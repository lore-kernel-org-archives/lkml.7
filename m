Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F64207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI7EB+RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfLJIhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:37:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40236 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLJIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:37:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so8541641pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YOvetV4MVRRWPou2An5hVJNwBVfKLVagoiSqtpV5io=;
        b=lI7EB+RNXO2IOAaBP8QoxppbUYFi64K6owYRv+tg2UUiwIHPW5/xeQov8v2Wgeyou1
         XOQmtySV1DmVOmya4O3i/VN0IbkVt1axGw02ocTBXjAbiiqo5UQ7e0o5tMfZ1UdS+f9W
         vtR3SlhJhAw8MeD9jA+zBDqia0JaeNILol5rjIruBWt1NL1BXHsDugi6AFCQflS5PLFy
         6wn5tXmPhmsMmQct9bPxJ9pQsXbxESplbAOoCSGY2Ac3RVpMnLJrrEcLAxCsghVdZkFC
         idkTcZj36eVEtZm57o57N0bQ4KOjbCSeynaZx8QDJmKUFYbsZPYfTt8kAGTQwXRMCnV0
         8vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YOvetV4MVRRWPou2An5hVJNwBVfKLVagoiSqtpV5io=;
        b=Ll6+a+RSykPAX63KqkFVBp3Wnrvj+/SJYR1l/onrmhjy6M78w/Q98JLjTYXlVVkpoC
         71wVxuMojXk8ueCYZD0vChgpc+Q4bjd9xwpjmWvcwpShuTRhE9CTJ/h10011OWInuQSM
         rIezc1jL59YVKOwvhbI9wN4h9HLGW2RItcs6pys/YnSdDZyT7kJyoTxbHNUdrs5wY7Mw
         FasmP410O8fhMkaYSd8l/eiJv+8b1YoFwdL5wn02sXAM/HuoSZIZKqG3TSe/99B8suVr
         0pJZcplPo1GtfUsQphSHlUGHSLtFe7t96tAH1VejruFDgbj9QFZdLWUMJPMXF38dcz4m
         a7rg==
X-Gm-Message-State: APjAAAXxph8m5G2uWFxAxmkewT0SQehutWPFVn1Djh0FfVUBD++zPKkT
        aw62jI8NKp698wCWxA97Kf8=
X-Google-Smtp-Source: APXvYqzW5DPlSfWwIpXSCL6evLBhPC6okvck3EI2x3qAk5xyMoX4lwHt8lzwnWi2YPzDWoEejOVA2g==
X-Received: by 2002:a63:1b54:: with SMTP id b20mr23239679pgm.312.1575967039849;
        Tue, 10 Dec 2019 00:37:19 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y128sm2246632pfg.17.2019.12.10.00.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:37:19 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC 8/8] drm/sprd: add Unisoc's drm generic mipi panel driver
Date:   Tue, 10 Dec 2019 16:36:35 +0800
Message-Id: <1575966995-13757-9-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

This is a generic mipi dsi panel driver, All the parameters related
to lcd panel, we are placed in the DTS to configure,
for example，lcd display timing, dpi parameter and more.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 drivers/gpu/drm/sprd/Makefile     |   3 +-
 drivers/gpu/drm/sprd/sprd_panel.c | 778 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sprd/sprd_panel.h | 114 ++++++
 3 files changed, 894 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sprd/sprd_panel.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_panel.h

diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makefile
index 78d3ddb..30a581c 100644
--- a/drivers/gpu/drm/sprd/Makefile
+++ b/drivers/gpu/drm/sprd/Makefile
@@ -8,7 +8,8 @@ obj-y := sprd_drm.o \
 	sprd_gem.o \
 	sprd_dpu.o \
 	sprd_dsi.o \
-	sprd_dphy.o
+	sprd_dphy.o \
+	sprd_panel.o
 
 obj-y += disp_lib.o
 obj-y += dpu/
