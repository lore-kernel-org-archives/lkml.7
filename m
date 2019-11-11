Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303D0206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT0KAKsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKGSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:18:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44545 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:18:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so13199841wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 22:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=45ezLomQjlswTmXMfx/qcO3Y8JsMdsjSXfP79l/s6kU=;
        b=cT0KAKsMdvlbEjTpJxEU3ucaWgoTXQaaNBZ6CPFSrWR7DwJDeqnKwLAIa+u37dDSv6
         B6aDTyT4s7YAVbNh0TAZX0XJAlf8UsmD6W2YLXEpF/RhxENIR3pWgW01tRh5Z4q8CcZP
         YIqiBRocC+/a9/ekcPaGWAQwGxSUc16u2r5bXAsojvvazReAjyxQNQLLqCpFyHZF/oQ2
         +pM5HH137Hax6t2waTL1o2PY0Cbu+Gucy9eIvaFYqKEK0oqfvuWNtx2jcKteO+rTrUEP
         VtmNbAdUlX1KzvnpcACyLlTRTtaCrmMWulzX+syTyuZMajXvW+8cqLZcyj/9JY+QdXsW
         tYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=45ezLomQjlswTmXMfx/qcO3Y8JsMdsjSXfP79l/s6kU=;
        b=hTqu27kaXZDrw69tZh29Fz8j7lx8SpOP5h9YeHjIuHqML4fBcy7iRtnMrKB5W8JE+D
         3SofrK143VDuPo3YDFAcnqgjDgL2tH5vyHzUT3C6lZ0NkXa3fXZ7bKT/4a6yeTMdBk3O
         NZpi3ibeNqYmdb04hyVHxJ3jBPYgxoEPj9lF7lZllRwz8LhF9vwWcBKFngwQMPGvHlah
         Ah+LL90VLrKtW0vjUFLi0J/zzC1cNr2/50u7QuGD60WuCCMMBItXbQQ5KRaBIHpjRM7D
         DV794Y8WjYlhzjVahIZJDutGAUSgqoroIM9eyEt0rawI37cqvizWBtw0zv/vRVypSp6/
         JRhg==
X-Gm-Message-State: APjAAAUvCFTlqYS1u9yXnTC0iNypgxvIEQGEVCy56oAK5UUIR0dLFcTh
        J65TtvwrJ+oE2o+x94nNvr/+yeq0nFg=
X-Google-Smtp-Source: APXvYqwcTJybEQ3OwUSi7z5cAF4s1Ak8MTRXecB0Oo5MfPQeDKXZfHzTzUV5NOnmmNarWROcgV+Geg==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr20815031wrw.82.1573453126413;
        Sun, 10 Nov 2019 22:18:46 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm20469381wrf.80.2019.11.10.22.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 22:18:45 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: re-factor memory module code
Date:   Mon, 11 Nov 2019 08:18:42 +0200
Message-Id: <20191111061842.27474-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Some of the functions in the memory module code were too long and/or
contained multiple operations that are not always done together. Re-factor
the code by dividing those functions to smaller functions which are more
readable and maintainable.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  |   2 +-
 drivers/misc/habanalabs/habanalabs.h |   4 +-
 drivers/misc/habanalabs/memory.c     | 281 +++++++++++++++------------
 3 files changed, 158 insertions(+), 129 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 4e767e1d78e4..9712122d6cb1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3935,7 +3935,7 @@ static int goya_parse_cb_no_ext_queue(struct hl_device *hdev,
 		return 0;
 
 	dev_err(hdev->dev,
-		"Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
+		"Internal CB address 0x%px + 0x%x is not in SRAM nor in DRAM\n",
 		parser->user_cb, parser->user_cb_size);
 
 	return -EFAULT;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 2a5344cc1a60..78aef59e690b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -692,7 +692,7 @@ struct hl_ctx_mgr {
  * @sgt: pointer to the scatter-gather table that holds the pages.
  * @dir: for DMA unmapping, the direction must be supplied, so save it.
  * @debugfs_list: node in debugfs list of command submissions.
- * @addr: user-space virtual pointer to the start of the memory area.
+ * @addr: user-space virtual address of the start of the memory area.
  * @size: size of the memory area to pin & map.
  * @dma_mapped: true if the SG was mapped to DMA addresses, false otherwise.
  */
@@ -1527,7 +1527,7 @@ void hl_vm_fini(struct hl_device *hdev);
 
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 			struct hl_userptr *userptr);
-int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr);
+void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr);
 void hl_userptr_delete_list(struct hl_device *hdev,
 				struct list_head *userptr_list);
 bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr, u32 size,
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 365fb0cb8dff..8ade9886a5a7 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -159,20 +159,19 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 }
 
 /*
- * get_userptr_from_host_va - initialize userptr structure from given host
- *                            virtual address
- *
- * @hdev                : habanalabs device structure
- * @args                : parameters containing the virtual address and size
- * @p_userptr           : pointer to result userptr structure
+ * dma_map_host_va - DMA mapping of the given host virtual address.
+ * @hdev: habanalabs device structure
+ * @addr: the host virtual address of the memory area
+ * @size: the size of the memory area
+ * @p_userptr: pointer to result userptr structure
  *
  * This function does the following:
  * - Allocate userptr structure
  * - Pin the given host memory using the userptr structure
  * - Perform DMA mapping to have the DMA addresses of the pages
  */
