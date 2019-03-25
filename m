Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F367C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C120883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfCYDFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:05:43 -0400
Received: from mx.socionext.com ([202.248.49.38]:52829 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfCYDFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:05:42 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Mar 2019 12:05:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 638C5180D5D;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Mar 2019 12:05:39 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 36F471A15B7;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2566D120459;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 3/3] clocksource/drivers/timer-milbeaut: Cleanup common register accesses
Date:   Mon, 25 Mar 2019 12:05:49 +0900
Message-Id: <1553483149-8922-4-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aggregate common register accesses into shared functions for
maintainability.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/clocksource/timer-milbeaut.c | 62 +++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index f478061..fa9fb4e 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -26,8 +26,8 @@
 #define MLB_TMR_TMCSR_CSL_DIV2	0
 #define MLB_TMR_DIV_CNT		2
 
-#define MLB_TMR_SRC_CH  (1)
-#define MLB_TMR_EVT_CH  (0)
+#define MLB_TMR_SRC_CH		1
+#define MLB_TMR_EVT_CH		0
 
 #define MLB_TMR_SRC_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_SRC_CH)
 #define MLB_TMR_EVT_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_EVT_CH)
@@ -43,6 +43,8 @@
 #define MLB_TMR_EVT_TMRLR2_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR2_OFS)
 
 #define MLB_TIMER_RATING	500
+#define MLB_TIMER_ONESHOT	0
+#define MLB_TIMER_PERIODIC	1
 
 static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
 {
@@ -59,38 +61,53 @@ static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mlb_set_state_periodic(struct clock_event_device *clk)
+static void mlb_evt_timer_start(struct timer_of *to, bool periodic)
 {
-	struct timer_of *to = to_timer_of(clk);
 	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
+	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	if (periodic)
+		val |= MLB_TMR_TMCSR_RELD;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+}
+
+static void mlb_evt_timer_stop(struct timer_of *to)
+{
+	u32 val = readl_relaxed(timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
 
-	writel_relaxed(to->of_clk.period, timer_of_base(to) +
-				MLB_TMR_EVT_TMRLR1_OFS);
-	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE |
-		MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	val &= ~MLB_TMR_TMCSR_CNTE;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+}
+
+static void mlb_evt_timer_register_count(struct timer_of *to, unsigned long cnt)
+{
+	writel_relaxed(cnt, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
+}
+
+static int mlb_set_state_periodic(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_register_count(to, to->of_clk.period);
+	mlb_evt_timer_start(to, MLB_TIMER_PERIODIC);
 	return 0;
 }
 
 static int mlb_set_state_oneshot(struct clock_event_device *clk)
 {
 	struct timer_of *to = to_timer_of(clk);
-	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
-	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_start(to, MLB_TIMER_ONESHOT);
 	return 0;
 }
 
 static int mlb_set_state_shutdown(struct clock_event_device *clk)
 {
 	struct timer_of *to = to_timer_of(clk);
-	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
 	return 0;
 }
 
@@ -99,22 +116,21 @@ static int mlb_clkevt_next_event(unsigned long event,
 {
 	struct timer_of *to = to_timer_of(clk);
 
-	writel_relaxed(event, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
-	writel_relaxed(MLB_TMR_TMCSR_CSL_DIV2 |
-			MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_INTE |
-			MLB_TMR_TMCSR_TRG, timer_of_base(to) +
-			MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_register_count(to, event);
+	mlb_evt_timer_start(to, MLB_TIMER_ONESHOT);
 	return 0;
 }
 
 static int mlb_config_clock_source(struct timer_of *to)
 {
-	writel_relaxed(0, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
-	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMR_OFS);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
 	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR1_OFS);
 	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR2_OFS);
-	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
-		MLB_TMR_SRC_TMCSR_OFS);
+	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
 	return 0;
 }
 
-- 
1.9.1

