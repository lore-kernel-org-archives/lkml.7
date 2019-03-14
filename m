Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2910E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCNQe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:34:56 -0400
Received: from anholt.net ([50.246.234.109]:58376 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCNQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:34:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3C8E610A2E6A;
        Thu, 14 Mar 2019 09:34:55 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pdqCFaLWXjD2; Thu, 14 Mar 2019 09:34:51 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B0D3810A27AB;
        Thu, 14 Mar 2019 09:34:51 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 39B512FE4653; Thu, 14 Mar 2019 09:34:51 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/v3d: Use the new shmem helpers to reduce driver boilerplate.
Date:   Thu, 14 Mar 2019 09:34:51 -0700
Message-Id: <20190314163451.13431-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313004344.24169-1-robh@kernel.org>
References: <20190313004344.24169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new shmem helpers from Noralf and Rob abstract out a bunch of our
BO creation and mapping code.

v2: Use the new sgt getter, and flag pages as dirty before freeing.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/Kconfig   |   1 +
 drivers/gpu/drm/v3d/v3d_bo.c  | 317 ++++++++++------------------------
 drivers/gpu/drm/v3d/v3d_drv.c |  27 +--
 drivers/gpu/drm/v3d/v3d_drv.h |  14 +-
 drivers/gpu/drm/v3d/v3d_gem.c |  12 +-
 drivers/gpu/drm/v3d/v3d_irq.c |   8 +-
 drivers/gpu/drm/v3d/v3d_mmu.c |  11 +-
 7 files changed, 120 insertions(+), 270 deletions(-)

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index 1552bf552c94..75a74c45f109 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -5,6 +5,7 @@ config DRM_V3D
 	depends on COMMON_CLK
 	depends on MMU
 	select DRM_SCHED
+	select DRM_GEM_SHMEM_HELPER
 	help
 	  Choose this option if you have a system that has a Broadcom
 	  V3D 3.x or newer GPU, such as BCM7268.
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index dff38bf36c50..82f08d861389 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -25,158 +25,6 @@
 #include "v3d_drv.h"
 #include "uapi/drm/v3d_drm.h"
 
-/* Pins the shmem pages, fills in the .pages and .sgt fields of the BO, and maps
- * it for DMA.
- */
-static int
-v3d_bo_get_pages(struct v3d_bo *bo)
-{
-	struct drm_gem_object *obj = &bo->base;
-	struct drm_device *dev = obj->dev;
-	int npages = obj->size >> PAGE_SHIFT;
-	int ret = 0;
-
-	mutex_lock(&bo->lock);
-	if (bo->pages_refcount++ != 0)
-		goto unlock;
-
-	if (!obj->import_attach) {
-		bo->pages = drm_gem_get_pages(obj);
-		if (IS_ERR(bo->pages)) {
-			ret = PTR_ERR(bo->pages);
-			goto unlock;
-		}
-
-		bo->sgt = drm_prime_pages_to_sg(bo->pages, npages);
-		if (IS_ERR(bo->sgt)) {
-			ret = PTR_ERR(bo->sgt);
-			goto put_pages;
-		}
-
-		/* Map the pages for use by the GPU. */
-		dma_map_sg(dev->dev, bo->sgt->sgl,
-			   bo->sgt->nents, DMA_BIDIRECTIONAL);
-	} else {
-		bo->pages = kcalloc(npages, sizeof(*bo->pages), GFP_KERNEL);
-		if (!bo->pages)
-			goto put_pages;
-
-		drm_prime_sg_to_page_addr_arrays(bo->sgt, bo->pages,
-						 NULL, npages);
-
-		/* Note that dma-bufs come in mapped. */
-	}
-
-	mutex_unlock(&bo->lock);
-
-	return 0;
-
-put_pages:
-	drm_gem_put_pages(obj, bo->pages, true, true);
-	bo->pages = NULL;
-unlock:
-	bo->pages_refcount--;
-	mutex_unlock(&bo->lock);
-	return ret;
-}
-
-static void
-v3d_bo_put_pages(struct v3d_bo *bo)
-{
-	struct drm_gem_object *obj = &bo->base;
-
-	mutex_lock(&bo->lock);
-	if (--bo->pages_refcount == 0) {
-		if (!obj->import_attach) {
-			dma_unmap_sg(obj->dev->dev, bo->sgt->sgl,
-				     bo->sgt->nents, DMA_BIDIRECTIONAL);
-			sg_free_table(bo->sgt);
-			kfree(bo->sgt);
-			drm_gem_put_pages(obj, bo->pages, true, true);
-		} else {
-			kfree(bo->pages);
-		}
-	}
-	mutex_unlock(&bo->lock);
-}
-
-static struct v3d_bo *v3d_bo_create_struct(struct drm_device *dev,
-					   size_t unaligned_size)
-{
-	struct v3d_dev *v3d = to_v3d_dev(dev);
-	struct drm_gem_object *obj;
-	struct v3d_bo *bo;
-	size_t size = roundup(unaligned_size, PAGE_SIZE);
-	int ret;
-
-	if (size == 0)
-		return ERR_PTR(-EINVAL);
-
-	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
-	if (!bo)
-		return ERR_PTR(-ENOMEM);
-	obj = &bo->base;
-
-	INIT_LIST_HEAD(&bo->unref_head);
-	mutex_init(&bo->lock);
-
-	ret = drm_gem_object_init(dev, obj, size);
-	if (ret)
-		goto free_bo;
-
-	spin_lock(&v3d->mm_lock);
-	ret = drm_mm_insert_node_generic(&v3d->mm, &bo->node,
-					 obj->size >> PAGE_SHIFT,
-					 GMP_GRANULARITY >> PAGE_SHIFT, 0, 0);
-	spin_unlock(&v3d->mm_lock);
-	if (ret)
-		goto free_obj;
-
-	return bo;
-
-free_obj:
-	drm_gem_object_release(obj);
-free_bo:
-	kfree(bo);
-	return ERR_PTR(ret);
-}
-
-struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
-			     size_t unaligned_size)
-{
-	struct v3d_dev *v3d = to_v3d_dev(dev);
-	struct drm_gem_object *obj;
-	struct v3d_bo *bo;
-	int ret;
-
-	bo = v3d_bo_create_struct(dev, unaligned_size);
-	if (IS_ERR(bo))
-		return bo;
-	obj = &bo->base;
-
-	ret = v3d_bo_get_pages(bo);
-	if (ret)
-		goto free_mm;
-
-	v3d_mmu_insert_ptes(bo);
-
-	mutex_lock(&v3d->bo_lock);
-	v3d->bo_stats.num_allocated++;
-	v3d->bo_stats.pages_allocated += obj->size >> PAGE_SHIFT;
-	mutex_unlock(&v3d->bo_lock);
-
-	return bo;
-
-free_mm:
-	spin_lock(&v3d->mm_lock);
-	drm_mm_remove_node(&bo->node);
-	spin_unlock(&v3d->mm_lock);
-
-	drm_gem_object_release(obj);
-	kfree(bo);
-	return ERR_PTR(ret);
-}
-
 /* Called DRM core on the last userspace/kernel unreference of the
  * BO.
  */
