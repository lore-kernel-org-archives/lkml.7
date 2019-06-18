Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C2C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015922085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEpfCcNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfFRCqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:46:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40708 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRCqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:46:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so7590998qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hnmSbaPYoH9LcJj1HTI+NTdpL8T7oL5uLDV7aWkGRYw=;
        b=SEpfCcNYyPV3gc7A0i6Ms3EhPuoD6JobPTWX9G8KOv5NY4bsZB14/9dR/bw58P/83h
         p/BR9eTKXzcGKyI+kIYmdSMV8hTsBkRXWFGBdFVIuEJlzjt8PTgIsWwTGCLhSuPUA231
         e/2YdhYMTzJjoPDGbMQOjtd+V1uZdTN39ypP3Ln7aTpKyWGY0vB7GG3wQwUzCwzhhsOW
         FhY/Tc7Q0/1/H3YGNfTZP+pTM4ZboPbBFM9tVGpvomJT2UxJBlwoVqWqhvCXMi7TP/JR
         VKzZRysvEs8Zvt2zHS3wK3C1+0mMHPra6tbZu0EPkLXGSpGTMoRAGb4NybcJKOGVW0c3
         vOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnmSbaPYoH9LcJj1HTI+NTdpL8T7oL5uLDV7aWkGRYw=;
        b=CM+FYpm1xEF6tsFe4iI3I+2sg3tuMnkuhJt0RC5nUamIUECOc2tPrhkYXetx5vEhWV
         J+0rO2IRPfxM4VP51KjLOnX01reiTYnqLF7v1811RsmEmxIvbyeKLhM0O5rXbn+3acYz
         TO3DCY/4z1BTK0AC6GqoKMJ50woPNTk3ytm9iN3kgBiAFoQX+Mdhnok2xIHEEL1HbXtx
         vY36ee8YPs0rLPAEiGyBbOUHTWiJqrQQ2+gLgQ1w9upGzCJ/vDf++UEd6gWY4eplgcky
         0hE/5RHWPTXwFt5U5DD9L9gKSn2A572R69+zJW+mDnqr8lVxlAAZxFuJw/VhumITGxLy
         4yUQ==
X-Gm-Message-State: APjAAAUxgNc9cy4ZGTx/r9O2U2sACknumHn6WZ1lJZJ+vJLCoJR5yLrK
        bVH5fSJ/dg+c2Xru0uGIBwg=
X-Google-Smtp-Source: APXvYqz5ZSIcXaacdr9jK2qHSKWsTQi7aoWbIa4fZxY/5ixtQBQYHqTqT3rg/e1mEMmfOtMjvNg+zA==
X-Received: by 2002:a05:620a:16ba:: with SMTP id s26mr19866476qkj.301.1560825959838;
        Mon, 17 Jun 2019 19:45:59 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id 41sm9866593qtp.32.2019.06.17.19.45.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:45:59 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:45:55 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] drm/vkms: Add support for writeback
Message-ID: <4787369d4927fa709da050e7481e48102842fd97.1560820888.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the necessary functions to add writeback support
for vkms. This feature is useful for testing compositors if you don't
have hardware with writeback support.

Change in V2:
- Rework signal completion (Brian)
- Integrates writeback with active_planes (Daniel)
- Compose cursor (Daniel)

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile         |   3 +-
 drivers/gpu/drm/vkms/vkms_drv.c       |   7 ++
 drivers/gpu/drm/vkms/vkms_drv.h       |   6 +
 drivers/gpu/drm/vkms/vkms_output.c    |   6 +
 drivers/gpu/drm/vkms/vkms_writeback.c | 166 ++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index b4c040854bd6..091e6fa643d1 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -6,6 +6,7 @@ vkms-y := \
 	vkms_crtc.o \
 	vkms_gem.o \
 	vkms_composer.o \
-	vkms_crc.o
+	vkms_crc.o \
+	vkms_writeback.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 966b3d653189..d870779abf9d 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -30,6 +30,10 @@ bool enable_cursor;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
+bool enable_writeback;
+module_param_named(enable_writeback, enable_writeback, bool, 0444);
+MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
+
 static const struct file_operations vkms_driver_fops = {
 	.owner		= THIS_MODULE,
 	.open		= drm_open,
@@ -158,6 +162,9 @@ static int __init vkms_init(void)
 		goto out_fini;
 	}
 
+	if (enable_writeback)
+		DRM_INFO("Writeback connector enabled");
+
 	ret = vkms_modeset_init(vkms_device);
 	if (ret)
 		goto out_fini;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index ad63dbe5e994..bf3fa737b3d7 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -7,6 +7,7 @@
 #include <drm/drm.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_writeback.h>
 #include <linux/hrtimer.h>
 
 #define XRES_MIN    20
@@ -19,6 +20,7 @@
 #define YRES_MAX  8192
 
 extern bool enable_cursor;
