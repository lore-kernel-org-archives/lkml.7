Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2A8C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA3C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWsSDN0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfFZOtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:49:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36015 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfFZOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so2412606wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2UTyMg0ppc1eRRdj76DkfzWSoIkOQypLQmaCRQCYNW0=;
        b=RWsSDN0a4DiHR2l8ZBogjElCbox/F4BHyfDbWcqTOM65gERQsqr/FafYGXFwch3YxG
         h8lgJ120hKnIOgJDkh4DwPMHT0TvCUwvuKm3nXzO+o0NzDwOJS882ndSciw1JziRqzh0
         46mu6NUXi2HZURdd0JBcRe1Pv9PIEIOKrf+Iu8V4Wav26zVoqjwTpVFFNdUSoFuRKtC4
         jtV6ZAxzVa8H38imQeCSLfn25n/Bjf8SFJXtvVs3EdXyLSI18TfsUj3fFA0kF3xVujQW
         JjmQNpWXva310L0zwiNGbqMpbplMHCObWSI7mfINNucb9so0kfmHaonfrVUDA6mAvW5V
         FC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2UTyMg0ppc1eRRdj76DkfzWSoIkOQypLQmaCRQCYNW0=;
        b=IKqB5cL9wMC7ghDmgzSOdh1VJEj0eccDeRejrD3yRT7H/xQz1yBvS3ofBwfjP7LNI2
         9bAAMoTpl54sNDk+oESjS8DRuVqWUX2247hWVPhY8K1jkluxFnk1nozE7Z/zP0wOk8lY
         ufDL0CWlsE7BF60rrOqgLI/zKIJSKGmchqrbhLTvhbdgyZ9K70urHlQcOrFpINz4fk5Z
         bM1c+RUWCNG+3nthT97V56tyXj6H8XdTfTfS2CzkQmheJEKA0GulDD1VnZKgEiYJG6Nf
         i09ArjT55TX52xVl5076xtsEkMqKrVPbeD86Ly7nI6Jp3bEz0jvOqTGToQBbZSSQoett
         dCQg==
X-Gm-Message-State: APjAAAWEd5vMxBaWZxD/uSYhFbNfAHKv75O5NXHzCaGEXmawCeDMtMDd
        VCKVijkOF8Qxc3Af4o5tZSTVsjn9Lb4=
X-Google-Smtp-Source: APXvYqw9IRXuNYtf5Auf0jrHrDR0BFlWwaisPPbHtMAsuc+Fj3pxdQi3DUMAD8O8UpRaq94HdUVhQQ==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr2933225wmj.2.1561560442330;
        Wed, 26 Jun 2019 07:47:22 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 06/25] clocksource/drivers/tegra: Unify timer code
Date:   Wed, 26 Jun 2019 16:46:32 +0200
Message-Id: <20190626144651.16742-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Tegra132 is 64bit platform and it has the tegra20-timer hardware unit.
Right now the corresponding timer code isn't compiled for ARM64, remove
ifdef'iness from the code and compile tegra20-timer for both 32 and 64 bit
platforms. Also note that like the older generations, Tegra210 has the
microseconds counter, hence the timer_us clocksource is now made available
for Tegra210 as well.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra20.c | 111 +++++++++++++++-------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 4b30ba6228c1..acd68c77fa91 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -21,10 +21,6 @@
 
 #include "timer-of.h"
 
-#ifdef CONFIG_ARM
-#include <asm/mach/time.h>
-#endif
-
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
 #define RTC_MILLISECONDS       0x10
@@ -39,25 +35,17 @@
 #define TIMER_PCR		0x4
 #define TIMER_PCR_INTR_CLR	BIT(30)
 
-#ifdef CONFIG_ARM
-#define TIMER_CPU0		0x00 /* TIMER1 */
-#define TIMER_CPU2		0x50 /* TIMER3 */
+#define TIMER1_BASE		0x00
+#define TIMER2_BASE		0x08
+#define TIMER3_BASE		0x50
+#define TIMER4_BASE		0x58
+#define TIMER10_BASE		0x90
+
 #define TIMER1_IRQ_IDX		0
