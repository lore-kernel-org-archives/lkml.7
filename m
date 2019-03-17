Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB2121741
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH0U5C36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCQUAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41350 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfCQUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:00:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so14741281wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p3bYTzNbcNRbVcnpfKvehWLqSmwZKHawJ/8LnOsjqvg=;
        b=QH0U5C36+Yz9CudZB+P5YIIkJB4OeJIJAogoHKCfZX3eJek3xkodPpkVuOkKS9eDjK
         LosjIGpitqXUTwFs6EecJF1hyi0VIzAAa+fe/h+M9uKMZ7MXEjBtjFYk8SibBo3HxkyR
         ubSDyVm4NYFvIffpmxhoAEScUqRT3KHjMRMb2937nCwr8MDZ7BRBKmHG9ZbA3u+v1RX5
         oXyUYjHeeZPFx71k4cMD6DxEM6jUadXWrk1jxpB4JtlbWgZoK85T0eap1cnO17FrFlyk
         228HckfG3pB7WMwiDwawmib4WJWPdG5d2+Er0z/qtZDtdBUO8bAREVlabKC0TDR3x7E6
         DVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p3bYTzNbcNRbVcnpfKvehWLqSmwZKHawJ/8LnOsjqvg=;
        b=cMmbknUtl/5piiUVA0Ij3XSijkILoZ9MXQwlvfzIWnJtmqEbetmfVbpqcRjvIl5PcD
         GAWwXyoQeUXIFuNTQOL6FqkNxq/QSBz2a89czVhhKm+AiU87hT737cEOySA6sZiej1Io
         jSPM2qENtPajL1wuFgoYVWGG5pEtM5IFj3J4e53scJPBHaWWlFBWCuZU2Ysw0ZFwkQK7
         DiBmxkVuJ5Lx3cTvBWxQ+ZRXFTB8U0noxDlKBTLuyEBbvCD05n4gm2NVB4RSuf/jP3mZ
         6qqr+TbX6HsdubTfzTC0DIn4j2Ihe8rCqnqXwEQWpv2hD8gZJlBU0A+vItlb37POPdyy
         HkEw==
X-Gm-Message-State: APjAAAWzdGbjbwbevf/uFeFqlY0OFAt9SREjleDIWfwM9J4xI2nLyg1b
        zfjxbpZyS0oRc8bYDu364o5xbo4c
X-Google-Smtp-Source: APXvYqxaSVuP6zXc+lyJyv7I43lMXFgNEgHHbtnCudJSZTLlJ1pZsb7vCIgyUgag3jaJVlZImoOBWQ==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr9343904wrx.281.1552852797067;
        Sun, 17 Mar 2019 12:59:57 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:56 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 13/15] habanalabs: add MMU shadow mapping
Date:   Sun, 17 Mar 2019 21:59:25 +0200
Message-Id: <20190317195927.26238-14-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch adds shadow mapping to the MMU module. The shadow mapping
allows traversing the page table in host memory rather reading each PTE
from the device memory.
It brings better performance and avoids reading from invalid device
address upon PCI errors.
Only at the end of map/unmap flow, writings to the device are performed in
order to sync the H/W page tables with the shadow ones.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h          |  24 +-
 .../include/hw_ip/mmu/mmu_general.h           |  16 +-
 drivers/misc/habanalabs/mmu.c                 | 597 ++++++++++--------
 3 files changed, 353 insertions(+), 284 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 9cc841777d81..6991a7f260e8 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -51,8 +51,9 @@
 
 /**
  * struct pgt_info - MMU hop page info.
- * @node: hash linked-list node for the pgts hash of pgts.
- * @addr: physical address of the pgt.
+ * @node: hash linked-list node for the pgts shadow hash of pgts.
+ * @phys_addr: physical address of the pgt.
+ * @shadow_addr: shadow hop in the host.
  * @ctx: pointer to the owner ctx.
  * @num_of_ptes: indicates how many ptes are used in the pgt.
  *
@@ -62,10 +63,11 @@
  * page, it is freed with its pgt_info structure.
  */
 struct pgt_info {
-	struct hlist_node node;
-	u64 addr;
-	struct hl_ctx *ctx;
-	int num_of_ptes;
+	struct hlist_node	node;
+	u64			phys_addr;
+	u64			shadow_addr;
+	struct hl_ctx		*ctx;
+	int			num_of_ptes;
 };
 
 struct hl_device;
