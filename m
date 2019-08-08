Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2763AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED32121479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbfHHJhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731122AbfHHJhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BDB330C1F8E;
        Thu,  8 Aug 2019 09:37:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85BB75D9D3;
        Thu,  8 Aug 2019 09:37:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BDF2E9D42; Thu,  8 Aug 2019 11:37:02 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/8] ttm: turn ttm_bo_device.vma_manager into a pointer
Date:   Thu,  8 Aug 2019 11:36:56 +0200
Message-Id: <20190808093702.29512-3-kraxel@redhat.com>
In-Reply-To: <20190808093702.29512-1-kraxel@redhat.com>
References: <20190808093702.29512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 08 Aug 2019 09:37:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the embedded struct vma_offset_manager, it is named _vma_manager
now.  ttm_bo_device.vma_manager is a pointer now, pointing to the
embedded ttm_bo_device._vma_manager by default.

Add ttm_bo_device_init_with_vma_manager() function which allows to
initialize ttm with a different vma manager.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_driver.h | 11 +++++++++--
 drivers/gpu/drm/ttm/ttm_bo.c    | 29 +++++++++++++++++++++--------
 drivers/gpu/drm/ttm/ttm_bo_vm.c |  6 +++---
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index 3f1935c19a66..2f84d6bcd1a7 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -441,7 +441,8 @@ extern struct ttm_bo_global {
  *
  * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
  * @man: An array of mem_type_managers.
- * @vma_manager: Address space manager
+ * @vma_manager: Address space manager (pointer)
+ * @_vma_manager: Address space manager (enbedded)
  * lru_lock: Spinlock that protects the buffer+device lru lists and
  * ddestroy lists.
  * @dev_mapping: A pointer to the struct address_space representing the
@@ -464,7 +465,8 @@ struct ttm_bo_device {
 	/*
 	 * Protected by internal locks.
 	 */
-	struct drm_vma_offset_manager vma_manager;
+	struct drm_vma_offset_manager *vma_manager;
+	struct drm_vma_offset_manager _vma_manager;
 
 	/*
 	 * Protected by the global:lru lock.
@@ -597,6 +599,11 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 		       struct ttm_bo_driver *driver,
 		       struct address_space *mapping,
 		       bool need_dma32);
+int ttm_bo_device_init_with_vma_manager(struct ttm_bo_device *bdev,
+					struct ttm_bo_driver *driver,
+					struct address_space *mapping,
+					struct drm_vma_offset_manager *vma_manager,
+					bool need_dma32);
 
 /**
  * ttm_bo_unmap_virtual
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 10a861a1690c..0ed1a1182962 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -672,7 +672,7 @@ static void ttm_bo_release(struct kref *kref)
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
 
-	drm_vma_offset_remove(&bdev->vma_manager, &bo->base.vma_node);
+	drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
 	ttm_mem_io_lock(man, false);
 	ttm_mem_io_free_vm(bo);
 	ttm_mem_io_unlock(man);
@@ -1353,7 +1353,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	 */
 	if (bo->type == ttm_bo_type_device ||
 	    bo->type == ttm_bo_type_sg)
-		ret = drm_vma_offset_add(&bdev->vma_manager, &bo->base.vma_node,
+		ret = drm_vma_offset_add(bdev->vma_manager, &bo->base.vma_node,
 					 bo->mem.num_pages);
 
 	/* passed reservation objects should already be locked,
@@ -1704,7 +1704,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
 			pr_debug("Swap list %d was clean\n", i);
 	spin_unlock(&glob->lru_lock);
 
-	drm_vma_offset_manager_destroy(&bdev->vma_manager);
+	drm_vma_offset_manager_destroy(&bdev->_vma_manager);
 
 	if (!ret)
 		ttm_bo_global_release();
@@ -1713,10 +1713,11 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
 }
 EXPORT_SYMBOL(ttm_bo_device_release);
 
-int ttm_bo_device_init(struct ttm_bo_device *bdev,
-		       struct ttm_bo_driver *driver,
-		       struct address_space *mapping,
-		       bool need_dma32)
+int ttm_bo_device_init_with_vma_manager(struct ttm_bo_device *bdev,
+					struct ttm_bo_driver *driver,
+					struct address_space *mapping,
+					struct drm_vma_offset_manager *vma_manager,
+					bool need_dma32)
 {
 	struct ttm_bo_global *glob = &ttm_bo_glob;
 	int ret;
@@ -1737,7 +1738,8 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 	if (unlikely(ret != 0))
 		goto out_no_sys;
 
-	drm_vma_offset_manager_init(&bdev->vma_manager,
+	bdev->vma_manager = vma_manager;
+	drm_vma_offset_manager_init(&bdev->_vma_manager,
 				    DRM_FILE_PAGE_OFFSET_START,
 				    DRM_FILE_PAGE_OFFSET_SIZE);
 	INIT_DELAYED_WORK(&bdev->wq, ttm_bo_delayed_workqueue);
@@ -1754,6 +1756,17 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 	ttm_bo_global_release();
 	return ret;
 }
+EXPORT_SYMBOL(ttm_bo_device_init_with_vma_manager);
+
+int ttm_bo_device_init(struct ttm_bo_device *bdev,
+		       struct ttm_bo_driver *driver,
+		       struct address_space *mapping,
+		       bool need_dma32)
+{
+	return ttm_bo_device_init_with_vma_manager(bdev, driver, mapping,
+						   &bdev->_vma_manager,
+						   need_dma32);
+}
 EXPORT_SYMBOL(ttm_bo_device_init);
 
 /*
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 85f5bcbe0c76..d4eecde8d050 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -409,16 +409,16 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
 	struct drm_vma_offset_node *node;
 	struct ttm_buffer_object *bo = NULL;
 
-	drm_vma_offset_lock_lookup(&bdev->vma_manager);
+	drm_vma_offset_lock_lookup(bdev->vma_manager);
 
-	node = drm_vma_offset_lookup_locked(&bdev->vma_manager, offset, pages);
+	node = drm_vma_offset_lookup_locked(bdev->vma_manager, offset, pages);
 	if (likely(node)) {
 		bo = container_of(node, struct ttm_buffer_object,
 				  base.vma_node);
 		bo = ttm_bo_get_unless_zero(bo);
 	}
 
-	drm_vma_offset_unlock_lookup(&bdev->vma_manager);
+	drm_vma_offset_unlock_lookup(bdev->vma_manager);
 
 	if (!bo)
 		pr_err("Could not find buffer object to map\n");
-- 
2.18.1

