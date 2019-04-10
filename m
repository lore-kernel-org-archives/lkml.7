Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2765C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DDA2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDJGiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfDJGiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1055C04B94F;
        Wed, 10 Apr 2019 06:38:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 375F818A81;
        Wed, 10 Apr 2019 06:38:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A15416E31; Wed, 10 Apr 2019 08:38:15 +0200 (CEST)
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
Subject: [PATCH v2 1/3] drm: switch drm_fb_memcpy_dstclip to accept __iomem dst
Date:   Wed, 10 Apr 2019 08:38:13 +0200
Message-Id: <20190410063815.17062-2-kraxel@redhat.com>
In-Reply-To: <20190410063815.17062-1-kraxel@redhat.com>
References: <20190410063815.17062-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 10 Apr 2019 06:38:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all archs have the __io_virt() macro, so cirrus can't simply convert
pointers that way.  The drm format helpers have to use memcpy_toio()
instead.

This patch makes drm_fb_memcpy_dstclip() accept a __iomem dst pointer
and use memcpy_toio() instead of memcpy().  With that separating out the
memcpy loop into the drm_fb_memcpy_lines() helper isn't useful any more,
so move the code back into the calling functins.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  3 +-
 drivers/gpu/drm/cirrus/cirrus.c     |  2 +-
 drivers/gpu/drm/drm_format_helper.c | 45 +++++++++++++++--------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 6f84380757ee..bc2e1004e166 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -15,7 +15,8 @@ struct drm_rect;
 
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
-void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
+			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip);
 void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 5095b8ce52c2..0fc3aa31b5a4 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -307,7 +307,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 		return -ENOMEM;
 
 	if (cirrus->cpp == fb->format->cpp[0])
-		drm_fb_memcpy_dstclip(__io_virt(cirrus->vram),
+		drm_fb_memcpy_dstclip(cirrus->vram,
 				      vmap, fb, rect);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2)
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 00d716f14173..dace05638bc3 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -10,23 +10,17 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
-static void drm_fb_memcpy_lines(void *dst, unsigned int dst_pitch,
-				void *src, unsigned int src_pitch,
-				unsigned int linelength, unsigned int lines)
+static unsigned int clip_offset(struct drm_rect *clip,
+				unsigned int pitch, unsigned int cpp)
 {
-	int line;
-
-	for (line = 0; line < lines; line++) {
-		memcpy(dst, src, linelength);
-		src += src_pitch;
-		dst += dst_pitch;
-	}
+	return clip->y1 * pitch + clip->x1 * cpp;
 }
 
 /**
@@ -43,35 +37,44 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
-	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
+	unsigned int y, lines = clip->y2 - clip->y1;
 
-	drm_fb_memcpy_lines(dst, len,
-			    vaddr + offset, fb->pitches[0],
-			    len, clip->y2 - clip->y1);
+	vaddr += clip_offset(clip, fb->pitches[0], cpp);
+	for (y = 0; y < lines; y++) {
+		memcpy(dst, vaddr, len);
+		vaddr += fb->pitches[0];
+		dst += len;
+	}
 }
 EXPORT_SYMBOL(drm_fb_memcpy);
 
 /**
  * drm_fb_memcpy_dstclip - Copy clip buffer
- * @dst: Destination buffer
+ * @dst: Destination buffer (iomem)
  * @vaddr: Source buffer
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
  * This function applies clipping on dst, i.e. the destination is a
- * full framebuffer but only the clip rect content is copied over.
+ * full (iomem) framebuffer but only the clip rect content is copied over.
  */
-void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
+			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
-	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
+	unsigned int offset = clip_offset(clip, fb->pitches[0], cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
+	unsigned int y, lines = clip->y2 - clip->y1;
 
-	drm_fb_memcpy_lines(dst + offset, fb->pitches[0],
-			    vaddr + offset, fb->pitches[0],
-			    len, clip->y2 - clip->y1);
+	vaddr += offset;
+	dst += offset;
+	for (y = 0; y < lines; y++) {
+		memcpy_toio(dst, vaddr, len);
+		vaddr += fb->pitches[0];
+		dst += fb->pitches[0];
+	}
 }
 EXPORT_SYMBOL(drm_fb_memcpy_dstclip);
 
-- 
2.18.1