@@ -595,7 +597,8 @@ struct hl_va_range {
  * struct hl_ctx - user/kernel context.
  * @mem_hash: holds mapping from virtual address to virtual memory area
  *		descriptor (hl_vm_phys_pg_list or hl_userptr).
- * @mmu_hash: holds a mapping from virtual address to pgt_info structure.
+ * @mmu_phys_hash: holds a mapping from physical address to pgt_info structure.
+ * @mmu_shadow_hash: holds a mapping from shadow address to pgt_info structure.
  * @hpriv: pointer to the private (KMD) data of the process (fd).
  * @hdev: pointer to the device structure.
  * @refcount: reference counter for the context. Context is released only when
@@ -624,7 +627,8 @@ struct hl_va_range {
  */
 struct hl_ctx {
 	DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
-	DECLARE_HASHTABLE(mmu_hash, MMU_HASH_TABLE_BITS);
+	DECLARE_HASHTABLE(mmu_phys_hash, MMU_HASH_TABLE_BITS);
+	DECLARE_HASHTABLE(mmu_shadow_hash, MMU_HASH_TABLE_BITS);
 	struct hl_fpriv		*hpriv;
 	struct hl_device	*hdev;
 	struct kref		refcount;
@@ -1066,7 +1070,8 @@ struct hl_device_reset_work {
  * @asic_specific: ASIC specific information to use only from ASIC files.
  * @mmu_pgt_pool: pool of available MMU hops.
  * @vm: virtual memory manager for MMU.
- * @mmu_cache_lock: protects MMU cache invalidation as it can serve one context
+ * @mmu_cache_lock: protects MMU cache invalidation as it can serve one context.
+ * @mmu_shadow_hop0: shadow mapping of the MMU hop 0 zone.
  * @hwmon_dev: H/W monitor device.
  * @pm_mng_profile: current power management profile.
  * @hl_chip_info: ASIC's sensors information.
@@ -1136,6 +1141,7 @@ struct hl_device {
 	struct gen_pool			*mmu_pgt_pool;
 	struct hl_vm			vm;
 	struct mutex			mmu_cache_lock;
+	void				*mmu_shadow_hop0;
 	struct device			*hwmon_dev;
 	enum hl_pm_mng_profile		pm_mng_profile;
 	struct hwmon_chip_info		*hl_chip_info;
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index b680052ee3f0..71ea3c3e8ba3 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -14,16 +14,16 @@
 #define PAGE_SIZE_4KB			(_AC(1, UL) << PAGE_SHIFT_4KB)
 #define PAGE_MASK_2MB			(~(PAGE_SIZE_2MB - 1))
 
-#define PAGE_PRESENT_MASK		0x0000000000001
-#define SWAP_OUT_MASK			0x0000000000004
-#define LAST_MASK			0x0000000000800
-#define PHYS_ADDR_MASK			0x3FFFFFFFFF000ull
+#define PAGE_PRESENT_MASK		0x0000000000001ull
+#define SWAP_OUT_MASK			0x0000000000004ull
+#define LAST_MASK			0x0000000000800ull
+#define PHYS_ADDR_MASK			0xFFFFFFFFFFFFF000ull
 #define HOP0_MASK			0x3000000000000ull
 #define HOP1_MASK			0x0FF8000000000ull
 #define HOP2_MASK			0x0007FC0000000ull
-#define HOP3_MASK			0x000003FE00000
-#define HOP4_MASK			0x00000001FF000
-#define OFFSET_MASK			0x0000000000FFF
+#define HOP3_MASK			0x000003FE00000ull
+#define HOP4_MASK			0x00000001FF000ull
+#define OFFSET_MASK			0x0000000000FFFull
 
 #define HOP0_SHIFT			48
 #define HOP1_SHIFT			39
@@ -32,7 +32,7 @@
 #define HOP4_SHIFT			12
 
 #define PTE_PHYS_ADDR_SHIFT		12
-#define PTE_PHYS_ADDR_MASK		~0xFFF
+#define PTE_PHYS_ADDR_MASK		~OFFSET_MASK
 
 #define HL_PTE_SIZE			sizeof(u64)
 #define HOP_TABLE_SIZE			PAGE_SIZE_4KB
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 3a5a2cec8305..1ca9508df5f8 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -11,13 +11,15 @@
 #include <linux/genalloc.h>
 #include <linux/slab.h>
 
-static struct pgt_info *get_pgt_info(struct hl_ctx *ctx, u64 addr)
+static inline u64 get_phys_addr(struct hl_ctx *ctx, u64 shadow_addr);
+
+static struct pgt_info *get_pgt_info(struct hl_ctx *ctx, u64 hop_addr)
 {
 	struct pgt_info *pgt_info = NULL;
 
-	hash_for_each_possible(ctx->mmu_hash, pgt_info, node,
-				(unsigned long) addr)
-		if (addr == pgt_info->addr)
+	hash_for_each_possible(ctx->mmu_shadow_hash, pgt_info, node,
+				(unsigned long) hop_addr)
+		if (hop_addr == pgt_info->shadow_addr)
 			break;
 
 	return pgt_info;
@@ -25,45 +27,108 @@ static struct pgt_info *get_pgt_info(struct hl_ctx *ctx, u64 addr)
 
 static void free_hop(struct hl_ctx *ctx, u64 hop_addr)
 {
+	struct hl_device *hdev = ctx->hdev;
 	struct pgt_info *pgt_info = get_pgt_info(ctx, hop_addr);
 
-	gen_pool_free(pgt_info->ctx->hdev->mmu_pgt_pool, pgt_info->addr,
-			ctx->hdev->asic_prop.mmu_hop_table_size);
+	gen_pool_free(hdev->mmu_pgt_pool, pgt_info->phys_addr,
+			hdev->asic_prop.mmu_hop_table_size);
 	hash_del(&pgt_info->node);
-
+	kfree((u64 *) pgt_info->shadow_addr);
 	kfree(pgt_info);
 }
 
 static u64 alloc_hop(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pgt_info *pgt_info;
-	u64 addr;
+	u64 phys_addr, shadow_addr;
 
 	pgt_info = kmalloc(sizeof(*pgt_info), GFP_KERNEL);
 	if (!pgt_info)
 		return ULLONG_MAX;
 
-	addr = (u64) gen_pool_alloc(hdev->mmu_pgt_pool,
-			hdev->asic_prop.mmu_hop_table_size);
-	if (!addr) {
+	phys_addr = (u64) gen_pool_alloc(hdev->mmu_pgt_pool,
+					prop->mmu_hop_table_size);
+	if (!phys_addr) {
 		dev_err(hdev->dev, "failed to allocate page\n");
-		kfree(pgt_info);
-		return ULLONG_MAX;
+		goto pool_add_err;
 	}
 
-	pgt_info->addr = addr;
+	shadow_addr = (u64) kzalloc(prop->mmu_hop_table_size, GFP_KERNEL);
+	if (!shadow_addr)
+		goto shadow_err;
+
+	pgt_info->phys_addr = phys_addr;
+	pgt_info->shadow_addr = shadow_addr;
 	pgt_info->ctx = ctx;
 	pgt_info->num_of_ptes = 0;
-	hash_add(ctx->mmu_hash, &pgt_info->node, addr);
+	hash_add(ctx->mmu_shadow_hash, &pgt_info->node, shadow_addr);
+
+	return shadow_addr;
+
+shadow_err:
+	gen_pool_free(hdev->mmu_pgt_pool, phys_addr, prop->mmu_hop_table_size);
+pool_add_err:
+	kfree(pgt_info);
+
+	return ULLONG_MAX;
+}
+
+static inline u64 get_phys_hop0_addr(struct hl_ctx *ctx)
+{
+	return ctx->hdev->asic_prop.mmu_pgt_addr +
+			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
+}
+
+static inline u64 get_hop0_addr(struct hl_ctx *ctx)
+{
+	return (u64) (uintptr_t) ctx->hdev->mmu_shadow_hop0 +
+			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
+}
+
+static inline void flush(struct hl_ctx *ctx)
+{
+	/* flush all writes from all cores to reach PCI */
+	mb();
+	ctx->hdev->asic_funcs->read_pte(ctx->hdev, get_phys_hop0_addr(ctx));
+}
+
+/* transform the value to physical address when writing to H/W */
+static inline void write_pte(struct hl_ctx *ctx, u64 shadow_pte_addr, u64 val)
+{
+	/*
+	 * The value to write is actually the address of the next shadow hop +
+	 * flags at the 12 LSBs.
+	 * Hence in order to get the value to write to the physical PTE, we
+	 * clear the 12 LSBs and translate the shadow hop to its associated
+	 * physical hop, and add back the original 12 LSBs.
+	 */
+	u64 phys_val = get_phys_addr(ctx, val & PTE_PHYS_ADDR_MASK) |
+				(val & OFFSET_MASK);
+
+	ctx->hdev->asic_funcs->write_pte(ctx->hdev,
+					get_phys_addr(ctx, shadow_pte_addr),
+					phys_val);
+
+	*(u64 *) shadow_pte_addr = val;
+}
 
-	return addr;
+/* do not transform the value to physical address when writing to H/W */
+static inline void write_final_pte(struct hl_ctx *ctx, u64 shadow_pte_addr,
+					u64 val)
+{
+	ctx->hdev->asic_funcs->write_pte(ctx->hdev,
+					get_phys_addr(ctx, shadow_pte_addr),
+					val);
+	*(u64 *) shadow_pte_addr = val;
 }
 
-static inline void clear_pte(struct hl_device *hdev, u64 pte_addr)
+/* clear the last and present bits */
+static inline void clear_pte(struct hl_ctx *ctx, u64 pte_addr)
 {
-	/* clear the last and present bits */
-	hdev->asic_funcs->write_pte(hdev, pte_addr, 0);
+	/* no need to transform the value to physical address */
+	write_final_pte(ctx, pte_addr, 0);
 }
 
 static inline void get_pte(struct hl_ctx *ctx, u64 hop_addr)
@@ -98,12 +163,6 @@ static inline int put_pte(struct hl_ctx *ctx, u64 hop_addr)
 	return num_of_ptes_left;
 }
 
-static inline u64 get_hop0_addr(struct hl_ctx *ctx)
-{
-	return ctx->hdev->asic_prop.mmu_pgt_addr +
-			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
-}
-
 static inline u64 get_hopN_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
 					u64 virt_addr, u64 mask, u64 shift)
 {
@@ -136,7 +195,7 @@ static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 vaddr)
 	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP4_MASK, HOP4_SHIFT);
 }
 
-static inline u64 get_next_hop_addr(u64 curr_pte)
+static inline u64 get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
 {
 	if (curr_pte & PAGE_PRESENT_MASK)
 		return curr_pte & PHYS_ADDR_MASK;
@@ -147,7 +206,7 @@ static inline u64 get_next_hop_addr(u64 curr_pte)
 static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
 						bool *is_new_hop)
 {
-	u64 hop_addr = get_next_hop_addr(curr_pte);
+	u64 hop_addr = get_next_hop_addr(ctx, curr_pte);
 
 	if (hop_addr == ULLONG_MAX) {
 		hop_addr = alloc_hop(ctx);
@@ -157,106 +216,30 @@ static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
 	return hop_addr;
 }
 
-/*
- * hl_mmu_init - init the mmu module
- *
- * @hdev: pointer to the habanalabs device structure
- *
- * This function does the following:
- * - Allocate max_asid zeroed hop0 pgts so no mapping is available
- * - Enable mmu in hw
- * - Invalidate the mmu cache
- * - Create a pool of pages for pgts
- * - Returns 0 on success
- *
- * This function depends on DMA QMAN to be working!
- */
-int hl_mmu_init(struct hl_device *hdev)
+/* translates shadow address inside hop to a physical address */
+static inline u64 get_phys_addr(struct hl_ctx *ctx, u64 shadow_addr)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	int rc;
+	u64 page_mask = (ctx->hdev->asic_prop.mmu_hop_table_size - 1);
+	u64 shadow_hop_addr = shadow_addr & ~page_mask;
+	u64 pte_offset = shadow_addr & page_mask;
+	u64 phys_hop_addr;
 
-	if (!hdev->mmu_enable)
-		return 0;
-
-	/* MMU HW init was already done in device hw_init() */
-
-	mutex_init(&hdev->mmu_cache_lock);
-
-	hdev->mmu_pgt_pool =
-			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
-
-	if (!hdev->mmu_pgt_pool) {
-		dev_err(hdev->dev, "Failed to create page gen pool\n");
-		rc = -ENOMEM;
-		goto err_pool_create;
-	}
-
-	rc = gen_pool_add(hdev->mmu_pgt_pool, prop->mmu_pgt_addr +
-			prop->mmu_hop0_tables_total_size,
-			prop->mmu_pgt_size - prop->mmu_hop0_tables_total_size,
-			-1);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to add memory to page gen pool\n");
-		goto err_pool_add;
-	}
-
-	return 0;
-
-err_pool_add:
-	gen_pool_destroy(hdev->mmu_pgt_pool);
-err_pool_create:
-	mutex_destroy(&hdev->mmu_cache_lock);
+	if (shadow_hop_addr != get_hop0_addr(ctx))
+		phys_hop_addr = get_pgt_info(ctx, shadow_hop_addr)->phys_addr;
+	else
+		phys_hop_addr = get_phys_hop0_addr(ctx);
 
-	return rc;
+	return phys_hop_addr + pte_offset;
 }
 
-/*
- * hl_mmu_fini - release the mmu module.
- *
- * @hdev: pointer to the habanalabs device structure
- *
- * This function does the following:
- * - Disable mmu in hw
- * - free the pgts pool
- *
- * All ctxs should be freed before calling this func
- */
-void hl_mmu_fini(struct hl_device *hdev)
-{
-	if (!hdev->mmu_enable)
-		return;
-
-	gen_pool_destroy(hdev->mmu_pgt_pool);
-
-	mutex_destroy(&hdev->mmu_cache_lock);
-
-	/* MMU HW fini will be done in device hw_fini() */
-}
-
-/**
- * hl_mmu_ctx_init() - initialize a context for using the MMU module.
- * @ctx: pointer to the context structure to initialize.
- *
- * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
- * page tables hops related to this context and an optional DRAM default page
- * mapping.
- * Return: 0 on success, non-zero otherwise.
- */
-int hl_mmu_ctx_init(struct hl_ctx *ctx)
+static int dram_default_mapping_init(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 num_of_hop3, total_hops, hop1_addr, hop2_addr, hop2_pte_addr,
-		hop3_pte_addr, pte_val;
+	u64 num_of_hop3, total_hops, hop0_addr, hop1_addr, hop2_addr,
+		hop2_pte_addr, hop3_pte_addr, pte_val;
 	int rc, i, j, hop3_allocated = 0;
 
-	if (!hdev->mmu_enable)
-		return 0;
-
-	mutex_init(&ctx->mmu_lock);
-	hash_init(ctx->mmu_hash);
-
 	if (!hdev->dram_supports_virtual_memory ||
 			!hdev->dram_default_page_mapping)
 		return 0;
@@ -269,10 +252,10 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 	total_hops = num_of_hop3 + 2;
 
 	ctx->dram_default_hops = kzalloc(HL_PTE_SIZE * total_hops,  GFP_KERNEL);
-	if (!ctx->dram_default_hops) {
-		rc = -ENOMEM;
-		goto alloc_err;
-	}
+	if (!ctx->dram_default_hops)
+		return -ENOMEM;
+
+	hop0_addr = get_hop0_addr(ctx);
 
 	hop1_addr = alloc_hop(ctx);
 	if (hop1_addr == ULLONG_MAX) {
@@ -304,17 +287,17 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 
 	/* need only pte 0 in hops 0 and 1 */
 	pte_val = (hop1_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
-	hdev->asic_funcs->write_pte(hdev, get_hop0_addr(ctx), pte_val);
+	write_pte(ctx, hop0_addr, pte_val);
 
 	pte_val = (hop2_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
-	hdev->asic_funcs->write_pte(hdev, hop1_addr, pte_val);
+	write_pte(ctx, hop1_addr, pte_val);
 	get_pte(ctx, hop1_addr);
 
 	hop2_pte_addr = hop2_addr;
 	for (i = 0 ; i < num_of_hop3 ; i++) {
 		pte_val = (ctx->dram_default_hops[i] & PTE_PHYS_ADDR_MASK) |
 				PAGE_PRESENT_MASK;
-		hdev->asic_funcs->write_pte(hdev, hop2_pte_addr, pte_val);
+		write_pte(ctx, hop2_pte_addr, pte_val);
 		get_pte(ctx, hop2_addr);
 		hop2_pte_addr += HL_PTE_SIZE;
 	}
@@ -325,33 +308,182 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 	for (i = 0 ; i < num_of_hop3 ; i++) {
 		hop3_pte_addr = ctx->dram_default_hops[i];
 		for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
-			hdev->asic_funcs->write_pte(hdev, hop3_pte_addr,
-					pte_val);
+			write_final_pte(ctx, hop3_pte_addr, pte_val);
 			get_pte(ctx, ctx->dram_default_hops[i]);
 			hop3_pte_addr += HL_PTE_SIZE;
 		}
 	}
 
-	/* flush all writes to reach PCI */
-	mb();
-	hdev->asic_funcs->read_pte(hdev, hop2_addr);
+	flush(ctx);
 
 	return 0;
 
 hop3_err:
 	for (i = 0 ; i < hop3_allocated ; i++)
 		free_hop(ctx, ctx->dram_default_hops[i]);
+
 	free_hop(ctx, hop2_addr);
 hop2_err:
 	free_hop(ctx, hop1_addr);
 hop1_err:
 	kfree(ctx->dram_default_hops);
-alloc_err:
-	mutex_destroy(&ctx->mmu_lock);
 
 	return rc;
 }
 
+static void dram_default_mapping_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 num_of_hop3, total_hops, hop0_addr, hop1_addr, hop2_addr,
+		hop2_pte_addr, hop3_pte_addr;
+	int i, j;
+
+	if (!hdev->dram_supports_virtual_memory ||
+			!hdev->dram_default_page_mapping)
+		return;
+
+	num_of_hop3 = prop->dram_size_for_default_page_mapping;
+	do_div(num_of_hop3, prop->dram_page_size);
+	do_div(num_of_hop3, PTE_ENTRIES_IN_HOP);
+
+	hop0_addr = get_hop0_addr(ctx);
+	/* add hop1 and hop2 */
+	total_hops = num_of_hop3 + 2;
+	hop1_addr = ctx->dram_default_hops[total_hops - 1];
+	hop2_addr = ctx->dram_default_hops[total_hops - 2];
+
+	for (i = 0 ; i < num_of_hop3 ; i++) {
+		hop3_pte_addr = ctx->dram_default_hops[i];
+		for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
+			clear_pte(ctx, hop3_pte_addr);
+			put_pte(ctx, ctx->dram_default_hops[i]);
+			hop3_pte_addr += HL_PTE_SIZE;
+		}
+	}
+
+	hop2_pte_addr = hop2_addr;
+	hop2_pte_addr = hop2_addr;
+	for (i = 0 ; i < num_of_hop3 ; i++) {
+		clear_pte(ctx, hop2_pte_addr);
+		put_pte(ctx, hop2_addr);
+		hop2_pte_addr += HL_PTE_SIZE;
+	}
+
+	clear_pte(ctx, hop1_addr);
+	put_pte(ctx, hop1_addr);
+	clear_pte(ctx, hop0_addr);
+
+	kfree(ctx->dram_default_hops);
+
+	flush(ctx);
+}
+
+/**
+ * hl_mmu_init() - initialize the MMU module.
+ * @hdev: habanalabs device structure.
+ *
+ * This function does the following:
+ * - Allocate max_asid zeroed hop0 pgts so no mapping is available.
+ * - Enable MMU in H/W.
+ * - Invalidate the MMU cache.
+ * - Create a pool of pages for pgt_infos.
+ *
+ * This function depends on DMA QMAN to be working!
+ *
+ * Return: 0 for success, non-zero for failure.
+ */
+int hl_mmu_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int rc;
+
+	if (!hdev->mmu_enable)
+		return 0;
+
+	/* MMU H/W init was already done in device hw_init() */
+
+	mutex_init(&hdev->mmu_cache_lock);
+
+	hdev->mmu_pgt_pool =
+			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
+
+	if (!hdev->mmu_pgt_pool) {
+		dev_err(hdev->dev, "Failed to create page gen pool\n");
+		rc = -ENOMEM;
+		goto err_pool_create;
+	}
+
+	rc = gen_pool_add(hdev->mmu_pgt_pool, prop->mmu_pgt_addr +
+			prop->mmu_hop0_tables_total_size,
+			prop->mmu_pgt_size - prop->mmu_hop0_tables_total_size,
+			-1);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to add memory to page gen pool\n");
+		goto err_pool_add;
+	}
+
+	hdev->mmu_shadow_hop0 = kcalloc(prop->max_asid,
+					prop->mmu_hop_table_size, GFP_KERNEL);
+	if (!hdev->mmu_shadow_hop0) {
+		rc = -ENOMEM;
+		goto err_pool_add;
+	}
+
+	return 0;
+
+err_pool_add:
+	gen_pool_destroy(hdev->mmu_pgt_pool);
+err_pool_create:
+	mutex_destroy(&hdev->mmu_cache_lock);
+
+	return rc;
+}
+
+/**
+ * hl_mmu_fini() - release the MMU module.
+ * @hdev: habanalabs device structure.
+ *
+ * This function does the following:
+ * - Disable MMU in H/W.
+ * - Free the pgt_infos pool.
+ *
+ * All contexts should be freed before calling this function.
+ */
+void hl_mmu_fini(struct hl_device *hdev)
+{
+	if (!hdev->mmu_enable)
+		return;
+
+	kfree(hdev->mmu_shadow_hop0);
+	gen_pool_destroy(hdev->mmu_pgt_pool);
+	mutex_destroy(&hdev->mmu_cache_lock);
+
+	/* MMU H/W fini will be done in device hw_fini() */
+}
+
+/**
+ * hl_mmu_ctx_init() - initialize a context for using the MMU module.
+ * @ctx: pointer to the context structure to initialize.
+ *
+ * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
+ * page tables hops related to this context.
+ * Return: 0 on success, non-zero otherwise.
+ */
+int hl_mmu_ctx_init(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (!hdev->mmu_enable)
+		return 0;
+
+	mutex_init(&ctx->mmu_lock);
+	hash_init(ctx->mmu_phys_hash);
+	hash_init(ctx->mmu_shadow_hash);
+
+	return dram_default_mapping_init(ctx);
+}
+
 /*
  * hl_mmu_ctx_fini - disable a ctx from using the mmu module
  *
@@ -365,63 +497,23 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pgt_info *pgt_info;
 	struct hlist_node *tmp;
-	u64 num_of_hop3, total_hops, hop1_addr, hop2_addr, hop2_pte_addr,
-		hop3_pte_addr;
-	int i, j;
+	int i;
 
-	if (!ctx->hdev->mmu_enable)
+	if (!hdev->mmu_enable)
 		return;
 
-	if (hdev->dram_supports_virtual_memory &&
-			hdev->dram_default_page_mapping) {
-
-		num_of_hop3 = prop->dram_size_for_default_page_mapping;
-		do_div(num_of_hop3, prop->dram_page_size);
-		do_div(num_of_hop3, PTE_ENTRIES_IN_HOP);
-
-		/* add hop1 and hop2 */
-		total_hops = num_of_hop3 + 2;
-		hop1_addr = ctx->dram_default_hops[total_hops - 1];
-		hop2_addr = ctx->dram_default_hops[total_hops - 2];
-
-		for (i = 0 ; i < num_of_hop3 ; i++) {
-			hop3_pte_addr = ctx->dram_default_hops[i];
-			for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
-				clear_pte(hdev, hop3_pte_addr);
-				put_pte(ctx, ctx->dram_default_hops[i]);
-				hop3_pte_addr += HL_PTE_SIZE;
-			}
-		}
+	dram_default_mapping_fini(ctx);
 
