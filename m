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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E9B26DF6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI+tV50d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFCTER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfFCTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so4744114ljf.4;
        Mon, 03 Jun 2019 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljHJzlH15H5xJbtWlMPrYUZUURDvwfZd1b/t/CFjvXs=;
        b=TI+tV50dnC5GBgz4JZFOmtduiq+Zvna81IanuzBVxVxtrzN12cWhy9Q8bnZGUT5DJM
         WwPalxZr3XSrXcPyoZOlgQYp5XEruZF2GivvPordfHWzfaSR+sCnStjE6UCXi+Hp78ds
         RKI7lefXy0zQ7+ENrJRoR/t9qipUlOWvJEsxEFsja19YjX7CK8O7IwZl6R52vrHtCLB+
         7d21FNbn+ulmDipMsew03GZSgABuEs/KzbGV4GgSc9ZJePOYU52bNEWFVx8qD/H7La0U
         7cosgUFHxPVnMXiH904IBIm8dmy99PXH7NVZul9kw/W9iBNYLB7kUR1+g5EYaNfeKub8
         1s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljHJzlH15H5xJbtWlMPrYUZUURDvwfZd1b/t/CFjvXs=;
        b=CazjbnDz1u/tNKvupLzuTPHakNPjZVtK9TetMdak9sfEjbju4TFuBGQfpCmiiJtF96
         B7eLcmaKynJsBsBx7QQSPLvuTkqO9D/+SQwWRyUkJ2RGAbvygGl7ZE4FgU/CXvb6HZeK
         dT3zpUDbSPAuWS3VLkF1k1bu3WkIhcW32JxrJ185SD0AY6XJamThf6m0WZtPVsjWEddZ
         Kj03z0I03laTkXXPxq1PgRnd32u5NL10K/0rt+hWrFEKSnD7WFD1DacPfRXTPH2QwaYU
         g6vWlnHrEjF8AVXL/rjg6bMu8xitx34as4RGZ09h2y7xPQ+dbIiukfd/phO34GDj/qkC
         CCnQ==
X-Gm-Message-State: APjAAAWJkFO0DxP+iLQhVwe03rlR42upG8RTUNV0yZWLhhidFqkugbdU
        TKPau2EUTXQ+hnByIlXEupQ=
X-Google-Smtp-Source: APXvYqxdSVM6R/eh8l9HV+mbS44bEd1edAQGKF98QYnMElxaFv1+zc/wmU+fknkpKh5uGJkNyqtSOw==
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr13092741ljj.100.1559588651359;
        Mon, 03 Jun 2019 12:04:11 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] clocksource/drivers/tegra: Unify timer code
Date:   Mon,  3 Jun 2019 21:59:40 +0300
Message-Id: <20190603185948.30438-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
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
microseconds counter, hence the timer_us clocksource is now made available
for Tegra210 as well.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 111 +++++++++++++++-------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 58e8bb6deac9..57e7aa2b80a3 100644
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
@@ -164,17 +152,23 @@ static int tegra_timer_stop(unsigned int cpu)
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
@@ -199,9 +193,34 @@ static struct clocksource suspend_rtc_clocksource = {
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
@@ -252,6 +271,8 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
+		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
 
 		/*
 		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
@@ -260,10 +281,10 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -283,6 +304,18 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -303,39 +336,17 @@ static int tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -350,5 +361,3 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
-#endif
-- 
2.21.0

