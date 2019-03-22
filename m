Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E502083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="IwnsUXB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfCVIfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43912 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfCVIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so1572890qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgqzJKlYgrjsh+NPCvN4r+JkV5xuGyj+t6AG7/VzGIM=;
        b=IwnsUXB/ai3XHdIYd81DS0Ek/J8MbUGNfLHbA9yGdCvp8a5gjvzRAaC0IrKNC4bhw8
         qNTw9twdi9eVZKM/NKSFc6FoNtcbPWz19UoFph8g6XgZ3LfyUZYz4wHIH9Z9MHc8xHhJ
         FvzrIu8sp4dcfmqkgfgR7xo7f+tT4q7NPxr1vZtUvtFpj4ii7gQm8JdhZrksbr6zHK1w
         Y5UDGpotPju+zKQvPrwy9JRThH9fXZIPQJEv7oBpavRSJlDmX7ENla2UgB7LwjJW2AIn
         hXGooIOz7Q40K/baBs8BxgL5C9a51BnHxEzjlnwAoiKUnaHUCMhAuJO2jmicClIl+Wwx
         IBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgqzJKlYgrjsh+NPCvN4r+JkV5xuGyj+t6AG7/VzGIM=;
        b=n5ThjtQ6vkfvdbDN5D0hO9SfuTh9tZpJPPxIntSaC1Iq8y8cdkd2zYDK5QcmhdE38R
         U5pI6L+DN1eyLI0Gm+U8WZq5UYSGafiMvUxIW6Y+02uU/yA1NjJ7kOmuq+FqUjoMDwqW
         uRmWEs55+73Zh+SYLdeBxYe6EHn4kENssrlTeH1+H9yAYNgt3XKOXdbRbdtT8uJdnEjs
         9UVYF43+DSJOWwD8DeABmY7oqJCDOhjoZfOq8qF0aU9SCnJl05gDscpebhs+/LGL3Yg5
         fCIMy9UsgAI8DHgsBT2JI6Qe5HDapNU077S4KtI2J2fPSmNDD7PMK6ntD0RIohYazlDI
         2dPw==
X-Gm-Message-State: APjAAAVJsOvogIjzUzNHGlEJW39oSQapMTyXnAZqjTQapOSxoy3u+Ufu
        VnGiwIKg3YDDPsOdVWaXy0esdQ==
X-Google-Smtp-Source: APXvYqyoZ+gSSwdrqlgeeUPNErbFQtlTOA3fr1N5LHKlhKBLBrxyN9/3qLvxuWQcoyNLY9CM1zOW2w==
X-Received: by 2002:aed:35e4:: with SMTP id d33mr6647374qte.58.1553243705650;
        Fri, 22 Mar 2019 01:35:05 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:05 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 7/8] emvtest: Add ability to run all tests
Date:   Fri, 22 Mar 2019 04:34:40 -0400
Message-Id: <20190322083441.31084-7-djacobs7@binghamton.edu>
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

evmtest tests functionality of different IMA-Appraisal policies.

To simplify testing, this patch defines an evmtest config file.  This
allows for running all tests at once, rather than invoking each test
individually. Variables can be set once rather than specifying
parameters at runtime on the command line.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

changelog:
* removed [OPTIONS] for runall
* added CONFIGURATION PATHNAME -> configuration file
* shellcheck compliant
---
 evmtest/README       | 31 +++++++++++++++++++++++++-
 evmtest/evmtest      | 52 ++++++++++++++++++++++++++++++++++++++++++++
 evmtest/example.conf | 14 ++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 evmtest/example.conf

diff --git a/evmtest/README b/evmtest/README
index 4dddbc0..d202559 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -13,6 +13,7 @@ SYNOPSIS
 
 evmtest runtest <test name> [OPTIONS]
 
+evmtest runall <configuration pathname>
 
 DESCRIPTION
 -----------
@@ -34,7 +35,7 @@ OPTIONS
 
 
 TEST NAMES
-----------
+---------
 
  boot_aggregate - verify the IMA boot-aggregate
  env_validate - verify kernel build
@@ -45,6 +46,34 @@ TEST NAMES
  xattr_preserve - test metadata preservation on file move
 
 
