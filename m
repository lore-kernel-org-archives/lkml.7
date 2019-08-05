Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AABC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CA52087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfHENue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:50:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729873AbfHENua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E4722D86713B22B4ABD;
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
Subject: [PATCH 14/15] scsi: hisi_sas: replace "%p" with "%pK"
Date:   Mon, 5 Aug 2019 21:48:11 +0800
Message-ID: <1565012892-75940-15-git-send-email-john.garry@huawei.com>
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

The format specifier "%p" can leak kernel address, and use "%pK" instead.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 +++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index e1c52811f4c7..acb87b4f9622 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2102,7 +2102,7 @@ _hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 	}
 
 exit:
-	dev_dbg(dev, "internal task abort: task to dev %016llx task=%p resp: 0x%x sts 0x%x\n",
+	dev_dbg(dev, "internal task abort: task to dev %016llx task=%pK resp: 0x%x sts 0x%x\n",
 		SAS_ADDR(device->sas_addr), task,
 		task->task_status.resp, /* 0 is complete, -1 is undelivered */
 		task->task_status.stat);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index a3f8c51b3500..fba4fcad4735 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2393,7 +2393,7 @@ slot_complete_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 			slot_err_v2_hw(hisi_hba, task, slot, 2);
 
 		if (ts->stat != SAS_DATA_UNDERRUN)
-			dev_info(dev, "erroneous completion iptt=%d task=%p dev id=%d CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
+			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
 				 slot->idx, task, sas_dev->device_id,
 				 complete_hdr->dw0, complete_hdr->dw1,
 				 complete_hdr->act, complete_hdr->dw3,
@@ -2455,7 +2455,7 @@ slot_complete_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
-		dev_info(dev, "slot complete: task(%p) aborted\n", task);
+		dev_info(dev, "slot complete: task(%pK) aborted\n", task);
 		return SAS_ABORTED_TASK;
 	}
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
@@ -2466,7 +2466,7 @@ slot_complete_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 		spin_lock_irqsave(&device->done_lock, flags);
 		if (test_bit(SAS_HA_FROZEN, &ha->state)) {
 			spin_unlock_irqrestore(&device->done_lock, flags);
-			dev_info(dev, "slot complete: task(%p) ignored\n",
+			dev_info(dev, "slot complete: task(%pK) ignored\n",
 				 task);
 			return sts;
 		}
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index db8c7e4b1954..2adb5c93bd81 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2190,7 +2190,7 @@ slot_complete_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 
 		slot_err_v3_hw(hisi_hba, task, slot);
 		if (ts->stat != SAS_DATA_UNDERRUN)
-			dev_info(dev, "erroneous completion iptt=%d task=%p dev id=%d CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
+			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
 				 slot->idx, task, sas_dev->device_id,
 				 dw0, dw1, complete_hdr->act, dw3,
 				 error_info[0], error_info[1],
@@ -2245,7 +2245,7 @@ slot_complete_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
-		dev_info(dev, "slot complete: task(%p) aborted\n", task);
+		dev_info(dev, "slot complete: task(%pK) aborted\n", task);
 		return SAS_ABORTED_TASK;
 	}
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
@@ -2256,7 +2256,7 @@ slot_complete_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_slot *slot)
 		spin_lock_irqsave(&device->done_lock, flags);
 		if (test_bit(SAS_HA_FROZEN, &ha->state)) {
 			spin_unlock_irqrestore(&device->done_lock, flags);
-			dev_info(dev, "slot complete: task(%p) ignored\n ",
+			dev_info(dev, "slot complete: task(%pK) ignored\n ",
 				 task);
 			return sts;
 		}
-- 
2.17.1