-static int get_userptr_from_host_va(struct hl_device *hdev,
-		struct hl_mem_in *args, struct hl_userptr **p_userptr)
+static int dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
+				struct hl_userptr **p_userptr)
 {
 	struct hl_userptr *userptr;
 	int rc;
@@ -183,8 +182,7 @@ static int get_userptr_from_host_va(struct hl_device *hdev,
 		goto userptr_err;
 	}
 
-	rc = hl_pin_host_memory(hdev, args->map_host.host_virt_addr,
-			args->map_host.mem_size, userptr);
+	rc = hl_pin_host_memory(hdev, addr, size, userptr);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to pin host memory\n");
 		goto pin_err;
@@ -215,16 +213,16 @@ static int get_userptr_from_host_va(struct hl_device *hdev,
 }
 
 /*
- * free_userptr - free userptr structure
- *
- * @hdev                : habanalabs device structure
- * @userptr             : userptr to free
+ * dma_unmap_host_va - DMA unmapping of the given host virtual address.
+ * @hdev: habanalabs device structure
+ * @userptr: userptr to free
  *
  * This function does the following:
  * - Unpins the physical pages
  * - Frees the userptr structure
  */
-static void free_userptr(struct hl_device *hdev, struct hl_userptr *userptr)
+static void dma_unmap_host_va(struct hl_device *hdev,
+				struct hl_userptr *userptr)
 {
 	hl_unpin_host_memory(hdev, userptr);
 	kfree(userptr);
@@ -253,10 +251,9 @@ static void dram_pg_pool_do_release(struct kref *ref)
 }
 
 /*
- * free_phys_pg_pack   - free physical page pack
- *
- * @hdev               : habanalabs device structure
- * @phys_pg_pack       : physical page pack to free
+ * free_phys_pg_pack - free physical page pack
+ * @hdev: habanalabs device structure
+ * @phys_pg_pack: physical page pack to free
  *
  * This function does the following:
  * - For DRAM memory only, iterate over the pack and free each physical block
@@ -264,7 +261,7 @@ static void dram_pg_pool_do_release(struct kref *ref)
  * - Free the hl_vm_phys_pg_pack structure
  */
 static void free_phys_pg_pack(struct hl_device *hdev,
-		struct hl_vm_phys_pg_pack *phys_pg_pack)
+				struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_vm *vm = &hdev->vm;
 	u64 i;
@@ -631,20 +628,18 @@ static u32 get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
 
 /*
  * init_phys_pg_pack_from_userptr - initialize physical page pack from host
- *                                   memory
- *
- * @ctx                : current context
- * @userptr            : userptr to initialize from
- * @pphys_pg_pack      : res pointer
+ *                                  memory
+ * @asid: current context ASID
+ * @userptr: userptr to initialize from
+ * @pphys_pg_pack: result pointer
  *
  * This function does the following:
  * - Pin the physical pages related to the given virtual block
  * - Create a physical page pack from the physical pages related to the given
  *   virtual block
  */
-static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
-		struct hl_userptr *userptr,
-		struct hl_vm_phys_pg_pack **pphys_pg_pack)
+static int init_phys_pg_pack_from_userptr(u32 asid, struct hl_userptr *userptr,
+				struct hl_vm_phys_pg_pack **pphys_pg_pack)
 {
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct scatterlist *sg;
@@ -660,7 +655,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 
 	phys_pg_pack->vm_type = userptr->vm_type;
 	phys_pg_pack->created_from_userptr = true;
-	phys_pg_pack->asid = ctx->asid;
+	phys_pg_pack->asid = asid;
 	atomic_set(&phys_pg_pack->mapping_cnt, 1);
 
 	/* Only if all dma_addrs are aligned to 2MB and their
@@ -731,19 +726,18 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 }
 
 /*
- * map_phys_page_pack - maps the physical page pack
- *
- * @ctx                : current context
- * @vaddr              : start address of the virtual area to map from
- * @phys_pg_pack       : the pack of physical pages to map to
+ * map_phys_pg_pack - maps the physical page pack.
+ * @ctx: current context
+ * @vaddr: start address of the virtual area to map from
+ * @phys_pg_pack: the pack of physical pages to map to
  *
  * This function does the following:
  * - Maps each chunk of virtual memory to matching physical chunk
  * - Stores number of successful mappings in the given argument
- * - Returns 0 on success, error code otherwise.
+ * - Returns 0 on success, error code otherwise
  */
-static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
-		struct hl_vm_phys_pg_pack *phys_pg_pack)
+static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
+				struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_device *hdev = ctx->hdev;
 	u64 next_vaddr = vaddr, paddr, mapped_pg_cnt = 0, i;
