Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA92A20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfDDPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37641 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfDDPYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:24:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 954307BDCA;
        Thu,  4 Apr 2019 15:24:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 839E010A4B3D;
        Thu,  4 Apr 2019 15:24:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EEAC6A1E2; Thu,  4 Apr 2019 17:24:30 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] drm: add drm_fb_xrgb8888_to_rgb888() function to drm_fb_helper.c
Date:   Thu,  4 Apr 2019 17:24:29 +0200
Message-Id: <20190404152430.8263-6-kraxel@redhat.com>
In-Reply-To: <20190404152430.8263-1-kraxel@redhat.com>
References: <20190404152430.8263-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 04 Apr 2019 15:24:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like drm_fb_xrgb8888_to_rgb565() but converts to 24bpp (DRM_FORMAT_RGB888).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fb_helper.h     |  4 +++
 drivers/gpu/drm/drm_fb_helper.c | 49 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 1406057e1a93..a6e56fcd948e 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -648,5 +648,9 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
 			       struct drm_rect *clip,
 			       bool swap, bool dstclip);
+void drm_fb_xrgb8888_to_rgb888(u8 *dst, void *vaddr,
+			       struct drm_framebuffer *fb,
+			       struct drm_rect *clip,
+			       bool dstclip);
 
 #endif
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 2c9286702c3f..6ef0ad4f40b1 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3431,3 +3431,52 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 	kfree(buf);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
+
+/**
+ * drm_fb_xrgb8888_to_rgb888 - Convert XRGB8888 to RGB888 clip buffer
+ * @dst: RGB565 destination buffer
+ * @vaddr: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @dstclip: Clip destination too.
+ *
+ * Drivers can use this function for RGB888 devices that don't natively
+ * support XRGB8888.
+ */
+void drm_fb_xrgb8888_to_rgb888(u8 *dst, void *vaddr,
+			       struct drm_framebuffer *fb,
+			       struct drm_rect *clip,
+			       bool dstclip)
+{
+	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
+	unsigned int x, y;
+	u32 *src, *buf;
+	u8 red, green, blue;
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	if (dstclip)
+		dst += (clip->y1 * fb->width + clip->x1) * 3;
+	for (y = clip->y1; y < clip->y2; y++) {
+		src = vaddr + (y * fb->pitches[0]);
+		src += clip->x1;
+		memcpy(buf, src, len);
+		src = buf;
+		for (x = clip->x1; x < clip->x2; x++) {
+			red   = (*src & 0x00FF0000) >> 16;
+			green = (*src & 0x0000FF00) >>  8;
+			blue  = (*src & 0x000000FF) >>  0;
+			src++;
+			*dst++ = blue;
+			*dst++ = green;
+			*dst++ = red;
+		}
+		if (dstclip)
+			dst += (fb->width - (clip->x2 - clip->x1)) * 3;
+	}
+
+	kfree(buf);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888);
-- 
2.18.1

