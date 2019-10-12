Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1DECE58D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D849621835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfJLDH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 23:07:56 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727587AbfJLDHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:07:55 -0400
X-UUID: 211e86fed14241ec87e46723ee631fe7-20191012
X-UUID: 211e86fed14241ec87e46723ee631fe7-20191012
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1339549916; Sat, 12 Oct 2019 11:07:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Oct
 2019 11:07:46 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sat, 12 Oct 2019 11:07:45 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 4/8] drm/panel: support for auo,kd101n80-45na wuxga dsi video mode panel
Date:   Sat, 12 Oct 2019 11:07:16 +0800
Message-ID: <20191012030720.27127-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012030720.27127-1-jitao.shi@mediatek.com>
References: <20191012030720.27127-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 3293A786B18C77DCA1B533F34E143959039A4E396C5B2CC907EC01FABA3A25D82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auo,kd101n80-45na's connector is same as boe,tv101wum-nl6.
The most codes can be reuse.
So auo,kd101n80-45na and boe,tv101wum-nl6 use one driver file.
Add the different parts in driver data.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  6 +-
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 86 ++++++++++++++++---
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index afcadb3585fb..0e887c978796 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -19,13 +19,13 @@ config DRM_PANEL_ARM_VERSATILE
 	  in the Versatile family syscon registers.
 
 config DRM_PANEL_BOE_TV101WUM_NL6
-	tristate "BOE TV101WUM 1200x1920 panel"
+	tristate "BOE TV101WUM and AUO KD101N80 45NA 1200x1920 panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
-	  Say Y here if you want to support for BOE TV101WUM WUXGA PANEL
-	  DSI Video Mode panel
+	  Say Y here if you want to support for BOE TV101WUM and AUO KD101N80
+	  45NA WUXGA PANEL DSI Video Mode panel
 
 config DRM_PANEL_LVDS
 	tristate "Generic LVDS panel driver"
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index af68236ea0e8..e6457f87bc61 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -35,6 +35,7 @@ struct panel_desc {
 	enum mipi_dsi_pixel_format format;
 	const struct panel_init_cmd *init_cmds;
 	unsigned int lanes;
+	bool discharge_on_disable;
 };
 
 struct boe_panel {
@@ -372,6 +373,15 @@ static const struct panel_init_cmd boe_init_cmd[] = {
 	{},
 };
 
+static const struct panel_init_cmd auo_kd101n80_45na_init_cmd[] = {
+	_INIT_DELAY_CMD(24),
+	_INIT_DCS_CMD(0x11),
+	_INIT_DELAY_CMD(120),
+	_INIT_DCS_CMD(0x29),
+	_INIT_DELAY_CMD(120),
+	{},
+};
+
 static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct boe_panel, base);
@@ -452,20 +462,30 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 	if (!boe->prepared)
 		return 0;
 
-	ret = boe_panel_off(boe);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
-		return ret;
+	if (boe->desc->discharge_on_disable) {
+		msleep(150);
+		regulator_disable(boe->avee);
+		regulator_disable(boe->avdd);
+		usleep_range(5000, 7000);
+		gpiod_set_value(boe->enable_gpio, 0);
+		usleep_range(5000, 7000);
+		regulator_disable(boe->pp1800);
+	} else {
+		ret = boe_panel_off(boe);
+		if (ret < 0) {
+			dev_err(panel->dev, "failed to set panel off: %d\n",
+				ret);
+			return ret;
+		}
+		msleep(150);
+		gpiod_set_value(boe->enable_gpio, 0);
+		usleep_range(500, 1000);
+		regulator_disable(boe->avee);
+		regulator_disable(boe->avdd);
+		usleep_range(5000, 7000);
+		regulator_disable(boe->pp1800);
 	}
 
-	msleep(150);
-	gpiod_set_value(boe->enable_gpio, 0);
-	usleep_range(500, 1000);
-	regulator_disable(boe->avee);
-	regulator_disable(boe->avdd);
-	usleep_range(5000, 7000);
-	regulator_disable(boe->pp1800);
-
 	boe->prepared = false;
 
 	return 0;
@@ -495,10 +515,14 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	if (ret < 0)
 		goto poweroffavdd;
 
-	msleep(100);
+	usleep_range(5000, 10000);
 
 	gpiod_set_value(boe->enable_gpio, 1);
-	usleep_range(10000, 12000);
+	usleep_range(1000, 2000);
+	gpiod_set_value(boe->enable_gpio, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value(boe->enable_gpio, 1);
+	usleep_range(6000, 10000);
 
 	ret = boe_panel_init(boe);
 	if (ret < 0) {
@@ -530,6 +554,8 @@ static int boe_panel_enable(struct drm_panel *panel)
 	if (boe->enabled)
 		return 0;
 
+	msleep(130);
+
 	ret = backlight_enable(boe->backlight);
 	if (ret) {
 		dev_err(panel->dev, "Failed to enable backlight %d\n",
@@ -567,6 +593,35 @@ static const struct panel_desc boe_tv101wum_nl6_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = boe_init_cmd,
+	.discharge_on_disable = false,
+};
+
+static const struct drm_display_mode auo_kd101n80_45na_default_mode = {
+	.clock = 157000,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 80,
+	.hsync_end = 1200 + 80 + 24,
+	.htotal = 1200 + 80 + 24 + 36,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 16,
+	.vsync_end = 1920 + 16 + 4,
+	.vtotal = 1920 + 16 + 4 + 16,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_kd101n80_45na_desc = {
+	.modes = &auo_kd101n80_45na_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 135,
+		.height_mm = 216,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init_cmds = auo_kd101n80_45na_init_cmd,
+	.discharge_on_disable = true,
 };
 
 static int boe_panel_get_modes(struct drm_panel *panel)
@@ -693,6 +748,9 @@ static const struct of_device_id boe_of_match[] = {
 	{ .compatible = "boe,tv101wum-nl6",
 	  .data = &boe_tv101wum_nl6_desc
 	},
+	{ .compatible = "auo,kd101n80-45na",
+	  .data = &auo_kd101n80_45na_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_of_match);
-- 
2.21.0

