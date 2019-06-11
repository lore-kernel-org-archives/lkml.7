Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEABC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129F72086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmiRbdS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbfFKFu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:50:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34374 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403894AbfFKFuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so11490479wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z30XCz3Jv0pR4ANslgh+KOQVFeDO1s2lr1AkQ/vlloA=;
        b=lmiRbdS//J9N7Xcgs9o55DBJhaubcSMsveSXMVKIJv9idmzx9sQIOBxdRnlNowRDwj
         KK/mdkC/OsB2VRzuYqXn++L63QeEAJpzVc6+FLef045GQu5g4b7WRs0Kuf0QW1Xa0w6T
         oO8Em13TbW1Yqhc1bRtMtzVv7eFHKLGbU0l3otlh0koW3PtJu9bh4PLS1uptebsLLzDr
         ElXiNYAbv6G8tQ1sJCcWNU9x7BhlfoxJgVFqgigtT1pCxO3YGNzUSPF7wzsjfhgAHcun
         CxlmTS+7rTVkuwJkoDqmd09NykpPXO1di9gHbcmC8pOVOo7GvfQ+gsbxDE0ldtL/A6Yr
         LZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z30XCz3Jv0pR4ANslgh+KOQVFeDO1s2lr1AkQ/vlloA=;
        b=p1noGKPgKQ3kOXuTkTo3EmAue1f2kF/moSHgoD3MCzeD//RxFZvULSd6cuE0nO8Pve
         Q4nqq1Q9p7yhMtBKPTZe6yr8M6zoSUd+sBMMDhwVGPNSjXhOLZsP3++RoqEFt0ChBFpe
         MnJQOvZuvBaXq6fkWZqY/BRKF7HPLrGnE1UirbplsknO8RM+k8UZG7FKpuaVtb597jWP
         QGFdj6uRjdTT35VO7uF3E4ZtzFHOdaZ+SLcz7uGcjEpE0DgzRMuzbUyf6ZT1NP4tHNXQ
         72XR/a0A2gVNw+0Gd4k/SS6pblc0RcRsr0y0ACWR8gGcMXmVteJpsa7ITIxusdRBvSR5
         g0gQ==
X-Gm-Message-State: APjAAAWhDGc7jGk3aIjc2bF1QrK2S3hTnC/OB1TdB6g5fGtw3prrIO0D
        12yyJsGEE8BXU48CB5vuSAqEEdr6R4g=
X-Google-Smtp-Source: APXvYqyacnZ7Kax4DbEu74nKxBQjNhxei9s84FR4bVPpoXP/Yhbon/hxIqMsUuU2YxdVf7pObSXyIQ==
X-Received: by 2002:a5d:528b:: with SMTP id c11mr22405859wrv.25.1560232252751;
        Mon, 10 Jun 2019 22:50:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 4/8] habanalabs: add MMU mappings for Goya CPU
Date:   Tue, 11 Jun 2019 08:50:41 +0300
Message-Id: <20190611055045.15945-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the necessary MMU mappings for the Goya CPU to access the
device DRAM and the host memory.

The first 256MB of the device DRAM is being mapped. That's where the F/W
is running.

The 2MB area located on the host memory for the purpose of communication
between the driver and the device CPU is also being mapped.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c    |   7 +-
 drivers/misc/habanalabs/goya/goya.c  | 126 +++++++++++++++++++++++++--
 drivers/misc/habanalabs/goya/goyaP.h |  12 ++-
 drivers/misc/habanalabs/habanalabs.h |   6 +-
 4 files changed, 137 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index ba418aaa404c..886f8ea82499 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -355,7 +355,7 @@ static int mmu_show(struct seq_file *s, void *data)
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
-	struct hl_ctx *ctx = hdev->user_ctx;
+	struct hl_ctx *ctx;
 
 	u64 hop0_addr = 0, hop0_pte_addr = 0, hop0_pte = 0,
 		hop1_addr = 0, hop1_pte_addr = 0, hop1_pte = 0,