@@ -185,83 +33,120 @@ void v3d_free_object(struct drm_gem_object *obj)
 	struct v3d_dev *v3d = to_v3d_dev(obj->dev);
 	struct v3d_bo *bo = to_v3d_bo(obj);
 
+	v3d_mmu_remove_ptes(bo);
+
 	mutex_lock(&v3d->bo_lock);
 	v3d->bo_stats.num_allocated--;
 	v3d->bo_stats.pages_allocated -= obj->size >> PAGE_SHIFT;
 	mutex_unlock(&v3d->bo_lock);
 
-	v3d_bo_put_pages(bo);
-
-	if (obj->import_attach)
-		drm_prime_gem_destroy(obj, bo->sgt);
-
-	v3d_mmu_remove_ptes(bo);
 	spin_lock(&v3d->mm_lock);
 	drm_mm_remove_node(&bo->node);
 	spin_unlock(&v3d->mm_lock);
 
-	mutex_destroy(&bo->lock);
+	drm_gem_shmem_put_pages(&bo->base);
 
-	drm_gem_object_release(obj);
-	kfree(bo);
-}
+	/* GPU execution may have dirtied any pages in the BO. */
+	bo->base.pages_mark_dirty_on_put = true;
 
-static void
-v3d_set_mmap_vma_flags(struct vm_area_struct *vma)
-{
-	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_flags |= VM_MIXEDMAP;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	drm_gem_shmem_free_object(obj);
 }
 
