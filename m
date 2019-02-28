Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E294C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8902171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfzy5bu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfB1IrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:47:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36154 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbfB1Iq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so8059081wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZtaef8rmRZdro60L9DIhYMrVD/vAUVbnbvs1g1O5Yg=;
        b=Gfzy5bu7fgPUBtGJ8zeDTXa4OCpcOvEu8X1H6r3lARzFzzGVXn1Ei75QUhYlhpAblY
         15E1I5YB8TlCwyiNi+U3PaOtEgfs4Wb1uHmeReorw9YxR6o7tZ8heFKBrWTtqZs6T2oJ
         +gVMjKp9paIlJnOklQNPAv4c1hpeC7QMQwLg6zJ4ReWj/I57DyZ195s1vq452nJL8zPO
         ZunXAMq20DtLqExJC966yvnn+DSrJjplOJ202A9GaDeP7GhhnY77KmTd9llP5x+JD5jT
         3i629s/xQVvZ9fY84dfB6Bw55xIDm+jBNbpMYQLkDAUXRD56gPQuU3Mh0tdjGgLZPXiG
         3W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZtaef8rmRZdro60L9DIhYMrVD/vAUVbnbvs1g1O5Yg=;
        b=gd8Ep2ZBKeTTBtU+3YHj492MUWCBTSRELd0yF3QExFkCSgfrpQhk8b7+LBpfN+mr99
         t0/NpkdvZFtJHhd5NkCZFUzu4D74h2u7ppx6ivFrGuQuh0SIRS6ZxVXPfa5HBDRd7zV8
         NOTKzEfbPJGzJqEg1ykdjAOZUyljg68rBOv7yHbjAVMRMHeKF9ua/9Xbwlrg1k62C188
         UiSkV/53KMcAFDABaefGzFs3AxliaL7BjkNHzMZmIYxZmAdYPk/wFMSzTAYRJ4P7a4Ib
         Q8E19//ujioPbIu5WMb88jo46rketq2zvWfZJQqpW3NNJzECDAS0yBzwTPy7Efutkl1c
         FCkg==
X-Gm-Message-State: AHQUAuYpI/2Q5Uq0Bq7jdXPqurpHVGdDNdgQkCMPSrU2+Qutk4luiugM
        tocRIkwVe/L2upVHYlobvhfNzt3B
X-Google-Smtp-Source: APXvYqyirxQf8IIsTAeu92hslz/jDBWPfyNTKgQG45dJA0z3hvxabblwrRcfdZHQgLhcrWbuLOETJw==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr2118187wme.69.1551343614167;
        Thu, 28 Feb 2019 00:46:54 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:53 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 13/15] habanalabs: fix little-endian<->cpu conversion warnings
Date:   Thu, 28 Feb 2019 10:46:22 +0200
Message-Id: <20190228084624.25288-14-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add __cpu_to_le16/32/64 and __le16/32/64_to_cpu where needed according to
sparse.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 223 ++++++++++++++++------------
 1 file changed, 125 insertions(+), 98 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 11597432f519..c4f3ec1e9d8b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -381,7 +381,7 @@ int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = opcode << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.ctl = cpu_to_le32(opcode << ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
 			sizeof(pkt), HL_DEVICE_TIMEOUT_USEC, NULL);
@@ -3167,12 +3167,13 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	fence_pkt = (struct packet_msg_prot *) (uintptr_t) (cb->kernel_address +
 			job->job_cb_size - sizeof(struct packet_msg_prot));
 
-	fence_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+	tmp = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
 			(1 << GOYA_PKT_CTL_EB_SHIFT) |
 			(1 << GOYA_PKT_CTL_MB_SHIFT);
-	fence_pkt->value = GOYA_QMAN0_FENCE_VAL;
-	fence_pkt->addr = fence_dma_addr +
-			hdev->asic_prop.host_phys_base_address;
+	fence_pkt->ctl = cpu_to_le32(tmp);
+	fence_pkt->value = cpu_to_le32(GOYA_QMAN0_FENCE_VAL);
+	fence_pkt->addr = cpu_to_le64(fence_dma_addr +
+					hdev->asic_prop.host_phys_base_address);
 
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GOYA_QUEUE_ID_DMA_0,
 					job->job_cb_size, cb->bus_address);
