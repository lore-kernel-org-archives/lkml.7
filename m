Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17543C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21A4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnPSxqo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDXXNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:13:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39749 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfDXXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so10020456pgj.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XnQBDo9k2oLEZ5F3zS0pOxbIMI+0vYGMgEt5HE+i3VY=;
        b=cnPSxqo2s6pQjFMgb1bvtkRrgeGU3L4fKJGDRn8gM/+CBe1AikmWM1GOiZrXP4HlFX
         EVrq3QGX+jFufgJ9cI6lxPWe2dIajCGADpYdjndB6N9ArmNpfPR6XyH8U/+QhBOGkKIW
         cT6+Fvh6BSaaylJhBQM8P5zsRSCpCzewqcfcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XnQBDo9k2oLEZ5F3zS0pOxbIMI+0vYGMgEt5HE+i3VY=;
        b=gmmENvsNg0DkuV2ixnrXHIV5JfmZPCz6tGbswYkKhuOXbLI+IlllASSBlQ225JCAPd
         4cmGWWECTTkf/wO1e8w5N/WOmZPyI8ePBIgs+hv5ULnBcf4ISFZNsz/fmToxFMvKBJsf
         4qmY2ZDbudIIJrI/nL3LEmJ5s3jXgl3o1LRg1J3UgCSQSN5SpfMYavnKWfeliwIA/kqM
         JYu56q4//TUWXcNSHRrLIrOIm7V7dOihMfL+Rj1e62jhqBp0U6+nCU/eWN7tspJJQ34w
         1LgZes6T/dQ2beUFcNhwdbbn5y8GFxVrizhpHQZASLGDUS5B7jRd5Mi50Fk9RiaofTBK
         DAOQ==
X-Gm-Message-State: APjAAAUnMf74bm+9xteSy7fB5QdTKvZnC6uO7KV64R+4rSmc7sOBXY/W
        3n00QujXMeLkzGDAuAxfFcgxfw==
X-Google-Smtp-Source: APXvYqwCSb1YskOnavo70LGN7TD5SJE1/RNSuA9Or7U0zIF27H9lIssGxFJGpmJbSYavJjt6acz10Q==
X-Received: by 2002:a62:4e86:: with SMTP id c128mr35880525pfb.39.1556147563094;
        Wed, 24 Apr 2019 16:12:43 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 13sm31138871pfi.172.2019.04.24.16.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:12:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] selftests: Extract single-test shell logic from lib.mk
Date:   Wed, 24 Apr 2019 16:12:30 -0700
Message-Id: <20190424231237.14776-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve the reusability of the kselftest test running logic,
this extracts the single-test logic from lib.mk into kselftest/runner.sh
which lib.mk can call directly. No changes in output.

As part of the change, this moves the "summary" Makefile logic around
to set a new "logfile" output. This will be used again in the future
"emit_tests" target as well.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/.gitignore          |  1 -
 tools/testing/selftests/kselftest/runner.sh | 32 ++++++++++++++++++
 tools/testing/selftests/lib.mk              | 37 ++++-----------------
 3 files changed, 39 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/kselftest/runner.sh

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 91750352459d..8059ce834247 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -1,4 +1,3 @@
-kselftest
 gpiogpio-event-mon
 gpiogpio-hammer
 gpioinclude/
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
new file mode 100644
index 000000000000..e1117d703887
--- /dev/null
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Runs a set of tests in a given subdirectory.
+export skip_rc=4
+export logfile=/dev/stdout
+
+run_one()
+{
+	TEST="$1"
+	NUM="$2"
+
+	BASENAME_TEST=$(basename $TEST)
+
+	TEST_HDR_MSG="selftests: "`basename $PWD`:" $BASENAME_TEST"
+	echo "$TEST_HDR_MSG"
+	echo "========================================"
+	if [ ! -x "$TEST" ]; then
+		echo "$TEST_HDR_MSG: Warning: file $TEST is not executable, correct this."
+		echo "not ok 1..$test_num $TEST_HDR_MSG [FAIL]"
+	else
+		cd `dirname $TEST` > /dev/null
+		(./$BASENAME_TEST >> "$logfile" 2>&1 &&
+		echo "ok 1..$test_num $TEST_HDR_MSG [PASS]") ||
+		(if [ $? -eq $skip_rc ]; then	\
+			echo "not ok 1..$test_num $TEST_HDR_MSG [SKIP]"
+		else
+			echo "not ok 1..$test_num $TEST_HDR_MSG [FAIL]"
+		fi)
+		cd - >/dev/null
+	fi
+}
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 5979fdc4f36c..9d2b3c303bfa 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -14,6 +14,7 @@ ifeq (0,$(MAKELEVEL))
 	endif
     endif
 endif
+selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
@@ -65,43 +66,19 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
 .ONESHELL:
-define RUN_TEST_PRINT_RESULT
-	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
-	echo $$TEST_HDR_MSG;					\
-	echo "========================================";	\
-	if [ ! -x $$TEST ]; then	\
-		echo "$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.";\
-		echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]"; \
-	else					\
-		cd `dirname $$TEST` > /dev/null; \
-		if [ "X$(summary)" != "X" ]; then	\
-			(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && \
-			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") || \
-			(if [ $$? -eq $$skip ]; then	\
-				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]";				\
-			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";					\
-			fi;)			\
-		else				\
-			(./$$BASENAME_TEST &&	\
-			echo "ok 1..$$test_num $$TEST_HDR_MSG [PASS]") ||						\
-			(if [ $$? -eq $$skip ]; then \
-				echo "not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]"; \
-			else echo "not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]";				\
-			fi;)		\
-		fi;				\
-		cd - > /dev/null;		\
-	fi;
-endef
-
 define RUN_TESTS
 	@export KSFT_TAP_LEVEL=`echo 1`;		\
 	test_num=`echo 0`;				\
-	skip=`echo 4`;					\
+	. $(selfdir)/kselftest/runner.sh;		\
 	echo "TAP version 13";				\
 	for TEST in $(1); do				\
 		BASENAME_TEST=`basename $$TEST`;	\
 		test_num=`echo $$test_num+1 | bc`;	\
-		$(call RUN_TEST_PRINT_RESULT,$(TEST),$(BASENAME_TEST),$(test_num),$(skip))						\
+		if [ "X$(summary)" != "X" ]; then	\
+		        logfile="/tmp/$$BASENAME_TEST";	\
+			cat /dev/null > "$$logfile";	\
+		fi;					\
+		run_one "$$BASENAME_TEST" "$$test_num";	\
 	done;
 endef
 
-- 
2.17.1