diff --git a/drivers/gpu/drm/sprd/sprd_panel.c b/drivers/gpu/drm/sprd/sprd_panel.c
new file mode 100644
index 0000000..4a70a20
--- /dev/null
+++ b/drivers/gpu/drm/sprd/sprd_panel.c
@@ -0,0 +1,778 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Unisoc Inc.
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <linux/backlight.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/pm_runtime.h>
+#include <video/mipi_display.h>
+#include <video/of_display_timing.h>
+#include <video/videomode.h>
+
+#include "sprd_dpu.h"
+#include "sprd_panel.h"
+#include "dsi/sprd_dsi_api.h"
+
+#define SPRD_MIPI_DSI_FMT_DSC 0xff
+static DEFINE_MUTEX(panel_lock);
+
+static const char *lcd_name;
+
+static inline struct sprd_panel *to_sprd_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct sprd_panel, base);
+}
+
+static int sprd_panel_send_cmds(struct mipi_dsi_device *dsi,
+				const void *data, int size)
+{
+	struct sprd_panel *panel;
+	const struct dsi_cmd_desc *cmds = data;
+	u16 len;
+
+	if (cmds == NULL || dsi == NULL)
+		return -EINVAL;
+
+	panel = mipi_dsi_get_drvdata(dsi);
+
+	while (size > 0) {
+		len = (cmds->wc_h << 8) | cmds->wc_l;
+
+		if (panel->info.use_dcs)
+			mipi_dsi_dcs_write_buffer(dsi, cmds->payload, len);
+		else
+			mipi_dsi_generic_write(dsi, cmds->payload, len);
+
+		if (cmds->wait)
+			msleep(cmds->wait);
+		cmds = (const struct dsi_cmd_desc *)(cmds->payload + len);
+		size -= (len + 4);
+	}
+
+	return 0;
+}
+
+static int sprd_panel_unprepare(struct drm_panel *p)
+{
+	struct sprd_panel *panel = to_sprd_panel(p);
+	struct gpio_timing *timing;
+	int items, i;
+
+	DRM_INFO("%s()\n", __func__);
+
+	if (panel->info.avee_gpio) {
+		gpiod_direction_output(panel->info.avee_gpio, 0);
+		mdelay(5);
+	}
+
+	if (panel->info.avdd_gpio) {
+		gpiod_direction_output(panel->info.avdd_gpio, 0);
+		mdelay(5);
+	}
+
+	if (panel->info.reset_gpio) {
+		items = panel->info.rst_off_seq.items;
+		timing = panel->info.rst_off_seq.timing;
+		for (i = 0; i < items; i++) {
+			gpiod_direction_output(panel->info.reset_gpio,
+						timing[i].level);
+			mdelay(timing[i].delay);
+		}
+	}
+
+	regulator_disable(panel->supply);
+
+	return 0;
+}
+
+static int sprd_panel_prepare(struct drm_panel *p)
+{
+	struct sprd_panel *panel = to_sprd_panel(p);
+	struct gpio_timing *timing;
+	int items, i, ret;
+
+	DRM_INFO("%s()\n", __func__);
+
+	ret = regulator_enable(panel->supply);
+	if (ret < 0) {
+		DRM_ERROR("enable lcd regulator failed\n");
+		return ret;
+	}
+
+	if (panel->info.avdd_gpio) {
+		gpiod_direction_output(panel->info.avdd_gpio, 1);
+		mdelay(5);
+	}
+
+	if (panel->info.avee_gpio) {
+		gpiod_direction_output(panel->info.avee_gpio, 1);
+		mdelay(5);
+	}
+
+	if (panel->info.reset_gpio) {
+		items = panel->info.rst_on_seq.items;
+		timing = panel->info.rst_on_seq.timing;
+		for (i = 0; i < items; i++) {
+			gpiod_direction_output(panel->info.reset_gpio,
+						timing[i].level);
+			mdelay(timing[i].delay);
+		}
+	}
+
+	return 0;
+}
+
+static int sprd_panel_disable(struct drm_panel *p)
+{
+	struct sprd_panel *panel = to_sprd_panel(p);
+
+	DRM_INFO("%s()\n", __func__);
+
+	mutex_lock(&panel_lock);
+	/*
+	 * FIXME:
+	 * The cancel work should be executed before DPU stop,
+	 * otherwise the esd check will be failed if the DPU
+	 * stopped in video mode and the DSI has not change to
+	 * CMD mode yet. Since there is no VBLANK timing for
+	 * LP cmd transmission.
+	 */
+	if (panel->esd_work_pending) {
+		cancel_delayed_work_sync(&panel->esd_work);
+		panel->esd_work_pending = false;
+	}
+
+	if (panel->backlight) {
+		panel->backlight->props.power = FB_BLANK_POWERDOWN;
+		panel->backlight->props.state |= BL_CORE_FBBLANK;
+		backlight_update_status(panel->backlight);
+	}
+
+	sprd_panel_send_cmds(panel->slave,
+			     panel->info.cmds[CMD_CODE_SLEEP_IN],
+			     panel->info.cmds_len[CMD_CODE_SLEEP_IN]);
+
+	panel->is_enabled = false;
+	mutex_unlock(&panel_lock);
+
+	return 0;
+}
+
+static int sprd_panel_enable(struct drm_panel *p)
+{
+	struct sprd_panel *panel = to_sprd_panel(p);
+
+	DRM_INFO("%s()\n", __func__);
+
+	mutex_lock(&panel_lock);
+	sprd_panel_send_cmds(panel->slave,
+			     panel->info.cmds[CMD_CODE_INIT],
+			     panel->info.cmds_len[CMD_CODE_INIT]);
+
+	if (panel->backlight) {
+		panel->backlight->props.power = FB_BLANK_UNBLANK;
+		panel->backlight->props.state &= ~BL_CORE_FBBLANK;
+		backlight_update_status(panel->backlight);
+	}
+
+	if (panel->info.esd_check_en) {
+		schedule_delayed_work(&panel->esd_work,
+				      msecs_to_jiffies(1000));
+		panel->esd_work_pending = true;
+	}
+
+	panel->is_enabled = true;
+	mutex_unlock(&panel_lock);
+
+	return 0;
+}
+
+static int sprd_panel_get_modes(struct drm_panel *p)
+{
+	struct drm_display_mode *mode;
+	struct sprd_panel *panel = to_sprd_panel(p);
+	struct device_node *np = panel->slave->dev.of_node;
+	u32 surface_width = 0, surface_height = 0;
+	int i, mode_count = 0;
+
+	DRM_INFO("%s()\n", __func__);
+	mode = drm_mode_duplicate(p->drm, &panel->info.mode);
+	if (!mode) {
+		DRM_ERROR("failed to alloc mode %s\n", panel->info.mode.name);
+		return 0;
+	}
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(p->connector, mode);
+	mode_count++;
+
+	for (i = 1; i < panel->info.num_buildin_modes; i++)	{
+		mode = drm_mode_duplicate(p->drm,
+			&(panel->info.buildin_modes[i]));
+		if (!mode) {
+			DRM_ERROR("failed to alloc mode %s\n",
+				panel->info.buildin_modes[i].name);
+			return 0;
+		}
+		mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_DEFAULT;
+		drm_mode_probed_add(p->connector, mode);
+		mode_count++;
+	}
+
+	of_property_read_u32(np, "sprd,surface-width", &surface_width);
+	of_property_read_u32(np, "sprd,surface-height", &surface_height);
+	if (surface_width && surface_height) {
+		struct videomode vm = {};
+
+		vm.hactive = surface_width;
+		vm.vactive = surface_height;
+		vm.pixelclock = surface_width * surface_height * 60;
+
+		mode = drm_mode_create(p->drm);
+
+		mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_BUILTIN |
+			DRM_MODE_TYPE_CRTC_C;
+		mode->vrefresh = 60;
+		drm_display_mode_from_videomode(&vm, mode);
+		drm_mode_probed_add(p->connector, mode);
+		mode_count++;
+	}
+
+	p->connector->display_info.width_mm = panel->info.mode.width_mm;
+	p->connector->display_info.height_mm = panel->info.mode.height_mm;
+
+	return mode_count;
+}
+
+static const struct drm_panel_funcs sprd_panel_funcs = {
+	.get_modes = sprd_panel_get_modes,
+	.enable = sprd_panel_enable,
+	.disable = sprd_panel_disable,
+	.prepare = sprd_panel_prepare,
+	.unprepare = sprd_panel_unprepare,
+};
+
+static int sprd_panel_esd_check(struct sprd_panel *panel)
+{
+	struct panel_info *info = &panel->info;
+	u8 read_val = 0;
+
+	/* FIXME: we should enable HS cmd tx here */
+	mipi_dsi_set_maximum_return_packet_size(panel->slave, 1);
+	mipi_dsi_dcs_read(panel->slave, info->esd_check_reg,
+			  &read_val, 1);
+
+	/*
+	 * TODO:
+	 * Should we support multi-registers check in the future?
+	 */
+	if (read_val != info->esd_check_val) {
+		DRM_ERROR("esd check failed, read value = 0x%02x\n",
+			  read_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sprd_panel_te_check(struct sprd_panel *panel)
+{
+	static int te_wq_inited;
+	struct sprd_dpu *dpu;
+	int ret;
+	bool irq_occur;
+
+	if (!panel->base.connector ||
+	    !panel->base.connector->encoder ||
+	    !panel->base.connector->encoder->crtc) {
+		return 0;
+	}
+
+	dpu = container_of(panel->base.connector->encoder->crtc,
+		struct sprd_dpu, crtc);
+
+	if (!te_wq_inited) {
+		init_waitqueue_head(&dpu->ctx.te_wq);
+		te_wq_inited = 1;
+		dpu->ctx.evt_te = false;
+		DRM_INFO("%s init te waitqueue\n", __func__);
+	}
+
+	/* DPU TE irq maybe enabled in kernel */
+	if (!dpu->ctx.is_inited)
+		return 0;
+
+	dpu->ctx.te_check_en = true;
+
+	/* wait for TE interrupt */
+	ret = wait_event_interruptible_timeout(dpu->ctx.te_wq,
+		dpu->ctx.evt_te, msecs_to_jiffies(500));
+	if (!ret) {
+		/* double check TE interrupt through dpu_int_raw register */
+		if (dpu->core && dpu->core->check_raw_int) {
+			irq_occur = dpu->core->check_raw_int(&dpu->ctx,
+				DISPC_INT_TE_MASK);
+			if (!irq_occur) {
+				DRM_ERROR("TE esd timeout.\n");
+				ret = -ETIMEDOUT;
+			} else
+				DRM_WARN("TE occur, but isr schedule delay\n");
+		} else {
+			DRM_ERROR("TE esd timeout.\n");
+			ret = -ETIMEDOUT;
+		}
+	}
+
+	dpu->ctx.te_check_en = false;
+	dpu->ctx.evt_te = false;
+
+	return ret < 0 ? ret : 0;
+}
+
+static void sprd_panel_esd_work_func(struct work_struct *work)
+{
+	struct sprd_panel *panel = container_of(work, struct sprd_panel,
+						esd_work.work);
+	struct panel_info *info = &panel->info;
+	int ret;
+
+	if (info->esd_check_mode == ESD_MODE_REG_CHECK)
+		ret = sprd_panel_esd_check(panel);
+	else if (info->esd_check_mode == ESD_MODE_TE_CHECK)
+		ret = sprd_panel_te_check(panel);
+	else {
+		DRM_ERROR("unknown esd check mode:%d\n", info->esd_check_mode);
+		return;
+	}
+
+	if (ret && panel->base.connector && panel->base.connector->encoder) {
+		const struct drm_encoder_helper_funcs *funcs;
+		struct drm_encoder *encoder;
+
+		encoder = panel->base.connector->encoder;
+		funcs = encoder->helper_private;
+		panel->esd_work_pending = false;
+
+		if (encoder->crtc && encoder->crtc->state &&
+		    !encoder->crtc->state->active) {
+			DRM_INFO("skip esd recovery during panel suspend\n");
+			return;
+		}
+
+		DRM_INFO("====== esd recovery start ========\n");
+		funcs->disable(encoder);
+
+		if (!encoder->crtc->state->active) {
+			DRM_INFO("skip esd recovery if panel suspend\n");
+			return;
+		}
+		funcs->enable(encoder);
+		DRM_INFO("======= esd recovery end =========\n");
+	} else
+		schedule_delayed_work(&panel->esd_work,
+			msecs_to_jiffies(info->esd_check_period));
+}
+
+static int sprd_panel_gpio_request(struct device *dev,
+			struct sprd_panel *panel)
+{
+	panel->info.avdd_gpio = devm_gpiod_get_optional(dev,
+					"avdd", GPIOD_ASIS);
+	if (IS_ERR_OR_NULL(panel->info.avdd_gpio))
+		DRM_WARN("can't get panel avdd gpio: %ld\n",
+				 PTR_ERR(panel->info.avdd_gpio));
+
+	panel->info.avee_gpio = devm_gpiod_get_optional(dev,
+					"avee", GPIOD_ASIS);
+	if (IS_ERR_OR_NULL(panel->info.avee_gpio))
+		DRM_WARN("can't get panel avee gpio: %ld\n",
+				 PTR_ERR(panel->info.avee_gpio));
+
+	panel->info.reset_gpio = devm_gpiod_get_optional(dev,
+					"reset", GPIOD_ASIS);
+	if (IS_ERR_OR_NULL(panel->info.reset_gpio))
+		DRM_WARN("can't get panel reset gpio: %ld\n",
+				 PTR_ERR(panel->info.reset_gpio));
+
+	return 0;
+}
+
+static int of_parse_reset_seq(struct device_node *np,
+				struct panel_info *info)
+{
+	struct property *prop;
+	int bytes, rc;
+	u32 *p;
+
+	prop = of_find_property(np, "sprd,reset-on-sequence", &bytes);
+	if (!prop) {
+		DRM_ERROR("sprd,reset-on-sequence property not found\n");
+		return -EINVAL;
+	}
+
+	p = kzalloc(bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	rc = of_property_read_u32_array(np, "sprd,reset-on-sequence",
+					p, bytes / 4);
+	if (rc) {
+		DRM_ERROR("parse sprd,reset-on-sequence failed\n");
+		kfree(p);
+		return rc;
+	}
+
+	info->rst_on_seq.items = bytes / 8;
+	info->rst_on_seq.timing = (struct gpio_timing *)p;
+
+	prop = of_find_property(np, "sprd,reset-off-sequence", &bytes);
+	if (!prop) {
+		DRM_ERROR("sprd,reset-off-sequence property not found\n");
+		return -EINVAL;
+	}
+
+	p = kzalloc(bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	rc = of_property_read_u32_array(np, "sprd,reset-off-sequence",
+					p, bytes / 4);
+	if (rc) {
+		DRM_ERROR("parse sprd,reset-off-sequence failed\n");
+		kfree(p);
+		return rc;
+	}
+
+	info->rst_off_seq.items = bytes / 8;
+	info->rst_off_seq.timing = (struct gpio_timing *)p;
+
+	return 0;
+}
+
+static int of_parse_buildin_modes(struct panel_info *info,
+	struct device_node *lcd_node)
+{
+	int i, rc, num_timings;
+	struct device_node *timings_np;
+
+
+	timings_np = of_get_child_by_name(lcd_node, "display-timings");
+	if (!timings_np) {
+		DRM_ERROR("%s: can not find display-timings node\n",
+			lcd_node->name);
+		return -ENODEV;
+	}
+
+	num_timings = of_get_child_count(timings_np);
+	if (num_timings == 0) {
+		/* should never happen, as entry was already found above */
+		DRM_ERROR("%s: no timings specified\n", lcd_node->name);
+		goto done;
+	}
+
+	info->buildin_modes = kzalloc(sizeof(struct drm_display_mode) *
+				num_timings, GFP_KERNEL);
+
+	for (i = 0; i < num_timings; i++) {
+		rc = of_get_drm_display_mode(lcd_node,
+			&info->buildin_modes[i], NULL, i);
+		if (rc) {
+			DRM_ERROR("get display timing failed\n");
+			goto entryfail;
+		}
+
+		info->buildin_modes[i].width_mm = info->mode.width_mm;
+		info->buildin_modes[i].height_mm = info->mode.height_mm;
+		info->buildin_modes[i].vrefresh = info->mode.vrefresh;
+	}
+	info->num_buildin_modes = num_timings;
+	DRM_INFO("info->num_buildin_modes = %d\n", num_timings);
+	goto done;
+
+entryfail:
+	kfree(info->buildin_modes);
+done:
+	of_node_put(timings_np);
+
+	return 0;
+}
+
+static int sprd_panel_parse_dt(struct device_node *np, struct sprd_panel *panel)
+{
+	u32 val;
+	struct device_node *lcd_node;
+	struct panel_info *info = &panel->info;
+	int bytes, rc;
+	const void *p;
+	const char *str;
+	char lcd_path[60];
+
+	sprintf(lcd_path, "/lcds/%s", lcd_name);
+	lcd_node = of_find_node_by_path(lcd_path);
+	if (!lcd_node) {
+		DRM_ERROR("%pOF: could not find %s node\n", np, lcd_name);
+		return -ENODEV;
+	}
+	info->of_node = lcd_node;
+
+	rc = of_property_read_u32(lcd_node, "sprd,dsi-work-mode", &val);
+	if (!rc) {
+		if (val == SPRD_DSI_MODE_CMD)
+			info->mode_flags = 0;
+		else if (val == SPRD_DSI_MODE_VIDEO_BURST)
+			info->mode_flags = MIPI_DSI_MODE_VIDEO |
+					   MIPI_DSI_MODE_VIDEO_BURST;
+		else if (val == SPRD_DSI_MODE_VIDEO_SYNC_PULSE)
+			info->mode_flags = MIPI_DSI_MODE_VIDEO |
+					   MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+		else if (val == SPRD_DSI_MODE_VIDEO_SYNC_EVENT)
+			info->mode_flags = MIPI_DSI_MODE_VIDEO;
+	} else {
+		DRM_ERROR("dsi work mode is not found! use video mode\n");
+		info->mode_flags = MIPI_DSI_MODE_VIDEO |
+				   MIPI_DSI_MODE_VIDEO_BURST;
+	}
+
+	if (of_property_read_bool(lcd_node, "sprd,dsi-non-continuous-clock"))
+		info->mode_flags |= MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	rc = of_property_read_u32(lcd_node, "sprd,dsi-lane-number", &val);
+	if (!rc)
+		info->lanes = val;
+	else
+		info->lanes = 4;
+
+	rc = of_property_read_string(lcd_node, "sprd,dsi-color-format", &str);
+	if (rc)
+		info->format = MIPI_DSI_FMT_RGB888;
+	else if (!strcmp(str, "rgb888"))
+		info->format = MIPI_DSI_FMT_RGB888;
+	else if (!strcmp(str, "rgb666"))
+		info->format = MIPI_DSI_FMT_RGB666;
+	else if (!strcmp(str, "rgb666_packed"))
+		info->format = MIPI_DSI_FMT_RGB666_PACKED;
+	else if (!strcmp(str, "rgb565"))
+		info->format = MIPI_DSI_FMT_RGB565;
+	else if (!strcmp(str, "dsc"))
+		info->format = SPRD_MIPI_DSI_FMT_DSC;
+	else
+		DRM_ERROR("dsi-color-format (%s) is not supported\n", str);
+
+	rc = of_property_read_u32(lcd_node, "width-mm", &val);
+	if (!rc)
+		info->mode.width_mm = val;
+	else
+		info->mode.width_mm = 68;
+
+	rc = of_property_read_u32(lcd_node, "height-mm", &val);
+	if (!rc)
+		info->mode.height_mm = val;
+	else
+		info->mode.height_mm = 121;
+
+	rc = of_property_read_u32(lcd_node, "sprd,esd-check-enable", &val);
+	if (!rc)
+		info->esd_check_en = val;
+
+	rc = of_property_read_u32(lcd_node, "sprd,esd-check-mode", &val);
+	if (!rc)
+		info->esd_check_mode = val;
+	else
+		info->esd_check_mode = 1;
+
+	rc = of_property_read_u32(lcd_node, "sprd,esd-check-period", &val);
+	if (!rc)
+		info->esd_check_period = val;
+	else
+		info->esd_check_period = 1000;
+
+	rc = of_property_read_u32(lcd_node, "sprd,esd-check-register", &val);
+	if (!rc)
+		info->esd_check_reg = val;
+	else
+		info->esd_check_reg = 0x0A;
+
+	rc = of_property_read_u32(lcd_node, "sprd,esd-check-value", &val);
+	if (!rc)
+		info->esd_check_val = val;
+	else
+		info->esd_check_val = 0x9C;
+
+	if (of_property_read_bool(lcd_node, "sprd,use-dcs-write"))
+		info->use_dcs = true;
+	else
+		info->use_dcs = false;
+
+	rc = of_parse_reset_seq(lcd_node, info);
+	if (rc)
+		DRM_ERROR("parse lcd reset sequence failed\n");
+
+	p = of_get_property(lcd_node, "sprd,initial-command", &bytes);
+	if (p) {
+		info->cmds[CMD_CODE_INIT] = p;
+		info->cmds_len[CMD_CODE_INIT] = bytes;
+	} else
+		DRM_ERROR("can't find sprd,initial-command property\n");
+
+	p = of_get_property(lcd_node, "sprd,sleep-in-command", &bytes);
+	if (p) {
+		info->cmds[CMD_CODE_SLEEP_IN] = p;
+		info->cmds_len[CMD_CODE_SLEEP_IN] = bytes;
+	} else
+		DRM_ERROR("can't find sprd,sleep-in-command property\n");
+
+	p = of_get_property(lcd_node, "sprd,sleep-out-command", &bytes);
+	if (p) {
+		info->cmds[CMD_CODE_SLEEP_OUT] = p;
+		info->cmds_len[CMD_CODE_SLEEP_OUT] = bytes;
+	} else
+		DRM_ERROR("can't find sprd,sleep-out-command property\n");
+
+	rc = of_get_drm_display_mode(lcd_node, &info->mode, 0,
+				     OF_USE_NATIVE_MODE);
+	if (rc) {
+		DRM_ERROR("get display timing failed\n");
+		return rc;
+	}
+
+	info->mode.vrefresh = drm_mode_vrefresh(&info->mode);
+	of_parse_buildin_modes(info, lcd_node);
+
+	return 0;
+}
+
+static int sprd_panel_probe(struct mipi_dsi_device *slave)
+{
+	int ret;
+	struct sprd_panel *panel;
+	struct device_node *bl_node;
+
+	panel = devm_kzalloc(&slave->dev, sizeof(*panel), GFP_KERNEL);
+	if (!panel)
+		return -ENOMEM;
+
+	bl_node = of_parse_phandle(slave->dev.of_node,
+					"sprd,backlight", 0);
+	if (bl_node) {
+		panel->backlight = of_find_backlight_by_node(bl_node);
+		of_node_put(bl_node);
+
+		if (panel->backlight) {
+			panel->backlight->props.state &= ~BL_CORE_FBBLANK;
+			panel->backlight->props.power = FB_BLANK_UNBLANK;
+			backlight_update_status(panel->backlight);
+		} else {
+			DRM_WARN("backlight is not ready, panel probe deferred\n");
+			return -EPROBE_DEFER;
+		}
+	} else
+		DRM_WARN("backlight node not found\n");
+
+	panel->supply = devm_regulator_get(&slave->dev, "power");
+	if (IS_ERR(panel->supply)) {
+		if (PTR_ERR(panel->supply) == -EPROBE_DEFER)
+			DRM_ERROR("regulator driver not initialized, probe deffer\n");
+		else
+			DRM_ERROR("can't get regulator: %ld\n", PTR_ERR(panel->supply));
+
+		return PTR_ERR(panel->supply);
+	}
+
+	INIT_DELAYED_WORK(&panel->esd_work, sprd_panel_esd_work_func);
+
+	ret = sprd_panel_parse_dt(slave->dev.of_node, panel);
+	if (ret) {
+		DRM_ERROR("parse panel info failed\n");
+		return ret;
+	}
+
+	ret = sprd_panel_gpio_request(&slave->dev, panel);
+	if (ret) {
+		DRM_WARN("gpio is not ready, panel probe deferred\n");
+		return -EPROBE_DEFER;
+	}
+
+	drm_panel_init(&panel->base, &panel->dev,
+		&sprd_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	ret = drm_panel_add(&panel->base);
+	if (ret) {
+		DRM_ERROR("drm_panel_add() failed\n");
+		return ret;
+	}
+
+	slave->lanes = panel->info.lanes;
+	slave->format = panel->info.format;
+	slave->mode_flags = panel->info.mode_flags;
+
+	ret = mipi_dsi_attach(slave);
+	if (ret) {
+		DRM_ERROR("failed to attach dsi panel to host\n");
+		drm_panel_remove(&panel->base);
+		return ret;
+	}
+	panel->slave = slave;
+
+	mipi_dsi_set_drvdata(slave, panel);
+
+	/*
+	 * FIXME:
+	 * The esd check work should not be scheduled in probe
+	 * function. It should be scheduled in the enable()
+	 * callback function. But the dsi encoder will not call
+	 * drm_panel_enable() the first time in encoder_enable().
+	 */
+	if (panel->info.esd_check_en) {
+		schedule_delayed_work(&panel->esd_work,
+				      msecs_to_jiffies(2000));
+		panel->esd_work_pending = true;
+	}
+
+	panel->is_enabled = true;
+
+	DRM_INFO("panel driver probe success\n");
+
+	return 0;
+}
+
+static int sprd_panel_remove(struct mipi_dsi_device *slave)
+{
+	struct sprd_panel *panel = mipi_dsi_get_drvdata(slave);
+	int ret;
+
+	DRM_INFO("%s()\n", __func__);
+
+	sprd_panel_disable(&panel->base);
+	sprd_panel_unprepare(&panel->base);
+
+	ret = mipi_dsi_detach(slave);
+	if (ret < 0)
+		DRM_ERROR("failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_detach(&panel->base);
+	drm_panel_remove(&panel->base);
+
+	return 0;
+}
+
+static const struct of_device_id panel_of_match[] = {
+	{ .compatible = "sprd,generic-mipi-panel", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, panel_of_match);
+
+static struct mipi_dsi_driver sprd_panel_driver = {
+	.driver = {
+		.name = "sprd-mipi-panel-drv",
+		.of_match_table = panel_of_match,
+	},
+	.probe = sprd_panel_probe,
+	.remove = sprd_panel_remove,
+};
+module_mipi_dsi_driver(sprd_panel_driver);
+
+MODULE_AUTHOR("Leon He <leon.he@unisoc.com>");
+MODULE_AUTHOR("Kevin Tang <kevin.tang@unisoc.com>");
+MODULE_DESCRIPTION("Unisoc MIPI DSI Panel Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/sprd/sprd_panel.h b/drivers/gpu/drm/sprd/sprd_panel.h
new file mode 100644
index 0000000..216cd4b
--- /dev/null
+++ b/drivers/gpu/drm/sprd/sprd_panel.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Unisoc Inc.
+ */
+
+#ifndef _SPRD_PANEL_H_
+#define _SPRD_PANEL_H_
+
+#include <linux/backlight.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+enum {
+	CMD_CODE_INIT = 0,
+	CMD_CODE_SLEEP_IN,
+	CMD_CODE_SLEEP_OUT,
+	CMD_OLED_BRIGHTNESS,
+	CMD_OLED_REG_LOCK,
+	CMD_OLED_REG_UNLOCK,
+	CMD_CODE_RESERVED0,
+	CMD_CODE_RESERVED1,
+	CMD_CODE_RESERVED2,
+	CMD_CODE_RESERVED3,
+	CMD_CODE_RESERVED4,
+	CMD_CODE_RESERVED5,
+	CMD_CODE_MAX,
+};
+
+enum {
+	SPRD_DSI_MODE_CMD = 0,
+	SPRD_DSI_MODE_VIDEO_BURST,
+	SPRD_DSI_MODE_VIDEO_SYNC_PULSE,
+	SPRD_DSI_MODE_VIDEO_SYNC_EVENT,
+};
+
+enum {
+	ESD_MODE_REG_CHECK,
+	ESD_MODE_TE_CHECK,
+};
+
+struct dsi_cmd_desc {
+	u8 data_type;
+	u8 wait;
+	u8 wc_h;
+	u8 wc_l;
+	u8 payload[];
+};
+
+struct gpio_timing {
+	u32 level;
+	u32 delay;
+};
+
+struct reset_sequence {
+	u32 items;
+	struct gpio_timing *timing;
+};
+
+struct panel_info {
+	/* common parameters */
+	struct device_node *of_node;
+	struct drm_display_mode mode;
+	struct drm_display_mode *buildin_modes;
+	int num_buildin_modes;
+	struct gpio_desc *avdd_gpio;
+	struct gpio_desc *avee_gpio;
+	struct gpio_desc *reset_gpio;
+	struct reset_sequence rst_on_seq;
+	struct reset_sequence rst_off_seq;
+	const void *cmds[CMD_CODE_MAX];
+	int cmds_len[CMD_CODE_MAX];
+
+	/* esd check parameters*/
+	bool esd_check_en;
+	u8 esd_check_mode;
+	u16 esd_check_period;
+	u32 esd_check_reg;
+	u32 esd_check_val;
+
+	/* MIPI DSI specific parameters */
+	u32 format;
+	u32 lanes;
+	u32 mode_flags;
+	bool use_dcs;
+};
+
+struct sprd_panel {
+	struct device dev;
+	struct drm_panel base;
+	struct mipi_dsi_device *slave;
+	struct panel_info info;
+	struct backlight_device *backlight;
+	struct regulator *supply;
+	struct delayed_work esd_work;
+	bool esd_work_pending;
+	bool is_enabled;
+};
+
+struct sprd_oled {
+	struct backlight_device *bdev;
+	struct sprd_panel *panel;
+	struct dsi_cmd_desc *cmds[255];
+	int cmd_len;
+	int cmds_total;
+	int max_level;
+};
+
+#endif
-- 
2.7.4

