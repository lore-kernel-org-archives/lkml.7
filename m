Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF4213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfCVNIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:08:19 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:54828 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730578AbfCVLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:39 -0400
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:55276 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1h7ISC-0006u1-UZ; Fri, 22 Mar 2019 12:35:17 +0100
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com
Cc:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 1/4] phy: rockchip-emmc: Allow to set drive impedance via DTS.
Date:   Fri, 22 Mar 2019 12:34:50 +0100
Message-Id: <20190322113456.16324-1-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip-emmc PHY can be configured with different
drive impedance values. Currenlty a value of 50 Ohm is
hard coded into the driver.

This patch introduces the DTS property 'drive-impedance-ohm'
for the rockchip-emmc phy node, which uses the value from the DTS
to setup the drive impedance accordingly.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 19bf84f0bc67..b804c6bf4b55 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -87,6 +87,7 @@ struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
 	struct regmap	*reg_base;
 	struct clk	*emmcclk;
+	unsigned int drive_impedance;
 };
 
 static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
@@ -281,10 +282,10 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 {
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
 
-	/* Drive impedance: 50 Ohm */
+	/* Drive impedance: from DTS */
 	regmap_write(rk_phy->reg_base,
 		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
-		     HIWORD_UPDATE(PHYCTRL_DR_50OHM,
+		     HIWORD_UPDATE(rk_phy->drive_impedance,
 				   PHYCTRL_DR_MASK,
 				   PHYCTRL_DR_SHIFT));
 
@@ -314,6 +315,26 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static u32 convert_drive_impedance_ohm(struct platform_device *pdev, u32 dr_ohm)
+{
+	switch (dr_ohm) {
+	case 100:
+		return PHYCTRL_DR_100OHM;
+	case 66:
+		return PHYCTRL_DR_66OHM;
+	case 50:
+		return PHYCTRL_DR_50OHM;
+	case 40:
+		return PHYCTRL_DR_40OHM;
+	case 33:
+		return PHYCTRL_DR_33OHM;
+	}
+
+	dev_warn(&pdev->dev, "Invalid value %u for drive-impedance-ohm.\n",
+		 dr_ohm);
+	return PHYCTRL_DR_50OHM;
+}
+
 static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -322,6 +343,7 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct regmap *grf;
 	unsigned int reg_offset;
+	u32 val;
 
 	if (!dev->parent || !dev->parent->of_node)
 		return -ENODEV;
@@ -344,6 +366,10 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 
 	rk_phy->reg_offset = reg_offset;
 	rk_phy->reg_base = grf;
+	rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
+
+	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
+		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
 
 	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
 	if (IS_ERR(generic_phy)) {
-- 
2.11.0

