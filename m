Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231ECC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21E820684
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLXkljUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGGXI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 19:08:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45458 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfGGXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 19:08:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so16258119qtr.12;
        Sun, 07 Jul 2019 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbpUkQHY6Ip6i0r/7exLkfwdi2NsHJU1OTryULkaYts=;
        b=BLXkljUpTEmVUt/VutqfDgk7OUIUZHw4jD7ozcWcd0aG5U9eACZHI0xROyMrLDDVbP
         lPCRyQUCYZbgbak1tDOMp1w+n+nKfiS4ejsF58wRqp+kKvGdS53GTElovDS3z87RNrcM
         4MWVl1SApfvuGHE3YBl5167xzYJmlQ/1v52brGxglNc5N5a3Pbt3Gyd6XEibSF9N+9VP
         O2qBsBeco059nglx5DRsFqrBLDdRWlEPT3nDzP2xTMhsXJQeaeCOdcJVg+v7CTmKxDt7
         TjdLZ51CuksE6Rr0GZtCx9UQFcD8mcxo14AZy0TwM/aMZdOOV26xG9LTjtokjrXzT4uu
         oTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbpUkQHY6Ip6i0r/7exLkfwdi2NsHJU1OTryULkaYts=;
        b=UA9TnxOPdgOSb/wmXe0yA5u69CbAXLqLQt4fGA9ZBFn1vQyg/XR0WSxFjien2zAkbo
         9PWPr8Jf2dI9w8ISkTkBH1pbSPITKmrcA3Jili2W8jA3Foj2kE99B3fDsUcozjOeVRXz
         0/dIIUt+qlhLoQXFhHhoOp8WZKJ2yr0/vZ13vWOsk4jAG6XDCHwLt/wI4AmLJrfmHVmL
         K3RYgo5arNBYkTf+OqYlMoMhiotE/XkP7O9onV/kvp0tevuib9i3vtMn/VycNEs665MM
         4sS8ySD3w7VkTad3BqrL25cmge/f5E0DQUSmDofLJvjmAn9DVs/9e1kXiEiWGn23kMXm
         i9wA==
X-Gm-Message-State: APjAAAUvX97NdI2FoGpQj0t7VTlfH15PtKZ+WXrwyWdRL7ianpMzNfo1
        I2juQt5H1xL7xtI58f6LOcI=
X-Google-Smtp-Source: APXvYqyeRUVYT74pZ3WFecZohbxQ17Dq/xPT33eFQmBbi4L2sDyEbjhDijETTfJg6g/NKwAe3e7/4g==
X-Received: by 2002:a0c:d14e:: with SMTP id c14mr12399534qvh.206.1562540937735;
        Sun, 07 Jul 2019 16:08:57 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id k74sm7434319qke.53.2019.07.07.16.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:08:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] soc/tegra: pmc: Query PCLK clock rate at probe time
Date:   Mon,  8 Jul 2019 02:08:43 +0300
Message-Id: <20190707230843.11224-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCLK clock is running off SCLK, which is a critical clock that is
very unlikely to randomly change its rate. It's also a bit clumsy (and
apparently incorrect) to query the clock's rate with interrupts being
disabled because clk_get_rate() takes a mutex and that's the case during
suspend/cpuidle entering. Lastly, it's better to always fully reprogram
PMC state because it's not obvious whether it could be changed after SC7.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 9f9c1c677cf4..532e0ada012b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1433,6 +1433,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 {
 	unsigned long long rate = 0;
+	u64 ticks;
 	u32 value;
 
 	switch (mode) {
@@ -1441,7 +1442,7 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 		break;
 
 	case TEGRA_SUSPEND_LP2:
-		rate = clk_get_rate(pmc->clk);
+		rate = pmc->rate;
 		break;
 
 	default:
@@ -1451,26 +1452,20 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 	if (WARN_ON_ONCE(rate == 0))
 		rate = 100000000;
 
-	if (rate != pmc->rate) {
-		u64 ticks;
-
-		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
-
-		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
+	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
 
-		wmb();
-
-		pmc->rate = rate;
-	}
+	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
 	value |= PMC_CNTRL_CPU_PWRREQ_OE;
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
+
+	wmb();
 }
 #endif
 
@@ -2082,6 +2077,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		pmc->clk = NULL;
 	}
 
+	pmc->rate = clk_get_rate(pmc->clk);
 	pmc->dev = &pdev->dev;
 
 	tegra_pmc_init(pmc);
-- 
2.22.0

