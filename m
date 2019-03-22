Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1618C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE772083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="XuBUTTif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfCVIfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:05 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:42273 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfCVIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:04 -0400
Received: by mail-qk1-f181.google.com with SMTP id b74so720495qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Co1GEveZfd4Xat/3SkhOIRbPAE0PV1ph7DVuYY6Ne9E=;
        b=XuBUTTifIU7ogJzt7QLOPuNl4dSKWG9Tb7oSjT9ZL0nTasRSj4+ZinaPjRN/LwtmSA
         OWo9DhiXI7wxC8MU1TqER6+woLKguT2Q32b9hxSqqBLLdEL10VSp15LolquD/rRweKcH
         BNiLIvZQ4AWqmOj/TG+jqb7QU9+RnsPczlvnL41n5gnEBqa7MPwKNeaY3U8Yc96yeT81
         RNVuGOTGl9KzqcUnAl/1+dv2ezINu16qBITOJxacbzXfOoUu997uVcFIdmjUA8NLxbhc
         rvS+ztiSfY53GmP+HkEmH20H7TzbAOXRZjr7rnxhxH+1KmkjP/c8v6lmosOUvZrUmXlE
         sYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Co1GEveZfd4Xat/3SkhOIRbPAE0PV1ph7DVuYY6Ne9E=;
        b=QDQymVlnqclLGUaJG8LvZ1R5Wg2ICP8whQbD7o4Jllqyprc5s+haBWPxOj/fCQ3kv8
         h5z04xk246/A6Vr6fSJQ+cqArChSWPZnXibPW6PxgnLjZx9nYA3R7YAn4cmuiEAN2RdT
         BzwQ4oiOCzCSQ1xp7J047tTOJt3PTja0m80yvcfPWq1ik1byNlVPgAkS+P0dbMaYawaz
         UQF/4RIWgvxH/AZXHEsbGXlVqLBoSF8cZDnEjezPN92Hb2U2mZ5h1tEv9j+w4dXYNJnZ
         1bEVFKM5v3P7xQyhMmyyijOEBff4A8pNhVf+7Bz/b7NWwXyIiY9IJjaMpaBqEQ/BiuEr
         pzRw==
X-Gm-Message-State: APjAAAVz6mkRJpL1Uy+fTUUU/6O0k5JLvva85lvOLdcdNW72h8WkQgQH
        UTTIa3GAkiXTxYWe/WMXXFX1VQ==
X-Google-Smtp-Source: APXvYqy8HAJrJ2ZHffcHjms8Ex5r3yIe8vcUdAnu33j2e+T8yYwHbyUglzQxQLskDwzc2RxVgOR4cA==
X-Received: by 2002:a37:d8e:: with SMTP id 136mr6322045qkn.95.1553243702353;
        Fri, 22 Mar 2019 01:35:02 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:01 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 3/8] evmtest: test kernel module loading
Date:   Fri, 22 Mar 2019 04:34:36 -0400
Message-Id: <20190322083441.31084-3-djacobs7@binghamton.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322083441.31084-1-djacobs7@binghamton.edu>
References: <20190322083441.31084-1-djacobs7@binghamton.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jacobson <djacobs7@binghamton.edu>

The Linux kernel supports two methods of loading kernel modules -
init_module and finit_module syscalls. This test verifies loading kernel
modules with both syscalls, first without an IMA policy, and
subsequently with an IMA policy (that restricts module loading to signed
modules).

This test requires the kernel to be configured with the
"CONFIG_MODULE_SIG" option, but not with "CONFIG_MODULE_SIG_FORCE".  For
this reason, the test requires that  "module.sig_enforce=1" is supplied
as a boot option to the kernel.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

