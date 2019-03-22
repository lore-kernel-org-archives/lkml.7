Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3039C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68975218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="PXjWftF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCVIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:04 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:38777 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:03 -0400
Received: by mail-qt1-f172.google.com with SMTP id s1so1608206qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGHDJQgoJxv9uANnRijm3XAyAv37fWf1IfT/iuLCDBc=;
        b=PXjWftF3tWKUWR+5fL2JfiAh16wAPIKsQGEuqv0DMtX5apKQIxMvFdVt+CNwHrQtOd
         tjhWR8OMi/X57ZCTln2nQ4+x39O7S3kGZnpyz7uySGay/L/gmVCTQK1JVFUHz120ot9R
         01R/rqFhrAWCDtLopkpY1YrkDvszTtQhEbH4Mry5cLWzZr/GpsuRkbirp8MWh07OBWL1
         fZP0eMXXs5djcbFaoL9/b75vLdkUWzAmOXksTB6j2eniekHeg7lCv8AAblQWwztC6ddN
         dckkmhMtANdkzWFgK3efwshe4pUvdv69vrlzcdMgP9BpNfUOHSJGfThX1dbuib2Nimxq
         XbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGHDJQgoJxv9uANnRijm3XAyAv37fWf1IfT/iuLCDBc=;
        b=Yhk7/Tx7r5wiZqxGuXa2chYi+wGnuRm4xiuBycRRhM3SZNtO6QHKSxYgl1lFj0Y54i
         UgcnZz6iVVTh8uIPZiHAUWv7an1mN6liLxwXPqIxVkwjy7BUMuck9SoaYOWYSYFz5gqh
         uCO6su4u1FWwTXF4nolbEaRzlmNJuf4NSkQmiHCm1mUWL3tJwfSOFgc/LZDuYuvYSHIN
         Sp3vfYEzCETIKM42eEpszjWoMCaBzyepbxcLvbxC+FICmUO3I6OKo+Hr+oQh+Ku5T13m
         sIHMd4gV+aSuohVVqmyGZs0pvh/NJWf01s3PkrWSJm1fmvZvlpusW2QWmWcjPuL79l33
         WZZw==
X-Gm-Message-State: APjAAAWZib3zdvmfDg1l6VrjXaIaOxqr2Z3R19tmFE1dONYIrBUwaXXy
        giZkdXFTW7yFf0hcdX8eKRrwQQ==
X-Google-Smtp-Source: APXvYqy3/bx7EaW+imaNqL8lRhcQ2bDn9TFVYbmpmEgueStkTI3xL1NSzDyua5W1xa5BoYs/JQ+LNw==
X-Received: by 2002:ac8:8d5:: with SMTP id y21mr7108448qth.67.1553243700732;
        Fri, 22 Mar 2019 01:35:00 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:00 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 1/8] evmtest: Regression testing integrity subsystem
Date:   Fri, 22 Mar 2019 04:34:34 -0400
Message-Id: <20190322083441.31084-1-djacobs7@binghamton.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jacobson <djacobs7@binghamton.edu>

As the Linux integrity subsystem matures and new features are added,
the number of kernel configuration options (Kconfig) and methods for
loading policies have increased. Regression testing of new and existing
features is needed to ensure correct behavior.

The Linux Test Project (LTP) is a test suite that aims to validate the
"reliability, robustness, and stability" of Linux.

Currently, the Linux Test Project (LTP) only includes the original
IMA-measurement regression tests, not the newer IMA-appraisal or IMA-
audit features.

This patchset introduces "evmtest" — a standalone Linux integrity
regression tool. evmtest can be used to validate individual behaviors
by exercising execve, kexec, module load, and other LSM hooks.
The initial evmtest regression tests verify the IMA-appraisal behavior
based on appending IMA-appraisal policy rules to the custom policy.
evmtest uses a combination of unsigned and validly signed files to
verify the running system.

The custom policy assumes the kernel is properly configured.  The
first evmtest named "env_validate" validates the kernel is properly
configured. For example, CONFIG_IMA_WRITE_POLICY is required for
appending to the IMA custom policy.  A local-CA certificate needs to
either be builtinto the kernel or memory reserved for embedding the
certificate post-build.

