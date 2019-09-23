Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C904C32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D9220835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfIWMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:48:09 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:52626 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbfIWMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:48:08 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 08:48:02 EDT
Received: from hjc?rock-chips.com (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id B3EAB3E9;
        Mon, 23 Sep 2019 20:40:04 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P10893T140454720919296S1569242369031174_;
        Mon, 23 Sep 2019 20:40:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <34ffe67a50f98c47a25cd474b3d01953>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/36] drm: exynos: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:38:53 +0800
Message-Id: <1569242365-182133-5-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
References: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 4 ++--
 drivers/gpu/drm/exynos/exynos7_drm_decon.c    | 6 +++---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     | 4 ++--
 drivers/gpu/drm/exynos/exynos_drm_fimc.c      | 6 +++---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c      | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c       | 4 ++--
 drivers/gpu/drm/exynos/exynos_drm_ipp.c       | 6 +++---
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   | 4 ++--
 drivers/gpu/drm/exynos/exynos_drm_scaler.c    | 4 ++--
 drivers/gpu/drm/exynos/exynos_mixer.c         | 4 ++--
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 2d5cbfd..9401591 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -356,7 +356,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		break;
 	}
 
-	DRM_DEV_DEBUG_KMS(ctx->dev, "cpp = %u\n", fb->format->cpp[0]);
+	DRM_DEV_DEBUG_KMS(ctx->dev, "bpp = %u\n", fb->format->bpp[0]);
 
 	/*
 	 * In case of exynos, setting dma-burst to 16Word causes permanent
@@ -403,7 +403,7 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	struct decon_context *ctx = crtc->ctx;
 	struct drm_framebuffer *fb = state->base.fb;
 	unsigned int win = plane->index;
-	unsigned int cpp = fb->format->cpp[0];
+	unsigned int cpp = fb->format->bpp[0] / 8;
 	unsigned int pitch = fb->pitches[0];
 	dma_addr_t dma_addr = exynos_drm_fb_dma_addr(fb, 0);
 	u32 val;
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index f064095..d6158b7 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -310,7 +310,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		break;
 	}
 
-	DRM_DEV_DEBUG_KMS(ctx->dev, "cpp = %d\n", fb->format->cpp[0]);
+	DRM_DEV_DEBUG_KMS(ctx->dev, "bpp = %d\n", fb->format->bpp[0]);
 
 	/*
 	 * In case of exynos, setting dma-burst to 16Word causes permanent
@@ -320,7 +320,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	 * movement causes unstable DMA which results into iommu crash/tear.
 	 */
 