+
+CONFIGURATION PATHNAME
+----------------------
+
+The configuration pathname should point to the runall configuration file.
+
+
+=== Configuration File
+
+The evmtest configuration file allows all tests to be run by executing a single
+command. The configuration file contains all the options that needed for
+various tests and allows tests to be run non-interactively, so they can be
+integrated in a larger testing suite.
+
+The `example.conf` file provides a skeleton configuration file, where the only
+variable that *must* be defined is `IMA_KEY`. Defaults are described below.
+
+* `IMA_KEY` - The private key for the certificate on the IMA Trusted Keyring
+
+* `KBUILD_DIR` - Should point to a kernel build tree. If not provided, the test
+will use `/lib/modules/$(uname -r)/build`.
+
+* `KERN_IMAGE` - Should point towards an unsigned kernel image. If not provided,
+the test will attempt to use the running kernel.
+
+* `VERBOSE` - If set to 1, will add -v to all tests run
+
+
 Introduction
 ------------
 
diff --git a/evmtest/evmtest b/evmtest/evmtest
index 18cb98d..d6f46f5 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -16,6 +16,7 @@ source "$EVMDIR"/files/common.sh
 usage (){
 	echo "Usage:"
 	echo "	evmtest runtest <test name> [OPTIONS]"
+	echo "	evmtest	runall <configuration file>"
 	echo ""
 	echo "Options:"
 	echo "	-h	Displays this help message"
@@ -67,6 +68,57 @@ elif [ "$1" == "runtest" ]; then
 		runtest "$@"
 		exit $?
 	fi
+elif [ "$1" == "runall" ]; then
+	if [ -z "$2" ] || [ ! -e "$2" ]; then
+		echo "evmtest runall <config file>"
+		echo "[!] Please provide a config file"
+		exit 1
+	fi
+	source "$2" # Load in config
+	if [ "$VERBOSE" -eq 1 ]; then
+		V="-v"
+	fi
+
+	# Key is not optional
+	if [ -z "$IMA_KEY" ]; then
+		echo "[*] Please correct your config file"
+		exit 1
+	fi
+
+	EVMTEST_require_root
+	FAIL=0
+	echo "[*] Running tests..."
+	# 1
+	"$EVMDIR"/tests/env_validate.sh -r "$V"
+	FAIL=$((FAIL+$?))
+	# 2
+	if [ -z "$KERN_IMAGE" ]; then
+		"$EVMDIR"/tests/kexec_sig.sh -k "$IMA_KEY" "$V"
+	else
+		"$EVMDIR"/tests/kexec_sig.sh -k "$IMA_KEY" -i \
+			"$KERN_IMAGE" "$V"
+	fi
+	FAIL=$((FAIL+$?))
+	# 3
+	if [ -z "$KBUILD_DIR" ]; then
+		"$EVMDIR"/tests/kmod_sig.sh -k "$IMA_KEY" "$V"
+	else
+		"$EVMDIR"/tests/kmod_sig.sh -b "$KBUILD_DIR" \
+			-k "$IMA_KEY" "$V"
+	fi
+	FAIL=$((FAIL+$?))
+	# 4
+	"$EVMDIR"/tests/policy_sig.sh -k "$IMA_KEY" "$V"
+	FAIL=$((FAIL+$?))
+	# 5
+	"$EVMDIR"/tests/boot_aggregate.sh "$V"
+	FAIL=$((FAIL+$?))
+	# 6
+	"$EVMDIR"/tests/xattr_preserve.sh "$V"
+	FAIL=$((FAIL+$?))
+	echo "..."
+	echo "[*] TESTS PASSED: $((6-FAIL))"
+	echo "[*] TESTS FAILED: $FAIL"
 else
 	usage
 fi
diff --git a/evmtest/example.conf b/evmtest/example.conf
new file mode 100644
index 0000000..fd1c8fe
--- /dev/null
+++ b/evmtest/example.conf
@@ -0,0 +1,14 @@
+# This is an example config file
+# There are three variables that can be set when using evmtest runall
+
+#Set this to 1 for verbose output
+VERBOSE=0
+# Path to the private key for the IMA Trusted Keyring
+# This is required
+IMA_KEY=/path/to/your/ima_key
+
+# If this is not provided, tests will run but attempt to copy the running kernel
+KERN_IMAGE=/path/to/unsigned/kernel_image
+
+# If this is not defined, tests will try to find build tree
+KBUILD_DIR=/path/to/kernel/build/tree
-- 
2.20.1

