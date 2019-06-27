Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6AAC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6067120828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfF0MYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfF0MX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B1AD305E23A;
        Thu, 27 Jun 2019 12:23:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6D46600CC;
        Thu, 27 Jun 2019 12:23:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 78CFC9DB6; Thu, 27 Jun 2019 14:23:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/5] drm/bochs: move bochs_hw_setformat() call
Date:   Thu, 27 Jun 2019 14:23:48 +0200
Message-Id: <20190627122348.5833-6-kraxel@redhat.com>
In-Reply-To: <20190627122348.5833-1-kraxel@redhat.com>
References: <20190627122348.5833-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 27 Jun 2019 12:23:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call it from bochs_hw_setfb().
This also allows to make bochs_hw_setformat static.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 2 --
 drivers/gpu/drm/bochs/bochs_hw.c  | 5 +++--
 drivers/gpu/drm/bochs/bochs_kms.c | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 4081b3aba28d..528b8e8dde40 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -80,8 +80,6 @@ void bochs_hw_fini(struct drm_device *dev);
 
 void bochs_hw_setmode(struct bochs_device *bochs,
 		      struct drm_display_mode *mode);
-void bochs_hw_setformat(struct bochs_device *bochs,
-			const struct drm_format_info *format);
 void bochs_hw_setfb(struct bochs_device *bochs,
 		    struct drm_framebuffer *fb,
 		    int x, int y);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 178715c6755d..daa4fda3d322 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -224,8 +224,8 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
 }
 
-void bochs_hw_setformat(struct bochs_device *bochs,
-			const struct drm_format_info *format)
+static void bochs_hw_setformat(struct bochs_device *bochs,
+			       const struct drm_format_info *format)
 {
 	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
 			 (format->format >>  0) & 0xff,
@@ -263,4 +263,5 @@ void bochs_hw_setfb(struct bochs_device *bochs,
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vw);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
+	bochs_hw_setformat(bochs, fb->format);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 28edfb2772ff..368803bd12e5 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -33,7 +33,6 @@ static void bochs_plane_update(struct bochs_device *bochs,
 	bochs_hw_setfb(bochs, state->fb,
 		       state->crtc_x,
 		       state->crtc_y);
-	bochs_hw_setformat(bochs, state->fb->format);
 }
 
 static void bochs_pipe_enable(struct drm_simple_display_pipe *pipe,
-- 
2.18.1

