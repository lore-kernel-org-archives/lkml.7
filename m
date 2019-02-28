Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ECE218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjY8u7w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfB1Irq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:47:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54156 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfB1Iqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so8300739wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fo9INuawfePlCpVa5hjTeUEo8P+DCcErGYVSGu92Sb0=;
        b=LjY8u7w8uKOzxEo8l0VF2vLSOyQ02ZM7qS7n+a7kRJICsGay+hcl2kNKtpZHwX+kmh
         XejE2P8vAzAWXUoI8hdmtiiF4skbjpo6S1/JhLU+fU92qtg/ijX1jrYC8obYH3D0ppQH
         lCOoupYtYHqay+hWKoqncRNo6Onfw9g24z7abVdDVV9497B6Cm0q/eSei+Wc9aG5c4zH
         DQXptiJaAdWWLH2SzhHfxoR8Csikn1t4yctz395jxgeONFDPY0GB05Qsk8w2UyItIgNL
         x5B9AcReLHi7TM63rQA6+ir0ErFtr6qbA+buFYlfX63jwaHSDEEGQZ8Qq6YJtNkLWj/I
         eFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fo9INuawfePlCpVa5hjTeUEo8P+DCcErGYVSGu92Sb0=;
        b=TNA/d/FE74AeHitxUnS6/onK+XfIVr2QTOXHynTcfe3SGJRQpprUgMm6KHdyyYoAbM
         +RZ8/qIO+m8ouza1RzHDlCcxR1w3iaq4pJIwsnlIKRUGp25ElKrgQwnRw4TbtMlGLRwm
         uvo8xMxCsxChnkqSMAxo/YJjTzBKGDqdoOQ0Vb5z0DZtgpMWyYGe5G3E+xvbvL4CDOmK
         2UGhq+N7jxniJmJd9/VeC3SjRoRDfOe64LtCVv+1P+IifWgb/y/7SwzMRdA/cez/ZdPQ
         gzEQYkbumIF3tlrUzPUkVTUbMGfMUvG5DaUdSBJTjNbK2NskfTrIf0fz5jRS6039Zifz
         L3mw==
X-Gm-Message-State: APjAAAV432lKhDD0sPXLSlQKltfadJlqcHg5eC2XWHGPyluRGSNL2AR2
        Ly9JSjRuo9LABW37Q5WmYAw=
X-Google-Smtp-Source: APXvYqzCAvIYNWlOpSYYH4ODodpnZ0ciUTIYieqrvzqDSCCNPLVGzC+gBUAY0c49zqJ+LlqqpSmLGA==
X-Received: by 2002:a1c:9693:: with SMTP id y141mr2178001wmd.33.1551343596147;
        Thu, 28 Feb 2019 00:46:36 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:35 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 02/15] habanalabs: add MMU DRAM default page mapping
Date:   Thu, 28 Feb 2019 10:46:11 +0200
Message-Id: <20190228084624.25288-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch provides a workaround for a H/W bug in Goya, where access to
RAZWI from TPC can cause PCI completion timeout.

The WA is to use the device MMU to map any unmapped DRAM memory to a
default page in the DRAM. That way, the TPC will never reach RAZWI upon
accessing a bad address in the DRAM.

When a DRAM page is mapped by the user, its default mapping is
overwritten. Once that page is unmapped, the MMU driver will map that page
to the default page.

To help debugging, the driver will set the default page area to 0x99 on
device initialization.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c           | 190 +++++-------
 drivers/misc/habanalabs/goya/goyaP.h          |  29 +-
 drivers/misc/habanalabs/habanalabs.h          |  12 +-
 .../include/hw_ip/mmu/mmu_general.h           |   1 +
 drivers/misc/habanalabs/memory.c              |  12 +-
 drivers/misc/habanalabs/mmu.c                 | 285 +++++++++++++++---
 6 files changed, 361 insertions(+), 168 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 447d907bddf3..7c2edabe20bd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -304,6 +304,7 @@ static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
 static int goya_armcp_info_get(struct hl_device *hdev);
 static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
 static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
+static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
 static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
 					u64 phys_addr);
 
@@ -345,6 +346,7 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 						SRAM_USER_BASE_OFFSET;
 
 	prop->mmu_pgt_addr = MMU_PAGE_TABLES_ADDR;
+	prop->mmu_dram_default_page_addr = MMU_DRAM_DEFAULT_PAGE_ADDR;
 	if (hdev->pldm)
 		prop->mmu_pgt_size = 0x800000; /* 8MB */
 	else
