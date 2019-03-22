Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5C21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jWB69jl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCVI6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:58:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60476 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:58:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2M8wFAX027051
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553245095;
        bh=JZva8GreHTBsEQhYw2VOI3/fonXSa/Q4j46jwDuckpc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jWB69jl+FUiImZckWL9UiUDuL/dBklttukW5SpxbvTkpzxtXrzWht4KPGRa8+kA4y
         I+4C8uJaS7PKUHyZ0dkXftqdx3DzPGYB8rsygpqBDDVD1QrFZFUMq00sGULhMMl0zZ
         fytUFM2dCUUKCbfGjsavVZf0+nEa2Rz/GCUpiI8E=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2M8wFPo076747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:15 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 03:58:13 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 03:58:13 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2M8w9b7016866;
        Fri, 22 Mar 2019 03:58:11 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/4] phy: ti-pipe3: Introduce mode property in driver data
Date:   Fri, 22 Mar 2019 10:58:04 +0200
Message-ID: <20190322085807.30216-2-rogerq@ti.com>
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

Introduce a mode property in the driver data so that
we don't have to keep using "of_device_is_compatible()"
throughtout the driver.

No functional change.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 93 +++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 68ce4a082b9b..0913dd55d82a 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -110,6 +110,10 @@
 #define PLL_IDLE_TIME	100	/* in milliseconds */
 #define PLL_LOCK_TIME	100	/* in milliseconds */
 
