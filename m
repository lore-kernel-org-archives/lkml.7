Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F849C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1121473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfDIL7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:59:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45503 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbfDIL7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:59:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E035B30FE5D8;
        Tue,  9 Apr 2019 11:59:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA11460BF1;
        Tue,  9 Apr 2019 11:59:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F3B1D16E31; Tue,  9 Apr 2019 13:59:13 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     noralf@tronnes.org, sam@ravnborg.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] drm: add generic convert_lines() function for format conversions.
Date:   Tue,  9 Apr 2019 13:59:10 +0200
Message-Id: <20190409115913.3468-2-kraxel@redhat.com>
In-Reply-To: <20190409115913.3468-1-kraxel@redhat.com>
References: <20190409115913.3468-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 09 Apr 2019 11:59:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce some infrastructure to handle format conversions:

 * New struct drm_format_convert containing the cpp for src
   and dst with a function pointer to actually convert a
   single scanline.
 * generic convert_lines() function which uses a struct
   drm_format_convert pointer to convert a rectangle.

drm_fb_swab16() has been switched over to the new
convert_lines() function as showcase.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_format_helper.c | 84 +++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 00d716f14173..f32e0173600c 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -16,6 +16,61 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
+struct drm_format_convert {
+	u32 dst_cpp;
+	u32 src_cpp;
+	void (*func)(void *dst, void *src, u32 pixels);
+};
+
+static void convert_swab16_fn(void *dst, void *src, u32 pixels)
+{
+	u16 *sbuf = src;
+	u16 *dbuf = dst;
+	u32 x;
+
+	for (x = 0; x < pixels; x++)
+		dbuf[x] = swab16(sbuf[16]);
+}
+
+static struct drm_format_convert convert_swab16 = {
+	.dst_cpp = 2,
+	.src_cpp = 2,
+	.func = convert_swab16_fn,
+};
+
+static void convert_lines(void *dst, unsigned int dst_pitch,
+			  void *src, unsigned int src_pitch,
+			  unsigned int pixels,
+			  unsigned int lines,
+			  struct drm_format_convert *conv)
+{
+	u32 src_linelength = pixels * conv->src_cpp;
+	u32 y;
+	void *sbuf;
+
+	/*
+	 * The cma memory is write-combined so reads are uncached.
+	 * Speed up by fetching one line at a time.
+	 */
+	sbuf = kmalloc(src_linelength, GFP_KERNEL);
+	if (!sbuf)
+		return;
+
+	for (y = 0; y < lines; y++) {
+		memcpy(sbuf, src, src_linelength);
+		conv->func(dst, sbuf, pixels);
+		src += src_pitch;
+		dst += dst_pitch;
+	}
+
+	kfree(sbuf);
+}
+
+static u32 clip_offset(struct drm_rect *clip, u32 pitch, u32 cpp)
+{
+	return (clip->y1 * pitch) + (clip->x1 * cpp);
+}
+
 static void drm_fb_memcpy_lines(void *dst, unsigned int dst_pitch,
 				void *src, unsigned int src_pitch,
 				unsigned int linelength, unsigned int lines)
@@ -85,28 +140,15 @@ EXPORT_SYMBOL(drm_fb_memcpy_dstclip);
 void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
-	size_t len = (clip->x2 - clip->x1) * sizeof(u16);
-	unsigned int x, y;
-	u16 *src, *buf;
+	struct drm_format_convert *conv = &convert_swab16;
+	unsigned int src_offset =
+		clip_offset(clip, fb->pitches[0], conv->src_cpp);
+	size_t pixels = (clip->x2 - clip->x1);
+	size_t lines = (clip->y2 - clip->y1);
 
-	/*
-	 * The cma memory is write-combined so reads are uncached.
-	 * Speed up by fetching one line at a time.
-	 */
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return;
-
-	for (y = clip->y1; y < clip->y2; y++) {
-		src = vaddr + (y * fb->pitches[0]);
-		src += clip->x1;
-		memcpy(buf, src, len);
-		src = buf;
-		for (x = clip->x1; x < clip->x2; x++)
-			*dst++ = swab16(*src++);
-	}
-
-	kfree(buf);
+	convert_lines(dst, pixels * conv->dst_cpp,
+		      vaddr + src_offset, fb->pitches[0],
+		      pixels, lines, conv);
 }
 EXPORT_SYMBOL(drm_fb_swab16);
 
-- 
2.18.1