@@ -783,6 +777,36 @@ static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
 	return rc;
 }
 
+/*
+ * unmap_phys_pg_pack - unmaps the physical page pack
+ * @ctx: current context
+ * @vaddr: start address of the virtual area to unmap
+ * @phys_pg_pack: the pack of physical pages to unmap
+ */
+static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
+				struct hl_vm_phys_pg_pack *phys_pg_pack)
+{
+	struct hl_device *hdev = ctx->hdev;
+	u64 next_vaddr, i;
+	u32 page_size;
+
+	page_size = phys_pg_pack->page_size;
+	next_vaddr = vaddr;
+
+	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size) {
+		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
+			dev_warn_ratelimited(hdev->dev,
+			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
+
+		/*
+		 * unmapping on Palladium can be really long, so avoid a CPU
+		 * soft lockup bug by sleeping a little between unmapping pages
+		 */
+		if (hdev->pldm)
+			usleep_range(500, 1000);
+	}
+}
+
 static int get_paddr_from_handle(struct hl_ctx *ctx, struct hl_mem_in *args,
 				u64 *paddr)
 {
@@ -839,18 +863,21 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	*device_addr = 0;
 
 	if (is_userptr) {
-		rc = get_userptr_from_host_va(hdev, args, &userptr);
+		u64 addr = args->map_host.host_virt_addr,
+			size = args->map_host.mem_size;
+
+		rc = dma_map_host_va(hdev, addr, size, &userptr);
 		if (rc) {
 			dev_err(hdev->dev, "failed to get userptr from va\n");
 			return rc;
 		}
 
-		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
+		rc = init_phys_pg_pack_from_userptr(ctx->asid, userptr,
 				&phys_pg_pack);
 		if (rc) {
 			dev_err(hdev->dev,
 				"unable to init page pack for vaddr 0x%llx\n",
-				args->map_host.host_virt_addr);
+				addr);
 			goto init_page_pack_err;
 		}
 
@@ -909,7 +936,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	mutex_lock(&ctx->mmu_lock);
 
-	rc = map_phys_page_pack(ctx, ret_vaddr, phys_pg_pack);
+	rc = map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
 		mutex_unlock(&ctx->mmu_lock);
 		dev_err(hdev->dev, "mapping page pack failed for handle %u\n",
@@ -955,7 +982,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		free_phys_pg_pack(hdev, phys_pg_pack);
 init_page_pack_err:
 	if (is_userptr)
-		free_userptr(hdev, userptr);
+		dma_unmap_host_va(hdev, userptr);
 
 	return rc;
 }
@@ -977,8 +1004,6 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 	struct hl_vm_hash_node *hnode = NULL;
 	struct hl_userptr *userptr = NULL;
 	enum vm_type_t *vm_type;
-	u64 next_vaddr, i;
-	u32 page_size;
 	bool is_userptr;
 	int rc;
 
@@ -1004,8 +1029,8 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 	if (*vm_type == VM_TYPE_USERPTR) {
 		is_userptr = true;
 		userptr = hnode->ptr;
-		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
-				&phys_pg_pack);
+		rc = init_phys_pg_pack_from_userptr(ctx->asid, userptr,
+							&phys_pg_pack);
 		if (rc) {
 			dev_err(hdev->dev,
 				"unable to init page pack for vaddr 0x%llx\n",
@@ -1029,24 +1054,11 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 		goto mapping_cnt_err;
 	}
 
-	page_size = phys_pg_pack->page_size;
-	vaddr &= ~(((u64) page_size) - 1);
-
-	next_vaddr = vaddr;
+	vaddr &= ~(((u64) phys_pg_pack->page_size) - 1);
 
 	mutex_lock(&ctx->mmu_lock);
 
-	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size) {
-		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
-			dev_warn_ratelimited(hdev->dev,
-			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
-
-		/* unmapping on Palladium can be really long, so avoid a CPU
-		 * soft lockup bug by sleeping a little between unmapping pages
-		 */
-		if (hdev->pldm)
-			usleep_range(500, 1000);
-	}
+	unmap_phys_pg_pack(ctx, vaddr, phys_pg_pack);
 
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
 
@@ -1064,7 +1076,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 
 	if (is_userptr) {
 		free_phys_pg_pack(hdev, phys_pg_pack);
-		free_userptr(hdev, userptr);
+		dma_unmap_host_va(hdev, userptr);
 	}
 
 	return 0;
@@ -1203,20 +1215,72 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 	return rc;
 }
 
+static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
+				u32 npages, u64 start, u32 offset,
+				struct hl_userptr *userptr)
+{
+	int rc;
+
+	if (!access_ok((void __user *) (uintptr_t) addr, size)) {
+		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n", addr);
+		return -EFAULT;
+	}
+
+	userptr->vec = frame_vector_create(npages);
+	if (!userptr->vec) {
+		dev_err(hdev->dev, "Failed to create frame vector\n");
+		return -ENOMEM;
+	}
+
+	rc = get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
+				userptr->vec);
+
+	if (rc != npages) {
+		dev_err(hdev->dev,
+			"Failed to map host memory, user ptr probably wrong\n");
+		if (rc < 0)
+			goto destroy_framevec;
+		rc = -EFAULT;
+		goto put_framevec;
+	}
+
+	if (frame_vector_to_pages(userptr->vec) < 0) {
+		dev_err(hdev->dev,
+			"Failed to translate frame vector to pages\n");
+		rc = -EFAULT;
+		goto put_framevec;
+	}
+
+	rc = sg_alloc_table_from_pages(userptr->sgt,
+					frame_vector_pages(userptr->vec),
+					npages, offset, size, GFP_ATOMIC);
+	if (rc < 0) {
+		dev_err(hdev->dev, "failed to create SG table from pages\n");
+		goto put_framevec;
+	}
+
+	return 0;
+
+put_framevec:
+	put_vaddr_frames(userptr->vec);
+destroy_framevec:
+	frame_vector_destroy(userptr->vec);
+	return rc;
+}
+
 /*
- * hl_pin_host_memory - pins a chunk of host memory
- *
- * @hdev                : pointer to the habanalabs device structure
- * @addr                : the user-space virtual address of the memory area
- * @size                : the size of the memory area
- * @userptr	        : pointer to hl_userptr structure
+ * hl_pin_host_memory - pins a chunk of host memory.
+ * @hdev: pointer to the habanalabs device structure
+ * @addr: the host virtual address of the memory area
+ * @size: the size of the memory area
+ * @userptr: pointer to hl_userptr structure
  *
  * This function does the following:
  * - Pins the physical pages
- * - Create a SG list from those pages
+ * - Create an SG list from those pages
  */
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
-			struct hl_userptr *userptr)
+					struct hl_userptr *userptr)
 {
 	u64 start, end;
 	u32 npages, offset;
@@ -1227,11 +1291,6 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 		return -EINVAL;
 	}
 
