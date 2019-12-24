Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F33C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295D92073B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfLXOjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:39:43 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58793 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfLXOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:39:28 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1DE12E0007;
        Tue, 24 Dec 2019 14:39:26 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 09/11] drm/rockchip: lvds: Add PX30 support
Date:   Tue, 24 Dec 2019 15:38:58 +0100
Message-Id: <20191224143900.23567-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224143900.23567-1-miquel.raynal@bootlin.com>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce PX30 LVDS support. This means adding the relevant helper
functions, a specific probe and also the initialization of a specific
PHY.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 143 +++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.h |  14 +++
 2 files changed, 157 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f2ece09e4e24..d762cdd114f9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_graph.h>
+#include <linux/phy/phy.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -53,6 +54,7 @@ struct rockchip_lvds {
 	void __iomem *regs;
 	struct regmap *grf;
 	struct clk *pclk;
+	struct phy *dphy;
 	const struct rockchip_lvds_soc_data *soc_data;
 	int output; /* rgb lvds or dual lvds output */
 	int format; /* vesa or jeida format */
@@ -321,6 +323,103 @@ static void rk3288_lvds_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_unprepare(lvds->panel);
 }
 
+static int px30_lvds_poweron(struct rockchip_lvds *lvds)
+{
+	int ret;
+
+	ret = pm_runtime_get_sync(lvds->dev);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable LVDS mode */
+	return regmap_update_bits(lvds->grf, PX30_LVDS_GRF_PD_VO_CON1,
+				  PX30_LVDS_MODE_EN(1) | PX30_LVDS_P2S_EN(1),
+				  PX30_LVDS_MODE_EN(1) | PX30_LVDS_P2S_EN(1));
+}
+
+static void px30_lvds_poweroff(struct rockchip_lvds *lvds)
+{
+	regmap_update_bits(lvds->grf, PX30_LVDS_GRF_PD_VO_CON1,
+			   PX30_LVDS_MODE_EN(1) | PX30_LVDS_P2S_EN(1),
+			   PX30_LVDS_MODE_EN(0) | PX30_LVDS_P2S_EN(0));
+
+	pm_runtime_put(lvds->dev);
+}
+
+static int px30_lvds_grf_config(struct drm_encoder *encoder,
+				struct drm_display_mode *mode)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+
+	if (lvds->output != DISPLAY_OUTPUT_LVDS) {
+		DRM_DEV_ERROR(lvds->dev, "Unsupported display output %d\n",
+			      lvds->output);
+		return -EINVAL;
+	}
+
+	/* Set format */
+	return regmap_update_bits(lvds->grf, PX30_LVDS_GRF_PD_VO_CON1,
+				  PX30_LVDS_FORMAT(lvds->format),
+				  PX30_LVDS_FORMAT(lvds->format));
+}
+
+static int px30_lvds_set_vop_source(struct rockchip_lvds *lvds,
+				    struct drm_encoder *encoder)
+{
+	int vop;
+
+	vop = drm_of_encoder_active_endpoint_id(lvds->dev->of_node, encoder);
+	if (vop < 0)
+		return vop;
+
+	return regmap_update_bits(lvds->grf, PX30_LVDS_GRF_PD_VO_CON1,
+				  PX30_LVDS_VOP_SEL(1),
+				  PX30_LVDS_VOP_SEL(vop));
+}
+
+static void px30_lvds_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
+	int ret;
+
+	drm_panel_prepare(lvds->panel);
+
+	ret = px30_lvds_poweron(lvds);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to power on LVDS: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	ret = px30_lvds_grf_config(encoder, mode);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to configure LVDS: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	ret = px30_lvds_set_vop_source(lvds, encoder);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to set VOP source: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	drm_panel_enable(lvds->panel);
+}
+
+static void px30_lvds_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+
+	drm_panel_disable(lvds->panel);
+	px30_lvds_poweroff(lvds);
+	drm_panel_unprepare(lvds->panel);
+}
+
 static const
 struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
 	.enable = rk3288_lvds_encoder_enable,
@@ -328,6 +427,13 @@ struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
 	.atomic_check = rockchip_lvds_encoder_atomic_check,
 };
 
+static const
+struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
+	.enable = px30_lvds_encoder_enable,
+	.disable = px30_lvds_encoder_disable,
+	.atomic_check = rockchip_lvds_encoder_atomic_check,
+};
+
 static const struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
@@ -378,16 +484,53 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static int px30_lvds_probe(struct platform_device *pdev,
+			   struct rockchip_lvds *lvds)
+{
+	int ret;
+
+	/* MSB */
+	ret =  regmap_update_bits(lvds->grf, PX30_LVDS_GRF_PD_VO_CON1,
+				  PX30_LVDS_MSBSEL(1),
+				  PX30_LVDS_MSBSEL(1));
+	if (ret)
+		return ret;
+
+	/* PHY */
+	lvds->dphy = devm_phy_get(&pdev->dev, "dphy");
+	if (IS_ERR(lvds->dphy))
+		return PTR_ERR(lvds->dphy);
+
+	phy_init(lvds->dphy);
+	if (ret)
+		return ret;
+
+	phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
+	if (ret)
+		return ret;
+
+	return phy_power_on(lvds->dphy);
+}
+
 static const struct rockchip_lvds_soc_data rk3288_lvds_data = {
 	.probe = rk3288_lvds_probe,
 	.helper_funcs = &rk3288_lvds_encoder_helper_funcs,
 };
 
+static const struct rockchip_lvds_soc_data px30_lvds_data = {
+	.probe = px30_lvds_probe,
+	.helper_funcs = &px30_lvds_encoder_helper_funcs,
+};
+
 static const struct of_device_id rockchip_lvds_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3288-lvds",
 		.data = &rk3288_lvds_data
 	},
+	{
+		.compatible = "rockchip,px30-lvds",
+		.data = &px30_lvds_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_lvds_dt_ids);
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index e41e9ab3c306..ff3cffc4770d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -106,4 +106,18 @@
 #define LVDS_VESA_18				2
 #define LVDS_JEIDA_18				3
 
+#define HIWORD_UPDATE(v, h, l)  ((GENMASK(h, l) << 16) | (v << l))
+
+#define PX30_LVDS_GRF_PD_VO_CON0		0x434
+#define   PX30_LVDS_TIE_CLKS(val)		HIWORD_UPDATE(val,  8,  8)
+#define   PX30_LVDS_INVERT_CLKS(val)		HIWORD_UPDATE(val,  9,  9)
+#define   PX30_LVDS_INVERT_DCLK(val)		HIWORD_UPDATE(val,  5,  5)
+
+#define PX30_LVDS_GRF_PD_VO_CON1		0x438
+#define   PX30_LVDS_FORMAT(val)			HIWORD_UPDATE(val, 14, 13)
+#define   PX30_LVDS_MODE_EN(val)		HIWORD_UPDATE(val, 12, 12)
+#define   PX30_LVDS_MSBSEL(val)			HIWORD_UPDATE(val, 11, 11)
+#define   PX30_LVDS_P2S_EN(val)			HIWORD_UPDATE(val,  6,  6)
+#define   PX30_LVDS_VOP_SEL(val)		HIWORD_UPDATE(val,  1,  1)
+
 #endif /* _ROCKCHIP_LVDS_ */
-- 
2.20.1

