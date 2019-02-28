Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07530C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26EB2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaAo9krV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfB1Iqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44969 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfB1Iqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so20929503wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qdYphrNH8O/XTmqEO1Xrw9r9rNYQmUYQCoaZlZXbEmU=;
        b=eaAo9krVoDjbfxps+fhsX4TD4D5EFjJaP04BzfHB7lw1WxRNIaG/U37k+P9TXFq3s2
         87nCPQM5q5G5t179iSWqnrEFeGydTrwr2QOR+4zDm+TqSkZIwqklnZ8uIxDFqMi0uRom
         FzlFpUyJY55r9I+33A06jBP5iEBG/NMUT19GeT7Knx/jnc6TCEIgK0FN6wjqpvvVrwbV
         WeR0g+k6Nv9Fh1czeIsOPvbM6HDNkR6P0wovl3N54VRimeOyyA0t7rHpMfhQ9WG54wKH
         xs5Bbg1RAkIBqYLDCW1J3pMErGuDK5PQYhNCis2SPAI+bq1wmNZ62cg5t5PchKFHvrwy
         N8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qdYphrNH8O/XTmqEO1Xrw9r9rNYQmUYQCoaZlZXbEmU=;
        b=OQA47351ZQHQljLS9vRDRnn5NXRP/4NVgUcw9QmRfrjbzldNqbEw9f3IR7omINrOLJ
         dBvHi3zy8RsMeF726jGHxhK9h88myYWQOJKSeyK5yFnV0aFkKkqOlsriSvyxR0doUb0n
         GEsWSbANhN4lhKOyEnVSI7RwMrMlXN1DbXBPEzySwiDso2tKwH5OvJXYKWn4Zmj6xQ/T
         kFv5HhYXiIacbgVjfJo1GuuSVjDifjbesnefpPPfhDdi8DNezpof67irW5fOHKMov8Rm
         f6LKG622SVvPmE2MP50+JJdPhdDSFXP7CLFPwdtb5QKJBYELWC2sMgUd+xWkjEUjZTzv
         zN2w==
X-Gm-Message-State: APjAAAXMxZV7Y/Ms6MWbWqQoHhYxKREefgWwKzkxtdgTOSTaWfPs9mQF
        MHix1Uqt0qJLiXoSg2N84d1fXFpk
X-Google-Smtp-Source: APXvYqzf9o3uPybSoSO8vmlZ4wpkxIuyReDBmv2/azzI/7n/E2SKDupr+G2WeD831ro9ZrHox7I3LQ==
X-Received: by 2002:adf:f846:: with SMTP id d6mr5679731wrq.53.1551343593388;
        Thu, 28 Feb 2019 00:46:33 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:32 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 01/15] habanalabs: Dissociate RAZWI info from event types
Date:   Thu, 28 Feb 2019 10:46:10 +0200
Message-Id: <20190228084624.25288-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

This patch provides a workaround for a H/W bug in the RAZWI logger in
Goya. The logger doesn't recognize the initiator correctly and as a
result, accesses from one initiator are reported that were coming from a
different initiator.

The WA is to print the error information from the event entries we receive
without looking at the RAZWI logger at all.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 227 ++++++++++++++++------------
 1 file changed, 127 insertions(+), 100 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 54218f147627..447d907bddf3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -111,29 +111,6 @@ static u16 goya_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_STOP]		= sizeof(struct packet_stop)
 };
 
-static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
-	"MME0",
-	"MME1",
-	"MME2",
-	"MME3",
-	"MME4",
-	"MME5",
-	"TPC0",
-	"TPC1",
-	"TPC2",
-	"TPC3",
-	"TPC4",
-	"TPC5",
-	"TPC6",
-	"TPC7",
-	"PCI",
-	"DMA", /* HBW */
-	"DMA", /* LBW */
-	"PSOC",
-	"CPU",
-	"MMU"
-};
-
 static u64 goya_mmu_regs[GOYA_MMU_REGS_NUM] = {
 	mmDMA_QM_0_GLBL_NON_SECURE_PROPS,
 	mmDMA_QM_1_GLBL_NON_SECURE_PROPS,
@@ -4554,111 +4531,161 @@ static void goya_write_pte(struct hl_device *hdev, u64 addr, u64 val)
 			(addr - goya->ddr_bar_cur_addr));
 }
 
