Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F20C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC00720833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDIL7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIL7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B151E5944C;
        Tue,  9 Apr 2019 11:59:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D50EE608A7;
        Tue,  9 Apr 2019 11:59:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2FDA91747C; Tue,  9 Apr 2019 13:59:14 +0200 (CEST)
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
Subject: [PATCH 3/4] drm: use convert_lines() in xrgb8888_to_rgb565 helpers.
Date:   Tue,  9 Apr 2019 13:59:12 +0200
Message-Id: <20190409115913.3468-4-kraxel@redhat.com>
In-Reply-To: <20190409115913.3468-1-kraxel@redhat.com>
References: <20190409115913.3468-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 09 Apr 2019 11:59:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_format_helper.c | 66 +++++++++++++----------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b8d17cd0a9f8..01d9ea134618 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -78,6 +78,25 @@ static struct drm_format_convert convert_xrgb8888_to_rgb565_swap = {
 	.func = convert_xrgb8888_to_rgb565_swab_fn,
 };
 
+static void convert_xrgb8888_to_rgb888_fn(void *dst, void *src, u32 pixels)
+{
+	u32 *sbuf = src;
+	u8 *dbuf = dst;
+	u32 x;
+
+	for (x = 0; x < pixels; x++) {
+		*dbuf++ = (sbuf[x] & 0x000000FF) >>  0;
+		*dbuf++ = (sbuf[x] & 0x0000FF00) >>  8;
+		*dbuf++ = (sbuf[x] & 0x00FF0000) >> 16;
+	}
+}
+
+static struct drm_format_convert convert_xrgb8888_to_rgb888 = {
+	.dst_cpp = 3,
+	.src_cpp = 4,
+	.func = convert_xrgb8888_to_rgb888_fn,
+};
+
 static void convert_lines(void *dst, unsigned int dst_pitch,
 			  void *src, unsigned int src_pitch,
 			  unsigned int pixels,
@@ -259,35 +278,6 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
-static void drm_fb_xrgb8888_to_rgb888_lines(void *dst, unsigned int dst_pitch,
-					    void *src, unsigned int src_pitch,
-					    unsigned int src_linelength,
-					    unsigned int lines)
-{
-	unsigned int linepixels = src_linelength / 3;
-	unsigned int x, y;
-	u32 *sbuf;
-	u8 *dbuf;
-
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
-	}
-
-	kfree(sbuf);
-}
-
 /**
  * drm_fb_xrgb8888_to_rgb888_dstclip - Convert XRGB8888 to RGB888 clip buffer
  * @dst: RGB565 destination buffer
@@ -307,15 +297,17 @@ void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	unsigned int dst_offset = (clip->y1 * dst_pitch)
-		+ (clip->x1 * 3);
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
+	struct drm_format_convert *conv = &convert_xrgb8888_to_rgb888;
+	unsigned int src_offset =
+		clip_offset(clip, fb->pitches[0], conv->src_cpp);
+	unsigned int dst_offset =
+		clip_offset(clip, dst_pitch, conv->dst_cpp);
+	size_t pixels = (clip->x2 - clip->x1);
+	size_t lines = (clip->y2 - clip->y1);
 
-	drm_fb_xrgb8888_to_rgb888_lines(dst + dst_offset, dst_pitch,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1);
+	convert_lines(dst + dst_offset, dst_pitch,
+		      vaddr + src_offset, fb->pitches[0],
+		      pixels, lines, conv);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
 
-- 
2.18.1

