Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84505C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F6824125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb/RVOGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLNU6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:58:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54590 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 15:58:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so2470857wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 12:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vMcnWgSW4WyNDrScAFvow/WT5DfXkoblq35RZJ7NaOE=;
        b=Xb/RVOGMJUVXYC1yfTaHEKCzugH6VFnNw5g+yujgwxpFwtlgVNESmUMPVaCHPtTxmv
         ndJoli9+lxs767KhVXxpIPPLaQ+PcXSvEkOiXthb7eFzDJlydkzSKV+/GUy6Z6C2ECR2
         9DYe49qgMHzMTUX0tzIuhHPeJ/QrOruwZbnFEGwjswmQrl1FhffHlnTv/S+7zASsBeob
         kR4XIjOuaHRVKukIV1pNhOs2EXeSArvA5jOEX7smcQpbR4Z3J0ypeH6aqRXUvtsfj78F
         NWUYBMEPdHpEN83r+t625Tqkcwse062KAJXs8nsbWN5KlvlQuMEmyJOPSbVMl8s7m9Np
         QHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vMcnWgSW4WyNDrScAFvow/WT5DfXkoblq35RZJ7NaOE=;
        b=evncEo15fJz+lg7DRrmR+/z7n5Uy5LF4IKX5oKQibE6jH8GW9eMvUqO5DXwxptn7EJ
         HzexzBsVujYA71XeZUhAKhuqkfAooXyg88URuXqwqkPvDQNgL3NWphPJP42EbqihohDK
         KchJL8nK0DTk89pDmZ1c2bHfpiThWnOYBEbWmhwRCYP1o/x0Z7YSpN8gsYa933HpNcOz
         yei43KZEbjTpDB9f6s5+g/VeCGkAlaYTuu+74wRk3TIvHmUd7erwLkTAY/2qLj8OUon4
         /ei1si8fkQ7PU1RamgAlgC9B5QNcoD30aIwsxueUjbDlPR9HQeBbW+9L6tuKEf/XLmd0
         jpOg==
X-Gm-Message-State: APjAAAWa6D/raZ3gzBwaCSslSAbYh8VdDsU4BrgLA4zMmx00B6L8vVQX
        RObqZB95uTq9z/+vupyM7P6xNSOIaTE=
X-Google-Smtp-Source: APXvYqybg/XnYIZ3pBMAf+OHTZbuRAR+yXkHAkAAoO0a3Vrr2ByAIAEe0ugWVMUIsgyjg+5RZ0rn5w==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr21299990wme.108.1576357080580;
        Sat, 14 Dec 2019 12:58:00 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j12sm15955607wrw.54.2019.12.14.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 12:57:59 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: flush only at the end of the map/unmap
Date:   Sat, 14 Dec 2019 22:57:57 +0200
Message-Id: <20191214205757.25919-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Piskorski <ppiskorski@habana.ai>

Optimize hl_mmu_map and hl_mmu_unmap by not calling flush(ctx)
within per-page loop.