"evmtest" output is consistent, allowing  "evmtest" to be plugged into a
testing framework/harness. Testing frameworks, such as xfstests, require
deterministic output. xfstests runs a test and compares its output to a
predefined value, created by running the test script under conditions
where it passes. evmtest provides output that can easily be integrated
with xfstests. All tests have a verbose mode (-v) that outputs more
information for debugging purposes.

New tests can be defined by placing them in the functions/ directory.
An "example_test.sh" script is provided for reference.

Example 1: Successful example test output
$ evmtest runtest example_test -h

example_test -e <example_file> [-vh]

	This is an example of how to structure an evmtest

  -e	<example_file>
  -h	Displays this help message
  -v	Verbose logging

$ evmtest runtest example_test -e /bin/bash
[*] Starting test: example_test
[*] TEST: PASSED

Example 1a: successful verbose example test output
$ evmtest runtest example_test -e /bin/bash -v
[*] Starting test: example_test
[*] Example file exists
[*] TEST: PASSED

Example 1b: failed verbose example test output
$ evmtest runtest example_test -e /bin/foo -v
[*] Starting test: example_test
[!] Example file does not exist
[!] TEST: FAILED

SYNOPSIS:
evmtest runtest <test name> [OPTIONS]
options:
	-h	Displays a help message
	-v	Verbose logging

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

Changelog:
* Various clean-up to env_validate
* Redid loading of running config
* Changed comment order in example test
* Cleaned up README
* Removed notes about VM in env_validate and README
* kernel_build_dir -> build_dir
* Removed listing of functions/ directory
* Added individual name of each test
* Rewritten and expanded README
* Rewrite validate and validate_defined
* shellcheck compliant
* example test, fewer comments + shellcheck
* clean ups suggested by Mimi
* renamed functions -> tests
* checkbashishms compliant
* removed begin funcion usage
* removed long opt names
* Notes file has changes in proper commit
* switched to using functions for structure
* added policy_readable to common.sh
---
 Makefile.am                   |   5 +-
 configure.ac                  |   1 +
 evmtest/INSTALL               |  11 ++
 evmtest/Makefile.am           |  23 ++++
 evmtest/README                | 240 ++++++++++++++++++++++++++++++++++
 evmtest/evmtest               |  67 ++++++++++
 evmtest/files/Notes           |   5 +
 evmtest/files/common.sh       |  59 +++++++++
 evmtest/files/load_policy.sh  |  37 ++++++
 evmtest/tests/env_validate.sh | 196 +++++++++++++++++++++++++++
 evmtest/tests/example_test.sh |  63 +++++++++
 11 files changed, 706 insertions(+), 1 deletion(-)
 create mode 100644 evmtest/INSTALL
 create mode 100644 evmtest/Makefile.am
 create mode 100644 evmtest/README
 create mode 100755 evmtest/evmtest
 create mode 100644 evmtest/files/Notes
 create mode 100755 evmtest/files/common.sh
 create mode 100755 evmtest/files/load_policy.sh
 create mode 100755 evmtest/tests/env_validate.sh
 create mode 100755 evmtest/tests/example_test.sh

diff --git a/Makefile.am b/Makefile.am
index dba408d..0cb4111 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -36,4 +36,7 @@ rmman:
 
 doc: evmctl.1.html rmman evmctl.1
 
-.PHONY: $(tarname)
+evmtest:
+	$(MAKE) -C evmtest
+
+.PHONY: $(tarname) evmtest
diff --git a/configure.ac b/configure.ac
index a5b4288..59ec1d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,7 @@ EVMCTL_MANPAGE_DOCBOOK_XSL
 AC_CONFIG_FILES([Makefile
 		src/Makefile
 		packaging/ima-evm-utils.spec
+		evmtest/Makefile
 		])
 AC_OUTPUT
 
