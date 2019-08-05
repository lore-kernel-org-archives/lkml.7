Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53F6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15F92086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfHENu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:50:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbfHENu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB6D2E454038141DF8AB;
        Mon,  5 Aug 2019 21:50:23 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 09/15] scsi: hisi_sas: Drop kmap_atomic() in SMP command completion
Date:   Mon, 5 Aug 2019 21:48:06 +0800
Message-ID: <1565012892-75940-10-git-send-email-john.garry@huawei.com>
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

The call to kmap_atomic() in the SMP command completion code is
unnecessary, since kmap() is only really concerned with highmem, which is
not relevant on arm64. The controller only finds itself in arm64 systems.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 4 +---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 4 +---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index b13cbc64d2a9..015bf00a20e6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1275,11 +1275,10 @@ static int slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 	}
 	case SAS_PROTOCOL_SMP:
 	{
-		void *to;
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
+		void *to = page_address(sg_page(sg_resp));
 
 		ts->stat = SAM_STAT_GOOD;
-		to = kmap_atomic(sg_page(sg_resp));
 
 		dma_unmap_sg(dev, &task->smp_task.smp_resp, 1,
 			     DMA_FROM_DEVICE);
@@ -1289,7 +1288,6 @@ static int slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		       hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
 		       sg_dma_len(sg_resp));
-		kunmap_atomic(to);
 		break;
 	}
 	case SAS_PROTOCOL_SATA:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index de33e31cd88a..c3cf3b77c655 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2419,10 +2419,9 @@ slot_complete_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 	case SAS_PROTOCOL_SMP:
 	{
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
-		void *to;
+		void *to = page_address(sg_page(sg_resp));
 
 		ts->stat = SAM_STAT_GOOD;
-		to = kmap_atomic(sg_page(sg_resp));
 
 		dma_unmap_sg(dev, &task->smp_task.smp_resp, 1,
 			     DMA_FROM_DEVICE);
@@ -2432,7 +2431,6 @@ slot_complete_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 		       hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
 		       sg_dma_len(sg_resp));
-		kunmap_atomic(to);
 		break;
 	}
 	case SAS_PROTOCOL_SATA:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 072a39d5c4ad..fcb2ef5f24b9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2211,10 +2211,9 @@ slot_complete_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 	}
 	case SAS_PROTOCOL_SMP: {
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
-		void *to;
+		void *to = page_address(sg_page(sg_resp));
 
 		ts->stat = SAM_STAT_GOOD;
-		to = kmap_atomic(sg_page(sg_resp));
 
 		dma_unmap_sg(dev, &task->smp_task.smp_resp, 1,
 			     DMA_FROM_DEVICE);
@@ -2224,7 +2223,6 @@ slot_complete_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 			hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
 		       sg_dma_len(sg_resp));
-		kunmap_atomic(to);
 		break;
 	}
 	case SAS_PROTOCOL_SATA:
-- 
2.17.1

