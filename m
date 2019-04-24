Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B75D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrZ7aZVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfDXXMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:12:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42538 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfDXXMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so5696868pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MWO4KenSHR25slNpTCUIhefVFREevGFRFzkC3RHE20M=;
        b=PrZ7aZVfgBiuZtYe4PrbOKtp4idfOdZwylzuSDPuhfaByEedQaMRp7lp+Pd4iBhZQ7
         DVmaJzF1UIzikdCp4jleLb55o8m8Kn5fZ/sj6boyac+PReSOkQfTT7vRwm+gHfVOIe0F
         DTY6AUYfSPYHDKkeQ+fc6tlPHng3B5NQdxg8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MWO4KenSHR25slNpTCUIhefVFREevGFRFzkC3RHE20M=;
        b=IXrzFpjP7gpumEqq1/Xg5sP4Akp8cs3iZO1Lm4M2pW/KxRaC7ihktS4vieoW6638gr
         +xvwF0kIl7KNdD1Hz/AyJyAfGJuyls+Ob/rBF6zVQq68QE+4FSCjo44CG0lsZcwEYQwa
         s4FfJkdSqyNbLtEoux6nGyf0nmh81gI3rVvR5cnLNZCcrmYJUAYwO//0Yp/u9iO2QHpf
         uHsoREr5izqLwEyzSkgUNub3tJkGdhO4hYyjlfJCBpaSycI/obkHCjlIDYVWGgeRhZV3
         XqwM7gS6f1yolP0Wx+WnCErBATk26zZeNN810YcO+5Q1x0KmMYIY/DVD/fybU0QKF0VM
         35vw==
X-Gm-Message-State: APjAAAVi/++5G6nHhvHOAuvzXvYNX5g1n6by1pI+aQ+8jkGuTU2L33Dy
        N09NP+f5n2EdUX7WLljAMtqr+w==
X-Google-Smtp-Source: APXvYqxkX+7q5cK6Y/F4x3Q++0IUyKNree3PZVatnmatqo691HD28fZot/p2tmE8gNTbnpiJCJ3Abg==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr5134764pls.334.1556147562468;
        Wed, 24 Apr 2019 16:12:42 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o81sm34003162pfa.156.2019.04.24.16.12.40
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
Subject: [PATCH v2 3/8] selftests: Extract logic for multiple test runs
Date:   Wed, 24 Apr 2019 16:12:32 -0700
Message-Id: <20190424231237.14776-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the logic for running multiple tests into a single "run_many"
function of runner.sh. Both "run_tests" and "emit_tests" are modified to
use it. Summary handling is now controlled by the "per_test_logging"
shell flag.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/Makefile            |  6 ++---
 tools/testing/selftests/kselftest/runner.sh | 25 ++++++++++++++++++---
 tools/testing/selftests/lib.mk              | 25 +++++++--------------
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c5f9f736cdbd..4ac1d1c7ce5b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -193,16 +193,14 @@ ifdef INSTALL_PATH
 	echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
 	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
-	echo "export KSFT_TAP_LEVEL=1" >> $(ALL_SCRIPT)
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		echo "echo ; echo TAP version 13" >> $(ALL_SCRIPT);	\
-		echo "echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
-		echo "echo ========================================" >> $(ALL_SCRIPT); \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
+		echo -n "run_many" >> $(ALL_SCRIPT); \
 		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
+		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
 	done;
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e1117d703887..f12b0a631273 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -2,17 +2,20 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Runs a set of tests in a given subdirectory.
+export KSFT_TAP_LEVEL=1
 export skip_rc=4
 export logfile=/dev/stdout
+export per_test_logging=
 
 run_one()
 {
-	TEST="$1"
-	NUM="$2"
+	DIR="$1"
+	TEST="$2"
+	NUM="$3"
 
 	BASENAME_TEST=$(basename $TEST)
 
-	TEST_HDR_MSG="selftests: "`basename $PWD`:" $BASENAME_TEST"
+	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "$TEST_HDR_MSG"
 	echo "========================================"
 	if [ ! -x "$TEST" ]; then
@@ -30,3 +33,19 @@ run_one()
 		cd - >/dev/null
 	fi
 }
+
+run_many()
+{
+	echo "TAP version 13"
+	DIR=$(basename "$PWD")
+	test_num=0
+	for TEST in "$@"; do
+		BASENAME_TEST=$(basename $TEST)
+		test_num=$(( test_num + 1 ))
+		if [ -n "$per_test_logging" ]; then
+			logfile="/tmp/$BASENAME_TEST"
+			cat /dev/null > "$logfile"
+		fi
+		run_one "$DIR" "$TEST" "$test_num"
+	done
+}
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 6b2d026a94ea..28b8ffedfdf1 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -67,19 +67,11 @@ endif
 
 .ONESHELL:
 define RUN_TESTS
-	@export KSFT_TAP_LEVEL=`echo 1`;		\
-	test_num=`echo 0`;				\
-	. $(selfdir)/kselftest/runner.sh;		\
-	echo "TAP version 13";				\
-	for TEST in $(1); do				\
-		BASENAME_TEST=`basename $$TEST`;	\
-		test_num=`echo $$test_num+1 | bc`;	\
-		if [ "X$(summary)" != "X" ]; then	\
-		        logfile="/tmp/$$BASENAME_TEST";	\
-			cat /dev/null > "$$logfile";	\
-		fi;					\
-		run_one "$$BASENAME_TEST" "$$test_num";	\
-	done;
+	@. $(selfdir)/kselftest/runner.sh;	\
+	if [ "X$(summary)" != "X" ]; then       \
+		per_test_logging=1;		\
+	fi;                                     \
+	run_many $(1)
 endef
 
 run_tests: all
@@ -117,12 +109,11 @@ else
 endif
 
 emit_tests:
-	@test_num=`echo 0`;				\
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
-		test_num=`echo $$test_num+1 | bc`;	\
-		echo "run_one \"$$BASENAME_TEST\" \"$$test_num\"";	\
-	done;
+		echo "	\\";				\
+		echo -n "	\"$$BASENAME_TEST\"";	\
+	done;						\
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
-- 
2.17.1

