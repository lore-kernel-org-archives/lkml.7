Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C232175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KjrT1fxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfDXXNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:13:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36576 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfDXXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so10169139pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iTzC2LknEGq+dSiv23e3s6QdQpr5UW6imYhTJ6A60aI=;
        b=KjrT1fxDoT0McG3ptEjcZjwYX/M2l3/ZOctARJxQcFagSvVVB/jkPqLKNlamhaNS6h
         M0mbC5ceW4bdap8uq1JnMPinYl4aPpAjkxlZkEKua5P3ZdDU9QQg/6hn752sJJ9PBeba
         2cPSgtD7SDtZTj0niI/dyeMmj1Mhj3VnDfgRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iTzC2LknEGq+dSiv23e3s6QdQpr5UW6imYhTJ6A60aI=;
        b=U/YZd8DzHLAxZzpMr+ScQlIC3QQysswuqsXh899zPnq8W8GBVGTdPn/0iJqeuNdOng
         CqOgyWFSFwdtP50hsFPVNQnwfH+cSJ1RK1eGtwg4nTEot/If89YaN3WzKklHec0cS2H6
         0j5lUaHRQyLILMzZZnf1+VZrUxD7hvf+VvfXrCwbrQiGQviU9j8Ozp1ttA5D0MiuSndV
         oJeOt4heDJhvIpEadFPYhXwEh6Ahm+xWp5DtXE5U7y3cDixOe8fHmN5/K1LEr7Lh1a+K
         l0y/ddwrVqdoW2/P0P6XeXC0Xmj324DC6Sxmba/n2apuFGyxOLE+gX0p690IRprddk5A
         qJgg==
X-Gm-Message-State: APjAAAXysX2bHNQi504pOyaKf/q7bEfRcIFEl0o0l0MseZhxMoeNVWGt
        Uh6UNlugqLYZeuGJAbJ06GBgAw==
X-Google-Smtp-Source: APXvYqx0reCRfsMOvXF9jnXzGq1YqJDFDpM9afbkbk08bZjtkLPY3rbMc8ftRSFPNH7mhTjh8gagNg==
X-Received: by 2002:a63:5041:: with SMTP id q1mr10368034pgl.386.1556147564334;
        Wed, 24 Apr 2019 16:12:44 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p6sm25076749pfd.122.2019.04.24.16.12.40
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
Subject: [PATCH v2 4/8] selftests: Add plan line and fix result line syntax
Date:   Wed, 24 Apr 2019 16:12:33 -0700
Message-Id: <20190424231237.14776-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAP version 13 spec requires a "plan" line, which has been missing.
Since we always know how many tests we're going to run, emit the count on
the plan line. This also fixes the result lines to remove the "1.." prefix
which is against spec, and to mark skips with the correct "# SKIP" suffix.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h         |  4 ++--
 tools/testing/selftests/kselftest/runner.sh | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 47e1d995c182..9f4147a6fdbc 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -111,7 +111,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
-	printf("ok %d # skip ", ksft_test_num());
+	printf("not ok %d # SKIP ", ksft_test_num());
 	vprintf(msg, args);
 	va_end(args);
 }
@@ -172,7 +172,7 @@ static inline int ksft_exit_skip(const char *msg, ...)
 		va_list args;
 
 		va_start(args, msg);
-		printf("1..%d # Skipped: ", ksft_test_num());
+		printf("not ok %d # SKIP ", ksft_test_num());
 		vprintf(msg, args);
 		va_end(args);
 	} else {
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index f12b0a631273..e0621974e01e 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -20,15 +20,15 @@ run_one()
 	echo "========================================"
 	if [ ! -x "$TEST" ]; then
 		echo "$TEST_HDR_MSG: Warning: file $TEST is not executable, correct this."
-		echo "not ok 1..$test_num $TEST_HDR_MSG [FAIL]"
+		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
 		(./$BASENAME_TEST >> "$logfile" 2>&1 &&
-		echo "ok 1..$test_num $TEST_HDR_MSG [PASS]") ||
+		echo "ok $test_num $TEST_HDR_MSG") ||
 		(if [ $? -eq $skip_rc ]; then	\
-			echo "not ok 1..$test_num $TEST_HDR_MSG [SKIP]"
+			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
 		else
-			echo "not ok 1..$test_num $TEST_HDR_MSG [FAIL]"
+			echo "not ok $test_num $TEST_HDR_MSG"
 		fi)
 		cd - >/dev/null
 	fi
@@ -39,6 +39,8 @@ run_many()
 	echo "TAP version 13"
 	DIR=$(basename "$PWD")
 	test_num=0
+	total=$(echo "$@" | wc -w)
+	echo "1..$total"
 	for TEST in "$@"; do
 		BASENAME_TEST=$(basename $TEST)
 		test_num=$(( test_num + 1 ))
-- 
2.17.1

