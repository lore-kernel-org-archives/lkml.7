Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C3C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ECA20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="grwMh90O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfFQUY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:24:29 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:14605 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:24:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5C4A8473F1;
        Mon, 17 Jun 2019 22:18:15 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=grwMh90O;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 40tC5uFNlIuC; Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8175B3F44D;
        Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 461D83619AF;
        Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1560802685; bh=ie7P8PRlXqjA4Uc3shR6h+sNX2ALI0R/o0+jtHbiHio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grwMh90OEut1ZO8z4sX/z8djL9NXIYGjYJaqK/PZBno6BlePLMfC4/8ejgZAhUMyf
         owkhqKTo/i4x+ZxpwKxWZudhKCzq0EI7tLBbdmkLq2OzU7vElJDzqaoo3Zof2h061p
         oui8cleX0SjiWxOhedHzVyZga/6865bPGXek+P4U=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/9] drm/ttm: TTM fault handler helpers
Date:   Mon, 17 Jun 2019 22:17:52 +0200
Message-Id: <20190617201756.12587-6-thomas@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617201756.12587-1-thomas@shipmail.org>
References: <20190617201756.12587-1-thomas@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With the vmwgfx dirty tracking, the default TTM fault handler is not
completely sufficient (vmwgfx need to modify the vma->vm_flags member,
and also needs to restrict the number of prefaults).

We also want to replicate the new ttm_bo_vm_reserve() functionality

So start turning the TTM vm code into helpers: ttm_bo_vm_fault_reserved()
and ttm_bo_vm_reserve(), and provide a default TTM fault handler for other
drivers to use.

Cc: "Christian König" <christian.koenig@amd.com>

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: "Christian König" <christian.koenig@amd.com> #v1
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 163 ++++++++++++++++++++------------
 include/drm/ttm/ttm_bo_api.h    |  10 ++
 2 files changed, 111 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 196e13a0adad..0c4576cbafcf 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -42,8 +42,6 @@
 #include <linux/uaccess.h>
 #include <linux/mem_encrypt.h>
 
-#define TTM_BO_VM_NUM_PREFAULT 16
-
 static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
 				struct vm_fault *vmf)
 {
@@ -106,25 +104,30 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
 		+ page_offset;
 }
 
-static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
+/**
+ * ttm_bo_vm_reserve - Reserve a buffer object in a retryable vm callback
+ * @bo: The buffer object
+ * @vmf: The fault structure handed to the callback
+ *
+ * vm callbacks like fault() and *_mkwrite() allow for the mm_sem to be dropped
+ * during long waits, and after the wait the callback will be restarted. This
+ * is to allow other threads using the same virtual memory space concurrent
+ * access to map(), unmap() completely unrelated buffer objects. TTM buffer
+ * object reservations sometimes wait for GPU and should therefore be
+ * considered long waits. This function reserves the buffer object interruptibly
+ * taking this into account. Starvation is avoided by the vm system not
+ * allowing too many repeated restarts.
+ * This function is intended to be used in customized fault() and _mkwrite()
+ * handlers.
+ *
+ * Return:
+ *    0 on success and the bo was reserved.
+ *    VM_FAULT_RETRY if blocking wait.
+ *    VM_FAULT_NOPAGE if blocking wait and retrying was not allowed.
+ */
+vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
+			     struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
-	    vma->vm_private_data;
-	struct ttm_bo_device *bdev = bo->bdev;
-	unsigned long page_offset;
-	unsigned long page_last;
-	unsigned long pfn;
-	struct ttm_tt *ttm = NULL;
-	struct page *page;
-	int err;
-	int i;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
-	unsigned long address = vmf->address;
-	struct ttm_mem_type_manager *man =
-		&bdev->man[bo->mem.mem_type];
-	struct vm_area_struct cvma;
-
 	/*
 	 * Work around locking order reversal in fault / nopfn
 	 * between mmap_sem and bo_reserve: Perform a trylock operation
@@ -151,14 +154,55 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL(ttm_bo_vm_reserve);
+
+/**
+ * ttm_bo_vm_fault_reserved - TTM fault helper
+ * @vmf: The struct vm_fault given as argument to the fault callback
+ * @prot: The page protection to be used for this memory area.
+ * @num_prefault: Maximum number of prefault pages. The caller may want to
+ * specify this based on madvice settings and the size of the GPU object
+ * backed by the memory.
+ *
+ * This function inserts one or more page table entries pointing to the
+ * memory backing the buffer object, and then returns a return code
+ * instructing the caller to retry the page access.
+ *
+ * Return:
+ *   VM_FAULT_NOPAGE on success or pending signal
+ *   VM_FAULT_SIGBUS on unspecified error
+ *   VM_FAULT_OOM on out-of-memory
+ *   VM_FAULT_RETRY if retryable wait
+ */
+vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
+				    pgprot_t prot,
+				    pgoff_t num_prefault)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct cvma = *vma;
+	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
+	    vma->vm_private_data;
+	struct ttm_bo_device *bdev = bo->bdev;
+	unsigned long page_offset;
+	unsigned long page_last;
+	unsigned long pfn;
+	struct ttm_tt *ttm = NULL;
+	struct page *page;
+	int err;
+	pgoff_t i;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
+	unsigned long address = vmf->address;
+	struct ttm_mem_type_manager *man =
+		&bdev->man[bo->mem.mem_type];
+
 	/*
 	 * Refuse to fault imported pages. This should be handled
 	 * (if at all) by redirecting mmap to the exporter.
 	 */
