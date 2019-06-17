Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ADC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60A220861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="pJrBmMil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfFQUZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:25:09 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:40184 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfFQUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:25:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 2AD6E3F901;
        Mon, 17 Jun 2019 22:18:18 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=pJrBmMil;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VrhaE5zoV_OX; Mon, 17 Jun 2019 22:18:06 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id DC9CA3F536;
        Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A208D361AF0;
        Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1560802685; bh=aoCEU51Mmy35TCfq2QFa8Fwf99tU96Ns5lgdueVokuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJrBmMilHGI4FW/n8GGvOhseFkubg/FY+C9VIbaMpgJ+z8eauMvblgRNqUq8Y8ksi
         wlbDYdisJ7SRATv2O2ynyFWXxNYdZErTfK6tjtf9itLYMJo1q7Zpa7JuNOTqySQlOh
         tbaPfvZ3lXX9zBF4Qqdx9/V+P2pWPvju8Qvyz81s=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/9] drm/vmwgfx: Implement an infrastructure for read-coherent resources
Date:   Mon, 17 Jun 2019 22:17:55 +0200
Message-Id: <20190617201756.12587-9-thomas@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617201756.12587-1-thomas@shipmail.org>
References: <20190617201756.12587-1-thomas@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Similar to write-coherent resources, make sure that from the user-space
point of view, GPU rendered contents is automatically available for
reading by the CPU.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c    |  73 ++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      | 103 +++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c    |   3 +-
 5 files changed, 177 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 9b347923196f..dae3a39bf402 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -689,7 +689,8 @@ extern void vmw_resource_unreference(struct vmw_resource **p_res);
 extern struct vmw_resource *vmw_resource_reference(struct vmw_resource *res);
 extern struct vmw_resource *
 vmw_resource_reference_unless_doomed(struct vmw_resource *res);
-extern int vmw_resource_validate(struct vmw_resource *res, bool intr);
+extern int vmw_resource_validate(struct vmw_resource *res, bool intr,
+				 bool dirtying);
 extern int vmw_resource_reserve(struct vmw_resource *res, bool interruptible,
 				bool no_backup);
 extern bool vmw_resource_needs_backup(const struct vmw_resource *res);
@@ -733,6 +734,8 @@ void vmw_resource_mob_attach(struct vmw_resource *res);
 void vmw_resource_mob_detach(struct vmw_resource *res);
 void vmw_resource_dirty_update(struct vmw_resource *res, pgoff_t start,
 			       pgoff_t end);