-		hop2_pte_addr = hop2_addr;
-		for (i = 0 ; i < num_of_hop3 ; i++) {
-			clear_pte(hdev, hop2_pte_addr);
-			put_pte(ctx, hop2_addr);
-			hop2_pte_addr += HL_PTE_SIZE;
-		}
-
-		clear_pte(hdev, hop1_addr);
-		put_pte(ctx, hop1_addr);
-		clear_pte(hdev, get_hop0_addr(ctx));
-
-		kfree(ctx->dram_default_hops);
-
-		/* flush all writes to reach PCI */
-		mb();
-		hdev->asic_funcs->read_pte(hdev, hop2_addr);
-	}
-
-	if (!hash_empty(ctx->mmu_hash))
+	if (!hash_empty(ctx->mmu_shadow_hash))
 		dev_err(hdev->dev, "ctx is freed while it has pgts in use\n");
 
-	hash_for_each_safe(ctx->mmu_hash, i, tmp, pgt_info, node) {
+	hash_for_each_safe(ctx->mmu_shadow_hash, i, tmp, pgt_info, node) {
 		dev_err(hdev->dev,
 			"pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
-			pgt_info->addr, ctx->asid, pgt_info->num_of_ptes);
-		free_hop(ctx, pgt_info->addr);
+			pgt_info->phys_addr, ctx->asid, pgt_info->num_of_ptes);
+		free_hop(ctx, pgt_info->shadow_addr);
 	}
 
 	mutex_destroy(&ctx->mmu_lock);
