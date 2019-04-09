Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D31C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641520833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDIL7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIL7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:59:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 759B830027D7;
        Tue,  9 Apr 2019 11:59:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05C2D1001F52;
        Tue,  9 Apr 2019 11:59:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5796A1750C; Tue,  9 Apr 2019 13:59:14 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     noralf@tronnes.org, sam@ravnborg.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] drm: add convert_lines_toio() variant, fix cirrus builds on powerpc.
Date:   Tue,  9 Apr 2019 13:59:13 +0200
Message-Id: <20190409115913.3468-5-kraxel@redhat.com>
In-Reply-To: <20190409115913.3468-1-kraxel@redhat.com>
References: <20190409115913.3468-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 09 Apr 2019 11:59:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __io_virt() macro is not available on all architectures, so cirrus
can't simply pass a pointer to io memory down to the format conversion
helpers.  The format conversion helpers must use memcpy_toio() instead.

Add a convert_lines_toio() variant which does just that.  Switch the
drm_fb_*_dstclip() functions used by cirrus to accept a __iomem pointer
as destination and pass that down to convert_lines_toio().  Fix the
calls in the cirrus driver to not use __io_virt() any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  9 ++--
 drivers/gpu/drm/cirrus/cirrus.c     |  6 +--
 drivers/gpu/drm/drm_format_helper.c | 74 ++++++++++++++++++++++-------
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 6f84380757ee..3532b76c2340 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -15,17 +15,20 @@ struct drm_rect;
 
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
-void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
+			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip);
 void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
 void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
 			       struct drm_rect *clip, bool swap);
-void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst,
+				       unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap);
-void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst,
+				       unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 5095b8ce52c2..be4ea370ba31 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -307,16 +307,16 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 		return -ENOMEM;
 
 	if (cirrus->cpp == fb->format->cpp[0])
-		drm_fb_memcpy_dstclip(__io_virt(cirrus->vram),
+		drm_fb_memcpy_dstclip(cirrus->vram,
 				      vmap, fb, rect);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2)
-		drm_fb_xrgb8888_to_rgb565_dstclip(__io_virt(cirrus->vram),
+		drm_fb_xrgb8888_to_rgb565_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect, false);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 3)
-		drm_fb_xrgb8888_to_rgb888_dstclip(__io_virt(cirrus->vram),
+		drm_fb_xrgb8888_to_rgb888_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect);
 
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 01d9ea134618..6a759cbaa263 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <asm/io.h>
+
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_fourcc.h>
@@ -125,6 +127,30 @@ static void convert_lines(void *dst, unsigned int dst_pitch,
 	kfree(sbuf);
 }
 
+static void convert_lines_toio(void __iomem *dst, unsigned int dst_pitch,
+			       void *src, unsigned int src_pitch,
+			       unsigned int pixels,
+			       unsigned int lines,
+			       struct drm_format_convert *conv)
+{
+	u32 dst_linelength = pixels * conv->dst_cpp;
+	u32 y;
+	void *dbuf;
+
+	dbuf = kmalloc(dst_linelength, GFP_KERNEL);
+	if (!dbuf)
+		return;
+
+	for (y = 0; y < lines; y++) {
+		conv->func(dbuf, src, pixels);
+		memcpy_toio(dst, dbuf, dst_linelength);
+		src += src_pitch;
+		dst += dst_pitch;
+	}
+
+	kfree(dbuf);
+}
+
 static u32 clip_offset(struct drm_rect *clip, u32 pitch, u32 cpp)
 {
 	return (clip->y1 * pitch) + (clip->x1 * cpp);
@@ -143,6 +169,19 @@ static void drm_fb_memcpy_lines(void *dst, unsigned int dst_pitch,
 	}
 }
 
+static void drm_fb_memcpy_lines_toio(void __iomem *dst, unsigned int dst_pitch,
+				     void *src, unsigned int src_pitch,
+				     unsigned int linelength, unsigned int lines)
+{
+	int line;
+
+	for (line = 0; line < lines; line++) {
+		memcpy_toio(dst, src, linelength);
+		src += src_pitch;
+		dst += dst_pitch;
+	}
+}
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Destination buffer
@@ -176,16 +215,17 @@ EXPORT_SYMBOL(drm_fb_memcpy);
  * This function applies clipping on dst, i.e. the destination is a
  * full framebuffer but only the clip rect content is copied over.
  */
-void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
+			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
 	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
 
-	drm_fb_memcpy_lines(dst + offset, fb->pitches[0],
-			    vaddr + offset, fb->pitches[0],
-			    len, clip->y2 - clip->y1);
+	drm_fb_memcpy_lines_toio(dst + offset, fb->pitches[0],
+				 vaddr + offset, fb->pitches[0],
+				 len, clip->y2 - clip->y1);
 }
 EXPORT_SYMBOL(drm_fb_memcpy_dstclip);
 
@@ -245,7 +285,7 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
 
 /**
  * drm_fb_xrgb8888_to_rgb565_dstclip - Convert XRGB8888 to RGB565 clip buffer
- * @dst: RGB565 destination buffer
+ * @dst: RGB565 destination buffer (__iomem)
  * @dst_pitch: destination buffer pitch
  * @vaddr: XRGB8888 source buffer
  * @fb: DRM framebuffer
@@ -256,9 +296,10 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
  * support XRGB8888.
  *
  * This function applies clipping on dst, i.e. the destination is a
- * full framebuffer but only the clip rect content is copied over.
+ * full framebuffer, in iomem, but only the clip rect content is copied over.
  */
-void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst,
+				       unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap)
 {
@@ -272,15 +313,15 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
 	size_t pixels = (clip->x2 - clip->x1);
 	size_t lines = (clip->y2 - clip->y1);
 
-	convert_lines(dst + dst_offset, dst_pitch,
-		      vaddr + src_offset, fb->pitches[0],
-		      pixels, lines, conv);
+	convert_lines_toio(dst + dst_offset, dst_pitch,
+			   vaddr + src_offset, fb->pitches[0],
+			   pixels, lines, conv);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
 /**
  * drm_fb_xrgb8888_to_rgb888_dstclip - Convert XRGB8888 to RGB888 clip buffer
- * @dst: RGB565 destination buffer
+ * @dst: RGB888 destination buffer (__iomem)
  * @dst_pitch: destination buffer pitch
  * @vaddr: XRGB8888 source buffer
  * @fb: DRM framebuffer
@@ -291,9 +332,10 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
  * support XRGB8888.
  *
  * This function applies clipping on dst, i.e. the destination is a
- * full framebuffer but only the clip rect content is copied over.
+ * full framebuffer, in iomem, but only the clip rect content is copied over.
  */
-void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst,
+				       unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip)
 {
@@ -305,9 +347,9 @@ void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
 	size_t pixels = (clip->x2 - clip->x1);
 	size_t lines = (clip->y2 - clip->y1);
 
-	convert_lines(dst + dst_offset, dst_pitch,
-		      vaddr + src_offset, fb->pitches[0],
-		      pixels, lines, conv);
+	convert_lines_toio(dst + dst_offset, dst_pitch,
+			   vaddr + src_offset, fb->pitches[0],
+			   pixels, lines, conv);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
 
-- 
2.18.1

