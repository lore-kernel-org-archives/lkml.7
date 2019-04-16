Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A2BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B4F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsUVHxbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfDPMqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:46:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36897 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfDPMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:46:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so26926258wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WuOrfzFgty8uzg4eOOmrSDaHL1ckDJPXwtzntkoNBco=;
        b=fsUVHxbmcNGRETL5IAHYhnv5qmnHJEfmSBIA2Fq2sqz13s9TFBHz1DFawTeGqSAHgr
         hX+n+FHfP06FsSaMoTWP0aR6NJVSFqOm/2hSP7aKkRhQvow7GbfwrNDyzqCHVK5mNRub
         8ZYwsVjIG1cQ1VnbUYSHnMwYCLCOXXXat++bm5wsaMl45H3P1bHuq1p2+QJJns1t+S94
         +aUiZ5CY1+LOhLrQO0SotICbuYivhtgzDYUZFc9ajdnnaZv7SqG0/d0vxUIwgvy+GUdJ
         jX3suUYcC2uiT+X8W4GuJUmbSRP7erXb8y8+cGaIeq3mDmuNqRT2FCYz7cFdnwuNDG4q
         DGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WuOrfzFgty8uzg4eOOmrSDaHL1ckDJPXwtzntkoNBco=;
        b=LEVsJ0KjFmh3BNicB9DZ3FdI7FuSFJwcqmLJzTfXSBo6bmz6opPR5RVtgBG5ZW+kJi
         kRublpCmlP1hyo83mVl3lTlbT/32Xq8qrusByBfk0Hpu/52AWzx1RAu1GMMxxumJIhfN
         KjIOAhwWMG/5CqrQ02+mkAhdHDgH7aXX5cWVFEcc8XWEBYu/naTFY80OFgpsgAMk18Vd
         dJoyIkEgCRZsZLzoz9gostUuXLRmklIHtWbNZzsy8qOR0jKrWZCxJBDE5uUsfBRkOORj
         47J0+E5bqakxVmJgj/QZJ05+dygq7qniyc3hI8BmU66xVD0RzVLSNec8tHhr2rXEgwb2
         BVVA==
X-Gm-Message-State: APjAAAUTfA8gDpUJoX3kXpm+8Fdebte2prSkw8aDhOuqideVITt6QR19
        ntcWRUqpYvmqTD2KpX3WNfwwew==
X-Google-Smtp-Source: APXvYqz1aYFyRUu7TF9UuQMErnkZwCqrtgtIjZ7y3lc7XB3ZU4BuGxNebtNVbS7HiC7oF4cVGZRbig==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr31053383wrw.301.1555418808778;
        Tue, 16 Apr 2019 05:46:48 -0700 (PDT)
Received: from mai.imgcgcw.net (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.gmail.com with ESMTPSA id p6sm42823732wrs.6.2019.04.16.05.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:46:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM ARCHITECTED
        TIMER DRIVER)
Subject: [PATCH 2/4] clocksource/drivers/arm_arch_timer: Remove unneeded pr_fmt macro
Date:   Tue, 16 Apr 2019 14:46:38 +0200
Message-Id: <20190416124640.20058-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416124640.20058-1-daniel.lezcano@linaro.org>
References: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
 <20190416124640.20058-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

After this commit ded24019b6b6f(clocksource: arm_arch_timer: clean up
printk usage), the previous macro is redundant, so delete it.

And move the new macro to the previous position.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aa4ec53281ce..ea373cfbcecb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-#define pr_fmt(fmt)	"arm_arch_timer: " fmt
+#define pr_fmt(fmt) 	"arch_timer: " fmt
 
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -33,9 +33,6 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#undef pr_fmt
-#define pr_fmt(fmt) "arch_timer: " fmt
-
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
-- 
2.17.1

