Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C531F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE2KA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:00:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfE2KAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:00:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90C1534F7DF3A24A781C;
        Wed, 29 May 2019 18:00:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 29 May 2019 18:00:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/6] scsi: hisi_sas: Fix the issue of argument mismatch of printing ecc errors
Date:   Wed, 29 May 2019 17:58:43 +0800
Message-ID: <1559123927-160502-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1559123927-160502-1-git-send-email-john.garry@huawei.com>
References: <1559123927-160502-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

The argument of dev_err() called by multi_bit_ecc_error_process_v3_hw()
is not right. We pass two arguments, but there is only one printk format
specifier in the string.

Besides, move the print format string to dev_err(). Then compiler can
find such issue in earlier stage.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 46 ++++++++++++++------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 25 +++++++-------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index d4650bed8274..b8c0ba778293 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -427,70 +427,70 @@ static const struct hisi_sas_hw_error one_bit_ecc_errors[] = {
 		.irq_msk = BIT(SAS_ECC_INTR_DQE_ECC_1B_OFF),
 		.msk = HGC_DQE_ECC_1B_ADDR_MSK,
 		.shift = HGC_DQE_ECC_1B_ADDR_OFF,
-		.msg = "hgc_dqe_acc1b_intr found: Ram address is 0x%08X\n",
+		.msg = "hgc_dqe_ecc1b_intr",
 		.reg = HGC_DQE_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_IOST_ECC_1B_OFF),
 		.msk = HGC_IOST_ECC_1B_ADDR_MSK,
 		.shift = HGC_IOST_ECC_1B_ADDR_OFF,
-		.msg = "hgc_iost_acc1b_intr found: Ram address is 0x%08X\n",
+		.msg = "hgc_iost_ecc1b_intr",
 		.reg = HGC_IOST_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_ITCT_ECC_1B_OFF),
 		.msk = HGC_ITCT_ECC_1B_ADDR_MSK,
 		.shift = HGC_ITCT_ECC_1B_ADDR_OFF,
-		.msg = "hgc_itct_acc1b_intr found: am address is 0x%08X\n",
+		.msg = "hgc_itct_ecc1b_intr",
 		.reg = HGC_ITCT_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_IOSTLIST_ECC_1B_OFF),
 		.msk = HGC_LM_DFX_STATUS2_IOSTLIST_MSK,
 		.shift = HGC_LM_DFX_STATUS2_IOSTLIST_OFF,
-		.msg = "hgc_iostl_acc1b_intr found: memory address is 0x%08X\n",
+		.msg = "hgc_iostl_ecc1b_intr",
 		.reg = HGC_LM_DFX_STATUS2,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_ITCTLIST_ECC_1B_OFF),
 		.msk = HGC_LM_DFX_STATUS2_ITCTLIST_MSK,
 		.shift = HGC_LM_DFX_STATUS2_ITCTLIST_OFF,
-		.msg = "hgc_itctl_acc1b_intr found: memory address is 0x%08X\n",
+		.msg = "hgc_itctl_ecc1b_intr",
 		.reg = HGC_LM_DFX_STATUS2,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_CQE_ECC_1B_OFF),
 		.msk = HGC_CQE_ECC_1B_ADDR_MSK,
 		.shift = HGC_CQE_ECC_1B_ADDR_OFF,
-		.msg = "hgc_cqe_acc1b_intr found: Ram address is 0x%08X\n",
+		.msg = "hgc_cqe_ecc1b_intr",
 		.reg = HGC_CQE_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM0_ECC_1B_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM0_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM0_OFF,
-		.msg = "rxm_mem0_acc1b_intr found: memory address is 0x%08X\n",
+		.msg = "rxm_mem0_ecc1b_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM1_ECC_1B_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM1_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM1_OFF,
-		.msg = "rxm_mem1_acc1b_intr found: memory address is 0x%08X\n",
+		.msg = "rxm_mem1_ecc1b_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM2_ECC_1B_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM2_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM2_OFF,
-		.msg = "rxm_mem2_acc1b_intr found: memory address is 0x%08X\n",
+		.msg = "rxm_mem2_ecc1b_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM3_ECC_1B_OFF),
 		.msk = HGC_RXM_DFX_STATUS15_MEM3_MSK,
 		.shift = HGC_RXM_DFX_STATUS15_MEM3_OFF,
-		.msg = "rxm_mem3_acc1b_intr found: memory address is 0x%08X\n",
+		.msg = "rxm_mem3_ecc1b_intr",
 		.reg = HGC_RXM_DFX_STATUS15,
 	},
 };
