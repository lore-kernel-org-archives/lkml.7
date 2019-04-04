Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F220855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfDDPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:24:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41933 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfDDPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:24:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 606C9757F9;
        Thu,  4 Apr 2019 15:24:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC327FC1F;
        Thu,  4 Apr 2019 15:24:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CFACBA1E0; Thu,  4 Apr 2019 17:24:30 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] drm: add dstclip parameter to drm_fb_xrgb8888_to_rgb565()
Date:   Thu,  4 Apr 2019 17:24:28 +0200
Message-Id: <20190404152430.8263-5-kraxel@redhat.com>
In-Reply-To: <20190404152430.8263-1-kraxel@redhat.com>
References: <20190404152430.8263-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 04 Apr 2019 15:24:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When set apply clipping logic to destination too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fb_helper.h        | 3 ++-
 drivers/gpu/drm/drm_fb_helper.c    | 8 +++++++-
 drivers/gpu/drm/tinydrm/mipi-dbi.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 0350c7e9d6ba..1406057e1a93 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -646,6 +646,7 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip, bool dstclip);
 void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
-			       struct drm_rect *clip, bool swap);
+			       struct drm_rect *clip,
+			       bool swap, bool dstclip);
 
 #endif
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 087e49741094..2c9286702c3f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3388,13 +3388,15 @@ EXPORT_SYMBOL(drm_fb_memcpy);
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  * @swap: Swap bytes
+ * @dstclip: Clip destination too.
  *
  * Drivers can use this function for RGB565 devices that don't natively
  * support XRGB8888.
  */
 void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
-			       struct drm_rect *clip, bool swap)
+			       struct drm_rect *clip,
+			       bool swap, bool dstclip)
 {
 	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
 	unsigned int x, y;
@@ -3405,6 +3407,8 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 	if (!buf)
 		return;
 
+	if (dstclip)
+		dst += clip->y1 * fb->width + clip->x1;
 	for (y = clip->y1; y < clip->y2; y++) {
 		src = vaddr + (y * fb->pitches[0]);
 		src += clip->x1;
@@ -3420,6 +3424,8 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
 			else
 				*dst++ = val16;
 		}
+		if (dstclip)
+			dst += fb->width - (clip->x2 - clip->x1);
 	}
 
 	kfree(buf);
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index cf8df5fb7494..b2d74f8707db 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -224,7 +224,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 			drm_fb_memcpy(dst, src, fb, clip, false);
 		break;
 	case DRM_FORMAT_XRGB8888:
-		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
+		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap, false);
 		break;
 	default:
 		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
-- 
2.18.1

