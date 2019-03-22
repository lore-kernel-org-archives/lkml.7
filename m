Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D06D2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="U3GGCL4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCVIfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37029 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfCVIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so1623871qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhnXicmFBTSFqGzyUFmfRXJnBFygK9aujfgCD+WFYQc=;
        b=U3GGCL4EZQ0KRnBnwtu0pLNYoBpC9WIh8gZny1AkxtFqhJ94HZHIepwHsgMlHJ/yvq
         hTxDBfS5Bh0ZvdKwLzKAMki1lkTQ+vPZ1gqP904HWsGpZ2SCEMYCDfs9HMaUJ9ENvzmE
         tfXA5UczkNHPjCuv/pcWjbsbEwr/DKIEoCgijm44GYcJTvn+cGPMp3+urbtxrEj/frcf
         Kqq6BBR8g5lvLI2kbYo2ABR688HWgKOfrYifB4wnI7s/Qpn1k/Zs6L+ek0MvjjPtkfXN
         WilkzKD9H3l/xMSuAtIU/6WhBi/usLlREzQ5+AJNI6X2WkOsILumXXOZRZ8eUzlBBQPz
         Rsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhnXicmFBTSFqGzyUFmfRXJnBFygK9aujfgCD+WFYQc=;
        b=mLX0m4UvO5SU0mqhVW7c7wwG2r0B0EW8vZjpSkXdQOwe5SJDMPzmCGOHik6AlduB0M
         PcdaGDrqUg+fZJawjwBPwKkPX8eZokesVZfz5FMDUdgmPSgg84iSf0NLQGoMia1g4utJ
         JNGasaDSASZIMEdRcPuCpBVaXn/I1spNGkay7EChV1sAQVAlaaSqtbXJPXlD3IwsCGra
         tlLY2FyGDk03xDwcI8hsv4F2N3wHT3cDI418t4WTgk8FkPCjfS1fbkG9RE65EGrUe7uQ
         nIjK+FNeTaHwP+Z+OQm4jQ5j/JdYU/1MqzUpyHgaT4alcXuEI6x1ihH76cDNPnBNXBWJ
         +Mdg==
X-Gm-Message-State: APjAAAXL6xL1ltrqyROYS0w0uJ5o4PU8g6pu17Up1lNL2ZnQ+v3yBjQa
        uynPN7xnJ9LnEugB3cxNc+e55g==
X-Google-Smtp-Source: APXvYqzTwpQ+98MlfPVXbP3DCYg8Q/B8dIvd/aNpwTKL/1heCL76s0oqo2fX8aXwbpbWsW46sI/hCQ==
X-Received: by 2002:ac8:30ea:: with SMTP id w39mr7125192qta.351.1553243704818;
        Fri, 22 Mar 2019 01:35:04 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:04 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 6/8] evmtest: test the preservation of extended attributes
Date:   Fri, 22 Mar 2019 04:34:39 -0400
Message-Id: <20190322083441.31084-6-djacobs7@binghamton.edu>
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

IMA supports file signatures by storing information in a security.ima
extended file attribute. This test ensures that the attribute is
preserved when a file is copied.  This test requires root because only
root can write "security." xattrs to files.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

Changelog:
* Clean ups suggested via mailing list
* getfattr used correctly
* more information about which file is created
* added xattr_preserve to test list
* shellcheck compliant
* move from functions to tests
* checkbashisms complaint
* remove begin
* removed long opts
* restructured using functions
---
 evmtest/README                  |  1 +
 evmtest/evmtest                 |  1 +
 evmtest/tests/xattr_preserve.sh | 81 +++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100755 evmtest/tests/xattr_preserve.sh

diff --git a/evmtest/README b/evmtest/README
index b2d37e2..4dddbc0 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -42,6 +42,7 @@ TEST NAMES
  policy_sig - verify loading IMA policies
  kexec_sig - test IMA-appraise on kexec image loading
  kmod_sig - test IMA-appraise on kernel module loading
+ xattr_preserve - test metadata preservation on file move
 
 
 Introduction
diff --git a/evmtest/evmtest b/evmtest/evmtest
index 3c967f9..18cb98d 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -32,6 +32,7 @@ usage (){
 	echo "[R]	kexec_sig"
 	echo "[R]	kmod_sig"
 	echo "[R]	policy_sig"
+	echo "[R]	xattr_preserve"
 
 	echo ""
 	echo "Note: Tests may be run directly from the \"tests\" directory"
diff --git a/evmtest/tests/xattr_preserve.sh b/evmtest/tests/xattr_preserve.sh
new file mode 100755
index 0000000..61f6ded
--- /dev/null
+++ b/evmtest/tests/xattr_preserve.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="xattr_preserve"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+
+VERBOSE=0
+# This test ensures that extended file attributes are preserved when a file is
+# moved with the correct flag
+
+usage (){
+	echo ""
+	echo "xattr_preserve [-hv]"
+	echo ""
+	echo "This test requires root privileges to write security xattrs"
+	echo ""
+	echo "	This test ensures that extended file attributes (specifically"
+	echo "	security.ima labels) are preserved when copying"
+	echo "Options"
+	echo "  -h	Display this help message"
+	echo "  -v	Verbose logging"
+}
+
+parse_args () {
+	TEMP=$(getopt -o 'hv' -n 'xattr_preserve' -- "$@")
+	eval set -- "$TEMP"
+
+	while true ; do
+		case "$1" in
+		-h) usage; exit; shift;;
+		-v) VERBOSE=1; shift;;
+		--) shift; break;;
+		*) echo "[*] Unrecognized option $1"; exit 1;;
+		esac
+	done
+}
+
+check_xattr_preserve () {
+	LOCATION_1=$(mktemp)
+	LOCATION_2=$(mktemp -u) # Doesn't create the file
+
+	v_out "Creating and labeling file $LOCATION_1..."
+
+	evmctl ima_hash "$LOCATION_1"
+
+	initial_ima_label=$(getfattr --absolute-names -n security.ima \
+			"$LOCATION_1")
+	initial_hash=$(echo "$initial_ima_label" | awk -F '=' '{print $2}')
+	if printf '%s' "$initial_ima_label" | grep -E -q "security.ima"; then
+		v_out "Found hash on initial file... "
+	else
+		fail "Hash not found on initial file"
+	fi
+
+	initial_hash=$(echo "$initial_ima_label" | awk -F '=' '{print $2}')
+
+	v_out "Copying file to $LOCATION_2..."
+	cp --preserve=xattr "$LOCATION_1" "$LOCATION_2"
+	v_out "Checking if extended attribute has been preserved..."
+
+
+	second_ima_label=$(getfattr --absolute-names -n security.ima \
+			"$LOCATION_2")
+	second_hash=$(echo "$second_ima_label" | awk -F '=' '{print $2}')
+	if [ "$initial_hash" != "$second_hash" ]; then
+		fail "security.ima xattr was not preserved!"
+	else
+		v_out "Extended attribute was preserved during copy"
+	fi
+}
+
+cleanup () {
+	v_out "Cleaning up..."
+	rm "$LOCATION_1" "$LOCATION_2"
+}
+
+EVMTEST_require_root
+echo "[*] Starting test: $TEST"
+check_xattr_preserve
+cleanup
+passed
-- 
2.20.1

