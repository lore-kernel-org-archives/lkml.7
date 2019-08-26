Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF7DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5621883
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHZWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:53:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41483 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfHZWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqS-0006nZ-HM; Tue, 27 Aug 2019 00:52:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6F6BD1C0DDA;
        Tue, 27 Aug 2019 00:52:15 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:15 -0000
From:   tip-bot2 for Avi Fishman <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/npcm: Fix GENMASK and timer operation
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993534.1315.8613837854195713163.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a2b58537b4a1cc08fd254fb8d1c24191ce286ae1
Gitweb:        https://git.kernel.org/tip/a2b58537b4a1cc08fd254fb8d1c24191ce286ae1
Author:        Avi Fishman <avifishman70@gmail.com>
AuthorDate:    Mon, 29 Jul 2019 20:03:54 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource/drivers/npcm: Fix GENMASK and timer operation

NPCM7XX_Tx_OPER GENMASK bits are wrong, fix them.

Hopefully the NPCM7XX_REG_TICR0 register reset value of those bits was 0,
so it did not cause an issue.

The function npcm7xx_timer_oneshot() reads the register
NPCM7XX_REG_TCSR0, modifies it and then reads it again overwriting the
previous changes. Remove the extra read which is pointless.

The function npcm7xx_timer_periodic() is correct but the code writes
to the NPCM7XX_REG_TICR0 register while it is dealing with the
NPCM7XX_REG_TCSR0 register, that is confusing. Separate the write to
the registers in the code for the sake of clarity.

Fixes: 1c00289ecd12 ("clocksource/drivers/npcm: Add NPCM7xx timer driver")
Signed-off-by: Avi Fishman <avifishman70@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-npcm7xx.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index 8a30da7..9780ffd 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN		BIT(29)
 #define NPCM7XX_Tx_COUNTEN		BIT(30)
 #define NPCM7XX_Tx_ONESHOT		0x0
-#define NPCM7XX_Tx_OPER			GENMASK(27, 3)
+#define NPCM7XX_Tx_OPER			GENMASK(28, 27)
 #define NPCM7XX_Tx_MIN_PRESCALE		0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS	24
 #define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
@@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct clock_event_device *evt)
 
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val |= NPCM7XX_START_ONESHOT_Tx;
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
@@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct clock_event_device *evt)
 	struct timer_of *to = to_timer_of(evt);
 	u32 val;
 
+	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
 	val |= NPCM7XX_START_PERIODIC_Tx;
-
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
 	return 0;
