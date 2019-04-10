Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2524B217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDJHsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfDJHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4A65302391C;
        Wed, 10 Apr 2019 07:48:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FF195DA38;
        Wed, 10 Apr 2019 07:48:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BA7D311AA4; Wed, 10 Apr 2019 09:48:28 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/bochs: use simple display pipe
Date:   Wed, 10 Apr 2019 09:48:28 +0200
Message-Id: <20190410074828.10296-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 10 Apr 2019 07:48:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |   6 +-
 drivers/gpu/drm/bochs/bochs_kms.c | 178 +++++++++---------------------
 2 files changed, 53 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index a7f6723bebdd..36f6ee725d13 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -7,6 +7,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include <drm/drm_gem.h>
 
@@ -69,9 +70,8 @@ struct bochs_device {
 	struct edid *edid;
 
 	/* drm */
-	struct drm_device  *dev;
-	struct drm_crtc crtc;
-	struct drm_encoder encoder;
+	struct drm_device *dev;
+	struct drm_simple_display_pipe pipe;
 	struct drm_connector connector;
 
 	/* ttm */
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 485f9cf05e8b..5e905f50449d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -22,76 +22,55 @@ MODULE_PARM_DESC(defy, "default y resolution");
 
 /* ---------------------------------------------------------------------- */
 
-static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-
-	bochs_hw_setmode(bochs, &crtc->mode);
-}
-
-static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
-				     struct drm_crtc_state *old_crtc_state)
-{
-}
-
-static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
-				    struct drm_crtc_state *old_crtc_state)
-{
-	struct drm_device *dev = crtc->dev;
-	struct drm_pending_vblank_event *event;
-
-	if (crtc->state && crtc->state->event) {
-		unsigned long irqflags;
-
-		spin_lock_irqsave(&dev->event_lock, irqflags);
-		event = crtc->state->event;
-		crtc->state->event = NULL;
-		drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irqrestore(&dev->event_lock, irqflags);
-	}
-}
-
-
-/* These provide the minimum set of functions required to handle a CRTC */
-static const struct drm_crtc_funcs bochs_crtc_funcs = {
-	.set_config = drm_atomic_helper_set_config,
-	.destroy = drm_crtc_cleanup,
-	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
-	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-};
-
-static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
-	.mode_set_nofb = bochs_crtc_mode_set_nofb,
-	.atomic_enable = bochs_crtc_atomic_enable,
-	.atomic_flush = bochs_crtc_atomic_flush,
-};
-
 static const uint32_t bochs_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGRX8888,
 };
 
-static void bochs_plane_atomic_update(struct drm_plane *plane,
-				      struct drm_plane_state *old_state)
+static void bochs_plane_update(struct bochs_device *bochs,
+			       struct drm_plane_state *state)
 {
-	struct bochs_device *bochs = plane->dev->dev_private;
 	struct bochs_bo *bo;
 
-	if (!plane->state->fb)
+	if (!state->fb || !bochs->stride)
 		return;
-	bo = gem_to_bochs_bo(plane->state->fb->obj[0]);
+
+	bo = gem_to_bochs_bo(state->fb->obj[0]);
 	bochs_hw_setbase(bochs,
-			 plane->state->crtc_x,
-			 plane->state->crtc_y,
+			 state->crtc_x,
+			 state->crtc_y,
 			 bo->bo.offset);
-	bochs_hw_setformat(bochs, plane->state->fb->format);
+	bochs_hw_setformat(bochs, state->fb->format);
 }
 
