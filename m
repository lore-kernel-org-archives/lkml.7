Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF2C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904532085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ervszTLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFZBjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:39:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42136 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZBjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:39:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so333218qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+TXqSwTZjDGWj2L4S+KWzT9OrVj0CDUBdtM8IFJVBGA=;
        b=ervszTLUC9g6PMkHh8xFdbXLwqy2ptpocTo5YeYt7pVLR20sibEuff45n1pnTXuW3D
         vN6A5y05aPfQ6lDOMxGnPVSncqduSje1eBfEjligVaL64TqIPlgCC8scG9v7lVXQx/6n
         FA30vHpln56hKSmoCAevu372laHXG40EzMEVP4/4gsHce62dR29poZ0da+dY39dMQQET
         yawTCqi9v10NrFqsLpVDqg4TUvoPNd1GM7CPa9ffhLCF5G37F2Az93mo6aGvPAaFhSl2
         iaySm6RVe9bJ+V7uC00uya9turvVA0ngBh4FXgSyvPlH9fqpjcGCefoh1nIkH7KmwX//
         r3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+TXqSwTZjDGWj2L4S+KWzT9OrVj0CDUBdtM8IFJVBGA=;
        b=mHq641G3vQ+gWgrSbMyxDUwe1N6HYMeWBfQyXtCEOaLsmNsziY8ZtgF+V7EIGhy6G0
         nReMwG1Bc0D0RZb+tK4AuzCrIp08L2uPMBVB4vwfjFKXEMoD2Y87pfEdNLV92PolDfkU
         70JUHcOwHMG9ZA38NtDKJEsNqOIgWCTXrw7FR6NqArQdW8qEc6sm+bMj9TvBKAvIJlEX
         xL9Oa3bcUuo+7ApIu8j1D9ACJAvpbUMhQZAqELZ8+2oEZDFlNUDvKZn044cgtgiKHOI5
         2b7cpjrSyE9eP05c/YGxLeie8bK1TjoHg+bImNtcCAbN8aRDzK5dxh6cVfWv8LHA1YZN
         RUQg==
X-Gm-Message-State: APjAAAWnkAYFwKz5yQ0ZsdpubUdMBk1krgVISwYrFHm0w791Z5kpP6cf
        lkSlsv+6z1xOY657XlZeb4c=
X-Google-Smtp-Source: APXvYqyDm2BNTI3hkynfdVEW0uNDWRhaj/k3V+V3hMvZHuUvQvsEyv0xpzQ4c2GCjDSMKsAURE7XJA==
X-Received: by 2002:a05:620a:624:: with SMTP id 4mr1470510qkv.15.1561513147526;
        Tue, 25 Jun 2019 18:39:07 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id q29sm8219747qkq.77.2019.06.25.18.39.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 18:39:07 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:39:03 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/5] drm/vkms: Add support for writeback
Message-ID: <917fda9b620cd84a0826d2d5a59bff9ea07bfde2.1561491964.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the necessary functions to add writeback support
for vkms. This feature is useful for testing compositors if you don't
have hardware with writeback support.

Change in V3 (Daniel):
- If writeback is enabled, compose everything into the writeback buffer
instead of CRC private buffer.
- Guarantees that the CRC will match exactly what we have in the
writeback buffer.

Change in V2:
- Rework signal completion (Brian)
- Integrates writeback with active_planes (Daniel)
- Compose cursor (Daniel)

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile         |   9 +-
 drivers/gpu/drm/vkms/vkms_composer.c  |  16 ++-
 drivers/gpu/drm/vkms/vkms_drv.c       |   4 +
 drivers/gpu/drm/vkms/vkms_drv.h       |   8 ++
 drivers/gpu/drm/vkms/vkms_output.c    |  10 ++
 drivers/gpu/drm/vkms/vkms_writeback.c | 141 ++++++++++++++++++++++++++
 6 files changed, 185 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 0b767d7efa24..333d3cead0e3 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_composer.o