-	if (!access_ok((void __user *) (uintptr_t) addr, size)) {
-		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n", addr);
-		return -EFAULT;
-	}
-
 	/*
 	 * If the combination of the address and size requested for this memory
 	 * region causes an integer overflow, return error.
@@ -1244,6 +1303,14 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 		return -EINVAL;
 	}
 
+	/*
+	 * This function can be called also from data path, hence use atomic
+	 * always as it is not a big allocation.
+	 */
+	userptr->sgt = kzalloc(sizeof(*userptr->sgt), GFP_ATOMIC);
+	if (!userptr->sgt)
+		return -ENOMEM;
+
 	start = addr & PAGE_MASK;
 	offset = addr & ~PAGE_MASK;
 	end = PAGE_ALIGN(addr + size);
@@ -1254,42 +1321,12 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 	userptr->dma_mapped = false;
 	INIT_LIST_HEAD(&userptr->job_node);
 
-	userptr->vec = frame_vector_create(npages);
-	if (!userptr->vec) {
-		dev_err(hdev->dev, "Failed to create frame vector\n");
-		return -ENOMEM;
-	}
-
-	rc = get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
-				userptr->vec);
-
-	if (rc != npages) {
-		dev_err(hdev->dev,
-			"Failed to map host memory, user ptr probably wrong\n");
-		if (rc < 0)
-			goto destroy_framevec;
-		rc = -EFAULT;
-		goto put_framevec;
-	}
-
-	if (frame_vector_to_pages(userptr->vec) < 0) {
+	rc = get_user_memory(hdev, addr, size, npages, start, offset,
+				userptr);
+	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to translate frame vector to pages\n");
-		rc = -EFAULT;
-		goto put_framevec;
-	}
-
-	userptr->sgt = kzalloc(sizeof(*userptr->sgt), GFP_ATOMIC);
-	if (!userptr->sgt) {
-		rc = -ENOMEM;
-		goto put_framevec;
-	}
-
-	rc = sg_alloc_table_from_pages(userptr->sgt,
-					frame_vector_pages(userptr->vec),
-					npages, offset, size, GFP_ATOMIC);
-	if (rc < 0) {
-		dev_err(hdev->dev, "failed to create SG table from pages\n");
+			"failed to get user memory for address 0x%llx\n",
+			addr);
 		goto free_sgt;
 	}
 