-static void goya_get_axi_name(struct hl_device *hdev, u32 agent_id,
-		u16 event_type, char *axi_name, int len)
+static const char *_goya_get_event_desc(u16 event_type)
 {
-	if (!strcmp(goya_axi_name[agent_id], "DMA"))
-		if (event_type >= GOYA_ASYNC_EVENT_ID_DMA0_CH)
-			snprintf(axi_name, len, "DMA %d",
-				event_type - GOYA_ASYNC_EVENT_ID_DMA0_CH);
-		else
-			snprintf(axi_name, len, "DMA %d",
-				event_type - GOYA_ASYNC_EVENT_ID_DMA0_QM);
-	else
-		snprintf(axi_name, len, "%s", goya_axi_name[agent_id]);
+	switch (event_type) {
+	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
+		return "PCIe_dec";
+	case GOYA_ASYNC_EVENT_ID_TPC0_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC1_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC2_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC3_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC4_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC5_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC6_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC7_DEC:
+		return "TPC%d_dec";
+	case GOYA_ASYNC_EVENT_ID_MME_WACS:
+		return "MME_wacs";
+	case GOYA_ASYNC_EVENT_ID_MME_WACSD:
+		return "MME_wacsd";
+	case GOYA_ASYNC_EVENT_ID_CPU_AXI_SPLITTER:
+		return "CPU_axi_splitter";
+	case GOYA_ASYNC_EVENT_ID_PSOC_AXI_DEC:
+		return "PSOC_axi_dec";
+	case GOYA_ASYNC_EVENT_ID_PSOC:
+		return "PSOC";
+	case GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR:
+		return "TPC%d_krn_err";
+	case GOYA_ASYNC_EVENT_ID_TPC0_CMDQ ... GOYA_ASYNC_EVENT_ID_TPC7_CMDQ:
+		return "TPC%d_cq";
+	case GOYA_ASYNC_EVENT_ID_TPC0_QM ... GOYA_ASYNC_EVENT_ID_TPC7_QM:
+		return "TPC%d_qm";
+	case GOYA_ASYNC_EVENT_ID_MME_QM:
+		return "MME_qm";
+	case GOYA_ASYNC_EVENT_ID_MME_CMDQ:
+		return "MME_cq";
+	case GOYA_ASYNC_EVENT_ID_DMA0_QM ... GOYA_ASYNC_EVENT_ID_DMA4_QM:
+		return "DMA%d_qm";
+	case GOYA_ASYNC_EVENT_ID_DMA0_CH ... GOYA_ASYNC_EVENT_ID_DMA4_CH:
+		return "DMA%d_ch";
+	default:
+		return "N/A";
+	}
 }
 
