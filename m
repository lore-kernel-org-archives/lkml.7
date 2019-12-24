Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C937C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFD1206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLXOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:39:23 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50037 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfLXOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:39:20 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 91EDDE0009;
        Tue, 24 Dec 2019 14:39:16 +0000 (UTC)
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
Subject: [PATCH v2 04/11] drm/rockchip: lvds: Harmonize function names
Date:   Tue, 24 Dec 2019 15:38:53 +0100
Message-Id: <20191224143900.23567-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224143900.23567-1-miquel.raynal@bootlin.com>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the introduction of PX30 support by clarifying the function
prefixes.

We continue to prefix with 'rockchip_lvds_' generic functions that are
not specific to a single hardware. Functions implying hardware
modifications are now prefixed with 'rk3288_lvds_'.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 138 ++++++++++++-----------
 1 file changed, 73 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 64aefa856896..3c08e50923ae 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -66,7 +66,8 @@ struct rockchip_lvds {
 	struct dev_pin_info *pins;
 };
 
-static inline void lvds_writel(struct rockchip_lvds *lvds, u32 offset, u32 val)
+static inline void rk3288_writel(struct rockchip_lvds *lvds, u32 offset,
+				 u32 val)
 {
 	writel_relaxed(val, lvds->regs + offset);
 	if (lvds->output == DISPLAY_OUTPUT_LVDS)
@@ -74,7 +75,7 @@ static inline void lvds_writel(struct rockchip_lvds *lvds, u32 offset, u32 val)
 	writel_relaxed(val, lvds->regs + offset + lvds->soc_data->ch1_offset);
 }
 
-static inline int lvds_name_to_format(const char *s)
+static inline int rockchip_lvds_name_to_format(const char *s)
 {
 	if (strncmp(s, "jeida-18", 8) == 0)
 		return LVDS_JEIDA_18;
@@ -86,7 +87,7 @@ static inline int lvds_name_to_format(const char *s)
 	return -EINVAL;
 }
 
-static inline int lvds_name_to_output(const char *s)
+static inline int rockchip_lvds_name_to_output(const char *s)
 {
 	if (strncmp(s, "rgb", 3) == 0)
 		return DISPLAY_OUTPUT_RGB;
@@ -98,7 +99,7 @@ static inline int lvds_name_to_output(const char *s)
 	return -EINVAL;
 }
 
