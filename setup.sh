#!/bin/bash

echo
echo "#########################################"
echo "# Welcome to Steven's Mac Setup Script! #"
echo "#########################################"
echo
echo "By default, this script will begin by creating a directory at \
~/.shwconfig to log its output, installing Homebrew, and using Homebrew \
to install 'dialog', which it will use to present the rest of the setup \
options. To abort, press Ctrl+c. To proceed, press enter."

read -p ""

set -e

mkdir -p $HOME/.shwconfig

start_time=$(date +%y%m%d-%H%M%S)
log_file=$HOME/.shwconfig/setup-$start_time.log
touch $log_file
exec &> >(tee $log_file)

set +e

echo "Checking if Homebrew is installed"
if ! command -v brew &> /dev/null; then
    echo "Homebrew was not installed"
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Check if Homebrew was installed successfully
    if command -v brew &> /dev/null; then
        echo "Homebrew installed successfully"
    else
        echo "Homebrew installation failed. Please install it manually and \
            re-run this script"
        exit 1
    fi
else
    echo "Homebrew is already installed"
fi

echo "Checking if 'dialog' is installed"
if ! brew list dialog &> /dev/null; then
    echo "'dialog' is not installed. Installing it with Homebrew"
    brew install dialog
    
    # Check if dialog was installed successfully
    if command -v dialog &> /dev/null; then
        echo "'dialog' installed successfully"
    else
        echo "'dialog' installation failed. Please install it manually with \
            Homebrew and re-run this script"
        exit 1
    fi
else
    echo "'dialog' is already installed"
fi

options=$(dialog --stdout \
    --title "Select Setup Options" \
    --checklist "Navigate with the up and down arrow keys, press SPACE to \
    toggle options, and press ENTER to confirm. Steps will execute in the \
    order they are presented in" 0 0 0 \
    0 "Install A" on \
    1 "Install B" on \
    2 "Install C" on)
echo
echo

if [ -z "$options" ]; then
    echo "No options selected. Exiting."
    exit 0
fi

function install_pizza() {
    echo "Installing pizza"
}

for option in $options; do
    echo "Option $option selected"
done

echo

for option in $options; do
    case $option in
        0) install_pizza ;;
        1) install_pizza ;;
        2) install_pizza ;;
        *) echo "Unknown option selected: $option" ;;
    esac
done