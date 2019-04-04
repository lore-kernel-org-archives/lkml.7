Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D91C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE96C20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfDDPYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbfDDPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:24:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 489547F6C7;
        Thu,  4 Apr 2019 15:24:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CAB76B49D;
        Thu,  4 Apr 2019 15:24:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4AB911747D; Thu,  4 Apr 2019 17:24:30 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] drm: move tinydrm_memcpy() to drm_fb_helper.c
Date:   Thu,  4 Apr 2019 17:24:25 +0200
Message-Id: <20190404152430.8263-2-kraxel@redhat.com>
In-Reply-To: <20190404152430.8263-1-kraxel@redhat.com>
References: <20190404152430.8263-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 04 Apr 2019 15:24:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also rename to drm_fb_memcpy().
Pure code motion, no functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fb_helper.h                   |  3 +++
 include/drm/tinydrm/tinydrm-helpers.h         |  2 --
 drivers/gpu/drm/drm_fb_helper.c               | 25 +++++++++++++++++++
 .../gpu/drm/tinydrm/core/tinydrm-helpers.c    | 24 ------------------
 drivers/gpu/drm/tinydrm/mipi-dbi.c            |  3 ++-
 5 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 81ae48a0df48..696017b38add 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -642,4 +642,7 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 #endif
 }
 
+void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
+		   struct drm_rect *clip);
+
 #endif
diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
index ae4a6abc43b5..591ca83330c4 100644
--- a/include/drm/tinydrm/tinydrm-helpers.h
+++ b/include/drm/tinydrm/tinydrm-helpers.h
@@ -46,8 +46,6 @@ int tinydrm_display_pipe_init(struct drm_device *drm,
 			      const struct drm_display_mode *mode,
 			      unsigned int rotation);
 
-void tinydrm_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
-		    struct drm_rect *clip);
 void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		    struct drm_rect *clip);
 void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 03749a24e4dd..22d29834bbe9 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3353,3 +3353,28 @@ int __init drm_fb_helper_modinit(void)
 	return 0;
 }
 EXPORT_SYMBOL(drm_fb_helper_modinit);
+
+/**
+ * drm_fb_memcpy - Copy clip buffer
+ * @dst: Destination buffer
+ * @vaddr: Source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @dstclip: Clip destination too.
+ */
+void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
+		   struct drm_rect *clip)
+{
+	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
+	unsigned int pitch = fb->pitches[0];
+	void *src = vaddr + (clip->y1 * pitch) + (clip->x1 * cpp);
+	size_t len = (clip->x2 - clip->x1) * cpp;
+	unsigned int y;
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		memcpy(dst, src, len);
+		src += pitch;
+		dst += len;
+	}
+}
+EXPORT_SYMBOL(drm_fb_memcpy);
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
index d7b38dfb6438..f5c6f35e6161 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
@@ -26,30 +26,6 @@ static unsigned int spi_max;
 module_param(spi_max, uint, 0400);
 MODULE_PARM_DESC(spi_max, "Set a lower SPI max transfer size");
 
-/**
- * tinydrm_memcpy - Copy clip buffer
- * @dst: Destination buffer
- * @vaddr: Source buffer
- * @fb: DRM framebuffer
- * @clip: Clip rectangle area to copy
- */
-void tinydrm_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
-		    struct drm_rect *clip)
-{
-	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
-	unsigned int pitch = fb->pitches[0];
-	void *src = vaddr + (clip->y1 * pitch) + (clip->x1 * cpp);
-	size_t len = (clip->x2 - clip->x1) * cpp;
-	unsigned int y;
-
-	for (y = clip->y1; y < clip->y2; y++) {
-		memcpy(dst, src, len);
-		src += pitch;
-		dst += len;
-	}
-}
-EXPORT_SYMBOL(tinydrm_memcpy);
-
 /**
  * tinydrm_swab16 - Swap bytes into clip buffer
  * @dst: RGB565 destination buffer
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index 869c8f56da3b..fb7e4582e293 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -19,6 +19,7 @@
 
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fourcc.h>
@@ -220,7 +221,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 		if (swap)
 			tinydrm_swab16(dst, src, fb, clip);
 		else
-			tinydrm_memcpy(dst, src, fb, clip);
+			drm_fb_memcpy(dst, src, fb, clip);
 		break;
 	case DRM_FORMAT_XRGB8888:
 		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
-- 
2.18.1

