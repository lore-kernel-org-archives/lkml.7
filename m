Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44364C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2C621726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxmMYVPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfFZOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:48:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39277 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfFZOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so2405117wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IAtyPcsTx9RzQZd9Z8HcSfwjywt5ILpbuYeShXpAGo=;
        b=DxmMYVPxorhNSwCea1YEH3jLyk7q+WYZ272bx3DX92dbN34lb4ZaCbJVBPbx6UP9ry
         lPqdhVvv6Lu+idmdX+4KTIVPn/oUpdhdm0BOyz18hrY8vM3NmSrvPrraDlX9JuEOGFwn
         fxK/mAN/wJTSlAtJ/HXVqeVgbjN6zzHSMSz+Wd6OwBoul9r5M05mJOXKYGKPDgELs6T8
         KL3UG+ajbmt8Bsa0lE39vWB4j+ldDQSWK5wwSazT7wPZ82FjjA1yMUvZX4Vq27NePpBH
         nWdPRfQ1s4gQPDz1SSyRQRSQ5Lzx/56rQ05HOsA9KYJGxYO7Brl8PGKvPMY/isD7tVr8
         g2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IAtyPcsTx9RzQZd9Z8HcSfwjywt5ILpbuYeShXpAGo=;
        b=Hgi8XBKn1F9rCm1Z3VabnKu6CqLfI4C4f4sH3t1u0XemTgbGLw5LK36uGqKwmQspXo
         IBEyiN+1B+yyVxaRdx2rGNEuC4iYwUANMz52ai0iPmajJFGWRG5wAH/pxHwvZ0A+sAF0
         71Fn6ITBKYqATqivSLof+f4SLpULDe1HdyxLGTGsKEYfIqe7ZdD3s4dHKNLxVDG6R4Xk
         D1FIT36+67LxJYRm2J6GebEkO3wpbJQ1P22GKVX+YdsIudrICL/bs8OpC1IxyKnsiZOP
         YrQTzYw2/6LEqurDLsmB6WmlHwaTDPx0Dkzp8Y2/Wa2DGt+tJq+tI0HfanEBLcxz46ln
         Cfng==
X-Gm-Message-State: APjAAAWLSXzFgVRNiuNRIBeGwjacvr/pKiOg0Fhor7xtJVwJtrJ1aNaB
        ndSqx5/XvnbkSt/dhnNOPubrJg==
X-Google-Smtp-Source: APXvYqyNUdSNruHeIloQDC0KHi0G/o6V9M2IYzlQ9dG2v7llKyzHCqfJ6mQZb2Tj/42yd3EExmmzTg==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr2805661wmh.134.1561560462620;
        Wed, 26 Jun 2019 07:47:42 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 18/25] clocksource/drivers/tegra: Set and use timer's period
Date:   Wed, 26 Jun 2019 16:46:44 +0200
Message-Id: <20190626144651.16742-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

The of_clk structure has a period field that is set up initially by
timer_of_clk_init(), that period value need to be adjusted for a case of
TIMER1-9 that are running at a fixed rate that doesn't match the clock's
rate. Note that the period value is currently used only by some of the
clocksource drivers internally and hence this is just a minor cleanup
change that doesn't fix anything.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index f172a57cc5fe..41257f89a216 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -73,9 +73,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+	unsigned long period = timer_of_period(to_timer_of(evt));
 
-	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
-		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
 		       reg_base + TIMER_PTV);
 
 	return 0;
@@ -299,6 +299,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		cpu_to->clkevt.rating = rating;
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->of_base.base = timer_reg_base + base;
+		cpu_to->of_clk.period = rate / HZ;
 		cpu_to->of_clk.rate = rate;
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
-- 
2.17.1