+vkms-y := \
+	vkms_drv.o \
+	vkms_plane.o \
+	vkms_output.o \
+	vkms_crtc.o \
+	vkms_gem.o \
+	vkms_composer.o \
+	vkms_writeback.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 8126aa0f968f..2317803e7320 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -157,16 +157,17 @@ void vkms_composer_worker(struct work_struct *work)
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	struct vkms_composer *primary_composer = NULL;
 	struct vkms_composer *cursor_composer = NULL;
+	bool crc_pending, wb_pending;
 	void *vaddr_out = NULL;
 	u32 crc32 = 0;
 	u64 frame_start, frame_end;
-	bool crc_pending;
 	int ret;
 
 	spin_lock_irq(&out->composer_lock);
 	frame_start = crtc_state->frame_start;
 	frame_end = crtc_state->frame_end;
 	crc_pending = crtc_state->crc_pending;
+	wb_pending = crtc_state->wb_pending;
 	crtc_state->frame_start = 0;
 	crtc_state->frame_end = 0;
 	crtc_state->crc_pending = false;
@@ -188,9 +189,12 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!primary_composer)
 		return;
 
+	if (wb_pending)
+		vaddr_out = crtc_state->active_writeback;
+
 	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
 	if (ret) {
-		if (ret == -EINVAL)
+		if (ret == -EINVAL && !wb_pending)
 			kfree(vaddr_out);
 		return;
 	}
@@ -203,6 +207,14 @@ void vkms_composer_worker(struct work_struct *work)
 	while (frame_start <= frame_end)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 
+	if (wb_pending) {
+		drm_writeback_signal_completion(&out->wb_connector, 0);
+		spin_lock_irq(&out->composer_lock);
+		crtc_state->wb_pending = false;
+		spin_unlock_irq(&out->composer_lock);
+		return;
+	}
+
 	kfree(vaddr_out);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index ac790b6527e4..152d7de24a76 100644
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
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index fc6cda164336..9ff2cd4ebf81 100644
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
 
 struct vkms_composer {
 	struct drm_framebuffer fb;
@@ -52,9 +54,11 @@ struct vkms_crtc_state {
 	int num_active_planes;
 	/* stack of active planes for crc computation, should be in z order */
 	struct vkms_plane_state **active_planes;
+	void *active_writeback;
 
 	/* below three are protected by vkms_output.composer_lock */
 	bool crc_pending;
+	bool wb_pending;
 	u64 frame_start;
 	u64 frame_end;
 };
@@ -63,6 +67,7 @@ struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
+	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
@@ -147,4 +152,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
 
+/* Writeback */
+int enable_writeback_connector(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index fb1941a6522c..aea1d4410864 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -84,6 +84,16 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
+	if (enable_writeback) {
+		ret = enable_writeback_connector(vkmsdev);
+		if (!ret) {
+			output->composer_enabled = true;
+			DRM_INFO("Writeback connector enabled");
+		} else {
+			DRM_ERROR("Failed to init writeback connector\n");
+		}
+	}
+
 	drm_mode_config_reset(dev);
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
new file mode 100644
index 000000000000..34dad37a0236
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "vkms_drv.h"
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
+	struct drm_writeback_connector *wb_conn = &output->wb_connector;
+	struct drm_connector_state *conn_state = wb_conn->base.state;
+	struct vkms_crtc_state *crtc_state = output->composer_state;
+
+	if (!conn_state)
+		return;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb) {
+		DRM_DEBUG_DRIVER("Disable writeback\n");
+		return;
+	}
+
+	spin_lock_irq(&output->composer_lock);
+	crtc_state->active_writeback = conn_state->writeback_job->priv;
+	crtc_state->wb_pending = true;
+	spin_unlock_irq(&output->composer_lock);
+	drm_writeback_queue_job(wb_conn, state);
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
