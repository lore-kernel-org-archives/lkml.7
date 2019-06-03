Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9906FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B0F25125
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnUXwZor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFCTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46119 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id m15so8997253ljg.13;
        Mon, 03 Jun 2019 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Ed1+Ug4ZkhEgqg4yLYkOxWrNtJBdRgQSanrCzVExY8=;
        b=OnUXwZorfdeN+o6jT4EAX7ekTpNwsj8W0pV9F5kO4/Tf0+Bwir5QeUSt7rdYJNhN2H
         YROp6Rm0XsRi/FyqNVvk7hQuLcxxYszWiU9VNTiVAlon85xW/ktkrS5lpfGhTL5R/ms9
         nYz63UDyLBps3oy4SijlPiNxjxJnpdpTLs15MTtp6SWPbObseHaGAY+9fQWYN+kt05m4
         Xj2Eqbcxm4mcMnNMO4RKwJA9h0KsqW7db06nRa+/SPACB30iTbpi1fploxYo1qIOrCN3
         4+g4xwCm1ngCinlsBDRJsCbg4cH10VChoubdRKMcDHlHkHulAs5O6Rg1Jm2bQbvSPbzm
         sPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Ed1+Ug4ZkhEgqg4yLYkOxWrNtJBdRgQSanrCzVExY8=;
        b=BNHfrUybVjTAOVEzT5qJKz+vS4hfWn/vP3urHkeNCWXuJGiiNe7MerBMXbSw7dQuN+
         9jmPt0TVZVOKh3ImwmTuaXKH6gSPZRlioPpr1MhCnYJ2a2RH6FakB8TYEXCzXOW+kEx5
         BHtTQCdZ3owDtPsGVnwNxQS6I5qblxECXrc3t5V3BoMKWM11Ho3tdXbQQBISJdfFIJb+
         g1O6loR8jmILKPxamdM/eYupit5xIvZ2tt0WBzc/OQIsvenffK8CQNtZZV7weh6rGvpk
         gqtSBSKbNWisRhfgIPFNOOg4iosGZQ3d6G09xf7/3WVBxnDb72HYZSpimpKYDfPMNFuV
         q8CQ==
X-Gm-Message-State: APjAAAUFj6DK4RHiTxem1pxaPBqH4PJR//7yqStUdY43L+zhuU2XvpdQ
        kyBPxNmxa40pNAWv8gg16QA=
X-Google-Smtp-Source: APXvYqzook9Q+dtFUsA4V7UwiDsAmPzQcv83LPx6lkYElaI15HMFqLbfMRk7aqCFtViZJsg7BIwrvw==
X-Received: by 2002:a2e:8785:: with SMTP id n5mr7696556lji.215.1559588649448;
        Mon, 03 Jun 2019 12:04:09 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
Date:   Mon,  3 Jun 2019 21:59:39 +0300
Message-Id: <20190603185948.30438-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign TMR1-4 per-CPU core on 32bit Tegra's in a way it is done for
Tegra210. In a result each core can handle its own timer events, less
code is unique to ARM64 and Tegra's clock events driver now has higher
rating on all Tegra's, replacing the ARM's TWD timer which isn't very
accurate due to the clock rate jitter caused by CPU frequency scaling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 120 ++++++++++------------------
 1 file changed, 43 insertions(+), 77 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 919b3568c495..58e8bb6deac9 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -49,13 +49,18 @@
 #define TIMER_PCR_INTR_CLR	BIT(30)
 
 #ifdef CONFIG_ARM
-#define TIMER_CPU0		0x50 /* TIMER3 */
+#define TIMER_CPU0		0x00 /* TIMER1 */
+#define TIMER_CPU2		0x50 /* TIMER3 */
+#define TIMER1_IRQ_IDX		0
+#define IRQ_IDX_FOR_CPU(cpu)	(TIMER1_IRQ_IDX + cpu)
+#define TIMER_BASE_FOR_CPU(cpu)	\
+	(((cpu) & 1) * 8 + ((cpu) < 2 ? TIMER_CPU0 : TIMER_CPU2))
 #else
 #define TIMER_CPU0		0x90 /* TIMER10 */
 #define TIMER10_IRQ_IDX		10
 #define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
-#endif
 #define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
+#endif
 
 static u32 usec_config;
 static void __iomem *timer_reg_base;
@@ -118,7 +123,6 @@ static void tegra_timer_resume(struct clock_event_device *evt)
 	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 }
 
-#ifdef CONFIG_ARM64
 static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
 	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
 
