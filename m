Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4188DC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4542208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmwopensource.org header.i=@vmwopensource.org header.b="fpUoIh7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407089AbfFLGnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:43:17 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:33382 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405699AbfFLGnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:43:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B6D443F6C5;
        Wed, 12 Jun 2019 08:43:07 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=vmwopensource.org header.i=@vmwopensource.org header.b=fpUoIh7o;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ndFOk7I7m6mB; Wed, 12 Jun 2019 08:42:56 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0CAC73F41E;
        Wed, 12 Jun 2019 08:42:55 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 990D0361FD1;
        Wed, 12 Jun 2019 08:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vmwopensource.org;
        s=mail; t=1560321775;
        bh=Bz3fklz0eZqd41xESnFZ78ynT4XIcVmRNES/IiKQVQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpUoIh7ozpayMOE8ELSZXZfIcF78wPcc2VhLI2TDRLn1Zz2/D6IVM9zHOw11luGmC
         WUAMzwd7/S9l52ZTllajOEpxrs3M6lJ6kEg7uYXFu3Vu/mlOWHdmfzSIxMlB+zjPxc
         YH9mI93X6ZQhjW81EGsf16/r4LNrDXnaFhBy0sZQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thellstrom@vmwopensource.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH v5 6/9] drm/vmwgfx: Implement an infrastructure for write-coherent resources
Date:   Wed, 12 Jun 2019 08:42:40 +0200
Message-Id: <20190612064243.55340-7-thellstrom@vmwopensource.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612064243.55340-1-thellstrom@vmwopensource.org>
References: <20190612064243.55340-1-thellstrom@vmwopensource.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

This infrastructure will, for coherent resources, make sure that
from the user-space point of view, data written by the CPU is immediately
automatically available to the GPU at resource validation time.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
---
 drivers/gpu/drm/vmwgfx/Kconfig                |   1 +
 drivers/gpu/drm/vmwgfx/Makefile               |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c            |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   5 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |  26 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c       |   1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c    | 409 ++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      |  57 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h |  11 +
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c    |  71 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h    |  16 +-
 11 files changed, 584 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c

diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index 6b28a326f8bb..d5fd81a521f6 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -8,6 +8,7 @@ config DRM_VMWGFX
 	select FB_CFB_IMAGEBLIT
 	select DRM_TTM
 	select FB
+	select AS_DIRTY_HELPERS
 	# Only needed for the transitional use of drm_crtc_init - can be removed
 	# again once vmwgfx sets up the primary plane itself.
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/vmwgfx/Makefile b/drivers/gpu/drm/vmwgfx/Makefile
index 8841bd30e1e5..c877a21a0739 100644
--- a/drivers/gpu/drm/vmwgfx/Makefile
+++ b/drivers/gpu/drm/vmwgfx/Makefile
@@ -8,7 +8,7 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_kms.o vmwgfx_drv.o \
 	    vmwgfx_cmdbuf_res.o vmwgfx_cmdbuf.o vmwgfx_stdu.o \
 	    vmwgfx_cotable.o vmwgfx_so.o vmwgfx_binding.o vmwgfx_msg.o \
 	    vmwgfx_simple_resource.o vmwgfx_va.o vmwgfx_blit.o \
-	    vmwgfx_validation.o \
+	    vmwgfx_validation.o vmwgfx_page_dirty.o \
 	    ttm_object.o ttm_lock.o
 
 obj-$(CONFIG_DRM_VMWGFX) := vmwgfx.o
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index c0829d50eecc..90ca866640fe 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -463,6 +463,7 @@ void vmw_bo_bo_free(struct ttm_buffer_object *bo)
 {
 	struct vmw_buffer_object *vmw_bo = vmw_buffer_object(bo);
 
+	WARN_ON(vmw_bo->dirty);
 	vmw_bo_unmap(vmw_bo);
 	kfree(vmw_bo);
 }