+extern bool enable_writeback;
 
 struct vkms_data {
 	struct drm_framebuffer fb;
@@ -63,6 +65,7 @@ struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
+	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
@@ -143,4 +146,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 			   size_t *values_cnt);
 void vkms_crc_work_handle(struct work_struct *work);
 
+/* Writeback */
+int enable_writeback_connector(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index fb1941a6522c..3b093ae8f373 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -84,6 +84,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
+	if (enable_writeback) {
+		ret = enable_writeback_connector(vkmsdev);
+		if (ret)
+			DRM_ERROR("Failed to init writeback connector\n");
+	}
+
 	drm_mode_config_reset(dev);
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
new file mode 100644
index 000000000000..56632eb393cb
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "vkms_drv.h"
+#include "vkms_composer.h"
+#include <drm/drm_writeback.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+
+static const u32 vkms_wb_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const struct drm_connector_funcs vkms_wb_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	struct drm_framebuffer *fb;
+	const struct drm_display_mode *mode = &crtc_state->mode;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
+		return 0;
+
+	fb = conn_state->writeback_job->fb;
+	if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
+		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
+			      fb->width, fb->height);
+		return -EINVAL;
+	}
+
+	if (fb->format->format != DRM_FORMAT_XRGB8888) {
+		struct drm_format_name_buf format_name;
+
+		DRM_DEBUG_KMS("Invalid pixel format %s\n",
+			      drm_get_format_name(fb->format->format,
+						  &format_name));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_funcs = {
+	.atomic_check = vkms_wb_encoder_atomic_check,
+};
+
+static int vkms_wb_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+
+	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
+				    dev->mode_config.max_height);
+}
+
+static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+			       struct drm_writeback_job *job)
+{
+	struct vkms_gem_object *vkms_obj;
+	struct drm_gem_object *gem_obj;
+	int ret;
+
+	if (!job->fb)
+		return 0;
+
+	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
+	ret = vkms_gem_vmap(gem_obj);
+	if (ret) {
+		DRM_ERROR("vmap failed: %d\n", ret);
+		return ret;
+	}
+
+	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
+	job->priv = vkms_obj->vaddr;
+
+	return 0;
+}
+
+static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
+				struct drm_writeback_job *job)
+{
+	struct drm_gem_object *gem_obj;
+
+	if (!job->fb)
+		return;
+
+	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
+	vkms_gem_vunmap(gem_obj);
+}
+
+static void vkms_wb_atomic_commit(struct drm_connector *conn,
+				  struct drm_connector_state *state)
+{
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
+	struct vkms_output *output = &vkmsdev->output;
+	struct vkms_crtc_state *crtc_state = output->crc_state;
+	struct drm_writeback_connector *wb_conn = &output->wb_connector;
+	struct drm_connector_state *conn_state = wb_conn->base.state;
+	void *priv_data = conn_state->writeback_job->priv;
+	struct vkms_data *primary_data = NULL;
+	struct vkms_data *cursor_data = NULL;
+	struct drm_framebuffer *fb = NULL;
+	struct vkms_gem_object *vkms_obj;
+	struct drm_gem_object *gem_obj;
+
+	if (!conn_state)
+		return;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb) {
+		DRM_DEBUG_DRIVER("Disable writeback\n");
+		return;
+	}
+
+	if (crtc_state->num_active_planes >= 1)
+		primary_data = crtc_state->active_planes[0]->data;
+
+	if (crtc_state->num_active_planes == 2)
+		cursor_data = crtc_state->active_planes[1]->data;
+
+	if (!primary_data)
+		return;
+
+	fb = &primary_data->fb;
+	gem_obj = drm_gem_fb_get_obj(fb, 0);
+	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
+
+	if (!vkms_obj->vaddr || !priv_data)
+		return;
+
+	drm_writeback_queue_job(wb_conn, state);
+
+	memcpy(priv_data, vkms_obj->vaddr, vkms_obj->gem.size);
+	if (cursor_data)
+		compose_cursor(cursor_data, primary_data, priv_data);
+
+	drm_writeback_signal_completion(wb_conn, 0);
+}
+
+static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
+	.get_modes = vkms_wb_connector_get_modes,
+	.prepare_writeback_job = vkms_wb_prepare_job,
+	.cleanup_writeback_job = vkms_wb_cleanup_job,
+	.atomic_commit = vkms_wb_atomic_commit,
+};
+
+int enable_writeback_connector(struct vkms_device *vkmsdev)
+{
+	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
+
+	vkmsdev->output.wb_connector.encoder.possible_crtcs = 1;
+	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
+
+	return drm_writeback_connector_init(&vkmsdev->drm, wb,
+					    &vkms_wb_connector_funcs,
+					    &vkms_wb_encoder_helper_funcs,
+					    vkms_wb_formats,
+					    ARRAY_SIZE(vkms_wb_formats));
+}
+
-- 
2.21.0
