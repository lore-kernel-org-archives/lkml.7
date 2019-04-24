Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4152C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684992175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtMd1yjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfDXXPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41176 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfDXXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so5937710lja.8;
        Wed, 24 Apr 2019 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyyXDseGtNt7YxWY7gLAOh+cMeHBkiDm6YdXz8JbKHY=;
        b=HtMd1yjhZgvLvIVr6o+XINYSpc5/Et5Waj8G/R38Yaby33DdM0k69EM3Mo8WRuVeW/
         80Dpv2jVOzp+pwNZuBMaGSexMICh5ZhrWMNsx7uSyALFzWnNgl4rKCpnyuj/dDYrRDvp
         S1tuMY1zmy8RNFCDbgSs9eCXKwoDxJkRVm5jbITql7GmZExyztRpY3+pvi77o2LPcU3f
         S2ENMkcIsFhjfwPqbrT+ZVcfXrzKQXAligRsC++4NkxO237+bvQIQZjlmlSPGldxjawZ
         dDECRz7Od8aHHuW4tjBVaB1XVl/1tO5X+UE2/8BlF5lhXwmmqC5U6j89hBqaCRAx54Jv
         e8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyyXDseGtNt7YxWY7gLAOh+cMeHBkiDm6YdXz8JbKHY=;
        b=cBQ6QPQpnBC5qNq+BvWRiG7sDBOsBhjM454pMcNHb8UNPTLNPq9W40jPMQJ00BhUDH
         K7Eh/MfdBJhJsJ0Gnc9F1TGirYILRtk1JxqVLcVIsBMJqLpJANvJHtrNOsePHhRAAHfh
         j2UwuKBe9W9THgZnwq1doKrVwHf6u0UfU7nu4Cf4hdB86ut3ZAX2HJOD6Vf1KxQ4bM1y
         CtpQBNoLPCO331qmfKMOEx9Myo1JV8cSnlBPwGOJqN48GaKjyk3CmZzt0m5B54/0mOzD
         U4g2sbIUOPbhBY+6YihWkVr/h0uAhjgzgNoW4FwD7NrM2kzTWy66fHWho3u4SKAUFN5J
         WusA==
X-Gm-Message-State: APjAAAW3sIkpOcWFqmQCaob7XU9bZE0MIwNkFcdNqidgRKYVlUqAoIWd
        PKJENoWGw8JSkhR3TOvuRro=
X-Google-Smtp-Source: APXvYqyLETzWJ6BsAp0qz98MRDMl8h6rJQQWLc3qdiKQv9AknEWJbs6fcSkj/Uw2nm/TJBXanuTTkQ==
X-Received: by 2002:a2e:8819:: with SMTP id x25mr12026333ljh.18.1556147709060;
        Wed, 24 Apr 2019 16:15:09 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] clocksource/drivers/tegra: Unify timer code
Date:   Thu, 25 Apr 2019 02:14:39 +0300
Message-Id: <20190424231444.20876-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
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
 drivers/clocksource/timer-tegra20.c | 111 +++++++++++++++-------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 5a7732055c1f..508ca4cdbc60 100644
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
@@ -48,28 +44,20 @@
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
 static void __iomem *rtc_base;
 static struct timespec64 persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
-static struct delay_timer tegra_delay_timer;
-#endif
 
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
@@ -177,7 +165,6 @@ static int tegra_timer_stop(unsigned int cpu)
 	return 0;
 }
 
-#ifdef CONFIG_ARM
 static u64 notrace tegra_read_sched_clock(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
@@ -188,6 +175,11 @@ static unsigned long tegra_delay_timer_read_counter_long(void)
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
+static struct delay_timer tegra_delay_timer = {
+	.read_current_timer = tegra_delay_timer_read_counter_long,
+	.freq = 1000000,
+};
+
 /*
  * tegra_rtc_read - Reads the Tegra RTC registers
  * Care must be taken that this funciton is not called while the
@@ -211,7 +203,7 @@ static u64 tegra_rtc_read_ms(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
+static __maybe_unused void tegra_read_persistent_clock64(struct timespec64 *ts)
 {
 	u64 delta;
 
@@ -222,9 +214,34 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
 	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
 	*ts = persistent_ts;
 }
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
@@ -275,6 +292,8 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
+		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
 
 		/*
 		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
@@ -286,10 +305,10 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 				tegra_timer_set_periodic_fixed_rate;
 		}
 
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
@@ -309,6 +328,16 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -329,39 +358,20 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
-	if (err < 0)
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
+
+#ifdef CONFIG_ARM
+#include <asm/mach/time.h>
 
 static int __init tegra20_init_rtc(struct device_node *np)
 {
@@ -386,5 +396,4 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return register_persistent_clock(tegra_read_persistent_clock64);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 #endif
-- 
2.21.0

