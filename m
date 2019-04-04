Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD18B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfDDPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:24:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfDDPYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 803262D0FB2;
        Thu,  4 Apr 2019 15:24:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86AF710A1823;
        Thu,  4 Apr 2019 15:24:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A81DB17532; Thu,  4 Apr 2019 17:24:30 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] drm: move tinydrm_xrgb8888_to_rgb565() to drm_fb_helper.c
Date:   Thu,  4 Apr 2019 17:24:27 +0200
Message-Id: <20190404152430.8263-4-kraxel@redhat.com>
In-Reply-To: <20190404152430.8263-1-kraxel@redhat.com>
References: <20190404152430.8263-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 04 Apr 2019 15:24:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also rename to drm_fb_xrgb8888_to_rgb565().
Pure code motion, no functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fb_helper.h                   |  3 ++
 include/drm/tinydrm/tinydrm-helpers.h         |  3 --
 drivers/gpu/drm/drm_fb_helper.c               | 45 +++++++++++++++++++
 .../gpu/drm/tinydrm/core/tinydrm-helpers.c    | 45 -------------------
 drivers/gpu/drm/tinydrm/mipi-dbi.c            |  2 +-
 5 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index a57420f40643..0350c7e9d6ba 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -644,5 +644,8 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip, bool dstclip);
+void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
+			       struct drm_framebuffer *fb,
+			       struct drm_rect *clip, bool swap);
 
 #endif
diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
index 591ca83330c4..220677107e0c 100644
--- a/include/drm/tinydrm/tinydrm-helpers.h
+++ b/include/drm/tinydrm/tinydrm-helpers.h
@@ -48,9 +48,6 @@ int tinydrm_display_pipe_init(struct drm_device *drm,
 
 void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		    struct drm_rect *clip);
-void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
-				struct drm_framebuffer *fb,
-				struct drm_rect *clip, bool swap);
 void tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
 			       struct drm_rect *clip);
 
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index fabeb408dce6..087e49741094 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3380,3 +3380,48 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 	}
 }
 EXPORT_SYMBOL(drm_fb_memcpy);
+
+/**
+ * drm_fb_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
+ * @dst: RGB565 destination buffer
+ * @vaddr: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @swap: Swap bytes
+ *
+ * Drivers can use this function for RGB565 devices that don't natively
+ * support XRGB8888.
+ */
+void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
+			       struct drm_framebuffer *fb,
+			       struct drm_rect *clip, bool swap)
+{
+	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
+	unsigned int x, y;
+	u32 *src, *buf;
+	u16 val16;
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		src = vaddr + (y * fb->pitches[0]);
+		src += clip->x1;
+		memcpy(buf, src, len);
+		src = buf;
+		for (x = clip->x1; x < clip->x2; x++) {
+			val16 = ((*src & 0x00F80000) >> 8) |
+				((*src & 0x0000FC00) >> 5) |
+				((*src & 0x000000F8) >> 3);
+			src++;
+			if (swap)
+				*dst++ = swab16(val16);
+			else
+				*dst++ = val16;
+		}
+	}
+
+	kfree(buf);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
index f5c6f35e6161..f4b84b15da75 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
@@ -61,51 +61,6 @@ void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(tinydrm_swab16);
 
-/**
- * tinydrm_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
- * @dst: RGB565 destination buffer
- * @vaddr: XRGB8888 source buffer
- * @fb: DRM framebuffer
- * @clip: Clip rectangle area to copy
- * @swap: Swap bytes
- *
- * Drivers can use this function for RGB565 devices that don't natively
- * support XRGB8888.
- */
-void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
-				struct drm_framebuffer *fb,
-				struct drm_rect *clip, bool swap)
-{
-	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
-	unsigned int x, y;
-	u32 *src, *buf;
-	u16 val16;
-
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return;
-
-	for (y = clip->y1; y < clip->y2; y++) {
-		src = vaddr + (y * fb->pitches[0]);
-		src += clip->x1;
-		memcpy(buf, src, len);
-		src = buf;
-		for (x = clip->x1; x < clip->x2; x++) {
-			val16 = ((*src & 0x00F80000) >> 8) |
-				((*src & 0x0000FC00) >> 5) |
-				((*src & 0x000000F8) >> 3);
-			src++;
-			if (swap)
-				*dst++ = swab16(val16);
-			else
-				*dst++ = val16;
-		}
-	}
-
-	kfree(buf);
-}
-EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
-
 /**
  * tinydrm_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
  * @dst: 8-bit grayscale destination buffer
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index e26fd61360a3..cf8df5fb7494 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -224,7 +224,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 			drm_fb_memcpy(dst, src, fb, clip, false);
 		break;
 	case DRM_FORMAT_XRGB8888:
-		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
+		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
 		break;
 	default:
 		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
-- 
2.18.1

