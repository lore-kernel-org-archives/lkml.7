Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD082C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE352075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwGbFvLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfDDTAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:00:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34809 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:00:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so5157747wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=57iQx0vNulZ5O+l9xPWRsbIZEsnbGWbMcL3xP8MD5q0=;
        b=FwGbFvLBr+hcBSKmdhch8O8/yRrxR75+wA37Doa5pxSGYOQdNhuGjOP2aV1NkmXa6m
         k3xR5nSWScLXQBfWLzFXB1fG0ghNTY7ot97q8AUsQasjnzKQ+GY8Y9FsXCAxM28+EAG7
         xeOg/KzuHj9IaPK3cUbSli1NuMh50omzfF6v77pFB5LTMJIE2h0i8pxHg2vCFVV3HU19
         +yiDJNfmrmJAzpkuoYvd4fFzIXfXf265WcA2hJbv1VLRH5issApwhnVv8o40mb37smEm
         /yMq3hQKVBRIFiMzcVu0m0lDSjfUzLtXE20IsnjzLWVbYK1X/FZaNAPzd2/NAZmPcJQQ
         t6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57iQx0vNulZ5O+l9xPWRsbIZEsnbGWbMcL3xP8MD5q0=;
        b=UyRICrltqHpkwWG1LDsd0G15OezfK8J+fm8aV+lPvfmRClRv5A3UsS+R1UuCJ43VSn
         S60q2JpBxYraolXVbExxGHM+IG4I61LnQQlj1DUukIf+TGmV/pHqxd0mCR5resuSB0jT
         1lDTHlllZ/sZaIT7rWWig4jLoCWYLFjdKjCX/PpXNorPkZJaQ8l8aAi2xyOuzOLdguhb
         Zp3AoUTCQyAwf5VxXkvIACqXcC7pPgxujR5luCfgekFpThuDNHMa9USy4rINdo41Ey7e
         izA5kdPGTRCP+MNHCLr9qWYba9AVmEHKzzMKT9o9ZEXjiPbSN/mpJCfr8b96joARGMo+
         oRIg==
X-Gm-Message-State: APjAAAXSx99Iu8gcyTEdjAAPI/BG36YBOJR911V0sUaPy/dNF/4d6Ybg
        wGzVq9ztPM1ibRQIBXVq9Nj53hgz
X-Google-Smtp-Source: APXvYqyTJOHwPr14EdGFlo3nK7sxrnn9yT8e9epr7uLyoTkogqHIZ0pUWGArcqXW1DTSwEqZlkKi5A==
X-Received: by 2002:adf:f102:: with SMTP id r2mr5191380wro.136.1554404404245;
        Thu, 04 Apr 2019 12:00:04 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm41137280wmo.20.2019.04.04.12.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:00:03 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/3] habanalabs: refactoring in goya.c
Date:   Thu,  4 Apr 2019 21:59:59 +0300
Message-Id: <20190404190001.28337-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does some refactoring in goya.c to make code more reusable
between goya code and the goya simulator code (which is not upstreamed).

In addition, the patch removes some dead functions from goya.c which are
not used by the current upstream code

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 146 +++++++++++++--------------
 drivers/misc/habanalabs/goya/goyaP.h |  19 +++-
 drivers/misc/habanalabs/habanalabs.h |   4 -
 3 files changed, 88 insertions(+), 81 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index cf4e66abf77e..2bef21bcbe1e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -78,7 +78,6 @@
 #define GOYA_RESET_WAIT_MSEC		1		/* 1ms */
 #define GOYA_CPU_RESET_WAIT_MSEC	100		/* 100ms */
 #define GOYA_PLDM_RESET_WAIT_MSEC	1000		/* 1s */
-#define GOYA_CPU_TIMEOUT_USEC		10000000	/* 10s */
 #define GOYA_TEST_QUEUE_WAIT_USEC	100000		/* 100ms */
 #define GOYA_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
 #define GOYA_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
@@ -298,12 +297,6 @@ static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
 };
 
-static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
-static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
-static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
-static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
-					u64 phys_addr);
-
 static void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -511,6 +504,28 @@ static int goya_early_fini(struct hl_device *hdev)
 	return 0;
 }
 
+static void goya_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid)
+{
+	/* mask to zero the MMBP and ASID bits */
+	WREG32_AND(reg, ~0x7FF);
+	WREG32_OR(reg, asid);
+}
+
+static void goya_qman0_set_security(struct hl_device *hdev, bool secure)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+		return;
+
+	if (secure)
+		WREG32(mmDMA_QM_0_GLBL_PROT, QMAN_DMA_FULLY_TRUSTED);
+	else
+		WREG32(mmDMA_QM_0_GLBL_PROT, QMAN_DMA_PARTLY_TRUSTED);
+
+	RREG32(mmDMA_QM_0_GLBL_PROT);
+}
+
 /*
  * goya_fetch_psoc_frequency - Fetch PSOC frequency values
  *
@@ -633,6 +648,9 @@ static int goya_sw_init(struct hl_device *hdev)
 	goya->tpc_clk = GOYA_PLL_FREQ_LOW;
 	goya->ic_clk = GOYA_PLL_FREQ_LOW;
 
+	goya->mmu_prepare_reg = goya_mmu_prepare_reg;
+	goya->qman0_set_security = goya_qman0_set_security;
+
 	hdev->asic_specific = goya;
 
 	/* Create DMA pool for small allocations */
