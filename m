Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E877C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF35206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJGxrhgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEANYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 09:24:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38975 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfEANYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:24:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id a9so24594666wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xlwpx+kFWtFmJ3XWSkGxk21kOyk3Sio7lkLUbd3IY44=;
        b=MJGxrhgOUsfg0LUqz00FmybWFUSH28HdG8XrsWzDPXyPM8fmwrDKrUXgiL/UslxSL8
         D7WOHopvxnqdhirSaAIf91Fs7eyLbB4L5iNyBmLW+lt3nqo64wjtoq3w0rfn9dthYJpU
         EPsO7Q+U7I25aHDEpGnM0bHtJ/2KbuJ7x71MdOdg75FWjMa/cLbgYbGS5PrJeQkYT0AW
         u2Mui7cbjNJbK3rNZbDLIA3uZHL3hiFEnt3hWf768NfNdTZ0iJlYGmUPSrbm4VSIvZJV
         mo06TtFBCnf0+jI9sAtNhWUMdfjRwa4yuZ507lJlO/irWPA0XareSwpxLyocTQcuPaqZ
         Xu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xlwpx+kFWtFmJ3XWSkGxk21kOyk3Sio7lkLUbd3IY44=;
        b=L7Mg67GLvRDSTM+lsPsGycT9NYcjCpfsuQiGFl7n6TFkQHX7QA2BzwfsJ8pBC2/g3/
         jDyEp5JhvJDGIUlkZaGyEz0pzs9mCgxEvznFkD+aNFZ6Z/+WUktak/8wz2CudVmZGn5t
         PYqG51bJRhJu4+Am3laAg1RO+KQ5KVkfWdrJlwYrQWTuXv/pc6Cyy9UjmioSeLg90OlE
         I4RXqyo45jVuvT++1eAIsNElhsHLD/HO4J7TjSIdmPqe87P1ld1OEmuj0ZPxRsbDLTh9
         sQvck0+fP3Snh892LiK9/TJM26pzbmlwGDUXr9pVpwru60nmlZC8FtnzUTTmZYy8tX9m
         yNng==
X-Gm-Message-State: APjAAAUd7YJYUeCo0dFoP6708PkSAz4UxauI4zYQ1bWxuuzQ7djd2T8J
        uJ3zWNo0WWIicZXXIAXenNRcXOxF
X-Google-Smtp-Source: APXvYqxC/zmc571I6WwYXZgggVAbesONpzp1KgNKMYYHJnCt9tDJdHXnoTYpwhAJHF+K9bLEUKQ69A==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr18152799wrl.252.1556717042316;
        Wed, 01 May 2019 06:24:02 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s124sm6983537wmf.42.2019.05.01.06.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:24:01 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Manipulate DMA addresses in ASIC functions
