Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F00C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78CA205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFnM0bcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfDBRHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:07:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43989 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:07:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so17584457wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/P6NFKKT+e8CsB1SoEOq22hZiRXABHbDSG/LspMPIo=;
        b=VFnM0bcqBtnUTb7YRoXdx34mLQbZaoobc3g9pkoX/lOuaD0/hV7jKI51cLGJkRjjXT
         OnlpHVaD+D2ihtnOuoj5qmXjkEn2htNGooIOSoIveJ6TJedOpVOwm5hhyHJsQYqS5vAe
         7kmJMhudicAgcGq05/f3pO7X/+m8sOd0JavMxUvMUZvkaL/8XWccB7l4fVYg7se6OzBu
         /Us5dNUtqQKm2n2eQqQc7Bz0Fvg0Tt50PugrDSL08wCOsMT3g43VShUOPaMhLPZDuf7r
         JX7h7Ir06xPdAosjxubDjpPlOhH6N3nQseomi4GmKKW0mhqbVCXZfBysJwZ2Ag9qcImZ
         oCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/P6NFKKT+e8CsB1SoEOq22hZiRXABHbDSG/LspMPIo=;
        b=nResHvz/mSRdXdfhrZy9ywTKKxjiTPsLvS1nUXEBgCXocVRj0pCOouzlbRHG1zVmbI
         8InNss0PyasUvW4uWNSf5QBNYaMOBcP1LyQ0YbT9lpwaOx2mS3cCEtZ8AY+v7GMShaAf
         LScSXfrBpQJyf1n7XSA1wERQdsp2zbxiu0E/LHert5gw7nzOLd8qsz48DzFBBbHZR1R5
         4qmIJovQ1xnCcuBNPgW1dn6XYvp5djPjyD/5AVpy4EU/Let/xlDkh9qVU7TPtqca/y7G
         5LVTg6ZGQzlPCNNNyJGFzFhZ8iG+5IjPW/6n9Rec+L+kDMsm68gxLlXd59M2MSQxsmoS
         EEdA==
X-Gm-Message-State: APjAAAVjm2mnpVD+baMFR8T7+vzPPxTdM0LOK8thRImzU1sqJTjQf92l
        NCfqSehkC8wElhU9T9je60paeuvT
X-Google-Smtp-Source: APXvYqxqjyeXo2s6vsyaGWqdoqqXh22Cmhvq4g07HRd23i00d4FYo5BI1JGjY3smCPAsbho+UtG/2A==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr43231958wre.246.1554224839108;
        Tue, 02 Apr 2019 10:07:19 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id e9sm22098922wrp.35.2019.04.02.10.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 10:07:18 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH v2 3/3] habanalabs: add goya implementation for debug configuration
Date:   Tue,  2 Apr 2019 20:07:09 +0300
Message-Id: <20190402170709.29562-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402170709.29562-1-oded.gabbay@gmail.com>
References: <20190402170709.29562-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch adds the ASIC-specific function for GOYA to configure the
coresight components.

Most of the components have an enabled/disabled flag, depending on whether
the user wants to enable the component or disable it.

For some of the components, such as ETR and SPMU, the user can also
request to read values from them. Those values are needed for the user to
parse the trace data.

The ETR configuration is also checked for security purposes, to make sure
the trace data is written to the device's DRAM.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c           |   9 +-
 drivers/misc/habanalabs/goya/goyaP.h          |   2 +
 drivers/misc/habanalabs/goya/goya_coresight.c | 609 +++++++++++++++++-
 .../include/goya/asic_reg/goya_regs.h         |   3 +-
 .../include/goya/asic_reg/pcie_wrap_regs.h    | 306 +++++++++
 .../habanalabs/include/goya/goya_coresight.h  | 199 ++++++
 6 files changed, 1122 insertions(+), 6 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_wrap_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_coresight.h

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0c2a902facb6..cf4e66abf77e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -69,7 +69,7 @@
  *
  */
 
-#define GOYA_MMU_REGS_NUM		61
+#define GOYA_MMU_REGS_NUM		63
 
 #define GOYA_DMA_POOL_BLK_SIZE		0x100		/* 256 bytes */
 
@@ -85,8 +85,6 @@
 
 #define GOYA_QMAN0_FENCE_VAL		0xD169B243
 
-#define GOYA_MAX_INITIATORS		20
-
 #define GOYA_MAX_STRING_LEN		20
 
 #define GOYA_CB_POOL_CB_CNT		512
