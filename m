Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8054CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512A620880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfHENvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:51:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729627AbfHENu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 003B8DA2237DC82E83EC;
        Mon,  5 Aug 2019 21:50:23 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 10/15] scsi: hisi_sas: Drop SMP resp frame DMA mapping
Date:   Mon, 5 Aug 2019 21:48:07 +0800
Message-ID: <1565012892-75940-11-git-send-email-john.garry@huawei.com>
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

The SMP frame response is written to the command table and not the
SMP response pointer from libsas, so don't bother DMA mapping (and
unmapping) the SMP response from libsas.

Suggested-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 28 +++++++-------------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  4 +---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  4 +---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  4 +---
 4 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 39ae69e42d26..a2255701b50b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -300,7 +300,7 @@ static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
 
 static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
 			       struct sas_task *task, int n_elem,
-			       int n_elem_req, int n_elem_resp)
+			       int n_elem_req)
 {
 	struct device *dev = hisi_hba->dev;
 
@@ -314,16 +314,13 @@ static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
 			if (n_elem_req)
 				dma_unmap_sg(dev, &task->smp_task.smp_req,
 					     1, DMA_TO_DEVICE);
-			if (n_elem_resp)
-				dma_unmap_sg(dev, &task->smp_task.smp_resp,
-					     1, DMA_FROM_DEVICE);
 		}
 	}
 }
 
 static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
 			    struct sas_task *task, int *n_elem,
-			    int *n_elem_req, int *n_elem_resp)
+			    int *n_elem_req)
 {
 	struct device *dev = hisi_hba->dev;
 	int rc;
@@ -331,7 +328,7 @@ static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
 	if (sas_protocol_ata(task->task_proto)) {
 		*n_elem = task->num_scatter;
 	} else {
-		unsigned int req_len, resp_len;
+		unsigned int req_len;
 
 		if (task->num_scatter) {
 			*n_elem = dma_map_sg(dev, task->scatter,
@@ -352,17 +349,6 @@ static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
 				rc = -EINVAL;
 				goto err_out_dma_unmap;
 			}
-			*n_elem_resp = dma_map_sg(dev, &task->smp_task.smp_resp,
-						  1, DMA_FROM_DEVICE);
-			if (!*n_elem_resp) {
-				rc = -ENOMEM;
-				goto err_out_dma_unmap;
-			}
-			resp_len = sg_dma_len(&task->smp_task.smp_resp);
-			if (resp_len & 0x3) {
-				rc = -EINVAL;
-				goto err_out_dma_unmap;
-			}
 		}
 	}
 
@@ -377,7 +363,7 @@ static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
 err_out_dma_unmap:
 	/* It would be better to call dma_unmap_sg() here, but it's messy */
 	hisi_sas_dma_unmap(hisi_hba, task, *n_elem,
-			   *n_elem_req, *n_elem_resp);
+			   *n_elem_req);
 prep_out:
 	return rc;
 }
@@ -449,7 +435,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	struct asd_sas_port *sas_port = device->port;
 	struct device *dev = hisi_hba->dev;
 	int dlvry_queue_slot, dlvry_queue, rc, slot_idx;
-	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0, n_elem_resp = 0;
+	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
 	struct hisi_sas_dq *dq;
 	unsigned long flags;
 	int wr_q_index;
@@ -485,7 +471,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	}
 
 	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
-			      &n_elem_req, &n_elem_resp);
+			      &n_elem_req);
 	if (rc < 0)
 		goto prep_out;
 
@@ -580,7 +566,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
 		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
 err_out_dma_unmap:
 	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
-			   n_elem_req, n_elem_resp);
+			   n_elem_req);
 prep_out:
 	dev_err(dev, "task prep: failed[%d]!\n", rc);
 	return rc;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 015bf00a20e6..16974421cb31 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1280,14 +1280,12 @@ static int slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 
 		ts->stat = SAM_STAT_GOOD;
 
-		dma_unmap_sg(dev, &task->smp_task.smp_resp, 1,
-			     DMA_FROM_DEVICE);
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
 		memcpy(to + sg_resp->offset,
 		       hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
-		       sg_dma_len(sg_resp));
+		       sg_resp->length);
 		break;
 	}
 	case SAS_PROTOCOL_SATA:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index c3cf3b77c655..9955b4fbdd0d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2423,14 +2423,12 @@ slot_complete_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 
 		ts->stat = SAM_STAT_GOOD;
 
-		dma_unmap_sg(dev, &task->smp_task.smp_resp, 1,
-			     DMA_FROM_DEVICE);
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
 		memcpy(to + sg_resp->offset,
 		       hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
-		       sg_dma_len(sg_resp));
+		       sg_resp->length);
 		break;
 	}
 	case SAS_PROTOCOL_SATA:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index fcb2ef5f24b9..95a298d4e211 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2215,14 +2215,12 @@ slot_complete_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 
 		ts->stat = SAM_STAT_GOOD;
 
-		dma_unmap_sg(dev, &task->smp_task.smp_resp, 1,
-			     DMA_FROM_DEVICE);
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
 		memcpy(to + sg_resp->offset,
 			hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
-		       sg_dma_len(sg_resp));
+		       sg_resp->length);
 		break;
 	}
 	case SAS_PROTOCOL_SATA:
-- 
2.17.1

