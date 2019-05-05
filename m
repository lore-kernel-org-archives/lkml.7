Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA464C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F1F208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8YdTckI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfEEQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 12:25:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36145 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfEEQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:25:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so805046lfl.3;
        Sun, 05 May 2019 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=us/x2se0nJ0UbyATJJBtJCUasmh/3ZYo6D/IH6DvFKs=;
        b=C8YdTckIMGx2Kp80Ysqqq4gCdinvdMjg79t878XH6PRXYvLpTjDzGilTXSZCRZ5Uke
         EaOcHFYSSs8SrGzJzZA81jhNLRaislaSxVRbMGzlujZmVCBSu+782iL6/kKRrIseZd/8
         3i+3HBWhocYFadOKPfzvT3rl7gvqNbHPO1skqEwadvG38+lCuw5Vc4ZS4hoG4AufqLaM
         b8/AOtgnoYXMgbGnKgCDF3FdiD38wMmyruZgqcR0X2jUYLwSGS/j8AV2q/FMANa7KO5z
         GSJ9bvexrN4XE9fhytHUulRirotjH8t/vc+cdjGgO/wfLAEyElXO64g9bBGT3SManz5V
         AcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=us/x2se0nJ0UbyATJJBtJCUasmh/3ZYo6D/IH6DvFKs=;
        b=twhpT/SW50epjJChDUbiZgdunMXiLK94VKXdQo+w0XxDxcsYdH5c8LjrEaoQpHa/GE
         uHhTRSqwiJObd7E/3Y2iVoQKJzI6KqLNJqPhauJC2KwM9Ane9d3q6QSzOFUTfEv7ImF2
         3dH6elGU0unn480CUoLLK8bVXFO44elRd9lHw6a5OgMSa9AlgbD7mpkJ90FS7p44aa2l
         nRN0N/yeTYz/KNYESHv4Tlhx+YUlaRjL68m8ckYeaPOV4zNwDfSSrbvAi8XyvJKoVkhv
         zvYLxKDPC0T2/PuhUzmM80jQ69OHDLvHVD51Ke8wqqeWYoQz97DWfECQ4vYHwKbstO9Q
         Ysnw==
X-Gm-Message-State: APjAAAV03Pzojb7+aNlh/0zxepnBteCOoqij0G9V1mzpBGPdoyI/Nsri
        qLvPeqa9A9ZWypyZnF/V9s4=
X-Google-Smtp-Source: APXvYqxDZ/uOSYlChjralukCgYUxPm+LHcUmjyXbx0h8gfnjCyGz1iCMi5vXulJa0F3NeqIoszDnRw==
X-Received: by 2002:ac2:5446:: with SMTP id d6mr90429lfn.47.1557073516362;
        Sun, 05 May 2019 09:25:16 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g13sm1581649lfh.49.2019.05.05.09.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 09:25:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] clocksource/drivers/tegra: Unify timer code
Date:   Sun,  5 May 2019 19:24:31 +0300
Message-Id: <20190505162436.23125-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505162436.23125-1-digetx@gmail.com>
References: <20190505162436.23125-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra132 is 64bit platform and it has the tegra20-timer hardware unit.
Right now the corresponding timer code isn't compiled for ARM64, remove
ifdef'iness from the code and compile tegra20-timer for both 32 and 64 bit
platforms. Also note that like the older generations, Tegra210 has the
microseconds counter. Hence the delay timer and timer_us clocksource are
now made available for Tegra210 as well.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 107 +++++++++++++++-------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 58e8bb6deac9..42a19a4019a9 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -30,10 +30,6 @@
 
 #include "timer-of.h"
 
-#ifdef CONFIG_ARM
-#include <asm/mach/time.h>
-#endif
-
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
 #define RTC_MILLISECONDS       0x10
@@ -48,25 +44,17 @@
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
@@ -164,7 +152,6 @@ static int tegra_timer_stop(unsigned int cpu)
 	return 0;
 }
 
-#ifdef CONFIG_ARM
 static u64 notrace tegra_read_sched_clock(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
@@ -175,6 +162,11 @@ static unsigned long tegra_delay_timer_read_counter_long(void)
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
+static struct delay_timer tegra_delay_timer = {
+	.read_current_timer = tegra_delay_timer_read_counter_long,
+	.freq = 1000000,
+};
+
 static struct timer_of suspend_rtc_to = {
 	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
 };
@@ -199,9 +191,34 @@ static struct clocksource suspend_rtc_clocksource = {
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
@@ -252,6 +269,8 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
+		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
 
 		/*
 		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
@@ -260,10 +279,10 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -283,6 +302,16 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
+	register_current_timer_delay(&tegra_delay_timer);
+
 	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
 			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
 			  tegra_timer_stop);
@@ -303,39 +332,17 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -350,5 +357,3 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
-#endif
-- 
2.21.0