@@ -437,45 +529,43 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 		hop3_addr = 0, hop3_pte_addr = 0,
 		hop4_addr = 0, hop4_pte_addr = 0,
 		curr_pte;
-	int clear_hop3 = 1;
-	bool is_dram_addr, is_huge, is_dram_default_page_mapping;
+	bool is_dram_addr, is_huge, clear_hop3 = true;
 
 	is_dram_addr = hl_mem_area_inside_range(virt_addr, PAGE_SIZE_2MB,
 				prop->va_space_dram_start_address,
 				prop->va_space_dram_end_address);
 
 	hop0_addr = get_hop0_addr(ctx);
-
 	hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
 
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
+	curr_pte = *(u64 *) hop0_pte_addr;
 
-	hop1_addr = get_next_hop_addr(curr_pte);
+	hop1_addr = get_next_hop_addr(ctx, curr_pte);
 
 	if (hop1_addr == ULLONG_MAX)
 		goto not_mapped;
 
 	hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
 
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
+	curr_pte = *(u64 *) hop1_pte_addr;
 
-	hop2_addr = get_next_hop_addr(curr_pte);
+	hop2_addr = get_next_hop_addr(ctx, curr_pte);
 
 	if (hop2_addr == ULLONG_MAX)
 		goto not_mapped;
 
 	hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
 
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
+	curr_pte = *(u64 *) hop2_pte_addr;
 
