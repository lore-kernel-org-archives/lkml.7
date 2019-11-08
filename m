Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51108C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E4421D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfKHADY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:03:24 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49872 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfKHADX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:03:23 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1iSrk1-00065H-HQ; Fri, 08 Nov 2019 01:03:05 +0100
From:   Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To:     dri-devel@lists.freedesktop.org, a.hajda@samsung.com
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, philippe.cornu@st.com,
        yannick.fertre@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 3/5] drm/rockchip: add ability to handle external dphys in mipi-dsi
Date:   Fri,  8 Nov 2019 01:02:51 +0100
Message-Id: <20191108000253.8560-4-heiko.stuebner@theobroma-systems.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
References: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the common case is that the dsi controller uses an internal dphy,
accessed through the phy registers inside the dsi controller, there is
also the possibility to use a separate dphy from a different vendor.

One such case is the Rockchip px30 that uses a Innosilicon Mipi dphy,
so add the support for handling such a constellation, including the pll
also getting generated inside that external phy.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 68 +++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index bc073ec5c183..1e6578f911a0 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
@@ -223,6 +224,10 @@ struct dw_mipi_dsi_rockchip {
 	bool is_slave;
 	struct dw_mipi_dsi_rockchip *slave;
 
+	/* optional external dphy */
+	struct phy *phy;
+	union phy_configure_opts phy_opts;
+
 	unsigned int lane_mbps; /* per lane */
 	u16 input_div;
 	u16 feedback_div;
@@ -359,6 +364,9 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 	struct dw_mipi_dsi_rockchip *dsi = priv_data;
 	int ret, i, vco;
 
+	if (dsi->phy)
+		return 0;
+
 	/*
 	 * Get vco from frequency(lane_mbps)
 	 * vco	frequency table
@@ -467,6 +475,28 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 	return ret;
 }
 
+static void dw_mipi_dsi_phy_power_on(void *priv_data)
+{
+	struct dw_mipi_dsi_rockchip *dsi = priv_data;
+	int ret;
+
+	ret = phy_set_mode(dsi->phy, PHY_MODE_MIPI_DPHY);
+	if (ret) {
+		DRM_DEV_ERROR(dsi->dev, "failed to set phy mode: %d\n", ret);
+		return;
+	}
+
+	phy_configure(dsi->phy, &dsi->phy_opts);
+	phy_power_on(dsi->phy);
+}
+
+static void dw_mipi_dsi_phy_power_off(void *priv_data)
+{
+	struct dw_mipi_dsi_rockchip *dsi = priv_data;
+
+	phy_power_off(dsi->phy);
+}
+
 static int
 dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 			  unsigned long mode_flags, u32 lanes, u32 format,
@@ -504,6 +534,17 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 				      "DPHY clock frequency is out of range\n");
 	}
 
+	/* for external phy only a the mipi_dphy_config is necessary */
+	if (dsi->phy) {
+		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
+						 bpp, lanes,
+						 &dsi->phy_opts.mipi_dphy);
+		dsi->lane_mbps = target_mbps;
+		*lane_mbps = dsi->lane_mbps;
+
+		return 0;
+	}
+
 	fin = clk_get_rate(dsi->pllref_clk);
 	fout = target_mbps * USEC_PER_SEC;
 
@@ -561,6 +602,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 	.init = dw_mipi_dsi_phy_init,
+	.power_on = dw_mipi_dsi_phy_power_on,
+	.power_off = dw_mipi_dsi_phy_power_off,
 	.get_lane_mbps = dw_mipi_dsi_get_lane_mbps,
 };
 
@@ -920,12 +963,29 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* try to get a possible external dphy */
+	dsi->phy = devm_phy_optional_get(dev, "dphy");
+	if (IS_ERR(dsi->phy)) {
+		ret = PTR_ERR(dsi->phy);
+		DRM_DEV_ERROR(dev, "failed to get mipi dphy: %d\n", ret);
+		return ret;
+	}
+
 	dsi->pllref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
-		ret = PTR_ERR(dsi->pllref_clk);
-		DRM_DEV_ERROR(dev,
-			      "Unable to get pll reference clock: %d\n", ret);
-		return ret;
+		if (dsi->phy) {
+			/*
+			 * if external phy is present, pll will be
+			 * generated there.
+			 */
+			dsi->pllref_clk = NULL;
+		} else {
+			ret = PTR_ERR(dsi->pllref_clk);
+			DRM_DEV_ERROR(dev,
+				      "Unable to get pll reference clock: %d\n",
+				      ret);
+			return ret;
+		}
 	}
 
 	if (dsi->cdata->flags & DW_MIPI_NEEDS_PHY_CFG_CLK) {
-- 
2.23.0

