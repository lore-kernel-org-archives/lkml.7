Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26485C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9DF21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t579sdMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfFZOrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36044 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfFZOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so2413201wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wdZ7FecC0TRurfVLmuWoSlgUMuXVwscdG5MO2xNw/Ic=;
        b=t579sdMYVNudZHexTNI4IPGizIkbNQKDA+IU2XssndcB2dsFhiFL5x++LJga0MG6Sk
         bsdtLaklcZAatUYpwsAE2a0YTEdMKZcUr0ory80k+eeXAkEzdbcaCAGICSKfetzz8T5T
         rIopJiNV9agiYtFiTaVsHeUyN228aCUTOhdoTGfxhuICf76LhQiVGdNhPdzb7ip18Fw6
         1X5BSpAT7GbyKLNq4cqIx9RUIK1Y3kuIFDT3xg7xsAiP+0WXxg1hXueXysA3a5ZhKw1s
         EPQNllxcS15xjKgqCUYhtRAR1lgV6keRrWbS2wYDlBXR+tfrOrsQIyTscBmTrOmb/IDG
         qrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdZ7FecC0TRurfVLmuWoSlgUMuXVwscdG5MO2xNw/Ic=;
        b=bma6YZJuLOZaGKKjWqCc+rQM7ipfwHPgFl7m92/6SOQVZCD3VsW+o4++x88epCf95o
         e1M7jQNYeWFDarbiHSffY6YU8yuxfufOBlWOchtm19sYAmaIYpO0vEJlOrLASfwHcSy3
         OlqX3KZZUvJCbdPl3i+qvoPaVBbjhcOfqnPKO5Y2hfYvpw84bkulgoJi9Xr8J1R0Q+6a
         jBUs8cJEuSLg0SdEiiAaBq7W5UBjigEeAiXeIesk3QanX2M4hHDl+WnxRwKJ7MraK+89
         rjXTksdnH0mLAQHCMVvgyFIgDfIQJjj5bBxtG9s8NrHwulvefOKElAm8tivwa06N2p1F
         92LA==
X-Gm-Message-State: APjAAAVpYqK50YQ6SaGLWQzm6YSZ/lvC+eXUFANyB5pmu+Yju3jlCEkT
        suV7f7g3qJnEAGqaOVPuhYMUsA==
X-Google-Smtp-Source: APXvYqyy1OV9Yz61PFs8lU0X/N15FLwXCQNvvHOwhD+YKPKxiC3fsLnBv3dbWUcvK59w05Qw6eoEeg==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr2968190wmf.45.1561560451162;
        Wed, 26 Jun 2019 07:47:31 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 12/25] clocksource/drivers/tegra: Lower clocksource rating for some Tegra's
Date:   Wed, 26 Jun 2019 16:46:38 +0200
Message-Id: <20190626144651.16742-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Arch-timer is more preferable for a range of Tegra SoC generations as
it has higher precision and is not affect by any kind of problems.

Pointed-out-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra20.c | 30 +++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 6a3704142f31..ed1454000ea9 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -109,7 +109,6 @@ static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
 
 	.clkevt = {
 		.name = "tegra_timer",
-		.rating = 460,
 		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
 		.set_next_event = tegra_timer_set_next_event,
 		.set_state_shutdown = tegra_timer_shutdown,
@@ -219,7 +218,8 @@ static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
 	return TIMER10_IRQ_IDX + cpu;
 }
 
-static int __init tegra_init_timer(struct device_node *np, bool tegra20)
+static int __init tegra_init_timer(struct device_node *np, bool tegra20,
+				   int rating)
 {
 	struct timer_of *to;
 	int cpu, ret;
@@ -282,6 +282,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 
 		cpu_to = per_cpu_ptr(&tegra_to, cpu);
 		cpu_to->of_base.base = timer_reg_base + base;
+		cpu_to->clkevt.rating = rating;
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->clkevt.irq = irq_of_parse_and_map(np, idx);
 		if (!cpu_to->clkevt.irq) {
@@ -341,13 +342,34 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 
 static int __init tegra210_init_timer(struct device_node *np)
 {
-	return tegra_init_timer(np, false);
+	/*
+	 * Arch-timer can't survive across power cycle of CPU core and
+	 * after CPUPORESET signal due to a system design shortcoming,
+	 * hence tegra-timer is more preferable on Tegra210.
+	 */
+	return tegra_init_timer(np, false, 460);
 }
 TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_init_timer);
 
 static int __init tegra20_init_timer(struct device_node *np)
 {
-	return tegra_init_timer(np, true);
+	int rating;
+
+	/*
+	 * Tegra20 and Tegra30 have Cortex A9 CPU that has a TWD timer,
+	 * that timer runs off the CPU clock and hence is subjected to
+	 * a jitter caused by DVFS clock rate changes. Tegra-timer is
+	 * more preferable for older Tegra's, while later SoC generations
+	 * have arch-timer as a main per-CPU timer and it is not affected
+	 * by DVFS changes.
+	 */
+	if (of_machine_is_compatible("nvidia,tegra20") ||
+	    of_machine_is_compatible("nvidia,tegra30"))
+		rating = 460;
+	else
+		rating = 330;
+
+	return tegra_init_timer(np, true, rating);
 }
 TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 
-- 
2.17.1