Date:   Wed,  1 May 2019 16:23:58 +0300
Message-Id: <20190501132358.18839-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Routing device accesses to the host memory requires the usage of a base
offset, which is canceled by the iATU just before leaving the device.
The value of the base offset might be distinctive between different ASIC
types.
The manipulation of the addresses is currently used throughout the
driver code, and one should be aware to it whenever providing a host
memory address to the device.
This patch removes this manipulation from the driver common code, and
moves it to the ASIC specific functions that are responsible for
host memory allocation/mapping.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c |  7 +--
 drivers/misc/habanalabs/goya/goya.c   | 90 +++++++++++++++++----------
 drivers/misc/habanalabs/habanalabs.h  | 10 ++-
 drivers/misc/habanalabs/hw_queue.c    |  6 +-
 drivers/misc/habanalabs/memory.c      |  4 --
 drivers/misc/habanalabs/pci.c         | 11 ++--
 6 files changed, 72 insertions(+), 56 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index 1acf82650b20..eda5d7fcb79f 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -249,8 +249,7 @@ int hl_fw_armcp_info_get(struct hl_device *hdev)
 
 	pkt.ctl = cpu_to_le32(ARMCP_PACKET_INFO_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.addr = cpu_to_le64(armcp_info_dma_addr +
-				prop->host_phys_base_address);
+	pkt.addr = cpu_to_le64(armcp_info_dma_addr);
 	pkt.data_max_size = cpu_to_le32(sizeof(struct armcp_info));
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -281,7 +280,6 @@ int hl_fw_armcp_info_get(struct hl_device *hdev)
 
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct armcp_packet pkt = {};
 	void *eeprom_info_cpu_addr;
 	dma_addr_t eeprom_info_dma_addr;
@@ -301,8 +299,7 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 
 	pkt.ctl = cpu_to_le32(ARMCP_PACKET_EEPROM_DATA_GET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.addr = cpu_to_le64(eeprom_info_dma_addr +
-				prop->host_phys_base_address);
+	pkt.addr = cpu_to_le64(eeprom_info_dma_addr);
 	pkt.data_max_size = cpu_to_le32(max_size);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 8e18c80a22e7..31dc3b872f9e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -345,7 +345,6 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
 
-	prop->host_phys_base_address = HOST_PHYS_BASE;
 	prop->va_space_host_start_address = VA_HOST_SPACE_START;
 	prop->va_space_host_end_address = VA_HOST_SPACE_END;
 	prop->va_space_dram_start_address = VA_DDR_SPACE_START;
@@ -422,7 +421,7 @@ static u64 goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
 static int goya_init_iatu(struct hl_device *hdev)
 {
 	return hl_pci_init_iatu(hdev, SRAM_BASE_ADDR, DRAM_PHYS_BASE,
-				HOST_PHYS_SIZE);
+				HOST_PHYS_BASE, HOST_PHYS_SIZE);
 }
 
 /*
@@ -804,7 +803,6 @@ void goya_init_dma_qmans(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct hl_hw_queue *q;
-	dma_addr_t bus_address;
 	int i;
 
 	if (goya->hw_cap_initialized & HW_CAP_DMA)
@@ -813,10 +811,7 @@ void goya_init_dma_qmans(struct hl_device *hdev)
 	q = &hdev->kernel_queues[0];
 
 	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++, q++) {
-		bus_address = q->bus_address +
-				hdev->asic_prop.host_phys_base_address;
-
-		goya_init_dma_qman(hdev, i, bus_address);
+		goya_init_dma_qman(hdev, i, q->bus_address);
 		goya_init_dma_ch(hdev, i);
 	}
 
@@ -957,7 +952,6 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct hl_eq *eq;
-	dma_addr_t bus_address;
 	u32 status;
 	struct hl_hw_queue *cpu_pq = &hdev->kernel_queues[GOYA_QUEUE_ID_CPU_PQ];
 	int err;
@@ -970,19 +964,18 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 
 	eq = &hdev->event_queue;
 
-	bus_address = cpu_pq->bus_address +
-			hdev->asic_prop.host_phys_base_address;
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_0, lower_32_bits(bus_address));
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_1, upper_32_bits(bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_0,
+			lower_32_bits(cpu_pq->bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_1,
+			upper_32_bits(cpu_pq->bus_address));
 
-	bus_address = eq->bus_address + hdev->asic_prop.host_phys_base_address;
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_2, lower_32_bits(bus_address));
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_3, upper_32_bits(bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_2, lower_32_bits(eq->bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_3, upper_32_bits(eq->bus_address));
 
-	bus_address = hdev->cpu_accessible_dma_address +
-			hdev->asic_prop.host_phys_base_address;
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_8, lower_32_bits(bus_address));
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_9, upper_32_bits(bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_8,
+			lower_32_bits(hdev->cpu_accessible_dma_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_9,
+			upper_32_bits(hdev->cpu_accessible_dma_address));
 
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_5, HL_QUEUE_SIZE_IN_BYTES);
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_4, HL_EQ_SIZE_IN_BYTES);
@@ -2731,13 +2724,23 @@ void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
 static void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags)
 {
-	return dma_alloc_coherent(&hdev->pdev->dev, size, dma_handle, flags);
+	void *kernel_addr = dma_alloc_coherent(&hdev->pdev->dev, size,
+						dma_handle, flags);
+
+	/* Shift to the device's base physical address of host memory */
+	if (kernel_addr)
+		*dma_handle += HOST_PHYS_BASE;
+
+	return kernel_addr;
 }
 
 static void goya_dma_free_coherent(struct hl_device *hdev, size_t size,
 					void *cpu_addr, dma_addr_t dma_handle)
 {
-	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
+	/* Cancel the device's base physical address of host memory */
+	dma_addr_t fixed_dma_handle = dma_handle - HOST_PHYS_BASE;
+
+	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, fixed_dma_handle);
 }
 
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
@@ -2848,8 +2851,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 			(1 << GOYA_PKT_CTL_MB_SHIFT);
 	fence_pkt->ctl = cpu_to_le32(tmp);
 	fence_pkt->value = cpu_to_le32(GOYA_QMAN0_FENCE_VAL);
