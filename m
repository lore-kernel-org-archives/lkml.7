Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1221019
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjd7y7jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCPULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:11:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:11:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so6987114wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8hhTrP2mkZ4OAwduXCx98X8ht157RsKf8rcJUZr7fSo=;
        b=Kjd7y7jIn7Y4Ydmaz6kFZF0YAb30YctngXKOYVgV++MJL5X1a1sCC71bKJgtT5OgiU
         a3fQArLcJiP+XYpPfGxgvo6/qaKXMtPVR7O22UPgIyMZeqQkkZ8MGqbM4RMcxMWI7mG4
         2pe9to/uSOIhMDX7kuOdUdmkLnm6FhnUMmpsAnTkJk4F6CTbhLlhmkk0tS8aYxyyT2Xc
         eTeCd1Y5iV/b4EkFoenB6zFwtDOFT58nqps+mMo1oO+nwdctgOyB2IywOJEeeG6d2tkF
         AB5Aa6pEZsN4Tnn65JM1V7K6xmRwN6WDjU27StpqBGRPLeoMsxT5Kz9lvzttCvKE8qT0
         Xpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8hhTrP2mkZ4OAwduXCx98X8ht157RsKf8rcJUZr7fSo=;
        b=f5dncEDCBuXTBpVlbYDZODO0MlbfX1/7FIVU9Wpc1tZ46Isybxb0fa4wBu5jpRcMN0
         zSdWS03jaJCI8M4it1ojQx86ixyjZBwxCcWPowSZb+c2NpOEr0VuUp7f5mIic6GOezPY
         phvQLaMbf/y7jqt3sI1txbOr292nME4BfokSV4oTJfqdyybsXrqKzIrYShnlUfWF+pJX
         tAm3dwokZcrRx9wcFsk0LvPa6GJCWBZr+ZEG851B1NwYWpnhPkAC+049n5hARbpl5z5P
         kBbBIb3k/N8I2xU6WNyd2Ibp5CfkfpWswNeyHtZuO8K4lJiAwSUqTYTOeQokXK6NN3Zl
         XgvA==
X-Gm-Message-State: APjAAAWRw3EEcZsvoVoZwtap4zifdnzKEbIFcHu79+pXO0hAjuj/I81H
        qXMpmoO8onVUjywTxV29L71HuMPu
X-Google-Smtp-Source: APXvYqz5WLBxMCrjFUVUiuPQ6fegS5TjZ6gOrkdkpsQQCm1wEV9zYq24YURUp38NWOAxhJgc6vl2Tw==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr7040476wrq.17.1552767062329;
        Sat, 16 Mar 2019 13:11:02 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h10sm8722221wmf.2.2019.03.16.13.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:11:01 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 1/4] habanalabs: fix MMU number of pages calculation
Date:   Sat, 16 Mar 2019 22:10:44 +0200
Message-Id: <20190316201047.22516-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

The requested allocation size is 64bit, hence the number of requested
pages and the total requested size should 64bit as well.
This patch fixes all places where these are treated as 32bit.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c    |  7 ++++---
 drivers/misc/habanalabs/habanalabs.h |  8 ++++----
 drivers/misc/habanalabs/memory.c     | 29 ++++++++++++++--------------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index a53c12aff6ad..974a87789bd8 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -232,6 +232,7 @@ static int vm_show(struct seq_file *s, void *data)
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
 	enum vm_type_t *vm_type;
 	bool once = true;
+	u64 j;
 	int i;
 
 	if (!dev_entry->hdev->mmu_enable)
@@ -260,7 +261,7 @@ static int vm_show(struct seq_file *s, void *data)
 			} else {
 				phys_pg_pack = hnode->ptr;
 				seq_printf(s,
-					"    0x%-14llx      %-10u       %-4u\n",
+					"    0x%-14llx      %-10llu       %-4u\n",
 					hnode->vaddr, phys_pg_pack->total_size,
 					phys_pg_pack->handle);
 			}
@@ -282,9 +283,9 @@ static int vm_show(struct seq_file *s, void *data)
 						phys_pg_pack->page_size);
 			seq_puts(s, "   physical address\n");
 			seq_puts(s, "---------------------\n");
