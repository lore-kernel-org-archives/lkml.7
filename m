Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEC2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfIEHFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731492AbfIEHFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFDCF3083362;
        Thu,  5 Sep 2019 07:05:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6628460126;
        Thu,  5 Sep 2019 07:05:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D353331F02; Thu,  5 Sep 2019 09:05:10 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/8] drm/vmwgfx: switch to own vma manager
Date:   Thu,  5 Sep 2019 09:05:08 +0200
Message-Id: <20190905070509.22407-8-kraxel@redhat.com>
In-Reply-To: <20190905070509.22407-1-kraxel@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 05 Sep 2019 07:05:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct drm_vma_offset_manager to vma_private, initialize it and
pass it to ttm_bo_device_init().

With this in place the last user of ttm's embedded vma offset manager
is gone and we can remove it (in a separate patch).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index dbb04dbcf478..adb0436528c7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -420,6 +420,7 @@ struct vmw_private {
 	struct vmw_fifo_state fifo;
 
 	struct drm_device *dev;
+	struct drm_vma_offset_manager vma_manager;
 	unsigned long vmw_chipset;
 	unsigned int io_start;
 	uint32_t vram_start;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 20bc91214e75..882facd055de 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -827,10 +827,13 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		goto out_no_fman;
 	}
 
+	drm_vma_offset_manager_init(&dev_priv->vma_manager,
+				    DRM_FILE_PAGE_OFFSET_START,
+				    DRM_FILE_PAGE_OFFSET_SIZE);
 	ret = ttm_bo_device_init(&dev_priv->bdev,
 				 &vmw_bo_driver,
 				 dev->anon_inode->i_mapping,
-				 NULL,
+				 &dev_priv->vma_manager,
 				 false);
 	if (unlikely(ret != 0)) {
 		DRM_ERROR("Failed initializing TTM buffer object driver.\n");
@@ -987,6 +990,7 @@ static void vmw_driver_unload(struct drm_device *dev)
 	if (dev_priv->has_mob)
 		(void) ttm_bo_clean_mm(&dev_priv->bdev, VMW_PL_MOB);
 	(void) ttm_bo_device_release(&dev_priv->bdev);
+	drm_vma_offset_manager_destroy(&dev_priv->vma_manager);
 	vmw_release_device_late(dev_priv);
 	vmw_fence_manager_takedown(dev_priv->fman);
 	if (dev_priv->capabilities & SVGA_CAP_IRQMASK)
-- 
2.18.1