+int vmw_resources_clean(struct vmw_buffer_object *vbo, pgoff_t start,
+			pgoff_t end, pgoff_t *num_prefault);
 
 /**
  * vmw_resource_mob_attached - Whether a resource currently has a mob attached
@@ -1427,6 +1430,8 @@ int vmw_bo_dirty_add(struct vmw_buffer_object *vbo);
 void vmw_bo_dirty_transfer_to_res(struct vmw_resource *res);
 void vmw_bo_dirty_clear_res(struct vmw_resource *res);
 void vmw_bo_dirty_release(struct vmw_buffer_object *vbo);
+void vmw_bo_dirty_unmap(struct vmw_buffer_object *vbo,
+			pgoff_t start, pgoff_t end);
 vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf);
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 8d154f90bdc0..730c51e397dd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -153,7 +153,6 @@ static void vmw_bo_dirty_scan_mkwrite(struct vmw_buffer_object *vbo)
 	}
 }
 
-
 /**
  * vmw_bo_dirty_scan - Scan for dirty pages and add them to the dirty
  * tracking structure
@@ -171,6 +170,51 @@ void vmw_bo_dirty_scan(struct vmw_buffer_object *vbo)
 		vmw_bo_dirty_scan_mkwrite(vbo);
 }
 
+/**
+ * vmw_bo_dirty_pre_unmap - write-protect and pick up dirty pages before
+ * an unmap_mapping_range operation.
+ * @vbo: The buffer object,
+ * @start: First page of the range within the buffer object.
+ * @end: Last page of the range within the buffer object + 1.
+ *
+ * If we're using the _PAGETABLE scan method, we may leak dirty pages
+ * when calling unmap_mapping_range(). This function makes sure we pick
+ * up all dirty pages.
+ */
+static void vmw_bo_dirty_pre_unmap(struct vmw_buffer_object *vbo,
+				   pgoff_t start, pgoff_t end)
+{
+	struct vmw_bo_dirty *dirty = vbo->dirty;
+	unsigned long offset = drm_vma_node_start(&vbo->base.vma_node);
+	struct address_space *mapping = vbo->base.bdev->dev_mapping;
+
+	if (dirty->method != VMW_BO_DIRTY_PAGETABLE || start >= end)
+		return;
+
+	apply_as_wrprotect(mapping, start + offset, end - start);
+	apply_as_clean(mapping, start + offset, end - start, offset,
+		       &dirty->bitmap[0], &dirty->start, &dirty->end);
+}
+
+/**
+ * vmw_bo_dirty_unmap - Clear all ptes pointing to a range within a bo
+ * @vbo: The buffer object,
+ * @start: First page of the range within the buffer object.
+ * @end: Last page of the range within the buffer object + 1.
+ *
+ * This is similar to ttm_bo_unmap_virtual_locked() except it takes a subrange.
+ */
+void vmw_bo_dirty_unmap(struct vmw_buffer_object *vbo,
+			pgoff_t start, pgoff_t end)
+{
+	unsigned long offset = drm_vma_node_start(&vbo->base.vma_node);
+	struct address_space *mapping = vbo->base.bdev->dev_mapping;
+
+	vmw_bo_dirty_pre_unmap(vbo, start, end);
+	unmap_shared_mapping_range(mapping, (offset + start) << PAGE_SHIFT,
+				   (loff_t) (end - start) << PAGE_SHIFT);
+}
+
 /**
  * vmw_bo_dirty_add - Add a dirty-tracking user to a buffer object
  * @vbo: The buffer object
@@ -389,21 +433,40 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
+	num_prefault = (vma->vm_flags & VM_RAND_READ) ? 1 :
+		TTM_BO_VM_NUM_PREFAULT;
+
+	if (vbo->dirty) {
+		pgoff_t allowed_prefault;
+		unsigned long page_offset;
+
+		page_offset = vmf->pgoff - drm_vma_node_start(&bo->vma_node);
+		if (page_offset >= bo->num_pages ||
+		    vmw_resources_clean(vbo, page_offset,
+					page_offset + PAGE_SIZE,
+					&allowed_prefault)) {
+			ret = VM_FAULT_SIGBUS;
+			goto out_unlock;
+		}
+
+		num_prefault = min(num_prefault, allowed_prefault);
+	}
+
 	/*
-	 * This will cause mkwrite() to be called for each pte on
-	 * write-enable vmas.
+	 * If we don't track dirty using the MKWRITE method, make sure
+	 * sure the page protection is write-enabled so we don't get
+	 * a lot of unnecessary write faults.
 	 */
 	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE)
 		prot = vma->vm_page_prot;
 	else
 		prot = vm_get_page_prot(vma->vm_flags);
 