@@ -2323,6 +2341,38 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 	return 0;
 }
 
+static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
+						u64 phys_addr)
+{
+	u32 status, timeout_usec;
+	int rc;
+
+	if (hdev->pldm)
+		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
+	else
+		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
+
+	WREG32(MMU_HOP0_PA43_12, phys_addr >> MMU_HOP0_PA43_12_SHIFT);
+	WREG32(MMU_HOP0_PA49_44, phys_addr >> MMU_HOP0_PA49_44_SHIFT);
+	WREG32(MMU_ASID_BUSY, 0x80000000 | asid);
+
+	rc = hl_poll_timeout(
+		hdev,
+		MMU_ASID_BUSY,
+		status,
+		!(status & 0x80000000),
+		1000,
+		timeout_usec);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Timeout during MMU hop0 config of asid %d\n", asid);
+		return rc;
+	}
+
+	return 0;
+}
+
 static int goya_mmu_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -2797,10 +2847,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 
 	*fence_ptr = 0;
 
-	if (goya->hw_cap_initialized & HW_CAP_MMU) {
-		WREG32(mmDMA_QM_0_GLBL_PROT, QMAN_DMA_FULLY_TRUSTED);
-		RREG32(mmDMA_QM_0_GLBL_PROT);
-	}
+	goya->qman0_set_security(hdev, true);
 
 	/*
 	 * goya cs parser saves space for 2xpacket_msg_prot at end of CB. For
@@ -2842,10 +2889,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_ptr,
 					fence_dma_addr);
 
-	if (goya->hw_cap_initialized & HW_CAP_MMU) {
-		WREG32(mmDMA_QM_0_GLBL_PROT, QMAN_DMA_PARTLY_TRUSTED);
-		RREG32(mmDMA_QM_0_GLBL_PROT);
-	}
+	goya->qman0_set_security(hdev, false);
 
 	return rc;
 }
@@ -2952,7 +2996,7 @@ int goya_test_cpu_queue(struct hl_device *hdev)
 	return hl_fw_test_cpu_queue(hdev);
 }
 
-static int goya_test_queues(struct hl_device *hdev)
+int goya_test_queues(struct hl_device *hdev)
 {
 	int i, rc, ret_val = 0;
 
@@ -2986,14 +3030,14 @@ static void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
 	dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
 }
 
-static void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev,
-					size_t size, dma_addr_t *dma_handle)
+void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
+					dma_addr_t *dma_handle)
 {
 	return hl_fw_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
 }
 
-static void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev,
-						size_t size, void *vaddr)
+void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
+					void *vaddr)
 {
 	hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
 }
@@ -4210,8 +4254,8 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
 						ARMCP_PKT_CTL_OPCODE_SHIFT);
 
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
-			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
+	rc = goya_send_cpu_message(hdev, (u32 *) pkt, total_pkt_size,
+			HL_DEVICE_TIMEOUT_USEC, &result);
 
 	if (rc)
 		dev_err(hdev->dev, "failed to unmask IRQ array\n");
@@ -4243,7 +4287,7 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.value = cpu_to_le64(event_type);
 
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+	rc = goya_send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_DEVICE_TIMEOUT_USEC, &result);
 
 	if (rc)
@@ -4465,7 +4509,7 @@ static int goya_context_switch(struct hl_device *hdev, u32 asid)
 	return 0;
 }
 
-static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
+int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct goya_device *goya = hdev->asic_specific;
@@ -4479,7 +4523,7 @@ static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 	return goya_memset_device_memory(hdev, addr, size, 0, true);
 }
 
-static int goya_mmu_set_dram_default_page(struct hl_device *hdev)
+int goya_mmu_set_dram_default_page(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	u64 addr = hdev->asic_prop.mmu_dram_default_page_addr;
@@ -4492,7 +4536,7 @@ static int goya_mmu_set_dram_default_page(struct hl_device *hdev)
 	return goya_memset_device_memory(hdev, addr, size, val, true);
 }
 
-static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
+void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	int i;
@@ -4506,10 +4550,8 @@ static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 	}
 
 	/* zero the MMBP and ASID bits and then set the ASID */