@@ -476,8 +477,10 @@ void vmw_bo_bo_free(struct ttm_buffer_object *bo)
 static void vmw_user_bo_destroy(struct ttm_buffer_object *bo)
 {
 	struct vmw_user_buffer_object *vmw_user_bo = vmw_user_buffer_object(bo);
+	struct vmw_buffer_object *vbo = &vmw_user_bo->vbo;
 
-	vmw_bo_unmap(&vmw_user_bo->vbo);
+	WARN_ON(vbo->dirty);
+	vmw_bo_unmap(vbo);
 	ttm_prime_object_kfree(vmw_user_bo, prime);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 4ff11a0077e1..d59c474be38e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -833,6 +833,11 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		DRM_ERROR("Failed initializing TTM buffer object driver.\n");
 		goto out_no_bdev;
 	}
+	dev_priv->vm_ops = *dev_priv->bdev.vm_ops;
+	dev_priv->vm_ops.fault = vmw_bo_vm_fault;
+	dev_priv->vm_ops.pfn_mkwrite = vmw_bo_vm_mkwrite;
+	dev_priv->vm_ops.page_mkwrite = vmw_bo_vm_mkwrite;
+	dev_priv->bdev.vm_ops = &dev_priv->vm_ops;
 
 	/*
 	 * Enable VRAM, but initially don't use it until SVGA is enabled and
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 7c935c72d368..27c259395790 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -94,6 +94,7 @@ struct vmw_fpriv {
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
  * @map: Kmap object for semi-persistent mappings
  * @res_prios: Eviction priority counts for attached resources
+ * @dirty: structure for user-space dirty-tracking
  */
 struct vmw_buffer_object {
 	struct ttm_buffer_object base;
@@ -104,6 +105,7 @@ struct vmw_buffer_object {
 	/* Protected by reservation */
 	struct ttm_bo_kmap_obj map;
 	u32 res_prios[TTM_MAX_BO_PRIORITY];
+	struct vmw_bo_dirty *dirty;
 };
 
 /**
@@ -134,7 +136,8 @@ struct vmw_res_func;
  * @res_dirty: Resource contains data not yet in the backup buffer. Protected
  * by resource reserved.
  * @backup_dirty: Backup buffer contains data not yet in the HW resource.
- * Protecte by resource reserved.
+ * Protected by resource reserved.
+ * @coherent: Emulate coherency by tracking vm accesses.
  * @backup: The backup buffer if any. Protected by resource reserved.
  * @backup_offset: Offset into the backup buffer if any. Protected by resource
  * reserved. Note that only a few resource types can have a @backup_offset
@@ -151,14 +154,16 @@ struct vmw_res_func;
  * @hw_destroy: Callback to destroy the resource on the device, as part of
  * resource destruction.
  */
+struct vmw_resource_dirty;
 struct vmw_resource {
 	struct kref kref;
 	struct vmw_private *dev_priv;
 	int id;
 	u32 used_prio;
 	unsigned long backup_size;
-	bool res_dirty;
-	bool backup_dirty;
+	u32 res_dirty : 1;
+	u32 backup_dirty : 1;
+	u32 coherent : 1;
 	struct vmw_buffer_object *backup;
 	unsigned long backup_offset;
 	unsigned long pin_count;
@@ -166,6 +171,7 @@ struct vmw_resource {
 	struct list_head lru_head;
 	struct list_head mob_head;
 	struct list_head binding_head;
+	struct vmw_resource_dirty *dirty;
 	void (*res_free) (struct vmw_resource *res);
 	void (*hw_destroy) (struct vmw_resource *res);
 };
@@ -606,6 +612,9 @@ struct vmw_private {
 
 	/* Validation memory reservation */
 	struct vmw_validation_mem vvm;
+
+	/* VM operations */
+	struct vm_operations_struct vm_ops;
 };
 
 static inline struct vmw_surface *vmw_res_to_srf(struct vmw_resource *res)
@@ -722,6 +731,8 @@ extern void vmw_resource_evict_all(struct vmw_private *dev_priv);
 extern void vmw_resource_unbind_list(struct vmw_buffer_object *vbo);
 void vmw_resource_mob_attach(struct vmw_resource *res);
 void vmw_resource_mob_detach(struct vmw_resource *res);
+void vmw_resource_dirty_update(struct vmw_resource *res, pgoff_t start,
+			       pgoff_t end);
 
 /**
  * vmw_resource_mob_attached - Whether a resource currently has a mob attached
@@ -1410,6 +1421,15 @@ int vmw_host_log(const char *log);
 #define VMW_DEBUG_USER(fmt, ...)                                              \
 	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
+/* Resource dirtying - vmwgfx_page_dirty.c */
+void vmw_bo_dirty_scan(struct vmw_buffer_object *vbo);
+int vmw_bo_dirty_add(struct vmw_buffer_object *vbo);
+void vmw_bo_dirty_transfer_to_res(struct vmw_resource *res);
+void vmw_bo_dirty_clear_res(struct vmw_resource *res);
+void vmw_bo_dirty_release(struct vmw_buffer_object *vbo);
+vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf);
+vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf);
+
 /**
  * Inline helper functions
  */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 33533d126277..319c1ca35663 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2560,7 +2560,6 @@ static int vmw_cmd_dx_check_subresource(struct vmw_private *dev_priv,
 		     offsetof(typeof(*cmd), sid));
 
 	cmd = container_of(header, typeof(*cmd), header);