@@ -500,70 +500,70 @@ static const struct hisi_sas_hw_error multi_bit_ecc_errors[] = {
 		.irq_msk = BIT(SAS_ECC_INTR_DQE_ECC_MB_OFF),
 		.msk = HGC_DQE_ECC_MB_ADDR_MSK,
 		.shift = HGC_DQE_ECC_MB_ADDR_OFF,
-		.msg = "hgc_dqe_accbad_intr (0x%x) found: Ram address is 0x%08X\n",
+		.msg = "hgc_dqe_eccbad_intr",
 		.reg = HGC_DQE_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_IOST_ECC_MB_OFF),
 		.msk = HGC_IOST_ECC_MB_ADDR_MSK,
 		.shift = HGC_IOST_ECC_MB_ADDR_OFF,
-		.msg = "hgc_iost_accbad_intr (0x%x) found: Ram address is 0x%08X\n",
+		.msg = "hgc_iost_eccbad_intr",
 		.reg = HGC_IOST_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_ITCT_ECC_MB_OFF),
 		.msk = HGC_ITCT_ECC_MB_ADDR_MSK,
 		.shift = HGC_ITCT_ECC_MB_ADDR_OFF,
-		.msg = "hgc_itct_accbad_intr (0x%x) found: Ram address is 0x%08X\n",
+		.msg = "hgc_itct_eccbad_intr",
 		.reg = HGC_ITCT_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_IOSTLIST_ECC_MB_OFF),
 		.msk = HGC_LM_DFX_STATUS2_IOSTLIST_MSK,
 		.shift = HGC_LM_DFX_STATUS2_IOSTLIST_OFF,
-		.msg = "hgc_iostl_accbad_intr (0x%x) found: memory address is 0x%08X\n",
+		.msg = "hgc_iostl_eccbad_intr",
 		.reg = HGC_LM_DFX_STATUS2,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_ITCTLIST_ECC_MB_OFF),
 		.msk = HGC_LM_DFX_STATUS2_ITCTLIST_MSK,
 		.shift = HGC_LM_DFX_STATUS2_ITCTLIST_OFF,
-		.msg = "hgc_itctl_accbad_intr (0x%x) found: memory address is 0x%08X\n",
+		.msg = "hgc_itctl_eccbad_intr",
 		.reg = HGC_LM_DFX_STATUS2,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_CQE_ECC_MB_OFF),
 		.msk = HGC_CQE_ECC_MB_ADDR_MSK,
 		.shift = HGC_CQE_ECC_MB_ADDR_OFF,
-		.msg = "hgc_cqe_accbad_intr (0x%x) found: Ram address is 0x%08X\n",
+		.msg = "hgc_cqe_eccbad_intr",
 		.reg = HGC_CQE_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM0_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM0_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM0_OFF,
-		.msg = "rxm_mem0_accbad_intr (0x%x) found: memory address is 0x%08X\n",
+		.msg = "rxm_mem0_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM1_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM1_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM1_OFF,
-		.msg = "rxm_mem1_accbad_intr (0x%x) found: memory address is 0x%08X\n",
+		.msg = "rxm_mem1_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM2_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM2_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM2_OFF,
-		.msg = "rxm_mem2_accbad_intr (0x%x) found: memory address is 0x%08X\n",
+		.msg = "rxm_mem2_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM3_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS15_MEM3_MSK,
 		.shift = HGC_RXM_DFX_STATUS15_MEM3_OFF,
-		.msg = "rxm_mem3_accbad_intr (0x%x) found: memory address is 0x%08X\n",
+		.msg = "rxm_mem3_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS15,
 	},
 };
@@ -2978,7 +2978,8 @@ one_bit_ecc_error_process_v2_hw(struct hisi_hba *hisi_hba, u32 irq_value)
 			val = hisi_sas_read32(hisi_hba, ecc_error->reg);
 			val &= ecc_error->msk;
 			val >>= ecc_error->shift;
-			dev_warn(dev, ecc_error->msg, val);
+			dev_warn(dev, "%s found: mem addr is 0x%08X\n",
+				 ecc_error->msg, val);
 		}
 	}
 }
@@ -2997,7 +2998,8 @@ static void multi_bit_ecc_error_process_v2_hw(struct hisi_hba *hisi_hba,
 			val = hisi_sas_read32(hisi_hba, ecc_error->reg);
 			val &= ecc_error->msk;
 			val >>= ecc_error->shift;
-			dev_err(dev, ecc_error->msg, irq_value, val);
+			dev_err(dev, "%s (0x%x) found: mem addr is 0x%08X\n",
+				ecc_error->msg, irq_value, val);
 			queue_work(hisi_hba->wq, &hisi_hba->rst_work);
 		}
 	}
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 49620c2411df..3efb1e72bdab 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1831,77 +1831,77 @@ static const struct hisi_sas_hw_error multi_bit_ecc_errors[] = {
 		.irq_msk = BIT(SAS_ECC_INTR_DQE_ECC_MB_OFF),
 		.msk = HGC_DQE_ECC_MB_ADDR_MSK,
 		.shift = HGC_DQE_ECC_MB_ADDR_OFF,
-		.msg = "hgc_dqe_eccbad_intr found: ram addr is 0x%08X\n",
+		.msg = "hgc_dqe_eccbad_intr",
 		.reg = HGC_DQE_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_IOST_ECC_MB_OFF),
 		.msk = HGC_IOST_ECC_MB_ADDR_MSK,
 		.shift = HGC_IOST_ECC_MB_ADDR_OFF,