-static int bochs_plane_prepare_fb(struct drm_plane *plane,
-				struct drm_plane_state *new_state)
+static void bochs_pipe_enable(struct drm_simple_display_pipe *pipe,
+			      struct drm_crtc_state *crtc_state,
+			      struct drm_plane_state *plane_state)
+{
+	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
+
+	bochs_hw_setmode(bochs, &crtc_state->mode);
+	bochs_plane_update(bochs, plane_state);
+}
+
+static void bochs_pipe_update(struct drm_simple_display_pipe *pipe,
+			      struct drm_plane_state *old_state)
+{
+	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
+	struct drm_crtc *crtc = &pipe->crtc;
+
+	bochs_plane_update(bochs, pipe->plane.state);
+
+	if (crtc->state->event) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+}
+
+static int bochs_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
+				 struct drm_plane_state *new_state)
 {
 	struct bochs_bo *bo;
 
@@ -101,8 +80,8 @@ static int bochs_plane_prepare_fb(struct drm_plane *plane,
 	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 }
 
-static void bochs_plane_cleanup_fb(struct drm_plane *plane,
-				   struct drm_plane_state *old_state)
+static void bochs_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
+				  struct drm_plane_state *old_state)
 {
 	struct bochs_bo *bo;
 
@@ -112,73 +91,13 @@ static void bochs_plane_cleanup_fb(struct drm_plane *plane,
 	bochs_bo_unpin(bo);
 }
 
-static const struct drm_plane_helper_funcs bochs_plane_helper_funcs = {
-	.atomic_update = bochs_plane_atomic_update,
-	.prepare_fb = bochs_plane_prepare_fb,
-	.cleanup_fb = bochs_plane_cleanup_fb,
+static const struct drm_simple_display_pipe_funcs bochs_pipe_funcs = {
+	.enable	    = bochs_pipe_enable,
+	.update	    = bochs_pipe_update,
+	.prepare_fb = bochs_pipe_prepare_fb,
+	.cleanup_fb = bochs_pipe_cleanup_fb,
 };
 
-static const struct drm_plane_funcs bochs_plane_funcs = {
-       .update_plane   = drm_atomic_helper_update_plane,
-       .disable_plane  = drm_atomic_helper_disable_plane,
-       .destroy        = drm_primary_helper_destroy,
-       .reset          = drm_atomic_helper_plane_reset,
-       .atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
-       .atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-};
-
-static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
-{
-	struct drm_plane *primary;
-	int ret;
-
-	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
-	if (primary == NULL) {
-		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
-		return NULL;
-	}
-
-	ret = drm_universal_plane_init(dev, primary, 0,
-				       &bochs_plane_funcs,
-				       bochs_formats,
-				       ARRAY_SIZE(bochs_formats),
-				       NULL,
-				       DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret) {
-		kfree(primary);
-		return NULL;
-	}
-
-	drm_plane_helper_add(primary, &bochs_plane_helper_funcs);
-	return primary;
-}
-
-static void bochs_crtc_init(struct drm_device *dev)
-{
-	struct bochs_device *bochs = dev->dev_private;
-	struct drm_crtc *crtc = &bochs->crtc;
-	struct drm_plane *primary = bochs_primary_plane(dev);
-
-	drm_crtc_init_with_planes(dev, crtc, primary, NULL,
-				  &bochs_crtc_funcs, NULL);
-	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
-}
-
-static const struct drm_encoder_funcs bochs_encoder_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
-static void bochs_encoder_init(struct drm_device *dev)
-{
-	struct bochs_device *bochs = dev->dev_private;
-	struct drm_encoder *encoder = &bochs->encoder;
-
-	encoder->possible_crtcs = 0x1;
-	drm_encoder_init(dev, encoder, &bochs_encoder_encoder_funcs,
-			 DRM_MODE_ENCODER_DAC, NULL);
-}
-
-
 static int bochs_connector_get_modes(struct drm_connector *connector)
 {
 	struct bochs_device *bochs =
@@ -278,11 +197,14 @@ int bochs_kms_init(struct bochs_device *bochs)
 
 	bochs->dev->mode_config.funcs = &bochs_mode_funcs;
 
-	bochs_crtc_init(bochs->dev);
-	bochs_encoder_init(bochs->dev);
 	bochs_connector_init(bochs->dev);
-	drm_connector_attach_encoder(&bochs->connector,
-					  &bochs->encoder);
+	drm_simple_display_pipe_init(bochs->dev,
+				     &bochs->pipe,
+				     &bochs_pipe_funcs,
+				     bochs_formats,
+				     ARRAY_SIZE(bochs_formats),
+				     NULL,
+				     &bochs->connector);
 
 	drm_mode_config_reset(bochs->dev);
 
-- 
2.18.1

