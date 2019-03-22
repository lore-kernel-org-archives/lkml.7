Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C046C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54FD218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kTOnW31I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCVI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:58:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60478 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfCVI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:58:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2M8wGkD027062
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553245096;
        bh=fTjnIsuQ8hpmovpcLwfvsAPy/Ud+Kro/q2XdWGbTPcI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kTOnW31IOSknDw7wMiL+0sXeLrSzOnLqfgOSAbqhXevTt4aEGuUZgUACq9vsrP5At
         LS7E+kfc0YUmxYGTIFfdOcObRJgplzDsPSsTEbISODN6UdeG++iTesiy73ysTUJKxD
         gTlFPDE30agGFbQltMXZov0503860kN87f4wZd/k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2M8wGWZ104339
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 03:58:14 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 03:58:14 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2M8w9b8016866;
        Fri, 22 Mar 2019 03:58:13 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/4] phy: ti-pipe3: improve DPLL stability for SATA & USB
Date:   Fri, 22 Mar 2019 10:58:05 +0200
Message-ID: <20190322085807.30216-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322085807.30216-1-rogerq@ti.com>
References: <20190322085807.30216-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For increased DPLL stability use the settings recommended in
the TRM [1] for PHY_RX registers for SATA and USB.

For SATA we need to use spread spectrum settings even
though we don't have spread spectrum enabled. The
suggested non-spread spectrum settings don't work.

[1] DRA75x, DRA74x TRM - http://www.ti.com/lit/ug/sprui30f/sprui30f.pdf

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 215 +++++++++++++++++++++++++++-------
 1 file changed, 173 insertions(+), 42 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 0913dd55d82a..cdc994f153b2 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -68,39 +68,61 @@
 #define PCIE_PCS_MASK			0xFF0000
 #define PCIE_PCS_DELAY_COUNT_SHIFT	0x10
 
-#define PCIEPHYRX_ANA_PROGRAMMABILITY	0x0000000C
+#define PIPE3_PHY_RX_ANA_PROGRAMMABILITY	0x0000000C
 #define INTERFACE_MASK			GENMASK(31, 27)
 #define INTERFACE_SHIFT			27
+#define INTERFACE_MODE_USBSS		BIT(4)
+#define INTERFACE_MODE_SATA_1P5		BIT(3)
+#define INTERFACE_MODE_SATA_3P0		BIT(2)
+#define INTERFACE_MODE_PCIE		BIT(0)
+
 #define LOSD_MASK			GENMASK(17, 14)
 #define LOSD_SHIFT			14
 #define MEM_PLLDIV			GENMASK(6, 5)
 
-#define PCIEPHYRX_TRIM			0x0000001C
-#define MEM_DLL_TRIM_SEL		GENMASK(31, 30)
+#define PIPE3_PHY_RX_TRIM		0x0000001C
+#define MEM_DLL_TRIM_SEL_MASK		GENMASK(31, 30)
 #define MEM_DLL_TRIM_SHIFT		30
 
-#define PCIEPHYRX_DLL			0x00000024
-#define MEM_DLL_PHINT_RATE		GENMASK(31, 30)
+#define PIPE3_PHY_RX_DLL		0x00000024
+#define MEM_DLL_PHINT_RATE_MASK		GENMASK(31, 30)
+#define MEM_DLL_PHINT_RATE_SHIFT	30
 
-#define PCIEPHYRX_DIGITAL_MODES		0x00000028
+#define PIPE3_PHY_RX_DIGITAL_MODES		0x00000028
+#define MEM_HS_RATE_MASK		GENMASK(28, 27)
+#define MEM_HS_RATE_SHIFT		27
+#define MEM_OVRD_HS_RATE		BIT(26)
+#define MEM_OVRD_HS_RATE_SHIFT		26
 #define MEM_CDR_FASTLOCK		BIT(23)
-#define MEM_CDR_LBW			GENMASK(22, 21)
-#define MEM_CDR_STEPCNT			GENMASK(20, 19)
+#define MEM_CDR_FASTLOCK_SHIFT		23
+#define MEM_CDR_LBW_MASK		GENMASK(22, 21)
+#define MEM_CDR_LBW_SHIFT		21
+#define MEM_CDR_STEPCNT_MASK		GENMASK(20, 19)
+#define MEM_CDR_STEPCNT_SHIFT		19
 #define MEM_CDR_STL_MASK		GENMASK(18, 16)
 #define MEM_CDR_STL_SHIFT		16
 #define MEM_CDR_THR_MASK		GENMASK(15, 13)
 #define MEM_CDR_THR_SHIFT		13
 #define MEM_CDR_THR_MODE		BIT(12)