Changelog:
* kernel_build_directory -> build_directory
* Added kmod_sig to test list
* shellcheck compliant
* move from functions to tests
* clean up for readability
* redid order of loading and pushing policy
* added policy check
* checkbashisms complaint
* removed begin
* removed long opts
* Notes file updated in appropriate patch
* Restructured with functions
* Renamed to simple_modload, can now be used in other areas
---
 evmtest/Makefile.am                         |  11 +-
 evmtest/README                              |  11 +
 evmtest/evmtest                             |   1 +
 evmtest/files/Notes                         |   5 +
 evmtest/files/policies/kernel_module_policy |   2 +
 evmtest/src/Makefile                        |   5 +
 evmtest/src/basic_mod.c                     |  36 +++
 evmtest/src/simple_modload.c                | 151 ++++++++++
 evmtest/tests/kmod_sig.sh                   | 288 ++++++++++++++++++++
 evmtest/tests/policy_sig.sh                 |   1 -
 10 files changed, 507 insertions(+), 4 deletions(-)
 create mode 100644 evmtest/files/policies/kernel_module_policy
 create mode 100644 evmtest/src/Makefile
 create mode 100644 evmtest/src/basic_mod.c
 create mode 100644 evmtest/src/simple_modload.c
 create mode 100755 evmtest/tests/kmod_sig.sh

diff --git a/evmtest/Makefile.am b/evmtest/Makefile.am
index 496a5de..74a8199 100644
--- a/evmtest/Makefile.am
+++ b/evmtest/Makefile.am
@@ -3,7 +3,7 @@ datarootdir=@datarootdir@
 exec_prefix=@exec_prefix@
 bindir=@bindir@
 
-all: evmtest.1
+all: src evmtest.1
 
 evmtest.1:
 	asciidoc -d manpage -b docbook -o evmtest.1.xsl README
@@ -11,7 +11,10 @@ evmtest.1:
 	xsltproc --nonet -o $@ $(MANPAGE_DOCBOOK_XSL) evmtest.1.xsl
 	asciidoc -o evmtest.html README
 	rm -f evmtest.1.xsl
-install:
+src:
+	cd src && make
+
+install: src
 	install -m 755 evmtest $(bindir)
 	install -d $(datarootdir)/evmtest/files/
 	install -d $(datarootdir)/evmtest/files/policies
