Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E41720855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfDDPYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfDDPYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE2043132C2B;
        Thu,  4 Apr 2019 15:24:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81C916B49C;
        Thu,  4 Apr 2019 15:24:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 718FE1750B; Thu,  4 Apr 2019 17:24:30 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] drm: add dstclip parameter to drm_fb_memcpy()
Date:   Thu,  4 Apr 2019 17:24:26 +0200
Message-Id: <20190404152430.8263-3-kraxel@redhat.com>
In-Reply-To: <20190404152430.8263-1-kraxel@redhat.com>
References: <20190404152430.8263-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 04 Apr 2019 15:24:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When set apply clipping logic to destination too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fb_helper.h        | 2 +-
 drivers/gpu/drm/drm_fb_helper.c    | 6 ++++--
 drivers/gpu/drm/tinydrm/mipi-dbi.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 696017b38add..a57420f40643 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -643,6 +643,6 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 }
 
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
-		   struct drm_rect *clip);
+		   struct drm_rect *clip, bool dstclip);
 
 #endif
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 22d29834bbe9..fabeb408dce6 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3363,7 +3363,7 @@ EXPORT_SYMBOL(drm_fb_helper_modinit);
  * @dstclip: Clip destination too.
  */
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
-		   struct drm_rect *clip)
+		   struct drm_rect *clip, bool dstclip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
 	unsigned int pitch = fb->pitches[0];
@@ -3371,10 +3371,12 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y;
 
+	if (dstclip)
+		dst += (clip->y1 * pitch) + (clip->x1 * cpp);
 	for (y = clip->y1; y < clip->y2; y++) {
 		memcpy(dst, src, len);
 		src += pitch;
-		dst += len;
+		dst += dstclip ? pitch : len;
 	}
 }
 EXPORT_SYMBOL(drm_fb_memcpy);
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index fb7e4582e293..e26fd61360a3 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -221,7 +221,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 		if (swap)
 			tinydrm_swab16(dst, src, fb, clip);
 		else
-			drm_fb_memcpy(dst, src, fb, clip);
+			drm_fb_memcpy(dst, src, fb, clip, false);
 		break;
 	case DRM_FORMAT_XRGB8888:
 		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
-- 
2.18.1

