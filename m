Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F714208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EOWd2Q34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbfGaAU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:20:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9291 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfGaAUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:20:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d40dedc0001>; Tue, 30 Jul 2019 17:20:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jul 2019 17:20:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jul 2019 17:20:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 00:20:32 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 00:20:32 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.107]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d40ded00004>; Tue, 30 Jul 2019 17:20:32 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 18/20] soc/tegra: pmc: Configure deep sleep control settings
Date:   Tue, 30 Jul 2019 17:20:22 -0700
Message-ID: <1564532424-10449-19-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564532424-10449-1-git-send-email-skomatineni@nvidia.com>
References: <1564532424-10449-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564532444; bh=e0L/CBaNsglm/ojFaoC8UfipD1BklMJFbKMEJWbcTJ0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EOWd2Q34m/iTKqzLnlDtbNR7KIEZSNrglqWcGmY6jmBIHkY+8tSJAv+wuOj11QZvF
         zleQBkNKSfEZ58Pg7Q0NoKQabCysp21io5TfknoZSt0AE6e7Y6y/OEB45z6emruliP
         kbEEbetQXfvZBh+PDajAANg3LEixMKDSFzapHsSQXvMZkHiIcqNL4e0ZVkQ6vroewf
         2cpiiGhEfzl9GrF6LVPcKjE6U51trxir5DpnARTwiY3U3P8joBwBTKJ7uSyRTnhvhQ
         vcxKCOMkPN8gBqouhy/jRcPEW8c1ltYk6/9tN5BVE5Q4Xv1Y7qaWMpGSvFu+rM0i2h
         Nwu4t2mdknm/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 and prior Tegra chips have deep sleep entry and wakeup related
timings which are platform specific that should be configured before
entering into deep sleep.

Below are the timing specific configurations for deep sleep entry and
wakeup.
- Core rail power-on stabilization timer
- OSC clock stabilization timer after SOC rail power is stabilized.
- Core power off time is the minimum wake delay to keep the system
  in deep sleep state irrespective of any quick wake event.

These values depends on the discharge time of regulators and turn OFF
time of the PMIC to allow the complete system to finish entering into
deep sleep state.

These values vary based on the platform design and are specified
through the device tree.

This patch has implementation to configure these timings which are must
to have for proper deep sleep and wakeup operations.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index e013ada7e4e9..9a78d8417367 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -88,6 +88,8 @@
 
 #define PMC_CPUPWRGOOD_TIMER		0xc8
 #define PMC_CPUPWROFF_TIMER		0xcc
+#define PMC_COREPWRGOOD_TIMER		0x3c
+#define PMC_COREPWROFF_TIMER		0xe0
 
 #define PMC_PWR_DET_VALUE		0xe4
 
@@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs tegra20_pmc_regs = {
 
 static void tegra20_pmc_init(struct tegra_pmc *pmc)
 {
-	u32 value;
+	u32 value, osc, pmu, off;
 
 	/* Always enable CPU power request */
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
@@ -2303,6 +2305,15 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_SYSCLK_OE;
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
+
+	osc = DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
+	pmu = DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
+	off = DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
+	if (osc && pmu)
+		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
+				 PMC_COREPWRGOOD_TIMER);
+	if (off)
+		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
 }
 
 static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
-- 
2.7.4