-static void goya_print_razwi_info(struct hl_device *hdev, u64 reg,
-		bool is_hbw, bool is_read, u16 event_type)
+static void goya_get_event_desc(u16 event_type, char *desc, size_t size)
 {
-	u32 val, agent_id;
-	char axi_name[10] = {0};
-
-	val = RREG32(reg);
+	u8 index;
 
-	if (is_hbw)
-		agent_id = (val & GOYA_IRQ_HBW_AGENT_ID_MASK) >>
-				GOYA_IRQ_HBW_AGENT_ID_SHIFT;
-	else
-		agent_id = (val & GOYA_IRQ_LBW_AGENT_ID_MASK) >>
-				GOYA_IRQ_LBW_AGENT_ID_SHIFT;
-
-	if (agent_id >= GOYA_MAX_INITIATORS) {
-		dev_err(hdev->dev,
-			"Illegal %s %s with wrong initiator id %d, H/W IRQ %d\n",
-				is_read ? "read from" : "write to",
-				is_hbw ? "HBW" : "LBW",
-				agent_id,
-				event_type);
-	} else {
-		goya_get_axi_name(hdev, agent_id, event_type, axi_name,
-				sizeof(axi_name));
-		dev_err(hdev->dev, "Illegal %s by %s %s %s, H/W IRQ %d\n",
-				is_read ? "read" : "write",
-				axi_name,
-				is_read ? "from" : "to",
-				is_hbw ? "HBW" : "LBW",
-				event_type);
+	switch (event_type) {
+	case GOYA_ASYNC_EVENT_ID_TPC0_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC1_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC2_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC3_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC4_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC5_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC6_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC7_DEC:
+		index = (event_type - GOYA_ASYNC_EVENT_ID_TPC0_DEC) / 3;
+		snprintf(desc, size, _goya_get_event_desc(event_type), index);
+		break;
+	case GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR:
+		index = (event_type - GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR) / 10;
+		snprintf(desc, size, _goya_get_event_desc(event_type), index);
+		break;
+	case GOYA_ASYNC_EVENT_ID_TPC0_CMDQ ... GOYA_ASYNC_EVENT_ID_TPC7_CMDQ:
+		index = event_type - GOYA_ASYNC_EVENT_ID_TPC0_CMDQ;
+		snprintf(desc, size, _goya_get_event_desc(event_type), index);
+		break;
+	case GOYA_ASYNC_EVENT_ID_TPC0_QM ... GOYA_ASYNC_EVENT_ID_TPC7_QM:
+		index = event_type - GOYA_ASYNC_EVENT_ID_TPC0_QM;
+		snprintf(desc, size, _goya_get_event_desc(event_type), index);
+		break;
+	case GOYA_ASYNC_EVENT_ID_DMA0_QM ... GOYA_ASYNC_EVENT_ID_DMA4_QM:
+		index = event_type - GOYA_ASYNC_EVENT_ID_DMA0_QM;
+		snprintf(desc, size, _goya_get_event_desc(event_type), index);
+		break;
+	case GOYA_ASYNC_EVENT_ID_DMA0_CH ... GOYA_ASYNC_EVENT_ID_DMA4_CH:
+		index = event_type - GOYA_ASYNC_EVENT_ID_DMA0_CH;
+		snprintf(desc, size, _goya_get_event_desc(event_type), index);
+		break;
+	default:
+		snprintf(desc, size, _goya_get_event_desc(event_type));
+		break;
 	}
 }
 
-static void goya_print_irq_info(struct hl_device *hdev, u16 event_type)
+static void goya_print_razwi_info(struct hl_device *hdev)
 {
-	struct goya_device *goya = hdev->asic_specific;
-	bool is_hbw = false, is_read = false, is_info = false;
-
 	if (RREG32(mmDMA_MACRO_RAZWI_LBW_WT_VLD)) {
-		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_LBW_WT_ID, is_hbw,
-				is_read, event_type);
+		dev_err(hdev->dev, "Illegal write to LBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_LBW_WT_VLD, 0);
-		is_info = true;
 	}
+
 	if (RREG32(mmDMA_MACRO_RAZWI_LBW_RD_VLD)) {
-		is_read = true;
-		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_LBW_RD_ID, is_hbw,
-				is_read, event_type);
+		dev_err(hdev->dev, "Illegal read from LBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_LBW_RD_VLD, 0);
-		is_info = true;
 	}
+
 	if (RREG32(mmDMA_MACRO_RAZWI_HBW_WT_VLD)) {
-		is_hbw = true;
-		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_HBW_WT_ID, is_hbw,
-				is_read, event_type);
+		dev_err(hdev->dev, "Illegal write to HBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_HBW_WT_VLD, 0);
-		is_info = true;
 	}
+
 	if (RREG32(mmDMA_MACRO_RAZWI_HBW_RD_VLD)) {
-		is_hbw = true;
-		is_read = true;
-		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_HBW_RD_ID, is_hbw,
-				is_read, event_type);
+		dev_err(hdev->dev, "Illegal read from HBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_HBW_RD_VLD, 0);
-		is_info = true;
-	}
-	if (!is_info) {
-		dev_err(hdev->dev,
-			"Received H/W interrupt %d, no additional info\n",
-			event_type);
-		return;
 	}
+}
 
-	if (goya->hw_cap_initialized & HW_CAP_MMU) {
-		u32 val = RREG32(mmMMU_PAGE_ERROR_CAPTURE);
-		u64 addr;
+static void goya_print_mmu_error_info(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u64 addr;
+	u32 val;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
+		return;
 
-		if (val & MMU_PAGE_ERROR_CAPTURE_ENTRY_VALID_MASK) {
-			addr = val & MMU_PAGE_ERROR_CAPTURE_VA_49_32_MASK;
-			addr <<= 32;
-			addr |= RREG32(mmMMU_PAGE_ERROR_CAPTURE_VA);
+	val = RREG32(mmMMU_PAGE_ERROR_CAPTURE);
+	if (val & MMU_PAGE_ERROR_CAPTURE_ENTRY_VALID_MASK) {
+		addr = val & MMU_PAGE_ERROR_CAPTURE_VA_49_32_MASK;
+		addr <<= 32;
+		addr |= RREG32(mmMMU_PAGE_ERROR_CAPTURE_VA);
 
-			dev_err(hdev->dev, "MMU page fault on va 0x%llx\n",
-					addr);
+		dev_err(hdev->dev, "MMU page fault on va 0x%llx\n", addr);
 
-			WREG32(mmMMU_PAGE_ERROR_CAPTURE, 0);
-		}
+		WREG32(mmMMU_PAGE_ERROR_CAPTURE, 0);
 	}
 }
 
+static void goya_print_irq_info(struct hl_device *hdev, u16 event_type)
+{
+	char desc[20] = "";
+
+	goya_get_event_desc(event_type, desc, sizeof(desc));
+	dev_err(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
+		event_type, desc);
+
+	goya_print_razwi_info(hdev);
+	goya_print_mmu_error_info(hdev);
+}
+
 static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 		size_t irq_arr_size)
 {
-- 
2.17.1

