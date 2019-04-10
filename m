Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCD52084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDJGiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfDJGiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:38:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BB41821D8;
        Wed, 10 Apr 2019 06:38:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60FBA61995;
        Wed, 10 Apr 2019 06:38:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8818F1747C; Wed, 10 Apr 2019 08:38:15 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm: switch drm_fb_xrgb8888_to_rgb888_dstclip to accept __iomem dst
Date:   Wed, 10 Apr 2019 08:38:15 +0200
Message-Id: <20190410063815.17062-4-kraxel@redhat.com>
In-Reply-To: <20190410063815.17062-1-kraxel@redhat.com>
References: <20190410063815.17062-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 10 Apr 2019 06:38:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all archs have the __io_virt() macro, so cirrus can't simply convert
pointers that way.  The drm format helpers have to use memcpy_toio()
instead.

This patch makes drm_fb_xrgb8888_to_rgb888_dstclip() accept a __iomem
dst pointer and use memcpy_toio() instead of memcpy().  The helper
function (drm_fb_xrgb8888_to_rgb888_line) has been changed to process a
single scanline.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  2 +-
 drivers/gpu/drm/cirrus/cirrus.c     |  2 +-
 drivers/gpu/drm/drm_format_helper.c | 57 +++++++++++++----------------
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index d1b8a9ea01b4..1594a1f967ad 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -26,7 +26,7 @@ void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap);
-void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index ed2f2d8cfb6f..be4ea370ba31 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -316,7 +316,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 						  vmap, fb, rect, false);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 3)
-		drm_fb_xrgb8888_to_rgb888_dstclip(__io_virt(cirrus->vram),
+		drm_fb_xrgb8888_to_rgb888_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect);
 
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index c9521af4e90b..dd9823e3a723 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -216,33 +216,16 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
-static void drm_fb_xrgb8888_to_rgb888_lines(void *dst, unsigned int dst_pitch,
-					    void *src, unsigned int src_pitch,
-					    unsigned int src_linelength,
-					    unsigned int lines)
+static void drm_fb_xrgb8888_to_rgb888_line(u8 *dbuf, u32 *sbuf,
+					   unsigned int pixels)
 {
-	unsigned int linepixels = src_linelength / 3;
-	unsigned int x, y;
-	u32 *sbuf;
-	u8 *dbuf;
+	unsigned int x;
 
-	sbuf = kmalloc(src_linelength, GFP_KERNEL);
-	if (!sbuf)
-		return;
-
-	for (y = 0; y < lines; y++) {
-		memcpy(sbuf, src, src_linelength);
-		dbuf = dst;
-		for (x = 0; x < linepixels; x++) {
-			*dbuf++ = (sbuf[x] & 0x000000FF) >>  0;
-			*dbuf++ = (sbuf[x] & 0x0000FF00) >>  8;
-			*dbuf++ = (sbuf[x] & 0x00FF0000) >> 16;
-		}
-		src += src_pitch;
-		dst += dst_pitch;
+	for (x = 0; x < pixels; x++) {
+		*dbuf++ = (sbuf[x] & 0x000000FF) >>  0;
+		*dbuf++ = (sbuf[x] & 0x0000FF00) >>  8;
+		*dbuf++ = (sbuf[x] & 0x00FF0000) >> 16;
 	}
-
-	kfree(sbuf);
 }
 
 /**
@@ -264,15 +247,25 @@ void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	unsigned int dst_offset = (clip->y1 * dst_pitch)
-		+ (clip->x1 * 3);
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
+	size_t linepixels = clip->x2 - clip->x1;
+	size_t dst_len = linepixels * 3;
+	unsigned y, lines = clip->y2 - clip->y1;
+	void *dbuf;
 
-	drm_fb_xrgb8888_to_rgb888_lines(dst + dst_offset, dst_pitch,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1);
+	dbuf = kmalloc(dst_len, GFP_KERNEL);
+	if (!dbuf)
+		return;
+
+	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
+	dst += clip_offset(clip, dst_pitch, sizeof(u16));
+	for (y = 0; y < lines; y++) {
+		drm_fb_xrgb8888_to_rgb888_line(dbuf, vaddr, linepixels);
+		memcpy_toio(dst, dbuf, dst_len);
+		vaddr += fb->pitches[0];
+		dst += dst_len;
+	}
+
+	kfree(dbuf);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
 
-- 
2.18.1