-vm_fault_t v3d_gem_fault(struct vm_fault *vmf)
+static const struct drm_gem_object_funcs v3d_gem_funcs = {
+	.free = v3d_free_object,
+	.print_info = drm_gem_shmem_print_info,
+	.pin = drm_gem_shmem_pin,
+	.unpin = drm_gem_shmem_unpin,
+	.get_sg_table = drm_gem_shmem_get_sg_table,
+	.vmap = drm_gem_shmem_vmap,
+	.vunmap = drm_gem_shmem_vunmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
+};
+
+/* gem_create_object function for allocating a BO struct and doing
+ * early setup.
+ */
+struct drm_gem_object *v3d_create_object(struct drm_device *dev, size_t size)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct drm_gem_object *obj = vma->vm_private_data;
-	struct v3d_bo *bo = to_v3d_bo(obj);
-	pfn_t pfn;
-	pgoff_t pgoff;
-
-	/* We don't use vmf->pgoff since that has the fake offset: */
-	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
-	pfn = __pfn_to_pfn_t(page_to_pfn(bo->pages[pgoff]), PFN_DEV);
+	struct v3d_bo *bo;
+	struct drm_gem_object *obj;
 
-	return vmf_insert_mixed(vma, vmf->address, pfn);
-}
+	if (size == 0)
+		return NULL;
 
-int v3d_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	int ret;
+	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
+	if (!bo)
+		return NULL;
+	obj = &bo->base.base;
 
-	ret = drm_gem_mmap(filp, vma);
-	if (ret)
-		return ret;
+	obj->funcs = &v3d_gem_funcs;
 
-	v3d_set_mmap_vma_flags(vma);
+	INIT_LIST_HEAD(&bo->unref_head);
 
-	return ret;
+	return &bo->base.base;
 }
 
-int v3d_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
+static int
+v3d_bo_create_finish(struct drm_gem_object *obj)
 {
+	struct v3d_dev *v3d = to_v3d_dev(obj->dev);
+	struct v3d_bo *bo = to_v3d_bo(obj);
+	struct sg_table *sgt;
 	int ret;
 
-	ret = drm_gem_mmap_obj(obj, obj->size, vma);
-	if (ret < 0)
+	/* So far we pin the BO in the MMU for its lifetime, so use
+	 * shmem's helper for getting a lifetime sgt.
+	 */
+	sgt = drm_gem_shmem_get_pages_sgt(&bo->base.base);
+	if (IS_ERR(sgt))
+		return PTR_ERR(sgt);
+
+	spin_lock(&v3d->mm_lock);
+	/* Allocate the object's space in the GPU's page tables.
+	 * Inserting PTEs will happen later, but the offset is for the
+	 * lifetime of the BO.
+	 */
+	ret = drm_mm_insert_node_generic(&v3d->mm, &bo->node,
+					 obj->size >> PAGE_SHIFT,
+					 GMP_GRANULARITY >> PAGE_SHIFT, 0, 0);
+	spin_unlock(&v3d->mm_lock);
+	if (ret) {
+		drm_gem_shmem_put_pages(&bo->base);
 		return ret;
+	}
 
-	v3d_set_mmap_vma_flags(vma);
+	/* Track stats for /debug/dri/n/bo_stats. */
+	mutex_lock(&v3d->bo_lock);
+	v3d->bo_stats.num_allocated++;
+	v3d->bo_stats.pages_allocated += obj->size >> PAGE_SHIFT;
+	mutex_unlock(&v3d->bo_lock);
+
+	v3d_mmu_insert_ptes(bo);
 
 	return 0;
 }
 