-static int rockchip_lvds_poweron(struct rockchip_lvds *lvds)
+static int rk3288_lvds_poweron(struct rockchip_lvds *lvds)
 {
 	int ret;
 	u32 val;
@@ -120,63 +121,70 @@ static int rockchip_lvds_poweron(struct rockchip_lvds *lvds)
 	if (lvds->output == DISPLAY_OUTPUT_RGB) {
 		val |= RK3288_LVDS_CH0_REG0_TTL_EN |
 			RK3288_LVDS_CH0_REG0_LANECK_EN;
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG0, val);
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG2,
-			    RK3288_LVDS_PLL_FBDIV_REG2(0x46));
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG4,
-			    RK3288_LVDS_CH0_REG4_LANECK_TTL_MODE |
-			    RK3288_LVDS_CH0_REG4_LANE4_TTL_MODE |
-			    RK3288_LVDS_CH0_REG4_LANE3_TTL_MODE |
-			    RK3288_LVDS_CH0_REG4_LANE2_TTL_MODE |
-			    RK3288_LVDS_CH0_REG4_LANE1_TTL_MODE |
-			    RK3288_LVDS_CH0_REG4_LANE0_TTL_MODE);
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG5,
-			    RK3288_LVDS_CH0_REG5_LANECK_TTL_DATA |
-			    RK3288_LVDS_CH0_REG5_LANE4_TTL_DATA |
-			    RK3288_LVDS_CH0_REG5_LANE3_TTL_DATA |
-			    RK3288_LVDS_CH0_REG5_LANE2_TTL_DATA |
-			    RK3288_LVDS_CH0_REG5_LANE1_TTL_DATA |
-			    RK3288_LVDS_CH0_REG5_LANE0_TTL_DATA);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG0, val);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG2,
+			      RK3288_LVDS_PLL_FBDIV_REG2(0x46));
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG4,
+			      RK3288_LVDS_CH0_REG4_LANECK_TTL_MODE |
+			      RK3288_LVDS_CH0_REG4_LANE4_TTL_MODE |
+			      RK3288_LVDS_CH0_REG4_LANE3_TTL_MODE |
+			      RK3288_LVDS_CH0_REG4_LANE2_TTL_MODE |
+			      RK3288_LVDS_CH0_REG4_LANE1_TTL_MODE |
+			      RK3288_LVDS_CH0_REG4_LANE0_TTL_MODE);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG5,
+			      RK3288_LVDS_CH0_REG5_LANECK_TTL_DATA |
+			      RK3288_LVDS_CH0_REG5_LANE4_TTL_DATA |
+			      RK3288_LVDS_CH0_REG5_LANE3_TTL_DATA |
+			      RK3288_LVDS_CH0_REG5_LANE2_TTL_DATA |
+			      RK3288_LVDS_CH0_REG5_LANE1_TTL_DATA |
+			      RK3288_LVDS_CH0_REG5_LANE0_TTL_DATA);
 	} else {
 		val |= RK3288_LVDS_CH0_REG0_LVDS_EN |
 			    RK3288_LVDS_CH0_REG0_LANECK_EN;
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG0, val);
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG1,
-			    RK3288_LVDS_CH0_REG1_LANECK_BIAS |
-			    RK3288_LVDS_CH0_REG1_LANE4_BIAS |
-			    RK3288_LVDS_CH0_REG1_LANE3_BIAS |
-			    RK3288_LVDS_CH0_REG1_LANE2_BIAS |
-			    RK3288_LVDS_CH0_REG1_LANE1_BIAS |
-			    RK3288_LVDS_CH0_REG1_LANE0_BIAS);
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG2,
-			    RK3288_LVDS_CH0_REG2_RESERVE_ON |
-			    RK3288_LVDS_CH0_REG2_LANECK_LVDS_MODE |
-			    RK3288_LVDS_CH0_REG2_LANE4_LVDS_MODE |
-			    RK3288_LVDS_CH0_REG2_LANE3_LVDS_MODE |
-			    RK3288_LVDS_CH0_REG2_LANE2_LVDS_MODE |
-			    RK3288_LVDS_CH0_REG2_LANE1_LVDS_MODE |
-			    RK3288_LVDS_CH0_REG2_LANE0_LVDS_MODE |
-			    RK3288_LVDS_PLL_FBDIV_REG2(0x46));
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG4, 0x00);
-		lvds_writel(lvds, RK3288_LVDS_CH0_REG5, 0x00);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG0, val);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG1,
+			      RK3288_LVDS_CH0_REG1_LANECK_BIAS |
+			      RK3288_LVDS_CH0_REG1_LANE4_BIAS |
+			      RK3288_LVDS_CH0_REG1_LANE3_BIAS |
+			      RK3288_LVDS_CH0_REG1_LANE2_BIAS |
+			      RK3288_LVDS_CH0_REG1_LANE1_BIAS |
+			      RK3288_LVDS_CH0_REG1_LANE0_BIAS);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG2,
+			      RK3288_LVDS_CH0_REG2_RESERVE_ON |
+			      RK3288_LVDS_CH0_REG2_LANECK_LVDS_MODE |
+			      RK3288_LVDS_CH0_REG2_LANE4_LVDS_MODE |
+			      RK3288_LVDS_CH0_REG2_LANE3_LVDS_MODE |
+			      RK3288_LVDS_CH0_REG2_LANE2_LVDS_MODE |
+			      RK3288_LVDS_CH0_REG2_LANE1_LVDS_MODE |
+			      RK3288_LVDS_CH0_REG2_LANE0_LVDS_MODE |
+			      RK3288_LVDS_PLL_FBDIV_REG2(0x46));
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG4, 0x00);
+		rk3288_writel(lvds, RK3288_LVDS_CH0_REG5, 0x00);
 	}
-	lvds_writel(lvds, RK3288_LVDS_CH0_REG3, RK3288_LVDS_PLL_FBDIV_REG3(0x46));
-	lvds_writel(lvds, RK3288_LVDS_CH0_REGD, RK3288_LVDS_PLL_PREDIV_REGD(0x0a));
-	lvds_writel(lvds, RK3288_LVDS_CH0_REG20, RK3288_LVDS_CH0_REG20_LSB);
+	rk3288_writel(lvds, RK3288_LVDS_CH0_REG3,
+		      RK3288_LVDS_PLL_FBDIV_REG3(0x46));
+	rk3288_writel(lvds, RK3288_LVDS_CH0_REGD,
+		      RK3288_LVDS_PLL_PREDIV_REGD(0x0a));
+	rk3288_writel(lvds, RK3288_LVDS_CH0_REG20,
+		      RK3288_LVDS_CH0_REG20_LSB);
 
-	lvds_writel(lvds, RK3288_LVDS_CFG_REGC, RK3288_LVDS_CFG_REGC_PLL_ENABLE);
-	lvds_writel(lvds, RK3288_LVDS_CFG_REG21, RK3288_LVDS_CFG_REG21_TX_ENABLE);
+	rk3288_writel(lvds, RK3288_LVDS_CFG_REGC,
+		      RK3288_LVDS_CFG_REGC_PLL_ENABLE);
+	rk3288_writel(lvds, RK3288_LVDS_CFG_REG21,
+		      RK3288_LVDS_CFG_REG21_TX_ENABLE);
 
 	return 0;
 }
 