@@ -159,33 +163,8 @@ static int tegra_timer_stop(unsigned int cpu)
 
 	return 0;
 }
-#else /* CONFIG_ARM */
-static struct timer_of tegra_to = {
-	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
-
-	.clkevt = {
-		.name = "tegra_timer",
-		.rating	= 300,
-		.features = CLOCK_EVT_FEAT_ONESHOT |
-			    CLOCK_EVT_FEAT_PERIODIC |
-			    CLOCK_EVT_FEAT_DYNIRQ,
-		.set_next_event	= tegra_timer_set_next_event,
-		.set_state_shutdown = tegra_timer_shutdown,
-		.set_state_periodic = tegra_timer_set_periodic,
-		.set_state_oneshot = tegra_timer_shutdown,
-		.tick_resume = tegra_timer_shutdown,
-		.suspend = tegra_timer_suspend,
-		.resume = tegra_timer_resume,
-		.cpumask = cpu_possible_mask,
-	},
-
-	.of_irq = {
-		.index = 2,
-		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
-		.handler = tegra_timer_isr,
-	},
-};
 
+#ifdef CONFIG_ARM
 static u64 notrace tegra_read_sched_clock(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
@@ -222,10 +201,12 @@ static struct clocksource suspend_rtc_clocksource = {
 };
 #endif
 
-static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
+static int tegra_init_timer(struct device_node *np, bool tegra20)
 {
-	int ret = 0;
+	struct timer_of *to;
+	int cpu, ret;
 
+	to = this_cpu_ptr(&tegra_to);
 	ret = timer_of_init(np, to);
 	if (ret < 0)
 		goto out;
@@ -267,29 +248,19 @@ static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
 		goto out;
 	}
 
-	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
-
-out:
-	return ret;
-}
-
-#ifdef CONFIG_ARM64
-static int __init tegra_init_timer(struct device_node *np)
-{
-	int cpu, ret = 0;
-	struct timer_of *to;
-
-	to = this_cpu_ptr(&tegra_to);
-	ret = tegra_timer_common_init(np, to);
-	if (ret < 0)
-		goto out;
+	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 
 	for_each_possible_cpu(cpu) {
-		struct timer_of *cpu_to;
+		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+
+		/*
+		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
+		 * parent clock.
+		 */
+		if (tegra20)
+			cpu_to->of_clk.rate = 1000000;
 
-		cpu_to = per_cpu_ptr(&tegra_to, cpu);
 		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
-		cpu_to->of_clk.rate = timer_of_rate(to);
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->clkevt.irq =
 			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
@@ -331,43 +302,39 @@ static int __init tegra_init_timer(struct device_node *np)
 	timer_of_cleanup(to);
 	return ret;
 }
+
+#ifdef CONFIG_ARM64
+static int __init tegra210_init_timer(struct device_node *np)
+{
+	return tegra_init_timer(np, false);
+}
+TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_init_timer);
 #else /* CONFIG_ARM */
-static int __init tegra_init_timer(struct device_node *np)
+static int __init tegra20_init_timer(struct device_node *np)
 {
-	int ret = 0;
+	struct timer_of *to;
+	int err;
 
-	ret = tegra_timer_common_init(np, &tegra_to);
-	if (ret < 0)
-		goto out;
+	err = tegra_init_timer(np, true);
+	if (err)
+		return err;
 
-	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
-	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
+	to = this_cpu_ptr(&tegra_to);
 
 	sched_clock_register(tegra_read_sched_clock, 32,
-			     timer_of_rate(&tegra_to));
-	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", timer_of_rate(&tegra_to),
+			     timer_of_rate(to));
+	err = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
+				    "timer_us", timer_of_rate(to),
 				    300, 32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("Failed to register clocksource\n");
-		goto out;
-	}
+	if (err)
+		pr_err("Failed to register clocksource: %d\n", err);
 
 	tegra_delay_timer.read_current_timer =
 			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
+	tegra_delay_timer.freq = timer_of_rate(to);
 	register_current_timer_delay(&tegra_delay_timer);
 
-	clockevents_config_and_register(&tegra_to.clkevt,
-					timer_of_rate(&tegra_to),
-					0x1,
-					0x1fffffff);
-
-	return ret;
-out:
-	timer_of_cleanup(&tegra_to);
-
-	return ret;
+	return 0;
 }
 
 static int __init tegra20_init_rtc(struct device_node *np)
@@ -383,6 +350,5 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 #endif
-TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
-- 
2.21.0