@@ -171,7 +169,9 @@ static u64 goya_mmu_regs[GOYA_MMU_REGS_NUM] = {
 	mmMME_SBA_CONTROL_DATA,
 	mmMME_SBB_CONTROL_DATA,
 	mmMME_SBC_CONTROL_DATA,
-	mmMME_WBC_CONTROL_DATA
+	mmMME_WBC_CONTROL_DATA,
+	mmPCIE_WRAP_PSOC_ARUSER,
+	mmPCIE_WRAP_PSOC_AWUSER
 };
 
 static u32 goya_all_events[] = {
@@ -1435,6 +1435,7 @@ static void goya_init_golden_registers(struct hl_device *hdev)
 	 * from Host using DMA CH 1
 	 */
 	WREG32(mmDMA_CH_1_CFG0, 0x0fff00F0);
+
 	WREG32(mmTPC_PLL_CLK_RLX_0, 0x200020);
 
 	goya->hw_cap_initialized |= HW_CAP_GOLDEN;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 6f1f7715075d..2a6cdca744dd 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -43,6 +43,8 @@
 
 #define QMAN_STOP_TIMEOUT_USEC		100000	/* 100 ms */
 
+#define CORESIGHT_TIMEOUT_USEC		100000	/* 100 ms */
+
 #define TPC_ENABLED_MASK		0xFF
 
 #define PLL_HIGH_DEFAULT		1575000000	/* 1.575 GHz */
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 8957b8b1c0d6..68726fb4c56a 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -6,8 +6,615 @@
  */
 
 #include "goyaP.h"
+#include "include/goya/goya_coresight.h"
+#include "include/goya/asic_reg/goya_regs.h"
+
+#include <uapi/misc/habanalabs.h>
+
+#include <linux/coresight.h>
+
+#define GOYA_PLDM_CORESIGHT_TIMEOUT_USEC	(CORESIGHT_TIMEOUT_USEC * 100)
+
+static u64 debug_stm_regs[GOYA_STM_LAST + 1] = {
+	[GOYA_STM_CPU]		= mmCPU_STM_BASE,
+	[GOYA_STM_DMA_CH_0_CS]	= mmDMA_CH_0_CS_STM_BASE,
+	[GOYA_STM_DMA_CH_1_CS]	= mmDMA_CH_1_CS_STM_BASE,
+	[GOYA_STM_DMA_CH_2_CS]	= mmDMA_CH_2_CS_STM_BASE,
+	[GOYA_STM_DMA_CH_3_CS]	= mmDMA_CH_3_CS_STM_BASE,
+	[GOYA_STM_DMA_CH_4_CS]	= mmDMA_CH_4_CS_STM_BASE,
+	[GOYA_STM_DMA_MACRO_CS]	= mmDMA_MACRO_CS_STM_BASE,
+	[GOYA_STM_MME1_SBA]	= mmMME1_SBA_STM_BASE,
+	[GOYA_STM_MME3_SBB]	= mmMME3_SBB_STM_BASE,
+	[GOYA_STM_MME4_WACS2]	= mmMME4_WACS2_STM_BASE,
+	[GOYA_STM_MME4_WACS]	= mmMME4_WACS_STM_BASE,
+	[GOYA_STM_MMU_CS]	= mmMMU_CS_STM_BASE,
+	[GOYA_STM_PCIE]		= mmPCIE_STM_BASE,
+	[GOYA_STM_PSOC]		= mmPSOC_STM_BASE,
+	[GOYA_STM_TPC0_EML]	= mmTPC0_EML_STM_BASE,
+	[GOYA_STM_TPC1_EML]	= mmTPC1_EML_STM_BASE,
+	[GOYA_STM_TPC2_EML]	= mmTPC2_EML_STM_BASE,
+	[GOYA_STM_TPC3_EML]	= mmTPC3_EML_STM_BASE,
+	[GOYA_STM_TPC4_EML]	= mmTPC4_EML_STM_BASE,
+	[GOYA_STM_TPC5_EML]	= mmTPC5_EML_STM_BASE,
+	[GOYA_STM_TPC6_EML]	= mmTPC6_EML_STM_BASE,
+	[GOYA_STM_TPC7_EML]	= mmTPC7_EML_STM_BASE
+};
+
+static u64 debug_etf_regs[GOYA_ETF_LAST + 1] = {
+	[GOYA_ETF_CPU_0]	= mmCPU_ETF_0_BASE,
+	[GOYA_ETF_CPU_1]	= mmCPU_ETF_1_BASE,
+	[GOYA_ETF_CPU_TRACE]	= mmCPU_ETF_TRACE_BASE,
+	[GOYA_ETF_DMA_CH_0_CS]	= mmDMA_CH_0_CS_ETF_BASE,
+	[GOYA_ETF_DMA_CH_1_CS]	= mmDMA_CH_1_CS_ETF_BASE,
+	[GOYA_ETF_DMA_CH_2_CS]	= mmDMA_CH_2_CS_ETF_BASE,
+	[GOYA_ETF_DMA_CH_3_CS]	= mmDMA_CH_3_CS_ETF_BASE,
+	[GOYA_ETF_DMA_CH_4_CS]	= mmDMA_CH_4_CS_ETF_BASE,
+	[GOYA_ETF_DMA_MACRO_CS]	= mmDMA_MACRO_CS_ETF_BASE,
+	[GOYA_ETF_MME1_SBA]	= mmMME1_SBA_ETF_BASE,
+	[GOYA_ETF_MME3_SBB]	= mmMME3_SBB_ETF_BASE,
+	[GOYA_ETF_MME4_WACS2]	= mmMME4_WACS2_ETF_BASE,
+	[GOYA_ETF_MME4_WACS]	= mmMME4_WACS_ETF_BASE,
+	[GOYA_ETF_MMU_CS]	= mmMMU_CS_ETF_BASE,
+	[GOYA_ETF_PCIE]		= mmPCIE_ETF_BASE,
+	[GOYA_ETF_PSOC]		= mmPSOC_ETF_BASE,
+	[GOYA_ETF_TPC0_EML]	= mmTPC0_EML_ETF_BASE,
+	[GOYA_ETF_TPC1_EML]	= mmTPC1_EML_ETF_BASE,
+	[GOYA_ETF_TPC2_EML]	= mmTPC2_EML_ETF_BASE,
+	[GOYA_ETF_TPC3_EML]	= mmTPC3_EML_ETF_BASE,
+	[GOYA_ETF_TPC4_EML]	= mmTPC4_EML_ETF_BASE,
+	[GOYA_ETF_TPC5_EML]	= mmTPC5_EML_ETF_BASE,
+	[GOYA_ETF_TPC6_EML]	= mmTPC6_EML_ETF_BASE,
+	[GOYA_ETF_TPC7_EML]	= mmTPC7_EML_ETF_BASE
+};
+
+static u64 debug_funnel_regs[GOYA_FUNNEL_LAST + 1] = {
+	[GOYA_FUNNEL_CPU]		= mmCPU_FUNNEL_BASE,
+	[GOYA_FUNNEL_DMA_CH_6_1]	= mmDMA_CH_FUNNEL_6_1_BASE,
+	[GOYA_FUNNEL_DMA_MACRO_3_1]	= mmDMA_MACRO_FUNNEL_3_1_BASE,
+	[GOYA_FUNNEL_MME0_RTR]		= mmMME0_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_MME1_RTR]		= mmMME1_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_MME2_RTR]		= mmMME2_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_MME3_RTR]		= mmMME3_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_MME4_RTR]		= mmMME4_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_MME5_RTR]		= mmMME5_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_PCIE]		= mmPCIE_FUNNEL_BASE,
+	[GOYA_FUNNEL_PSOC]		= mmPSOC_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC0_EML]		= mmTPC0_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC1_EML]		= mmTPC1_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC1_RTR]		= mmTPC1_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC2_EML]		= mmTPC2_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC2_RTR]		= mmTPC2_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC3_EML]		= mmTPC3_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC3_RTR]		= mmTPC3_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC4_EML]		= mmTPC4_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC4_RTR]		= mmTPC4_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC5_EML]		= mmTPC5_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC5_RTR]		= mmTPC5_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC6_EML]		= mmTPC6_EML_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC6_RTR]		= mmTPC6_RTR_FUNNEL_BASE,
+	[GOYA_FUNNEL_TPC7_EML]		= mmTPC7_EML_FUNNEL_BASE
+};
+
+static u64 debug_bmon_regs[GOYA_BMON_LAST + 1] = {
+	[GOYA_BMON_CPU_RD]		= mmCPU_RD_BMON_BASE,
+	[GOYA_BMON_CPU_WR]		= mmCPU_WR_BMON_BASE,
+	[GOYA_BMON_DMA_CH_0_0]		= mmDMA_CH_0_BMON_0_BASE,
+	[GOYA_BMON_DMA_CH_0_1]		= mmDMA_CH_0_BMON_1_BASE,
+	[GOYA_BMON_DMA_CH_1_0]		= mmDMA_CH_1_BMON_0_BASE,
+	[GOYA_BMON_DMA_CH_1_1]		= mmDMA_CH_1_BMON_1_BASE,
+	[GOYA_BMON_DMA_CH_2_0]		= mmDMA_CH_2_BMON_0_BASE,
+	[GOYA_BMON_DMA_CH_2_1]		= mmDMA_CH_2_BMON_1_BASE,
+	[GOYA_BMON_DMA_CH_3_0]		= mmDMA_CH_3_BMON_0_BASE,
+	[GOYA_BMON_DMA_CH_3_1]		= mmDMA_CH_3_BMON_1_BASE,
+	[GOYA_BMON_DMA_CH_4_0]		= mmDMA_CH_4_BMON_0_BASE,
+	[GOYA_BMON_DMA_CH_4_1]		= mmDMA_CH_4_BMON_1_BASE,
+	[GOYA_BMON_DMA_MACRO_0]		= mmDMA_MACRO_BMON_0_BASE,
+	[GOYA_BMON_DMA_MACRO_1]		= mmDMA_MACRO_BMON_1_BASE,
+	[GOYA_BMON_DMA_MACRO_2]		= mmDMA_MACRO_BMON_2_BASE,
+	[GOYA_BMON_DMA_MACRO_3]		= mmDMA_MACRO_BMON_3_BASE,
+	[GOYA_BMON_DMA_MACRO_4]		= mmDMA_MACRO_BMON_4_BASE,
+	[GOYA_BMON_DMA_MACRO_5]		= mmDMA_MACRO_BMON_5_BASE,
+	[GOYA_BMON_DMA_MACRO_6]		= mmDMA_MACRO_BMON_6_BASE,
+	[GOYA_BMON_DMA_MACRO_7]		= mmDMA_MACRO_BMON_7_BASE,
+	[GOYA_BMON_MME1_SBA_0]		= mmMME1_SBA_BMON0_BASE,
+	[GOYA_BMON_MME1_SBA_1]		= mmMME1_SBA_BMON1_BASE,
+	[GOYA_BMON_MME3_SBB_0]		= mmMME3_SBB_BMON0_BASE,
+	[GOYA_BMON_MME3_SBB_1]		= mmMME3_SBB_BMON1_BASE,
+	[GOYA_BMON_MME4_WACS2_0]	= mmMME4_WACS2_BMON0_BASE,
+	[GOYA_BMON_MME4_WACS2_1]	= mmMME4_WACS2_BMON1_BASE,
+	[GOYA_BMON_MME4_WACS2_2]	= mmMME4_WACS2_BMON2_BASE,
+	[GOYA_BMON_MME4_WACS_0]		= mmMME4_WACS_BMON0_BASE,
+	[GOYA_BMON_MME4_WACS_1]		= mmMME4_WACS_BMON1_BASE,
+	[GOYA_BMON_MME4_WACS_2]		= mmMME4_WACS_BMON2_BASE,
+	[GOYA_BMON_MME4_WACS_3]		= mmMME4_WACS_BMON3_BASE,
+	[GOYA_BMON_MME4_WACS_4]		= mmMME4_WACS_BMON4_BASE,
+	[GOYA_BMON_MME4_WACS_5]		= mmMME4_WACS_BMON5_BASE,
+	[GOYA_BMON_MME4_WACS_6]		= mmMME4_WACS_BMON6_BASE,
+	[GOYA_BMON_MMU_0]		= mmMMU_BMON_0_BASE,
+	[GOYA_BMON_MMU_1]		= mmMMU_BMON_1_BASE,
+	[GOYA_BMON_PCIE_MSTR_RD]	= mmPCIE_BMON_MSTR_RD_BASE,
+	[GOYA_BMON_PCIE_MSTR_WR]	= mmPCIE_BMON_MSTR_WR_BASE,
+	[GOYA_BMON_PCIE_SLV_RD]		= mmPCIE_BMON_SLV_RD_BASE,
+	[GOYA_BMON_PCIE_SLV_WR]		= mmPCIE_BMON_SLV_WR_BASE,
+	[GOYA_BMON_TPC0_EML_0]		= mmTPC0_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC0_EML_1]		= mmTPC0_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC0_EML_2]		= mmTPC0_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC0_EML_3]		= mmTPC0_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC1_EML_0]		= mmTPC1_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC1_EML_1]		= mmTPC1_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC1_EML_2]		= mmTPC1_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC1_EML_3]		= mmTPC1_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC2_EML_0]		= mmTPC2_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC2_EML_1]		= mmTPC2_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC2_EML_2]		= mmTPC2_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC2_EML_3]		= mmTPC2_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC3_EML_0]		= mmTPC3_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC3_EML_1]		= mmTPC3_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC3_EML_2]		= mmTPC3_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC3_EML_3]		= mmTPC3_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC4_EML_0]		= mmTPC4_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC4_EML_1]		= mmTPC4_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC4_EML_2]		= mmTPC4_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC4_EML_3]		= mmTPC4_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC5_EML_0]		= mmTPC5_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC5_EML_1]		= mmTPC5_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC5_EML_2]		= mmTPC5_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC5_EML_3]		= mmTPC5_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC6_EML_0]		= mmTPC6_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC6_EML_1]		= mmTPC6_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC6_EML_2]		= mmTPC6_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC6_EML_3]		= mmTPC6_EML_BUSMON_3_BASE,
+	[GOYA_BMON_TPC7_EML_0]		= mmTPC7_EML_BUSMON_0_BASE,
+	[GOYA_BMON_TPC7_EML_1]		= mmTPC7_EML_BUSMON_1_BASE,
+	[GOYA_BMON_TPC7_EML_2]		= mmTPC7_EML_BUSMON_2_BASE,
+	[GOYA_BMON_TPC7_EML_3]		= mmTPC7_EML_BUSMON_3_BASE
+};
+
+static u64 debug_spmu_regs[GOYA_SPMU_LAST + 1] = {
+	[GOYA_SPMU_DMA_CH_0_CS]		= mmDMA_CH_0_CS_SPMU_BASE,
+	[GOYA_SPMU_DMA_CH_1_CS]		= mmDMA_CH_1_CS_SPMU_BASE,
+	[GOYA_SPMU_DMA_CH_2_CS]		= mmDMA_CH_2_CS_SPMU_BASE,
+	[GOYA_SPMU_DMA_CH_3_CS]		= mmDMA_CH_3_CS_SPMU_BASE,
+	[GOYA_SPMU_DMA_CH_4_CS]		= mmDMA_CH_4_CS_SPMU_BASE,
+	[GOYA_SPMU_DMA_MACRO_CS]	= mmDMA_MACRO_CS_SPMU_BASE,
+	[GOYA_SPMU_MME1_SBA]		= mmMME1_SBA_SPMU_BASE,
+	[GOYA_SPMU_MME3_SBB]		= mmMME3_SBB_SPMU_BASE,
+	[GOYA_SPMU_MME4_WACS2]		= mmMME4_WACS2_SPMU_BASE,
+	[GOYA_SPMU_MME4_WACS]		= mmMME4_WACS_SPMU_BASE,
+	[GOYA_SPMU_MMU_CS]		= mmMMU_CS_SPMU_BASE,
+	[GOYA_SPMU_PCIE]		= mmPCIE_SPMU_BASE,
+	[GOYA_SPMU_TPC0_EML]		= mmTPC0_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC1_EML]		= mmTPC1_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC2_EML]		= mmTPC2_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC3_EML]		= mmTPC3_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC4_EML]		= mmTPC4_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC5_EML]		= mmTPC5_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC6_EML]		= mmTPC6_EML_SPMU_BASE,
+	[GOYA_SPMU_TPC7_EML]		= mmTPC7_EML_SPMU_BASE
+};
+
+static int goya_coresight_timeout(struct hl_device *hdev, u64 addr,
+		int position, bool up)
+{
+	int rc;
+	u32 val, timeout_usec;
+
+	if (hdev->pldm)
+		timeout_usec = GOYA_PLDM_CORESIGHT_TIMEOUT_USEC;
+	else
+		timeout_usec = CORESIGHT_TIMEOUT_USEC;
+
+	rc = hl_poll_timeout(
+		hdev,
+		addr,
+		val,
+		up ? val & BIT(position) : !(val & BIT(position)),
+		1000,
+		timeout_usec);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Timeout while waiting for coresight, addr: 0x%llx, position: %d, up: %d\n",
+				addr, position, up);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int goya_config_stm(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_stm *input;
+	u64 base_reg = debug_stm_regs[params->reg_idx] - CFG_BASE;
+	int rc;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		WREG32(base_reg + 0xE80, 0x80004);
+		WREG32(base_reg + 0xD64, 7);
+		WREG32(base_reg + 0xD60, 0);
+		WREG32(base_reg + 0xD00, lower_32_bits(input->he_mask));
+		WREG32(base_reg + 0xD20, lower_32_bits(input->sp_mask));
+		WREG32(base_reg + 0xD60, 1);
+		WREG32(base_reg + 0xD00, upper_32_bits(input->he_mask));
+		WREG32(base_reg + 0xD20, upper_32_bits(input->sp_mask));
+		WREG32(base_reg + 0xE70, 0x10);
+		WREG32(base_reg + 0xE60, 0);
+		WREG32(base_reg + 0xE64, 0x420000);
+		WREG32(base_reg + 0xE00, 0xFFFFFFFF);
+		WREG32(base_reg + 0xE20, 0xFFFFFFFF);
+		WREG32(base_reg + 0xEF4, input->id);
+		WREG32(base_reg + 0xDF4, 0x80);
+		WREG32(base_reg + 0xE8C, input->frequency);
+		WREG32(base_reg + 0xE90, 0x7FF);
+		WREG32(base_reg + 0xE80, 0x7 | (input->id << 16));
+	} else {
+		WREG32(base_reg + 0xE80, 4);
+		WREG32(base_reg + 0xD64, 0);
+		WREG32(base_reg + 0xD60, 1);
+		WREG32(base_reg + 0xD00, 0);
+		WREG32(base_reg + 0xD20, 0);
+		WREG32(base_reg + 0xD60, 0);
+		WREG32(base_reg + 0xE20, 0);
+		WREG32(base_reg + 0xE00, 0);
+		WREG32(base_reg + 0xDF4, 0x80);
+		WREG32(base_reg + 0xE70, 0);
+		WREG32(base_reg + 0xE60, 0);
+		WREG32(base_reg + 0xE64, 0);
+		WREG32(base_reg + 0xE8C, 0);
+
+		rc = goya_coresight_timeout(hdev, base_reg + 0xE80, 23, false);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to disable STM on timeout, error %d\n",
+				rc);
+			return rc;
+		}
+
+		WREG32(base_reg + 0xE80, 4);
+	}
+
+	return 0;
+}
+
+static int goya_config_etf(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_etf *input;
+	u64 base_reg = debug_etf_regs[params->reg_idx] - CFG_BASE;
+	u32 val;
+	int rc;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	val = RREG32(base_reg + 0x304);
+	val |= 0x1000;
+	WREG32(base_reg + 0x304, val);
+	val |= 0x40;
+	WREG32(base_reg + 0x304, val);
+
+	rc = goya_coresight_timeout(hdev, base_reg + 0x304, 6, false);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to %s ETF on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	rc = goya_coresight_timeout(hdev, base_reg + 0xC, 2, true);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to %s ETF on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	WREG32(base_reg + 0x20, 0);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		WREG32(base_reg + 0x34, 0x3FFC);
+		WREG32(base_reg + 0x28, input->sink_mode);
+		WREG32(base_reg + 0x304, 0x4001);
+		WREG32(base_reg + 0x308, 0xA);
+		WREG32(base_reg + 0x20, 1);
+	} else {
+		WREG32(base_reg + 0x34, 0);
+		WREG32(base_reg + 0x28, 0);
+		WREG32(base_reg + 0x304, 0);
+	}
+
+	return 0;
+}
+
+static int goya_etr_validate_address(struct hl_device *hdev, u64 addr,
+		u32 size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 range_start, range_end;
+
+	if (hdev->mmu_enable) {
+		range_start = prop->va_space_dram_start_address;
+		range_end = prop->va_space_dram_end_address;
+	} else {
+		range_start = prop->dram_user_base_address;
+		range_end = prop->dram_end_address;
+	}
+
+	return hl_mem_area_inside_range(addr, size, range_start, range_end);
+}
+
+static int goya_config_etr(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_etr *input;
+	u64 base_reg = mmPSOC_ETR_BASE - CFG_BASE;
+	u32 val;
+	int rc;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	val = RREG32(base_reg + 0x304);
+	val |= 0x1000;
+	WREG32(base_reg + 0x304, val);
+	val |= 0x40;
+	WREG32(base_reg + 0x304, val);
+
+	rc = goya_coresight_timeout(hdev, base_reg + 0x304, 6, false);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	rc = goya_coresight_timeout(hdev, base_reg + 0xC, 2, true);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
+				params->enable ? "enable" : "disable", rc);
+		return rc;
+	}
+
+	WREG32(base_reg + 0x20, 0);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		if (input->buffer_size == 0) {
+			dev_err(hdev->dev,
+				"ETR buffer size should be bigger than 0\n");
+			return -EINVAL;
+		}
+
+		if (!goya_etr_validate_address(hdev,
+				input->buffer_address, input->buffer_size)) {
+			dev_err(hdev->dev, "buffer address is not valid\n");
+			return -EINVAL;
+		}
+
+		WREG32(base_reg + 0x34, 0x3FFC);
+		WREG32(base_reg + 0x4, input->buffer_size);
+		WREG32(base_reg + 0x28, input->sink_mode);
+		WREG32(base_reg + 0x110, 0x700);
+		WREG32(base_reg + 0x118,
+				lower_32_bits(input->buffer_address));
+		WREG32(base_reg + 0x11C,
+				upper_32_bits(input->buffer_address));
+		WREG32(base_reg + 0x304, 3);
+		WREG32(base_reg + 0x308, 0xA);
+		WREG32(base_reg + 0x20, 1);
+	} else {
+		WREG32(base_reg + 0x34, 0);
+		WREG32(base_reg + 0x4, 0x400);
+		WREG32(base_reg + 0x118, 0);
+		WREG32(base_reg + 0x11C, 0);
+		WREG32(base_reg + 0x308, 0);
+		WREG32(base_reg + 0x28, 0);
+		WREG32(base_reg + 0x304, 0);
+
+		if (params->output_size >= sizeof(u32))
+			*(u32 *) params->output = RREG32(base_reg + 0x18);
+	}
+
+	return 0;
+}
+
+static int goya_config_funnel(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	WREG32(debug_funnel_regs[params->reg_idx] - CFG_BASE + 0xFB0,
+			CORESIGHT_UNLOCK);
+
+	WREG32(debug_funnel_regs[params->reg_idx] - CFG_BASE,
+			params->enable ? 0x33F : 0);
+
+	return 0;
+}
+
+static int goya_config_bmon(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	struct hl_debug_params_bmon *input;
+	u64 base_reg = debug_bmon_regs[params->reg_idx] - CFG_BASE;
+	u32 pcie_base = 0;
+
+	WREG32(base_reg + 0x104, 1);
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		WREG32(base_reg + 0x208, lower_32_bits(input->addr_range0));
+		WREG32(base_reg + 0x20C, upper_32_bits(input->addr_range0));
+		WREG32(base_reg + 0x248, lower_32_bits(input->addr_range1));
+		WREG32(base_reg + 0x24C, upper_32_bits(input->addr_range1));
+		WREG32(base_reg + 0x224, 0);
+		WREG32(base_reg + 0x234, 0);
+		WREG32(base_reg + 0x30C, input->bw_win);
+		WREG32(base_reg + 0x308, input->win_capture);
+
+		/* PCIE IF BMON bug WA */
+		if (params->reg_idx != GOYA_BMON_PCIE_MSTR_RD &&
+				params->reg_idx != GOYA_BMON_PCIE_MSTR_WR &&
+				params->reg_idx != GOYA_BMON_PCIE_SLV_RD &&
+				params->reg_idx != GOYA_BMON_PCIE_SLV_WR)
+			pcie_base = 0xA000000;
+
+		WREG32(base_reg + 0x700, pcie_base | 0xB00 | (input->id << 12));
+		WREG32(base_reg + 0x708, pcie_base | 0xA00 | (input->id << 12));
+		WREG32(base_reg + 0x70C, pcie_base | 0xC00 | (input->id << 12));
+
+		WREG32(base_reg + 0x100, 0x11);
+		WREG32(base_reg + 0x304, 0x1);
+	} else {
+		WREG32(base_reg + 0x208, 0xFFFFFFFF);
+		WREG32(base_reg + 0x20C, 0xFFFFFFFF);
+		WREG32(base_reg + 0x248, 0xFFFFFFFF);
+		WREG32(base_reg + 0x24C, 0xFFFFFFFF);
+		WREG32(base_reg + 0x224, 0xFFFFFFFF);
+		WREG32(base_reg + 0x234, 0x1070F);
+		WREG32(base_reg + 0x30C, 0);
+		WREG32(base_reg + 0x308, 0xFFFF);
+		WREG32(base_reg + 0x700, 0xA000B00);
+		WREG32(base_reg + 0x708, 0xA000A00);
+		WREG32(base_reg + 0x70C, 0xA000C00);
+		WREG32(base_reg + 0x100, 1);
+		WREG32(base_reg + 0x304, 0);
+		WREG32(base_reg + 0x104, 0);
+	}
+
+	return 0;
+}
+
+static int goya_config_spmu(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	u64 base_reg = debug_spmu_regs[params->reg_idx] - CFG_BASE;
+	struct hl_debug_params_spmu *input = params->input;
+	u64 *output;
+	u32 output_arr_len;
+	u32 events_num;
+	u32 overflow_idx;
+	u32 cycle_cnt_idx;
+	int i;
+
+	if (params->enable) {
+		input = params->input;
+
+		if (!input)
+			return -EINVAL;
+
+		if (input->event_types_num < 3) {
+			dev_err(hdev->dev,
+				"not enough values for SPMU enable\n");
+			return -EINVAL;
+		}
+
+		WREG32(base_reg + 0xE04, 0x41013046);
+		WREG32(base_reg + 0xE04, 0x41013040);
+
+		for (i = 0 ; i < input->event_types_num ; i++)
+			WREG32(base_reg + 0x400 + i * 4, input->event_types[i]);
+
+		WREG32(base_reg + 0xE04, 0x41013041);
+		WREG32(base_reg + 0xC00, 0x8000003F);
+	} else {
+		output = params->output;
+		output_arr_len = params->output_size / 8;
+		events_num = output_arr_len - 2;
+		overflow_idx = output_arr_len - 2;
+		cycle_cnt_idx = output_arr_len - 1;
+
+		if (!output)
+			return -EINVAL;
+
+		if (output_arr_len < 3) {
+			dev_err(hdev->dev,
+				"not enough values for SPMU disable\n");
+			return -EINVAL;
+		}
+
+		WREG32(base_reg + 0xE04, 0x41013040);
+
+		for (i = 0 ; i < events_num ; i++)
+			output[i] = RREG32(base_reg + i * 8);
+
+		output[overflow_idx] = RREG32(base_reg + 0xCC0);
+
+		output[cycle_cnt_idx] = RREG32(base_reg + 0xFC);
+		output[cycle_cnt_idx] <<= 32;
+		output[cycle_cnt_idx] |= RREG32(base_reg + 0xF8);
+
+		WREG32(base_reg + 0xCC0, 0);
+	}
+
+	return 0;
+}
+
+static int goya_config_timestamp(struct hl_device *hdev,
+		struct hl_debug_params *params)
+{
+	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
+	if (params->enable) {
+		WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0xC, 0);
+		WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0x8, 0);
+		WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 1);
+	}
+
+	return 0;
+}
 
 int goya_debug_coresight(struct hl_device *hdev, void *data)
 {
-	return -ENOTTY;
+	struct hl_debug_params *params = data;
+	u32 val;
+	int rc;
+
+	switch (params->op) {
+	case HL_DEBUG_OP_STM:
+		rc = goya_config_stm(hdev, params);
+		break;
+	case HL_DEBUG_OP_ETF:
+		rc = goya_config_etf(hdev, params);
+		break;
+	case HL_DEBUG_OP_ETR:
+		rc = goya_config_etr(hdev, params);
+		break;
+	case HL_DEBUG_OP_FUNNEL:
+		rc = goya_config_funnel(hdev, params);
+		break;
+	case HL_DEBUG_OP_BMON:
+		rc = goya_config_bmon(hdev, params);
+		break;
+	case HL_DEBUG_OP_SPMU:
+		rc = goya_config_spmu(hdev, params);
+		break;
+	case HL_DEBUG_OP_TIMESTAMP:
+		rc = goya_config_timestamp(hdev, params);
+		break;
+
+	default:
+		dev_err(hdev->dev, "Unknown coresight id %d\n", params->op);
+		return -EINVAL;
+	}
+
+	/* Perform read from the device to flush all configuration */
+	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+
+	return rc;
 }
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
index 6cb0b6e54d41..506e71e201e1 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2018 HabanaLabs, Ltd.
+ * Copyright 2016-2019 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -12,6 +12,7 @@
 #include "stlb_regs.h"
 #include "mmu_regs.h"
 #include "pcie_aux_regs.h"