diff --git a/evmtest/INSTALL b/evmtest/INSTALL
new file mode 100644
index 0000000..699853e
--- /dev/null
+++ b/evmtest/INSTALL
@@ -0,0 +1,11 @@
+Installation Instructions
+-------------------------
+
+Basic Installation
+------------------
+
+From the root directory of ima-evm-utils, run the commands: `./autogen.sh`
+followed by `./configure`. `cd` to evmtest directory, execute `make`, and
+`sudo make install`.
+For details on how to use `evmtest` See the installed manpage or the README.
+There is an evmtest.html provided as well.
diff --git a/evmtest/Makefile.am b/evmtest/Makefile.am
new file mode 100644
index 0000000..e74feaf
--- /dev/null
+++ b/evmtest/Makefile.am
@@ -0,0 +1,23 @@
+prefix=@prefix@
+datarootdir=@datarootdir@
+exec_prefix=@exec_prefix@
+bindir=@bindir@
+
+all: evmtest.1
+
+evmtest.1:
+	asciidoc -d manpage -b docbook -o evmtest.1.xsl README
+	asciidoc INSTALL
+	xsltproc --nonet -o $@ $(MANPAGE_DOCBOOK_XSL) evmtest.1.xsl
+	asciidoc -o evmtest.html README
+	rm -f evmtest.1.xsl
+install:
+	install -m 755 evmtest $(bindir)
+	install -d $(datarootdir)/evmtest/files/
+	install -d $(datarootdir)/evmtest/tests/
+	install -D $$(find ./files/ -not -type d)  $(datarootdir)/evmtest/files/
+	install -D ./tests/* $(datarootdir)/evmtest/tests/
+	cp evmtest.1 $(datarootdir)/man/man1
+	mandb -q
+
+.PHONY: install evmtest.1
diff --git a/evmtest/README b/evmtest/README
new file mode 100644
index 0000000..5a44070
--- /dev/null
+++ b/evmtest/README
@@ -0,0 +1,240 @@
+evmtest(1)
+==========
+
+
+NAME
+----
+
+evmtest - Linux integrity subsystem regression testing utility
+
+
+SYNOPSIS
+--------
+
+evmtest runtest <test name> [OPTIONS]
+
+
+DESCRIPTION
+-----------
+
+evmtest is a regression testing framework for testing different aspects of the
+Linux integrity subsystem.
+
+
+OPTIONS
+-------
+
+ -b	<kernel build directory pathname>
+ -c	<kernel config file pathname>
+ -e	<example file pathname>
+ -h	Help
+ -i	<kernel image pathname>
+ -k	<private key pathname>
+ -v	Verbose logging
+
+
+TEST NAMES
+----------
+
+ env_validate - verify kernel build
+ example_test - example test
+
+
+Introduction
+------------
+
+IMA-appraisal verifies a file's integrity based on the information
+stored in the "security.ima" extended attribute (xattr), before the file
+is made accessible to userspace.  The "security.ima" xattr may contain
+either a file hash or a file signature.  However, only immutable files
+may be signed.
+
+The file signatures are verified based on keys loaded onto the `.ima`
+keyring.  To prevent untrusted or unknown keys from being loaded onto
+the `.ima` keyring, only certificates signed by a kernel "builtin" key
+may be loaded onto the `.ima` keyring.  This establishes a signature
+chain of trust from a signed kernel image up to the running system.
+
+
+Confirming the kernel is properly configured
+--------------------------------------------
+
+Several kernel configuration (Kconfig) options need to be enabled in order to
+execute the regression test suite.  To verify these options are enabled,
+either a configuration file may be validated directly or the running
+kernel's configuration may be validated.
+
+To directly validate a kernel's configuration file, execute:
+
+    evmtest runtest r_env_validate -c <Kconfig pathname> [-v]
+
+To validate the running kernel's configuration is properly configured
+requires root privileges.  As root, execute:
+
+    evmtest runtest r_env_validate -r [-v]
+
+
+Creating a local-CA certificate
+-------------------------------
+
+The local-CA's private key is used to sign certificates that are loaded
+onto the `.ima` keyring.  The evmctl manpage provides directions for
+generating the local-CA keypair and for creating the certificate.  Refer
+to the evmctl manpage section named "GENERATE TRUSTED KEYS".
+
+The examples directory contains two sample scripts named
+`ima-gen-local-ca.sh` and `ima-genkey.sh`, for generating these files.
+
+* `ima-local-ca.x509` - Inserted into the Linux kernel, to be loaded onto
+  the "builtin" keyring.
+* `ima-local-ca.priv` - Used for signing the IMA certificate
+* `x509_ima.der`      - Loaded onto the IMA trusted keyring
+
+
+Adding keys to the builtin kernel keyring
+-------------------------------------------
+
+The Linux kernel's `scripts/insert-sys-cert`, included in the kernel
+headers package (eg. kernel-headers, linux-headers), inserts a DER
+encoded certificate into the Linux kernel post build.  This requires
+the kernel to be configured with `CONFIG_SYSTEM_EXTRA_CERTIFICATE`
+enabled to reserve memory for the additional certificate.
+
+Some prebuilt kernel images are configured with this reserved memory.
+For these kernels, after inserting the local-CA public key, the kernel
+only needs to be resigned.  For kernels which do not reserve memory for
+a certificate, the kernel needs to be recompiled and resigned.
+
+
+=== Inserting a local-CA certificate post build into the kernel
+
+upstreamed:     insert-sys-cert -s System.map -b vmlinux -c <local-CA cert>
+posted*:        insert-sys-cert -s System.map -z vmlinuz -c <local-CA cert>
+
+After inserting the certificate with either of these methods, the kernel
+needs to be resigned.
+
+* https://lwn.net/Articles/753487/
+
+
+=== Kernel build method for including a local-CA certificate
+
+The second method for adding a key to the .builtin_trusted_keys keyring is
+to either directly include the certificate during the build, by
+specifying the certificate pathname or by reserving memory for the
+certificate.
+
+==== Kconfig options: including the certificate during build
+ CONFIG_SYSTEM_TRUSTED_KEYRING=y
+ CONFIG_SYSTEM_TRUSTED_KEYS="<path to ima-local-ca.pem>"
+
+==== Kconfig options: reserving memory for the certificate
+ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
+ CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
+
+
+The latter method allows a generic kernel to be built, initially
+containing a "test" certificate, but released with the "real"
+certificate.
+
+In this kernel build environment, the certificate may be inserted into
+the vmlinux post build, followed by "make" and "sudo make install". The kernel
+image needs to be resigned as usual.
+
+
+Signing the kernel image containing the local-CA certificate
+------------------------------------------------------------
+
+Once the kernel image is built and contains the local-CA certificate,
+sign the kernel image as normal.  A couple of tools exist for signing
+kernel images (eg. pesign and sbsign). Refer to the distro’s
+documentation.
+
+
+Loading signed certificates onto the IMA trusted keyring
+--------------------------------------------------------
+
+The integrity dracut module 98integrity/ima-keys-load.sh loads keys
+stored in /etc/keys/ima directory onto the IMA keyring.  Assuming the
+integrity dracut module is enabled, properly signed keys will be loaded
+onto the IMA keyring on boot.
+
+To view the keys loaded onto the `.ima` keyring, as root execute:
+
+ keyctl show %keyring:.ima
+
+
+Boot command line options
+-------------------------
+
+IMA's behavior is dependent on its policy. The policy defines which
+files are measured, appraised, and audited. Without a policy, IMA does
+not do anything.
+
+
+=== Methods for defining policy rules
+
+* Builtin policies: are specified on the boot command line (eg.
+  ima_policy="tcb|appraise_tcb")
+* Custom policy: is specified by echo'ing the custom policy pathname to
+  <securityfs>/ima/policy
+* Build time policy rules: Kconfig options
+* Architecture specific policy rules: Kconfig option
+
+The "builtin" policies, specified on the boot command line, are enabled
+from boot.  Once the LSMs are initialized, IMA policy rules can be
+defined in terms of LSM labels, allowing for more fine grained policy
+rules to be defined.  The "builtin" policies can be replaced with a
+"custom" policy.
+
+After loading a custom policy, additional rules may extend the
+custom policy, if the kernel is configured with CONFIG_IMA_WRITE_POLICY
+enabled.
+
+Unlike the "builtin" policies, the "build" time policy rules are
+automatically enabled at runtime and continue to persist after loading a
+custom policy.
+
+The "architecture" specific policy rules are derived during kernel boot,
+based on runtime secure boot flags. These are similar to the "build" time
+policies in that they persist after loading a custom policy.
+
+Initially each of the regression tests, first executes without an appraisal
+policy rule and then extends the IMA policy with the specific test rule.
+For this reason, the kernel must be configured with:
+
+ CONFIG_IMA_WRITE_POLICY=y
+ CONFIG_IMA_READ_POLICY=y
+
+and booted without any appraisal policy rules.
+
+As the regression tests mature and additional tests are defined, the
+regression tests will not make policy assumptions.
+
+
+FAQ
+---
+=== 1. How can an IMA key be loaded without rebuilding dracut?
+
+Unlike thread (@t), process (@p), session (@s), user (@u), or group (@g)
+keyrings, loading keys onto a trusted keyring requires searching for the
+keyring id.  The shell command, below, finds and saves the keyring id.
+The subsequent shell command loads a DER encoded key on to the keyring.
+
+ keyring_id=`sudo keyctl describe %keyring:.ima | awk -F ':' '{print $1}';`
+ evmctl import <path to ima key> ${keyring_id}
+
+This process can be scripted and added to startup/login
+
+=== 2. Should verbose mode be used when integrating with a test platform?
+
+When using evmtest inside of a test platform, output should be kept minimal.
+This is accomplished by not using the --verbose option.
+
+== Reference
+
+1. https://sourceforge.net/p/linux-ima/wiki/Home/
+
+Author
+------
+David Jacobson - davidj@linux.ibm.com
diff --git a/evmtest/evmtest b/evmtest/evmtest
new file mode 100755
index 0000000..d579d03
--- /dev/null
+++ b/evmtest/evmtest
@@ -0,0 +1,67 @@
+#!/bin/bash
+
+DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
+
+# Check to see if we're installed or not
+evmtest=$(type -p evmtest) # Find in path
+if [ -e "${evmtest}" ]; then
+	_evmdir=$(dirname "${evmtest}")
+	prefix=${_evmdir%%/bin}
+	EVMDIR=${prefix}/share/evmtest
+else
+	EVMDIR=$DIR
+fi
+
+source "$EVMDIR"/files/common.sh
+usage (){
+	echo "Usage:"
+	echo "	evmtest runtest <test name> [OPTIONS]"
+	echo ""
+	echo "Options:"
+	echo "	-h	Displays this help message"
+	echo "	-v	Verbose logging"
+	echo "List of tests: [R] = Must be run as root"
+	echo ""
+
+	# Any test should be added here manually
+	# The reason this is manual is to prevent the accidental / malicious
+	# placement of a script in tests/
+	echo "[R]	env_validate"
+	echo "[ ]	examples_test"
+
+	echo ""
+	echo "Note: Tests may be run directly from the \"tests\" directory"
+}
+
+
+runtest (){
+	local test_name=$1
+	shift
+
+	if [ ! -e "$EVMDIR"/tests/"$test_name".sh ]; then
+		echo "[!] Test: \"$test_name\" not found"
+		usage
+		exit 1
+	else
+		("$EVMDIR"/tests/"$test_name".sh "$@")
+	fi
+}
+
+if [ "$#" == 0 ]; then
+	usage
+	exit 1
+elif [ "$1" == "-h" ]; then
+	usage
+	exit 0
+elif [ "$1" == "runtest" ]; then
+	if [ -z "$2" ]; then
+		echo "[!] Provide a test"
+		exit
+	else
+		shift # Drop runtest
+		runtest "$@"
+		exit $?
+	fi
+else
+	usage
+fi
diff --git a/evmtest/files/Notes b/evmtest/files/Notes
new file mode 100644
index 0000000..f20a272
--- /dev/null
+++ b/evmtest/files/Notes
@@ -0,0 +1,5 @@
+This file contains a description of the contents of this directory.
+
+1. common.sh
+
+This file contains useful functions and variables for evmtest scripts.
diff --git a/evmtest/files/common.sh b/evmtest/files/common.sh
new file mode 100755
index 0000000..e48733f
--- /dev/null
+++ b/evmtest/files/common.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+
+# This is the EVMTest common.sh file
+# This is sourced at the top of a test file to provide common variables,
+# paths, and functions.
+
+EVMTEST_forbid_root () {
+	if [ "$UID" == 0 ]; then
+		echo "[!] This test should not be run as root"
+		exit 1
+	fi
+}
+
+EVMTEST_require_root () {
+	if [ "$UID" != 0 ]; then
+		echo "[!] This test must be run as root"
+		exit 1
+	fi
+}
+
+# verbose_output function - will only echo output if verbose is true
+# otherwise, output is muted
+v_out () {
+	[ "$VERBOSE" != "0" ] && { echo "[*]" "$@" ; return ; }
+}
+
+# Function to fail a test
+fail () {
+	if [ "$VERBOSE" != 0 ]; then
+		if [ -n "$*" ]; then
+			echo "[!]" "$@"
+		fi
+	fi
+	echo "[*] TEST: FAILED"
+	exit 1
+}
+
+passed () {
+	echo "[*] TEST: PASSED"
+	exit 0
+}
+
+EVMTEST_check_policy_readable () {
+	v_out "Attempting to read current policy..."
+	if ! cat "$EVMTEST_SECFS"/ima/policy &>> /dev/null; then
+		fail "Could not read running policy. Kernel must be"\
+		"configured with Kconfig option CONFIG_IMA_READ_POLICY=y"
+	fi
+	v_out "Policy is readable"
+}
+
+# Everything exported should be prefixed with EVMTEST_
+EVMTEST_SECFS_EXISTS=$(findmnt securityfs)
+EVMTEST_SECFS=$(findmnt -f -n securityfs -o TARGET)
+EVMTEST_BOOT_OPTS=$(cat /proc/cmdline)
+
+export EVMTEST_SECFS_EXISTS
+export EVMTEST_SECFS
+export EVMTEST_BOOT_OPTS
diff --git a/evmtest/files/load_policy.sh b/evmtest/files/load_policy.sh
new file mode 100755
index 0000000..0430830
--- /dev/null
+++ b/evmtest/files/load_policy.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+EVMTEST_require_root
+
+#This script loads the IMA policy either by replacing the builtin
+#policies specified on the boot command line or by appending the policy
+#rules to the existing custom policy.
+
+# This program assumes that the running kernel has been compiled with
+# CONFIG_IMA_WRITE_POLICY=y
+# To validate this, run env_validate <path_to_kernel_build>
+# Otherwise, this will fail
+
+if [ "$#" != 1 ] || [ "$1" == "-h" ]; then
+	echo "Usage: load_policy <policy pathname>"
+	exit
+fi
+
+IMA_POLICY="$EVMTEST_SECFS"/ima/policy
+EVMTESTPOLICY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" \
+	>/dev/null && pwd )/policies"
+
+if [ ! -e "$EVMTESTPOLICY_DIR"/"$1" ]; then
+	echo "[!] Policy: $1 not found, ensure it is in files/policies"
+	exit 1
+fi
+
+if ! echo "$EVMTESTPOLICY_DIR/$1" > "$IMA_POLICY"; then
+	echo "[!] Load failed - see dmesg"
+	exit 1
+else
+	echo "[*] Policy update completed"
+fi
+
+exit 0
diff --git a/evmtest/tests/env_validate.sh b/evmtest/tests/env_validate.sh
new file mode 100755
index 0000000..c630a23
--- /dev/null
+++ b/evmtest/tests/env_validate.sh
@@ -0,0 +1,196 @@
+#!/bin/bash
+# This test serves to validate a kernel build for running with EVMTEST
+
+TEST="env_validate"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+VERBOSE=0
+CONFIG_FILE=""
+
+usage () {
+	echo ""
+	echo "env_validate [-c <config>]|-r] [-vh]"
+	echo ""
+	echo "	This test validates that a kernel is properly configured, "
+	echo "	based on either the provided config file or the builtin"
+	echo "	kernel image config file of the running system"
+	echo ""
+	echo "	-c	Kernel config file"
+	echo "	-r	Will attempt to pull running config"
+	echo "	-v	Verbose testing"
+	echo "	-h	Displays this help message"
+	echo ""
+}
+
+parse_args () {
+	TEMP=$(getopt -o 'hc:rv' -n 'env_validate' -- "$@")
+	eval set -- "$TEMP"
+
+	while true ; do
+		case "$1" in
+		-h) usage; exit 0 ;;
+		-c) CONFIG="$2"; shift 2;;
+		-r) RUNNING=1; shift;;
+		-v) VERBOSE=1; shift;;
+		--) shift; break;;
+		*) echo "[*] Unrecognized option $1"; exit 1 ;;
+		esac
+	done
+
+	# One must be defined
+	if [ -z "$CONFIG" ] && [ -z "$RUNNING" ]; then
+		usage
+		exit 1
+	# But not both
+	elif [ -n  "$CONFIG" ] && [ -n "$RUNNING" ]; then
+		usage
+		exit 1
+	fi
+}
+
+# Validate that a variable has been set to a value
+validate () {
+	search="$1=$2"
+	for line in "${lines[@]}"
+	do
+	:
+		if test "${line}" == "${search}"; then
+			return
+		fi
+	done
+	INVALID_DEFINITION+=( "$search" )
+}
+
+# Validate that a variable is defined
+validate_defined () {
+	search="$1"
+	for line in "${lines[@]}"
+	do
+	:
+		if test "${line#*$search}" != "$line"; then
+			if test "${line#*"#"}" == "$line"; then
+				return
+			fi
+		fi
+	done
+	NOT_DEFINED+=( "$1" )
+}
+
+# Attempt to find the config on /proc. If not on proc, try extracting from
+# the image, and then the configs.ko module using extract-ikconfig.
+locate_config () {
+	if [ -n "$RUNNING" ]; then
+		CONFIG_FILE=$(mktemp)
+		if ! gunzip -c /proc/config.gz &>> "$CONFIG_FILE";  then
+			# Clear errors
+			rm "$CONFIG_FILE"
+
+			v_out "$WARN_PROC"
+
+			build=$(uname -r)
+			scripts=/lib/modules/"$build"/build/scripts
+			extract="$scripts"/extract-ikconfig
+			image=/boot/vmlinuz-"$build"
+			mod=/lib/modules/"$build"/kernel/kernel/configs.ko
+
+			if ! "$extract" "$image" &>> "$CONFIG_FILE"; then
+				rm "$CONFIG_FILE"
+				v_out "$WARN_IMAGE"
+
+				if ! "$extract" "$mod" &>> "$CONFIG_FILE"; then
+					fail "$NO_CONF"
+				fi
+			fi
+		fi
+		v_out "Extracted config to $CONFIG_FILE"
+	fi
+
+	if [ -n "$CONFIG" ]; then
+		CONFIG_FILE="$CONFIG"
+	fi
+
+	if [ ! -f "$CONFIG_FILE" ]; then
+		fail "Could not find config file"
+	fi
+}
+
+check_config () {
+	v_out "Parsing .config file..."
+
+	IFS=$'\n' read -d '' -r -a lines < "$CONFIG_FILE"
+
+	v_out "Validating keyring configuration..."
+	# Keyring configuration
+	validate "CONFIG_SYSTEM_EXTRA_CERTIFICATE" "y"
+	validate_defined "CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE"
+	validate "CONFIG_SYSTEM_TRUSTED_KEYRING" "y"
+	validate_defined "CONFIG_SYSTEM_TRUSTED_KEYS"
+
+	v_out "Validating integrity configuration..."
+	# Integrity configuration
+	validate "CONFIG_INTEGRITY" "y"
+	validate "CONFIG_INTEGRITY_SIGNATURE" "y"
+	validate "CONFIG_INTEGRITY_ASYMMETRIC_KEYS" "y"
+	validate "CONFIG_INTEGRITY_TRUSTED_KEYRING" "y"
+	validate "CONFIG_INTEGRITY_AUDIT" "y"
+
+	v_out "Validating IMA configuration..."
+	# IMA configuration
+	validate "CONFIG_IMA" "y"
+	validate "CONFIG_IMA_MEASURE_PCR_IDX" "10"
+	validate "CONFIG_IMA_LSM_RULES" "y"
+	validate "CONFIG_IMA_SIG_TEMPLATE" "y"
+	validate_defined "CONFIG_IMA_DEFAULT_TEMPLATE"
+	validate_defined "CONFIG_IMA_DEFAULT_HASH_SHA256"
+	validate_defined "CONFIG_IMA_DEFAULT_HASH"
+	validate "CONFIG_IMA_WRITE_POLICY" "y"
+	validate "CONFIG_IMA_READ_POLICY" "y"
+	validate "CONFIG_IMA_APPRAISE" "y"
+	validate "CONFIG_IMA_TRUSTED_KEYRING" "y"
+	validate "CONFIG_IMA_LOAD_X509" "y"
+	validate_defined "CONFIG_IMA_X509_PATH"
+	v_out "Validating module signing configuration..."
+	# Module signing configuration
+	validate_defined "CONFIG_MODULE_SIG_KEY"
+	validate "CONFIG_MODULE_SIG" "y"
+
+	if [ ${#INVALID_DEFINITION[@]} != 0 ]; then
+		v_out "The following Kconfig variables are incorrectly defined:"
+		for var in "${INVALID_DEFINITION[@]}"; do
+			v_out "$var"
+		done
+	fi
+
+	if [ ${#NOT_DEFINED[@]} != 0 ]; then
+		v_out "The following Kconfig variables need to be defined:"
+		for var in "${NOT_DEFINED[@]}"; do
+			v_out "$var"
+		done
+
+	fi
+
+	[ "${#NOT_DEFINED[@]}" -eq 0 ] && [ "${#INVALID_DEFINITION[@]}" -eq 0 ]
+	code=$?
+
+	if [ -n "$RUNNING" ]; then
+		rm "$CONFIG_FILE"
+	fi
+
+	if [ "$code" != 0 ]; then
+		fail
+	fi
+}
+
+WARN_PROC="Configuration not on /proc, will attempt to extract from image"
+WARN_IMAGE="Unable to extract from image, will attempt to extract from module"
+NO_CONF="Unable to extract from module. Extracting kernel configuration
+	requires CONFIG_IKCONFIG to be enabled. Support for reading from /proc
+	is enabled with CONFIG_IKCONFIG_PROC"
+INVALID_DEFINITION=()
+NOT_DEFINED=()
+
+echo "[*] Starting test: $TEST"
+parse_args "$@"
+locate_config
+check_config
+passed
diff --git a/evmtest/tests/example_test.sh b/evmtest/tests/example_test.sh
new file mode 100755
index 0000000..c6035c9
--- /dev/null
+++ b/evmtest/tests/example_test.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+
+# This is an example test for documentation purposes.
+# This test describes the outline of evmtest test files.
+
+# Author: David Jacobson <davidj@linux.ibm.com>
+
+TEST="example_test"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+VERBOSE=0
+
+
+
+usage () {
+	echo ""
+	echo "example_test -e <example_file> [-vh]"
+	echo ""
+	echo "	This is an example of how to structure an evmtest"
+	echo ""
+	echo "  -e	<example_file>"
+	echo "  -h	Display this help message"
+	echo "  -v	Verbose logging"
+	echo ""
+}
+
+
+
+parse_args () {
+	TEMP=$(getopt -o 'e:hv' -n 'example_test' -- "$@")
+	eval set -- "$TEMP"
+	while true ; do
+		case "$1" in
+			-h) usage; exit 0 ; shift;;
+			-e) EXAMPLE_FILE=$2; shift 2;;
+			-v) VERBOSE=1; shift;;
+			--) shift; break;;
+			*) echo "[*] Unrecognized option $1"; exit 1 ;;
+		esac
+	done
+
+	if [ -z "$EXAMPLE_FILE" ]; then
+		usage
+		exit 1
+	fi
+}
+
+# Define what needs to be tested as a function
+check_file_exists () {
+	if [ -e "$EXAMPLE_FILE" ]; then
+		v_out "Example file exists"
+	else
+		fail "Example file not found"
+	fi
+}
+
+# The two options are: EVMTEST_forbid_root and EVMTEST_require_root
+EVMTEST_forbid_root
+
+echo "[*] Starting test: $TEST"
+parse_args "$@"
+check_file_exists
+passed
-- 
2.20.1