@@ -367,6 +367,11 @@ static int mmu_show(struct seq_file *s, void *data)
 	if (!hdev->mmu_enable)
 		return 0;
 
+	if (dev_entry->mmu_asid == HL_KERNEL_ASID_ID)
+		ctx = hdev->kernel_ctx;
+	else
+		ctx = hdev->user_ctx;
+
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
 		return 0;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 106074466dca..4e41f2669e6d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -297,6 +297,11 @@ static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
 };
 
+static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
+static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
+static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev);
+static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
+
 void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -554,6 +559,10 @@ int goya_late_init(struct hl_device *hdev)
 		return rc;
 	}
 
+	rc = goya_mmu_add_mappings_for_device_cpu(hdev);
+	if (rc)
+		return rc;
+
 	rc = goya_init_cpu_queues(hdev);
 	if (rc)
 		return rc;
@@ -2065,10 +2074,12 @@ static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
 	goya_disable_external_queues(hdev);
 	goya_disable_internal_queues(hdev);
 
-	if (hard_reset)
+	if (hard_reset) {
 		goya_disable_msix(hdev);
-	else
+		goya_mmu_remove_device_cpu_mappings(hdev);
+	} else {
 		goya_sync_irqs(hdev);
+	}
 }
 
 /*
@@ -4584,7 +4595,7 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
 	return 0;
 }
 
-int goya_mmu_clear_pgt_range(struct hl_device *hdev)
+static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct goya_device *goya = hdev->asic_specific;
@@ -4598,7 +4609,7 @@ int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 	return goya_memset_device_memory(hdev, addr, size, 0, true);
 }
 
-int goya_mmu_set_dram_default_page(struct hl_device *hdev)
+static int goya_mmu_set_dram_default_page(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	u64 addr = hdev->asic_prop.mmu_dram_default_page_addr;
@@ -4611,7 +4622,112 @@ int goya_mmu_set_dram_default_page(struct hl_device *hdev)
 	return goya_memset_device_memory(hdev, addr, size, val, true);
 }
 
-void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
+static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct goya_device *goya = hdev->asic_specific;
+	s64 off, cpu_off;
+	int rc;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+		return 0;
+
+	for (off = 0 ; off < CPU_FW_IMAGE_SIZE ; off += PAGE_SIZE_2MB) {
+		rc = hl_mmu_map(hdev->kernel_ctx, prop->dram_base_address + off,
+				prop->dram_base_address + off, PAGE_SIZE_2MB);
+		if (rc) {
+			dev_err(hdev->dev, "Map failed for address 0x%llx\n",
+				prop->dram_base_address + off);
+			goto unmap;
+		}
+	}
+
+	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
+		rc = hl_mmu_map(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
+			hdev->cpu_accessible_dma_address, PAGE_SIZE_2MB);
+
+		if (rc) {
+			dev_err(hdev->dev,
+				"Map failed for CPU accessible memory\n");
+			off -= PAGE_SIZE_2MB;
+			goto unmap;
+		}
+	} else {
+		for (cpu_off = 0 ; cpu_off < SZ_2M ; cpu_off += PAGE_SIZE_4KB) {
+			rc = hl_mmu_map(hdev->kernel_ctx,
+				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
+				hdev->cpu_accessible_dma_address + cpu_off,
+				PAGE_SIZE_4KB);
+			if (rc) {
+				dev_err(hdev->dev,
+					"Map failed for CPU accessible memory\n");
+				cpu_off -= PAGE_SIZE_4KB;
+				goto unmap_cpu;
+			}
+		}
+	}
+
+	goya->device_cpu_mmu_mappings_done = true;
+
+	return 0;
+
+unmap_cpu:
+	for (; cpu_off >= 0 ; cpu_off -= PAGE_SIZE_4KB)
+		if (hl_mmu_unmap(hdev->kernel_ctx,
+				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
+				PAGE_SIZE_4KB))
+			dev_warn_ratelimited(hdev->dev,
+				"failed to unmap address 0x%llx\n",
+				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off);
+unmap:
+	for (; off >= 0 ; off -= PAGE_SIZE_2MB)
+		if (hl_mmu_unmap(hdev->kernel_ctx,
+				prop->dram_base_address + off, PAGE_SIZE_2MB))
+			dev_warn_ratelimited(hdev->dev,
+				"failed to unmap address 0x%llx\n",
+				prop->dram_base_address + off);
+
+	return rc;
+}
+
+void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct goya_device *goya = hdev->asic_specific;
+	u32 off, cpu_off;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+		return;
+
+	if (!goya->device_cpu_mmu_mappings_done)
+		return;
+
+	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
+		if (hl_mmu_unmap(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
+				PAGE_SIZE_2MB))
+			dev_warn(hdev->dev,
+				"Failed to unmap CPU accessible memory\n");
+	} else {
+		for (cpu_off = 0 ; cpu_off < SZ_2M ; cpu_off += PAGE_SIZE_4KB)
+			if (hl_mmu_unmap(hdev->kernel_ctx,
+					VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
+					PAGE_SIZE_4KB))
+				dev_warn_ratelimited(hdev->dev,
+					"failed to unmap address 0x%llx\n",
+					VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off);
+	}
+
+	for (off = 0 ; off < CPU_FW_IMAGE_SIZE ; off += PAGE_SIZE_2MB)
+		if (hl_mmu_unmap(hdev->kernel_ctx,
+				prop->dram_base_address + off, PAGE_SIZE_2MB))
+			dev_warn_ratelimited(hdev->dev,
+					"Failed to unmap address 0x%llx\n",
+					prop->dram_base_address + off);
+
+	goya->device_cpu_mmu_mappings_done = false;
+}
+
+static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	int i;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 066b1d306977..f8c611883dc1 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -126,6 +126,12 @@
 #define VA_DDR_SPACE_SIZE	(VA_DDR_SPACE_END - \
 					VA_DDR_SPACE_START)	/* 128GB */
 
