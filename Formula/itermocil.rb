# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Itermocil < Formula
  desc "Create pre-defined window/pane layouts and run commands in iTerm - alternative profile support implementation"
  homepage "https://github.com/xtream1101/itermocil"
  url "https://github.com/xtream1101/itermocil/archive/0.2.1.5.zip"
  sha256 "68a09466d2f59f4ed041295d5612d173e632d12a8f414ab7936195268fad5536"


  # depends_on "cmake" => :build
  resource "PyYAML" do
    url "https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.11.tar.gz"
    sha256 "c36c938a872e5ff494938b33b14aaa156cb439ec67548fcab3535bb78b0846e8"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    %w[PyYAML].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install "itermocil"
    bin.install "itermocil.py"

    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/itermocil", "-h"
  end
end
