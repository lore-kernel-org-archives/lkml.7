Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D05C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E199B20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfDIL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfDIL7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:59:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F319B308338F;
        Tue,  9 Apr 2019 11:59:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B912B1001E92;
        Tue,  9 Apr 2019 11:59:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 17C2D1747B; Tue,  9 Apr 2019 13:59:14 +0200 (CEST)
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
Subject: [PATCH 2/4] drm: use convert_lines() in xrgb8888_to_rgb565 helpers.
Date:   Tue,  9 Apr 2019 13:59:11 +0200
Message-Id: <20190409115913.3468-3-kraxel@redhat.com>
In-Reply-To: <20190409115913.3468-1-kraxel@redhat.com>
References: <20190409115913.3468-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 09 Apr 2019 11:59:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add two conversion functions for the swab / not swab cases.
That way we have to check the swab flag only once.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_format_helper.c | 117 +++++++++++++++-------------
 1 file changed, 62 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index f32e0173600c..b8d17cd0a9f8 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -38,6 +38,46 @@ static struct drm_format_convert convert_swab16 = {
 	.func = convert_swab16_fn,
 };
 
+static void convert_xrgb8888_to_rgb565_fn(void *dst, void *src, u32 pixels)
+{
+	u32 *sbuf = src;
+	u16 *dbuf = dst;
+	u32 x;
+
+	for (x = 0; x < pixels; x++) {
+		dbuf[x] = ((sbuf[x] & 0x00F80000) >> 8) |
+			((sbuf[x] & 0x0000FC00) >> 5) |
+			((sbuf[x] & 0x000000F8) >> 3);
+	}
+}
+
+static struct drm_format_convert convert_xrgb8888_to_rgb565 = {
+	.dst_cpp = 2,
+	.src_cpp = 4,
+	.func = convert_xrgb8888_to_rgb565_fn,
+};
+
+static void convert_xrgb8888_to_rgb565_swab_fn(void *dst, void *src, u32 pixels)
+{
+	u32 *sbuf = src;
+	u16 *dbuf = dst;
+	u16 val16;
+	u32 x;
+
+	for (x = 0; x < pixels; x++) {
+		val16 = ((sbuf[x] & 0x00F80000) >> 8) |
+			((sbuf[x] & 0x0000FC00) >> 5) |
+			((sbuf[x] & 0x000000F8) >> 3);
+		dbuf[x] = swab16(val16);
+	}
+}
+
+static struct drm_format_convert convert_xrgb8888_to_rgb565_swap = {
+	.dst_cpp = 2,
+	.src_cpp = 4,
+	.func = convert_xrgb8888_to_rgb565_swab_fn,
+};
+
 static void convert_lines(void *dst, unsigned int dst_pitch,
 			  void *src, unsigned int src_pitch,
 			  unsigned int pixels,
@@ -152,44 +192,6 @@ void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(drm_fb_swab16);
 
-static void drm_fb_xrgb8888_to_rgb565_lines(void *dst, unsigned int dst_pitch,
-					    void *src, unsigned int src_pitch,
-					    unsigned int src_linelength,
-					    unsigned int lines,
-					    bool swap)
-{
-	unsigned int linepixels = src_linelength / sizeof(u32);
-	unsigned int x, y;
-	u32 *sbuf;
-	u16 *dbuf, val16;
-
-	/*
-	 * The cma memory is write-combined so reads are uncached.
-	 * Speed up by fetching one line at a time.
-	 */
-	sbuf = kmalloc(src_linelength, GFP_KERNEL);
-	if (!sbuf)
-		return;
-
-	for (y = 0; y < lines; y++) {
-		memcpy(sbuf, src, src_linelength);
-		dbuf = dst;
-		for (x = 0; x < linepixels; x++) {
-			val16 = ((sbuf[x] & 0x00F80000) >> 8) |
-				((sbuf[x] & 0x0000FC00) >> 5) |
-				((sbuf[x] & 0x000000F8) >> 3);
-			if (swap)
-				*dbuf++ = swab16(val16);
-			else
-				*dbuf++ = val16;
-		}
-		src += src_pitch;
-		dst += dst_pitch;
-	}
-
-	kfree(sbuf);
-}
-
 /**
  * drm_fb_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
  * @dst: RGB565 destination buffer
@@ -208,15 +210,17 @@ void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
 			       struct drm_rect *clip, bool swap)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
-	size_t dst_len = (clip->x2 - clip->x1) * sizeof(u16);
+	struct drm_format_convert *conv = swap
+		? &convert_xrgb8888_to_rgb565_swap
+		: &convert_xrgb8888_to_rgb565;
+	unsigned int src_offset =
+		clip_offset(clip, fb->pitches[0], conv->src_cpp);
+	size_t pixels = (clip->x2 - clip->x1);
+	size_t lines = (clip->y2 - clip->y1);
 
-	drm_fb_xrgb8888_to_rgb565_lines(dst, dst_len,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1,
-					swap);
+	convert_lines(dst, pixels * conv->dst_cpp,
+		      vaddr + src_offset, fb->pitches[0],
+		      pixels, lines, conv);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
 
@@ -239,16 +243,19 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	unsigned int dst_offset = (clip->y1 * dst_pitch)
-		+ (clip->x1 * sizeof(u16));
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
+	struct drm_format_convert *conv = swap
+		? &convert_xrgb8888_to_rgb565_swap
+		: &convert_xrgb8888_to_rgb565;
+	unsigned int src_offset =
+		clip_offset(clip, fb->pitches[0], conv->src_cpp);
+	unsigned int dst_offset =
+		clip_offset(clip, dst_pitch, conv->dst_cpp);
+	size_t pixels = (clip->x2 - clip->x1);
+	size_t lines = (clip->y2 - clip->y1);
 
-	drm_fb_xrgb8888_to_rgb565_lines(dst + dst_offset, dst_pitch,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1,
-					swap);
+	convert_lines(dst + dst_offset, dst_pitch,
+		      vaddr + src_offset, fb->pitches[0],
+		      pixels, lines, conv);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
-- 
2.18.1