+enum pipe3_mode { PIPE3_MODE_PCIE = 1,
+		  PIPE3_MODE_SATA,
+		  PIPE3_MODE_USBSS };
+
 struct pipe3_dpll_params {
 	u16	m;
 	u8	n;
@@ -141,6 +145,7 @@ struct ti_pipe3 {
 	unsigned int		power_reg; /* power reg. index within syscon */
 	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
 	bool			sata_refclk_enabled;
+	enum pipe3_mode		mode;
 };
 
 static struct pipe3_dpll_map dpll_map_usb[] = {
@@ -163,6 +168,25 @@ static struct pipe3_dpll_map dpll_map_sata[] = {
 	{ },					/* Terminator */
 };
 
+struct pipe3_data {
+	enum pipe3_mode mode;
+	struct pipe3_dpll_map *dpll_map;
+};
+
+static struct pipe3_data data_usb = {
+	.mode = PIPE3_MODE_USBSS,
+	.dpll_map = dpll_map_usb,
+};
+
+static struct pipe3_data data_sata = {
+	.mode = PIPE3_MODE_SATA,
+	.dpll_map = dpll_map_sata,
+};
+
+static struct pipe3_data data_pcie = {
+	.mode = PIPE3_MODE_PCIE,
+};
+
 static inline u32 ti_pipe3_readl(void __iomem *addr, unsigned offset)
 {
 	return __raw_readl(addr + offset);
@@ -340,7 +364,7 @@ static int ti_pipe3_init(struct phy *x)
 	 * as recommended in AM572x TRM SPRUHZ6, section 18.5.2.2, table
 	 * 18-1804.
 	 */
-	if (of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
+	if (phy->mode == PIPE3_MODE_PCIE) {
 		if (!phy->pcs_syscon) {
 			omap_control_pcie_pcs(phy->control_dev, 0x96);
 			return 0;
@@ -367,8 +391,7 @@ static int ti_pipe3_init(struct phy *x)
 
 	/* SATA has issues if re-programmed when locked */
 	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-	if ((val & PLL_LOCK) && of_device_is_compatible(phy->dev->of_node,
-							"ti,phy-pipe3-sata"))
+	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA)
 		return ret;
 
 	/* Program the DPLL */
@@ -390,12 +413,11 @@ static int ti_pipe3_exit(struct phy *x)
 	/* If dpll_reset_syscon is not present we wont power down SATA DPLL
 	 * due to Errata i783
 	 */
-	if (of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-sata") &&
-	    !phy->dpll_reset_syscon)
+	if (phy->mode == PIPE3_MODE_SATA && !phy->dpll_reset_syscon)
 		return 0;
 
 	/* PCIe doesn't have internal DPLL */
-	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
+	if (phy->mode != PIPE3_MODE_PCIE) {
 		/* Put DPLL in IDLE mode */
 		val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
 		val |= PLL_IDLE;
@@ -418,7 +440,7 @@ static int ti_pipe3_exit(struct phy *x)
 	}
 
 	/* i783: SATA needs control bit toggle after PLL unlock */
-	if (of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-sata")) {
+	if (phy->mode == PIPE3_MODE_SATA) {
 		regmap_update_bits(phy->dpll_reset_syscon, phy->dpll_reset_reg,
 				   SATA_PLL_SOFT_RESET, SATA_PLL_SOFT_RESET);
 		regmap_update_bits(phy->dpll_reset_syscon, phy->dpll_reset_reg,
@@ -443,7 +465,6 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 {
 	struct clk *clk;
 	struct device *dev = phy->dev;
-	struct device_node *node = dev->of_node;
 
 	phy->refclk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(phy->refclk)) {
@@ -451,11 +472,11 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 		/* older DTBs have missing refclk in SATA PHY
 		 * so don't bail out in case of SATA PHY.
 		 */
-		if (!of_device_is_compatible(node, "ti,phy-pipe3-sata"))
+		if (phy->mode != PIPE3_MODE_SATA)
 			return PTR_ERR(phy->refclk);
 	}
 
-	if (!of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+	if (phy->mode != PIPE3_MODE_SATA) {
 		phy->wkupclk = devm_clk_get(dev, "wkupclk");
 		if (IS_ERR(phy->wkupclk)) {
 			dev_err(dev, "unable to get wkupclk\n");
@@ -465,8 +486,7 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 		phy->wkupclk = ERR_PTR(-ENODEV);
 	}
 
-	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie") ||
-	    phy->phy_power_syscon) {
+	if (phy->mode != PIPE3_MODE_PCIE || phy->phy_power_syscon) {
 		phy->sys_clk = devm_clk_get(dev, "sysclk");
 		if (IS_ERR(phy->sys_clk)) {
 			dev_err(dev, "unable to get sysclk\n");
@@ -474,7 +494,7 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 		}
 	}
 
-	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
+	if (phy->mode == PIPE3_MODE_PCIE) {
 		clk = devm_clk_get(dev, "dpll_ref");
 		if (IS_ERR(clk)) {
 			dev_err(dev, "unable to get dpll ref clk\n");
@@ -546,7 +566,7 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		phy->control_dev = &control_pdev->dev;
 	}
 
-	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
+	if (phy->mode == PIPE3_MODE_PCIE) {
 		phy->pcs_syscon = syscon_regmap_lookup_by_phandle(node,
 								  "syscon-pcs");
 		if (IS_ERR(phy->pcs_syscon)) {
@@ -564,7 +584,7 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		}
 	}
 
-	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+	if (phy->mode == PIPE3_MODE_SATA) {
 		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
 							"syscon-pllreset");
 		if (IS_ERR(phy->dpll_reset_syscon)) {
@@ -589,10 +609,9 @@ static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
 {
 	struct resource *res;
 	struct device *dev = phy->dev;
-	struct device_node *node = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
+	if (phy->mode != PIPE3_MODE_PCIE)
 		return 0;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -611,24 +630,12 @@ static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
 static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 {
 	struct resource *res;
-	const struct of_device_id *match;
 	struct device *dev = phy->dev;
-	struct device_node *node = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
+	if (phy->mode == PIPE3_MODE_PCIE)
 		return 0;
 
-	match = of_match_device(ti_pipe3_id_table, dev);
-	if (!match)
-		return -EINVAL;
-
-	phy->dpll_map = (struct pipe3_dpll_map *)match->data;
-	if (!phy->dpll_map) {
-		dev_err(dev, "no DPLL data\n");
-		return -EINVAL;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "pll_ctrl");
 	phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
@@ -640,15 +647,28 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	struct ti_pipe3 *phy;
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
-	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int ret;
+	const struct of_device_id *match;
+	struct pipe3_data *data;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	phy->dev		= dev;
+	match = of_match_device(ti_pipe3_id_table, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct pipe3_data *)match->data;
+	if (!data) {
+		dev_err(dev, "no driver data\n");
+		return -EINVAL;
+	}
+
+	phy->dev = dev;
+	phy->mode = data->mode;
+	phy->dpll_map = data->dpll_map;
 
 	ret = ti_pipe3_get_pll_base(phy);
 	if (ret)
@@ -672,7 +692,7 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	/*
 	 * Prevent auto-disable of refclk for SATA PHY due to Errata i783
 	 */
-	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+	if (phy->mode == PIPE3_MODE_SATA) {
 		if (!IS_ERR(phy->refclk)) {
 			clk_prepare_enable(phy->refclk);
 			phy->sata_refclk_enabled = true;
@@ -762,18 +782,19 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy)
 static const struct of_device_id ti_pipe3_id_table[] = {
 	{
 		.compatible = "ti,phy-usb3",
-		.data = dpll_map_usb,
+		.data = &data_usb,
 	},
 	{
 		.compatible = "ti,omap-usb3",
-		.data = dpll_map_usb,
+		.data = &data_usb,
 	},
 	{
 		.compatible = "ti,phy-pipe3-sata",
-		.data = dpll_map_sata,
+		.data = &data_sata,
 	},
 	{
 		.compatible = "ti,phy-pipe3-pcie",
+		.data = &data_pcie,
 	},
 	{}
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