-			for (i = 0 ; i < phys_pg_pack->npages ; i++) {
+			for (j = 0 ; j < phys_pg_pack->npages ; j++) {
 				seq_printf(s, "    0x%-14llx\n",
-						phys_pg_pack->pages[i]);
+						phys_pg_pack->pages[j]);
 			}
 		}
 		spin_unlock(&vm->idr_lock);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a7c95e9f9b9a..806f0a5ee4d8 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -793,11 +793,11 @@ struct hl_vm_hash_node {
  * struct hl_vm_phys_pg_pack - physical page pack.
  * @vm_type: describes the type of the virtual area descriptor.
  * @pages: the physical page array.
+ * @npages: num physical pages in the pack.
+ * @total_size: total size of all the pages in this list.
  * @mapping_cnt: number of shared mappings.
  * @asid: the context related to this list.
- * @npages: num physical pages in the pack.
  * @page_size: size of each page in the pack.
- * @total_size: total size of all the pages in this list.
  * @flags: HL_MEM_* flags related to this list.
  * @handle: the provided handle related to this list.
  * @offset: offset from the first page.
@@ -807,11 +807,11 @@ struct hl_vm_hash_node {
 struct hl_vm_phys_pg_pack {
 	enum vm_type_t		vm_type; /* must be first */
 	u64			*pages;
+	u64			npages;
+	u64			total_size;
 	atomic_t		mapping_cnt;
 	u32			asid;
-	u32			npages;
 	u32			page_size;
-	u32			total_size;
 	u32			flags;
 	u32			handle;
 	u32			offset;
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 3a12fd1a5274..4f8c968e441a 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -56,9 +56,9 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm *vm = &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
-	u64 paddr = 0;
-	u32 total_size, num_pgs, num_curr_pgs, page_size, page_shift;
-	int handle, rc, i;
+	u64 paddr = 0, total_size, num_pgs, i;
+	u32 num_curr_pgs, page_size, page_shift;
+	int handle, rc;
 	bool contiguous;
 
 	num_curr_pgs = 0;
@@ -73,7 +73,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 		paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
 		if (!paddr) {
 			dev_err(hdev->dev,
-				"failed to allocate %u huge contiguous pages\n",
+				"failed to allocate %llu huge contiguous pages\n",
 				num_pgs);
 			return -ENOMEM;
 		}
@@ -267,7 +267,7 @@ static void free_phys_pg_pack(struct hl_device *hdev,
 		struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_vm *vm = &hdev->vm;
-	int i;
+	u64 i;
 
 	if (!phys_pg_pack->created_from_userptr) {
 		if (phys_pg_pack->contiguous) {
@@ -519,7 +519,7 @@ static inline int add_va_block(struct hl_device *hdev,
  * - Return the start address of the virtual block
  */
 static u64 get_va_block(struct hl_device *hdev,
-		struct hl_va_range *va_range, u32 size, u64 hint_addr,
+		struct hl_va_range *va_range, u64 size, u64 hint_addr,
 		bool is_userptr)
 {
 	struct hl_vm_va_block *va_block, *new_va_block = NULL;
@@ -577,7 +577,8 @@ static u64 get_va_block(struct hl_device *hdev,
 	}
 
 	if (!new_va_block) {
-		dev_err(hdev->dev, "no available va block for size %u\n", size);
+		dev_err(hdev->dev, "no available va block for size %llu\n",
+				size);
 		goto out;
 	}
 
@@ -648,8 +649,8 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct scatterlist *sg;
 	dma_addr_t dma_addr;
-	u64 page_mask;
-	u32 npages, total_npages, page_size = PAGE_SIZE;
+	u64 page_mask, total_npages;
+	u32 npages, page_size = PAGE_SIZE;
 	bool first = true, is_huge_page_opt = true;
 	int rc, i, j;
 
@@ -750,9 +751,9 @@ static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
 		struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_device *hdev = ctx->hdev;
-	u64 next_vaddr = vaddr, paddr;
+	u64 next_vaddr = vaddr, paddr, mapped_pg_cnt = 0, i;
 	u32 page_size = phys_pg_pack->page_size;
-	int i, rc = 0, mapped_pg_cnt = 0;
+	int rc = 0;
 
 	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
 		paddr = phys_pg_pack->pages[i];
@@ -764,7 +765,7 @@ static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
 		rc = hl_mmu_map(ctx, next_vaddr, paddr, page_size);
 		if (rc) {
 			dev_err(hdev->dev,
-				"map failed for handle %u, npages: %d, mapped: %d",
+				"map failed for handle %u, npages: %llu, mapped: %llu",
 				phys_pg_pack->handle, phys_pg_pack->npages,
 				mapped_pg_cnt);
 			goto err;
@@ -985,10 +986,10 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 	struct hl_vm_hash_node *hnode = NULL;
 	struct hl_userptr *userptr = NULL;
 	enum vm_type_t *vm_type;
-	u64 next_vaddr;
+	u64 next_vaddr, i;
 	u32 page_size;
 	bool is_userptr;
-	int i, rc;
+	int rc;
 
 	/* protect from double entrance */
 	mutex_lock(&ctx->mem_hash_lock);
-- 
2.17.1

