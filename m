Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5394C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82325206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG2qOZ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfFIT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:28:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33326 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfFIT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:28:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so108743ljg.0;
        Sun, 09 Jun 2019 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sj3CdrTusp0vzzIcEyR2aoS6rw9ut0BwVaeKBvqb17A=;
        b=eG2qOZ3bDVdovkwRoeqds9WtLI2BHXbqVWSZqzSCrHD3uF0KAPoYOK5lytzixgXpSO
         YuyFsl3cBLLIz0LcssVbPo7tEBXdVECwWGzL59jHGy9lL3tvNaFfPfGA2yo6EzFqqCoH
         WpFp5F4vXJIEkL9Up7CtrMLA9s8Nvxnw9XGxGWJZpZJM4XTVRz8IiTRf5BQ7Ml357BBR
         UZ4BFPcG1PKli47Xvv3MrJ32DCqxcZzkI1ljNU2AkOI80zjpYLgQVFgdaUmgOgOobyzz
         YZjwNBZJJccKVdWfioIbSe/N/7cLD285uIFm30age7ScYAdCgtWH+/efmup6q8WumuS9
         i3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sj3CdrTusp0vzzIcEyR2aoS6rw9ut0BwVaeKBvqb17A=;
        b=XJL7CB/rKowt29Fl9QR5lQ14TW2BjmzZHab/jGZfWQObkRo8gDPJGsd4+KF4QraPGu
         y68/Z4UBVOye0+n9Oc3I7jxFUv6NkuhpbxIJhdrPtzARk/xEYv+l6u379zB0it7eVFVt
         vkudcrhn+pVCUkeHnSuMThrqH+OlZ/WGlYKdyKWnu7hLkTiqVhxSLgmgkfqjGo+ybBEY
         H8XwMGbhldLQyyXX81A36K58iKAD/5Z5ekNjBqKGPOy4ZFFt6l+bsEfi/PkIuPWW07Cq
         ipw+lXWcbBPu8ivywMTMVOIQILlPRzsUlV9AXXpoQaw/LU7DhIbsD0evvk3e+k9rLIMO
         g0Mw==
X-Gm-Message-State: APjAAAUuhoIXopHhVssc5w/Ae0OgiXVpC0avJsMHJOt/g2EFeogN65AH
        /8tQbGs01biIw4qqbts3KM0=
X-Google-Smtp-Source: APXvYqz3Cg5V5SkpFd+z/lnRMxzrdW9To7z8gQ47rDlWuznbL8DgEeDr8sVdcl079tCDKt7w2tAgQA==
X-Received: by 2002:a2e:9158:: with SMTP id q24mr8120577ljg.119.1560108532837;
        Sun, 09 Jun 2019 12:28:52 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id e26sm1531685ljl.33.2019.06.09.12.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:28:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
Date:   Sun,  9 Jun 2019 22:27:28 +0300
Message-Id: <20190609192730.29459-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609192730.29459-1-digetx@gmail.com>
References: <20190609192730.29459-1-digetx@gmail.com>
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
 drivers/clocksource/timer-tegra.c | 40 +++++++++++++++++++------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 9406855781ff..6da169de47f9 100644
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
+	return to->of_clk.rate;
+}
+
 static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 				   int rating)
 {
@@ -268,30 +281,27 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
+		unsigned long rate = tegra_rate_for_timer(&tegra_to, tegra20);
 		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
 		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
+		unsigned int irq = irq_of_parse_and_map(np, idx);
 
-		/*
-		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
-		 * parent clock.
-		 */
-		if (tegra20)
-			cpu_to->of_clk.rate = 1000000;
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

