Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92720C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E712146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFZGz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:55:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfFZGz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACABF307D861;
        Wed, 26 Jun 2019 06:55:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7900608C1;
        Wed, 26 Jun 2019 06:55:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C27E016E1A; Wed, 26 Jun 2019 08:55:51 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/bochs: fix framebuffer setup.
Date:   Wed, 26 Jun 2019 08:55:51 +0200
Message-Id: <20190626065551.12956-3-kraxel@redhat.com>
In-Reply-To: <20190626065551.12956-1-kraxel@redhat.com>
References: <20190626065551.12956-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 26 Jun 2019 06:55:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bo->width doesn't match fb->width the driver fails to configure
the display correctly, resulting in a scrambled display.  Fix it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 +-
 drivers/gpu/drm/bochs/bochs_hw.c  | 13 +++++++++----
 drivers/gpu/drm/bochs/bochs_kms.c |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index cc35d492142c..78c0283496cc 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr);
+		      int x, int y, int fbwidth, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 791ab2f79947..141aa02962d3 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -255,16 +255,21 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 }
 
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr)
+		      int x, int y, int fbwidth, u64 addr)
 {
-	unsigned long offset = (unsigned long)addr +
+	unsigned long offset;
+	unsigned int vx, vy;
+
+	bochs->stride = fbwidth * (bochs->bpp / 8);
+	offset = (unsigned long)addr +
 		y * bochs->stride +
 		x * (bochs->bpp / 8);
-	int vy = offset / bochs->stride;
-	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
+	vy = offset / bochs->stride;
+	vx = (offset % bochs->stride) * 8 / bochs->bpp;
 
 	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
 			 x, y, addr, offset, vx, vy);
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, fbwidth);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5904eddc83a5..1f6aa11a1dc9 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -36,6 +36,7 @@ static void bochs_plane_update(struct bochs_device *bochs,
 	bochs_hw_setbase(bochs,
 			 state->crtc_x,
 			 state->crtc_y,
+			 gbo->width,
 			 gbo->bo.offset);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
-- 
2.18.1