@@ -1299,34 +1336,28 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 free_sgt:
 	kfree(userptr->sgt);
-put_framevec:
-	put_vaddr_frames(userptr->vec);
-destroy_framevec:
-	frame_vector_destroy(userptr->vec);
 	return rc;
 }
 
 /*
- * hl_unpin_host_memory - unpins a chunk of host memory
- *
- * @hdev                : pointer to the habanalabs device structure
- * @userptr             : pointer to hl_userptr structure
+ * hl_unpin_host_memory - unpins a chunk of host memory.
+ * @hdev: pointer to the habanalabs device structure
+ * @userptr: pointer to hl_userptr structure
  *
  * This function does the following:
  * - Unpins the physical pages related to the host memory
  * - Free the SG list
  */
-int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
+void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
 {
 	struct page **pages;
 
 	hl_debugfs_remove_userptr(hdev, userptr);
 
 	if (userptr->dma_mapped)
-		hdev->asic_funcs->hl_dma_unmap_sg(hdev,
-				userptr->sgt->sgl,
-				userptr->sgt->nents,
-				userptr->dir);
+		hdev->asic_funcs->hl_dma_unmap_sg(hdev, userptr->sgt->sgl,
+							userptr->sgt->nents,
+							userptr->dir);
 
 	pages = frame_vector_pages(userptr->vec);
 	if (!IS_ERR(pages)) {
@@ -1342,8 +1373,6 @@ int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
 
 	sg_free_table(userptr->sgt);
 	kfree(userptr->sgt);
-
-	return 0;
 }
 
 /*
@@ -1627,7 +1656,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
 		if (phys_pg_list->asid == ctx->asid) {
 			dev_dbg(hdev->dev,
-				"page list 0x%p of asid %d is still alive\n",
+				"page list 0x%px of asid %d is still alive\n",
 				phys_pg_list, ctx->asid);
 			atomic64_sub(phys_pg_list->total_size,
 					&hdev->dram_used_mem);
-- 
2.17.1

