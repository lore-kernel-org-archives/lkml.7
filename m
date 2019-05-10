Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D44C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F85020989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfEJLJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:09:06 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51793 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfEJLJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:09:04 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2B4EA40002;
        Fri, 10 May 2019 11:08:59 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>
Subject: [PATCH v2 4/6] drm/fourcc: Pass the format_info pointer to drm_format_plane_cpp
Date:   Fri, 10 May 2019 13:08:49 +0200
Message-Id: <32aa13e53dbc98a90207fd290aa8e79f785fb11e.1557486447.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, the drm_format_plane_cpp function was operating on the format's
fourcc and was doing a lookup to retrieve the drm_format_info structure and
return the cpp.

However, this is inefficient since in most cases, we will have the
drm_format_info pointer already available so we shouldn't have to perform a
new lookup. Some drm_fourcc functions also already operate on the
drm_format_info pointer for that reason, so the API is quite inconsistent
there.

Let's follow the latter pattern and remove the extra lookup while being a
bit more consistent. In order to be extra consistent, also rename that
function to drm_format_info_plane_cpp and to a static function in the
header to match the current policy.

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c     |  4 +++-
 drivers/gpu/drm/arm/malidp_hw.c            |  3 ++-
 drivers/gpu/drm/arm/malidp_planes.c        |  2 +-
 drivers/gpu/drm/drm_client.c               |  3 ++-
 drivers/gpu/drm/drm_fb_helper.c            |  2 +-
 drivers/gpu/drm/drm_format_helper.c        |  4 ++--
 drivers/gpu/drm/drm_fourcc.c               | 20 --------------------
 drivers/gpu/drm/i915/intel_sprite.c        |  3 ++-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c      |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c  |  3 ++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c   |  2 +-
 drivers/gpu/drm/msm/msm_fb.c               |  2 +-
 drivers/gpu/drm/radeon/radeon_fb.c         |  4 +++-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c |  2 +-
 drivers/gpu/drm/stm/ltdc.c                 |  2 +-
 drivers/gpu/drm/tegra/fb.c                 |  2 +-
 drivers/gpu/drm/zte/zx_plane.c             |  2 +-
 include/drm/drm_fourcc.h                   | 18 +++++++++++++++++-
 18 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index e47609218839..06e73a343724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -121,6 +121,8 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 					 struct drm_mode_fb_cmd2 *mode_cmd,
 					 struct drm_gem_object **gobj_p)
 {
+	const struct drm_format_info *info = drm_get_format_info(dev,
+								 mode_cmd);
 	struct amdgpu_device *adev = rfbdev->adev;
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
@@ -131,7 +133,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	int height = mode_cmd->height;
 	u32 cpp;
 
-	cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	cpp = drm_format_info_plane_cpp(info, 0);
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 8df12e9a33bb..1c9e869f4c52 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -382,7 +382,8 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 
 int malidp_format_get_bpp(u32 fmt)
 {
-	int bpp = drm_format_plane_cpp(fmt, 0) * 8;
+	const struct drm_format_info *info = drm_format_info(fmt);
+	int bpp = drm_format_info_plane_cpp(info, 0) * 8;
 
 	if (bpp == 0) {
 		switch (fmt) {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 8f89813d08c1..361c02988375 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -227,7 +227,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
 
 	if (modifier & AFBC_SPLIT) {
 		if (!info->is_yuv) {
-			if (drm_format_plane_cpp(format, 0) <= 2) {
+			if (drm_format_info_plane_cpp(info, 0) <= 2) {
 				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
 				return false;
 			}
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index f20d1dda3961..169d8eeaa662 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -243,6 +243,7 @@ static void drm_client_buffer_delete(struct drm_client_buffer *buffer)
 static struct drm_client_buffer *
 drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u32 format)
 {
+	const struct drm_format_info *info = drm_format_info(format);
 	struct drm_mode_create_dumb dumb_args = { };
 	struct drm_device *dev = client->dev;
 	struct drm_client_buffer *buffer;
@@ -258,7 +259,7 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
 
 	dumb_args.width = width;
 	dumb_args.height = height;
-	dumb_args.bpp = drm_format_plane_cpp(format, 0) * 8;
+	dumb_args.bpp = drm_format_info_plane_cpp(info, 0) * 8;
 	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
 	if (ret)
 		goto err_delete;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 498f95c3e81d..184f455c99ab 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -767,7 +767,7 @@ static void drm_fb_helper_dirty_blit_real(struct drm_fb_helper *fb_helper,
 					  struct drm_clip_rect *clip)
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
-	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
+	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
 	size_t offset = clip->y1 * fb->pitches[0] + clip->x1 * cpp;
 	void *src = fb_helper->fbdev->screen_buffer + offset;
 	void *dst = fb_helper->buffer->vaddr + offset;
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index a18da35145b7..8ad66aa1362a 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -36,7 +36,7 @@ static unsigned int clip_offset(struct drm_rect *clip,
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
-	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
+	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y, lines = clip->y2 - clip->y1;
 
@@ -63,7 +63,7 @@ void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
 			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip)
 {
-	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
+	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
 	unsigned int offset = clip_offset(clip, fb->pitches[0], cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y, lines = clip->y2 - clip->y1;
diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e4a2c8372c8b..5f63fc74e265 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -333,26 +333,6 @@ drm_get_format_info(struct drm_device *dev,
 EXPORT_SYMBOL(drm_get_format_info);
 
 /**
- * drm_format_plane_cpp - determine the bytes per pixel value
- * @format: pixel format (DRM_FORMAT_*)
- * @plane: plane index
- *
- * Returns:
- * The bytes per pixel value for the specified plane.
- */
-int drm_format_plane_cpp(uint32_t format, int plane)
-{
-	const struct drm_format_info *info;
-
-	info = drm_format_info(format);
-	if (!info || plane >= info->num_planes)
-		return 0;
-
-	return info->cpp[plane];
-}
-EXPORT_SYMBOL(drm_format_plane_cpp);
-
-/**
  * drm_format_plane_width - width of the plane given the first plane
  * @width: width of the first plane
  * @format: pixel format
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index 2913e89280d7..e35601b1f878 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -325,7 +325,8 @@ skl_plane_max_stride(struct intel_plane *plane,
 		     u32 pixel_format, u64 modifier,
 		     unsigned int rotation)
 {
-	int cpp = drm_format_plane_cpp(pixel_format, 0);
+	const struct drm_format_info *info = drm_format_info(pixel_format);
+	int cpp = drm_format_info_plane_cpp(info, 0);
 
 	/*
 	 * "The stride in bytes must not exceed the
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index 68fdef8b12bd..0d5334a5a9a7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -104,7 +104,7 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 	if (!gem)
 		return ERR_PTR(-ENOENT);
 
-	bpp = drm_format_plane_cpp(cmd->pixel_format, 0);
+	bpp = drm_format_info_plane_cpp(info, 0);
 	size = (height - 1) * cmd->pitches[0] + width * bpp;
 	size += cmd->offsets[0];
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index b0cf63c4e3d7..a565dccaba3a 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -782,6 +782,7 @@ static void get_roi(struct drm_crtc *crtc, uint32_t *roi_w, uint32_t *roi_h)
 
 static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
 {
+	const struct drm_format_info *info = drm_format_info(DRM_FORMAT_ARGB8888);
 	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc->state);
 	struct mdp5_crtc *mdp5_crtc = to_mdp5_crtc(crtc);
 	struct mdp5_kms *mdp5_kms = get_kms(crtc);
@@ -800,7 +801,7 @@ static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
 	width = mdp5_crtc->cursor.width;
 	height = mdp5_crtc->cursor.height;
 
-	stride = width * drm_format_plane_cpp(DRM_FORMAT_ARGB8888, 0);
+	stride = width * drm_format_info_plane_cpp(info, 0);
 
 	get_roi(crtc, &roi_w, &roi_h);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index b30b2f4efc60..1ca294694597 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -158,7 +158,7 @@ uint32_t mdp5_smp_calculate(struct mdp5_smp *smp,
 	for (i = 0; i < nplanes; i++) {
 		int n, fetch_stride, cpp;
 
-		cpp = drm_format_plane_cpp(fmt, i);
+		cpp = drm_format_info_plane_cpp(info, i);
 		fetch_stride = width * cpp / (i ? hsub : 1);
 
 		n = DIV_ROUND_UP(fetch_stride * nlines, smp->blk_size);
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index f69c0afd6ec6..29e45f2144b5 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -181,7 +181,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 		unsigned int min_size;
 
 		min_size = (height - 1) * mode_cmd->pitches[i]
-			 + width * drm_format_plane_cpp(mode_cmd->pixel_format, i)
+			 + width * drm_format_info_plane_cpp(info, i)
 			 + mode_cmd->offsets[i];
 
 		if (bos[i]->size < min_size) {
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 1298b84cb1c7..dbf596fc4339 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -125,6 +125,7 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 					 struct drm_mode_fb_cmd2 *mode_cmd,
 					 struct drm_gem_object **gobj_p)
 {
+	const struct drm_format_info *info;
 	struct radeon_device *rdev = rfbdev->rdev;
 	struct drm_gem_object *gobj = NULL;
 	struct radeon_bo *rbo = NULL;
@@ -135,7 +136,8 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 	int height = mode_cmd->height;
 	u32 cpp;
 
-	cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	info = drm_get_format_info(rdev->ddev, mode_cmd);
+	cpp = drm_format_info_plane_cpp(info, 0);
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = radeon_align_pitch(rdev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index c318fae28581..57873c99ae29 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -98,7 +98,7 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 
 		min_size = (height - 1) * mode_cmd->pitches[i] +
 			mode_cmd->offsets[i] +
-			width * drm_format_plane_cpp(mode_cmd->pixel_format, i);
+			width * drm_format_info_plane_cpp(info, i);
 
 		if (obj->size < min_size) {
 			drm_gem_object_put_unlocked(obj);
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 32fd6a3b37fb..6bb3cd3a1a01 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -779,7 +779,7 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
 
 	/* Configures the color frame buffer pitch in bytes & line length */
 	pitch_in_bytes = fb->pitches[0];
-	line_length = drm_format_plane_cpp(fb->format->format, 0) *
+	line_length = drm_format_info_plane_cpp(fb->format, 0) *
 		      (x1 - x0 + 1) + (ldev->caps.bus_width >> 3) - 1;
 	val = ((pitch_in_bytes << 16) | line_length);
 	reg_update_bits(ldev->regs, LTDC_L1CFBLR + lofs,
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 94fb75089d87..d1042196a30f 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -149,7 +149,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 			goto unreference;
 		}
 
-		bpp = drm_format_plane_cpp(cmd->pixel_format, i);
+		bpp = drm_format_info_plane_cpp(info, i);
 
 		size = (height - 1) * cmd->pitches[i] +
 		       width * bpp + cmd->offsets[i];
diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index c6a8be444300..d97a4dff515d 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -222,7 +222,7 @@ static void zx_vl_plane_atomic_update(struct drm_plane *plane,
 		cma_obj = drm_fb_cma_get_gem_obj(fb, i);
 		paddr = cma_obj->paddr + fb->offsets[i];
 		paddr += src_y * fb->pitches[i];
-		paddr += src_x * drm_format_plane_cpp(format, i);
+		paddr += src_x * drm_format_info_plane_cpp(fb->format, i);
 		zx_writel(paddr_reg, paddr);
 		paddr_reg += 4;
 	}
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index eeec449d6c6a..6b5a82b31bc4 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -260,6 +260,23 @@ drm_format_info_is_yuv_sampling_444(const struct drm_format_info *info)
 	return info->is_yuv && info->hsub == 1 && info->vsub == 1;
 }
 
+/**
+ * drm_format_info_plane_cpp - determine the bytes per pixel value
+ * @format: pixel format info
+ * @plane: plane index
+ *
+ * Returns:
+ * The bytes per pixel value for the specified plane.
+ */
+static inline
+int drm_format_info_plane_cpp(const struct drm_format_info *info, int plane)
+{
+	if (!info || plane >= info->num_planes)
+		return 0;
+
+	return info->cpp[plane];
+}
+
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
@@ -268,7 +285,6 @@ drm_get_format_info(struct drm_device *dev,
 uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
 uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 				     uint32_t bpp, uint32_t depth);
-int drm_format_plane_cpp(uint32_t format, int plane);
 int drm_format_plane_width(int width, uint32_t format, int plane);
 int drm_format_plane_height(int height, uint32_t format, int plane);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
-- 
git-series 0.9.1
