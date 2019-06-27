Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E5C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59B720828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfF0MYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfF0MYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89FB3308793B;
        Thu, 27 Jun 2019 12:23:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAC531001B0E;
        Thu, 27 Jun 2019 12:23:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 05CF116E1A; Thu, 27 Jun 2019 14:23:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/5] drm/bochs: pass framebuffer to bochs_hw_setbase
Date:   Thu, 27 Jun 2019 14:23:45 +0200
Message-Id: <20190627122348.5833-3-kraxel@redhat.com>
In-Reply-To: <20190627122348.5833-1-kraxel@redhat.com>
References: <20190627122348.5833-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 12:23:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also rename to bochs_hw_setfb, we have to set more
than just the base address.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  5 +++--
 drivers/gpu/drm/bochs/bochs_hw.c  | 10 +++++-----
 drivers/gpu/drm/bochs/bochs_kms.c | 10 +++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index cc35d492142c..246f05f4a711 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -85,8 +85,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 		      struct drm_display_mode *mode);
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
-void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr);
+void bochs_hw_setfb(struct bochs_device *bochs,
+		    struct drm_framebuffer *fb,
+		    int x, int y);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 791ab2f79947..67101c85029c 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -254,17 +254,17 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 	};
 }
 
-void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr)
+void bochs_hw_setfb(struct bochs_device *bochs,
+		    struct drm_framebuffer *fb,
+		    int x, int y)
 {
-	unsigned long offset = (unsigned long)addr +
+	struct drm_gem_vram_object *bo = drm_gem_vram_of_gem(fb->obj[0]);
+	unsigned long offset = bo->bo.offset +
 		y * bochs->stride +
 		x * (bochs->bpp / 8);
 	int vy = offset / bochs->stride;
 	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
 
-	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
-			 x, y, addr, offset, vx, vy);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5904eddc83a5..ddbf0802138d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -27,16 +27,12 @@ static const uint32_t bochs_formats[] = {
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
-			 gbo->bo.offset);
+	bochs_hw_setfb(bochs, state->fb,
+		       state->crtc_x,
+		       state->crtc_y);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
-- 
2.18.1

