Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED2C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB48208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQAI2Leb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfFLQlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:41:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35278 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfFLQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:41:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so12704407lfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LY3Zum7EcZySh9JV2QeSI4VbZdzqoIew45sk+wZcJEo=;
        b=TQAI2LebuM1+ynuvr8g3h6TzCBLzN9uyrGj9oAFp954KLiKbjPYhrSn57VkSeKB+GO
         1TW+f4ABv+jfBF6kJmcvyEPYpAqWhUV7KKkGG25p5Ch89K1ScHW4B38jh0c2ATAddfGS
         4fBSYPmsKHNZe5wWpX7BclI9vv1TkSNAWFKFkWoXO1lYGhXE8J3yio5cqepODBt6/cgB
         CkPCGcFH8TZQwlafoEQusXPdb/4zMFhN08uJlURhN5Nve4wRP23WkP68wVO6GkKbM5pC
         lo3Spo91KZ86EtKpKSrGUKvhSmidkLNStcQVFn0BeVFXbh8rfU5ufN4sn0qOUdNEIG+8
         9pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LY3Zum7EcZySh9JV2QeSI4VbZdzqoIew45sk+wZcJEo=;
        b=O/lkEqAmparNHYxvbpYWPDV2ssnJ6mSRXgxDnmr4MDetLuk5S8PTy6NZO6T+oj7fjz
         jy6JVpjWVRugO5kAS3ZZC0jKtqnHfDIxRxE0ynFnScR611Yu/HbVznQYStCZoQtlBU+q
         fpMx9G5b5IfyiFz0hQ5eF5xfocGE0qLkRZxeYN8uDIqNi/DnHUIQ4psfVLCMMfp5w09X
         8/uuzlzFIdENpUzeewQYmYbuM9gas2Bg9Sn8BQAsVtfBGRC0R3g8frD2fJDPiOmlJlAn
         WEMYIlbB/EUyCSYfjbuA3HCSr7HsXm1CYI4Eh1ic2Y2c/OW0Tm9gRdeyORS9It5ZWAl4
         d5nQ==
X-Gm-Message-State: APjAAAVjVRuAeihBitEK7F12N/6PwXGT8te5NheWMmjfuc7kvZ84/6ro
        Srkriqa8KSoMBLP96ryYhHGXtZFJop3Wdg==
X-Google-Smtp-Source: APXvYqz6QDOJM5JIGBo3oUBwIo24eGlCYtbosVQp04IUzpddt+vXBwhkPiBIsXgkOa0hXozn07Ho1Q==
X-Received: by 2002:a19:9152:: with SMTP id y18mr1312743lfj.128.1560357710141;
        Wed, 12 Jun 2019 09:41:50 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id l25sm65239lfk.57.2019.06.12.09.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:41:49 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, keescook@chromium.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/kselftest/runner.sh: Add 30 second timeout per test
Date:   Wed, 12 Jun 2019 18:41:46 +0200
Message-Id: <20190612164146.25280-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
test") solves that binary tests doesn't hang forever. However, scripts
can still hang forever, this adds an timeout to each test script run. This
assumes that an individual test doesn't take longer than 30 seconds.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/kselftest/runner.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 00c9020bdda8..cff7d2d83648 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -5,6 +5,7 @@
 export skip_rc=4
 export logfile=/dev/stdout
 export per_test_logging=
+export TEST_TIMEOUT_DEFAULT=30
 
 # There isn't a shell-agnostic way to find the path of a sourced file,
 # so we must rely on BASE_DIR being set to find other tools.
@@ -24,6 +25,14 @@ tap_prefix()
 	fi
 }
 
+tap_timeout()
+{
+	if [ -x /usr/bin/timeout ] && [ -x "$BASENAME_TEST" ] \
+		&& file $BASENAME_TEST |grep -q "shell script"; then
+		echo -n "timeout $TEST_TIMEOUT_DEFAULT"
+	fi
+}
+
 run_one()
 {
 	DIR="$1"
@@ -44,7 +53,7 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
-- 
2.11.0

