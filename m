Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34973C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2372082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfDBJFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfDBJFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D29E13087934;
        Tue,  2 Apr 2019 09:05:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4336402D;
        Tue,  2 Apr 2019 09:05:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C1B99A1E3; Tue,  2 Apr 2019 11:04:59 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/cirrus: drop mode_info.mode_config_initialized
Date:   Tue,  2 Apr 2019 11:04:59 +0200
Message-Id: <20190402090459.12126-3-kraxel@redhat.com>
In-Reply-To: <20190402090459.12126-1-kraxel@redhat.com>
References: <20190402090459.12126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Apr 2019 09:05:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.h  | 1 -
 drivers/gpu/drm/cirrus/cirrus_mode.c | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirrus/cirrus_drv.h
index 915709739257..828b150cdb20 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.h
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.h
@@ -101,7 +101,6 @@ struct cirrus_crtc {
 
 struct cirrus_fbdev;
 struct cirrus_mode_info {
-	bool				mode_config_initialized;
 	struct cirrus_crtc		*crtc;
 	/* pointer to fbdev info structure */
 	struct cirrus_fbdev		*gfbdev;
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 32ce2c1040b4..b109cd71426f 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -575,7 +575,6 @@ int cirrus_modeset_init(struct cirrus_device *cdev)
 	int ret;
 
 	drm_mode_config_init(cdev->dev);
-	cdev->mode_info.mode_config_initialized = true;
 
 	cdev->dev->mode_config.max_width = CIRRUS_MAX_FB_WIDTH;
 	cdev->dev->mode_config.max_height = CIRRUS_MAX_FB_HEIGHT;
@@ -613,10 +612,6 @@ int cirrus_modeset_init(struct cirrus_device *cdev)
 void cirrus_modeset_fini(struct cirrus_device *cdev)
 {
 	cirrus_fbdev_fini(cdev);
-
-	if (cdev->mode_info.mode_config_initialized) {
-		drm_helper_force_disable_all(cdev->dev);
-		drm_mode_config_cleanup(cdev->dev);
-		cdev->mode_info.mode_config_initialized = false;
-	}
+	drm_helper_force_disable_all(cdev->dev);
+	drm_mode_config_cleanup(cdev->dev);
 }
-- 
2.18.1