+#if (HL_CPU_ACCESSIBLE_MEM_SIZE != SZ_2M)
+#error "HL_CPU_ACCESSIBLE_MEM_SIZE must be exactly 2MB to enable MMU mapping"
+#endif
+
+#define VA_CPU_ACCESSIBLE_MEM_ADDR	0x8000000000ull
+
 #define DMA_MAX_TRANSFER_SIZE	U32_MAX
 
 #define HW_CAP_PLL		0x00000001
@@ -157,6 +163,7 @@ struct goya_device {
 	u64		ddr_bar_cur_addr;
 	u32		events_stat[GOYA_ASYNC_EVENT_ID_SIZE];
 	u32		hw_cap_initialized;
+	u8		device_cpu_mmu_mappings_done;
 };
 
 void goya_get_fixed_properties(struct hl_device *hdev);
@@ -204,10 +211,6 @@ int goya_armcp_info_get(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, void *data);
 void goya_halt_coresight(struct hl_device *hdev);
 
-void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
-int goya_mmu_clear_pgt_range(struct hl_device *hdev);
-int goya_mmu_set_dram_default_page(struct hl_device *hdev);
-
 int goya_suspend(struct hl_device *hdev);
 int goya_resume(struct hl_device *hdev);
 
@@ -225,5 +228,6 @@ void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle);
 void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
+void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 0462b7727da7..5e4a631b3d88 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -320,10 +320,8 @@ struct hl_cs_job;
 #define HL_EQ_LENGTH			64
 #define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
-/* KMD <-> ArmCP shared memory size (EQ + PQ + 2MB for packets) */
-#define HL_CPU_ACCESSIBLE_MEM_SIZE	(HL_EQ_SIZE_IN_BYTES + \
-					 HL_QUEUE_SIZE_IN_BYTES + \
-					 SZ_2M)
+/* KMD <-> ArmCP shared memory size */
+#define HL_CPU_ACCESSIBLE_MEM_SIZE	SZ_2M
 
 /**
  * struct hl_hw_queue - describes a H/W transport queue.
-- 
2.17.1

