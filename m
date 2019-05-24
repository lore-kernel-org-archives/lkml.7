Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B198C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355E1217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ZoGGre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbfEXPfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:35:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43762 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389814AbfEXPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so9027645lji.10;
        Fri, 24 May 2019 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9tPoKh6v4/2G+YqR2rAKuMQIIR4hdO1ztimbmlKniY=;
        b=e6ZoGGrekX2VIs2H9mPHxQfxPG2zm0plNskl0dyQENiPZPQT0WwJWodKpyYcgEWiQN
         Ib3o/wk5NODXXyEulfSNdya4scj3diykOe3mTNZ4iWM10W/Xl0Io0qA+z9eRb4XZXUO/
         sEHS0QcLQcoG3tHD464F6UW+mJX4AahV9MMINHTTBQRH3th3bT8JNoIdF2RKYekUjJFC
         cuXiLh5fo96YakpuD3LsXQiLNTRUJxB9J4GmRMuj+OFMu+kIjtkJVy/HMF03U+Mu2oYV
         hOQTIr9rZAFKsFnyAgmh9NaDL4nTzERbvoPD7XpZNSUiNeCMnd8RTKSiwid8hl7Vyigy
         rvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9tPoKh6v4/2G+YqR2rAKuMQIIR4hdO1ztimbmlKniY=;
        b=Cq5xckJYlEGEkafuFwX4vYNze+gx/J0vJG6bvYh9xfUNQtBoLUWCc+5r2OIjw2yko6
         +mu1UZFjdC4tPsw7BGVjhTUoswXj6k6Y2Ys97X2d8VTFxxgPF/br0znTF0vTR638c61h
         M9qkohc5wW1u3zFr99bZrTBTkqRvB/o2xe5WpCTJ2JWikwfpu7tu325neF+4O/MCjIDG
         v75iAFf/q2c4aS3EdYRSEpT2NAw+TJOnLpz8N/yYoZPwSgqNQvwun/Q/s+dJ2xu3YdN9
         E3P7Uj9zDJj9K4T9v+iYO2mMaM0LMDGYOPtR8TVJ7cAmpptbKUEDRa99kLGlJQzwxs6j
         v+jg==
X-Gm-Message-State: APjAAAXJyrFLDXOqABEZaEU685dQCSDJcdTS7a3gxignTIATIP3qHjVZ
        I+4/yVh3X6AtqnJb1aw4Abo=
X-Google-Smtp-Source: APXvYqw+3R4nvqnvrfLcXZvwjvcIqHwX16rRTjL6cyC+nogqV0X3xjd55vy2tUj4huTz8upLau9ApA==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr39540362ljw.153.1558712130284;
        Fri, 24 May 2019 08:35:30 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id y14sm572316ljh.60.2019.05.24.08.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:35:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v3 4/8] clocksource/drivers/tegra: Replace readl/writel with relaxed versions
Date:   Fri, 24 May 2019 18:32:49 +0300
Message-Id: <20190524153253.28564-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524153253.28564-1-digetx@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The readl/writel functions are inserting memory barrier to ensure that
outstanding memory writes are completed, this results in L2 cache syncing
being done on Tegra20 and Tegra30 which isn't a very cheap operation.
Replace all readl/writel occurrences in the code with the relaxed versions
since there is no need for the memory-access syncing.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 739f83fdb318..55e9b3e1fbeb 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -61,9 +61,9 @@ static int tegra_timer_set_next_event(unsigned long cycles,
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PTV_EN |
-	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
-	       reg_base + TIMER_PTV);
+	writel_relaxed(TIMER_PTV_EN |
+		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
+		       reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -72,7 +72,7 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(0, reg_base + TIMER_PTV);
+	writel_relaxed(0, reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -81,9 +81,9 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PTV_EN | TIMER_PTV_PER |
-	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
-	       reg_base + TIMER_PTV);
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
+		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+		       reg_base + TIMER_PTV);
 
 	return 0;
 }
@@ -93,7 +93,7 @@ static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -103,12 +103,12 @@ static void tegra_timer_suspend(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
 }
 
 static void tegra_timer_resume(struct clock_event_device *evt)
 {
-	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 }
 
 static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
@@ -132,8 +132,8 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
-	writel(0, timer_of_base(to) + TIMER_PTV);
-	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+	writel_relaxed(0, timer_of_base(to) + TIMER_PTV);
+	writel_relaxed(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
 
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
@@ -157,13 +157,13 @@ static int tegra_timer_stop(unsigned int cpu)
 
 static u64 notrace tegra_read_sched_clock(void)
 {
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+	return readl_relaxed(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
 #ifdef CONFIG_ARM
 static unsigned long tegra_delay_timer_read_counter_long(void)
 {
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+	return readl_relaxed(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
 static struct delay_timer tegra_delay_timer = {
@@ -184,8 +184,9 @@ static struct timer_of suspend_rtc_to = {
  */
 static u64 tegra_rtc_read_ms(struct clocksource *cs)
 {
-	u32 ms = readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
-	u32 s = readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
+	void __iomem *reg_base = timer_of_base(&suspend_rtc_to);
+	u32 ms = readl_relaxed(reg_base + RTC_MILLISECONDS);
+	u32 s = readl_relaxed(reg_base + RTC_SHADOW_SECONDS);
 	return (u64)s * MSEC_PER_SEC + ms;
 }
 
@@ -270,7 +271,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		goto out;
 	}
 
-	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
-- 
2.21.0