-	fence_pkt->addr = cpu_to_le64(fence_dma_addr +
-					hdev->asic_prop.host_phys_base_address);
+	fence_pkt->addr = cpu_to_le64(fence_dma_addr);
 
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GOYA_QUEUE_ID_DMA_0,
 					job->job_cb_size, cb->bus_address);
@@ -2928,8 +2930,7 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 			(1 << GOYA_PKT_CTL_MB_SHIFT);
 	fence_pkt->ctl = cpu_to_le32(tmp);
 	fence_pkt->value = cpu_to_le32(fence_val);
-	fence_pkt->addr = cpu_to_le64(fence_dma_addr +
-					hdev->asic_prop.host_phys_base_address);
+	fence_pkt->addr = cpu_to_le64(fence_dma_addr);
 
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id,
 					sizeof(struct packet_msg_prot),
@@ -3001,16 +3002,27 @@ int goya_test_queues(struct hl_device *hdev)
 static void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size,
 					gfp_t mem_flags, dma_addr_t *dma_handle)
 {
+	void *kernel_addr;
+
 	if (size > GOYA_DMA_POOL_BLK_SIZE)
 		return NULL;
 
-	return dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
+	kernel_addr =  dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
+
+	/* Shift to the device's base physical address of host memory */
+	if (kernel_addr)
+		*dma_handle += HOST_PHYS_BASE;
+
+	return kernel_addr;
 }
 
 static void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
 				dma_addr_t dma_addr)
 {
-	dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
+	/* Cancel the device's base physical address of host memory */
+	dma_addr_t fixed_dma_addr = dma_addr - HOST_PHYS_BASE;
+
+	dma_pool_free(hdev->dma_pool, vaddr, fixed_dma_addr);
 }
 
 void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
@@ -3025,19 +3037,33 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 	hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
 }
 
-static int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg,
+static int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sgl,
 				int nents, enum dma_data_direction dir)
 {
-	if (!dma_map_sg(&hdev->pdev->dev, sg, nents, dir))
+	struct scatterlist *sg;
+	int i;
+
+	if (!dma_map_sg(&hdev->pdev->dev, sgl, nents, dir))
 		return -ENOMEM;
 
+	/* Shift to the device's base physical address of host memory */
+	for_each_sg(sgl, sg, nents, i)
+		sg->dma_address += HOST_PHYS_BASE;
+
 	return 0;
 }
 
-static void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sg,
+static void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sgl,
 				int nents, enum dma_data_direction dir)
 {
-	dma_unmap_sg(&hdev->pdev->dev, sg, nents, dir);
+	struct scatterlist *sg;
+	int i;
+
+	/* Cancel the device's base physical address of host memory */
+	for_each_sg(sgl, sg, nents, i)
+		sg->dma_address -= HOST_PHYS_BASE;
+
+	dma_unmap_sg(&hdev->pdev->dev, sgl, nents, dir);
 }
 
 u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt)
@@ -3589,8 +3615,6 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 		new_dma_pkt->ctl = cpu_to_le32(ctl);
 		new_dma_pkt->tsize = cpu_to_le32((u32) len);
 
