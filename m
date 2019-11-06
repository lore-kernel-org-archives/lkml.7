Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74CBC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C3D20659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfKFL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:27:24 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53224 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfKFL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:27:22 -0500
Received: from [94.134.91.181] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1iSJSn-0004nK-UE; Wed, 06 Nov 2019 12:27:02 +0100
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
Subject: [PATCH 2/3] drm/rockchip: add ability to handle external dphys in mipi-dsi
Date:   Wed,  6 Nov 2019 12:26:49 +0100
Message-Id: <20191106112650.8365-2-heiko.stuebner@theobroma-systems.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106112650.8365-1-heiko.stuebner@theobroma-systems.com>
References: <20191106112650.8365-1-heiko.stuebner@theobroma-systems.com>
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
 .../display/rockchip/dw_mipi_dsi_rockchip.txt |  7 ++-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 54 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index ce4c1fc9116c..8b25156a9dcf 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -8,8 +8,9 @@ Required properties:
 	      "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi".
 - reg: Represent the physical address range of the controller.
 - interrupts: Represent the controller's interrupt to the CPU(s).
-- clocks, clock-names: Phandles to the controller's pll reference
-  clock(ref) and APB clock(pclk). For RK3399, a phy config clock
+- clocks, clock-names: Phandles to the controller's and APB clock(pclk)
+  and either a pll reference clock(ref) (internal dphy) or pll clock(pll)
+  (when connected to an external phy). For RK3399, a phy config clock
   (phy_cfg) and a grf clock(grf) are required. As described in [1].
 - rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
 - ports: contain a port node with endpoint definitions as defined in [2].
@@ -18,6 +19,8 @@ Required properties:
 - video port 1 for either a panel or subsequent encoder
 
 Optional properties:
+- phys: from general PHY binding: the phandle for the PHY device.
+- phy-names: Should be "dphy" if phys references an external phy.
 - power-domains: a phandle to mipi dsi power domain node.
 - resets: list of phandle + reset specifier pairs, as described in [3].
 - reset-names: string reset name, must be "apb".
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index bc073ec5c183..99ec625e0448 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
@@ -223,6 +224,9 @@ struct dw_mipi_dsi_rockchip {
 	bool is_slave;
 	struct dw_mipi_dsi_rockchip *slave;
 
+	/* optional external dphy */
+	struct phy *phy;
+
 	unsigned int lane_mbps; /* per lane */
 	u16 input_div;
 	u16 feedback_div;
@@ -359,6 +363,9 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 	struct dw_mipi_dsi_rockchip *dsi = priv_data;
 	int ret, i, vco;
 
+	if (dsi->phy)
+		return 0;
+
 	/*
 	 * Get vco from frequency(lane_mbps)
 	 * vco	frequency table
@@ -467,6 +474,27 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
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
@@ -504,9 +532,21 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 				      "DPHY clock frequency is out of range\n");
 	}
 
-	fin = clk_get_rate(dsi->pllref_clk);
 	fout = target_mbps * USEC_PER_SEC;
 
+	/* an external phy does have a controllable pll clk */
+	if (dsi->phy) {
+		fout = clk_round_rate(dsi->pllref_clk, fout);
+		clk_set_rate(dsi->pllref_clk, fout);
+
+		dsi->lane_mbps = target_mbps;
+		*lane_mbps = dsi->lane_mbps;
+
+		return 0;
+	}
+
+	fin = clk_get_rate(dsi->pllref_clk);
+
 	/* constraint: 5Mhz <= Fref / N <= 40MHz */
 	min_prediv = DIV_ROUND_UP(fin, 40 * USEC_PER_SEC);
 	max_prediv = fin / (5 * USEC_PER_SEC);
@@ -561,6 +601,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 	.init = dw_mipi_dsi_phy_init,
+	.power_on = dw_mipi_dsi_phy_power_on,
+	.power_off = dw_mipi_dsi_phy_power_off,
 	.get_lane_mbps = dw_mipi_dsi_get_lane_mbps,
 };
 
@@ -920,7 +962,15 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dsi->pllref_clk = devm_clk_get(dev, "ref");
+	/* try to get a possible external dphy */
+	dsi->phy = devm_phy_optional_get(dev, "dphy");
+	if (IS_ERR(dsi->phy)) {
+		ret = PTR_ERR(dsi->phy);
+		DRM_DEV_ERROR(dev, "failed to get mipi dphy: %d\n", ret);
+		return ret;
+	}
+
+	dsi->pllref_clk = devm_clk_get(dev, dsi->phy ? "pll" : "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
 		ret = PTR_ERR(dsi->pllref_clk);
 		DRM_DEV_ERROR(dev,
-- 
2.23.0

