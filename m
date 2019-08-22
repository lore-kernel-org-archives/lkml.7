Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E08C3A5A4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBCA21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfHVGuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbfHVGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:50:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 224BA89F38E;
        Thu, 22 Aug 2019 06:50:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B489E58B5;
        Thu, 22 Aug 2019 06:50:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E57E77F; Thu, 22 Aug 2019 08:50:41 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/4] drm/bochs: drop yres_virtual from struct bochs_device
Date:   Thu, 22 Aug 2019 08:50:39 +0200
Message-Id: <20190822065041.11941-3-kraxel@redhat.com>
In-Reply-To: <20190822065041.11941-1-kraxel@redhat.com>
References: <20190822065041.11941-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Thu, 22 Aug 2019 06:50:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed, writing to VBE_DISPI_INDEX_VIRT_HEIGHT has no effect anyway.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h    | 1 -
 drivers/gpu/drm/bochs/bochs_hw.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index ed16840411f1..6aae494ffbe8 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -62,7 +62,6 @@ struct bochs_device {
 	/* mode */
 	u16 xres;
 	u16 yres;
-	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
 	struct edid *edid;
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 949930d8a92f..2657b2e6e4d8 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -211,11 +211,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs->yres = mode->vdisplay;
 	bochs->bpp = 32;
 	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
-	bochs->yres_virtual = bochs->fb_size / bochs->stride;
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, vy %d\n",
-			 bochs->xres, bochs->yres, bochs->bpp,
-			 bochs->yres_virtual);
+	DRM_DEBUG_DRIVER("%dx%d @ %d bpp\n",
+			 bochs->xres, bochs->yres, bochs->bpp);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
 
@@ -225,8 +223,6 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_YRES,        bochs->yres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BANK,        0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH,  bochs->xres);
-	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_HEIGHT,
-			  bochs->yres_virtual);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET,    0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET,    0);
 
-- 
2.18.1

