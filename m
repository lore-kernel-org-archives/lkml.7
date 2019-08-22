Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EEFC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546921848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfHVGuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfHVGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:50:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E2EC10F23E4;
        Thu, 22 Aug 2019 06:50:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 969FD5D9E5;
        Thu, 22 Aug 2019 06:50:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C54E216E32; Thu, 22 Aug 2019 08:50:41 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/4] drm/bochs: pass framebuffer to bochs_hw_setbase
Date:   Thu, 22 Aug 2019 08:50:38 +0200
Message-Id: <20190822065041.11941-2-kraxel@redhat.com>
In-Reply-To: <20190822065041.11941-1-kraxel@redhat.com>
References: <20190822065041.11941-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 06:50:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also rename bochs_hw_setbase to bochs_hw_setfb,
we have to set more than just the base address.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  5 +++--
 drivers/gpu/drm/bochs/bochs_hw.c  | 24 +++++++++++-------------
 drivers/gpu/drm/bochs/bochs_kms.c | 11 +++--------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 68483a2fc12c..ed16840411f1 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -83,8 +83,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 		      struct drm_display_mode *mode);
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
-void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, int stride, u64 addr);
+void bochs_hw_setfb(struct bochs_device *bochs,
+		    struct drm_framebuffer *fb,
+		    int x, int y);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index e567bdfa2ab8..949930d8a92f 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -258,22 +258,20 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 	};
 }
 
-void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, int stride, u64 addr)
+void bochs_hw_setfb(struct bochs_device *bochs,
+		    struct drm_framebuffer *fb,
+		    int x, int y)
 {
-	unsigned long offset;
-	unsigned int vx, vy, vwidth;
-
-	bochs->stride = stride;
-	offset = (unsigned long)addr +
-		y * bochs->stride +
-		x * (bochs->bpp / 8);
-	vy = offset / bochs->stride;
-	vx = (offset % bochs->stride) * 8 / bochs->bpp;
-	vwidth = stride * 8 / bochs->bpp;
+	struct drm_gem_vram_object *bo = drm_gem_vram_of_gem(fb->obj[0]);
+	unsigned long offset = bo->bo.offset +
+		y * fb->pitches[0] +
+		x * fb->format->cpp[0];
+	int vy = offset / fb->pitches[0];
+	int vx = (offset % fb->pitches[0]) / fb->format->cpp[0];
+	int vwidth = fb->pitches[0] / fb->format->cpp[0];
 
 	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
-			 x, y, addr, offset, vx, vy);
+			 x, y, bo->bo.offset, offset, vx, vy);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 02a9c1ed165b..f5d663259753 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -29,17 +29,12 @@ static const uint32_t bochs_formats[] = {
 static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
-	struct drm_gem_vram_object *gbo;
-
 	if (!state->fb || !bochs->stride)
 		return;
 
-	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
-	bochs_hw_setbase(bochs,
-			 state->crtc_x,
-			 state->crtc_y,
-			 state->fb->pitches[0],
-			 state->fb->offsets[0] + gbo->bo.offset);
+	bochs_hw_setfb(bochs, state->fb,
+		       state->crtc_x,
+		       state->crtc_y);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
-- 
2.18.1

