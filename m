Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B38C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF820828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfF0MYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:24:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfF0MYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6653230089B5;
        Thu, 27 Jun 2019 12:23:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 029B45D71C;
        Thu, 27 Jun 2019 12:23:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5126916E36; Thu, 27 Jun 2019 14:23:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/5] drm/bochs: drop stride and bpp from struct bochs_device
Date:   Thu, 27 Jun 2019 14:23:47 +0200
Message-Id: <20190627122348.5833-5-kraxel@redhat.com>
In-Reply-To: <20190627122348.5833-1-kraxel@redhat.com>
References: <20190627122348.5833-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 27 Jun 2019 12:24:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to store that, struct drm_framebuffer has all we need.

Also update VBE_DISPI_INDEX_VIRT_WIDTH register, otherwise we'll
have a fixes broken display in case pitch != width * cpp.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 --
 drivers/gpu/drm/bochs/bochs_hw.c  | 18 +++++++++---------
 drivers/gpu/drm/bochs/bochs_kms.c |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 5c90b76708ef..4081b3aba28d 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -64,8 +64,6 @@ struct bochs_device {
 	/* mode */
 	u16 xres;
 	u16 yres;
-	u32 stride;
-	u32 bpp;
 	struct edid *edid;
 
 	/* drm */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 9ab6ec269ef9..178715c6755d 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -205,16 +205,14 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 {
 	bochs->xres = mode->hdisplay;
 	bochs->yres = mode->vdisplay;
-	bochs->bpp = 32;
-	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp\n",
-			 bochs->xres, bochs->yres, bochs->bpp);
+	DRM_DEBUG_DRIVER("%dx%d\n",
+			 bochs->xres, bochs->yres);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
 
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
-	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         32);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_XRES,        bochs->xres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_YRES,        bochs->yres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BANK,        0);
@@ -256,11 +254,13 @@ void bochs_hw_setfb(struct bochs_device *bochs,
 {
 	struct drm_gem_vram_object *bo = drm_gem_vram_of_gem(fb->obj[0]);
 	unsigned long offset = bo->bo.offset +
-		y * bochs->stride +
-		x * (bochs->bpp / 8);
-	int vy = offset / bochs->stride;
-	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
+		y * fb->pitches[0] +
+		x * fb->format->cpp[0];
+	int vy = offset / fb->pitches[0];
+	int vx = (offset % fb->pitches[0]) / fb->format->cpp[0];
+	int vw = fb->pitches[0] / fb->format->cpp[0];
 
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vw);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ddbf0802138d..28edfb2772ff 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -27,7 +27,7 @@ static const uint32_t bochs_formats[] = {
 static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
-	if (!state->fb || !bochs->stride)
+	if (!state->fb)
 		return;
 
 	bochs_hw_setfb(bochs, state->fb,
-- 
2.18.1

