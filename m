Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566C921738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfDEJwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbfDEJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB8E9308FC4D;
        Fri,  5 Apr 2019 09:52:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D79961001DD5;
        Fri,  5 Apr 2019 09:52:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A82C1750B; Fri,  5 Apr 2019 11:52:20 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     noralf@tronnes.org, sam@ravnborg.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/5] drm: add drm_fb_memcpy_dstclip() helper
Date:   Fri,  5 Apr 2019 11:52:16 +0200
Message-Id: <20190405095219.9231-3-kraxel@redhat.com>
In-Reply-To: <20190405095219.9231-1-kraxel@redhat.com>
References: <20190405095219.9231-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 05 Apr 2019 09:52:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a drm_fb_memcpy() variant which checks the clip rectangle for the
destination too.

Common code between drm_fb_memcpy() and drm_fb_memcpy_dstclip() was
factored out into the drm_fb_memcpy_lines() helper function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  2 ++
 drivers/gpu/drm/drm_format_helper.c | 51 ++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 5a7ada6b0bef..c52b7b9a25f0 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -15,6 +15,8 @@ struct drm_rect;
 
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
+void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+			   struct drm_rect *clip);
 void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
 void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 62bb4913d6f6..55a2d629a75f 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -16,30 +16,65 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
+static void drm_fb_memcpy_lines(void *dst, unsigned int dst_pitch,
+				void *src, unsigned int src_pitch,
+				unsigned int linelength, unsigned int lines)
+{
+	int line;
+
+	for (line = 0; line < lines; line++) {
+		memcpy(dst, src, linelength);
+		src += src_pitch;
+		dst += dst_pitch;
+	}
+}
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Destination buffer
  * @vaddr: Source buffer
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
+ *
+ * This function does not apply clipping on dst, i.e. the destination
+ * is a small buffer containing the clip rect only.
  */
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
-	unsigned int pitch = fb->pitches[0];
-	void *src = vaddr + (clip->y1 * pitch) + (clip->x1 * cpp);
+	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
-	unsigned int y;
 
-	for (y = clip->y1; y < clip->y2; y++) {
-		memcpy(dst, src, len);
-		src += pitch;
-		dst += len;
-	}
+	drm_fb_memcpy_lines(dst, len,
+			    vaddr + offset, fb->pitches[0],
+			    len, clip->y2 - clip->y1);
 }
 EXPORT_SYMBOL(drm_fb_memcpy);
 
+/**
+ * drm_fb_memcpy_dstclip - Copy clip buffer
+ * @dst: Destination buffer
+ * @vaddr: Source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ *
+ * This function applies clipping on dst, i.e. the destination is a
+ * full framebuffer but only the clip rect content is copied over.
+ */
+void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+			   struct drm_rect *clip)
+{
+	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
+	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
+	size_t len = (clip->x2 - clip->x1) * cpp;
+
+	drm_fb_memcpy_lines(dst + offset, fb->pitches[0],
+			    vaddr + offset, fb->pitches[0],
+			    len, clip->y2 - clip->y1);
+}
+EXPORT_SYMBOL(drm_fb_memcpy_dstclip);
+
 /**
  * drm_fb_swab16 - Swap bytes into clip buffer
  * @dst: RGB565 destination buffer
-- 
2.18.1

