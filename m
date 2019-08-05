Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24918C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33202067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfHEMnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfHEMnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABE01C06511E;
        Mon,  5 Aug 2019 12:43:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC00A5DE5B;
        Mon,  5 Aug 2019 12:43:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 152739DBF; Mon,  5 Aug 2019 14:43:13 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, thomas@shipmail.org,
        tzimmermann@suse.de, ckoenig.leichtzumerken@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@redhat.com>,
        Huang Rui <ray.huang@amd.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU)
Subject: [PATCH v5 08/18] drm/ttm: use gem vma_node
Date:   Mon,  5 Aug 2019 14:43:00 +0200
Message-Id: <20190805124310.3275-9-kraxel@redhat.com>
In-Reply-To: <20190805124310.3275-1-kraxel@redhat.com>
References: <20190805124310.3275-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 12:43:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop vma_node from ttm_buffer_object, use the gem struct
(base.vma_node) instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
 drivers/gpu/drm/qxl/qxl_object.h           | 2 +-
 drivers/gpu/drm/radeon/radeon_object.h     | 2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h       | 2 +-
 include/drm/ttm/ttm_bo_api.h               | 4 ----
 drivers/gpu/drm/drm_gem_vram_helper.c      | 2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c  | 2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c      | 2 +-
 drivers/gpu/drm/ttm/ttm_bo.c               | 8 ++++----
 drivers/gpu/drm/ttm/ttm_bo_util.c          | 2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c            | 9 +++++----
 drivers/gpu/drm/virtio/virtgpu_prime.c     | 3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c         | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c    | 4 ++--
 14 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 645a189d365c..113fb2feb437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -191,7 +191,7 @@ static inline unsigned amdgpu_bo_gpu_page_alignment(struct amdgpu_bo *bo)
  */
 static inline u64 amdgpu_bo_mmap_offset(struct amdgpu_bo *bo)
 {
-	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
+	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
 /**
diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index b812d4ae9d0d..8ae54ba7857c 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -60,7 +60,7 @@ static inline unsigned long qxl_bo_size(struct qxl_bo *bo)
 
 static inline u64 qxl_bo_mmap_offset(struct qxl_bo *bo)
 {
-	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
+	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
 static inline int qxl_bo_wait(struct qxl_bo *bo, u32 *mem_type,
diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/radeon/radeon_object.h
index 9ffd8215d38a..e5554bf9140e 100644
--- a/drivers/gpu/drm/radeon/radeon_object.h
+++ b/drivers/gpu/drm/radeon/radeon_object.h
@@ -116,7 +116,7 @@ static inline unsigned radeon_bo_gpu_page_alignment(struct radeon_bo *bo)
  */
 static inline u64 radeon_bo_mmap_offset(struct radeon_bo *bo)
 {
-	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
+	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
 extern int radeon_bo_wait(struct radeon_bo *bo, u32 *mem_type,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f4ecea6054ba..e28829661724 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -396,7 +396,7 @@ static inline void virtio_gpu_object_unref(struct virtio_gpu_object **bo)
 
 static inline u64 virtio_gpu_object_mmap_offset(struct virtio_gpu_object *bo)
 {
-	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
+	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
 static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo,
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index fa050f0328ab..7ffc50a3303d 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -152,7 +152,6 @@ struct ttm_tt;
  * @ddestroy: List head for the delayed destroy list.
  * @swap: List head for swap LRU list.
  * @moving: Fence set when BO is moving
- * @vma_node: Address space manager node.
  * @offset: The current GPU offset, which can have different meanings
  * depending on the memory type. For SYSTEM type memory, it should be 0.
  * @cur_placement: Hint of current placement.
@@ -219,9 +218,6 @@ struct ttm_buffer_object {
 	 */
 
 	struct dma_fence *moving;
-
-	struct drm_vma_offset_node vma_node;
-
 	unsigned priority;
 
 	/**
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index fc13920b3cb4..fd751078bae1 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -168,7 +168,7 @@ EXPORT_SYMBOL(drm_gem_vram_put);
  */
 u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo)
 {
-	return drm_vma_node_offset_addr(&gbo->bo.vma_node);
+	return drm_vma_node_offset_addr(&gbo->bo.base.vma_node);
 }
 EXPORT_SYMBOL(drm_gem_vram_mmap_offset);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index fc8f5bb73ca8..98afc50162e9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -675,7 +675,7 @@ nouveau_display_dumb_map_offset(struct drm_file *file_priv,
 	gem = drm_gem_object_lookup(file_priv, handle);
 	if (gem) {
 		struct nouveau_bo *bo = nouveau_gem_object(gem);
-		*poffset = drm_vma_node_offset_addr(&bo->bo.vma_node);
+		*poffset = drm_vma_node_offset_addr(&bo->bo.base.vma_node);
 		drm_gem_object_put_unlocked(gem);
 		return 0;
 	}
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 2f484ab7dbca..b1e4852810ed 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -240,7 +240,7 @@ nouveau_gem_info(struct drm_file *file_priv, struct drm_gem_object *gem,
 	}
 
 	rep->size = nvbo->bo.mem.num_pages << PAGE_SHIFT;
-	rep->map_handle = drm_vma_node_offset_addr(&nvbo->bo.vma_node);
+	rep->map_handle = drm_vma_node_offset_addr(&nvbo->bo.base.vma_node);
 	rep->tile_mode = nvbo->mode;
 	rep->tile_flags = nvbo->contig ? 0 : NOUVEAU_GEM_TILE_NONCONTIG;
 	if (cli->device.info.family >= NV_DEVICE_INFO_V0_FERMI)
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ceff153f7e68..3e0a0cbc410e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -672,7 +672,7 @@ static void ttm_bo_release(struct kref *kref)
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
 
-	drm_vma_offset_remove(&bdev->vma_manager, &bo->vma_node);
+	drm_vma_offset_remove(&bdev->vma_manager, &bo->base.vma_node);
 	ttm_mem_io_lock(man, false);
 	ttm_mem_io_free_vm(bo);
 	ttm_mem_io_unlock(man);
@@ -1343,9 +1343,9 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 		 * struct elements we want use regardless.
 		 */
 		reservation_object_init(&bo->base._resv);
+		drm_vma_node_reset(&bo->base.vma_node);
 	}
 	atomic_inc(&bo->bdev->glob->bo_count);
-	drm_vma_node_reset(&bo->vma_node);
 
 	/*
 	 * For ttm_bo_type_device buffers, allocate
@@ -1353,7 +1353,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	 */
 	if (bo->type == ttm_bo_type_device ||
 	    bo->type == ttm_bo_type_sg)
-		ret = drm_vma_offset_add(&bdev->vma_manager, &bo->vma_node,
+		ret = drm_vma_offset_add(&bdev->vma_manager, &bo->base.vma_node,
 					 bo->mem.num_pages);
 
 	/* passed reservation objects should already be locked,
@@ -1781,7 +1781,7 @@ void ttm_bo_unmap_virtual_locked(struct ttm_buffer_object *bo)
 {
 	struct ttm_bo_device *bdev = bo->bdev;
 
-	drm_vma_node_unmap(&bo->vma_node, bdev->dev_mapping);
+	drm_vma_node_unmap(&bo->base.vma_node, bdev->dev_mapping);
 	ttm_mem_io_free_vm(bo);
 }
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 05fbcaf6a3f2..f5009c1b6a9c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -510,7 +510,7 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	INIT_LIST_HEAD(&fbo->base.io_reserve_lru);
 	mutex_init(&fbo->base.wu_mutex);
 	fbo->base.moving = NULL;
-	drm_vma_node_reset(&fbo->base.vma_node);
+	drm_vma_node_reset(&fbo->base.base.vma_node);
 	atomic_set(&fbo->base.cpu_writers, 0);
 
 	kref_init(&fbo->base.list_kref);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 6dacff49c1cc..fb6875a789b7 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -211,9 +211,9 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	}
 
 	page_offset = ((address - vma->vm_start) >> PAGE_SHIFT) +
-		vma->vm_pgoff - drm_vma_node_start(&bo->vma_node);
+		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
 	page_last = vma_pages(vma) + vma->vm_pgoff -
-		drm_vma_node_start(&bo->vma_node);
+		drm_vma_node_start(&bo->base.vma_node);
 
 	if (unlikely(page_offset >= bo->num_pages)) {
 		ret = VM_FAULT_SIGBUS;
@@ -267,7 +267,7 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 			} else if (unlikely(!page)) {
 				break;
 			}
-			page->index = drm_vma_node_start(&bo->vma_node) +
+			page->index = drm_vma_node_start(&bo->base.vma_node) +
 				page_offset;
 			pfn = page_to_pfn(page);
 		}
@@ -413,7 +413,8 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
 
 	node = drm_vma_offset_lookup_locked(&bdev->vma_manager, offset, pages);
 	if (likely(node)) {
-		bo = container_of(node, struct ttm_buffer_object, vma_node);
+		bo = container_of(node, struct ttm_buffer_object,
+				  base.vma_node);
 		bo = ttm_bo_get_unless_zero(bo);
 	}
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 8b3b2caf3364..dc642a884b88 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -68,8 +68,5 @@ void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
 			   struct vm_area_struct *vma)
 {
-	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-
-	bo->gem_base.vma_node.vm_node.start = bo->tbo.vma_node.vm_node.start;
 	return drm_gem_prime_mmap(obj, vma);
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 315da41a18b4..5739c6c49c99 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -835,7 +835,7 @@ int vmw_bo_alloc_ioctl(struct drm_device *dev, void *data,
 		goto out_no_bo;
 
 	rep->handle = handle;
-	rep->map_handle = drm_vma_node_offset_addr(&vbo->base.vma_node);
+	rep->map_handle = drm_vma_node_offset_addr(&vbo->base.base.vma_node);
 	rep->cur_gmr_id = handle;
 	rep->cur_gmr_offset = 0;
 
@@ -1077,7 +1077,7 @@ int vmw_dumb_map_offset(struct drm_file *file_priv,
 	if (ret != 0)
 		return -EINVAL;
 
-	*offset = drm_vma_node_offset_addr(&out_buf->base.vma_node);
+	*offset = drm_vma_node_offset_addr(&out_buf->base.base.vma_node);
 	vmw_bo_unreference(&out_buf);
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 219471903bc1..3a6da3b66484 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1669,7 +1669,7 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 	rep->backup_size = res->backup_size;
 	if (res->backup) {
 		rep->buffer_map_handle =
-			drm_vma_node_offset_addr(&res->backup->base.vma_node);
+			drm_vma_node_offset_addr(&res->backup->base.base.vma_node);
 		rep->buffer_size = res->backup->base.num_pages * PAGE_SIZE;
 		rep->buffer_handle = backup_handle;
 	} else {
@@ -1745,7 +1745,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->crep.backup_size = srf->res.backup_size;
 	rep->crep.buffer_handle = backup_handle;
 	rep->crep.buffer_map_handle =
-		drm_vma_node_offset_addr(&srf->res.backup->base.vma_node);
+		drm_vma_node_offset_addr(&srf->res.backup->base.base.vma_node);
 	rep->crep.buffer_size = srf->res.backup->base.num_pages * PAGE_SIZE;
 
 	rep->creq.version = drm_vmw_gb_surface_v1;
-- 
2.18.1

