Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838D321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H4dUFSl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfDXXNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:13:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46818 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfDXXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1018259pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KIorirH95SzVwrqSDe1yVALnBy6zYImlloz9Cy/V4l4=;
        b=H4dUFSl30RUmaew5ui9/relos6unEywoW37la27lK9cd1+Ze/AxlvlKLRxj24we6C+
         tZ201qsAlJK3WTntDFI8qhBgybh1CO4s3IXFBqF3sZT578Eds4gkxzEm6LGg2dH9Q6Yj
         8dFQKXkBerCOUfVPHqPa56Yv+QHQE7hE8VjOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KIorirH95SzVwrqSDe1yVALnBy6zYImlloz9Cy/V4l4=;
        b=uXap8ZNvS+X2iJQDKhdyqqqE1q5LF3/FSiggQCgCc519j3IzYz6SJ+mrb8/BcGFrN7
         IjEbtZvpbMDX/HiVMHmirXEHX8amOxuG4Ou0pK5NUFP5j8/ZkyAXszgp47+8dDVFClUG
         iSvzOv/Es5A9QtOauCpV5CJDAo5fI7RuZn9X1qCgqKMFk6ixShvIE/5xiQWh8IhChMTi
         ebqv70LDegRwcDltBePsnW0nOdcuuQBRAO0bpAkGns2XXFCYieBcN0ij8sCyOELO4aYD
         PJwd7NmzfGxDiBZbsfZu/HouURH4FBX8uI1YofClhXdsgmQtgLDeTsygm+Jc05/77nII
         R8EQ==
X-Gm-Message-State: APjAAAWjZzN7Of6zjSsKw+dwcG/uB2PnDyIXB/8DuK63AL6KESEP2IOF
        AaJBUY4RxTqvrhqd2HCk3puB6Q==
X-Google-Smtp-Source: APXvYqwL78F7iJIpuPRIG7HbqT8j/8lHbv+3i0+DrPZ4uXrUKcpW0lwg3z7IZ71eb6qyC4QLPtcwkQ==
X-Received: by 2002:a63:d908:: with SMTP id r8mr186591pgg.268.1556147565115;
        Wed, 24 Apr 2019 16:12:45 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f87sm32642931pff.56.2019.04.24.16.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:12:44 -0700 (PDT)
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
Subject: [PATCH v2 5/8] selftests: Distinguish between missing and non-executable
Date:   Wed, 24 Apr 2019 16:12:34 -0700
Message-Id: <20190424231237.14776-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a test was missing (e.g. wrong architecture, etc), the test runner
would incorrectly claim the test was non-executable. This adds an
existence check to report correctly.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest/runner.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e0621974e01e..a66fb64e61e9 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -19,7 +19,12 @@ run_one()
 	echo "$TEST_HDR_MSG"
 	echo "========================================"
 	if [ ! -x "$TEST" ]; then
-		echo "$TEST_HDR_MSG: Warning: file $TEST is not executable, correct this."
+		echo -n "$TEST_HDR_MSG: Warning: file $TEST is "
+		if [ ! -e "$TEST" ]; then
+			echo "missing!"
+		else
+			echo "not executable, correct this."
+		fi
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-- 
2.17.1

