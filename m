Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4740AC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3222387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9Yi+FYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbfGWCh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:37:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44853 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfGWCh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:37:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so39491850ljc.11;
        Mon, 22 Jul 2019 19:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBer8SYfa2cfphF8bWwChUCFMhN6h73MmPDTMlWFdCs=;
        b=F9Yi+FYQOltOihk6sx0xckZ00EmTMGFbQGO/YY/upRvycCYVfUH0yUdGkGfPUWNyVO
         BhlXgZ1FiAa64RoumZhmrRFEcinp21vFPErHxoVu5AFAzWefbdfiItskkPTLoczXsE1n
         ojiIdbdNGwnZKARqjcdp5VRN8Pay3i7XZjCGrtXXc6fpBaC7/Icwwer+xdBHVCix9PE7
         0vUxO61OT3jmKK1GUYccURBfWLfK1vVIY4ptF7TeEC+qOQgtXHy9JuDSkCMXGEuY3rhS
         dA6jioaeGhV02KrJard5Vkau4nJxF7ZnSiRujSfnJA3sXeC8U8aVKj4s3K39NiSukVEW
         HJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBer8SYfa2cfphF8bWwChUCFMhN6h73MmPDTMlWFdCs=;
        b=AE5aA2FGS4SsTz8jiSz+8kGAxoHefeICAbKj4dGQMFAV24p8XcshuzDCKdadcJI1ji
         w2tjtLD/fd+RF+G1C6tLA6kHrOE4CnnfEMJBvMn9oIprdDeqDqyMRoPhcdMvoINbBtQ4
         WZxcUKcA5aCVO7YzM2cyoMZf89OKMEearoJnc4szbGolLIEpFZKNGe1kzMJ6eqClXSws
         GW0WQmnq4RBF64MlYQChW4m7uulr7SnjvuEHkq6lxrr5jeEQE6OpT1nFu2QamgU5WpFn
         VlufxWSa+TODimUw/bQC7DnceKCECFZHfXvMZtFVmDQPsfp3BJk7h27BIB6P2efDkOoE
         Ktng==
X-Gm-Message-State: APjAAAXW0P3ayoVJVj3yArJY3+tRH+J6AslkM3ZwGal86mgh2Ma+wBku
        8NlrDgrb4X4Y4Cru1FvHysk=
X-Google-Smtp-Source: APXvYqx3Dd2bsIzyPqSkamLPCWH9K6ohrlIvIenL6oxTw+3H63NYN3uePv+K+lrtUbRbrm/owhFjXw==
X-Received: by 2002:a2e:824f:: with SMTP id j15mr38875388ljh.117.1563849444442;
        Mon, 22 Jul 2019 19:37:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r17sm7832425ljc.85.2019.07.22.19.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:37:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] soc/tegra: pmc: Query PCLK clock rate at probe time
Date:   Tue, 23 Jul 2019 05:35:10 +0300
Message-Id: <20190723023511.24542-1-digetx@gmail.com>
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
suspend/cpuidle entering.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

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