-		.msg = "hgc_iost_eccbad_intr found: ram addr is 0x%08X\n",
+		.msg = "hgc_iost_eccbad_intr",
 		.reg = HGC_IOST_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_ITCT_ECC_MB_OFF),
 		.msk = HGC_ITCT_ECC_MB_ADDR_MSK,
 		.shift = HGC_ITCT_ECC_MB_ADDR_OFF,
-		.msg = "hgc_itct_eccbad_intr found: ram addr is 0x%08X\n",
+		.msg = "hgc_itct_eccbad_intr",
 		.reg = HGC_ITCT_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_IOSTLIST_ECC_MB_OFF),
 		.msk = HGC_LM_DFX_STATUS2_IOSTLIST_MSK,
 		.shift = HGC_LM_DFX_STATUS2_IOSTLIST_OFF,
-		.msg = "hgc_iostl_eccbad_intr found: mem addr is 0x%08X\n",
+		.msg = "hgc_iostl_eccbad_intr",
 		.reg = HGC_LM_DFX_STATUS2,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_ITCTLIST_ECC_MB_OFF),
 		.msk = HGC_LM_DFX_STATUS2_ITCTLIST_MSK,
 		.shift = HGC_LM_DFX_STATUS2_ITCTLIST_OFF,
-		.msg = "hgc_itctl_eccbad_intr found: mem addr is 0x%08X\n",
+		.msg = "hgc_itctl_eccbad_intr",
 		.reg = HGC_LM_DFX_STATUS2,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_CQE_ECC_MB_OFF),
 		.msk = HGC_CQE_ECC_MB_ADDR_MSK,
 		.shift = HGC_CQE_ECC_MB_ADDR_OFF,
-		.msg = "hgc_cqe_eccbad_intr found: ram address is 0x%08X\n",
+		.msg = "hgc_cqe_eccbad_intr",
 		.reg = HGC_CQE_ECC_ADDR,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM0_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM0_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM0_OFF,
-		.msg = "rxm_mem0_eccbad_intr found: mem addr is 0x%08X\n",
+		.msg = "rxm_mem0_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM1_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM1_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM1_OFF,
-		.msg = "rxm_mem1_eccbad_intr found: mem addr is 0x%08X\n",
+		.msg = "rxm_mem1_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM2_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS14_MEM2_MSK,
 		.shift = HGC_RXM_DFX_STATUS14_MEM2_OFF,
-		.msg = "rxm_mem2_eccbad_intr found: mem addr is 0x%08X\n",
+		.msg = "rxm_mem2_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS14,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_NCQ_MEM3_ECC_MB_OFF),
 		.msk = HGC_RXM_DFX_STATUS15_MEM3_MSK,
 		.shift = HGC_RXM_DFX_STATUS15_MEM3_OFF,
-		.msg = "rxm_mem3_eccbad_intr found: mem addr is 0x%08X\n",
+		.msg = "rxm_mem3_eccbad_intr",
 		.reg = HGC_RXM_DFX_STATUS15,
 	},
 	{
 		.irq_msk = BIT(SAS_ECC_INTR_OOO_RAM_ECC_MB_OFF),
 		.msk = AM_ROB_ECC_ERR_ADDR_MSK,
 		.shift = AM_ROB_ECC_ERR_ADDR_OFF,
-		.msg = "ooo_ram_eccbad_intr found: ROB_ECC_ERR_ADDR=0x%08X\n",
+		.msg = "ooo_ram_eccbad_intr",
 		.reg = AM_ROB_ECC_ERR_ADDR,
 	},
 };
@@ -1920,7 +1920,8 @@ static void multi_bit_ecc_error_process_v3_hw(struct hisi_hba *hisi_hba,
 			val = hisi_sas_read32(hisi_hba, ecc_error->reg);
 			val &= ecc_error->msk;
 			val >>= ecc_error->shift;
-			dev_err(dev, ecc_error->msg, irq_value, val);
+			dev_err(dev, "%s (0x%x) found: mem addr is 0x%08X\n",
+				ecc_error->msg, irq_value, val);
 			queue_work(hisi_hba->wq, &hisi_hba->rst_work);
 		}
 	}
-- 
2.17.1