-#define MEM_CDR_CDR_2NDO_SDM_MODE	BIT(11)
-#define MEM_OVRD_HS_RATE		BIT(26)
-
-#define PCIEPHYRX_EQUALIZER		0x00000038
-#define MEM_EQLEV			GENMASK(31, 16)
-#define MEM_EQFTC			GENMASK(15, 11)
-#define MEM_EQCTL			GENMASK(10, 7)
+#define MEM_CDR_THR_MODE_SHIFT		12
+#define MEM_CDR_2NDO_SDM_MODE		BIT(11)
+#define MEM_CDR_2NDO_SDM_MODE_SHIFT	11
+
+#define PIPE3_PHY_RX_EQUALIZER		0x00000038
+#define MEM_EQLEV_MASK			GENMASK(31, 16)
+#define MEM_EQLEV_SHIFT			16
+#define MEM_EQFTC_MASK			GENMASK(15, 11)
+#define MEM_EQFTC_SHIFT			11
+#define MEM_EQCTL_MASK			GENMASK(10, 7)
 #define MEM_EQCTL_SHIFT			7
 #define MEM_OVRD_EQLEV			BIT(2)
+#define MEM_OVRD_EQLEV_SHIFT		2
 #define MEM_OVRD_EQFTC			BIT(1)
+#define MEM_OVRD_EQFTC_SHIFT		1
+
+#define SATA_PHY_RX_IO_AND_A2D_OVERRIDES	0x44
+#define MEM_CDR_LOS_SOURCE_MASK		GENMASK(10, 9)
+#define MEM_CDR_LOS_SOURCE_SHIFT	9
 
 /*
  * This is an Empirical value that works, need to confirm the actual
@@ -127,6 +149,27 @@ struct pipe3_dpll_map {
 	struct pipe3_dpll_params params;
 };
 
+struct pipe3_settings {
+	u8 ana_interface;
+	u8 ana_losd;
+	u8 dig_fastlock;
+	u8 dig_lbw;
+	u8 dig_stepcnt;
+	u8 dig_stl;
+	u8 dig_thr;
+	u8 dig_thr_mode;
+	u8 dig_2ndo_sdm_mode;
+	u8 dig_hs_rate;
+	u8 dig_ovrd_hs_rate;
+	u8 dll_trim_sel;
+	u8 dll_phint_rate;
+	u8 eq_lev;
+	u8 eq_ftc;
+	u8 eq_ctl;
+	u8 eq_ovrd_lev;
+	u8 eq_ovrd_ftc;
+};
+
 struct ti_pipe3 {
 	void __iomem		*pll_ctrl_base;
 	void __iomem		*phy_rx;
@@ -146,6 +189,7 @@ struct ti_pipe3 {
 	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
 	bool			sata_refclk_enabled;
 	enum pipe3_mode		mode;
+	struct pipe3_settings	settings;
 };
 
 static struct pipe3_dpll_map dpll_map_usb[] = {
@@ -171,20 +215,84 @@ static struct pipe3_dpll_map dpll_map_sata[] = {
 struct pipe3_data {
 	enum pipe3_mode mode;
 	struct pipe3_dpll_map *dpll_map;
+	struct pipe3_settings settings;
 };
 
 static struct pipe3_data data_usb = {
 	.mode = PIPE3_MODE_USBSS,
 	.dpll_map = dpll_map_usb,
+	.settings = {
+	/* DRA75x TRM Table 26-17. Preferred USB3_PHY_RX SCP Register Settings */
+		.ana_interface = INTERFACE_MODE_USBSS,
+		.ana_losd = 0xa,
+		.dig_fastlock = 1,
+		.dig_lbw = 3,
+		.dig_stepcnt = 0,
+		.dig_stl = 0x3,
+		.dig_thr = 1,
+		.dig_thr_mode = 1,
+		.dig_2ndo_sdm_mode = 0,
+		.dig_hs_rate = 0,
+		.dig_ovrd_hs_rate = 1,
+		.dll_trim_sel = 0x2,
+		.dll_phint_rate = 0x3,
+		.eq_lev = 0,
+		.eq_ftc = 0,
+		.eq_ctl = 0x9,
+		.eq_ovrd_lev = 0,
+		.eq_ovrd_ftc = 0,
+	},
 };
 
 static struct pipe3_data data_sata = {
 	.mode = PIPE3_MODE_SATA,
 	.dpll_map = dpll_map_sata,
+	.settings = {
+	/* DRA75x TRM Table 26-9. Preferred SATA_PHY_RX SCP Register Settings */
+		.ana_interface = INTERFACE_MODE_SATA_3P0,
+		.ana_losd = 0x5,
+		.dig_fastlock = 1,
+		.dig_lbw = 3,
+		.dig_stepcnt = 0,
+		.dig_stl = 0x3,
+		.dig_thr = 1,
+		.dig_thr_mode = 1,
+		.dig_2ndo_sdm_mode = 0,
+		.dig_hs_rate = 0,	/* Not in TRM preferred settings */
+		.dig_ovrd_hs_rate = 0,	/* Not in TRM preferred settings */
+		.dll_trim_sel = 0x1,
+		.dll_phint_rate = 0x2,	/* for 1.5 GHz DPLL clock */
+		.eq_lev = 0,
+		.eq_ftc = 0x1f,
+		.eq_ctl = 0,
+		.eq_ovrd_lev = 1,
+		.eq_ovrd_ftc = 1,
+	},
 };
 
 static struct pipe3_data data_pcie = {
 	.mode = PIPE3_MODE_PCIE,
+	.settings = {
+	/* DRA75x TRM Table 26-62. Preferred PCIe_PHY_RX SCP Register Settings */
+		.ana_interface = INTERFACE_MODE_PCIE,
+		.ana_losd = 0xa,
+		.dig_fastlock = 1,
+		.dig_lbw = 3,
+		.dig_stepcnt = 0,
+		.dig_stl = 0x3,
+		.dig_thr = 1,
+		.dig_thr_mode = 1,
+		.dig_2ndo_sdm_mode = 0,
+		.dig_hs_rate = 0,
+		.dig_ovrd_hs_rate = 0,
+		.dll_trim_sel = 0x2,
+		.dll_phint_rate = 0x3,
+		.eq_lev = 0,
+		.eq_ftc = 0x1f,
+		.eq_ctl = 1,
+		.eq_ovrd_lev = 0,
+		.eq_ovrd_ftc = 0,
+	},
 };
 
 static inline u32 ti_pipe3_readl(void __iomem *addr, unsigned offset)