@@ -3263,16 +3264,17 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 	}
 
 	if (tmp == ARMCP_PACKET_FENCE_VAL) {
-		rc = (pkt->ctl & ARMCP_PKT_CTL_RC_MASK) >>
-						ARMCP_PKT_CTL_RC_SHIFT;
+		u32 ctl = le32_to_cpu(pkt->ctl);
+
+		rc = (ctl & ARMCP_PKT_CTL_RC_MASK) >> ARMCP_PKT_CTL_RC_SHIFT;
 		if (rc) {
 			dev_err(hdev->dev,
 				"F/W ERROR %d for CPU packet %d\n",
-				rc, (pkt->ctl & ARMCP_PKT_CTL_OPCODE_MASK)
+				rc, (ctl & ARMCP_PKT_CTL_OPCODE_MASK)
 						>> ARMCP_PKT_CTL_OPCODE_SHIFT);
 			rc = -EINVAL;
 		} else if (result) {
-			*result = pkt->result;
+			*result = (long) le64_to_cpu(pkt->result);
 		}
 	} else {
 		dev_err(hdev->dev, "CPU packet wrong fence value\n");
@@ -3318,12 +3320,13 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 		goto free_fence_ptr;
 	}
 
-	fence_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+	tmp = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
 			(1 << GOYA_PKT_CTL_EB_SHIFT) |
 			(1 << GOYA_PKT_CTL_MB_SHIFT);
-	fence_pkt->value = fence_val;
-	fence_pkt->addr = fence_dma_addr +
-				hdev->asic_prop.host_phys_base_address;
+	fence_pkt->ctl = cpu_to_le32(tmp);
+	fence_pkt->value = cpu_to_le32(fence_val);
+	fence_pkt->addr = cpu_to_le64(fence_dma_addr +
+					hdev->asic_prop.host_phys_base_address);
 
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id,
 					sizeof(struct packet_msg_prot),
@@ -3369,8 +3372,9 @@ int goya_test_cpu_queue(struct hl_device *hdev)
 
 	memset(&test_pkt, 0, sizeof(test_pkt));
 
-	test_pkt.ctl = ARMCP_PACKET_TEST << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	test_pkt.value = ARMCP_PACKET_FENCE_VAL;
+	test_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
+					ARMCP_PKT_CTL_OPCODE_SHIFT);
+	test_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
 			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