-	padding = (fb->pitches[0] / fb->format->cpp[0]) - fb->width;
+	padding = (fb->pitches[0] / fb->format->bpp[0] / 8) - fb->width;
 	if (fb->width + padding < MIN_FB_WIDTH_FOR_16WORD_BURST) {
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_8WORD;
@@ -387,7 +387,7 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned int last_x;
 	unsigned int last_y;
 	unsigned int win = plane->index;
-	unsigned int cpp = fb->format->cpp[0];
+	unsigned int cpp = fb->format->bpp[0] / 8;
 	unsigned int pitch = fb->pitches[0];
 
 	if (ctx->suspended)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index b0877b9..f82ac12 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -75,7 +75,7 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 {
 	struct fb_info *fbi;
 	struct drm_framebuffer *fb = helper->fb;
-	unsigned int size = fb->width * fb->height * fb->format->cpp[0];
+	unsigned int size = fb->width * fb->height * fb->format->bpp[0] / 8;
 	unsigned int nr_pages;
 	unsigned long offset;
 
@@ -100,7 +100,7 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 		return -EIO;
 	}
 
-	offset = fbi->var.xoffset * fb->format->cpp[0];
+	offset = fbi->var.xoffset * fb->format->bpp[0] / 8;
 	offset += fbi->var.yoffset * fb->pitches[0];
 
 	fbi->screen_base = exynos_gem->kvaddr + offset;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index a594ab7..ceb889c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -466,7 +466,7 @@ static void fimc_src_set_transf(struct fimc_context *ctx, unsigned int rotation)
 static void fimc_set_window(struct fimc_context *ctx,
 			    struct exynos_drm_ipp_buffer *buf)
 {
-	unsigned int real_width = buf->buf.pitch[0] / buf->format->cpp[0];
+	unsigned int real_width = buf->buf.pitch[0] / buf->format->bpp[0] / 8;
 	u32 cfg, h1, h2, v1, v2;
 
 	/* cropped image */
@@ -501,7 +501,7 @@ static void fimc_set_window(struct fimc_context *ctx,
 static void fimc_src_set_size(struct fimc_context *ctx,
 			      struct exynos_drm_ipp_buffer *buf)
 {
-	unsigned int real_width = buf->buf.pitch[0] / buf->format->cpp[0];
+	unsigned int real_width = buf->buf.pitch[0] / buf->format->bpp[0] / 8;
 	u32 cfg;
 
 	DRM_DEV_DEBUG_KMS(ctx->dev, "hsize[%d]vsize[%d]\n", real_width,
@@ -843,7 +843,7 @@ static void fimc_set_scaler(struct fimc_context *ctx, struct fimc_scaler *sc)
 static void fimc_dst_set_size(struct fimc_context *ctx,
 			     struct exynos_drm_ipp_buffer *buf)
 {
-	unsigned int real_width = buf->buf.pitch[0] / buf->format->cpp[0];
+	unsigned int real_width = buf->buf.pitch[0] / buf->format->bpp[0] / 8;
 	u32 cfg, cfg_ext;
 
 	DRM_DEV_DEBUG_KMS(ctx->dev, "hsize[%d]vsize[%d]\n", real_width,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 8d0a929..561597b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -795,7 +795,7 @@ static void fimd_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned long val, size, offset;
 	unsigned int last_x, last_y, buf_offsize, line_size;
 	unsigned int win = plane->index;
-	unsigned int cpp = fb->format->cpp[0];
+	unsigned int cpp = fb->format->bpp[0] / 8;
 	unsigned int pitch = fb->pitches[0];
 
 	if (ctx->suspended)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 1e4b21c..a15e2d9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -579,7 +579,7 @@ static void gsc_src_set_size(struct gsc_context *ctx,
 	cfg &= ~(GSC_SRCIMG_HEIGHT_MASK |
 		GSC_SRCIMG_WIDTH_MASK);
 
-	cfg |= (GSC_SRCIMG_WIDTH(buf->buf.pitch[0] / buf->format->cpp[0]) |
+	cfg |= (GSC_SRCIMG_WIDTH(buf->buf.pitch[0] / buf->format->bpp[0] / 8) |
 		GSC_SRCIMG_HEIGHT(buf->buf.height));
 
 	gsc_write(cfg, GSC_SRCIMG_SIZE);
@@ -881,7 +881,7 @@ static void gsc_dst_set_size(struct gsc_context *ctx,
 	/* original size */
 	cfg = gsc_read(GSC_DSTIMG_SIZE);
 	cfg &= ~(GSC_DSTIMG_HEIGHT_MASK | GSC_DSTIMG_WIDTH_MASK);
-	cfg |= GSC_DSTIMG_WIDTH(buf->buf.pitch[0] / buf->format->cpp[0]) |
+	cfg |= GSC_DSTIMG_WIDTH(buf->buf.pitch[0] / buf->format->bpp[0] / 8) |
 	       GSC_DSTIMG_HEIGHT(buf->buf.height);
 	gsc_write(cfg, GSC_DSTIMG_SIZE);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index d45bfab..14c728e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -475,7 +475,7 @@ static int exynos_drm_ipp_check_size_limits(struct exynos_drm_ipp_buffer *buf,
 	enum drm_ipp_size_id id = rotate ? IPP_LIMIT_ROTATED : IPP_LIMIT_AREA;
 	struct drm_ipp_limit l;
 	struct drm_exynos_ipp_limit_val *lh = &l.h, *lv = &l.v;
-	int real_width = buf->buf.pitch[0] / buf->format->cpp[0];
+	int real_width = buf->buf.pitch[0] / buf->format->bpp[0] / 8;
 
 	if (!limits)
 		return 0;
@@ -570,8 +570,8 @@ static int exynos_drm_ipp_check_format(struct exynos_drm_ipp_task *task,
 			     DIV_ROUND_UP(buf->buf.width, buf->format->hsub);
 
 		if (buf->buf.pitch[i] == 0)
-			buf->buf.pitch[i] = width * buf->format->cpp[i];
-		if (buf->buf.pitch[i] < width * buf->format->cpp[i])
+			buf->buf.pitch[i] = width * buf->format->bpp[i] / 8;
+		if (buf->buf.pitch[i] < width * buf->format->bpp[i] / 8)
 			return -EINVAL;
 		if (!buf->buf.gem_id[i])
 			return -ENOENT;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 8ebad27..8d1da0f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -139,7 +139,7 @@ static void rotator_src_set_buf(struct rot_context *rot,
 
 	/* Set buffer size configuration */
 	val = ROT_SET_BUF_SIZE_H(buf->buf.height) |
-	      ROT_SET_BUF_SIZE_W(buf->buf.pitch[0] / buf->format->cpp[0]);
+	      ROT_SET_BUF_SIZE_W(buf->buf.pitch[0] / buf->format->bpp[0] / 8);
 	rot_write(val, ROT_SRC_BUF_SIZE);
 
 	/* Set crop image position configuration */
@@ -187,7 +187,7 @@ static void rotator_dst_set_buf(struct rot_context *rot,
 
 	/* Set buffer size configuration */
 	val = ROT_SET_BUF_SIZE_H(buf->buf.height) |
-	      ROT_SET_BUF_SIZE_W(buf->buf.pitch[0] / buf->format->cpp[0]);
+	      ROT_SET_BUF_SIZE_W(buf->buf.pitch[0] / buf->format->bpp[0] / 8);
 	rot_write(val, ROT_DST_BUF_SIZE);
 
 	/* Set crop image position configuration */
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 9af0964..c9ad312 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -166,7 +166,7 @@ static inline void scaler_set_src_span(struct scaler_context *scaler,
 	u32 val;
 
 	val = SCALER_SRC_SPAN_SET_Y_SPAN(src_buf->buf.pitch[0] /
-		src_buf->format->cpp[0]);
+		src_buf->format->bpp[0] / 8);
 
 	if (src_buf->format->num_planes > 1)
 		val |= SCALER_SRC_SPAN_SET_C_SPAN(src_buf->buf.pitch[1]);
@@ -229,7 +229,7 @@ static inline void scaler_set_dst_span(struct scaler_context *scaler,
 	u32 val;
 
 	val = SCALER_DST_SPAN_SET_Y_SPAN(dst_buf->buf.pitch[0] /
-		dst_buf->format->cpp[0]);
+		dst_buf->format->bpp[0] / 8);
 
 	if (dst_buf->format->num_planes > 1)
 		val |= SCALER_DST_SPAN_SET_C_SPAN(dst_buf->buf.pitch[1]);
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 7b24338f..015dbab 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -646,7 +646,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 
 	/* translate dma address base s.t. the source image offset is zero */
 	dma_addr = exynos_drm_fb_dma_addr(fb, 0)
-		+ (state->src.x * fb->format->cpp[0])
+		+ (state->src.x * fb->format->bpp[0] / 8)
 		+ (state->src.y * fb->pitches[0]);
 
 	spin_lock_irqsave(&ctx->reg_slock, flags);
@@ -657,7 +657,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 
 	/* setup geometry */
 	mixer_reg_write(ctx, MXR_GRAPHIC_SPAN(win),
-			fb->pitches[0] / fb->format->cpp[0]);
+			fb->pitches[0] / fb->format->bpp[0] / 8);
 
 	val  = MXR_GRP_WH_WIDTH(state->src.w);
 	val |= MXR_GRP_WH_HEIGHT(state->src.h);
-- 
2.7.4