-static void rockchip_lvds_poweroff(struct rockchip_lvds *lvds)
+static void rk3288_lvds_poweroff(struct rockchip_lvds *lvds)
 {
 	int ret;
 	u32 val;
 
-	lvds_writel(lvds, RK3288_LVDS_CFG_REG21, RK3288_LVDS_CFG_REG21_TX_ENABLE);
-	lvds_writel(lvds, RK3288_LVDS_CFG_REGC, RK3288_LVDS_CFG_REGC_PLL_ENABLE);
+	rk3288_writel(lvds, RK3288_LVDS_CFG_REG21,
+		      RK3288_LVDS_CFG_REG21_TX_ENABLE);
+	rk3288_writel(lvds, RK3288_LVDS_CFG_REGC,
+		      RK3288_LVDS_CFG_REGC_PLL_ENABLE);
 	val = LVDS_DUAL | LVDS_TTL_EN | LVDS_CH0_EN | LVDS_CH1_EN | LVDS_PWRDN;
 	val |= val << 16;
 	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con7, val);
@@ -208,8 +216,8 @@ struct drm_connector_helper_funcs rockchip_lvds_connector_helper_funcs = {
 	.get_modes = rockchip_lvds_connector_get_modes,
 };
 
-static void rockchip_lvds_grf_config(struct drm_encoder *encoder,
-				     struct drm_display_mode *mode)
+static void rk3288_lvds_grf_config(struct drm_encoder *encoder,
+				   struct drm_display_mode *mode)
 {
 	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
 	u8 pin_hsync = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 1 : 0;
@@ -240,8 +248,8 @@ static void rockchip_lvds_grf_config(struct drm_encoder *encoder,
 	}
 }
 
-static int rockchip_lvds_set_vop_source(struct rockchip_lvds *lvds,
-					struct drm_encoder *encoder)
+static int rk3288_lvds_set_vop_source(struct rockchip_lvds *lvds,
+				      struct drm_encoder *encoder)
 {
 	u32 val;
 	int ret;
@@ -277,36 +285,36 @@ rockchip_lvds_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
-static void rockchip_lvds_encoder_enable(struct drm_encoder *encoder)
+static void rk3288_lvds_encoder_enable(struct drm_encoder *encoder)
 {
 	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	int ret;
 
 	drm_panel_prepare(lvds->panel);
-	ret = rockchip_lvds_poweron(lvds);
+	ret = rk3288_lvds_poweron(lvds);
 	if (ret < 0) {
 		DRM_DEV_ERROR(lvds->dev, "failed to power on lvds: %d\n", ret);
 		drm_panel_unprepare(lvds->panel);
 	}
-	rockchip_lvds_grf_config(encoder, mode);
-	rockchip_lvds_set_vop_source(lvds, encoder);
+	rk3288_lvds_grf_config(encoder, mode);
+	rk3288_lvds_set_vop_source(lvds, encoder);
 	drm_panel_enable(lvds->panel);
 }
 
-static void rockchip_lvds_encoder_disable(struct drm_encoder *encoder)
+static void rk3288_lvds_encoder_disable(struct drm_encoder *encoder)
 {
 	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
 
 	drm_panel_disable(lvds->panel);
-	rockchip_lvds_poweroff(lvds);
+	rk3288_lvds_poweroff(lvds);
 	drm_panel_unprepare(lvds->panel);
 }
 
 static const
-struct drm_encoder_helper_funcs rockchip_lvds_encoder_helper_funcs = {
-	.enable = rockchip_lvds_encoder_enable,
-	.disable = rockchip_lvds_encoder_disable,
+struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
+	.enable = rk3288_lvds_encoder_enable,
+	.disable = rk3288_lvds_encoder_disable,
 	.atomic_check = rockchip_lvds_encoder_atomic_check,
 };
 
@@ -377,7 +385,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		/* default set it as output rgb */
 		lvds->output = DISPLAY_OUTPUT_RGB;
 	else
-		lvds->output = lvds_name_to_output(name);
+		lvds->output = rockchip_lvds_name_to_output(name);
 
 	if (lvds->output < 0) {
 		DRM_DEV_ERROR(dev, "invalid output type [%s]\n", name);
@@ -389,7 +397,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		/* default set it as format vesa 18 */
 		lvds->format = LVDS_VESA_18;
 	else
-		lvds->format = lvds_name_to_format(name);
+		lvds->format = rockchip_lvds_name_to_format(name);
 
 	if (lvds->format < 0) {
 		DRM_DEV_ERROR(dev, "invalid data-mapping format [%s]\n", name);
@@ -409,7 +417,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_remote;
 	}
 
-	drm_encoder_helper_add(encoder, &rockchip_lvds_encoder_helper_funcs);
+	drm_encoder_helper_add(encoder, &rk3288_lvds_encoder_helper_funcs);
 
 	if (lvds->panel) {
 		connector = &lvds->connector;
@@ -471,7 +479,7 @@ static void rockchip_lvds_unbind(struct device *dev, struct device *master,
 {
 	struct rockchip_lvds *lvds = dev_get_drvdata(dev);
 
-	rockchip_lvds_encoder_disable(&lvds->encoder);
+	rk3288_lvds_encoder_disable(&lvds->encoder);
 	if (lvds->panel)
 		drm_panel_detach(lvds->panel);
 	pm_runtime_disable(dev);
-- 
2.20.1