-struct sg_table *
-v3d_prime_get_sg_table(struct drm_gem_object *obj)
+struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
+			     size_t unaligned_size)
 {
-	struct v3d_bo *bo = to_v3d_bo(obj);
-	int npages = obj->size >> PAGE_SHIFT;
+	struct drm_gem_shmem_object *shmem_obj;
+	struct v3d_bo *bo;
+	int ret;
+
+	shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
+	if (!shmem_obj)
+		return NULL;
+	bo = to_v3d_bo(&shmem_obj->base);
+
+	ret = v3d_bo_create_finish(&shmem_obj->base);
+	if (ret)
+		goto free_obj;
+
+	return bo;
 
-	return drm_prime_pages_to_sg(bo->pages, npages);
+free_obj:
+	drm_gem_shmem_free_object(&shmem_obj->base);
+	return ERR_PTR(ret);
 }
 
 struct drm_gem_object *
@@ -269,27 +154,18 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 			  struct dma_buf_attachment *attach,
 			  struct sg_table *sgt)
 {
-	struct v3d_dev *v3d = to_v3d_dev(dev);
 	struct drm_gem_object *obj;
-	struct v3d_bo *bo;
-
-	bo = v3d_bo_create_struct(dev, attach->dmabuf->size);
-	if (IS_ERR(bo))
-		return ERR_CAST(bo);
-	obj = &bo->base;
-
-	obj->resv = attach->dmabuf->resv;
+	int ret;
 
-	bo->sgt = sgt;
-	obj->import_attach = attach;
-	v3d_bo_get_pages(bo);
+	obj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
+	if (IS_ERR(obj))
+		return obj;
 
-	mutex_lock(&v3d->bo_lock);
-	v3d->bo_stats.num_allocated++;
-	v3d->bo_stats.pages_allocated += obj->size >> PAGE_SHIFT;
-	mutex_unlock(&v3d->bo_lock);
-
-	v3d_mmu_insert_ptes(bo);
+	ret = v3d_bo_create_finish(obj);
+	if (ret) {
+		drm_gem_shmem_free_object(obj);
+		return ERR_PTR(ret);
+	}
 
 	return obj;
 }
@@ -312,8 +188,8 @@ int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
 
 	args->offset = bo->node.start << PAGE_SHIFT;
 
-	ret = drm_gem_handle_create(file_priv, &bo->base, &args->handle);
-	drm_gem_object_put_unlocked(&bo->base);
+	ret = drm_gem_handle_create(file_priv, &bo->base.base, &args->handle);
+	drm_gem_object_put_unlocked(&bo->base.base);
 
 	return ret;
 }
@@ -323,7 +199,6 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_v3d_mmap_bo *args = data;
 	struct drm_gem_object *gem_obj;
-	int ret;
 
 	if (args->flags != 0) {
 		DRM_INFO("unknown mmap_bo flags: %d\n", args->flags);
@@ -336,12 +211,10 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
 		return -ENOENT;
 	}
 
-	ret = drm_gem_create_mmap_offset(gem_obj);
-	if (ret == 0)
-		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
+	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
 	drm_gem_object_put_unlocked(gem_obj);
 
-	return ret;
+	return 0;
 }
 
 int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 89b7567d550f..d600628bb5c1 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -161,17 +161,7 @@ v3d_postclose(struct drm_device *dev, struct drm_file *file)
 	kfree(v3d_priv);
 }
 
-static const struct file_operations v3d_drm_fops = {
-	.owner = THIS_MODULE,
-	.open = drm_open,
-	.release = drm_release,
-	.unlocked_ioctl = drm_ioctl,
-	.mmap = v3d_mmap,
-	.poll = drm_poll,
-	.read = drm_read,
-	.compat_ioctl = drm_compat_ioctl,
-	.llseek = noop_llseek,
-};
+DEFINE_DRM_GEM_SHMEM_FOPS(v3d_drm_fops);
 
 /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
  * protection between clients.  Note that render nodes would be be
@@ -189,12 +179,6 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_TFU, v3d_submit_tfu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
 };
 
