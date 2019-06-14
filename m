Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5610BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F0621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjIapLAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFNTCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:02:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33280 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:02:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so2062643pga.0;
        Fri, 14 Jun 2019 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q4CwzHvSxPdrHbLfdvEnU6XX5mvUWE4s13V3F5wL12w=;
        b=qjIapLAZMVuaAJkOeMRv+8i9iLR84SVKaupIVQsaLF0hzsAZYOnverun5g6jQcwYvR
         z0wRvqyGkeiHYxRTApMjfTIf8Hpf9ZwV1z4LxYcgpedll0fryUO6937UFxqVzo83aO2A
         oROiCTPfXs9tEFuUvws7SZcpWrsWoR4NyG2s/1k3lXf/isUTJsqYCDTVAuA+qwxM4yCP
         +iz+2GTUXiamJCLBw2kx0ZrhO8K0lArk7xf3G8q2kLkaXX4TDP9cc7VIfsMV8PRC5O7j
         sfhjqyIyKtwKI1H5wLGd+idzysSkpM6f6yaq5D4m6Wzr+YwjaPp2JIhtNNfielVHHT2N
         346g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q4CwzHvSxPdrHbLfdvEnU6XX5mvUWE4s13V3F5wL12w=;
        b=ZkqM+yq6389EJujgkkzgL1FSWTzii5Qod1HooJGZ8Y5o0c6FhJOq6Lz0hoVaWDuTvq
         cyoAj/wUGGm+wgdTj/7KTf70j0Vf9wjItSV9DGMAtb2oQziS4XML+xPjRq9J4A/Uh/HO
         XeDPZKJaOvIY1lOO9igcw3AFYd/CK4VXYjr1jNavauGjM1bx1Uum+NhzKObsI3vjHcYV
         Nvi2TqoT2QtHILXF9iltq8JnaKEwshKqTtbrQqJY+778bEQcyuVbtcuDM/KNqX5VSPtf
         LOF5HafEGs7/VZrzJ3mNErJLgbuy1GANBP4xkD5xykeORorLWAXaR6LpW8MOgHTQS/rk
         oJVA==
X-Gm-Message-State: APjAAAVBi09lTp1bKyplk1FFX1udLj03dYaUsMAVpofmJjbziWJGE0kP
        4xzMiLj/7Jbu15ODGMvVSSA=
X-Google-Smtp-Source: APXvYqxq86nvk7En+2k6Qmb/e8xJH64H+1W/yXHf3yXI+rH8Q7VcbhbG90OHDiI6i/RtgLk0xZk3Wg==
X-Received: by 2002:a63:ec42:: with SMTP id r2mr38185907pgj.262.1560538969771;
        Fri, 14 Jun 2019 12:02:49 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9sm3507675pgj.34.2019.06.14.12.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 12:02:49 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        sam@ravnborg.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH 2/2] drm/panel: truly: Add MSM8998 MTP support
Date:   Fri, 14 Jun 2019 12:02:46 -0700
Message-Id: <20190614190246.34617-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
References: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8998 MTP is the MSM8998 reference platform, and like the SDM845 MTP
it uses the Truly NT35587 Display driver.  However, unlike the SDM845 MTP,
the instance in the MSM8998 MTP is a single DSI interface, command mode
type panel that supports a WQHD resolution and requires DSC compression.

Add support for the MSM8998 MTP by extending the driver to handle both
configurations.

