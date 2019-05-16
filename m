Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11969C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6A6206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfEPKcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:32:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57779 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:32:34 -0400
X-Originating-IP: 80.215.244.179
Received: from localhost (unknown [80.215.244.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 10B16E0009;
        Thu, 16 May 2019 10:32:25 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v3 7/7] drm: Remove users of drm_format_num_planes
Date:   Thu, 16 May 2019 12:31:52 +0200
Message-Id: <c0a78c87cd0410a1819edad2794ad06543c85bb5.1558002671.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1558002671.git-series.maxime.ripard@bootlin.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1558002671.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_format_info_plane_cpp() basically just returns the cpp array content
found in the drm_format_info structure.

Since it's pretty trivial, let's remove the function and have the users use
the array directly

Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v2:
  - new patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c     |  2 +-
 drivers/gpu/drm/arm/malidp_hw.c            |  2 +-
 drivers/gpu/drm/arm/malidp_planes.c        |  2 +-
 drivers/gpu/drm/drm_client.c               |  2 +-
 drivers/gpu/drm/drm_fb_helper.c            |  2 +-
 drivers/gpu/drm/drm_format_helper.c        |  4 ++--
 drivers/gpu/drm/i915/intel_sprite.c        |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c      |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c  |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c   |  2 +-
 drivers/gpu/drm/msm/msm_fb.c               |  2 +-
 drivers/gpu/drm/radeon/radeon_fb.c         |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c |  2 +-
 drivers/gpu/drm/stm/ltdc.c                 |  2 +-
 drivers/gpu/drm/tegra/fb.c                 |  2 +-
 drivers/gpu/drm/zte/zx_plane.c             |  2 +-
 include/drm/drm_fourcc.h                   | 17 -----------------
 17 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 6edae6458be8..2e2869299a84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -133,7 +133,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	u32 cpp;
 
 	info = drm_get_format_info(adev->ddev, mode_cmd);
-	cpp = drm_format_info_plane_cpp(info, 0);
+	cpp = info->cpp[0];
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 1c9e869f4c52..53391c0f87eb 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -383,7 +383,7 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 int malidp_format_get_bpp(u32 fmt)
 {
 	const struct drm_format_info *info = drm_format_info(fmt);
-	int bpp = drm_format_info_plane_cpp(info, 0) * 8;
+	int bpp = info->cpp[0] * 8;
 
 	if (bpp == 0) {
 		switch (fmt) {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 361c02988375..07ceb4ee14e3 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -227,7 +227,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
 
 	if (modifier & AFBC_SPLIT) {
 		if (!info->is_yuv) {
-			if (drm_format_info_plane_cpp(info, 0) <= 2) {
+			if (info->cpp[0] <= 2) {
 				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
 				return false;
 			}
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 169d8eeaa662..5abcd83da6a6 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -259,7 +259,7 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
 
 	dumb_args.width = width;
 	dumb_args.height = height;
-	dumb_args.bpp = drm_format_info_plane_cpp(info, 0) * 8;
+	dumb_args.bpp = info->cpp[0] * 8;
 	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
 	if (ret)
 		goto err_delete;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 184f455c99ab..09605ed69f06 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -767,7 +767,7 @@ static void drm_fb_helper_dirty_blit_real(struct drm_fb_helper *fb_helper,
 					  struct drm_clip_rect *clip)
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
-	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
+	unsigned int cpp = fb->format->cpp[0];
 	size_t offset = clip->y1 * fb->pitches[0] + clip->x1 * cpp;
 	void *src = fb_helper->fbdev->screen_buffer + offset;
 	void *dst = fb_helper->buffer->vaddr + offset;
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 8ad66aa1362a..0897cb9aeaff 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -36,7 +36,7 @@ static unsigned int clip_offset(struct drm_rect *clip,
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
-	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
+	unsigned int cpp = fb->format->cpp[0];
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y, lines = clip->y2 - clip->y1;
 
@@ -63,7 +63,7 @@ void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
 			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip)
 {
-	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
+	unsigned int cpp = fb->format->cpp[0];
 	unsigned int offset = clip_offset(clip, fb->pitches[0], cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y, lines = clip->y2 - clip->y1;
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index e35601b1f878..c1647c0cc217 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -326,7 +326,7 @@ skl_plane_max_stride(struct intel_plane *plane,
 		     unsigned int rotation)
 {
 	const struct drm_format_info *info = drm_format_info(pixel_format);
-	int cpp = drm_format_info_plane_cpp(info, 0);
+	int cpp = info->cpp[0];
 
 	/*
 	 * "The stride in bytes must not exceed the
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index 0d5334a5a9a7..b5e2f230da00 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -104,7 +104,7 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 	if (!gem)
 		return ERR_PTR(-ENOENT);
 
-	bpp = drm_format_info_plane_cpp(info, 0);
+	bpp = info->cpp[0];
 	size = (height - 1) * cmd->pitches[0] + width * bpp;
 	size += cmd->offsets[0];
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index a565dccaba3a..74dd036a2246 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -801,7 +801,7 @@ static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
 	width = mdp5_crtc->cursor.width;
 	height = mdp5_crtc->cursor.height;
 
-	stride = width * drm_format_info_plane_cpp(info, 0);
+	stride = width * info->cpp[0];
 
 	get_roi(crtc, &roi_w, &roi_h);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index 1ca294694597..2834837f4d3e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -158,7 +158,7 @@ uint32_t mdp5_smp_calculate(struct mdp5_smp *smp,
 	for (i = 0; i < nplanes; i++) {
 		int n, fetch_stride, cpp;
 
-		cpp = drm_format_info_plane_cpp(info, i);
+		cpp = info->cpp[i];
 		fetch_stride = width * cpp / (i ? hsub : 1);
 
 		n = DIV_ROUND_UP(fetch_stride * nlines, smp->blk_size);
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 29e45f2144b5..68fa2c8f61e6 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -181,7 +181,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 		unsigned int min_size;
 
 		min_size = (height - 1) * mode_cmd->pitches[i]
-			 + width * drm_format_info_plane_cpp(info, i)
+			 + width * info->cpp[i]
 			 + mode_cmd->offsets[i];
 
 		if (bos[i]->size < min_size) {
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index dbf596fc4339..287e3f92102a 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -137,7 +137,7 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 	u32 cpp;
 
 	info = drm_get_format_info(rdev->ddev, mode_cmd);
-	cpp = drm_format_info_plane_cpp(info, 0);
+	cpp = info->cpp[0];
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = radeon_align_pitch(rdev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 57873c99ae29..31030cf81bc9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -98,7 +98,7 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 
 		min_size = (height - 1) * mode_cmd->pitches[i] +
 			mode_cmd->offsets[i] +
-			width * drm_format_info_plane_cpp(info, i);
+			width * info->cpp[i];
 
 		if (obj->size < min_size) {
 			drm_gem_object_put_unlocked(obj);
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 6bb3cd3a1a01..9ff39789ffb7 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -779,7 +779,7 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
 
 	/* Configures the color frame buffer pitch in bytes & line length */
 	pitch_in_bytes = fb->pitches[0];
-	line_length = drm_format_info_plane_cpp(fb->format, 0) *
+	line_length = fb->format->cpp[0] *
 		      (x1 - x0 + 1) + (ldev->caps.bus_width >> 3) - 1;
 	val = ((pitch_in_bytes << 16) | line_length);
 	reg_update_bits(ldev->regs, LTDC_L1CFBLR + lofs,
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index d1042196a30f..57cc26e1da01 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -149,7 +149,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 			goto unreference;
 		}
 
-		bpp = drm_format_info_plane_cpp(info, i);
+		bpp = info->cpp[i];
 
 		size = (height - 1) * cmd->pitches[i] +
 		       width * bpp + cmd->offsets[i];
diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index d97a4dff515d..706452f9b276 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -222,7 +222,7 @@ static void zx_vl_plane_atomic_update(struct drm_plane *plane,
 		cma_obj = drm_fb_cma_get_gem_obj(fb, i);
 		paddr = cma_obj->paddr + fb->offsets[i];
 		paddr += src_y * fb->pitches[i];
-		paddr += src_x * drm_format_info_plane_cpp(fb->format, i);
+		paddr += src_x * fb->format->cpp[i];
 		zx_writel(paddr_reg, paddr);
 		paddr_reg += 4;
 	}
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 4ef8ccb5d236..405466692bd2 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -261,23 +261,6 @@ drm_format_info_is_yuv_sampling_444(const struct drm_format_info *info)
 }
 
 /**
- * drm_format_info_plane_cpp - determine the bytes per pixel value
- * @format: pixel format info
- * @plane: plane index
- *
- * Returns:
- * The bytes per pixel value for the specified plane.
- */
-static inline
-int drm_format_info_plane_cpp(const struct drm_format_info *info, int plane)
-{
-	if (!info || plane >= info->num_planes)
-		return 0;
-
-	return info->cpp[plane];
-}
-
-/**
  * drm_format_info_plane_width - width of the plane given the first plane
  * @format: pixel format info
  * @width: width of the first plane
-- 
git-series 0.9.1
