Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035AAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8739222C1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfCXKe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:34:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 06:34:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OAY8uD1421591
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 03:34:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OAY7hi1421588;
        Sun, 24 Mar 2019 03:34:07 -0700
Date:   Sun, 24 Mar 2019 03:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shiyan <tipbot@zytor.com>
Message-ID: <tip-2a6a8e2d9004b5303fcb494588ba3a3b87a256c3@git.kernel.org>
Cc:     shc_work@mail.ru, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        arnd@arndb.de, tglx@linutronix.de
Reply-To: shc_work@mail.ru, hpa@zytor.com, daniel.lezcano@linaro.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
          tglx@linutronix.de
In-Reply-To: <20181220111626.17140-1-shc_work@mail.ru>
References: <20181220111626.17140-1-shc_work@mail.ru>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/clps711x: Remove board
 support
Git-Commit-ID: 2a6a8e2d9004b5303fcb494588ba3a3b87a256c3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2a6a8e2d9004b5303fcb494588ba3a3b87a256c3
Gitweb:     https://git.kernel.org/tip/2a6a8e2d9004b5303fcb494588ba3a3b87a256c3
Author:     Alexander Shiyan <shc_work@mail.ru>
AuthorDate: Thu, 20 Dec 2018 14:16:26 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 11:30:11 +0100

clocksource/drivers/clps711x: Remove board support

Since board support for the CLPS711X platform was removed,
remove the board support from the clps711x-timer driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lkml.kernel.org/r/20181220111626.17140-1-shc_work@mail.ru

---
 drivers/clocksource/clps711x-timer.c | 45 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index cdc251524f5e..857f8c086274 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -31,16 +31,9 @@ static u64 notrace clps711x_sched_clock_read(void)
 	return ~readw(tcd);
 }
 
-static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
+static void __init clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 {
-	unsigned long rate;
-
-	if (!base)
-		return -ENOMEM;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
-	rate = clk_get_rate(clock);
+	unsigned long rate = clk_get_rate(clock);
 
 	tcd = base;
 
@@ -48,8 +41,6 @@ static int __init _clps711x_clksrc_init(struct clk *clock, void __iomem *base)
 			      clocksource_mmio_readw_down);
 
 	sched_clock_register(clps711x_sched_clock_read, 16, rate);
-
-	return 0;
 }
 
 static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
@@ -67,13 +58,6 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 	struct clock_event_device *clkevt;
 	unsigned long rate;
 
-	if (!irq)
-		return -EINVAL;
-	if (!base)
-		return -ENOMEM;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
 	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
 	if (!clkevt)
 		return -ENOMEM;
@@ -93,32 +77,29 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 			   "clps711x-timer", clkevt);
 }
 
-static void __init clps711x_clksrc_init(void __iomem *tc1_base,
-					void __iomem *tc2_base,
-					unsigned int irq)
-{
-	struct clk *tc1 = clk_get_sys("clps711x-timer.0", NULL);
-	struct clk *tc2 = clk_get_sys("clps711x-timer.1", NULL);
-
-	BUG_ON(_clps711x_clksrc_init(tc1, tc1_base));
-	BUG_ON(_clps711x_clkevt_init(tc2, tc2_base, irq));
-}
-
-#ifdef CONFIG_TIMER_OF
 static int __init clps711x_timer_init(struct device_node *np)
 {
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
 
+	if (!base)
+		return -ENOMEM;
+	if (!irq)
+		return -EINVAL;
+	if (IS_ERR(clock))
+		return PTR_ERR(clock);
+
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
-		return _clps711x_clksrc_init(clock, base);
+		clps711x_clksrc_init(clock, base);
+		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
 		return _clps711x_clkevt_init(clock, base, irq);
 	default:
 		return -EINVAL;
 	}
+
+	return 0;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
-#endif