-	num_prefault = (vma->vm_flags & VM_RAND_READ) ? 0 :
-		TTM_BO_VM_NUM_PREFAULT;
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
+out_unlock:
 	reservation_object_unlock(bo->resv);
 	return ret;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index b84dd5953886..d70ee0df5c13 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -395,7 +395,8 @@ static int vmw_resource_buf_alloc(struct vmw_resource *res,
  * should be retried once resources have been freed up.
  */
 static int vmw_resource_do_validate(struct vmw_resource *res,
-				    struct ttm_validate_buffer *val_buf)
+				    struct ttm_validate_buffer *val_buf,
+				    bool dirtying)
 {
 	int ret = 0;
 	const struct vmw_res_func *func = res->func;
@@ -437,6 +438,15 @@ static int vmw_resource_do_validate(struct vmw_resource *res,
 	 * the resource.
 	 */
 	if (res->dirty) {
+		if (dirtying && !res->res_dirty) {
+			pgoff_t start = res->backup_offset >> PAGE_SHIFT;
+			pgoff_t end = __KERNEL_DIV_ROUND_UP
+				(res->backup_offset + res->backup_size,
+				 PAGE_SIZE);
+
+			vmw_bo_dirty_unmap(res->backup, start, end);
+		}
+
 		vmw_bo_dirty_transfer_to_res(res);
 		return func->dirty_sync(res);
 	}
@@ -681,6 +691,7 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
  *                         to the device.
  * @res: The resource to make visible to the device.
  * @intr: Perform waits interruptible if possible.
+ * @dirtying: Pending GPU operation will dirty the resource
  *
  * On succesful return, any backup DMA buffer pointed to by @res->backup will
  * be reserved and validated.
@@ -690,7 +701,8 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
  * Return: Zero on success, -ERESTARTSYS if interrupted, negative error code
  * on failure.
  */
-int vmw_resource_validate(struct vmw_resource *res, bool intr)
+int vmw_resource_validate(struct vmw_resource *res, bool intr,
+			  bool dirtying)
 {
 	int ret;
 	struct vmw_resource *evict_res;
@@ -707,7 +719,7 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr)
 	if (res->backup)
 		val_buf.bo = &res->backup->base;
 	do {
-		ret = vmw_resource_do_validate(res, &val_buf);
+		ret = vmw_resource_do_validate(res, &val_buf, dirtying);
 		if (likely(ret != -EBUSY))
 			break;
 
@@ -1007,7 +1019,7 @@ int vmw_resource_pin(struct vmw_resource *res, bool interruptible)
 			/* Do we really need to pin the MOB as well? */
 			vmw_bo_pin_reserved(vbo, true);
 		}
-		ret = vmw_resource_validate(res, interruptible);
+		ret = vmw_resource_validate(res, interruptible, true);
 		if (vbo)
 			ttm_bo_unreserve(&vbo->base);
 		if (ret)
@@ -1082,3 +1094,86 @@ void vmw_resource_dirty_update(struct vmw_resource *res, pgoff_t start,
 		res->func->dirty_range_add(res, start << PAGE_SHIFT,
 					   end << PAGE_SHIFT);
 }
+
+/**
+ * vmw_resources_clean - Clean resources intersecting a mob range
+ * @vbo: The mob buffer object
+ * @start: The mob page offset starting the range
+ * @end: The mob page offset ending the range
+ * @num_prefault: Returns how many pages including the first have been
+ * cleaned and are ok to prefault
+ */
+int vmw_resources_clean(struct vmw_buffer_object *vbo, pgoff_t start,
+			pgoff_t end, pgoff_t *num_prefault)
+{
+	struct rb_node *cur = vbo->res_tree.rb_node;
+	struct vmw_resource *found = NULL;
+	unsigned long res_start = start << PAGE_SHIFT;
+	unsigned long res_end = end << PAGE_SHIFT;
+	unsigned long last_cleaned = 0;
+
+	/*
+	 * Find the resource with lowest backup_offset that intersects the
+	 * range.
+	 */
+	while (cur) {
+		struct vmw_resource *cur_res =
+			container_of(cur, struct vmw_resource, mob_node);
+
+		if (cur_res->backup_offset >= res_end) {
+			cur = cur->rb_left;
+		} else if (cur_res->backup_offset + cur_res->backup_size <=
+			   res_start) {
+			cur = cur->rb_right;
+		} else {
+			found = cur_res;
+			cur = cur->rb_left;
+			/* Continue to look for resources with lower offsets */
+		}
+	}
+
+	/*
+	 * In order of increasing backup_offset, clean dirty resorces
+	 * intersecting the range.
+	 */
+	while (found) {
+		if (found->res_dirty) {
+			int ret;
+
+			if (!found->func->clean)
+				return -EINVAL;
+
+			ret = found->func->clean(found);
+			if (ret)
+				return ret;
+
+			found->res_dirty = false;
+		}
+		last_cleaned = found->backup_offset + found->backup_size;
+		cur = rb_next(&found->mob_node);
+		if (!cur)
+			break;
+
+		found = container_of(cur, struct vmw_resource, mob_node);
+		if (found->backup_offset >= res_end)
+			break;
+	}
+
+	/*
+	 * Set number of pages allowed prefaulting and fence the buffer object
+	 */
+	*num_prefault = 1;
+	if (last_cleaned > res_start) {
+		struct ttm_buffer_object *bo = &vbo->base;
+
+		*num_prefault = __KERNEL_DIV_ROUND_UP(last_cleaned - res_start,
+						      PAGE_SIZE);
+		vmw_bo_fence_single(bo, NULL);
+		if (bo->moving)
+			dma_fence_put(bo->moving);
+		bo->moving = dma_fence_get
+			(reservation_object_get_excl(bo->resv));
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
index c85144286cfe..3b7438b2d289 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h
@@ -77,6 +77,7 @@ struct vmw_user_resource_conv {
  * @dirty_sync:        Upload the dirty mob contents to the resource.
  * @dirty_add_range:   Add a sequential dirty range to the resource
  *                     dirty tracker.
+ * @clean:             Clean the resource.
  */
 struct vmw_res_func {
 	enum vmw_res_type res_type;
@@ -101,6 +102,7 @@ struct vmw_res_func {
 	int (*dirty_sync)(struct vmw_resource *res);
 	void (*dirty_range_add)(struct vmw_resource *res, size_t start,
 				 size_t end);
+	int (*clean)(struct vmw_resource *res);
 };
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index 71349a7bae90..9aaf807ed73c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -641,7 +641,8 @@ int vmw_validation_res_validate(struct vmw_validation_context *ctx, bool intr)
 		struct vmw_resource *res = val->res;
 		struct vmw_buffer_object *backup = res->backup;
 
-		ret = vmw_resource_validate(res, intr);
+		ret = vmw_resource_validate(res, intr, val->dirty_set &&
+					    val->dirty);
 		if (ret) {
 			if (ret != -ERESTARTSYS)
 				DRM_ERROR("Failed to validate resource.\n");
-- 
2.20.1

