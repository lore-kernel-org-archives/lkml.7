Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA6CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A0E2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSIqv7sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfG3RlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:41:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39816 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3RlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:41:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so62843790ljh.6;
        Tue, 30 Jul 2019 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grLUxdosb4UfR11DOl+yWibactqQToHflORrwM4FNak=;
        b=tSIqv7snetyrULMsaKUF2ChW5E9SUEIs16EvBthhyGM7T7ODFVW3gS8eEkCbg8XLeC
         9Al+EMaKmgyQ10bUU64P+SVcaNPq5Jut4bRyjYPPZXgWkbYu5bGx36ghhfwLVlWTg+Pa
         qNzKVHDDZOzJe7wmRB3KPggVfgTuG5dH5vWSd6tLKlUU0mq0/dPcvlzmAKJzKJ3lsNnq
         hf5759A/YDYnFUVvnmpd8GJKog+obZdPxK31zt2Dq6a2cvSXKybH00rg2pzrZsylDLQM
         FsjtfYg+dMeOOTMhbFhzCtHeU0MiyEmxyuYrz+xx4QdO75a/MrH+F1LO9yFr5yYGlJ18
         5j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grLUxdosb4UfR11DOl+yWibactqQToHflORrwM4FNak=;
        b=onuolSUFRRxZL4adwdEH03EUAPennpu1un/GFNlbXjz5kUTTHtp2UHa96G/eukvMEd
         kyk4Q8U1Sanl1DeHo1jo6YykuvvxtLJUZH5nBASISL8BrPkTC/R6XU9NADFhrH2ZS3NE
         VNPHI7S6cvOSpuPM42bn8BGOlAyCIEeNqP970JlcVxt7kZBdOshJiP2PmPKNF3j+yS0/
         6cwi7GYuXtQkQUwZlnpSn2A014VvPWNerSZRJDlDOiyKXbeCwKmHfHmpPwwO4u5+w4is
         sdKVjS8hjnolnzbZHuTM/GCyiM8cCOwrrJHxWn8SvnaLNaKxt5BTeFSKOuUAY0tvKQQK
         ICUA==
X-Gm-Message-State: APjAAAWxPGA3fgEOJqkJk0LWRFGSqHgo2aebhkMtxt791Q5olCzEqCcq
        QDSddj5d9wtlkliYksbyfS0H2+jT
X-Google-Smtp-Source: APXvYqznqvIJwgJKC8HTDr44K2775kb8iGYAE0g60AOMLy6IfSsQOZCCo7vtjx53/UGOGL+cs4xAgQ==
X-Received: by 2002:a2e:93cc:: with SMTP id p12mr62833417ljh.11.1564508472098;
        Tue, 30 Jul 2019 10:41:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id g5sm13721177ljj.69.2019.07.30.10.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:41:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] soc/tegra: pmc: Query PCLK clock rate at probe time
Date:   Tue, 30 Jul 2019 20:40:19 +0300
Message-Id: <20190730174020.15878-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCLK clock is running off SCLK, which is a critical clock that is
very unlikely to randomly change its rate. It is possible to get a
lockup if kernel decides to enter LP2 cpuidle from a clk-notifier, which
happens occasionally in a case of Tegra30 EMC driver that waits for the
clk-change event in the clk-notify handler, because CCF's 'prepare' mutex
in kept locked and thus clk_get_rate() wants to sleep with interrupts
being disabled.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: Changed commit's message because I actually recalled what was the
    initial reason for the patch, since the problem reoccurred once again.

v2: Addressed review comments that were made by Jon Hunter to v1 by
    not moving the memory barrier, replacing one missed clk_get_rate()
    with pmc->rate, handling possible clk_get_rate() error on probe and
    slightly adjusting the commits message.

 drivers/soc/tegra/pmc.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 9f9c1c677cf4..aba3396b2e73 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1192,7 +1192,7 @@ static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
 		return err;
 
 	if (pmc->clk) {
-		rate = clk_get_rate(pmc->clk);
+		rate = pmc->rate;
 		if (!rate) {
 			dev_err(pmc->dev, "failed to get clock rate\n");
 			return -ENODEV;
@@ -1433,6 +1433,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 {
 	unsigned long long rate = 0;
+	u64 ticks;
 	u32 value;
 
 	switch (mode) {
@@ -1441,31 +1442,22 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 		break;
 
 	case TEGRA_SUSPEND_LP2:
-		rate = clk_get_rate(pmc->clk);
+		rate = pmc->rate;
 		break;
 
 	default:
 		break;
 	}
 
-	if (WARN_ON_ONCE(rate == 0))
-		rate = 100000000;
+	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
 
-	if (rate != pmc->rate) {
-		u64 ticks;
+	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
+	do_div(ticks, USEC_PER_SEC);
+	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
-		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
-
-		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
-		do_div(ticks, USEC_PER_SEC);
-		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
-
-		wmb();
-
-		pmc->rate = rate;
-	}
+	wmb();
 
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
@@ -2082,8 +2074,14 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		pmc->clk = NULL;
 	}
 
+	pmc->rate = clk_get_rate(pmc->clk);
 	pmc->dev = &pdev->dev;
 
+	if (!pmc->rate) {
+		dev_err(&pdev->dev, "failed to get pclk rate\n");
+		pmc->rate = 100000000;
+	}
+
 	tegra_pmc_init(pmc);
 
 	tegra_pmc_init_tsense_reset(pmc);
-- 
2.22.0

