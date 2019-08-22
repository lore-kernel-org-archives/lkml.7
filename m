Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D12C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E175233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfHVGu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:50:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbfHVGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:50:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1858910F23EC;
        Thu, 22 Aug 2019 06:50:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E031258BA;
        Thu, 22 Aug 2019 06:50:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1A3599AF5; Thu, 22 Aug 2019 08:50:42 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/4] drm/bochs: drop stride and bpp from struct bochs_device
Date:   Thu, 22 Aug 2019 08:50:40 +0200
Message-Id: <20190822065041.11941-4-kraxel@redhat.com>
In-Reply-To: <20190822065041.11941-1-kraxel@redhat.com>
References: <20190822065041.11941-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 06:50:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to store these values.  bpp is fixed (32) anyway.
We lookup the stride from struct drm_framebuffer if needed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 2 --
 drivers/gpu/drm/bochs/bochs_hw.c  | 8 +++-----
 drivers/gpu/drm/bochs/bochs_kms.c | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 6aae494ffbe8..fa36a358a5dc 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -62,8 +62,6 @@ struct bochs_device {
 	/* mode */
 	u16 xres;
 	u16 yres;
-	u32 stride;
-	u32 bpp;
 	struct edid *edid;
 
 	/* drm */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 2657b2e6e4d8..0749e9de1a4d 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -209,16 +209,14 @@ void bochs_hw_setmode(struct bochs_device *bochs,
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
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f5d663259753..334e458cbc31 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -29,7 +29,7 @@ static const uint32_t bochs_formats[] = {
 static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
-	if (!state->fb || !bochs->stride)
+	if (!state->fb)
 		return;
 
 	bochs_hw_setfb(bochs, state->fb,
-- 
2.18.1