@@ -21,7 +24,9 @@ install:
 	$(datarootdir)/evmtest/files/
 	install -D ./tests/* $(datarootdir)/evmtest/tests/
 	install -D ./files/policies/* $(datarootdir)/evmtest/files/policies/
+	cp ./src/basic_mod.ko $(datarootdir)/evmtest/files/
+	cp ./src/basic_modload $(datarootdir)/evmtest/files
 	cp evmtest.1 $(datarootdir)/man/man1
 	mandb -q
 
-.PHONY: install evmtest.1
+.PHONY: src install evmtest.1
diff --git a/evmtest/README b/evmtest/README
index 480f426..8c63630 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -39,6 +39,7 @@ TEST NAMES
  env_validate - verify kernel build
  example_test - example test
  policy_sig - verify loading IMA policies
+ policy_sig - test IMA-appraise on policies
 
 
 Introduction
@@ -172,6 +173,9 @@ IMA's behavior is dependent on its policy. The policy defines which
 files are measured, appraised, and audited. Without a policy, IMA does
 not do anything.
 
+When running evmtest, boot with: module.sig_enforce=1. This tells the kernel to
+prevent the loading of any unsigned modules.
+
 
 === Methods for defining policy rules
 
@@ -213,6 +217,13 @@ As the regression tests mature and additional tests are defined, the
 regression tests will not make policy assumptions.
 
 
+=== Require kernel module appended signatures
+
+Most kernels are configured with CONFIG_MODULE_SIG enabled but without
+CONFIG_MODULE_SIG_FORCE. For testing purposes, require kernel module appended
+signatures by specifying `module.sig_enforce=1` on the boot command line.
+
+
 FAQ
 ---
 === 1. How can an IMA key be loaded without rebuilding dracut?
diff --git a/evmtest/evmtest b/evmtest/evmtest
index 9902e61..49b162d 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -28,6 +28,7 @@ usage (){
 	# placement of a script in tests/
 	echo "[R]	env_validate"
 	echo "[ ]	examples_test"
+	echo "[R]	kmod_sig"
 	echo "[R]	policy_sig"
 
 	echo ""
diff --git a/evmtest/files/Notes b/evmtest/files/Notes
index 8aa2670..574f5d8 100644
--- a/evmtest/files/Notes
+++ b/evmtest/files/Notes
@@ -19,3 +19,8 @@ This is a directory that contains IMA policies with self explanatory names.
 This file was generated such that its corresponding public key could be placed
 on the IMA Trusted Keyring, however, it has not. Therefore, any policy (or file)
 signed by this key cannot be verified, and is untrusted.
+
+5. basic_mod.ko
+
+This is a kernel module that logs (to dmesg) the syscall that was used to load
+it.
diff --git a/evmtest/files/policies/kernel_module_policy b/evmtest/files/policies/kernel_module_policy
new file mode 100644
index 0000000..8096e18
--- /dev/null
+++ b/evmtest/files/policies/kernel_module_policy
@@ -0,0 +1,2 @@
+measure func=MODULE_CHECK
+appraise func=MODULE_CHECK appraise_type=imasig
diff --git a/evmtest/src/Makefile b/evmtest/src/Makefile
new file mode 100644
index 0000000..2d66ece
--- /dev/null
+++ b/evmtest/src/Makefile
@@ -0,0 +1,5 @@
+obj-m += basic_mod.o
+
+all:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
+	$(CC) simple_modload.c -o simple_modload
diff --git a/evmtest/src/basic_mod.c b/evmtest/src/basic_mod.c
new file mode 100644
index 0000000..7c49c74
--- /dev/null
+++ b/evmtest/src/basic_mod.c
@@ -0,0 +1,36 @@
+/*
+ * Basic kernel module
+ *
+ * Copyright (C) 2018 IBM
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/*
+ * evmtest_load_type is a flag passed when loading the module, it indicates
+ * which syscall is being used. It should be either init_module or finit_module
+ * When loaded, evmtest_load_type is outputted to the kernel's message buffer
+ */
+static char *evmtest_load_type;
+
+module_param(evmtest_load_type, charp, 000);
+MODULE_PARM_DESC(evmtest_load_type, "Which syscall is loading this module.");
+
+static int __init basic_module_init(void)
+{
+	printk(KERN_INFO "EVMTEST: LOADED MODULE (%s)\n", evmtest_load_type);
+	return 0;
+}
+
+static void __exit basic_module_cleanup(void)
+{
+	printk(KERN_INFO "EVMTEST: UNLOADED MODULE (%s)\n", evmtest_load_type);
+}
+
+module_init(basic_module_init);
+module_exit(basic_module_cleanup);
+
+MODULE_AUTHOR("David Jacobson");
+MODULE_DESCRIPTION("Kernel module for testing IMA signatures");
+MODULE_LICENSE("GPL");
diff --git a/evmtest/src/simple_modload.c b/evmtest/src/simple_modload.c
new file mode 100644
index 0000000..42510f0
--- /dev/null
+++ b/evmtest/src/simple_modload.c
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+
+/*
+ * finit_module - load a kernel module using the finit_module syscall
+ * @fd: File Descriptor of the kernel module to be loaded
+ */
+int finit_module(int fd)
+{
+	return syscall(__NR_finit_module, fd,
+			"evmtest_load_type=finit_module", 0);
+}
+
+/*
+ * init_module - load a kernel module using the init_module syscall
+ * @fd: File Descriptor of the kernel module to be loaded
+ *
+ * Adapted explanation from: https://github.com/cirosantilli/
+ * linux-kernel-module-cheat/blob/
+ * 91583552ba2c2d547c8577ac888ab9f851642b25/kernel_module/user/
+ * myinsmod.c
+ */
+int init_module(int fd)
+{
+
+	struct stat st;
+
+	int mod = fstat(fd, &st);
+
+	if (mod != 0) {
+		printf("[!] Failed to load module\n");
+		return -1;
+	}
+
+	size_t im_size = st.st_size;
+	void *im = malloc(im_size);
+
+	if (im == NULL) {
+		printf("[!] Failed to load module - MALLOC NULL\n");
+		return -1;
+	}
+	read(fd, im, im_size);
+	close(fd);
+
+	int loaded = syscall(__NR_init_module, im, im_size,
+			     "evmtest_load_type=init_module");
+	free(im);
+
+	return loaded;
+}
+
+/*
+ * usage - print out a help message to the user
+ */
+void usage(void)
+{
+	printf("Usage: simple_modload <-p pathname> <-o | -n>\n");
+	printf("	-p,--path	pathname of kernel module\n");
+	printf("	-o,--old	old syscall (INIT_MODULE)\n");
+	printf("	-n,--new	new syscall (FINIT_MODULE)\n");
+}
+
+int main(int argc, char **argv)
+{
+
+	int ret;
+	int uid = getuid();
+	char * path;
+	char old = 0;
+	char new = 0;
+
+	// For getopt
+	char * opt_path = 0;
+	int next;
+
+	const char * const short_opts = "p:on";
+	const struct option long_opts[] =
+		{
+			{ "path", 1, NULL, 'p' },
+			{ "old", 0, NULL, 'o' },
+			{ "new", 0, NULL, 'n' },
+			{ NULL, 0, NULL, 0 }
+		};
+
+	while (1) {
+		next = getopt_long(argc, argv, short_opts, long_opts, NULL);
+
+		if (next == -1) {
+			break;
+		}
+
+		switch (next) {
+			case 'p' :
+				opt_path=optarg;
+				int size = strlen(opt_path) + 1;
+				path=(char *)malloc(sizeof(char) * size);
+				strcpy(path,opt_path);
+				break;
+
+			case 'o' :
+				old = 1;
+				break;
+
+			case 'n' :
+				new = 1;
+				break;
+
+			case '?' :
+			case -1 :
+				break;
+
+			default :
+				return -1;
+		}
+	}
+
+	if ( (old && new) || !(old || new) || path == NULL) {
+		usage();
+		return -1;
+	}
+
+	/* Root is required to try and load kernel modules */
+	if (uid != 0) {
+		printf("[!] simple_modload must be run as root\n");
+		return -1;
+	}
+
+	int fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		printf("[!] Could not open file for read.\n");
+		return -1;
+	}
+
+	if (old == 1) {
+		ret = init_module(fd);
+	} else {
+		ret = finit_module(fd);
+	}
+
+	return ret;
+}
diff --git a/evmtest/tests/kmod_sig.sh b/evmtest/tests/kmod_sig.sh
new file mode 100755
index 0000000..0ebbaf3
--- /dev/null
+++ b/evmtest/tests/kmod_sig.sh
@@ -0,0 +1,288 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="kmod_sig"
+BUILD_DIR=""
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+
+VERBOSE=0
+# This test validates that IMA prevents the loading of unsigned
+# kernel modules
+
+# The boot command line option module.sig_enforce=1 is equivalent to
+# compiling with CONFIG_MODULE_SIG_FORCE enabled.
+
+usage(){
+	echo ""
+	echo "kmod_sig [-b build_directory] -k <ima_key> [-v]"
+	echo "	This test verifies that IMA prevents the loading of an"
+	echo "	unsigned kernel module with a policy appraising MODULE_CHECK"
+	echo ""
+	echo "	This test must be run as root"
+	echo ""
+	echo "	-b	The path to a kernel build dir"
+	echo "	-k	IMA key"
+	echo "	-v	Verbose logging"
+	echo "	-h	Display this help message"
+}
+
+parse_args () {
+	TEMP=$(getopt -o 'b:k:hv' -n 'kmod_sig' -- "$@")
+	eval set -- "$TEMP"
+
+	while true ; do
+		case "$1" in
+		-h) usage; exit 0 ;;
+		-b) BUILD_DIR=$2; shift 2;;
+		-k) IMA_KEY=$2; shift 2;;
+		-v) VERBOSE=1; shift;;
+		--) shift; break;;
+		*) echo "[*] Unrecognized option $1"; exit 1 ;;
+		esac
+	done
+
+	if [ -z "$IMA_KEY" ]; then
+		echo "[!] Please provide an IMA key."
+		usage
+		exit 1
+	fi
+}
+
+
+set_build_tree_location () {
+	if [ -z "$BUILD_DIR" ]; then
+		BUILD_DIR="/lib/modules/$(uname -r)/build"
+		if [ ! -e "$BUILD_DIR" ]; then
+			echo "[!] Could not find build tree. Specify with -b"
+			exit 1
+		else
+			v_out "No build tree provided."\
+			"Found - using: $(readlink -f "$BUILD_DIR")"
+		fi
+	fi
+
+
+	if [ ! -d "$BUILD_DIR" ]; then
+		fail "Could not find kernel build path"
+	fi
+}
+
+check_key () {
+	if [ ! -e "$IMA_KEY" ]; then
+		fail "Could not find IMA key"
+	fi
+}
+
+check_policy () {
+	already_run="IMA policy already contains MODULE_CHECK"
+	if [ -e "$EVMTEST_SECFS"/ima/policy ]; then
+		POLICY=$(mktemp -u)
+		cp "$EVMTEST_SECFS"/ima/policy "$POLICY"
+		if grep -q "MODULE_CHECK" "$POLICY"; then
+			rm "$POLICY"
+			fail "$already_run"
+		fi
+		rm "$POLICY"
+	fi
+}
+
+unload_module () {
+	v_out "Unloading test module if loaded..."
+	rmmod basic_mod &>> /dev/null
+}
+
+
+
+check_boot_opts () {
+	if ! printf '%s' "$EVMTEST_BOOT_OPTS" | grep -E -q "$SIG_ENFORCE_CMD";
+		then
+		v_out "Run with kernel command: $SIG_ENFORCE_CMD"
+		fail "Booted with options: $EVMTEST_BOOT_OPTS"
+	else
+		v_out "Booted with correct configuration..."
+	fi
+}
+
+# This test may have been run before - remove the security attribute so we can
+# test again
+remove_xattr_appended_sig () {
+	v_out "Removing security attribute and appended signature if present"
+	setfattr -x security.ima "$ROOT"/files/basic_mod.ko &>> /dev/null
+	strip --strip-debug "$ROOT"/files/basic_mod.ko
+}
+
+check_hash_algo () {
+	# First attempt to find hash algo
+	hash_alg=$(grep CONFIG_MODULE_SIG_HASH "$BUILD_DIR"/.config|awk -F "=" \
+		'{print $2}'| tr -d "\"")
+	# Need to read the config more to determine how to sign module...
+	if [ -z "$hash_alg" ]; then
+		v_out "Could not determine hash algorithm used on module"\
+			"signing. Checking for other Kconfig variables..."
+		hash_opts=$(grep CONFIG_MODULE_SIG "$BUILD_DIR"/.config)
+
+		# All possible hashes from:
+		# https://www.kernel.org/doc/html/v4.17/admin-guide/
+		# module-signing.html
+		case $hash_opts in
+		*"CONFIG_MODULE_SIG_SHA1=y"*)
+			hash_alg="sha1"
+			;;
+		*"CONFIG_MODULE_SIG_SHA224"*)
+			hash_alg="sha224"
+			;;
+		*"CONFIG_MODULE_SIG_SHA256"*)
+			hash_alg="sha256"
+			;;
+		*"CONFIG_MODULE_SIG_SHA384"*)
+			hash_alg="sha384"
+			;;
+		*"CONFIG_MODULE_SIG_SHA512"*)
+			hash_alg="sha512"
+			;;
+		*)
+			fail "Could not determine hash"
+			;;
+		esac
+	fi
+
+	v_out "Found hash algo: $hash_alg"
+}
+
+check_signing_key () {
+	v_out "Looking for signing key..."
+	if [ ! -e "$BUILD_DIR"/certs/signing_key.pem ]; then
+		v_out "signing_key.pem not in certs/ finding via Kconfig";
+		key_location=$(grep MODULE_SIG_KEY "$BUILD_DIR"/.config)
+		if [ -z "$key_location" ]; then
+			fail "Could not determine key location"
+		fi
+		# Parse from .config
+		key_location=${key_location/CONFIG_MODULE_SIG_KEY=/}
+		# Drop quotes
+		key_location=${key_location//\"}
+		# Drop .pem
+		key_location=${key_location/.pem}
+		sig_key="$key_location"
+
+	else
+		sig_key="$BUILD_DIR"/certs/signing_key
+	fi
+
+	v_out "Found key: $sig_key"
+}
+
+sign_appended_signature () {
+	v_out "Signing module [appended signature]..."
+
+	if ! "$BUILD_DIR"/scripts/sign-file "$hash_alg" "$sig_key".pem \
+		"$sig_key".x509 "$ROOT"/files/basic_mod.ko; then
+		fail "Signing failed - please ensure sign-file is in scripts/"
+	fi
+}
+
+check_appended_signature_init_mod () {
+	v_out "Attempting to load signed (appended) module with INIT_MODULE"\
+		" syscall [should pass]"
+	if ! "$mod_load" -p "$ROOT"/files/basic_mod.ko -o &>> /dev/null;
+		then
+		fail "Failed to load using init_module - check key"
+	fi
+
+	v_out "Module loaded - unloading"
+	rmmod basic_mod &>> /dev/null
+}
+
+check_appended_signature_finit_mod () {
+	v_out "Attempting to load signed (appended) module with FINIT_MODULE"\
+		" syscall [should pass]"
+	if ! "$mod_load" -p "$ROOT"/files/basic_mod.ko -n &>> /dev/null;
+		then
+		fail "Failed to load module"
+	fi
+
+	v_out "Module loaded - unloading"
+	rmmod basic_mod &>> /dev/null
+}
+
+update_policy () {
+	if ! evmctl ima_sign -f "$POLICY_PATH" -k "$IMA_KEY"; then
+		fail "Failed to sign policy - check key"
+	fi
+
+	v_out "Signing and loading policy to prevent loading unsigned kernel"\
+		" modules..."
+	if ! "$POLICY_LOAD" kernel_module_policy &>> /dev/null; then
+		fail "Could not write policy - is the supplied key correct?"
+	fi
+}
+
+check_appended_signature_init_mod_IMA () {
+	v_out "Attempting to load signed (appended) module with FINIT_MODULE "\
+		"syscall [should fail]"
+	if "$mod_load" -p "$ROOT"/files/basic_mod.ko -n &>> /dev/null;
+		then
+		rmmod_basic_mod &>> /dev/null
+		fail "FINIT_MODULE loaded module without xattr. Unloading"
+	fi
+	v_out "Prevented module without file attribute from loading"
+}
+
+sign_xattr () {
+	v_out "Signing file [extended file attribute]..."
+	if ! evmctl ima_sign -k "$IMA_KEY" -f "$ROOT"/files/basic_mod.ko; then
+		fail "Error signing module - check keys"
+	fi
+}
+
+check_xattr_finit_mod () {
+	v_out "Attempting to load module with FINIT_MODULE syscall"\
+	" [should pass]"
+	"$mod_load" -p "$ROOT"/files/basic_mod.ko -n &>> /dev/null
+}
+
+check_unknown_key () {
+	v_out "Signing with unknown key..."
+	evmctl ima_sign -f "$ROOT"/files/basic_mod.ko &>> /dev/null
+	if "$mod_load" -p "$ROOT"/files/basic_mod.ko -n &>> /dev/null;
+		then
+		fail "Allowed module to load with wrong signature"
+	fi
+
+	v_out "Prevented loading module signed by unknown key using"\
+		" FINIT_MODULE syscall"
+
+	if "$mod_load" -p "$ROOT"/files/basic_mod.ko -o &>> /dev/null;
+		then
+		fail "Allowed module to load with wrong signature"
+	fi
+
+	v_out "Prevented loading module signed by unknown key using"\
+		" INIT_MODULE syscall"
+}
+
+mod_load="$ROOT"/files/simple_modload
+SIG_ENFORCE_CMD="module.sig_enforce=1"
+POLICY_LOAD="$ROOT"/files/load_policy.sh
+POLICY_PATH="$ROOT"/files/policies/kernel_module_policy
+
+EVMTEST_require_root
+echo "[*] Starting test: $TEST"
+parse_args "$@"
+set_build_tree_location
+check_key
+check_policy
+unload_module
+check_boot_opts
+remove_xattr_appended_sig
+check_hash_algo
+check_signing_key
+sign_appended_signature
+check_appended_signature_init_mod
+check_appended_signature_finit_mod
+update_policy
+check_appended_signature_init_mod_IMA
+sign_xattr
+check_xattr_finit_mod
+remove_xattr_appended_sig
+passed
diff --git a/evmtest/tests/policy_sig.sh b/evmtest/tests/policy_sig.sh
index 174d111..ac56d0a 100755
--- a/evmtest/tests/policy_sig.sh
+++ b/evmtest/tests/policy_sig.sh
@@ -3,7 +3,6 @@ TEST="policy_sig"
 # Author: David Jacobson <davidj@linux.ibm.com>
 
 ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
-#shellcheck source=/usr/local/share/evmtest/files/common.sh
 source "$ROOT"/files/common.sh
 
 VERBOSE=0
-- 
2.20.1