@@ -324,32 +432,55 @@ static int ti_pipe3_dpll_program(struct ti_pipe3 *phy)
 static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
 {
 	u32 val;
+	struct pipe3_settings *s = &phy->settings;
 
-	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY);
+	val = ti_pipe3_readl(phy->phy_rx, PIPE3_PHY_RX_ANA_PROGRAMMABILITY);
 	val &= ~(INTERFACE_MASK | LOSD_MASK | MEM_PLLDIV);
-	val = (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
-	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY, val);
-
-	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES);
-	val &= ~(MEM_CDR_STEPCNT | MEM_CDR_STL_MASK | MEM_CDR_THR_MASK |
-		 MEM_CDR_CDR_2NDO_SDM_MODE | MEM_OVRD_HS_RATE);
-	val |= (MEM_CDR_FASTLOCK | MEM_CDR_LBW | 0x3 << MEM_CDR_STL_SHIFT |
-		0x1 << MEM_CDR_THR_SHIFT | MEM_CDR_THR_MODE);
-	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES, val);
-
-	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_TRIM);
-	val &= ~MEM_DLL_TRIM_SEL;
-	val |= 0x2 << MEM_DLL_TRIM_SHIFT;
-	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_TRIM, val);
-
-	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DLL);
-	val |= MEM_DLL_PHINT_RATE;
-	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_DLL, val);
-
-	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_EQUALIZER);
-	val &= ~(MEM_EQLEV | MEM_EQCTL | MEM_OVRD_EQLEV | MEM_OVRD_EQFTC);
-	val |= MEM_EQFTC | 0x1 << MEM_EQCTL_SHIFT;
-	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_EQUALIZER, val);
+	val = (s->ana_interface << INTERFACE_SHIFT | s->ana_losd << LOSD_SHIFT);
+	ti_pipe3_writel(phy->phy_rx, PIPE3_PHY_RX_ANA_PROGRAMMABILITY, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PIPE3_PHY_RX_DIGITAL_MODES);
+	val &= ~(MEM_HS_RATE_MASK | MEM_OVRD_HS_RATE | MEM_CDR_FASTLOCK |
+		 MEM_CDR_LBW_MASK | MEM_CDR_STEPCNT_MASK | MEM_CDR_STL_MASK |
+		 MEM_CDR_THR_MASK | MEM_CDR_THR_MODE | MEM_CDR_2NDO_SDM_MODE);
+	val |= s->dig_hs_rate << MEM_HS_RATE_SHIFT |
+		s->dig_ovrd_hs_rate << MEM_OVRD_HS_RATE_SHIFT |
+		s->dig_fastlock << MEM_CDR_FASTLOCK_SHIFT |
+		s->dig_lbw << MEM_CDR_LBW_SHIFT |
+		s->dig_stepcnt << MEM_CDR_STEPCNT_SHIFT |
+		s->dig_stl << MEM_CDR_STL_SHIFT |
+		s->dig_thr << MEM_CDR_THR_SHIFT |
+		s->dig_thr_mode << MEM_CDR_THR_MODE_SHIFT |
+		s->dig_2ndo_sdm_mode << MEM_CDR_2NDO_SDM_MODE_SHIFT;
+	ti_pipe3_writel(phy->phy_rx, PIPE3_PHY_RX_DIGITAL_MODES, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PIPE3_PHY_RX_TRIM);
+	val &= ~MEM_DLL_TRIM_SEL_MASK;
+	val |= s->dll_trim_sel << MEM_DLL_TRIM_SHIFT;
+	ti_pipe3_writel(phy->phy_rx, PIPE3_PHY_RX_TRIM, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PIPE3_PHY_RX_DLL);
+	val &= ~MEM_DLL_PHINT_RATE_MASK;
+	val |= s->dll_phint_rate << MEM_DLL_PHINT_RATE_SHIFT;
+	ti_pipe3_writel(phy->phy_rx, PIPE3_PHY_RX_DLL, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PIPE3_PHY_RX_EQUALIZER);
+	val &= ~(MEM_EQLEV_MASK | MEM_EQFTC_MASK | MEM_EQCTL_MASK |
+		 MEM_OVRD_EQLEV | MEM_OVRD_EQFTC);
+	val |= s->eq_lev << MEM_EQLEV_SHIFT |
+		s->eq_ftc << MEM_EQFTC_SHIFT |
+		s->eq_ctl << MEM_EQCTL_SHIFT |
+		s->eq_ovrd_lev << MEM_OVRD_EQLEV_SHIFT |
+		s->eq_ovrd_ftc << MEM_OVRD_EQFTC_SHIFT;
+	ti_pipe3_writel(phy->phy_rx, PIPE3_PHY_RX_EQUALIZER, val);
+
+	if (phy->mode == PIPE3_MODE_SATA) {
+		val = ti_pipe3_readl(phy->phy_rx,
+				     SATA_PHY_RX_IO_AND_A2D_OVERRIDES);
+		val &= ~MEM_CDR_LOS_SOURCE_MASK;
+		ti_pipe3_writel(phy->phy_rx, SATA_PHY_RX_IO_AND_A2D_OVERRIDES,
+				val);
+	}
 }
 
 static int ti_pipe3_init(struct phy *x)
@@ -401,6 +532,8 @@ static int ti_pipe3_init(struct phy *x)
 		return -EINVAL;
 	}
 
+	ti_pipe3_calibrate(phy);
+
 	return ret;
 }
 
@@ -611,9 +744,6 @@ static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
 	struct device *dev = phy->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	if (phy->mode != PIPE3_MODE_PCIE)
-		return 0;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "phy_rx");
 	phy->phy_rx = devm_ioremap_resource(dev, res);
@@ -669,6 +799,7 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	phy->dev = dev;
 	phy->mode = data->mode;
 	phy->dpll_map = data->dpll_map;
+	phy->settings = data->settings;
 
 	ret = ti_pipe3_get_pll_base(phy);
 	if (ret)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