-static const struct vm_operations_struct v3d_vm_ops = {
-	.fault = v3d_gem_fault,
-	.open = drm_gem_vm_open,
-	.close = drm_gem_vm_close,
-};
-
 static struct drm_driver v3d_drm_driver = {
 	.driver_features = (DRIVER_GEM |
 			    DRIVER_RENDER |
@@ -208,16 +192,11 @@ static struct drm_driver v3d_drm_driver = {
 	.debugfs_init = v3d_debugfs_init,
 #endif
 
-	.gem_free_object_unlocked = v3d_free_object,
-	.gem_vm_ops = &v3d_vm_ops,
-
+	.gem_create_object = v3d_create_object,
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_import = drm_gem_prime_import,
-	.gem_prime_export = drm_gem_prime_export,
-	.gem_prime_get_sg_table	= v3d_prime_get_sg_table,
 	.gem_prime_import_sg_table = v3d_prime_import_sg_table,
-	.gem_prime_mmap = v3d_prime_mmap,
+	.gem_prime_mmap = drm_gem_prime_mmap,
 
 	.ioctls = v3d_drm_ioctls,
 	.num_ioctls = ARRAY_SIZE(v3d_drm_ioctls),
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 65906c05dc9c..7b0fe6240f7d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -5,6 +5,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_shmem_helper.h>
 #include <drm/gpu_scheduler.h>
 #include "uapi/drm/v3d_drm.h"
 
@@ -111,16 +112,10 @@ struct v3d_file_priv {
 };
 
 struct v3d_bo {
-	struct drm_gem_object base;
-
-	struct mutex lock;
+	struct drm_gem_shmem_object base;
 
 	struct drm_mm_node node;
 
-	u32 pages_refcount;
-	struct page **pages;
-	struct sg_table *sgt;
-
 	/* List entry for the BO's position in
 	 * v3d_exec_info->unref_list
 	 */
@@ -258,6 +253,7 @@ static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
 }
 
 /* v3d_bo.c */
+struct drm_gem_object *v3d_create_object(struct drm_device *dev, size_t size);
 void v3d_free_object(struct drm_gem_object *gem_obj);
 struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
 			     size_t size);
@@ -267,10 +263,6 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv);
 int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv);
-vm_fault_t v3d_gem_fault(struct vm_fault *vmf);
-int v3d_mmap(struct file *filp, struct vm_area_struct *vma);
-int v3d_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
-struct sg_table *v3d_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *v3d_prime_import_sg_table(struct drm_device *dev,
 						 struct dma_buf_attachment *attach,
 						 struct sg_table *sgt);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 945eaaaad016..b84d89c7b3fb 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -201,7 +201,8 @@ v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
 
 	for (i = 0; i < bo_count; i++) {
 		/* XXX: Use shared fences for read-only objects. */
-		reservation_object_add_excl_fence(bos[i]->base.resv, fence);
+		reservation_object_add_excl_fence(bos[i]->base.base.resv,
+						  fence);
 	}
 }
 