Signed-off-by: Pawel Piskorski <ppiskorski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 20 +++++++------
 drivers/misc/habanalabs/habanalabs.h |  6 ++--
 drivers/misc/habanalabs/memory.c     |  9 ++++--
 drivers/misc/habanalabs/mmu.c        | 42 ++++++++++++++++++----------
 4 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c8d16aa4382c..08d4bef86e23 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4737,7 +4737,8 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 
 	for (off = 0 ; off < CPU_FW_IMAGE_SIZE ; off += PAGE_SIZE_2MB) {
 		rc = hl_mmu_map(hdev->kernel_ctx, prop->dram_base_address + off,
-				prop->dram_base_address + off, PAGE_SIZE_2MB);
+				prop->dram_base_address + off, PAGE_SIZE_2MB,
+				(off + PAGE_SIZE_2MB) == CPU_FW_IMAGE_SIZE);
 		if (rc) {
 			dev_err(hdev->dev, "Map failed for address 0x%llx\n",
 				prop->dram_base_address + off);
@@ -4747,7 +4748,7 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 
 	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
 		rc = hl_mmu_map(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
-			hdev->cpu_accessible_dma_address, PAGE_SIZE_2MB);
+			hdev->cpu_accessible_dma_address, PAGE_SIZE_2MB, true);
 
 		if (rc) {
 			dev_err(hdev->dev,
@@ -4760,7 +4761,7 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 			rc = hl_mmu_map(hdev->kernel_ctx,
 				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
 				hdev->cpu_accessible_dma_address + cpu_off,
-				PAGE_SIZE_4KB);
+				PAGE_SIZE_4KB, true);
 			if (rc) {
 				dev_err(hdev->dev,
 					"Map failed for CPU accessible memory\n");
@@ -4786,14 +4787,15 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 	for (; cpu_off >= 0 ; cpu_off -= PAGE_SIZE_4KB)
 		if (hl_mmu_unmap(hdev->kernel_ctx,
 				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
-				PAGE_SIZE_4KB))
+				PAGE_SIZE_4KB, true))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap address 0x%llx\n",
 				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off);
 unmap:
 	for (; off >= 0 ; off -= PAGE_SIZE_2MB)
 		if (hl_mmu_unmap(hdev->kernel_ctx,
-				prop->dram_base_address + off, PAGE_SIZE_2MB))
+				prop->dram_base_address + off, PAGE_SIZE_2MB,
+				true))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap address 0x%llx\n",
 				prop->dram_base_address + off);
@@ -4818,14 +4820,15 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev)
 
 	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
 		if (hl_mmu_unmap(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
-				PAGE_SIZE_2MB))
+				PAGE_SIZE_2MB, true))
 			dev_warn(hdev->dev,
 				"Failed to unmap CPU accessible memory\n");
 	} else {
 		for (cpu_off = 0 ; cpu_off < SZ_2M ; cpu_off += PAGE_SIZE_4KB)
 			if (hl_mmu_unmap(hdev->kernel_ctx,
 					VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
-					PAGE_SIZE_4KB))
+					PAGE_SIZE_4KB,
+					(cpu_off + PAGE_SIZE_4KB) >= SZ_2M))
 				dev_warn_ratelimited(hdev->dev,
 					"failed to unmap address 0x%llx\n",
 					VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off);
@@ -4833,7 +4836,8 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev)
 
 	for (off = 0 ; off < CPU_FW_IMAGE_SIZE ; off += PAGE_SIZE_2MB)
 		if (hl_mmu_unmap(hdev->kernel_ctx,
-				prop->dram_base_address + off, PAGE_SIZE_2MB))
+				prop->dram_base_address + off, PAGE_SIZE_2MB,
+				(off + PAGE_SIZE_2MB) >= CPU_FW_IMAGE_SIZE))
 			dev_warn_ratelimited(hdev->dev,
 					"Failed to unmap address 0x%llx\n",
 					prop->dram_base_address + off);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 00c949f4ccd1..df34227dea31 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1573,8 +1573,10 @@ int hl_mmu_init(struct hl_device *hdev);
 void hl_mmu_fini(struct hl_device *hdev);
 int hl_mmu_ctx_init(struct hl_ctx *ctx);
 void hl_mmu_ctx_fini(struct hl_ctx *ctx);
-int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size);
-int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size);
+int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
+		u32 page_size, bool flush_pte);
+int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
+		bool flush_pte);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 6c72cb4eff54..b612b1ad0aac 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -747,7 +747,8 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
 		paddr = phys_pg_pack->pages[i];
 