-	for (i = 0 ; i < GOYA_MMU_REGS_NUM ; i++) {
-		WREG32_AND(goya_mmu_regs[i], ~0x7FF);
-		WREG32_OR(goya_mmu_regs[i], asid);
-	}
+	for (i = 0 ; i < GOYA_MMU_REGS_NUM ; i++)
+		goya->mmu_prepare_reg(hdev, goya_mmu_regs[i], asid);
 }
 
 static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard)
@@ -4600,38 +4642,6 @@ static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 			"Timeout when waiting for MMU cache invalidation\n");
 }
 
-static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
-						u64 phys_addr)
-{
-	u32 status, timeout_usec;
-	int rc;
-
-	if (hdev->pldm)
-		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
-	else
-		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
-
-	WREG32(MMU_HOP0_PA43_12, phys_addr >> MMU_HOP0_PA43_12_SHIFT);
-	WREG32(MMU_HOP0_PA49_44, phys_addr >> MMU_HOP0_PA49_44_SHIFT);
-	WREG32(MMU_ASID_BUSY, 0x80000000 | asid);
-
-	rc = hl_poll_timeout(
-		hdev,
-		MMU_ASID_BUSY,
-		status,
-		!(status & 0x80000000),
-		1000,
-		timeout_usec);
-
-	if (rc) {
-		dev_err(hdev->dev,
-			"Timeout during MMU hop0 config of asid %d\n", asid);
-		return rc;
-	}
-
-	return 0;
-}
-
 int goya_send_heartbeat(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -4673,16 +4683,6 @@ int goya_armcp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static void goya_init_clock_gating(struct hl_device *hdev)
-{
-
-}
-
-static void goya_disable_clock_gating(struct hl_device *hdev)
-{
-
-}
-
 static bool goya_is_device_idle(struct hl_device *hdev, char *buf, size_t size)
 {
 	u64 offset, dma_qm_reg, tpc_qm_reg, tpc_cmdq_reg, tpc_cfg_reg;
@@ -4813,8 +4813,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
 	.send_heartbeat = goya_send_heartbeat,
-	.enable_clock_gating = goya_init_clock_gating,
-	.disable_clock_gating = goya_disable_clock_gating,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
 	.soft_reset_late_init = goya_soft_reset_late_init,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 2a6cdca744dd..b572e0263ac5 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -39,11 +39,13 @@
 #error "Number of MSIX interrupts must be smaller or equal to GOYA_MSIX_ENTRIES"
 #endif
 
-#define QMAN_FENCE_TIMEOUT_USEC		10000	/* 10 ms */
+#define QMAN_FENCE_TIMEOUT_USEC		10000		/* 10 ms */
 
-#define QMAN_STOP_TIMEOUT_USEC		100000	/* 100 ms */
+#define QMAN_STOP_TIMEOUT_USEC		100000		/* 100 ms */
 
-#define CORESIGHT_TIMEOUT_USEC		100000	/* 100 ms */
+#define CORESIGHT_TIMEOUT_USEC		100000		/* 100 ms */
+
+#define GOYA_CPU_TIMEOUT_USEC		10000000	/* 10s */
 
 #define TPC_ENABLED_MASK		0xFF
 
@@ -145,6 +147,9 @@ enum goya_fw_component {
 };
 
 struct goya_device {
+	void (*mmu_prepare_reg)(struct hl_device *hdev, u64 reg, u32 asid);
+	void (*qman0_set_security)(struct hl_device *hdev, bool secure);
+
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
 
@@ -180,6 +185,10 @@ void goya_init_security(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, void *data);
 u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
+int goya_test_queues(struct hl_device *hdev);
+void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
+int goya_mmu_clear_pgt_range(struct hl_device *hdev);
+int goya_mmu_set_dram_default_page(struct hl_device *hdev);
 
 void goya_late_fini(struct hl_device *hdev);
 int goya_suspend(struct hl_device *hdev);
@@ -195,5 +204,9 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt);
 int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id);
 int goya_send_heartbeat(struct hl_device *hdev);
+void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
+					dma_addr_t *dma_handle);
+void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
+					void *vaddr);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 18a03657780a..535d4f9531f6 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -481,8 +481,6 @@ enum hl_pll_frequency {
  * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
  *                              ASID-VA-size mask.
  * @send_heartbeat: send is-alive packet to ArmCP and verify response.
- * @enable_clock_gating: enable clock gating for reducing power consumption.
- * @disable_clock_gating: disable clock for accessing registers on HBW.
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
  * @soft_reset_late_init: perform certain actions needed after soft reset.
@@ -556,8 +554,6 @@ struct hl_asic_funcs {
 	void (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 			u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
-	void (*enable_clock_gating)(struct hl_device *hdev);
-	void (*disable_clock_gating)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, char *buf, size_t size);
 	int (*soft_reset_late_init)(struct hl_device *hdev);
-- 
2.17.1