@@ -359,6 +361,8 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->va_space_host_end_address = VA_HOST_SPACE_END;
 	prop->va_space_dram_start_address = VA_DDR_SPACE_START;
 	prop->va_space_dram_end_address = VA_DDR_SPACE_END;
+	prop->dram_size_for_default_page_mapping =
+			prop->va_space_dram_end_address;
 	prop->cfg_size = CFG_SIZE;
 	prop->max_asid = MAX_ASID;
 	prop->num_of_events = GOYA_ASYNC_EVENT_ID_SIZE;
@@ -816,6 +820,12 @@ static int goya_late_init(struct hl_device *hdev)
 		goto disable_pci_access;
 	}
 
+	rc = goya_mmu_set_dram_default_page(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to set DRAM default page\n");
+		goto disable_pci_access;
+	}
+
 	return 0;
 
 disable_pci_access:
@@ -2648,6 +2658,7 @@ static int goya_mmu_init(struct hl_device *hdev)
 		return 0;
 
 	hdev->dram_supports_virtual_memory = true;
+	hdev->dram_default_page_mapping = true;
 
 	for (i = 0 ; i < prop->max_asid ; i++) {
 		hop0_addr = prop->mmu_pgt_addr +
@@ -4303,98 +4314,6 @@ static void goya_update_eq_ci(struct hl_device *hdev, u32 val)
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, val);
 }
 
-static int goya_context_switch(struct hl_device *hdev, u32 asid)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct packet_lin_dma *clear_sram_pkt;
-	struct hl_cs_parser parser;
-	struct hl_cs_job *job;
-	u32 cb_size;
-	struct hl_cb *cb;
-	int rc;
-
-	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
-	if (!cb)
-		return -EFAULT;
-
-	clear_sram_pkt = (struct packet_lin_dma *)
-					(uintptr_t) cb->kernel_address;
-
-	memset(clear_sram_pkt, 0, sizeof(*clear_sram_pkt));
-	cb_size = sizeof(*clear_sram_pkt);
-
-	clear_sram_pkt->ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
-		(DMA_HOST_TO_SRAM << GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT) |
-		(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
-		(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
-		(1 << GOYA_PKT_CTL_RB_SHIFT) |
-		(1 << GOYA_PKT_CTL_MB_SHIFT));
-
-	clear_sram_pkt->src_addr = 0x7777777777777777ull;
-	clear_sram_pkt->dst_addr = prop->sram_base_address;
-	if (hdev->pldm)
-		clear_sram_pkt->tsize = 0x10000;
-	else
-		clear_sram_pkt->tsize = prop->sram_size;
-
-	job = hl_cs_allocate_job(hdev, true);
-	if (!job) {
-		dev_err(hdev->dev, "Failed to allocate a new job\n");
-		rc = -ENOMEM;
-		goto release_cb;
-	}
-
-	job->id = 0;
-	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
-	job->user_cb_size = cb_size;
-	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
-
-	hl_debugfs_add_job(hdev, job);
-
-	parser.ctx_id = HL_KERNEL_ASID_ID;
-	parser.cs_sequence = 0;
-	parser.job_id = job->id;
-	parser.hw_queue_id = job->hw_queue_id;
-	parser.job_userptr_list = &job->userptr_list;
-	parser.user_cb = job->user_cb;
-	parser.user_cb_size = job->user_cb_size;
-	parser.ext_queue = job->ext_queue;
-	parser.use_virt_addr = hdev->mmu_enable;
-
-	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to parse kernel CB during context switch\n");
-		goto free_job;
-	}
-
-	job->patched_cb = parser.patched_cb;
-	job->job_cb_size = parser.patched_cb_size;
-	job->patched_cb->cs_cnt++;
-
-	rc = goya_send_job_on_qman0(hdev, job);
-
-	/* no point in setting the asid in case of failure */
-	if (!rc)
-		goya_mmu_prepare(hdev, asid);
-
-	job->patched_cb->cs_cnt--;
-	hl_cb_put(job->patched_cb);
-
-free_job:
-	hl_userptr_delete_list(hdev, &job->userptr_list);
-	hl_debugfs_remove_job(hdev, job);
-	kfree(job);
-	cb->cs_cnt--;
-
-release_cb:
-	hl_cb_put(cb);
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
-
-	return rc;
-}
-
 static void goya_restore_phase_topology(struct hl_device *hdev)
 {
 	int i, num_of_sob_in_longs, num_of_mon_in_longs;
@@ -4864,41 +4783,37 @@ void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
 	return goya->events_stat;
 }
 
