Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB158C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E3F222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Cu/4rNAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKSGvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:51:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10804 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfKSGvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:51:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390da0001>; Mon, 18 Nov 2019 22:51:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:51:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:51:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:51:03 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:51:03 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390d50002>; Mon, 18 Nov 2019 22:51:03 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 08/17] clk: tegra: Use Tegra PMC helper function for PLLE IDDQ
Date:   Mon, 18 Nov 2019 22:50:25 -0800
Message-ID: <1574146234-3871-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146266; bh=2gZW9nYdzkXkyTc5bBk/WveG4zN9ZQjJdfxaExNTDSc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Cu/4rNAGo+PfmjejTL4sGQT42og6qZzdi+71bYE393qKBBvw5BM1AgpZebJgQ7V8E
         4kLCONQPkjhFLglkh0vaTwH3QJHpRnsYhajwuaf6/tgdGrw8aBZcA+gUoYCHTlU2Sj
         1ta5ylz4etZ5vy99B7h8JXxurplN3Ogp980hcZZrWx2OBkZfUVUSRhDYG0Oma+HHTf
         OItDek0dyABqpJgfeeTNhogM8oG+YzORXKCnOyvX+t4KtNI1d7ZhElI/Tw7fMApStu
         UjEakwhPrawPH5Ikli8RJhWcMlh1RkMOhSoKDoMNhv9pH6rSKi+W5vHPPXRD3YVwTJ
         QN7SbbzsGBemA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has PLLE IDDQ programming to bring the PLLE pads out of
DPD idle state through software by overriding the hardware control.

Currently Tegra clock driver programs Tegra PMC registers directly
for enabling software override and to bring PLLE pads out of DPD
idle state. With this, when Tegra PMC is in secure mode, any direct
PMC register access from non-secure world will not go through.

This patch updates Tegra clock driver to use Tegra PMC helper function
to clear PLLE IDDQ through software control that does PMC programming
using tegra_pmc_writel and tegra_pmc_readl which supports both secure
mode and non-secure mode PMC access.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index f3c0a637174f..4ae9e282e7be 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -143,10 +143,6 @@
 #define PLLCX_MISC2_DEFAULT 0x30211200
 #define PLLCX_MISC3_DEFAULT 0x200
 
-#define PMC_SATA_PWRGT 0x1ac
-#define PMC_SATA_PWRGT_PLLE_IDDQ_VALUE BIT(5)
-#define PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL BIT(4)
-
 #define PLLSS_MISC_KCP		0
 #define PLLSS_MISC_KVCO		0
 #define PLLSS_MISC_SETUP	0
@@ -863,24 +859,11 @@ static int clk_plle_training(struct tegra_clk_pll *pll)
 	u32 val;
 	unsigned long timeout;
 
-	if (!pll->pmc)
-		return -ENOSYS;
-
 	/*
 	 * PLLE is already disabled, and setup cleared;
 	 * create falling edge on PLLE IDDQ input.
 	 */
-	val = readl(pll->pmc + PMC_SATA_PWRGT);
-	val |= PMC_SATA_PWRGT_PLLE_IDDQ_VALUE;
-	writel(val, pll->pmc + PMC_SATA_PWRGT);
-
-	val = readl(pll->pmc + PMC_SATA_PWRGT);
-	val |= PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL;
-	writel(val, pll->pmc + PMC_SATA_PWRGT);
-
-	val = readl(pll->pmc + PMC_SATA_PWRGT);
-	val &= ~PMC_SATA_PWRGT_PLLE_IDDQ_VALUE;
-	writel(val, pll->pmc + PMC_SATA_PWRGT);
+	tegra_pmc_clear_plle_iddq();
 
 	val = pll_readl_misc(pll);
 
-- 
2.7.4

