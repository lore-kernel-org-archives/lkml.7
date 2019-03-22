Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5373C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36EC218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="F9pzVM9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfCVIfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35346 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfCVIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so1635907qte.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdvC+51bl32WZuffSvloly+TOiS9ydaLK+J/h7e5kYs=;
        b=F9pzVM9SkG4ZphEXCNN0bYhZqKAmSw7jLc/Ydzo2p8QJnrVkebtLpNk76ZwfjfQifX
         adHDA+PC/V4jNT4DtDKWlS6A+oW/4p6MkzKcTpWqFuAsbjN204lrhGBy+6x9EuKNDpHX
         Uwejm1Zi0ETAOJbu7Hqhk8M4VuAsmyf6HScUmtLZwlHlAEWnuVXOwVm9pqBLWM9wMnf7
         npQKmGBXjN4O7u4vvo8x4g0N0i5lh/85aQj48LWH2kWRQPPdtzOflPQd2cazwdTAaD7T
         NVnpJYh4I7Ng/47a5LMArZSO+JcRPR9TlO7X1gtEdmgC0RufIyEf9hXBV+Sxsir2iJi4
         lk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdvC+51bl32WZuffSvloly+TOiS9ydaLK+J/h7e5kYs=;
        b=ZRnRVlm8MR6sDgdDC85sK9wmYnStVsf5e8TCFQzNKcHtoe7o6I9+PK2UkjeHsDecBv
         icoNqPaeIlgW5QGPUl8Vr2R25pJm7IRVFdQ0ce/SE/dsWo2rv4nLQ8VPyZQUOPNNHQTT
         TCNozNcuNe9UlqGNSMIdh8Sv7zZzIJEhq/Oi6fhezjGJzljoKVclnWd3Qap0hkJ1lo6E
         +JIB90wuln6w3gnrbBdhcGkILUetq6VjXwsZAZVXkqYwVvJKzxLjGy8mgHdEzeQEkedM
         XczaAsEpFU0aHrqO4BCR15Miex5YTAamF1i/trRvSvBoMpGZswZnYc/stRT+f1p5CM/P
         mCAg==
X-Gm-Message-State: APjAAAUfJB61WVaGkhB8w0m5OyHNkXCt5pdVwZeRyyMJ/H35/JuFF+MR
        lfTg+si2vkaR5u82qZ3vNWBsUg==
X-Google-Smtp-Source: APXvYqy4B4vQQeXJ1uhnaHc3rTnP73LNgKT3ooddRvEZrmVWZvbx6CpbgpWsgg/qibB6cAY086Fvhg==
X-Received: by 2002:ac8:6894:: with SMTP id m20mr6648520qtq.277.1553243703074;
        Fri, 22 Mar 2019 01:35:03 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:02 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 4/8] evmtest: test kexec signature policy
Date:   Fri, 22 Mar 2019 04:34:37 -0400
Message-Id: <20190322083441.31084-4-djacobs7@binghamton.edu>
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

With secure boot enabled, the bootloader verifies the kernel image's
signature before transferring control to it. With Linux as the
bootloader running with secure boot enabled, kexec needs to verify the
kernel image's signature.

This patch defined a new test named "kexec_sig", which first attempts to
kexec an unsigned kernel image with an IMA policy that requires
signatures on any kernel image. Then, the test attempts to kexec the
signed kernel image, which should succeed.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

Changelog:
* Added policy_sig to test list
* shellcheck compliant
* move from functions to tests
* suggestions from Mimi
* checkbashisms complaint
* removed begin
* removed long opts
* restructed to use functions
---
 evmtest/README                      |   3 +-
 evmtest/evmtest                     |   1 +
 evmtest/files/policies/kexec_policy |   3 +
 evmtest/tests/kexec_sig.sh          | 167 ++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 evmtest/files/policies/kexec_policy
 create mode 100755 evmtest/tests/kexec_sig.sh

diff --git a/evmtest/README b/evmtest/README
index 8c63630..91c8cda 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -39,7 +39,8 @@ TEST NAMES
  env_validate - verify kernel build
  example_test - example test
  policy_sig - verify loading IMA policies
- policy_sig - test IMA-appraise on policies
+ kexec_sig - test IMA-appraise on kexec image loading
+ kmod_sig - test IMA-appraise on kernel module loading
 
 
 Introduction
