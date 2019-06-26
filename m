Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9622C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983C121670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTMI536E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfFZOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfFZOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2399019wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCTMtso5AmHagoM0kbPRWJWMA6Wb3OobegULM1kp5BM=;
        b=aTMI536Eim8TcauDkcrVaRm5YZ9JFMT4cTZJ2X0B45UB0iPzfxC9MpXor3iIIP6oJI
         p5QiNRqa0HSMBlBQo10RFmlCtC5oo7epSxMKNgAjS1shoeMzuAC+YTpl3ZbPFPefs590
         TDP11d3vu1zDy4pOZxpVNcJLsgP+k1uxQ0l2rU7rjjc2cR3hH4MI1/nnzTNjWq7/fqu3
         sf0z4YJT7d8dnWRnSfOqkwHsFOHArPIqxLvkQO4O39eP6nzLv1x4cuhldNohB3s6Qra6
         NDjvVjlhqwMk9bJk1NqWhM3qqxf7/MOMsK1ho/zjX7llQQ01AyNXlL9dJ4NA4Aasojv5
         2zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCTMtso5AmHagoM0kbPRWJWMA6Wb3OobegULM1kp5BM=;
        b=oyxiAknuLp85Zm71Lkqzwek2B5MkGOx9SD4VmJEkkz+pv1IVWy9sHULXLjsJUZQfMl
         PhMOoZGkjUF+7e9TAVYNNdHbq0PtvZwTp8lV7Wp26hS6OS6SR1ePag6KuSbtsJYqgSUU
         ZeeCvsh0BfCg0tuwUsDgVy1JD+YuweB46YdbFg3luXtv5vdb4VZhYsB/5dZ+XNnJUooV
         IYNHuUSLHdobR1axsIP3JJxckG/LY2Lpt+uRcl7czAWoy9WizMkoGUl9+i9CEpSIk10/
         WLQx4ozyMFsWjASdHXjVZCz6B9vxoyuNdL0derP/wJGj8BfFAbxoBTYBWG+VNcj+fJ+k
         wrFA==
X-Gm-Message-State: APjAAAWDKjgjQUxO2xI7g88RFCTR7YvJJe/gSrRn4Iah78LhjvyEs0oN
        TQV6g3MUvZmRMzBIbMnwpnOO5w==
X-Google-Smtp-Source: APXvYqzJtLxMzasX4DvcArKJ1/ZEMlTvM8AryQ+14SrXPDW5dpSRolFHNBkYxA8xHDBzWrY5LQXFGA==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr3190763wmc.62.1561560439887;
        Wed, 26 Jun 2019 07:47:19 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 05/25] clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
Date:   Wed, 26 Jun 2019 16:46:31 +0200
Message-Id: <20190626144651.16742-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Assign TMR1-4 per-CPU core on 32bit Tegra's in a way it is done for
Tegra210. In a result each core can handle its own timer events, less
code is unique to ARM64 and Tegra's clock events driver now has higher
rating on all Tegra's, replacing the ARM's TWD timer which isn't very
accurate due to the clock rate jitter caused by CPU frequency scaling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra20.c | 120 ++++++++++------------------
 1 file changed, 43 insertions(+), 77 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 1e7ece279730..4b30ba6228c1 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -40,13 +40,18 @@
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
@@ -109,7 +114,6 @@ static void tegra_timer_resume(struct clock_event_device *evt)
 	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 }
 
-#ifdef CONFIG_ARM64
 static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
 	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
 
@@ -150,33 +154,8 @@ static int tegra_timer_stop(unsigned int cpu)
 
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
@@ -213,10 +192,12 @@ static struct clocksource suspend_rtc_clocksource = {
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
@@ -258,29 +239,19 @@ static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
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
@@ -322,43 +293,39 @@ static int __init tegra_init_timer(struct device_node *np)
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
@@ -374,6 +341,5 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 #endif
-TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
-- 
2.17.1

