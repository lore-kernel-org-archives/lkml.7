Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57E3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9910720828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF0MX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfF0MX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3218F308213C;
        Thu, 27 Jun 2019 12:23:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDFD95D71B;
        Thu, 27 Jun 2019 12:23:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 26E9C16E2D; Thu, 27 Jun 2019 14:23:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/5] drm/bochs: drop yres_virtual from struct bochs_device
Date:   Thu, 27 Jun 2019 14:23:46 +0200
Message-Id: <20190627122348.5833-4-kraxel@redhat.com>
In-Reply-To: <20190627122348.5833-1-kraxel@redhat.com>
References: <20190627122348.5833-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 27 Jun 2019 12:23:57 +0000 (UTC)
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
index 246f05f4a711..5c90b76708ef 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -64,7 +64,6 @@ struct bochs_device {
 	/* mode */
 	u16 xres;
 	u16 yres;
-	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
 	struct edid *edid;
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 67101c85029c..9ab6ec269ef9 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -207,11 +207,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
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
 
@@ -221,8 +219,6 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_YRES,        bochs->yres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BANK,        0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH,  bochs->xres);
-	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_HEIGHT,
-			  bochs->yres_virtual);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET,    0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET,    0);
 
-- 
2.18.1