-#define IRQ_IDX_FOR_CPU(cpu)	(TIMER1_IRQ_IDX + cpu)
-#define TIMER_BASE_FOR_CPU(cpu)	\
-	(((cpu) & 1) * 8 + ((cpu) < 2 ? TIMER_CPU0 : TIMER_CPU2))
-#else
-#define TIMER_CPU0		0x90 /* TIMER10 */
 #define TIMER10_IRQ_IDX		10
-#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
-#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
-#endif
 
 static u32 usec_config;
 static void __iomem *timer_reg_base;
-#ifdef CONFIG_ARM
-static struct delay_timer tegra_delay_timer;
-#endif
 
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
@@ -155,17 +143,23 @@ static int tegra_timer_stop(unsigned int cpu)
 	return 0;
 }
 
-#ifdef CONFIG_ARM
 static u64 notrace tegra_read_sched_clock(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
+#ifdef CONFIG_ARM
 static unsigned long tegra_delay_timer_read_counter_long(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
+static struct delay_timer tegra_delay_timer = {
+	.read_current_timer = tegra_delay_timer_read_counter_long,
+	.freq = 1000000,
+};
+#endif
+
 static struct timer_of suspend_rtc_to = {
 	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
 };
@@ -190,9 +184,34 @@ static struct clocksource suspend_rtc_clocksource = {
 	.mask	= CLOCKSOURCE_MASK(32),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
-#endif
 
-static int tegra_init_timer(struct device_node *np, bool tegra20)
+static inline unsigned int tegra_base_for_cpu(int cpu, bool tegra20)
+{
+	if (tegra20) {
+		switch (cpu) {
+		case 0:
+			return TIMER1_BASE;
+		case 1:
+			return TIMER2_BASE;
+		case 2:
+			return TIMER3_BASE;
+		default:
+			return TIMER4_BASE;
+		}
+	}
+
+	return TIMER10_BASE + cpu * 8;
+}
+
+static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
+{
+	if (tegra20)
+		return TIMER1_IRQ_IDX + cpu;
+
+	return TIMER10_IRQ_IDX + cpu;
+}
+
+static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 {
 	struct timer_of *to;
 	int cpu, ret;
@@ -243,6 +262,8 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
+		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
 
 		/*
 		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
@@ -251,10 +272,10 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 		if (tegra20)
 			cpu_to->of_clk.rate = 1000000;
 
-		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		cpu_to->of_base.base = timer_reg_base + base;
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
-		cpu_to->clkevt.irq =
-			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
+		cpu_to->clkevt.irq = irq_of_parse_and_map(np, idx);
 		if (!cpu_to->clkevt.irq) {
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
@@ -274,6 +295,18 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 		}
 	}
 
+	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
+
+	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
+				    "timer_us", 1000000,
+				    300, 32, clocksource_mmio_readl_up);
+	if (ret)
+		pr_err("failed to register clocksource: %d\n", ret);
+
+#ifdef CONFIG_ARM
+	register_current_timer_delay(&tegra_delay_timer);
+#endif
+
 	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
 			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
 			  tegra_timer_stop);
@@ -294,39 +327,17 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 	return ret;
 }
 
-#ifdef CONFIG_ARM64
 static int __init tegra210_init_timer(struct device_node *np)
 {
 	return tegra_init_timer(np, false);
 }
 TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_init_timer);
-#else /* CONFIG_ARM */
+
 static int __init tegra20_init_timer(struct device_node *np)
 {
-	struct timer_of *to;
-	int err;
-
-	err = tegra_init_timer(np, true);
-	if (err)
-		return err;
-
-	to = this_cpu_ptr(&tegra_to);
-
-	sched_clock_register(tegra_read_sched_clock, 32,
-			     timer_of_rate(to));
-	err = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", timer_of_rate(to),
-				    300, 32, clocksource_mmio_readl_up);
-	if (err)
-		pr_err("Failed to register clocksource: %d\n", err);
-
-	tegra_delay_timer.read_current_timer =
-			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = timer_of_rate(to);
-	register_current_timer_delay(&tegra_delay_timer);
-
-	return 0;
+	return tegra_init_timer(np, true);
 }
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 
 static int __init tegra20_init_rtc(struct device_node *np)
 {
@@ -341,5 +352,3 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
-#endif
-- 
2.17.1