-	hop3_addr = get_next_hop_addr(curr_pte);
+	hop3_addr = get_next_hop_addr(ctx, curr_pte);
 
 	if (hop3_addr == ULLONG_MAX)
 		goto not_mapped;
 
 	hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
 
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
+	curr_pte = *(u64 *) hop3_pte_addr;
 
 	is_huge = curr_pte & LAST_MASK;
 
@@ -485,27 +575,24 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 		return -EFAULT;
 	}
 
-	is_dram_default_page_mapping =
-			hdev->dram_default_page_mapping && is_dram_addr;
-
 	if (!is_huge) {
-		hop4_addr = get_next_hop_addr(curr_pte);
+		hop4_addr = get_next_hop_addr(ctx, curr_pte);
 
 		if (hop4_addr == ULLONG_MAX)
 			goto not_mapped;
 
 		hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
 
-		curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
+		curr_pte = *(u64 *) hop4_pte_addr;
 
-		clear_hop3 = 0;
+		clear_hop3 = false;
 	}
 
-	if (is_dram_default_page_mapping) {
-		u64 zero_pte = (prop->mmu_dram_default_page_addr &
+	if (hdev->dram_default_page_mapping && is_dram_addr) {
+		u64 default_pte = (prop->mmu_dram_default_page_addr &
 				PTE_PHYS_ADDR_MASK) | LAST_MASK |
 					PAGE_PRESENT_MASK;
-		if (curr_pte == zero_pte) {
+		if (curr_pte == default_pte) {
 			dev_err(hdev->dev,
 				"DRAM: hop3 PTE points to zero page, can't unmap, va: 0x%llx\n",
 					virt_addr);
@@ -519,40 +606,43 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 			goto not_mapped;
 		}
 
-		hdev->asic_funcs->write_pte(hdev, hop3_pte_addr, zero_pte);
+		write_final_pte(ctx, hop3_pte_addr, default_pte);
 		put_pte(ctx, hop3_addr);
 	} else {
 		if (!(curr_pte & PAGE_PRESENT_MASK))
 			goto not_mapped;
 
-		clear_pte(hdev, hop4_addr ? hop4_pte_addr : hop3_pte_addr);
+		if (hop4_addr)
+			clear_pte(ctx, hop4_pte_addr);
+		else
+			clear_pte(ctx, hop3_pte_addr);
 
 		if (hop4_addr && !put_pte(ctx, hop4_addr))
-			clear_hop3 = 1;
+			clear_hop3 = true;
 
 		if (!clear_hop3)
 			goto flush;
-		clear_pte(hdev, hop3_pte_addr);
+
+		clear_pte(ctx, hop3_pte_addr);
 
 		if (put_pte(ctx, hop3_addr))
 			goto flush;
-		clear_pte(hdev, hop2_pte_addr);
+
+		clear_pte(ctx, hop2_pte_addr);
 
 		if (put_pte(ctx, hop2_addr))
 			goto flush;
-		clear_pte(hdev, hop1_pte_addr);
+
+		clear_pte(ctx, hop1_pte_addr);
 
 		if (put_pte(ctx, hop1_addr))
 			goto flush;
-		clear_pte(hdev, hop0_pte_addr);
+
+		clear_pte(ctx, hop0_pte_addr);
 	}
 
 flush:
-	/* flush all writes from all cores to reach PCI */
-	mb();
-
-	hdev->asic_funcs->read_pte(hdev,
-				hop4_addr ? hop4_pte_addr : hop3_pte_addr);
+	flush(ctx);
 
 	return 0;
 
@@ -632,8 +722,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		hop4_addr = 0, hop4_pte_addr = 0,
 		curr_pte = 0;
 	bool hop1_new = false, hop2_new = false, hop3_new = false,
-		hop4_new = false, is_huge, is_dram_addr,
-		is_dram_default_page_mapping;
+		hop4_new = false, is_huge, is_dram_addr;
 	int rc = -ENOMEM;
 
 	/*
@@ -654,59 +743,46 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		return -EFAULT;
 	}
 
-	is_dram_default_page_mapping =
-			hdev->dram_default_page_mapping && is_dram_addr;
-
 	hop0_addr = get_hop0_addr(ctx);
-
 	hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
-
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
+	curr_pte = *(u64 *) hop0_pte_addr;
 
 	hop1_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop1_new);
-
 	if (hop1_addr == ULLONG_MAX)
 		goto err;
 
 	hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
-
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
+	curr_pte = *(u64 *) hop1_pte_addr;
 
 	hop2_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop2_new);
-
 	if (hop2_addr == ULLONG_MAX)
 		goto err;
 
 	hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
-
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
+	curr_pte = *(u64 *) hop2_pte_addr;
 
 	hop3_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop3_new);
-
 	if (hop3_addr == ULLONG_MAX)
 		goto err;
 
 	hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
-
-	curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
+	curr_pte = *(u64 *) hop3_pte_addr;
 
 	if (!is_huge) {
 		hop4_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop4_new);
-
 		if (hop4_addr == ULLONG_MAX)
 			goto err;
 
 		hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
-
-		curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
+		curr_pte = *(u64 *) hop4_pte_addr;
 	}
 
-	if (is_dram_default_page_mapping) {
-		u64 zero_pte = (prop->mmu_dram_default_page_addr &
+	if (hdev->dram_default_page_mapping && is_dram_addr) {
+		u64 default_pte = (prop->mmu_dram_default_page_addr &
 					PTE_PHYS_ADDR_MASK) | LAST_MASK |
 						PAGE_PRESENT_MASK;
 
-		if (curr_pte != zero_pte) {
+		if (curr_pte != default_pte) {
 			dev_err(hdev->dev,
 				"DRAM: mapping already exists for virt_addr 0x%llx\n",
 					virt_addr);
@@ -722,27 +798,21 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		}
 	} else if (curr_pte & PAGE_PRESENT_MASK) {
 		dev_err(hdev->dev,
-				"mapping already exists for virt_addr 0x%llx\n",
-					virt_addr);
+			"mapping already exists for virt_addr 0x%llx\n",
+				virt_addr);
 
 		dev_dbg(hdev->dev, "hop0 pte: 0x%llx (0x%llx)\n",
-				hdev->asic_funcs->read_pte(hdev, hop0_pte_addr),
-				hop0_pte_addr);
+			*(u64 *) hop0_pte_addr, hop0_pte_addr);
 		dev_dbg(hdev->dev, "hop1 pte: 0x%llx (0x%llx)\n",
-				hdev->asic_funcs->read_pte(hdev, hop1_pte_addr),
-				hop1_pte_addr);
+			*(u64 *) hop1_pte_addr, hop1_pte_addr);
 		dev_dbg(hdev->dev, "hop2 pte: 0x%llx (0x%llx)\n",
-				hdev->asic_funcs->read_pte(hdev, hop2_pte_addr),
-				hop2_pte_addr);
+			*(u64 *) hop2_pte_addr, hop2_pte_addr);
 		dev_dbg(hdev->dev, "hop3 pte: 0x%llx (0x%llx)\n",
-				hdev->asic_funcs->read_pte(hdev, hop3_pte_addr),
-				hop3_pte_addr);
+			*(u64 *) hop3_pte_addr, hop3_pte_addr);
 
 		if (!is_huge)
 			dev_dbg(hdev->dev, "hop4 pte: 0x%llx (0x%llx)\n",
-				hdev->asic_funcs->read_pte(hdev,
-							hop4_pte_addr),
-							hop4_pte_addr);
+				*(u64 *) hop4_pte_addr, hop4_pte_addr);
 
 		rc = -EINVAL;
 		goto err;
@@ -751,28 +821,26 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	curr_pte = (phys_addr & PTE_PHYS_ADDR_MASK) | LAST_MASK
 			| PAGE_PRESENT_MASK;
 
-	hdev->asic_funcs->write_pte(hdev,
-				is_huge ? hop3_pte_addr : hop4_pte_addr,
-				curr_pte);
+	if (is_huge)
+		write_final_pte(ctx, hop3_pte_addr, curr_pte);
+	else
+		write_final_pte(ctx, hop4_pte_addr, curr_pte);
 
 	if (hop1_new) {
-		curr_pte = (hop1_addr & PTE_PHYS_ADDR_MASK) |
-				PAGE_PRESENT_MASK;
-		ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop0_pte_addr,
-				curr_pte);
+		curr_pte =
+			(hop1_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+		write_pte(ctx, hop0_pte_addr, curr_pte);
 	}
 	if (hop2_new) {
-		curr_pte = (hop2_addr & PTE_PHYS_ADDR_MASK) |
-				PAGE_PRESENT_MASK;
-		ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop1_pte_addr,
-				curr_pte);
+		curr_pte =
+			(hop2_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+		write_pte(ctx, hop1_pte_addr, curr_pte);
 		get_pte(ctx, hop1_addr);
 	}
 	if (hop3_new) {
-		curr_pte = (hop3_addr & PTE_PHYS_ADDR_MASK) |
-				PAGE_PRESENT_MASK;
-		ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop2_pte_addr,
-				curr_pte);
+		curr_pte =
+			(hop3_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+		write_pte(ctx, hop2_pte_addr, curr_pte);
 		get_pte(ctx, hop2_addr);
 	}
 
@@ -780,8 +848,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		if (hop4_new) {
 			curr_pte = (hop4_addr & PTE_PHYS_ADDR_MASK) |
 					PAGE_PRESENT_MASK;
-			ctx->hdev->asic_funcs->write_pte(ctx->hdev,
-					hop3_pte_addr, curr_pte);
+			write_pte(ctx, hop3_pte_addr, curr_pte);
 			get_pte(ctx, hop3_addr);
 		}
 
@@ -790,11 +857,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		get_pte(ctx, hop3_addr);
 	}
 
-	/* flush all writes from all cores to reach PCI */
-	mb();
-
-	hdev->asic_funcs->read_pte(hdev,
-				is_huge ? hop3_pte_addr : hop4_pte_addr);
+	flush(ctx);
 
 	return 0;
 
-- 
2.17.1

