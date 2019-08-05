Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D054FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1422087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfHENuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:50:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729854AbfHENu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 24FF616D94FDECA0FE1E;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 13/15] scsi: hisi_sas: Remove some unnecessary code
Date:   Mon, 5 Aug 2019 21:48:10 +0800
Message-ID: <1565012892-75940-14-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Remove some unnecessary code, including:
- Explicit zeroing of memory allocated for dmam_alloc_coherent()
- Some duplicated code
- Some redundant masking

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 5 ++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index be15280343d1..e1c52811f4c7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2358,7 +2358,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 
 	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
 	hisi_hba->itct = dmam_alloc_coherent(dev, s, &hisi_hba->itct_dma,
-					     GFP_KERNEL | __GFP_ZERO);
+					     GFP_KERNEL);
 	if (!hisi_hba->itct)
 		goto err_out;
 
@@ -2385,7 +2385,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 		void *buf;
 
 		buf = dmam_alloc_coherent(dev, s, &buf_dma,
-					  GFP_KERNEL | __GFP_ZERO);
+					  GFP_KERNEL);
 		if (!buf)
 			goto err_out;
 
@@ -2434,7 +2434,6 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 					GFP_KERNEL);
 	if (!hisi_hba->sata_breakpoint)
 		goto err_out;
-	hisi_sas_init_mem(hisi_hba);
 
 	hisi_sas_slot_index_init(hisi_hba);
 	hisi_hba->last_slot_index = HISI_SAS_UNRESERVED_IPTT;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3cc53e5b92f2..db8c7e4b1954 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1914,7 +1914,7 @@ static void fatal_ecc_int_v3_hw(struct hisi_hba *hisi_hba)
 	u32 irq_value, irq_msk;
 
 	irq_msk = hisi_sas_read32(hisi_hba, SAS_ECC_INTR_MSK);
-	hisi_sas_write32(hisi_hba, SAS_ECC_INTR_MSK, irq_msk | 0xffffffff);
+	hisi_sas_write32(hisi_hba, SAS_ECC_INTR_MSK, 0xffffffff);
 
 	irq_value = hisi_sas_read32(hisi_hba, SAS_ECC_INTR);
 	if (irq_value)
@@ -3008,8 +3008,6 @@ hisi_sas_shost_alloc_pci(struct pci_dev *pdev)
 	else
 		hisi_hba->prot_mask = prot_mask;
 
-	timer_setup(&hisi_hba->timer, NULL, 0);
-
 	if (hisi_sas_get_fw_info(hisi_hba) < 0)
 		goto err_out;
 
@@ -3099,7 +3097,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &hisi_hba->sas_addr[0];
 	sha->num_phys = hisi_hba->n_phy;
-	sha->core.shost = hisi_hba->shost;
 
 	for (i = 0; i < hisi_hba->n_phy; i++) {
 		sha->sas_phy[i] = &hisi_hba->phy[i].sas_phy;
-- 
2.17.1

