Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A004C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05F1217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfIEHFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfIEHFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13FBB10F23E3;
        Thu,  5 Sep 2019 07:05:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68B576060D;
        Thu,  5 Sep 2019 07:05:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F3FC431F04; Thu,  5 Sep 2019 09:05:10 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] drm/ttm: remove embedded vma_offset_manager
Date:   Thu,  5 Sep 2019 09:05:09 +0200
Message-Id: <20190905070509.22407-9-kraxel@redhat.com>
In-Reply-To: <20190905070509.22407-1-kraxel@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 05 Sep 2019 07:05:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left.  Drivers either setup vma_offset_manager themself
(vmwgfx) or pass the gem vma_offset_manager to ttm_bo_device_init
(all other drivers).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_driver.h | 4 +---
 drivers/gpu/drm/ttm/ttm_bo.c    | 9 ++-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index e365434f92b3..4e307f65f497 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -442,7 +442,6 @@ extern struct ttm_bo_global {
  * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
  * @man: An array of mem_type_managers.
  * @vma_manager: Address space manager (pointer)
- * @_vma_manager: Address space manager (enbedded)
  * lru_lock: Spinlock that protects the buffer+device lru lists and
  * ddestroy lists.
  * @dev_mapping: A pointer to the struct address_space representing the
@@ -466,7 +465,6 @@ struct ttm_bo_device {
 	 * Protected by internal locks.
 	 */
 	struct drm_vma_offset_manager *vma_manager;
-	struct drm_vma_offset_manager _vma_manager;
 
 	/*
 	 * Protected by the global:lru lock.
@@ -587,7 +585,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev);
  * @glob: A pointer to an initialized struct ttm_bo_global.
  * @driver: A pointer to a struct ttm_bo_driver set up by the caller.
  * @mapping: The address space to use for this bo.
- * @vma_manager: A pointer to a vma manager or NULL.
+ * @vma_manager: A pointer to a vma manager.
  * @file_page_offset: Offset into the device address space that is available
  * for buffer data. This ensures compatibility with other users of the
  * address space.
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 8dc26babc5cb..881cf26d698e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1704,8 +1704,6 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
 			pr_debug("Swap list %d was clean\n", i);
 	spin_unlock(&glob->lru_lock);
 
-	drm_vma_offset_manager_destroy(&bdev->_vma_manager);
-
 	if (!ret)
 		ttm_bo_global_release();
 
@@ -1722,8 +1720,8 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 	struct ttm_bo_global *glob = &ttm_bo_glob;
 	int ret;
 
-	if (!vma_manager)
-		vma_manager = &bdev->_vma_manager;
+	if (WARN_ON(vma_manager == NULL))
+		return -EINVAL;
 
 	ret = ttm_bo_global_init();
 	if (ret)
@@ -1742,9 +1740,6 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 		goto out_no_sys;
 
 	bdev->vma_manager = vma_manager;
-	drm_vma_offset_manager_init(&bdev->_vma_manager,
-				    DRM_FILE_PAGE_OFFSET_START,
-				    DRM_FILE_PAGE_OFFSET_SIZE);
 	INIT_DELAYED_WORK(&bdev->wq, ttm_bo_delayed_workqueue);
 	INIT_LIST_HEAD(&bdev->ddestroy);
 	bdev->dev_mapping = mapping;
-- 
2.18.1