@@ -237,7 +238,8 @@ v3d_lock_bo_reservations(struct v3d_bo **bos,
 	 * before we commit the CL to the hardware.
 	 */
 	for (i = 0; i < bo_count; i++) {
-		ret = reservation_object_reserve_shared(bos[i]->base.resv, 1);
+		ret = reservation_object_reserve_shared(bos[i]->base.base.resv,
+							1);
 		if (ret) {
 			v3d_unlock_bo_reservations(bos, bo_count,
 						   acquire_ctx);
@@ -345,11 +347,11 @@ v3d_exec_cleanup(struct kref *ref)
 	dma_fence_put(exec->render_done_fence);
 
 	for (i = 0; i < exec->bo_count; i++)
-		drm_gem_object_put_unlocked(&exec->bo[i]->base);
+		drm_gem_object_put_unlocked(&exec->bo[i]->base.base);
 	kvfree(exec->bo);
 
 	list_for_each_entry_safe(bo, save, &exec->unref_list, unref_head) {
-		drm_gem_object_put_unlocked(&bo->base);
+		drm_gem_object_put_unlocked(&bo->base.base);
 	}
 
 	pm_runtime_mark_last_busy(v3d->dev);
@@ -376,7 +378,7 @@ v3d_tfu_job_cleanup(struct kref *ref)
 
 	for (i = 0; i < ARRAY_SIZE(job->bo); i++) {
 		if (job->bo[i])
-			drm_gem_object_put_unlocked(&job->bo[i]->base);
+			drm_gem_object_put_unlocked(&job->bo[i]->base.base);
 	}
 
 	pm_runtime_mark_last_busy(v3d->dev);
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index b8aea2dfbe82..b4d6ae81186d 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -37,12 +37,14 @@ v3d_overflow_mem_work(struct work_struct *work)
 		container_of(work, struct v3d_dev, overflow_mem_work);
 	struct drm_device *dev = &v3d->drm;
 	struct v3d_bo *bo = v3d_bo_create(dev, NULL /* XXX: GMP */, 256 * 1024);
+	struct drm_gem_object *obj;
 	unsigned long irqflags;
 
 	if (IS_ERR(bo)) {
 		DRM_ERROR("Couldn't allocate binner overflow mem\n");
 		return;
 	}
+	obj = &bo->base.base;
 
 	/* We lost a race, and our work task came in after the bin job
 	 * completed and exited.  This can happen because the HW
@@ -59,15 +61,15 @@ v3d_overflow_mem_work(struct work_struct *work)
 		goto out;
 	}
 
-	drm_gem_object_get(&bo->base);
+	drm_gem_object_get(obj);
 	list_add_tail(&bo->unref_head, &v3d->bin_job->unref_list);
 	spin_unlock_irqrestore(&v3d->job_lock, irqflags);
 
 	V3D_CORE_WRITE(0, V3D_PTB_BPOA, bo->node.start << PAGE_SHIFT);
-	V3D_CORE_WRITE(0, V3D_PTB_BPOS, bo->base.size);
+	V3D_CORE_WRITE(0, V3D_PTB_BPOS, obj->size);
 
 out:
-	drm_gem_object_put_unlocked(&bo->base);
+	drm_gem_object_put_unlocked(obj);
 }
 
 static irqreturn_t
diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index b00f97c31b70..7a21f1787ab1 100644
--- a/drivers/gpu/drm/v3d/v3d_mmu.c
+++ b/drivers/gpu/drm/v3d/v3d_mmu.c
@@ -83,13 +83,14 @@ int v3d_mmu_set_page_table(struct v3d_dev *v3d)
 
 void v3d_mmu_insert_ptes(struct v3d_bo *bo)
 {
-	struct v3d_dev *v3d = to_v3d_dev(bo->base.dev);
+	struct drm_gem_shmem_object *shmem_obj = &bo->base;
+	struct v3d_dev *v3d = to_v3d_dev(shmem_obj->base.dev);
 	u32 page = bo->node.start;
 	u32 page_prot = V3D_PTE_WRITEABLE | V3D_PTE_VALID;
 	unsigned int count;
 	struct scatterlist *sgl;
 
-	for_each_sg(bo->sgt->sgl, sgl, bo->sgt->nents, count) {
+	for_each_sg(shmem_obj->sgt->sgl, sgl, shmem_obj->sgt->nents, count) {
 		u32 page_address = sg_dma_address(sgl) >> V3D_MMU_PAGE_SHIFT;
 		u32 pte = page_prot | page_address;
 		u32 i;
@@ -102,7 +103,7 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo)
 	}
 
 	WARN_ON_ONCE(page - bo->node.start !=
-		     bo->base.size >> V3D_MMU_PAGE_SHIFT);
+		     shmem_obj->base.size >> V3D_MMU_PAGE_SHIFT);
 
 	if (v3d_mmu_flush_all(v3d))
 		dev_err(v3d->dev, "MMU flush timeout\n");
@@ -110,8 +111,8 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo)
 
 void v3d_mmu_remove_ptes(struct v3d_bo *bo)
 {
-	struct v3d_dev *v3d = to_v3d_dev(bo->base.dev);
-	u32 npages = bo->base.size >> V3D_MMU_PAGE_SHIFT;
+	struct v3d_dev *v3d = to_v3d_dev(bo->base.base.dev);
+	u32 npages = bo->base.base.size >> V3D_MMU_PAGE_SHIFT;
 	u32 page;
 
 	for (page = bo->node.start; page < bo->node.start + npages; page++)
-- 
2.20.1

