Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835DFFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5D320656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215271;
	bh=N175i1gxQlKG58kZd35eoA5nSyc+JAtK9XTWQzqa5sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W9Hk0CJC73yp2cBVOSs3EsTgfcBypmj0Lf1MxSJjhvh+Ctywc4bT1qJa+NShBTpsc
	 ZLAJvf/E6lYQhS1BOeEbDppJ7VD/Hyh8jXnDtcwKgygaEKISjauBtBeGrSNIU3Lopn
	 ehqKnaZguP3qdCFxBHS7oiH3FumZwtVSPlGWJxSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391957AbfKHMOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732193AbfKHLiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2414F21D7F;
        Fri,  8 Nov 2019 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213086;
        bh=N175i1gxQlKG58kZd35eoA5nSyc+JAtK9XTWQzqa5sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev8lATPDDjx2sqIZJ8bZ8k0SAZy0mNku4nijLApvdEnr7jl+pz0kujoVOanyNKnvS
         gGUPg+KrMKxf8U5otYAtrctCjinltFj60S2yN4MVlKwEw1dpNPaUJa6TKDUCWFao3K
         JLNnBREbORo4VqNkyb1xXsbW4wvZmBYIgrYlbkEU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 012/205] soc/tegra: pmc: Fix pad voltage configuration for Tegra186
Date:   Fri,  8 Nov 2019 06:34:39 -0500
Message-Id: <20191108113752.12502-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aapo Vienamo <avienamo@nvidia.com>

[ Upstream commit 13136a47a061c01c91df78b37f7708dd5ce7035f ]

Implement support for the PMC_IMPL_E_33V_PWR register which replaces
PMC_PWR_DET register interface of the SoC generations preceding
Tegra186. Also add the voltage bit offsets to the tegra186_io_pads[]
table and the AO_HV pad.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/pmc.c | 55 +++++++++++++++++++++++++++++------------
 include/soc/tegra/pmc.h |  1 +
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 4b452f36f0547..f17a678154047 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -65,6 +65,8 @@
 
 #define PWRGATE_STATUS			0x38
 
+#define PMC_IMPL_E_33V_PWR		0x40
+
 #define PMC_PWR_DET			0x48
 
 #define PMC_SCRATCH0_MODE_RECOVERY	BIT(31)
@@ -154,6 +156,7 @@ struct tegra_pmc_soc {
 	bool has_tsense_reset;
 	bool has_gpu_clamps;
 	bool needs_mbist_war;
+	bool has_impl_33v_pwr;
 
 	const struct tegra_io_pad_soc *io_pads;
 	unsigned int num_io_pads;
@@ -1067,20 +1070,31 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 
 	mutex_lock(&pmc->powergates_lock);
 
-	/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
-	value = tegra_pmc_readl(PMC_PWR_DET);
-	value |= BIT(pad->voltage);
-	tegra_pmc_writel(value, PMC_PWR_DET);
+	if (pmc->soc->has_impl_33v_pwr) {
+		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
 
-	/* update I/O voltage */
-	value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+		if (voltage == TEGRA_IO_PAD_1800000UV)
+			value &= ~BIT(pad->voltage);
+		else
+			value |= BIT(pad->voltage);
 
-	if (voltage == TEGRA_IO_PAD_1800000UV)
-		value &= ~BIT(pad->voltage);
-	else
+		tegra_pmc_writel(value, PMC_IMPL_E_33V_PWR);
+	} else {
+		/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
+		value = tegra_pmc_readl(PMC_PWR_DET);
 		value |= BIT(pad->voltage);
+		tegra_pmc_writel(value, PMC_PWR_DET);
+
+		/* update I/O voltage */
+		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
 
-	tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
+		if (voltage == TEGRA_IO_PAD_1800000UV)
+			value &= ~BIT(pad->voltage);
+		else
+			value |= BIT(pad->voltage);
+
+		tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
+	}
 
 	mutex_unlock(&pmc->powergates_lock);
 
@@ -1102,7 +1116,10 @@ int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 	if (pad->voltage == UINT_MAX)
 		return -ENOTSUPP;
 
-	value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+	if (pmc->soc->has_impl_33v_pwr)
+		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
+	else
+		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
 
 	if ((value & BIT(pad->voltage)) == 0)
 		return TEGRA_IO_PAD_1800000UV;
@@ -1561,6 +1578,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.cpu_powergates = tegra30_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.regs = &tegra20_pmc_regs,
@@ -1603,6 +1621,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.cpu_powergates = tegra114_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.regs = &tegra20_pmc_regs,
@@ -1683,6 +1702,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.cpu_powergates = tegra124_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
 	.io_pads = tegra124_io_pads,
 	.regs = &tegra20_pmc_regs,
@@ -1772,6 +1792,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.cpu_powergates = tegra210_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_impl_33v_pwr = false,
 	.needs_mbist_war = true,
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
@@ -1800,7 +1821,7 @@ static const struct tegra_io_pad_soc tegra186_io_pads[] = {
 	{ .id = TEGRA_IO_PAD_HDMI_DP0, .dpd = 28, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_HDMI_DP1, .dpd = 29, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = 5 },
 	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 36, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_CAM, .dpd = 38, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 40, .voltage = UINT_MAX },
@@ -1812,12 +1833,13 @@ static const struct tegra_io_pad_soc tegra186_io_pads[] = {
 	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 46, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_SPI, .dpd = 47, .voltage = UINT_MAX },
 	{ .id = TEGRA_IO_PAD_UFS, .dpd = 49, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = 2 },
 	{ .id = TEGRA_IO_PAD_EDP, .dpd = 53, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = 4 },
+	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = 6 },
 	{ .id = TEGRA_IO_PAD_CONN, .dpd = 60, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = UINT_MAX },
+	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 1 },
+	{ .id = TEGRA_IO_PAD_AO_HV, .dpd = UINT_MAX, .voltage = 0 },
 };
 
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
@@ -1870,6 +1892,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.cpu_powergates = NULL,
 	.has_tsense_reset = false,
 	.has_gpu_clamps = false,
+	.has_impl_33v_pwr = true,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
 	.regs = &tegra186_pmc_regs,
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index c32bf91c23e6f..445aa66514e90 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -134,6 +134,7 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_USB2,
 	TEGRA_IO_PAD_USB3,
 	TEGRA_IO_PAD_USB_BIAS,
+	TEGRA_IO_PAD_AO_HV,
 };
 
 /* deprecated, use TEGRA_IO_PAD_{HDMI,LVDS} instead */
-- 
2.20.1

