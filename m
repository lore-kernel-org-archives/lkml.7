Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E78C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A92121852
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfDKMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:48:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfDKMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:47:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8F72D4F651B2AC100F5;
        Thu, 11 Apr 2019 20:47:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:47:21 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 8/9] scsi: hisi_sas: Don't fail IT nexus reset for Open Reject timeout
Date:   Thu, 11 Apr 2019 20:46:43 +0800
Message-ID: <1554986804-233706-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554986804-233706-1-git-send-email-john.garry@huawei.com>
References: <1554986804-233706-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Currently we call hisi_sas_softreset_ata_disk() in
hisi_sas_I_T_nexus_reset().

If this fails for open reject reason, there is no reason to
fail the IT nexus reset, so only fail for TMF_RESP_FUNC_FAILED.

Some other strings spilled over multiple lines are reunited.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index c02cf78a20c7..ebeec7a52ddc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1287,8 +1287,7 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 			/* no error, but return the number of bytes of
 			 * underrun
 			 */
-			dev_warn(dev, "abort tmf: task to dev %016llx "
-				 "resp: 0x%x sts 0x%x underrun\n",
+			dev_warn(dev, "abort tmf: task to dev %016llx resp: 0x%x sts 0x%x underrun\n",
 				 SAS_ADDR(device->sas_addr),
 				 task->task_status.resp,
 				 task->task_status.stat);
@@ -1303,10 +1302,16 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 			break;
 		}
 
-		dev_warn(dev, "abort tmf: task to dev "
-			 "%016llx resp: 0x%x status 0x%x\n",
-			 SAS_ADDR(device->sas_addr), task->task_status.resp,
-			 task->task_status.stat);
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+		    task->task_status.stat == SAS_OPEN_REJECT) {
+			dev_warn(dev, "abort tmf: open reject failed\n");
+			res = -EIO;
+		} else {
+			dev_warn(dev, "abort tmf: task to dev %016llx resp: 0x%x status 0x%x\n",
+				 SAS_ADDR(device->sas_addr),
+				 task->task_status.resp,
+				 task->task_status.stat);
+		}
 		sas_free_task(task);
 		task = NULL;
 	}
@@ -1826,7 +1831,7 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 
 	if (dev_is_sata(device)) {
 		rc = hisi_sas_softreset_ata_disk(device);
-		if (rc)
+		if (rc == TMF_RESP_FUNC_FAILED)
 			return TMF_RESP_FUNC_FAILED;
 	}
 
@@ -2123,10 +2128,8 @@ _hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 	}
 
 exit:
-	dev_dbg(dev, "internal task abort: task to dev %016llx task=%p "
-		"resp: 0x%x sts 0x%x\n",
-		SAS_ADDR(device->sas_addr),
-		task,
+	dev_dbg(dev, "internal task abort: task to dev %016llx task=%p resp: 0x%x sts 0x%x\n",
+		SAS_ADDR(device->sas_addr), task,
 		task->task_status.resp, /* 0 is complete, -1 is undelivered */
 		task->task_status.stat);
 	sas_free_task(task);
-- 
2.17.1

