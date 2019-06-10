Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D579BC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB54220820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBflaKLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfFJQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43331 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387525AbfFJQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so15396215edb.10;
        Mon, 10 Jun 2019 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQnyKe9ECwU+79r9nTPxAWiJwKgmuyzLfRVX0pzyA6Y=;
        b=BBflaKLdER/Co2hU+NZhrvD9hyuSSHM9XfeXGCHFIQ035tM4VMWBWVGBcTFk0kpd0y
         YsbIse09/pnujAeno7agBxViKXPwUZymppLSG0IkCr+11tx+ZMWSckuLj/+15LMPDMgx
         +IUvi8o+UnbnwkfXFWc+n5EHl+Ei6zO3J8V2Xi4VtH3eK4PK3cDTqrHmzwgAJk/OYn4C
         CR0S4tx4jd9dpF+8FYtZit8sG01B5WK8AQ2xYKI3b+Q2QlOPFUAWnNxKa8iXtywHzLxZ
         czN2o6vhj3ziPKINhirCX5Ho4pZY4URTE/Fw1io6brTBkYu8Zc4v+/ULWFT/gd71D0Je
         fC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQnyKe9ECwU+79r9nTPxAWiJwKgmuyzLfRVX0pzyA6Y=;
        b=G5XHcjlqaA7aHWMqv0YxSyjEPC/Fp8RH00+XSbYJnoPFkJW8lGQiFgmEvdAyfX7nnO
         UHojPZ9RMGThB3pmahUU1MkM6M2w6MMg8fNYjbPEH/wRq37UvyGVbEvNO4IgegpHOIig
         WCHHgaxhD/Sy4v6jHWggWd38fswWk1JSAUxZZcxON0fng73MZPCUB6S2y3hoiqftEw3a
         MavNiMs4vnAu3SCeoExfeB8SEl87hut7/23OkaviDhEP+bMaexFPTtFmvGiZwMXn7XOU
         tgC6VpioWPiohao/MCaSOs3eod8M20CVRL3/RpYLOm4cQFu9K9R/qbHornsChgh8cPyO
         DTqA==
X-Gm-Message-State: APjAAAV7hq5AQWGqmLYv1VaZsvFlHzxguBCt1yEtdc0+BcksAbSt2s8Y
        KfBavCsh/AhLJ7Tp+6GQwaDri6CL
X-Google-Smtp-Source: APXvYqwTOmAklCiujNmzcdAERQ9mEfNOFom+0kG/WG5cKkRdbri+/GDuIbjUT7nEMNFwtsfME96Eug==
X-Received: by 2002:a17:906:9705:: with SMTP id k5mr26860459ejx.5.1560185302811;
        Mon, 10 Jun 2019 09:48:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id a9sm3075799edc.44.2019.06.10.09.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:48:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
Date:   Mon, 10 Jun 2019 19:43:56 +0300
Message-Id: <20190610164400.11830-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610164400.11830-1-digetx@gmail.com>
References: <20190610164400.11830-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was left unnoticed by accident, which means that the code could be
cleaned up a tad more.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 42 ++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 830c66e2d927..810b4e7435cf 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -216,6 +216,19 @@ static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
 	return TIMER10_IRQ_IDX + cpu;
 }
 
+static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
+						 bool tegra20)
+{
+	/*
+	 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
+	 * parent clock.
+	 */
+	if (tegra20)
+		return 1000000;
+
+	return timer_of_rate(to);
+}
+
 static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 				   int rating)
 {
@@ -268,32 +281,27 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
+		unsigned long rate = tegra_rate_for_timer(to, tegra20);
 		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
 		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
+		unsigned int irq = irq_of_parse_and_map(np, idx);
 
-		/*
-		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
-		 * parent clock.
-		 */
-		if (tegra20)
-			cpu_to->of_clk.rate = 1000000;
-		else
-			cpu_to->of_clk.rate = timer_of_rate(to);
-
-		cpu_to = per_cpu_ptr(&tegra_to, cpu);
-		cpu_to->of_base.base = timer_reg_base + base;
-		cpu_to->clkevt.rating = rating;
-		cpu_to->clkevt.cpumask = cpumask_of(cpu);
-		cpu_to->clkevt.irq = irq_of_parse_and_map(np, idx);
-		if (!cpu_to->clkevt.irq) {
+		if (!irq) {
 			pr_err("failed to map irq for cpu%d\n", cpu);
 			ret = -EINVAL;
 			goto out_irq;
 		}
 
+		cpu_to->clkevt.irq = irq;
+		cpu_to->clkevt.rating = rating;
+		cpu_to->clkevt.cpumask = cpumask_of(cpu);
+		cpu_to->of_base.base = timer_reg_base + base;
+		cpu_to->of_clk.rate = rate;
+
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
-		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
-				  IRQF_TIMER | IRQF_NOBALANCING,
+
+		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr, flags,
 				  cpu_to->clkevt.name, &cpu_to->clkevt);
 		if (ret) {
 			pr_err("failed to set up irq for cpu%d: %d\n",
-- 
2.21.0