Note that the delay after the reset has been de-asserted has been extended
to 100 ms.  Through experimentation, it has been determined that the
MSM8998 instance requires a 50 ms delay between reset de-assert and sending
configuration commands for the display to work.  Significantly shorter
than that, and timeouts/errors occur signaling a non-working display.
Shorter than 50 ms, but in the ball park, results in no "loud" errors, but
nothing is displayed.  100 ms is used since double the minimum should
guarantee enough delay for the device to finish whatever reset processing
seems necessary, while also providing a safe buffer incase the experimental
measurement was somehow not accurate enough for everyone.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/gpu/drm/panel/panel-truly-nt35597.c | 149 +++++++++++++++-----
 1 file changed, 112 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index 77e1311b7c69..5ee76acb8f49 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -49,6 +49,8 @@ struct nt35597_config {
 	const struct cmd_set *panel_on_cmds;
 	u32 num_on_cmds;
 	const struct drm_display_mode *dm;
+	bool dual_dsi; /* true if panel uses two dsi connections */
+	bool cmd_type; /* true if panel is command mode type, not video mode */
 };
 
 struct truly_nt35597 {
@@ -63,6 +65,7 @@ struct truly_nt35597 {
 	struct backlight_device *backlight;
 
 	struct mipi_dsi_device *dsi[2];
+	int num_dsi;
 
 	const struct nt35597_config *config;
 	bool prepared;
@@ -223,12 +226,42 @@ static const struct cmd_set qcom_2k_panel_magic_cmds[] = {
 	{ { 0xFB, 0x01 }, 2 },
 };
 
+static const struct cmd_set qcom_wqhd_cmd_dsc_panel_magic_cmds[] = {
+	{ { 0xff, 0x10 }, 2 },
+	{ { 0xfb, 0x01 }, 2 },
+	{ { 0xba, 0x03 }, 2 },
+	{ { 0xe5, 0x01 }, 2 },
+	{ { 0xb0, 0x03 }, 2 },
+	{ { 0xff, 0x28 }, 2 },
+	{ { 0x7a, 0x02 }, 2 },
+	{ { 0xfb, 0x01 }, 2 },
+	{ { 0xff, 0x10 }, 2 },
+	{ { 0xfb, 0x01 }, 2 },
+	{ { 0xc0, 0x03 }, 2 },
+	{ { 0xbb, 0x10 }, 2 },
+	{ { 0xff, 0xe0 }, 2 },
+	{ { 0xfb, 0x01 }, 2 },
+	{ { 0x6b, 0x3d }, 2 },
+	{ { 0x6c, 0x3d }, 2 },
+	{ { 0x6d, 0x3d }, 2 },
+	{ { 0x6e, 0x3d }, 2 },
+	{ { 0x6f, 0x3d }, 2 },
+	{ { 0x35, 0x02 }, 2 },
+	{ { 0x36, 0x72 }, 2 },
+	{ { 0x37, 0x10 }, 2 },
+	{ { 0x08, 0xc0 }, 2 },
+	{ { 0xff, 0x24 }, 2 },
+	{ { 0xfb, 0x01 }, 2 },
+	{ { 0xc6, 0x06 }, 2 },
+	{ { 0xff, 0x10 }, 2 },
+};
+
 static int truly_dcs_write(struct drm_panel *panel, u32 command)
 {
 	struct truly_nt35597 *ctx = panel_to_ctx(panel);
-	int i, ret;
+	int i, ret = 0;
 
-	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
+	for (i = 0; i < ctx->num_dsi; i++) {
 		ret = mipi_dsi_dcs_write(ctx->dsi[i], command, NULL, 0);
 		if (ret < 0) {
 			DRM_DEV_ERROR(ctx->dev,
@@ -247,7 +280,7 @@ static int truly_dcs_write_buf(struct drm_panel *panel,
 	int ret = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
+	for (i = 0; i < ctx->num_dsi; i++) {
 		ret = mipi_dsi_dcs_write_buffer(ctx->dsi[i], buf, size);
 		if (ret < 0) {
 			DRM_DEV_ERROR(ctx->dev,
@@ -284,7 +317,7 @@ static int truly_35597_power_on(struct truly_nt35597 *ctx)
 	gpiod_set_value(ctx->reset_gpio, 1);
 	usleep_range(10000, 20000);
 	gpiod_set_value(ctx->reset_gpio, 0);
-	usleep_range(10000, 20000);
+	msleep(100);
 
 	return 0;
 }
@@ -342,7 +375,8 @@ static int truly_nt35597_unprepare(struct drm_panel *panel)
 		return 0;
 
 	ctx->dsi[0]->mode_flags = 0;
-	ctx->dsi[1]->mode_flags = 0;
+	if (ctx->config->dual_dsi)
+		ctx->dsi[1]->mode_flags = 0;
 
 	ret = truly_dcs_write(panel, MIPI_DCS_SET_DISPLAY_OFF);
 	if (ret < 0) {
@@ -384,10 +418,12 @@ static int truly_nt35597_prepare(struct drm_panel *panel)
 	if (ret < 0)
 		return ret;
 
+	config = ctx->config;
+
 	ctx->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
-	ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
+	if (config->dual_dsi)
+		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	config = ctx->config;
 	panel_on_cmds = config->panel_on_cmds;
 	num_cmds = config->num_on_cmds;
 
@@ -515,8 +551,10 @@ static int truly_nt35597_panel_add(struct truly_nt35597 *ctx)
 		return PTR_ERR(ctx->mode_gpio);
 	}
 
-	/* dual port */
-	gpiod_set_value(ctx->mode_gpio, 0);
+	if (config->dual_dsi)
+		gpiod_set_value(ctx->mode_gpio, 0);
+	else
+		gpiod_set_value(ctx->mode_gpio, 1);
 
 	drm_panel_init(&ctx->panel);
 	ctx->panel.dev = dev;
@@ -541,6 +579,21 @@ static const struct drm_display_mode qcom_sdm845_mtp_2k_mode = {
 	.flags = 0,
 };
 
+static const struct drm_display_mode qcom_msm8998_mtp_wqhd_mode = {
+	.name = "1440x2560",
+	.clock = 113447,
+	.hdisplay = 1440,
+	.hsync_start = 1440 + 154,
+	.hsync_end = 1440 + 154 + 32,
+	.htotal = 1440 + 154 + 32 + 68,
+	.vdisplay = 2560,
+	.vsync_start = 2560 + 8,
+	.vsync_end = 2560 + 8 + 1,
+	.vtotal = 2560 + 8 + 1 + 7,
+	.vrefresh = 60,
+	.flags = 0,
+};
+
 static const struct nt35597_config nt35597_dir = {
 	.width_mm = 74,
 	.height_mm = 131,
@@ -548,13 +601,24 @@ static const struct nt35597_config nt35597_dir = {
 	.dm = &qcom_sdm845_mtp_2k_mode,
 	.panel_on_cmds = qcom_2k_panel_magic_cmds,
 	.num_on_cmds = ARRAY_SIZE(qcom_2k_panel_magic_cmds),
+	.dual_dsi = true,
+};
+
+static const struct nt35597_config msm8998_mtp = {
+	.width_mm = 74,
+	.height_mm = 131,
+	.panel_name = "qcom_msm8998_mtp_wqhd_panel",
+	.dm = &qcom_msm8998_mtp_wqhd_mode,
+	.panel_on_cmds = qcom_wqhd_cmd_dsc_panel_magic_cmds,
+	.num_on_cmds = ARRAY_SIZE(qcom_wqhd_cmd_dsc_panel_magic_cmds),
+	.cmd_type = true,
 };
 
 static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
 	struct truly_nt35597 *ctx;
-	struct mipi_dsi_device *dsi1_device;
+	struct mipi_dsi_device *dsi1_device = NULL;
 	struct device_node *dsi1;
 	struct mipi_dsi_host *dsi1_host;
 	struct mipi_dsi_device *dsi_dev;
@@ -572,13 +636,6 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
-	/*
-	 * This device represents itself as one with two input ports which are
-	 * fed by the output ports of the two DSI controllers . The DSI0 is
-	 * the master controller and has most of the panel related info in its
-	 * child node.
-	 */
-
 	ctx->config = of_device_get_match_data(dev);
 
 	if (!ctx->config) {
@@ -586,25 +643,36 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 		return -ENODEV;
 	}
 
-	dsi1 = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
-	if (!dsi1) {
-		DRM_DEV_ERROR(dev,
-			"failed to get remote node for dsi1_device\n");
-		return -ENODEV;
-	}
+	ctx->num_dsi = 1;
+	/*
+	 * This device represents itself as one with two input ports which are
+	 * fed by the output ports of the two DSI controllers . The DSI0 is
+	 * the master controller and has most of the panel related info in its
+	 * child node.
+	 */
+	if (ctx->config->dual_dsi) {
+		ctx->num_dsi = 2;
 
-	dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
-	of_node_put(dsi1);
-	if (!dsi1_host) {
-		DRM_DEV_ERROR(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+		dsi1 = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
+		if (!dsi1) {
+			DRM_DEV_ERROR(dev,
+				"failed to get remote node for dsi1_device\n");
+			return -ENODEV;
+		}
+
+		dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
+		of_node_put(dsi1);
+		if (!dsi1_host) {
+			DRM_DEV_ERROR(dev, "failed to find dsi host\n");
+			return -EPROBE_DEFER;
+		}
 
-	/* register the second DSI device */
-	dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);
-	if (IS_ERR(dsi1_device)) {
-		DRM_DEV_ERROR(dev, "failed to create dsi device\n");
-		return PTR_ERR(dsi1_device);
+		/* register the second DSI device */
+		dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);
+		if (IS_ERR(dsi1_device)) {
+			DRM_DEV_ERROR(dev, "failed to create dsi device\n");
+			return PTR_ERR(dsi1_device);
+		}
 	}
 
 	mipi_dsi_set_drvdata(dsi, ctx);
@@ -619,12 +687,14 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 		goto err_panel_add;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
+	for (i = 0; i < ctx->num_dsi; i++) {
 		dsi_dev = ctx->dsi[i];
 		dsi_dev->lanes = 4;
 		dsi_dev->format = MIPI_DSI_FMT_RGB888;
-		dsi_dev->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM |
+		dsi_dev->mode_flags =  MIPI_DSI_MODE_LPM |
 			MIPI_DSI_CLOCK_NON_CONTINUOUS;
+		if (!ctx->config->cmd_type)
+			dsi_dev->mode_flags |= MIPI_DSI_MODE_VIDEO;
 		ret = mipi_dsi_attach(dsi_dev);
 		if (ret < 0) {
 			DRM_DEV_ERROR(dev,
@@ -638,7 +708,8 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 err_dsi_attach:
 	drm_panel_remove(&ctx->panel);
 err_panel_add:
-	mipi_dsi_device_unregister(dsi1_device);
+	if (ctx->config->dual_dsi)
+		mipi_dsi_device_unregister(dsi1_device);
 	return ret;
 }
 
@@ -662,6 +733,10 @@ static const struct of_device_id truly_nt35597_of_match[] = {
 		.compatible = "truly,nt35597-2K-display",
 		.data = &nt35597_dir,
 	},
+	{
+		.compatible = "truly,nt35597-wqhd-cmd-dsc-display",
+		.data = &msm8998_mtp,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, truly_nt35597_of_match);
-- 
2.17.1