+#include "pcie_wrap_regs.h"
 #include "psoc_global_conf_regs.h"
 #include "psoc_spi_regs.h"
 #include "psoc_mme_pll_regs.h"
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/pcie_wrap_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/pcie_wrap_regs.h
new file mode 100644
index 000000000000..d1e55aace4a0
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/pcie_wrap_regs.h
@@ -0,0 +1,306 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_PCIE_WRAP_REGS_H_
+#define ASIC_REG_PCIE_WRAP_REGS_H_
+
+/*
+ *****************************************
+ *   PCIE_WRAP (Prototype: PCIE_WRAP)
+ *****************************************
+ */
+
+#define mmPCIE_WRAP_PHY_RST_N                                        0xC01300
+
+#define mmPCIE_WRAP_OUTSTAND_TRANS                                   0xC01400
+
+#define mmPCIE_WRAP_MASK_REQ                                         0xC01404
+
+#define mmPCIE_WRAP_IND_AWADDR_L                                     0xC01500
+
+#define mmPCIE_WRAP_IND_AWADDR_H                                     0xC01504
+
+#define mmPCIE_WRAP_IND_AWLEN                                        0xC01508
+
+#define mmPCIE_WRAP_IND_AWSIZE                                       0xC0150C
+
+#define mmPCIE_WRAP_IND_AWBURST                                      0xC01510
+
+#define mmPCIE_WRAP_IND_AWLOCK                                       0xC01514
+
+#define mmPCIE_WRAP_IND_AWCACHE                                      0xC01518
+
+#define mmPCIE_WRAP_IND_AWPROT                                       0xC0151C
+
+#define mmPCIE_WRAP_IND_AWVALID                                      0xC01520
+
+#define mmPCIE_WRAP_IND_WDATA_0                                      0xC01524
+
+#define mmPCIE_WRAP_IND_WDATA_1                                      0xC01528
+
+#define mmPCIE_WRAP_IND_WDATA_2                                      0xC0152C
+
+#define mmPCIE_WRAP_IND_WDATA_3                                      0xC01530
+
+#define mmPCIE_WRAP_IND_WSTRB                                        0xC01544
+
+#define mmPCIE_WRAP_IND_WLAST                                        0xC01548
+
+#define mmPCIE_WRAP_IND_WVALID                                       0xC0154C
+
+#define mmPCIE_WRAP_IND_BRESP                                        0xC01550
+
+#define mmPCIE_WRAP_IND_BVALID                                       0xC01554
+
+#define mmPCIE_WRAP_IND_ARADDR_0                                     0xC01558
+
+#define mmPCIE_WRAP_IND_ARADDR_1                                     0xC0155C
+
+#define mmPCIE_WRAP_IND_ARLEN                                        0xC01560
+
+#define mmPCIE_WRAP_IND_ARSIZE                                       0xC01564
+
+#define mmPCIE_WRAP_IND_ARBURST                                      0xC01568
+
+#define mmPCIE_WRAP_IND_ARLOCK                                       0xC0156C
+
+#define mmPCIE_WRAP_IND_ARCACHE                                      0xC01570
+
+#define mmPCIE_WRAP_IND_ARPROT                                       0xC01574
+
+#define mmPCIE_WRAP_IND_ARVALID                                      0xC01578
+
+#define mmPCIE_WRAP_IND_RDATA_0                                      0xC0157C
+
+#define mmPCIE_WRAP_IND_RDATA_1                                      0xC01580
+
+#define mmPCIE_WRAP_IND_RDATA_2                                      0xC01584
+
+#define mmPCIE_WRAP_IND_RDATA_3                                      0xC01588
+
+#define mmPCIE_WRAP_IND_RLAST                                        0xC0159C
+
+#define mmPCIE_WRAP_IND_RRESP                                        0xC015A0
+
+#define mmPCIE_WRAP_IND_RVALID                                       0xC015A4
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO                                  0xC015A8
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_HDR_34DW_0                       0xC015AC
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_HDR_34DW_1                       0xC015B0
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_P_TAG                            0xC015B4
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_ATU_BYPAS                        0xC015B8
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_FUNC_NUM                         0xC015BC
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_VFUNC_ACT                        0xC015C0
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_VFUNC_NUM                        0xC015C4
+
+#define mmPCIE_WRAP_IND_AWMISC_INFO_TLPPRFX                          0xC015C8
+
+#define mmPCIE_WRAP_IND_ARMISC_INFO                                  0xC015CC
+
+#define mmPCIE_WRAP_IND_ARMISC_INFO_TLPPRFX                          0xC015D0
+
+#define mmPCIE_WRAP_IND_ARMISC_INFO_ATU_BYP                          0xC015D4
+
+#define mmPCIE_WRAP_IND_ARMISC_INFO_FUNC_NUM                         0xC015D8
+
+#define mmPCIE_WRAP_IND_ARMISC_INFO_VFUNC_ACT                        0xC015DC
+
+#define mmPCIE_WRAP_IND_ARMISC_INFO_VFUNC_NUM                        0xC015E0
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO                                  0xC01800
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_HDR_34DW_0                       0xC01804
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_HDR_34DW_1                       0xC01808
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_P_TAG                            0xC0180C
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_ATU_BYPAS                        0xC01810
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_FUNC_NUM                         0xC01814
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_VFUNC_ACT                        0xC01818
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_VFUNC_NUM                        0xC0181C
+
+#define mmPCIE_WRAP_SLV_AWMISC_INFO_TLPPRFX                          0xC01820
+
+#define mmPCIE_WRAP_SLV_ARMISC_INFO                                  0xC01824
+
+#define mmPCIE_WRAP_SLV_ARMISC_INFO_TLPPRFX                          0xC01828
+
+#define mmPCIE_WRAP_SLV_ARMISC_INFO_ATU_BYP                          0xC0182C
+
+#define mmPCIE_WRAP_SLV_ARMISC_INFO_FUNC_NUM                         0xC01830
+
+#define mmPCIE_WRAP_SLV_ARMISC_INFO_VFUNC_ACT                        0xC01834
+
+#define mmPCIE_WRAP_SLV_ARMISC_INFO_VFUNC_NUM                        0xC01838
+
+#define mmPCIE_WRAP_MAX_QID                                          0xC01900
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_L_0                                 0xC01910
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_L_1                                 0xC01914
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_L_2                                 0xC01918
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_L_3                                 0xC0191C
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_H_0                                 0xC01920
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_H_1                                 0xC01924
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_H_2                                 0xC01928
+
+#define mmPCIE_WRAP_DB_BASE_ADDR_H_3                                 0xC0192C
+
+#define mmPCIE_WRAP_DB_MASK                                          0xC01940
+
+#define mmPCIE_WRAP_SQ_BASE_ADDR_H                                   0xC01A00
+
+#define mmPCIE_WRAP_SQ_BASE_ADDR_L                                   0xC01A04
+
+#define mmPCIE_WRAP_SQ_STRIDE_ACCRESS                                0xC01A08
+
+#define mmPCIE_WRAP_SQ_POP_CMD                                       0xC01A10
+
+#define mmPCIE_WRAP_SQ_POP_DATA                                      0xC01A14
+
+#define mmPCIE_WRAP_DB_INTR_0                                        0xC01A20
+
+#define mmPCIE_WRAP_DB_INTR_1                                        0xC01A24
+
+#define mmPCIE_WRAP_DB_INTR_2                                        0xC01A28
+
+#define mmPCIE_WRAP_DB_INTR_3                                        0xC01A2C
+
+#define mmPCIE_WRAP_DB_INTR_4                                        0xC01A30
+
+#define mmPCIE_WRAP_DB_INTR_5                                        0xC01A34
+
+#define mmPCIE_WRAP_DB_INTR_6                                        0xC01A38
+
+#define mmPCIE_WRAP_DB_INTR_7                                        0xC01A3C
+
+#define mmPCIE_WRAP_MMU_BYPASS_DMA                                   0xC01A80
+
+#define mmPCIE_WRAP_MMU_BYPASS_NON_DMA                               0xC01A84
+
+#define mmPCIE_WRAP_ASID_NON_DMA                                     0xC01A90
+
+#define mmPCIE_WRAP_ASID_DMA_0                                       0xC01AA0
+
+#define mmPCIE_WRAP_ASID_DMA_1                                       0xC01AA4
+
+#define mmPCIE_WRAP_ASID_DMA_2                                       0xC01AA8
+
+#define mmPCIE_WRAP_ASID_DMA_3                                       0xC01AAC
+
+#define mmPCIE_WRAP_ASID_DMA_4                                       0xC01AB0
+
+#define mmPCIE_WRAP_ASID_DMA_5                                       0xC01AB4
+
+#define mmPCIE_WRAP_ASID_DMA_6                                       0xC01AB8
+
+#define mmPCIE_WRAP_ASID_DMA_7                                       0xC01ABC
+
+#define mmPCIE_WRAP_CPU_HOT_RST                                      0xC01AE0
+
+#define mmPCIE_WRAP_AXI_PROT_OVR                                     0xC01AE4
+
+#define mmPCIE_WRAP_CACHE_OVR                                        0xC01B00
+
+#define mmPCIE_WRAP_LOCK_OVR                                         0xC01B04
+
+#define mmPCIE_WRAP_PROT_OVR                                         0xC01B08
+
+#define mmPCIE_WRAP_ARUSER_OVR                                       0xC01B0C
+
+#define mmPCIE_WRAP_AWUSER_OVR                                       0xC01B10
+
+#define mmPCIE_WRAP_ARUSER_OVR_EN                                    0xC01B14
+
+#define mmPCIE_WRAP_AWUSER_OVR_EN                                    0xC01B18
+
+#define mmPCIE_WRAP_MAX_OUTSTAND                                     0xC01B20
+
+#define mmPCIE_WRAP_MST_IN                                           0xC01B24
+
+#define mmPCIE_WRAP_RSP_OK                                           0xC01B28
+
+#define mmPCIE_WRAP_LBW_CACHE_OVR                                    0xC01B40
+
+#define mmPCIE_WRAP_LBW_LOCK_OVR                                     0xC01B44
+
+#define mmPCIE_WRAP_LBW_PROT_OVR                                     0xC01B48
+
+#define mmPCIE_WRAP_LBW_ARUSER_OVR                                   0xC01B4C
+
+#define mmPCIE_WRAP_LBW_AWUSER_OVR                                   0xC01B50
+
+#define mmPCIE_WRAP_LBW_ARUSER_OVR_EN                                0xC01B58
+
+#define mmPCIE_WRAP_LBW_AWUSER_OVR_EN                                0xC01B5C
+
+#define mmPCIE_WRAP_LBW_MAX_OUTSTAND                                 0xC01B60
+
+#define mmPCIE_WRAP_LBW_MST_IN                                       0xC01B64
+
+#define mmPCIE_WRAP_LBW_RSP_OK                                       0xC01B68
+
+#define mmPCIE_WRAP_QUEUE_INIT                                       0xC01C00
+
+#define mmPCIE_WRAP_AXI_SPLIT_INTR_0                                 0xC01C10
+
+#define mmPCIE_WRAP_AXI_SPLIT_INTR_1                                 0xC01C14
+
+#define mmPCIE_WRAP_DB_AWUSER                                        0xC01D00
+
+#define mmPCIE_WRAP_DB_ARUSER                                        0xC01D04
+
+#define mmPCIE_WRAP_PCIE_AWUSER                                      0xC01D08
+
+#define mmPCIE_WRAP_PCIE_ARUSER                                      0xC01D0C
+
+#define mmPCIE_WRAP_PSOC_AWUSER                                      0xC01D10
+
+#define mmPCIE_WRAP_PSOC_ARUSER                                      0xC01D14
+
+#define mmPCIE_WRAP_SCH_Q_AWUSER                                     0xC01D18
+
+#define mmPCIE_WRAP_SCH_Q_ARUSER                                     0xC01D1C
+
+#define mmPCIE_WRAP_PSOC2PCI_AWUSER                                  0xC01D40
+
+#define mmPCIE_WRAP_PSOC2PCI_ARUSER                                  0xC01D44
+
+#define mmPCIE_WRAP_DRAIN_TIMEOUT                                    0xC01D50
+
+#define mmPCIE_WRAP_DRAIN_CFG                                        0xC01D54
+
+#define mmPCIE_WRAP_DB_AXI_ERR                                       0xC01DE0
+
+#define mmPCIE_WRAP_SPMU_INTR                                        0xC01DE4
+
+#define mmPCIE_WRAP_AXI_INTR                                         0xC01DE8
+
+#define mmPCIE_WRAP_E2E_CTRL                                         0xC01DF0
+
+#endif /* ASIC_REG_PCIE_WRAP_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/goya/goya_coresight.h b/drivers/misc/habanalabs/include/goya/goya_coresight.h
new file mode 100644
index 000000000000..6e933c0ca5cd
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_coresight.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GOYA_CORESIGHT_H
+#define GOYA_CORESIGHT_H
+
+enum goya_debug_stm_regs_index {
+	GOYA_STM_FIRST = 0,
+	GOYA_STM_CPU = GOYA_STM_FIRST,
+	GOYA_STM_DMA_CH_0_CS,
+	GOYA_STM_DMA_CH_1_CS,
+	GOYA_STM_DMA_CH_2_CS,
+	GOYA_STM_DMA_CH_3_CS,
+	GOYA_STM_DMA_CH_4_CS,
+	GOYA_STM_DMA_MACRO_CS,
+	GOYA_STM_MME1_SBA,
+	GOYA_STM_MME3_SBB,
+	GOYA_STM_MME4_WACS2,
+	GOYA_STM_MME4_WACS,
+	GOYA_STM_MMU_CS,
+	GOYA_STM_PCIE,
+	GOYA_STM_PSOC,
+	GOYA_STM_TPC0_EML,
+	GOYA_STM_TPC1_EML,
+	GOYA_STM_TPC2_EML,
+	GOYA_STM_TPC3_EML,
+	GOYA_STM_TPC4_EML,
+	GOYA_STM_TPC5_EML,
+	GOYA_STM_TPC6_EML,
+	GOYA_STM_TPC7_EML,
+	GOYA_STM_LAST = GOYA_STM_TPC7_EML
+};
+
+enum goya_debug_etf_regs_index {
+	GOYA_ETF_FIRST = 0,
+	GOYA_ETF_CPU_0 = GOYA_ETF_FIRST,
+	GOYA_ETF_CPU_1,
+	GOYA_ETF_CPU_TRACE,
+	GOYA_ETF_DMA_CH_0_CS,
+	GOYA_ETF_DMA_CH_1_CS,
+	GOYA_ETF_DMA_CH_2_CS,
+	GOYA_ETF_DMA_CH_3_CS,
+	GOYA_ETF_DMA_CH_4_CS,
+	GOYA_ETF_DMA_MACRO_CS,
+	GOYA_ETF_MME1_SBA,
+	GOYA_ETF_MME3_SBB,
+	GOYA_ETF_MME4_WACS2,
+	GOYA_ETF_MME4_WACS,
+	GOYA_ETF_MMU_CS,
+	GOYA_ETF_PCIE,
+	GOYA_ETF_PSOC,
+	GOYA_ETF_TPC0_EML,
+	GOYA_ETF_TPC1_EML,
+	GOYA_ETF_TPC2_EML,
+	GOYA_ETF_TPC3_EML,
+	GOYA_ETF_TPC4_EML,
+	GOYA_ETF_TPC5_EML,
+	GOYA_ETF_TPC6_EML,
+	GOYA_ETF_TPC7_EML,
+	GOYA_ETF_LAST = GOYA_ETF_TPC7_EML
+};
+
+enum goya_debug_funnel_regs_index {
+	GOYA_FUNNEL_FIRST = 0,
+	GOYA_FUNNEL_CPU = GOYA_FUNNEL_FIRST,
+	GOYA_FUNNEL_DMA_CH_6_1,
+	GOYA_FUNNEL_DMA_MACRO_3_1,
+	GOYA_FUNNEL_MME0_RTR,
+	GOYA_FUNNEL_MME1_RTR,
+	GOYA_FUNNEL_MME2_RTR,
+	GOYA_FUNNEL_MME3_RTR,
+	GOYA_FUNNEL_MME4_RTR,
+	GOYA_FUNNEL_MME5_RTR,
+	GOYA_FUNNEL_PCIE,
+	GOYA_FUNNEL_PSOC,
+	GOYA_FUNNEL_TPC0_EML,
+	GOYA_FUNNEL_TPC1_EML,
+	GOYA_FUNNEL_TPC1_RTR,
+	GOYA_FUNNEL_TPC2_EML,
+	GOYA_FUNNEL_TPC2_RTR,
+	GOYA_FUNNEL_TPC3_EML,
+	GOYA_FUNNEL_TPC3_RTR,
+	GOYA_FUNNEL_TPC4_EML,
+	GOYA_FUNNEL_TPC4_RTR,
+	GOYA_FUNNEL_TPC5_EML,
+	GOYA_FUNNEL_TPC5_RTR,
+	GOYA_FUNNEL_TPC6_EML,
+	GOYA_FUNNEL_TPC6_RTR,
+	GOYA_FUNNEL_TPC7_EML,
+	GOYA_FUNNEL_LAST = GOYA_FUNNEL_TPC7_EML
+};
+
+enum goya_debug_bmon_regs_index {
+	GOYA_BMON_FIRST = 0,
+	GOYA_BMON_CPU_RD = GOYA_BMON_FIRST,
+	GOYA_BMON_CPU_WR,
+	GOYA_BMON_DMA_CH_0_0,
+	GOYA_BMON_DMA_CH_0_1,
+	GOYA_BMON_DMA_CH_1_0,
+	GOYA_BMON_DMA_CH_1_1,
+	GOYA_BMON_DMA_CH_2_0,
+	GOYA_BMON_DMA_CH_2_1,
+	GOYA_BMON_DMA_CH_3_0,
+	GOYA_BMON_DMA_CH_3_1,
+	GOYA_BMON_DMA_CH_4_0,
+	GOYA_BMON_DMA_CH_4_1,
+	GOYA_BMON_DMA_MACRO_0,
+	GOYA_BMON_DMA_MACRO_1,
+	GOYA_BMON_DMA_MACRO_2,
+	GOYA_BMON_DMA_MACRO_3,
+	GOYA_BMON_DMA_MACRO_4,
+	GOYA_BMON_DMA_MACRO_5,
+	GOYA_BMON_DMA_MACRO_6,
+	GOYA_BMON_DMA_MACRO_7,
+	GOYA_BMON_MME1_SBA_0,
+	GOYA_BMON_MME1_SBA_1,
+	GOYA_BMON_MME3_SBB_0,
+	GOYA_BMON_MME3_SBB_1,
+	GOYA_BMON_MME4_WACS2_0,
+	GOYA_BMON_MME4_WACS2_1,
+	GOYA_BMON_MME4_WACS2_2,
+	GOYA_BMON_MME4_WACS_0,
+	GOYA_BMON_MME4_WACS_1,
+	GOYA_BMON_MME4_WACS_2,
+	GOYA_BMON_MME4_WACS_3,
+	GOYA_BMON_MME4_WACS_4,
+	GOYA_BMON_MME4_WACS_5,
+	GOYA_BMON_MME4_WACS_6,
+	GOYA_BMON_MMU_0,
+	GOYA_BMON_MMU_1,
+	GOYA_BMON_PCIE_MSTR_RD,
+	GOYA_BMON_PCIE_MSTR_WR,
+	GOYA_BMON_PCIE_SLV_RD,
+	GOYA_BMON_PCIE_SLV_WR,
+	GOYA_BMON_TPC0_EML_0,
+	GOYA_BMON_TPC0_EML_1,
+	GOYA_BMON_TPC0_EML_2,
+	GOYA_BMON_TPC0_EML_3,
+	GOYA_BMON_TPC1_EML_0,
+	GOYA_BMON_TPC1_EML_1,
+	GOYA_BMON_TPC1_EML_2,
+	GOYA_BMON_TPC1_EML_3,
+	GOYA_BMON_TPC2_EML_0,
+	GOYA_BMON_TPC2_EML_1,
+	GOYA_BMON_TPC2_EML_2,
+	GOYA_BMON_TPC2_EML_3,
+	GOYA_BMON_TPC3_EML_0,
+	GOYA_BMON_TPC3_EML_1,
+	GOYA_BMON_TPC3_EML_2,
+	GOYA_BMON_TPC3_EML_3,
+	GOYA_BMON_TPC4_EML_0,
+	GOYA_BMON_TPC4_EML_1,
+	GOYA_BMON_TPC4_EML_2,
+	GOYA_BMON_TPC4_EML_3,
+	GOYA_BMON_TPC5_EML_0,
+	GOYA_BMON_TPC5_EML_1,
+	GOYA_BMON_TPC5_EML_2,
+	GOYA_BMON_TPC5_EML_3,
+	GOYA_BMON_TPC6_EML_0,
+	GOYA_BMON_TPC6_EML_1,
+	GOYA_BMON_TPC6_EML_2,
+	GOYA_BMON_TPC6_EML_3,
+	GOYA_BMON_TPC7_EML_0,
+	GOYA_BMON_TPC7_EML_1,
+	GOYA_BMON_TPC7_EML_2,
+	GOYA_BMON_TPC7_EML_3,
+	GOYA_BMON_LAST = GOYA_BMON_TPC7_EML_3
+};
+
+enum goya_debug_spmu_regs_index {
+	GOYA_SPMU_FIRST = 0,
+	GOYA_SPMU_DMA_CH_0_CS = GOYA_SPMU_FIRST,
+	GOYA_SPMU_DMA_CH_1_CS,
+	GOYA_SPMU_DMA_CH_2_CS,
+	GOYA_SPMU_DMA_CH_3_CS,
+	GOYA_SPMU_DMA_CH_4_CS,
+	GOYA_SPMU_DMA_MACRO_CS,
+	GOYA_SPMU_MME1_SBA,
+	GOYA_SPMU_MME3_SBB,
+	GOYA_SPMU_MME4_WACS2,
+	GOYA_SPMU_MME4_WACS,
+	GOYA_SPMU_MMU_CS,
+	GOYA_SPMU_PCIE,
+	GOYA_SPMU_TPC0_EML,
+	GOYA_SPMU_TPC1_EML,
+	GOYA_SPMU_TPC2_EML,
+	GOYA_SPMU_TPC3_EML,
+	GOYA_SPMU_TPC4_EML,
+	GOYA_SPMU_TPC5_EML,
+	GOYA_SPMU_TPC6_EML,
+	GOYA_SPMU_TPC7_EML,
+	GOYA_SPMU_LAST = GOYA_SPMU_TPC7_EML
+};
+
+#endif /* GOYA_CORESIGHT_H */
-- 
2.17.1

