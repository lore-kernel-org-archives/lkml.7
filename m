Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E86C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D792189D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfIQJYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfIQJYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7ABDA89AC6;
        Tue, 17 Sep 2019 09:24:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC216013A;
        Tue, 17 Sep 2019 09:24:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3F63017538; Tue, 17 Sep 2019 11:24:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER)
Subject: [PATCH v2 02/11] drm/shmem: switch shmem helper to &drm_gem_object_funcs.mmap
Date:   Tue, 17 Sep 2019 11:23:55 +0200
Message-Id: <20190917092404.9982-3-kraxel@redhat.com>
In-Reply-To: <20190917092404.9982-1-kraxel@redhat.com>
References: <20190917092404.9982-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 17 Sep 2019 09:24:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch gem shmem helper to the new mmap() workflow,
from &gem_driver.fops.mmap to &drm_gem_object_funcs.mmap.

v2: Fix vm_flags and vm_page_prot handling.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_shmem_helper.h      |  6 ++----
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 28 +++++++++----------------
 drivers/gpu/drm/panfrost/panfrost_gem.c |  2 +-
 drivers/gpu/drm/v3d/v3d_bo.c            |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
 5 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 01f514521687..d89f2116c8ab 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -111,7 +111,7 @@ struct drm_gem_shmem_object {
 		.poll		= drm_poll,\
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_shmem_mmap, \
+		.mmap		= drm_gem_mmap, \
 	}
 
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
@@ -143,9 +143,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
 
-int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma);
-
-extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
+int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
 void drm_gem_shmem_print_info(struct drm_printer *p, unsigned int indent,
 			      const struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f5918707672f..a9a586630517 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -32,7 +32,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /**
@@ -505,39 +505,30 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 	drm_gem_vm_close(vma);
 }
 
-const struct vm_operations_struct drm_gem_shmem_vm_ops = {
+static const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
 };
-EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
 
 /**
  * drm_gem_shmem_mmap - Memory-map a shmem GEM object
- * @filp: File object
+ * @obj: gem object
  * @vma: VMA for the area to be mapped
  *
  * This function implements an augmented version of the GEM DRM file mmap
  * operation for shmem objects. Drivers which employ the shmem helpers should
- * use this function as their &file_operations.mmap handler in the DRM device file's
- * file_operations structure.
- *
- * Instead of directly referencing this function, drivers should use the
- * DEFINE_DRM_GEM_SHMEM_FOPS() macro.
+ * use this function as their &drm_gem_object_funcs.mmap handler.
  *
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
+int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct drm_gem_shmem_object *shmem;
 	int ret;
 
-	ret = drm_gem_mmap(filp, vma);
-	if (ret)
-		return ret;
-
-	shmem = to_drm_gem_shmem_obj(vma->vm_private_data);
+	shmem = to_drm_gem_shmem_obj(obj);
 
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret) {
@@ -545,9 +536,10 @@ int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
 		return ret;
 	}
 
-	/* VM_PFNMAP was set by drm_gem_mmap() */
-	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_flags |= VM_IO | VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+	vma->vm_ops = &drm_gem_shmem_vm_ops;
 
 	/* Remove the fake offset */
 	vma->vm_pgoff -= drm_vma_node_start(&shmem->base.vma_node);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index acb07fe06580..deca0c30bbd4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -112,7 +112,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /**
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a22b75a3a533..edd299ab53d8 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -58,7 +58,7 @@ static const struct drm_gem_object_funcs v3d_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /* gem_create_object function for allocating a BO struct and doing
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 69a3d310ff70..017a9e0fc3bb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -86,7 +86,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = &drm_gem_shmem_mmap,
 };
 
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
-- 
2.18.1

