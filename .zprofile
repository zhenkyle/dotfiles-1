# User dependent .bash_profile file

[[ ":$PATH:" != *":/usr/local/bin:"* ]] && export PATH="/usr/local/bin:${PATH}"


if [ -d "/usr/local/opt/coreutils/libexec/gnubin" ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
fi

if [ -d "/usr/local/opt/coreutils/libexec/gnuman" ]; then
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

if [ -d "/usr/local/opt/gnu-sed/libexec/gnubin" ]; then
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}"
fi

# Linuxbrew
if [ -d "${HOME}/.linuxbrew" ]; then
    export PATH=${HOME}/.linuxbrew/bin:${PATH}
fi

# Add path for node
if [ -d "${HOME}/.nodebrew" ]; then
    export PATH=${HOME}/.nodebrew/current/bin:${PATH}
fi

# anaconda
anaconda_base_list=("${HOME}"{,/opt}/{anaconda,Anaconda,miniconda}{,3,2})
for anaconda_base in "${anaconda_base_list[@]}"; do
    if [ -d "${anaconda_base}" ]; then
        export ANACONDA_BASE_DIR="${anaconda_base}"
        break
    fi
done
unset anaconda_base_list
if [ -n "${ANACONDA_BASE_DIR}" ]; then
    __conda_setup="$(${ANACONDA_BASE_DIR}/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "${ANACONDA_BASE_DIR}/etc/profile.d/conda.sh" ]; then
        . "${ANACONDA_BASE_DIR}/etc/profile.d/conda.sh"
    else
        export PATH="${ANACONDA_BASE_DIR}"/bin:$PATH
    fi
fi
unset __conda_setup

# latex path
if [ -d "/Library/TeX/texbin" ]; then
    export PATH="/Library/TeX/texbin:${PATH}"
fi

# executable path
if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# include path
if [ -d "/usr/local/include" ] ; then
    export CPLUS_INCLUDE_PATH=/usr/local/include:${CPLUS_INCLUDE_PATH}
fi
if [ -d "${HOME}/.local/include" ] ; then
    export CPLUS_INCLUDE_PATH=${HOME}/.local/include:${CPLUS_INCLUDE_PATH}
fi
# library path
if [ -d "/usr/local/lib" ] ; then
    export LIBRARY_PATH=/usr/local/lib:${LIBRARY_PATH}
fi
if [ -d "${HOME}/.local/lib" ] ; then
    export CPLUS_INCLUDE_PATH=${HOME}/.local/lib:${CPLUS_INCLUDE_PATH}
fi

# MANPATH
if [ -d "${HOME}/.local/share/man" ]; then
   export MANPATH="${HOME}/.local/share/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/.local/info" ]; then
  INFOPATH="${HOME}/.local/info:${INFOPATH}"
fi

typeset -U path