-
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->sid, NULL);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
new file mode 100644
index 000000000000..8d154f90bdc0
--- /dev/null
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/**************************************************************************
+ *
+ * Copyright 2019 VMware, Inc., Palo Alto, CA., USA
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ **************************************************************************/
+#include "vmwgfx_drv.h"
+
+/*
+ * Different methods for tracking dirty:
+ * VMW_BO_DIRTY_PAGETABLE - Scan the pagetable for hardware dirty bits
+ * VMW_BO_DIRTY_MKWRITE - Write-protect page table entries and record write-
+ * accesses in the VM mkwrite() callback
+ */
+enum vmw_bo_dirty_method {
+	VMW_BO_DIRTY_PAGETABLE,
+	VMW_BO_DIRTY_MKWRITE,
+};
+
+/*
+ * No dirtied pages at scan trigger a transition to the _MKWRITE method,
+ * similarly a certain percentage of dirty pages trigger a transition to
+ * the _PAGETABLE method. How many triggers should we wait for before
+ * changing method?
+ */
+#define VMW_DIRTY_NUM_CHANGE_TRIGGERS 2
+
+/* Percentage to trigger a transition to the _PAGETABLE method */
+#define VMW_DIRTY_PERCENTAGE 10
+
+/**
+ * struct vmw_bo_dirty - Dirty information for buffer objects
+ * @start: First currently dirty bit
+ * @end: Last currently dirty bit + 1
+ * @method: The currently used dirty method
+ * @change_count: Number of consecutive method change triggers
+ * @ref_count: Reference count for this structure
+ * @bitmap_size: The size of the bitmap in bits. Typically equal to the
+ * nuber of pages in the bo.
+ * @size: The accounting size for this struct.
+ * @bitmap: A bitmap where each bit represents a page. A set bit means a
+ * dirty page.
+ */
+struct vmw_bo_dirty {
+	unsigned long start;
+	unsigned long end;
+	enum vmw_bo_dirty_method method;
+	unsigned int change_count;
+	unsigned int ref_count;
+	unsigned long bitmap_size;
+	size_t size;
+	unsigned long bitmap[0];
+};
+
+/**
+ * vmw_bo_dirty_scan_pagetable - Perform a pagetable scan for dirty bits
+ * @vbo: The buffer object to scan
+ *
+ * Scans the pagetable for dirty bits. Clear those bits and modify the
+ * dirty structure with the results. This function may change the
+ * dirty-tracking method.
+ */
+static void vmw_bo_dirty_scan_pagetable(struct vmw_buffer_object *vbo)
+{
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+	pgoff_t offset = drm_vma_node_start(&vbo->base.vma_node);
+	struct address_space *mapping = vbo->base.bdev->dev_mapping;
+	pgoff_t num_marked;
+
+	num_marked = apply_as_clean(mapping,
+				    offset, dirty->bitmap_size,
+				    offset, &dirty->bitmap[0],
+				    &dirty->start, &dirty->end);
+	if (num_marked == 0)
+		dirty->change_count++;
+	else
+		dirty->change_count = 0;
+
+	if (dirty->change_count > VMW_DIRTY_NUM_CHANGE_TRIGGERS) {
+		dirty->change_count = 0;
+		dirty->method = VMW_BO_DIRTY_MKWRITE;
+		apply_as_wrprotect(mapping,
+				   offset, dirty->bitmap_size);
+		apply_as_clean(mapping,
+			       offset, dirty->bitmap_size,
+			       offset, &dirty->bitmap[0],
+			       &dirty->start, &dirty->end);
+	}
+}
+
+/**
+ * vmw_bo_dirty_scan_mkwrite - Reset the mkwrite dirty-tracking method
+ * @vbo: The buffer object to scan
+ *
+ * Write-protect pages written to so that consecutive write accesses will
+ * trigger a call to mkwrite.
+ *
+ * This function may change the dirty-tracking method.
+ */
+static void vmw_bo_dirty_scan_mkwrite(struct vmw_buffer_object *vbo)
+{
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+	unsigned long offset = drm_vma_node_start(&vbo->base.vma_node);
+	struct address_space *mapping = vbo->base.bdev->dev_mapping;
+	pgoff_t num_marked;
+
+	if (dirty->end <= dirty->start)
+		return;
+
+	num_marked = apply_as_wrprotect(vbo->base.bdev->dev_mapping,
+					dirty->start + offset,
+					dirty->end - dirty->start);
+
+	if (100UL * num_marked / dirty->bitmap_size >
+	    VMW_DIRTY_PERCENTAGE) {
+		dirty->change_count++;
+	} else {
+		dirty->change_count = 0;
+	}
+
+	if (dirty->change_count > VMW_DIRTY_NUM_CHANGE_TRIGGERS) {
+		pgoff_t start = 0;
+		pgoff_t end = dirty->bitmap_size;
+
+		dirty->method = VMW_BO_DIRTY_PAGETABLE;
+		apply_as_clean(mapping, offset, end, offset, &dirty->bitmap[0],
+			       &start, &end);
+		bitmap_clear(&dirty->bitmap[0], 0, dirty->bitmap_size);
+		if (dirty->start < dirty->end)
+			bitmap_set(&dirty->bitmap[0], dirty->start,
+				   dirty->end - dirty->start);
+		dirty->change_count = 0;
+	}
+}
+
+
+/**
+ * vmw_bo_dirty_scan - Scan for dirty pages and add them to the dirty
+ * tracking structure
+ * @vbo: The buffer object to scan
+ *
+ * This function may change the dirty tracking method.
+ */
+void vmw_bo_dirty_scan(struct vmw_buffer_object *vbo)
+{
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+
+	if (dirty->method == VMW_BO_DIRTY_PAGETABLE)
+		vmw_bo_dirty_scan_pagetable(vbo);
+	else
+		vmw_bo_dirty_scan_mkwrite(vbo);
+}
+
+/**
+ * vmw_bo_dirty_add - Add a dirty-tracking user to a buffer object
+ * @vbo: The buffer object
+ *
+ * This function registers a dirty-tracking user to a buffer object.
+ * A user can be for example a resource or a vma in a special user-space
+ * mapping.
+ *
+ * Return: Zero on success, -ENOMEM on memory allocation failure.
+ */
+int vmw_bo_dirty_add(struct vmw_buffer_object *vbo)
+{
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+	pgoff_t num_pages = vbo->base.num_pages;
+	size_t size, acc_size;
+	int ret;
+	static struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false
+	};
+
+	if (dirty) {
+		dirty->ref_count++;
+		return 0;
+	}
+
+	size = sizeof(*dirty) + BITS_TO_LONGS(num_pages) * sizeof(long);
+	acc_size = ttm_round_pot(size);
+	ret = ttm_mem_global_alloc(&ttm_mem_glob, acc_size, &ctx);
+	if (ret) {
+		VMW_DEBUG_USER("Out of graphics memory for buffer object "
+			       "dirty tracker.\n");
+		return ret;
+	}
+	dirty = kvzalloc(size, GFP_KERNEL);
+	if (!dirty) {
+		ret = -ENOMEM;
+		goto out_no_dirty;
+	}
+
+	dirty->size = acc_size;
+	dirty->bitmap_size = num_pages;
+	dirty->start = dirty->bitmap_size;
+	dirty->end = 0;
+	dirty->ref_count = 1;
+	if (num_pages < PAGE_SIZE / sizeof(pte_t)) {
+		dirty->method = VMW_BO_DIRTY_PAGETABLE;
+	} else {
+		struct address_space *mapping = vbo->base.bdev->dev_mapping;
+		pgoff_t offset = drm_vma_node_start(&vbo->base.vma_node);
+
+		dirty->method = VMW_BO_DIRTY_MKWRITE;
+
+		/* Write-protect and then pick up already dirty bits */
+		apply_as_wrprotect(mapping, offset, num_pages);
+		apply_as_clean(mapping, offset, num_pages, offset,
+			       &dirty->bitmap[0], &dirty->start, &dirty->end);
+	}
+
+	vbo->dirty = dirty;
+
+	return 0;
+
+out_no_dirty:
+	ttm_mem_global_free(&ttm_mem_glob, acc_size);
+	return ret;
+}
+
+/**
+ * vmw_bo_dirty_release - Release a dirty-tracking user from a buffer object
+ * @vbo: The buffer object
+ *
+ * This function releases a dirty-tracking user from a buffer object.
+ * If the reference count reaches zero, then the dirty-tracking object is
+ * freed and the pointer to it cleared.
+ *
+ * Return: Zero on success, -ENOMEM on memory allocation failure.
+ */
+void vmw_bo_dirty_release(struct vmw_buffer_object *vbo)
+{
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+
+	if (dirty && --dirty->ref_count == 0) {
+		size_t acc_size = dirty->size;
+
+		kvfree(dirty);
+		ttm_mem_global_free(&ttm_mem_glob, acc_size);
+		vbo->dirty = NULL;
+	}
+}
+
+/**
+ * vmw_bo_dirty_transfer_to_res - Pick up a resource's dirty region from
+ * its backing mob.
+ * @res: The resource
+ *
+ * This function will pick up all dirty ranges affecting the resource from
+ * it's backup mob, and call vmw_resource_dirty_update() once for each
+ * range. The transferred ranges will be cleared from the backing mob's
+ * dirty tracking.
+ */
+void vmw_bo_dirty_transfer_to_res(struct vmw_resource *res)
+{
+	struct vmw_buffer_object *vbo = res->backup;
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+	pgoff_t start, cur, end;
+	unsigned long res_start = res->backup_offset;
+	unsigned long res_end = res->backup_offset + res->backup_size;
+
+	WARN_ON_ONCE(res_start & ~PAGE_MASK);
+	res_start >>= PAGE_SHIFT;
+	res_end = DIV_ROUND_UP(res_end, PAGE_SIZE);
+
+	if (res_start >= dirty->end || res_end <= dirty->start)
+		return;
+
+	cur = max(res_start, dirty->start);
+	res_end = max(res_end, dirty->end);
+	while (cur < res_end) {
+		unsigned long num;
+
+		start = find_next_bit(&dirty->bitmap[0], res_end, cur);
+		if (start >= res_end)
+			break;
+
+		end = find_next_zero_bit(&dirty->bitmap[0], res_end, start + 1);
+		cur = end + 1;
+		num = end - start;
+		bitmap_clear(&dirty->bitmap[0], start, num);
+		vmw_resource_dirty_update(res, start, end);
+	}
+
+	if (res_start <= dirty->start && res_end > dirty->start)
+		dirty->start = res_end;
+	if (res_start < dirty->end && res_end >= dirty->end)
+		dirty->end = res_start;
+}
+
+/**
+ * vmw_bo_dirty_clear_res - Clear a resource's dirty region from
+ * its backing mob.
+ * @res: The resource
+ *
+ * This function will clear all dirty ranges affecting the resource from
+ * it's backup mob's dirty tracking.
+ */
+void vmw_bo_dirty_clear_res(struct vmw_resource *res)
+{
+	unsigned long res_start = res->backup_offset;
+	unsigned long res_end = res->backup_offset + res->backup_size;
+	struct vmw_buffer_object *vbo = res->backup;
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+
+	res_start >>= PAGE_SHIFT;
+	res_end = DIV_ROUND_UP(res_end, PAGE_SIZE);
+
+	if (res_start >= dirty->end || res_end <= dirty->start)
+		return;
+
+	res_start = max(res_start, dirty->start);
+	res_end = min(res_end, dirty->end);
+	bitmap_clear(&dirty->bitmap[0], res_start, res_end - res_start);
+
+	if (res_start <= dirty->start && res_end > dirty->start)
+		dirty->start = res_end;
+	if (res_start < dirty->end && res_end >= dirty->end)
+		dirty->end = res_start;
+}
+
+vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
+	    vma->vm_private_data;
+	vm_fault_t ret;
+	unsigned long page_offset;
+	struct vmw_buffer_object *vbo =
+		container_of(bo, typeof(*vbo), base);
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	page_offset = vmf->pgoff - drm_vma_node_start(&bo->vma_node);
+	if (unlikely(page_offset >= bo->num_pages)) {
+		ret = VM_FAULT_SIGBUS;
+		goto out_unlock;
+	}
+
+	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
+	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
+		struct vmw_bo_dirty *dirty = vbo->dirty;
+
+		__set_bit(page_offset, &dirty->bitmap[0]);
+		dirty->start = min(dirty->start, page_offset);
+		dirty->end = max(dirty->end, page_offset + 1);
+	}
+
+out_unlock:
+	reservation_object_unlock(bo->resv);
+	return ret;
+}
+
+vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
+	    vma->vm_private_data;
+	struct vmw_buffer_object *vbo =
+		container_of(bo, struct vmw_buffer_object, base);
+	pgoff_t num_prefault;
+	pgprot_t prot;
+	vm_fault_t ret;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	/*
+	 * This will cause mkwrite() to be called for each pte on
+	 * write-enable vmas.
+	 */
+	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE)
+		prot = vma->vm_page_prot;
+	else
+		prot = vm_get_page_prot(vma->vm_flags);
+
+	num_prefault = (vma->vm_flags & VM_RAND_READ) ? 0 :
+		TTM_BO_VM_NUM_PREFAULT;
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
+	reservation_object_unlock(bo->resv);
+	return ret;
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index be7d4149a129..da9afa83fb4f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -121,6 +121,10 @@ static void vmw_resource_release(struct kref *kref)
 		}
 		res->backup_dirty = false;
 		vmw_resource_mob_detach(res);
