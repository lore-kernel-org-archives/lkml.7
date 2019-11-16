Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F6C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FD720733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919049;
	bh=T1fjXJ8Jm32Cke60Jcid/VJwyP6KUMtt2vqjFjO8xeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TaY9zKO5FPna+FmRw3vRSjLMgYZdt2BSryEtEKOdm3ADYG9q1H37AufS+hf/hsLc5
	 v41pJ1Bw0+XyEacDahz+Xaydfw+mwm9yn8sOe3nDSl3UBPEkeot9w13i3QZmqR1qdr
	 zSUuhjiZAQnviwKm/HEQadPX6vOr29qnWZW/Y1pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfKPPnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbfKPPnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:39 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1955820833;
        Sat, 16 Nov 2019 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919018;
        bh=T1fjXJ8Jm32Cke60Jcid/VJwyP6KUMtt2vqjFjO8xeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCyt8RD6YK86xeR85nOUBAEhInc8zUHli0GBR3x25KDXgQ94HLvBlLgsouSGvPl5X
         2dgqtEAXtLftPhucdsNpybc+s579zJP+Kb5i3PAE+sH4ZFPC17N14sU3kEzZz26oeN
         Ql3Du7q4/QPEuJK6XqaLftqF58n/QBISrv0gQRnQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/237] selftests: kvm: Fix -Wformat warnings
Date:   Sat, 16 Nov 2019 10:39:14 -0500
Message-Id: <20191116154113.7417-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

[ Upstream commit fb363e2d20351e1d16629df19e7bce1a31b3227a ]

Fixes the following warnings:

dirty_log_test.c: In function ‘help’:
dirty_log_test.c:216:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Wformat=]
  printf(" -i: specify iteration counts (default: %"PRIu64")\n",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/test_util.h:18:0,
                 from dirty_log_test.c:16:
/usr/include/inttypes.h:105:34: note: format string is defined here
 # define PRIu64  __PRI64_PREFIX "u"
dirty_log_test.c:218:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Wformat=]
  printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/test_util.h:18:0,
                 from dirty_log_test.c:16:
/usr/include/inttypes.h:105:34: note: format string is defined here
 # define PRIu64  __PRI64_PREFIX "u"

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 0c2cdc105f968..a9c4b5e21d7e7 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -31,9 +31,9 @@
 /* How many pages to dirty for each guest loop */
 #define  TEST_PAGES_PER_LOOP            1024
 /* How many host loops to run (one KVM_GET_DIRTY_LOG for each loop) */
-#define  TEST_HOST_LOOP_N               32
+#define  TEST_HOST_LOOP_N               32UL
 /* Interval for each host loop (ms) */
-#define  TEST_HOST_LOOP_INTERVAL        10
+#define  TEST_HOST_LOOP_INTERVAL        10UL
 
 /*
  * Guest variables.  We use these variables to share data between host
-- 
2.20.1