-		dma_addr += hdev->asic_prop.host_phys_base_address;
-
 		if (dir == DMA_TO_DEVICE) {
 			new_dma_pkt->src_addr = cpu_to_le64(dma_addr);
 			new_dma_pkt->dst_addr = cpu_to_le64(device_memory_addr);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index b64594be6dbd..f08f71982585 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -135,8 +135,6 @@ enum hl_device_hw_state {
  * @dram_user_base_address: DRAM physical start address for user access.
  * @dram_size: DRAM total size.
  * @dram_pci_bar_size: size of PCI bar towards DRAM.
- * @host_phys_base_address: base physical address of host memory for
- *				transactions that the device generates.
  * @max_power_default: max power of the device after reset
  * @va_space_host_start_address: base address of virtual memory range for
  *                               mapping host memory.
@@ -184,7 +182,6 @@ struct asic_fixed_properties {
 	u64			dram_user_base_address;
 	u64			dram_size;
 	u64			dram_pci_bar_size;
-	u64			host_phys_base_address;
 	u64			max_power_default;
 	u64			va_space_host_start_address;
 	u64			va_space_host_end_address;
@@ -537,11 +534,11 @@ struct hl_asic_funcs {
 	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
 				size_t size, void *vaddr);
 	void (*hl_dma_unmap_sg)(struct hl_device *hdev,
-				struct scatterlist *sg, int nents,
+				struct scatterlist *sgl, int nents,
 				enum dma_data_direction dir);
 	int (*cs_parser)(struct hl_device *hdev, struct hl_cs_parser *parser);
 	int (*asic_dma_map_sg)(struct hl_device *hdev,
-				struct scatterlist *sg, int nents,
+				struct scatterlist *sgl, int nents,
 				enum dma_data_direction dir);
 	u32 (*get_dma_desc_list_size)(struct hl_device *hdev,
 					struct sg_table *sgt);
@@ -1450,7 +1447,8 @@ int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data);
 int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
 				u64 addr);
 int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
-			u64 dram_base_address, u64 host_phys_size);
+			u64 dram_base_address, u64 host_phys_base_address,
+			u64 host_phys_size);
 int hl_pci_init(struct hl_device *hdev, u8 dma_mask);
 void hl_pci_fini(struct hl_device *hdev);
 int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask);
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 6cdaa117fc40..2894d8975933 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -82,7 +82,7 @@ static void ext_queue_submit_bd(struct hl_device *hdev, struct hl_hw_queue *q,
 	bd += hl_pi_2_offset(q->pi);
 	bd->ctl = __cpu_to_le32(ctl);
 	bd->len = __cpu_to_le32(len);
-	bd->ptr = __cpu_to_le64(ptr + hdev->asic_prop.host_phys_base_address);
+	bd->ptr = __cpu_to_le64(ptr);
 
 	q->pi = hl_queue_inc_ptr(q->pi);
 	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
@@ -263,9 +263,7 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
 	 * checked in hl_queue_sanity_checks
 	 */
 	cq = &hdev->completion_queue[q->hw_queue_id];
-	cq_addr = cq->bus_address +
-			hdev->asic_prop.host_phys_base_address;
-	cq_addr += cq->pi * sizeof(struct hl_cq_entry);
+	cq_addr = cq->bus_address + cq->pi * sizeof(struct hl_cq_entry);
 
 	hdev->asic_funcs->add_end_of_cb_packets(cb->kernel_address, len,
 						cq_addr,
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 43ef3ad8438a..d67d24c13efd 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -759,10 +759,6 @@ static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
 	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
 		paddr = phys_pg_pack->pages[i];
 
-		/* For accessing the host we need to turn on bit 39 */
-		if (phys_pg_pack->created_from_userptr)
-			paddr += hdev->asic_prop.host_phys_base_address;
-
 		rc = hl_mmu_map(ctx, next_vaddr, paddr, page_size);
 		if (rc) {
 			dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index 5278f086d65d..0e78a04d63f4 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -236,6 +236,8 @@ int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
  * @hdev: Pointer to hl_device structure.
  * @sram_base_address: SRAM base address.
  * @dram_base_address: DRAM base address.
+ * @host_phys_base_address: Base physical address of host memory for device
+ *                          transactions.
  * @host_phys_size: Size of host memory for device transactions.
  *
  * This is needed in case the firmware doesn't initialize the iATU.
@@ -243,7 +245,8 @@ int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
  * Return: 0 on success, negative value for failure.
  */
 int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
-			u64 dram_base_address, u64 host_phys_size)
+			u64 dram_base_address, u64 host_phys_base_address,
+			u64 host_phys_size)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 host_phys_end_addr;
@@ -265,11 +268,11 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 
 
 	/* Outbound Region 0 - Point to Host */
-	host_phys_end_addr = prop->host_phys_base_address + host_phys_size - 1;
+	host_phys_end_addr = host_phys_base_address + host_phys_size - 1;
 	rc |= hl_pci_iatu_write(hdev, 0x008,
-				lower_32_bits(prop->host_phys_base_address));
+				lower_32_bits(host_phys_base_address));
 	rc |= hl_pci_iatu_write(hdev, 0x00C,
-				upper_32_bits(prop->host_phys_base_address));
+				upper_32_bits(host_phys_base_address));
 	rc |= hl_pci_iatu_write(hdev, 0x010, lower_32_bits(host_phys_end_addr));
 	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
 	rc |= hl_pci_iatu_write(hdev, 0x018, 0);
-- 
2.17.1