diff --git a/evmtest/evmtest b/evmtest/evmtest
index 49b162d..cd5e238 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -28,6 +28,7 @@ usage (){
 	# placement of a script in tests/
 	echo "[R]	env_validate"
 	echo "[ ]	examples_test"
+	echo "[R]	kexec_sig"
 	echo "[R]	kmod_sig"
 	echo "[R]	policy_sig"
 
diff --git a/evmtest/files/policies/kexec_policy b/evmtest/files/policies/kexec_policy
new file mode 100644
index 0000000..dc00fa7
--- /dev/null
+++ b/evmtest/files/policies/kexec_policy
@@ -0,0 +1,3 @@
+appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig
+measure func=KEXEC_KERNEL_CHECK
+audit func=KEXEC_KERNEL_CHECK
diff --git a/evmtest/tests/kexec_sig.sh b/evmtest/tests/kexec_sig.sh
new file mode 100755
index 0000000..3a9459d
--- /dev/null
+++ b/evmtest/tests/kexec_sig.sh
@@ -0,0 +1,167 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="kexec_sig"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+VERBOSE=0
+POLICY_LOAD="$ROOT"/files/load_policy.sh
+
+# This test validates that IMA measures and appraises signatures on kernel
+# images when trying to kexec, if the current policy requires that.
+usage() {
+	echo ""
+	echo "kexec_sig -k <key> [-i <kernel_image]"
+	echo "	[-vh]"
+	echo ""
+	echo "	This test must be run as root"
+	echo ""
+	echo "	This test validates that IMA prevents kexec-ing to an"
+	echo "	unsigned kernel image."
+	echo ""
+	echo ""
+	echo "	-k	The key for the certificate on the IMA keyring"
+	echo "	-i	An unsigned kernel image"
+	echo "	-h	Display this help message"
+	echo "	-v	Verbose logging"
+	echo ""
+	echo "	Note: kexec may require PECOFF signature"
+}
+
+parse_args () {
+	TEMP=$(getopt -o 'k:i:hv' -n 'kexec_sig' -- "$@")
+	eval set -- "$TEMP"
+
+	while true ; do
+		case "$1" in
+			-h) usage; exit 0 ; shift;;
+			-i) KERNEL_IMAGE=$2; shift 2;;
+			-k) IMA_KEY=$2; shift 2;;
+			-v) VERBOSE=1; shift;;
+			--) shift; break;;
+			*) echo "[*] Unrecognized option $1"; exit 1;;
+		esac
+	done
+
+	if [ -z "$IMA_KEY" ]; then
+		usage
+		exit 1
+	else
+		if [ ! -e "$IMA_KEY" ]; then
+			fail "Please provide valid keys"
+		fi
+	fi
+}
+
+
+
+# If the user doesn't provide a kernel image for kexec, get the current
+get_image () {
+	if [ -z "$KERNEL_IMAGE" ]; then
+		v_out "No kernel provided, looking for running kernel"
+		RUNNING_KERNEL=$(uname -r)
+		if [ -e /boot/vmlinuz-"$RUNNING_KERNEL" ]; then
+			KERNEL_IMAGE=/boot/vmlinuz-"$RUNNING_KERNEL"
+			TEMP_LOCATION=$(mktemp)
+			v_out "Copying kernel ($KERNEL_IMAGE) to $TEMP_LOCATION"
+			cp "$KERNEL_IMAGE" "$TEMP_LOCATION"
+			KERNEL_IMAGE="$TEMP_LOCATION"
+		fi
+	else
+		if [ ! -e "$KERNEL_IMAGE" ]; then
+			fail "Kernel image not found..."
+		else
+			v_out "Valid Kernel provided, continuing"
+		fi
+	fi
+}
+
+write_hash () {
+	v_out "Writing file hash on kernel image"
+	evmctl ima_hash -a sha256 -f "$KERNEL_IMAGE"
+}
+
+load_policy () {
+	v_out "Attempting to sign policy..."
+	evmctl ima_sign -f "$ROOT"/files/policies/kexec_policy -k "$IMA_KEY"
+
+	v_out "Loading kexec policy..."
+	if ! "$POLICY_LOAD" kexec_policy &>> /dev/null; then
+		fail "Could not update policy - verify keys"
+	fi
+}
+
+check_unsigned_KEXEC_FILE_LOAD () {
+	v_out "Testing loading an unsigned kernel image using KEXEC_FILE_LOAD"\
+		"syscall"
+	# -s uses the kexec_file_load syscall
+	if ! kexec -s -l "$KERNEL_IMAGE" &>> /dev/null; then
+		v_out "Correctly prevented kexec of an unsigned image"
+	else
+		kexec -s -u
+		fail "kexec loaded instead of rejecting. Unloading and exiting."
+	fi
+}
+
+check_unsigned_KEXEC_LOAD () {
+	v_out "Testing loading an unsigned kernel image using KEXEC_LOAD"\
+		"syscall"
+	if kexec -l "$KERNEL_IMAGE" &>> /dev/null; then
+		kexec -u
+		fail "Kexec loaded unsigned image - unloading"
+	else
+		v_out "Correctly prevented kexec of an unsigned image"
+	fi
+}
+
+sign_image () {
+	v_out "Signing kernel image with provided key..."
+	evmctl ima_sign -f "$KERNEL_IMAGE" -k "$IMA_KEY"
+}
+
+check_signed_KEXEC_FILE_LOAD () {
+	v_out "Testing loading a signed kernel image using KEXEC_FILE_LOAD"\
+		"syscall"
+	if ! kexec -s -l "$KERNEL_IMAGE" &>> /dev/null; then
+		fail "kexec rejected a signed image - possibly due to PECOFF"\
+			"signature"
+	else
+		v_out "kexec correctly loaded signed image...unloading"
+	fi
+
+	kexec -s -u
+}
+
+check_signed_KEXEC_LOAD () {
+	v_out "Testing loading a signed kernel image \
+	(without file descriptor) using KEXEC_LOAD syscall"
+
+	if kexec -l "$KERNEL_IMAGE" &>> /dev/null; then
+		kexec -u
+		fail "Signed image was allowed to load without file descriptor"\
+		"for appraisal. Unloading."
+	fi
+
+	v_out "Correctly prevented loading"
+}
+
+cleanup () {
+v_out "Cleaning up..."
+if [ -n "$TEMP_LOCATION" ]; then
+	rm "$TEMP_LOCATION"
+fi
+}
+
+
+EVMTEST_require_root
+echo "[*] Starting test: $TEST"
+parse_args "$@"
+get_image
+write_hash
+load_policy
+check_unsigned_KEXEC_FILE_LOAD
+check_unsigned_KEXEC_LOAD
+sign_image
+check_signed_KEXEC_FILE_LOAD
+check_signed_KEXEC_LOAD
+cleanup
+passed
-- 
2.20.1