+		if (res->dirty)
+			res->func->dirty_free(res);
+		if (res->coherent)
+			vmw_bo_dirty_release(res->backup);
 		ttm_bo_unreserve(bo);
 		vmw_bo_unreference(&res->backup);
 	}
@@ -210,7 +214,9 @@ int vmw_resource_init(struct vmw_private *dev_priv, struct vmw_resource *res,
 	res->backup_offset = 0;
 	res->backup_dirty = false;
 	res->res_dirty = false;
+	res->coherent = false;
 	res->used_prio = 3;
+	res->dirty = NULL;
 	if (delay_id)
 		return 0;
 	else
@@ -397,6 +403,30 @@ static int vmw_resource_do_validate(struct vmw_resource *res,
 			vmw_resource_mob_attach(res);
 	}
 
+	/*
+	 * Handle the case where the backup mob is marked coherent but
+	 * the resource isn't.
+	 */
+	if (func->dirty_alloc && vmw_resource_mob_attached(res) &&
+	    !res->coherent) {
+		if (res->backup->dirty && !res->dirty) {
+			ret = func->dirty_alloc(res);
+			if (ret)
+				return ret;
+		} else if (!res->backup->dirty && res->dirty) {
+			func->dirty_free(res);
+		}
+	}
+
+	/*
+	 * Transfer the dirty regions to the resource and update
+	 * the resource.
+	 */
+	if (res->dirty) {
+		vmw_bo_dirty_transfer_to_res(res);
+		return func->dirty_sync(res);
+	}
+
 	return 0;
 
 out_bind_failed:
@@ -435,16 +465,28 @@ void vmw_resource_unreserve(struct vmw_resource *res,
 	if (switch_backup && new_backup != res->backup) {
 		if (res->backup) {
 			vmw_resource_mob_detach(res);
+			if (res->coherent)
+				vmw_bo_dirty_release(res->backup);
 			vmw_bo_unreference(&res->backup);
 		}
 
 		if (new_backup) {
 			res->backup = vmw_bo_reference(new_backup);
+
+			/*
+			 * The validation code should already have added a
+			 * dirty tracker here.
+			 */
+			WARN_ON(res->coherent && !new_backup->dirty);
+
 			vmw_resource_mob_attach(res);
 		} else {
 			res->backup = NULL;
 		}
+	} else if (switch_backup && res->coherent) {
+		vmw_bo_dirty_release(res->backup);
 	}
+
 	if (switch_backup)
 		res->backup_offset = new_backup_offset;
 
@@ -1010,3 +1052,18 @@ enum vmw_res_type vmw_res_type(const struct vmw_resource *res)
 {
 	return res->func->res_type;
 }
+
+/**
+ * vmw_resource_update_dirty - Update a resource's dirty tracker with a
+ * sequential range of touched backing store memory.
+ * @res: The resource.
+ * @start: The first page touched.
+ * @end: The last page touched + 1.
+ */
+void vmw_resource_dirty_update(struct vmw_resource *res, pgoff_t start,
+			       pgoff_t end)
+{
+	if (res->dirty)
+		res->func->dirty_range_add(res, start << PAGE_SHIFT,
+					   end << PAGE_SHIFT);
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
index 984e588c62ca..c85144286cfe 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
@@ -71,6 +71,12 @@ struct vmw_user_resource_conv {
  * @commit_notify:     If the resource is a command buffer managed resource,
  *                     callback to notify that a define or remove command
  *                     has been committed to the device.
+ * @dirty_alloc:       Allocate a dirty tracker. NULL if dirty-tracking is not
+ *                     supported.
+ * @dirty_free:        Free the dirty tracker.
+ * @dirty_sync:        Upload the dirty mob contents to the resource.
+ * @dirty_add_range:   Add a sequential dirty range to the resource
+ *                     dirty tracker.
  */
 struct vmw_res_func {
 	enum vmw_res_type res_type;
@@ -90,6 +96,11 @@ struct vmw_res_func {
 		       struct ttm_validate_buffer *val_buf);
 	void (*commit_notify)(struct vmw_resource *res,
 			      enum vmw_cmdbuf_res_state state);
+	int (*dirty_alloc)(struct vmw_resource *res);
+	void (*dirty_free)(struct vmw_resource *res);
+	int (*dirty_sync)(struct vmw_resource *res);
+	void (*dirty_range_add)(struct vmw_resource *res, size_t start,
+				 size_t end);
 };
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index f611b2290a1b..71349a7bae90 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -33,6 +33,8 @@
  * struct vmw_validation_bo_node - Buffer object validation metadata.
  * @base: Metadata used for TTM reservation- and validation.
  * @hash: A hash entry used for the duplicate detection hash table.
+ * @coherent_count: If switching backup buffers, number of new coherent
+ * resources that will have this buffer as a backup buffer.
  * @as_mob: Validate as mob.
  * @cpu_blit: Validate for cpu blit access.
  *
@@ -42,6 +44,7 @@
 struct vmw_validation_bo_node {
 	struct ttm_validate_buffer base;
 	struct drm_hash_item hash;
+	unsigned int coherent_count;
 	u32 as_mob : 1;
 	u32 cpu_blit : 1;
 };
@@ -459,6 +462,19 @@ int vmw_validation_res_reserve(struct vmw_validation_context *ctx,
 			if (ret)
 				goto out_unreserve;
 		}
+
+		if (val->switching_backup && val->new_backup &&
+		    res->coherent) {
+			struct vmw_validation_bo_node *bo_node =
+				vmw_validation_find_bo_dup(ctx,
+							   val->new_backup);
+
+			if (WARN_ON(!bo_node)) {
+				ret = -EINVAL;
+				goto out_unreserve;
+			}
+			bo_node->coherent_count++;
+		}
 	}
 
 	return 0;
@@ -562,6 +578,9 @@ int vmw_validation_bo_validate(struct vmw_validation_context *ctx, bool intr)
 	int ret;
 
 	list_for_each_entry(entry, &ctx->bo_list, base.head) {
+		struct vmw_buffer_object *vbo =
+			container_of(entry->base.bo, typeof(*vbo), base);
+
 		if (entry->cpu_blit) {
 			struct ttm_operation_ctx ctx = {
 				.interruptible = intr,
@@ -576,6 +595,27 @@ int vmw_validation_bo_validate(struct vmw_validation_context *ctx, bool intr)
 		}
 		if (ret)
 			return ret;
+
+		/*
+		 * Rather than having the resource code allocating the bo
+		 * dirty tracker in resource_unreserve() where we can't fail,
+		 * Do it here when validating the buffer object.
+		 */
+		if (entry->coherent_count) {
+			unsigned int coherent_count = entry->coherent_count;
+
+			while (coherent_count) {
+				ret = vmw_bo_dirty_add(vbo);
+				if (ret)
+					return ret;
+
+				coherent_count--;
+			}
+			entry->coherent_count -= coherent_count;
+		}
+
+		if (vbo->dirty)
+			vmw_bo_dirty_scan(vbo);
 	}
 	return 0;
 }
@@ -828,3 +868,34 @@ int vmw_validation_preload_res(struct vmw_validation_context *ctx,
 	ctx->mem_size_left += size;
 	return 0;
 }
+
+/**
+ * vmw_validation_bo_backoff - Unreserve buffer objects registered with a
+ * validation context
+ * @ctx: The validation context
+ *
+ * This function unreserves the buffer objects previously reserved using
+ * vmw_validation_bo_reserve. It's typically used as part of an error path
+ */
+void vmw_validation_bo_backoff(struct vmw_validation_context *ctx)
+{
+	struct vmw_validation_bo_node *entry;
+
+	/*
+	 * Switching coherent resource backup buffers failed.
+	 * Release corresponding buffer object dirty trackers.
+	 */
+	list_for_each_entry(entry, &ctx->bo_list, base.head) {
+		if (entry->coherent_count) {
+			unsigned int coherent_count = entry->coherent_count;
+			struct vmw_buffer_object *vbo =
+				container_of(entry->base.bo, typeof(*vbo),
+					     base);
+
+			while (coherent_count--)
+				vmw_bo_dirty_release(vbo);
+		}
+	}
+
+	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->bo_list);
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 1d2322ad6fd5..fd83e017c2a5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -172,20 +172,6 @@ vmw_validation_bo_reserve(struct vmw_validation_context *ctx,
 				      NULL, true);
 }
 
-/**
- * vmw_validation_bo_backoff - Unreserve buffer objects registered with a
- * validation context
- * @ctx: The validation context
- *
- * This function unreserves the buffer objects previously reserved using
- * vmw_validation_bo_reserve. It's typically used as part of an error path
- */
-static inline void
-vmw_validation_bo_backoff(struct vmw_validation_context *ctx)
-{
-	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->bo_list);
-}
-
 /**
  * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
  * with a validation context
@@ -268,4 +254,6 @@ int vmw_validation_preload_res(struct vmw_validation_context *ctx,
 			       unsigned int size);
 void vmw_validation_res_set_dirty(struct vmw_validation_context *ctx,
 				  void *val_private, u32 dirty);
+void vmw_validation_bo_backoff(struct vmw_validation_context *ctx);
+
 #endif
-- 
2.20.1