-	if (bo->ttm && (bo->ttm->page_flags & TTM_PAGE_FLAG_SG)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
-	}
+	if (bo->ttm && (bo->ttm->page_flags & TTM_PAGE_FLAG_SG))
+		return VM_FAULT_SIGBUS;
 
 	if (bdev->driver->fault_reserve_notify) {
 		struct dma_fence *moving = dma_fence_get(bo->moving);
@@ -169,11 +213,9 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 			break;
 		case -EBUSY:
 		case -ERESTARTSYS:
-			ret = VM_FAULT_NOPAGE;
-			goto out_unlock;
+			return VM_FAULT_NOPAGE;
 		default:
-			ret = VM_FAULT_SIGBUS;
-			goto out_unlock;
+			return VM_FAULT_SIGBUS;
 		}
 
 		if (bo->moving != moving) {
@@ -189,21 +231,12 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	 * move.
 	 */
 	ret = ttm_bo_vm_fault_idle(bo, vmf);
-	if (unlikely(ret != 0)) {
-		if (ret == VM_FAULT_RETRY &&
-		    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
-			/* The BO has already been unreserved. */
-			return ret;
-		}
-
-		goto out_unlock;
-	}
+	if (unlikely(ret != 0))
+		return ret;
 
 	err = ttm_mem_io_lock(man, true);
-	if (unlikely(err != 0)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out_unlock;
-	}
+	if (unlikely(err != 0))
+		return VM_FAULT_NOPAGE;
 	err = ttm_mem_io_reserve_vm(bo);
 	if (unlikely(err != 0)) {
 		ret = VM_FAULT_SIGBUS;
@@ -220,18 +253,8 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		goto out_io_unlock;
 	}
 
-	/*
-	 * Make a local vma copy to modify the page_prot member
-	 * and vm_flags if necessary. The vma parameter is protected
-	 * by mmap_sem in write mode.
-	 */
-	cvma = *vma;
-	cvma.vm_page_prot = vm_get_page_prot(cvma.vm_flags);
-
-	if (bo->mem.bus.is_iomem) {
-		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
-						cvma.vm_page_prot);
-	} else {
+	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
+	if (!bo->mem.bus.is_iomem) {
 		struct ttm_operation_ctx ctx = {
 			.interruptible = false,
 			.no_wait_gpu = false,
@@ -240,24 +263,21 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		};
 
 		ttm = bo->ttm;
-		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
-						cvma.vm_page_prot);
-
-		/* Allocate all page at once, most common usage */
-		if (ttm_tt_populate(ttm, &ctx)) {
+		if (ttm_tt_populate(bo->ttm, &ctx)) {
 			ret = VM_FAULT_OOM;
 			goto out_io_unlock;
 		}
+	} else {
+		/* Iomem should not be marked encrypted */
+		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
 	}
 
 	/*
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
 	 */
-	for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
+	for (i = 0; i < num_prefault; ++i) {
 		if (bo->mem.bus.is_iomem) {
-			/* Iomem should not be marked encrypted */
-			cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
 			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
 		} else {
 			page = ttm->pages[page_offset];
@@ -295,7 +315,26 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	ret = VM_FAULT_NOPAGE;
 out_io_unlock:
 	ttm_mem_io_unlock(man);
-out_unlock:
+	return ret;
+}
+EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
+
+static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t prot;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
+	vm_fault_t ret;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	prot = vm_get_page_prot(vma->vm_flags);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
 	reservation_object_unlock(bo->resv);
 	return ret;
 }
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 49d9cdfc58f2..435d02f719a8 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -768,4 +768,14 @@ int ttm_bo_swapout(struct ttm_bo_global *glob,
 			struct ttm_operation_ctx *ctx);
 void ttm_bo_swapout_all(struct ttm_bo_device *bdev);
 int ttm_bo_wait_unreserved(struct ttm_buffer_object *bo);
+
+/* Default number of pre-faulted pages in the TTM fault handler */
+#define TTM_BO_VM_NUM_PREFAULT 16
+
+vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
+			     struct vm_fault *vmf);
+
+vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
+				    pgprot_t prot,
+				    pgoff_t num_prefault);
 #endif
-- 
2.20.1