-		rc = hl_mmu_map(ctx, next_vaddr, paddr, page_size);
+		rc = hl_mmu_map(ctx, next_vaddr, paddr, page_size,
+				(i + 1) == phys_pg_pack->npages);
 		if (rc) {
 			dev_err(hdev->dev,
 				"map failed for handle %u, npages: %llu, mapped: %llu",
@@ -765,7 +766,8 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 err:
 	next_vaddr = vaddr;
 	for (i = 0 ; i < mapped_pg_cnt ; i++) {
-		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
+		if (hl_mmu_unmap(ctx, next_vaddr, page_size,
+					(i + 1) == mapped_pg_cnt))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap handle %u, va: 0x%llx, pa: 0x%llx, page size: %u\n",
 					phys_pg_pack->handle, next_vaddr,
@@ -794,7 +796,8 @@ static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	next_vaddr = vaddr;
 
 	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size) {
-		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
+		if (hl_mmu_unmap(ctx, next_vaddr, page_size,
+				       (i + 1) == phys_pg_pack->npages))
 			dev_warn_ratelimited(hdev->dev,
 			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
 
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 6262b26e2086..006eee47909d 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -637,29 +637,27 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_addr)
 			clear_hop3 = true;
 
 		if (!clear_hop3)
-			goto flush;
+			goto mapped;
 
 		clear_pte(ctx, hop3_pte_addr);
 
 		if (put_pte(ctx, hop3_addr))
-			goto flush;
+			goto mapped;
 
 		clear_pte(ctx, hop2_pte_addr);
 
 		if (put_pte(ctx, hop2_addr))
-			goto flush;
+			goto mapped;
 
 		clear_pte(ctx, hop1_pte_addr);
 
 		if (put_pte(ctx, hop1_addr))
-			goto flush;
+			goto mapped;
 
 		clear_pte(ctx, hop0_pte_addr);
 	}
 
-flush:
-	flush(ctx);
-
+mapped:
 	return 0;
 
 not_mapped:
@@ -675,6 +673,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_addr)
  * @ctx: pointer to the context structure
  * @virt_addr: virt addr to map from
  * @page_size: size of the page to unmap
+ * @flush_pte: whether to do a PCI flush
  *
  * This function does the following:
  * - Check that the virt addr is mapped
@@ -685,15 +684,19 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_addr)
  * changes the MMU hash, it must be protected by a lock.
  * However, because it maps only a single page, the lock should be implemented
  * in a higher level in order to protect the entire mapping of the memory area
+ *
+ * For optimization reasons PCI flush may be requested once after unmapping of
+ * large area.
  */
-int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size)
+int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
+		bool flush_pte)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_mmu_properties *mmu_prop;
 	u64 real_virt_addr;
 	u32 real_page_size, npages;
-	int i, rc;
+	int i, rc = 0;
 	bool is_dram_addr;
 
 	if (!hdev->mmu_enable)
@@ -729,12 +732,15 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size)
 	for (i = 0 ; i < npages ; i++) {
 		rc = _hl_mmu_unmap(ctx, real_virt_addr, is_dram_addr);
 		if (rc)
-			return rc;
+			break;
 
 		real_virt_addr += real_page_size;
 	}
 
-	return 0;
+	if (flush_pte)
+		flush(ctx);
+
+	return rc;
 }
 
 static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
@@ -885,8 +891,6 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		get_pte(ctx, hop3_addr);
 	}
 
-	flush(ctx);
-
 	return 0;
 
 err:
@@ -909,6 +913,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
  * @virt_addr: virt addr to map from
  * @phys_addr: phys addr to map to
  * @page_size: physical page size
+ * @flush_pte: whether to do a PCI flush
  *
  * This function does the following:
  * - Check that the virt addr is not mapped
@@ -919,8 +924,12 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
  * changes the MMU hash, it must be protected by a lock.
  * However, because it maps only a single page, the lock should be implemented
  * in a higher level in order to protect the entire mapping of the memory area
+ *
+ * For optimization reasons PCI flush may be requested once after mapping of
+ * large area.
  */
-int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
+int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
+		bool flush_pte)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -976,6 +985,9 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
 		mapped_cnt++;
 	}
 
+	if (flush_pte)
+		flush(ctx);
+
 	return 0;
 
 err:
@@ -988,6 +1000,8 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
 		real_virt_addr += real_page_size;
 	}
 
+	flush(ctx);
+
 	return rc;
 }
 
-- 
2.17.1

