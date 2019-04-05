Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1101C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D2521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfDEJwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbfDEJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5BD33082B5A;
        Fri,  5 Apr 2019 09:52:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 227665D705;
        Fri,  5 Apr 2019 09:52:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 79325A1E0; Fri,  5 Apr 2019 11:52:20 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     noralf@tronnes.org, sam@ravnborg.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/5] drm: add drm_fb_xrgb8888_to_rgb888_dstclip()
Date:   Fri,  5 Apr 2019 11:52:18 +0200
Message-Id: <20190405095219.9231-5-kraxel@redhat.com>
In-Reply-To: <20190405095219.9231-1-kraxel@redhat.com>
References: <20190405095219.9231-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 05 Apr 2019 09:52:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simliar to drm_fb_xrgb8888_to_rgb565_dstclip() but converts to rgb888
instead of rgb565.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  3 ++
 drivers/gpu/drm/drm_format_helper.c | 60 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index a84d71fa446b..6f84380757ee 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -25,6 +25,9 @@ void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap);
+void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
+				       void *vaddr, struct drm_framebuffer *fb,
+				       struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
 			      struct drm_rect *clip);
 
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 246775510c2e..00d716f14173 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -210,6 +210,66 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
+static void drm_fb_xrgb8888_to_rgb888_lines(void *dst, unsigned int dst_pitch,
+					    void *src, unsigned int src_pitch,
+					    unsigned int src_linelength,
+					    unsigned int lines)
+{
+	unsigned int linepixels = src_linelength / 3;
+	unsigned int x, y;
+	u32 *sbuf;
+	u8 *dbuf;
+
+	sbuf = kmalloc(src_linelength, GFP_KERNEL);
+	if (!sbuf)
+		return;
+
+	for (y = 0; y < lines; y++) {
+		memcpy(sbuf, src, src_linelength);
+		dbuf = dst;
+		for (x = 0; x < linepixels; x++) {
+			*dbuf++ = (sbuf[x] & 0x000000FF) >>  0;
+			*dbuf++ = (sbuf[x] & 0x0000FF00) >>  8;
+			*dbuf++ = (sbuf[x] & 0x00FF0000) >> 16;
+		}
+		src += src_pitch;
+		dst += dst_pitch;
+	}
+
+	kfree(sbuf);
+}
+
+/**
+ * drm_fb_xrgb8888_to_rgb888_dstclip - Convert XRGB8888 to RGB888 clip buffer
+ * @dst: RGB565 destination buffer
+ * @dst_pitch: destination buffer pitch
+ * @vaddr: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @dstclip: Clip destination too.
+ *
+ * Drivers can use this function for RGB888 devices that don't natively
+ * support XRGB8888.
+ *
+ * This function applies clipping on dst, i.e. the destination is a
+ * full framebuffer but only the clip rect content is copied over.
+ */
+void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
+				       void *vaddr, struct drm_framebuffer *fb,
+				       struct drm_rect *clip)
+{
+	unsigned int src_offset = (clip->y1 * fb->pitches[0])
+		+ (clip->x1 * sizeof(u32));
+	unsigned int dst_offset = (clip->y1 * dst_pitch)
+		+ (clip->x1 * 3);
+	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
+
+	drm_fb_xrgb8888_to_rgb888_lines(dst + dst_offset, dst_pitch,
+					vaddr + src_offset, fb->pitches[0],
+					src_len, clip->y2 - clip->y1);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
+
 /**
  * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
  * @dst: 8-bit grayscale destination buffer
-- 
2.18.1