-static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
+static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
+				u64 val, bool is_dram)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct goya_device *goya = hdev->asic_specific;
-	struct packet_lin_dma *clear_pgt_range_pkt;
+	struct packet_lin_dma *lin_dma_pkt;
 	struct hl_cs_parser parser;
 	struct hl_cs_job *job;
 	u32 cb_size;
 	struct hl_cb *cb;
 	int rc;
 
-	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
-		return 0;
-
 	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
 	if (!cb)
 		return -EFAULT;
 
-	clear_pgt_range_pkt = (struct packet_lin_dma *)
-					(uintptr_t) cb->kernel_address;
+	lin_dma_pkt = (struct packet_lin_dma *) (uintptr_t) cb->kernel_address;
+
+	memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
+	cb_size = sizeof(*lin_dma_pkt);
 
-	memset(clear_pgt_range_pkt, 0, sizeof(*clear_pgt_range_pkt));
-	cb_size = sizeof(*clear_pgt_range_pkt);
+	lin_dma_pkt->ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
+				(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
+				(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
+				(1 << GOYA_PKT_CTL_RB_SHIFT) |
+				(1 << GOYA_PKT_CTL_MB_SHIFT));
 
-	clear_pgt_range_pkt->ctl =
-		((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
-		(DMA_HOST_TO_DRAM << GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT) |
-		(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
-		(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
-		(1 << GOYA_PKT_CTL_RB_SHIFT) |
-		(1 << GOYA_PKT_CTL_MB_SHIFT));
+	lin_dma_pkt->ctl |= (is_dram ? DMA_HOST_TO_DRAM : DMA_HOST_TO_SRAM) <<
+				GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 
-	clear_pgt_range_pkt->src_addr = 0;
-	clear_pgt_range_pkt->dst_addr = prop->mmu_pgt_addr;
-	clear_pgt_range_pkt->tsize = prop->mmu_pgt_size + MMU_CACHE_MNG_SIZE;
+	lin_dma_pkt->src_addr = val;
+	lin_dma_pkt->dst_addr = addr;
+	lin_dma_pkt->tsize = size;
 
 	job = hl_cs_allocate_job(hdev, true);
 	if (!job) {
@@ -4927,8 +4842,7 @@ static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 
 	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
 	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to parse kernel CB when clearing pgt\n");
+		dev_err(hdev->dev, "Failed to parse kernel CB\n");
 		goto free_job;
 	}
 
@@ -4954,6 +4868,52 @@ static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 	return rc;
 }
 
+static int goya_context_switch(struct hl_device *hdev, u32 asid)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 addr = prop->sram_base_address;
+	u32 size = hdev->pldm ? 0x10000 : prop->sram_size;
+	u64 val = 0x7777777777777777ull;
+	int rc;
+
+	rc = goya_memset_device_memory(hdev, addr, size, val, false);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to clear SRAM in context switch\n");
+		return rc;
+	}
+
+	goya_mmu_prepare(hdev, asid);
+
+	return 0;
+}
+
+static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct goya_device *goya = hdev->asic_specific;
+	u64 addr = prop->mmu_pgt_addr;
+	u32 size = prop->mmu_pgt_size + MMU_DRAM_DEFAULT_PAGE_SIZE +
+			MMU_CACHE_MNG_SIZE;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+		return 0;
+
+	return goya_memset_device_memory(hdev, addr, size, 0, true);
+}
+
+static int goya_mmu_set_dram_default_page(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u64 addr = hdev->asic_prop.mmu_dram_default_page_addr;
+	u32 size = MMU_DRAM_DEFAULT_PAGE_SIZE;
+	u64 val = 0x9999999999999999ull;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+		return 0;
+
+	return goya_memset_device_memory(hdev, addr, size, val, true);
+}
+
 static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 {
 	struct goya_device *goya = hdev->asic_specific;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 0631bc133cce..830551b6b062 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -56,18 +56,23 @@
 
 /* DRAM Memory Map */
 
-#define CPU_FW_IMAGE_SIZE	0x10000000	/* 256MB */
-#define MMU_PAGE_TABLES_SIZE	0x0E000000	/* 224MB */
-#define MMU_CACHE_MNG_SIZE	0x00001000	/* 4KB */
-#define CPU_PQ_PKT_SIZE		0x00001000	/* 4KB */
-#define CPU_PQ_DATA_SIZE	0x01FFE000	/* 32MB - 8KB  */
-
-#define CPU_FW_IMAGE_ADDR	DRAM_PHYS_BASE
-#define MMU_PAGE_TABLES_ADDR	(CPU_FW_IMAGE_ADDR + CPU_FW_IMAGE_SIZE)
-#define MMU_CACHE_MNG_ADDR	(MMU_PAGE_TABLES_ADDR + MMU_PAGE_TABLES_SIZE)
-#define CPU_PQ_PKT_ADDR		(MMU_CACHE_MNG_ADDR + MMU_CACHE_MNG_SIZE)
-#define CPU_PQ_DATA_ADDR	(CPU_PQ_PKT_ADDR + CPU_PQ_PKT_SIZE)
-#define DRAM_BASE_ADDR_USER	(CPU_PQ_DATA_ADDR + CPU_PQ_DATA_SIZE)
+#define CPU_FW_IMAGE_SIZE		0x10000000	/* 256MB */
+#define MMU_PAGE_TABLES_SIZE		0x0DE00000	/* 222MB */
+#define MMU_DRAM_DEFAULT_PAGE_SIZE	0x00200000	/* 2MB */
+#define MMU_CACHE_MNG_SIZE		0x00001000	/* 4KB */
+#define CPU_PQ_PKT_SIZE			0x00001000	/* 4KB */
+#define CPU_PQ_DATA_SIZE		0x01FFE000	/* 32MB - 8KB  */
+
+#define CPU_FW_IMAGE_ADDR		DRAM_PHYS_BASE
+#define MMU_PAGE_TABLES_ADDR		(CPU_FW_IMAGE_ADDR + CPU_FW_IMAGE_SIZE)
+#define MMU_DRAM_DEFAULT_PAGE_ADDR	(MMU_PAGE_TABLES_ADDR + \
+						MMU_PAGE_TABLES_SIZE)
+#define MMU_CACHE_MNG_ADDR		(MMU_DRAM_DEFAULT_PAGE_ADDR + \
+					MMU_DRAM_DEFAULT_PAGE_SIZE)
+#define CPU_PQ_PKT_ADDR			(MMU_CACHE_MNG_ADDR + \
+						MMU_CACHE_MNG_SIZE)
+#define CPU_PQ_DATA_ADDR		(CPU_PQ_PKT_ADDR + CPU_PQ_PKT_SIZE)
+#define DRAM_BASE_ADDR_USER		(CPU_PQ_DATA_ADDR + CPU_PQ_DATA_SIZE)
 
 #if (DRAM_BASE_ADDR_USER != 0x20000000)
 #error "KMD must reserve 512MB"
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index ee29971822c6..59b25c6fae00 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -143,7 +143,10 @@ enum hl_device_hw_state {
  *                               mapping DRAM memory.
  * @va_space_dram_end_address: end address of virtual memory range for
  *                             mapping DRAM memory.
+ * @dram_size_for_default_page_mapping: DRAM size needed to map to avoid page
+ *                                      fault.
  * @mmu_pgt_addr: base physical address in DRAM of MMU page tables.
+ * @mmu_dram_default_page_addr: DRAM default page physical address.
  * @mmu_pgt_size: MMU page tables total size.
  * @mmu_pte_size: PTE size in MMU page tables.
  * @mmu_hop_table_size: MMU hop table size.
@@ -182,7 +185,9 @@ struct asic_fixed_properties {
 	u64			va_space_host_end_address;
 	u64			va_space_dram_start_address;
 	u64			va_space_dram_end_address;
+	u64			dram_size_for_default_page_mapping;
 	u64			mmu_pgt_addr;
+	u64			mmu_dram_default_page_addr;
 	u32			mmu_pgt_size;
 	u32			mmu_pte_size;
 	u32			mmu_hop_table_size;
@@ -592,6 +597,8 @@ struct hl_va_range {
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
  *			to user so user could inquire about CS. It is used as
  *			index to cs_pending array.
+ * @dram_default_hops: array that holds all hops addresses needed for default
+ *                     DRAM mapping.
  * @cs_lock: spinlock to protect cs_sequence.
  * @dram_phys_mem: amount of used physical DRAM memory by this context.
  * @thread_restore_token: token to prevent multiple threads of the same context
@@ -615,6 +622,7 @@ struct hl_ctx {
 	struct mutex		mmu_lock;
 	struct list_head	debugfs_list;
 	u64			cs_sequence;
+	u64			*dram_default_hops;
 	spinlock_t		cs_lock;
 	atomic64_t		dram_phys_mem;
 	atomic_t		thread_restore_token;
@@ -1068,6 +1076,7 @@ struct hl_device_reset_work {
  * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
  *                   otherwise.
  * @dram_supports_virtual_memory: is MMU enabled towards DRAM.
+ * @dram_default_page_mapping: is DRAM default page mapping enabled.
  * @init_done: is the initialization of the device done.
  * @mmu_enable: is MMU enabled.
  */
@@ -1135,6 +1144,7 @@ struct hl_device {
 	u8				heartbeat;
 	u8				reset_on_lockup;
 	u8				dram_supports_virtual_memory;
+	u8				dram_default_page_mapping;
 	u8				init_done;
 
 	/* Parameters for bring-up */
@@ -1329,7 +1339,7 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr, u32 size,
 
 int hl_mmu_init(struct hl_device *hdev);
 void hl_mmu_fini(struct hl_device *hdev);
-void hl_mmu_ctx_init(struct hl_ctx *ctx);
+int hl_mmu_ctx_init(struct hl_ctx *ctx);
 void hl_mmu_ctx_fini(struct hl_ctx *ctx);
 int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size);
 int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size);
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index 1bc36aba1426..b680052ee3f0 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -36,6 +36,7 @@
 
 #define HL_PTE_SIZE			sizeof(u64)
 #define HOP_TABLE_SIZE			PAGE_SIZE_4KB
+#define PTE_ENTRIES_IN_HOP		(HOP_TABLE_SIZE / HL_PTE_SIZE)
 #define HOP0_TABLES_TOTAL_SIZE		(HOP_TABLE_SIZE * MAX_ASID)
 
 #define MMU_HOP0_PA43_12_SHIFT		12
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 660cf67258fd..3a12fd1a5274 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -925,8 +925,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto map_err;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache_range(hdev, false, ctx->asid,
-			ret_vaddr, phys_pg_pack->total_size);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -1050,8 +1049,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 			dev_warn_ratelimited(hdev->dev,
 				"unmap failed for vaddr: 0x%llx\n", next_vaddr);
 
-	hdev->asic_funcs->mmu_invalidate_cache_range(hdev, true, ctx->asid,
-			vaddr, phys_pg_pack->total_size);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
 
 	mutex_unlock(&ctx->mmu_lock);
 
@@ -1455,7 +1453,11 @@ static int hl_vm_ctx_init_with_ranges(struct hl_ctx *ctx, u64 host_range_start,
 	struct hl_device *hdev = ctx->hdev;
 	int rc;
 
-	hl_mmu_ctx_init(ctx);
+	rc = hl_mmu_ctx_init(ctx);
+	if (rc) {
+		dev_err(hdev->dev, "failed to init context %d\n", ctx->asid);
+		return rc;
+	}
 
 	mutex_init(&ctx->mem_hash_lock);
 	hash_init(ctx->mem_hash);
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 79c70d92e74b..a7187f9a5948 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -151,7 +151,7 @@ static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
 
 	if (hop_addr == ULLONG_MAX) {
 		hop_addr = alloc_hop(ctx);
-		*is_new_hop = true;
+		*is_new_hop = (hop_addr != ULLONG_MAX);
 	}
 
 	return hop_addr;
@@ -234,22 +234,122 @@ void hl_mmu_fini(struct hl_device *hdev)
 	/* MMU HW fini will be done in device hw_fini() */
 }
 
-/*
- * hl_mmu_ctx_init - init a ctx for using the mmu module
- *
- * @ctx: pointer to the context structure
+/**
+ * hl_mmu_ctx_init() - initialize a context for using the MMU module.
+ * @ctx: pointer to the context structure to initialize.
  *
- * This function does the following:
- * - Init a mutex to protect the concurrent mapping flow
- * - Init a hash to hold all pgts related to this ctx
+ * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
+ * page tables hops related to this context and an optional DRAM default page
+ * mapping.
+ * Return: 0 on success, non-zero otherwise.
  */
-void hl_mmu_ctx_init(struct hl_ctx *ctx)
+int hl_mmu_ctx_init(struct hl_ctx *ctx)
 {
-	if (!ctx->hdev->mmu_enable)
-		return;
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 num_of_hop3, total_hops, hop1_addr, hop2_addr, hop2_pte_addr,
+		hop3_pte_addr, pte_val;
+	int rc, i, j, hop3_allocated = 0;
+
+	if (!hdev->mmu_enable)
+		return 0;
 
 	mutex_init(&ctx->mmu_lock);
 	hash_init(ctx->mmu_hash);
+
+	if (!hdev->dram_supports_virtual_memory ||
+			!hdev->dram_default_page_mapping)
+		return 0;
+
+	num_of_hop3 = (prop->dram_size_for_default_page_mapping /
+			prop->dram_page_size) /
+			PTE_ENTRIES_IN_HOP;
+
+	/* add hop1 and hop2 */
+	total_hops = num_of_hop3 + 2;
+
+	ctx->dram_default_hops = kzalloc(HL_PTE_SIZE * total_hops,  GFP_KERNEL);
+	if (!ctx->dram_default_hops) {
+		rc = -ENOMEM;
+		goto alloc_err;
+	}
+
+	hop1_addr = alloc_hop(ctx);
+	if (hop1_addr == ULLONG_MAX) {
+		dev_err(hdev->dev, "failed to alloc hop 1\n");
+		rc = -ENOMEM;
+		goto hop1_err;
+	}
+
+	ctx->dram_default_hops[total_hops - 1] = hop1_addr;
+
+	hop2_addr = alloc_hop(ctx);
+	if (hop2_addr == ULLONG_MAX) {
+		dev_err(hdev->dev, "failed to alloc hop 2\n");
+		rc = -ENOMEM;
+		goto hop2_err;
+	}
+
+	ctx->dram_default_hops[total_hops - 2] = hop2_addr;
+
+	for (i = 0 ; i < num_of_hop3 ; i++) {
+		ctx->dram_default_hops[i] = alloc_hop(ctx);
+		if (ctx->dram_default_hops[i] == ULLONG_MAX) {
+			dev_err(hdev->dev, "failed to alloc hop 3, i: %d\n", i);
+			rc = -ENOMEM;
+			goto hop3_err;
+		}
+		hop3_allocated++;
+	}
+
+	/* need only pte 0 in hops 0 and 1 */
+	pte_val = (hop1_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+	hdev->asic_funcs->write_pte(hdev, get_hop0_addr(ctx), pte_val);
+
+	pte_val = (hop2_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+	hdev->asic_funcs->write_pte(hdev, hop1_addr, pte_val);
+	get_pte(ctx, hop1_addr);
+
+	hop2_pte_addr = hop2_addr;
+	for (i = 0 ; i < num_of_hop3 ; i++) {
+		pte_val = (ctx->dram_default_hops[i] & PTE_PHYS_ADDR_MASK) |
+				PAGE_PRESENT_MASK;
+		hdev->asic_funcs->write_pte(hdev, hop2_pte_addr, pte_val);
+		get_pte(ctx, hop2_addr);
+		hop2_pte_addr += HL_PTE_SIZE;
+	}
+
+	pte_val = (prop->mmu_dram_default_page_addr & PTE_PHYS_ADDR_MASK) |
+			LAST_MASK | PAGE_PRESENT_MASK;
+
+	for (i = 0 ; i < num_of_hop3 ; i++) {
+		hop3_pte_addr = ctx->dram_default_hops[i];
+		for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
+			hdev->asic_funcs->write_pte(hdev, hop3_pte_addr,
+					pte_val);
+			get_pte(ctx, ctx->dram_default_hops[i]);
+			hop3_pte_addr += HL_PTE_SIZE;
+		}
+	}
+
+	/* flush all writes to reach PCI */
+	mb();
+	hdev->asic_funcs->read_pte(hdev, hop2_addr);
+
+	return 0;
+
+hop3_err:
+	for (i = 0 ; i < hop3_allocated ; i++)
+		free_hop(ctx, ctx->dram_default_hops[i]);
+	free_hop(ctx, hop2_addr);
+hop2_err:
+	free_hop(ctx, hop1_addr);
+hop1_err:
+	kfree(ctx->dram_default_hops);
+alloc_err:
+	mutex_destroy(&ctx->mmu_lock);
+
+	return rc;
 }
 
 /*
@@ -260,22 +360,65 @@ void hl_mmu_ctx_init(struct hl_ctx *ctx)
  * This function does the following:
  * - Free any pgts which were not freed yet
  * - Free the mutex
+ * - Free DRAM default page mapping hops
  */
 void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 {
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pgt_info *pgt_info;
 	struct hlist_node *tmp;
-	int i;
+	u64 num_of_hop3, total_hops, hop1_addr, hop2_addr, hop2_pte_addr,
+		hop3_pte_addr;
+	int i, j;
 
 	if (!ctx->hdev->mmu_enable)
 		return;
 
+	if (hdev->dram_supports_virtual_memory &&
+			hdev->dram_default_page_mapping) {
+
+		num_of_hop3 = (prop->dram_size_for_default_page_mapping /
+				prop->dram_page_size) /
+				PTE_ENTRIES_IN_HOP;
+
+		/* add hop1 and hop2 */
+		total_hops = num_of_hop3 + 2;
+		hop1_addr = ctx->dram_default_hops[total_hops - 1];
+		hop2_addr = ctx->dram_default_hops[total_hops - 2];
+
+		for (i = 0 ; i < num_of_hop3 ; i++) {
+			hop3_pte_addr = ctx->dram_default_hops[i];
+			for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
+				clear_pte(hdev, hop3_pte_addr);
+				put_pte(ctx, ctx->dram_default_hops[i]);
+				hop3_pte_addr += HL_PTE_SIZE;
+			}
+		}
+
+		hop2_pte_addr = hop2_addr;
+		for (i = 0 ; i < num_of_hop3 ; i++) {
+			clear_pte(hdev, hop2_pte_addr);
+			put_pte(ctx, hop2_addr);
+			hop2_pte_addr += HL_PTE_SIZE;
+		}
+
+		clear_pte(hdev, hop1_addr);
+		put_pte(ctx, hop1_addr);
+		clear_pte(hdev, get_hop0_addr(ctx));
+
+		kfree(ctx->dram_default_hops);
+
+		/* flush all writes to reach PCI */
+		mb();
+		hdev->asic_funcs->read_pte(hdev, hop2_addr);
+	}
+
 	if (!hash_empty(ctx->mmu_hash))
-		dev_err(ctx->hdev->dev,
-				"ctx is freed while it has pgts in use\n");
+		dev_err(hdev->dev, "ctx is freed while it has pgts in use\n");
 
 	hash_for_each_safe(ctx->mmu_hash, i, tmp, pgt_info, node) {
-		dev_err(ctx->hdev->dev,
+		dev_err(hdev->dev,
 			"pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
 			pgt_info->addr, ctx->asid, pgt_info->num_of_ptes);
 		free_hop(ctx, pgt_info->addr);
@@ -287,6 +430,7 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 {
 	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 hop0_addr = 0, hop0_pte_addr = 0,
 		hop1_addr = 0, hop1_pte_addr = 0,
 		hop2_addr = 0, hop2_pte_addr = 0,
@@ -294,6 +438,11 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 		hop4_addr = 0, hop4_pte_addr = 0,
 		curr_pte;
 	int clear_hop3 = 1;
+	bool is_dram_addr, is_huge, is_dram_default_page_mapping;
+
+	is_dram_addr = hl_mem_area_inside_range(virt_addr, PAGE_SIZE_2MB,
+				prop->va_space_dram_start_address,
+				prop->va_space_dram_end_address);
 
 	hop0_addr = get_hop0_addr(ctx);
 
@@ -328,7 +477,18 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 
 	curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
 
-	if (!(curr_pte & LAST_MASK)) {
+	is_huge = curr_pte & LAST_MASK;
+
+	if (is_dram_addr && !is_huge) {
+		dev_err(hdev->dev,
+				"DRAM unmapping should use huge pages only\n");
+		return -EFAULT;
+	}
+
+	is_dram_default_page_mapping =
+			hdev->dram_default_page_mapping && is_dram_addr;
+
+	if (!is_huge) {
 		hop4_addr = get_next_hop_addr(curr_pte);
 
 		if (hop4_addr == ULLONG_MAX)
@@ -341,29 +501,51 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
 		clear_hop3 = 0;
 	}
 
-	if (!(curr_pte & PAGE_PRESENT_MASK))
-		goto not_mapped;
+	if (is_dram_default_page_mapping) {
+		u64 zero_pte = (prop->mmu_dram_default_page_addr &
+				PTE_PHYS_ADDR_MASK) | LAST_MASK |
+					PAGE_PRESENT_MASK;
+		if (curr_pte == zero_pte) {
+			dev_err(hdev->dev,
+				"DRAM: hop3 PTE points to zero page, can't unmap, va: 0x%llx\n",
+					virt_addr);
+			goto not_mapped;
+		}
+
+		if (!(curr_pte & PAGE_PRESENT_MASK)) {
+			dev_err(hdev->dev,
+				"DRAM: hop3 PTE is cleared! can't unmap, va: 0x%llx\n",
+					virt_addr);
+			goto not_mapped;
+		}
 
-	clear_pte(hdev, hop4_addr ? hop4_pte_addr : hop3_pte_addr);
+		hdev->asic_funcs->write_pte(hdev, hop3_pte_addr, zero_pte);
+		put_pte(ctx, hop3_addr);
+	} else {
+		if (!(curr_pte & PAGE_PRESENT_MASK))
+			goto not_mapped;
+
+		clear_pte(hdev, hop4_addr ? hop4_pte_addr : hop3_pte_addr);
 
-	if (hop4_addr && !put_pte(ctx, hop4_addr))
-		clear_hop3 = 1;
+		if (hop4_addr && !put_pte(ctx, hop4_addr))
+			clear_hop3 = 1;
 
-	if (!clear_hop3)
-		goto flush;
-	clear_pte(hdev, hop3_pte_addr);
+		if (!clear_hop3)
+			goto flush;
+		clear_pte(hdev, hop3_pte_addr);
 
-	if (put_pte(ctx, hop3_addr))
-		goto flush;
-	clear_pte(hdev, hop2_pte_addr);
+		if (put_pte(ctx, hop3_addr))
+			goto flush;
+		clear_pte(hdev, hop2_pte_addr);
 
-	if (put_pte(ctx, hop2_addr))
-		goto flush;
-	clear_pte(hdev, hop1_pte_addr);
+		if (put_pte(ctx, hop2_addr))
+			goto flush;
+		clear_pte(hdev, hop1_pte_addr);
 
-	if (put_pte(ctx, hop1_addr))
-		goto flush;
-	clear_pte(hdev, hop0_pte_addr);
+		if (put_pte(ctx, hop1_addr))
+			goto flush;
+		clear_pte(hdev, hop0_pte_addr);
+	}
 
 flush:
 	/* flush all writes from all cores to reach PCI */
@@ -442,6 +624,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		u32 page_size)
 {
 	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 hop0_addr = 0, hop0_pte_addr = 0,
 		hop1_addr = 0, hop1_pte_addr = 0,
 		hop2_addr = 0, hop2_pte_addr = 0,
@@ -449,7 +632,8 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		hop4_addr = 0, hop4_pte_addr = 0,
 		curr_pte = 0;
 	bool hop1_new = false, hop2_new = false, hop3_new = false,
-		hop4_new = false, is_huge;
+		hop4_new = false, is_huge, is_dram_addr,
+		is_dram_default_page_mapping;
 	int rc = -ENOMEM;
 
 	/*
@@ -461,6 +645,18 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	 */
 	is_huge = page_size == PAGE_SIZE_2MB;
 
+	is_dram_addr = hl_mem_area_inside_range(virt_addr, page_size,
+				prop->va_space_dram_start_address,
+				prop->va_space_dram_end_address);
+
+	if (is_dram_addr && !is_huge) {
+		dev_err(hdev->dev, "DRAM mapping should use huge pages only\n");
+		return -EFAULT;
+	}
+
+	is_dram_default_page_mapping =
+			hdev->dram_default_page_mapping && is_dram_addr;
+
 	hop0_addr = get_hop0_addr(ctx);
 
 	hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
@@ -505,7 +701,26 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
 	}
 
-	if (curr_pte & PAGE_PRESENT_MASK) {
+	if (is_dram_default_page_mapping) {
+		u64 zero_pte = (prop->mmu_dram_default_page_addr &
+					PTE_PHYS_ADDR_MASK) | LAST_MASK |
+						PAGE_PRESENT_MASK;
+
+		if (curr_pte != zero_pte) {
+			dev_err(hdev->dev,
+				"DRAM: mapping already exists for virt_addr 0x%llx\n",
+					virt_addr);
+			rc = EINVAL;
+			goto err;
+		}
+
+		if (hop1_new || hop2_new || hop3_new || hop4_new) {
+			dev_err(hdev->dev,
+				"DRAM mapping should not allocate more hops\n");
+			rc = -EFAULT;
+			goto err;
+		}
+	} else if (curr_pte & PAGE_PRESENT_MASK) {
 		dev_err(hdev->dev,
 				"mapping already exists for virt_addr 0x%llx\n",
 					virt_addr);
-- 
2.17.1