@@ -3514,7 +3518,7 @@ static int goya_pin_memory_before_cs(struct hl_device *hdev,
 	struct hl_userptr *userptr;
 	int rc;
 
-	if (hl_userptr_is_pinned(hdev, addr, user_dma_pkt->tsize,
+	if (hl_userptr_is_pinned(hdev, addr, le32_to_cpu(user_dma_pkt->tsize),
 			parser->job_userptr_list, &userptr))
 		goto already_pinned;
 
@@ -3522,7 +3526,8 @@ static int goya_pin_memory_before_cs(struct hl_device *hdev,
 	if (!userptr)
 		return -ENOMEM;
 
-	rc = hl_pin_host_memory(hdev, addr, user_dma_pkt->tsize, userptr);
+	rc = hl_pin_host_memory(hdev, addr, le32_to_cpu(user_dma_pkt->tsize),
+				userptr);
 	if (rc)
 		goto free_userptr;
 
@@ -3561,12 +3566,15 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 	bool sram_addr = true;
 	bool skip_host_mem_pin = false;
 	bool user_memset;
+	u32 ctl;
 	int rc = 0;
 
-	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+	ctl = le32_to_cpu(user_dma_pkt->ctl);
+
+	user_dir = (ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 
-	user_memset = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
+	user_memset = (ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT;
 
 	switch (user_dir) {
@@ -3574,8 +3582,8 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 		dev_dbg(hdev->dev, "DMA direction is HOST --> DRAM\n");
 		dir = DMA_TO_DEVICE;
 		sram_addr = false;
-		addr = user_dma_pkt->src_addr;
-		device_memory_addr = user_dma_pkt->dst_addr;
+		addr = le64_to_cpu(user_dma_pkt->src_addr);
+		device_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
 		if (user_memset)
 			skip_host_mem_pin = true;
 		break;
@@ -3584,15 +3592,15 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 		dev_dbg(hdev->dev, "DMA direction is DRAM --> HOST\n");
 		dir = DMA_FROM_DEVICE;
 		sram_addr = false;
-		addr = user_dma_pkt->dst_addr;
-		device_memory_addr = user_dma_pkt->src_addr;
+		addr = le64_to_cpu(user_dma_pkt->dst_addr);
+		device_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
 		break;
 
 	case DMA_HOST_TO_SRAM:
 		dev_dbg(hdev->dev, "DMA direction is HOST --> SRAM\n");
 		dir = DMA_TO_DEVICE;
-		addr = user_dma_pkt->src_addr;
-		device_memory_addr = user_dma_pkt->dst_addr;
+		addr = le64_to_cpu(user_dma_pkt->src_addr);
+		device_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
 		if (user_memset)
 			skip_host_mem_pin = true;
 		break;
@@ -3600,8 +3608,8 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 	case DMA_SRAM_TO_HOST:
 		dev_dbg(hdev->dev, "DMA direction is SRAM --> HOST\n");
 		dir = DMA_FROM_DEVICE;
-		addr = user_dma_pkt->dst_addr;
-		device_memory_addr = user_dma_pkt->src_addr;
+		addr = le64_to_cpu(user_dma_pkt->dst_addr);
+		device_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
 		break;
 	default:
 		dev_err(hdev->dev, "DMA direction is undefined\n");
@@ -3611,7 +3619,7 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 	if (parser->ctx_id != HL_KERNEL_ASID_ID) {
 		if (sram_addr) {
 			if (!hl_mem_area_inside_range(device_memory_addr,
-					user_dma_pkt->tsize,
+					le32_to_cpu(user_dma_pkt->tsize),
 					hdev->asic_prop.sram_user_base_address,
 					hdev->asic_prop.sram_end_address)) {
 
@@ -3623,7 +3631,7 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 			}
 		} else {
 			if (!hl_mem_area_inside_range(device_memory_addr,
-					user_dma_pkt->tsize,
+					le32_to_cpu(user_dma_pkt->tsize),
 					hdev->asic_prop.dram_user_base_address,
 					hdev->asic_prop.dram_end_address)) {
 
@@ -3659,21 +3667,24 @@ static int goya_validate_dma_pkt_no_host(struct hl_device *hdev,
 {
 	u64 sram_memory_addr, dram_memory_addr;
 	enum goya_dma_direction user_dir;
+	u32 ctl;
 
-	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+	ctl = le32_to_cpu(user_dma_pkt->ctl);
+	user_dir = (ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 
 	if (user_dir == DMA_DRAM_TO_SRAM) {
 		dev_dbg(hdev->dev, "DMA direction is DRAM --> SRAM\n");
-		dram_memory_addr = user_dma_pkt->src_addr;
-		sram_memory_addr = user_dma_pkt->dst_addr;
+		dram_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
+		sram_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
 	} else {
 		dev_dbg(hdev->dev, "DMA direction is SRAM --> DRAM\n");
-		sram_memory_addr = user_dma_pkt->src_addr;
-		dram_memory_addr = user_dma_pkt->dst_addr;
+		sram_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
+		dram_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
 	}
 
-	if (!hl_mem_area_inside_range(sram_memory_addr, user_dma_pkt->tsize,
+	if (!hl_mem_area_inside_range(sram_memory_addr,
+				le32_to_cpu(user_dma_pkt->tsize),
 				hdev->asic_prop.sram_user_base_address,
 				hdev->asic_prop.sram_end_address)) {
 		dev_err(hdev->dev, "SRAM address 0x%llx + 0x%x is invalid\n",
@@ -3681,7 +3692,8 @@ static int goya_validate_dma_pkt_no_host(struct hl_device *hdev,
 		return -EFAULT;
 	}
 
-	if (!hl_mem_area_inside_range(dram_memory_addr, user_dma_pkt->tsize,
+	if (!hl_mem_area_inside_range(dram_memory_addr,
+				le32_to_cpu(user_dma_pkt->tsize),
 				hdev->asic_prop.dram_user_base_address,
 				hdev->asic_prop.dram_end_address)) {
 		dev_err(hdev->dev, "DRAM address 0x%llx + 0x%x is invalid\n",
@@ -3699,6 +3711,7 @@ static int goya_validate_dma_pkt_no_mmu(struct hl_device *hdev,
 				struct packet_lin_dma *user_dma_pkt)
 {
 	enum goya_dma_direction user_dir;
+	u32 ctl;
 	int rc;
 
 	dev_dbg(hdev->dev, "DMA packet details:\n");
@@ -3706,7 +3719,8 @@ static int goya_validate_dma_pkt_no_mmu(struct hl_device *hdev,
 	dev_dbg(hdev->dev, "destination == 0x%llx\n", user_dma_pkt->dst_addr);
 	dev_dbg(hdev->dev, "size == %u\n", user_dma_pkt->tsize);
 
-	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+	ctl = le32_to_cpu(user_dma_pkt->ctl);
+	user_dir = (ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 
 	/*
@@ -3741,8 +3755,8 @@ static int goya_validate_dma_pkt_mmu(struct hl_device *hdev,
 	 * We can't allow user to read from Host using QMANs other than 1.
 	 */
 	if (parser->hw_queue_id > GOYA_QUEUE_ID_DMA_1 &&
-		hl_mem_area_inside_range(user_dma_pkt->src_addr,
-				user_dma_pkt->tsize,
+		hl_mem_area_inside_range(le64_to_cpu(user_dma_pkt->src_addr),
+				le32_to_cpu(user_dma_pkt->tsize),
 				hdev->asic_prop.va_space_host_start_address,
 				hdev->asic_prop.va_space_host_end_address)) {
 		dev_err(hdev->dev,
@@ -3769,7 +3783,8 @@ static int goya_validate_wreg32(struct hl_device *hdev,
 	u32 sob_start_addr, sob_end_addr;
 	u16 reg_offset;
 
-	reg_offset = wreg_pkt->ctl & GOYA_PKT_WREG32_CTL_REG_OFFSET_MASK;
+	reg_offset = le32_to_cpu(wreg_pkt->ctl) &
+			GOYA_PKT_WREG32_CTL_REG_OFFSET_MASK;
 
 	dev_dbg(hdev->dev, "WREG32 packet details:\n");
 	dev_dbg(hdev->dev, "reg_offset == 0x%x\n", reg_offset);
@@ -3792,8 +3807,8 @@ static int goya_validate_wreg32(struct hl_device *hdev,
 	sob_start_addr = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
 	sob_end_addr = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1023);
 
-	if ((wreg_pkt->value < sob_start_addr) ||
-			(wreg_pkt->value > sob_end_addr)) {
+	if ((le32_to_cpu(wreg_pkt->value) < sob_start_addr) ||
+			(le32_to_cpu(wreg_pkt->value) > sob_end_addr)) {
 
 		dev_err(hdev->dev, "WREG32 packet with illegal value 0x%x\n",
 			wreg_pkt->value);
@@ -3919,12 +3934,14 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 	struct sg_table *sgt;
 	bool skip_host_mem_pin = false;
 	bool user_memset;
-	u32 user_rdcomp_mask, user_wrcomp_mask;
+	u32 user_rdcomp_mask, user_wrcomp_mask, ctl;
 
-	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+	ctl = le32_to_cpu(user_dma_pkt->ctl);
+
+	user_dir = (ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 
-	user_memset = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
+	user_memset = (ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT;
 
 	if ((user_dir == DMA_DRAM_TO_SRAM) || (user_dir == DMA_SRAM_TO_DRAM) ||
@@ -3935,19 +3952,20 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 	}
 
 	if ((user_dir == DMA_HOST_TO_DRAM) || (user_dir == DMA_HOST_TO_SRAM)) {
-		addr = user_dma_pkt->src_addr;
-		device_memory_addr = user_dma_pkt->dst_addr;
+		addr = le64_to_cpu(user_dma_pkt->src_addr);
+		device_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
 		dir = DMA_TO_DEVICE;
 		if (user_memset)
 			skip_host_mem_pin = true;
 	} else {
-		addr = user_dma_pkt->dst_addr;
-		device_memory_addr = user_dma_pkt->src_addr;
+		addr = le64_to_cpu(user_dma_pkt->dst_addr);
+		device_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
 		dir = DMA_FROM_DEVICE;
 	}
 
 	if ((!skip_host_mem_pin) &&
-		(hl_userptr_is_pinned(hdev, addr, user_dma_pkt->tsize,
+		(hl_userptr_is_pinned(hdev, addr,
+			le32_to_cpu(user_dma_pkt->tsize),
 			parser->job_userptr_list, &userptr) == false)) {
 		dev_err(hdev->dev, "Userptr 0x%llx + 0x%x NOT mapped\n",
 				addr, user_dma_pkt->tsize);
@@ -3960,11 +3978,9 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 		return 0;
 	}
 
-	user_rdcomp_mask =
-			(user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK);
+	user_rdcomp_mask = ctl & GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK;
 
-	user_wrcomp_mask =
-			(user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK);
+	user_wrcomp_mask = ctl & GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK;
 
 	sgt = userptr->sgt;
 	dma_desc_cnt = 0;
@@ -3994,21 +4010,22 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 			}
 		}
 
-		new_dma_pkt->ctl = user_dma_pkt->ctl;
+		ctl = le32_to_cpu(user_dma_pkt->ctl);
 		if (likely(dma_desc_cnt))
-			new_dma_pkt->ctl &= ~GOYA_PKT_CTL_EB_MASK;
-		new_dma_pkt->ctl &= ~(GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK |
-					GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK);
-		new_dma_pkt->tsize = len;
+			ctl &= ~GOYA_PKT_CTL_EB_MASK;
+		ctl &= ~(GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK |
+				GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK);
+		new_dma_pkt->ctl = cpu_to_le32(ctl);
+		new_dma_pkt->tsize = cpu_to_le32((u32) len);
 
 		dma_addr += hdev->asic_prop.host_phys_base_address;
 
 		if (dir == DMA_TO_DEVICE) {
-			new_dma_pkt->src_addr = dma_addr;
-			new_dma_pkt->dst_addr = device_memory_addr;
+			new_dma_pkt->src_addr = cpu_to_le64(dma_addr);
+			new_dma_pkt->dst_addr = cpu_to_le64(device_memory_addr);
 		} else {
-			new_dma_pkt->src_addr = device_memory_addr;
-			new_dma_pkt->dst_addr = dma_addr;
+			new_dma_pkt->src_addr = cpu_to_le64(device_memory_addr);
+			new_dma_pkt->dst_addr = cpu_to_le64(dma_addr);
 		}
 
 		if (!user_memset)
@@ -4025,7 +4042,7 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 
 	/* Fix the last dma packet - rdcomp/wrcomp must be as user set them */
 	new_dma_pkt--;
-	new_dma_pkt->ctl |= (user_rdcomp_mask | user_wrcomp_mask);
+	new_dma_pkt->ctl |= cpu_to_le32(user_rdcomp_mask | user_wrcomp_mask);
 
 	*new_dma_pkt_size = dma_desc_cnt * sizeof(struct packet_lin_dma);
 
@@ -4302,22 +4319,25 @@ void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
 				u32 cq_val, u32 msix_vec)
 {
 	struct packet_msg_prot *cq_pkt;
+	u32 tmp;
 
 	cq_pkt = (struct packet_msg_prot *) (uintptr_t)
 		(kernel_address + len - (sizeof(struct packet_msg_prot) * 2));
 
-	cq_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+	tmp = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
 			(1 << GOYA_PKT_CTL_EB_SHIFT) |
 			(1 << GOYA_PKT_CTL_MB_SHIFT);
-	cq_pkt->value = cq_val;
-	cq_pkt->addr = cq_addr;
+	cq_pkt->ctl = cpu_to_le32(tmp);
+	cq_pkt->value = cpu_to_le32(cq_val);
+	cq_pkt->addr = cpu_to_le64(cq_addr);
 
 	cq_pkt++;
 
-	cq_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+	tmp = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
 			(1 << GOYA_PKT_CTL_MB_SHIFT);
-	cq_pkt->value = msix_vec & 0x7FF;
-	cq_pkt->addr = CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF;
+	cq_pkt->ctl = cpu_to_le32(tmp);
+	cq_pkt->value = cpu_to_le32(msix_vec & 0x7FF);
+	cq_pkt->addr = cpu_to_le64(CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF);
 }
 
 static void goya_update_eq_ci(struct hl_device *hdev, u32 val)
@@ -4640,11 +4660,11 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	if (!pkt)
 		return -ENOMEM;
 
-	pkt->length = irq_arr_size / sizeof(irq_arr[0]);
+	pkt->length = cpu_to_le32(irq_arr_size / sizeof(irq_arr[0]));
 	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
 
-	pkt->armcp_pkt.ctl = ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
 			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
@@ -4675,8 +4695,9 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_UNMASK_RAZWI_IRQ << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.value = event_type;
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = cpu_to_le64(event_type);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_DEVICE_TIMEOUT_USEC, &result);
@@ -4689,8 +4710,9 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 {
-	u16 event_type = ((eq_entry->hdr.ctl & EQ_CTL_EVENT_TYPE_MASK)
-			>> EQ_CTL_EVENT_TYPE_SHIFT);
+	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
+	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
+				>> EQ_CTL_EVENT_TYPE_SHIFT);
 	struct goya_device *goya = hdev->asic_specific;
 
 	goya->events_stat[event_type]++;
@@ -4800,7 +4822,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
 	struct packet_lin_dma *lin_dma_pkt;
 	struct hl_cs_parser parser;
 	struct hl_cs_job *job;
-	u32 cb_size;
+	u32 cb_size, ctl;
 	struct hl_cb *cb;
 	int rc;
 
@@ -4813,18 +4835,18 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
 	memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
 	cb_size = sizeof(*lin_dma_pkt);
 
-	lin_dma_pkt->ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
-				(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
-				(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
-				(1 << GOYA_PKT_CTL_RB_SHIFT) |
-				(1 << GOYA_PKT_CTL_MB_SHIFT));
-
-	lin_dma_pkt->ctl |= (is_dram ? DMA_HOST_TO_DRAM : DMA_HOST_TO_SRAM) <<
-				GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+	ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
+			(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
+			(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
+			(1 << GOYA_PKT_CTL_RB_SHIFT) |
+			(1 << GOYA_PKT_CTL_MB_SHIFT));
+	ctl |= (is_dram ? DMA_HOST_TO_DRAM : DMA_HOST_TO_SRAM) <<
+			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+	lin_dma_pkt->ctl = cpu_to_le32(ctl);
 
-	lin_dma_pkt->src_addr = val;
-	lin_dma_pkt->dst_addr = addr;
-	lin_dma_pkt->tsize = size;
+	lin_dma_pkt->src_addr = cpu_to_le64(val);
+	lin_dma_pkt->dst_addr = cpu_to_le64(addr);
+	lin_dma_pkt->tsize = cpu_to_le32(size);
 
 	job = hl_cs_allocate_job(hdev, true);
 	if (!job) {
@@ -5077,8 +5099,9 @@ int goya_send_heartbeat(struct hl_device *hdev)
 
 	memset(&hb_pkt, 0, sizeof(hb_pkt));
 
-	hb_pkt.ctl = ARMCP_PACKET_TEST << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	hb_pkt.value = ARMCP_PACKET_FENCE_VAL;
+	hb_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
+					ARMCP_PKT_CTL_OPCODE_SHIFT);
+	hb_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
 			sizeof(hb_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
@@ -5116,9 +5139,11 @@ static int goya_armcp_info_get(struct hl_device *hdev)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_INFO_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.addr = armcp_info_dma_addr + prop->host_phys_base_address;
-	pkt.data_max_size = sizeof(struct armcp_info);
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_INFO_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(armcp_info_dma_addr +
+				prop->host_phys_base_address);
+	pkt.data_max_size = cpu_to_le32(sizeof(struct armcp_info));
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			GOYA_ARMCP_INFO_TIMEOUT, &result);
@@ -5132,7 +5157,7 @@ static int goya_armcp_info_get(struct hl_device *hdev)
 	memcpy(&prop->armcp_info, armcp_info_cpu_addr,
 			sizeof(prop->armcp_info));
 
-	dram_size = prop->armcp_info.dram_size;
+	dram_size = le64_to_cpu(prop->armcp_info.dram_size);
 	if (dram_size) {
 		if ((!is_power_of_2(dram_size)) ||
 				(dram_size < DRAM_PHYS_DEFAULT_SIZE)) {
@@ -5270,9 +5295,11 @@ static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = ARMCP_PACKET_EEPROM_DATA_GET << ARMCP_PKT_CTL_OPCODE_SHIFT;
-	pkt.addr = eeprom_info_dma_addr + prop->host_phys_base_address;
-	pkt.data_max_size = max_size;
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_EEPROM_DATA_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(eeprom_info_dma_addr +
+				prop->host_phys_base_address);
+	pkt.data_max_size = cpu_to_le32(max_size);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			GOYA_ARMCP_EEPROM_TIMEOUT, &result);
-- 
2.17.1

