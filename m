Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607C02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbfB1Ova (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:51:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731361AbfB1Ov3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:51:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADEF69C18F2B0E4D68E6;
        Thu, 28 Feb 2019 22:51:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 22:51:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 2/6] scsi: hisi_sas: Fix a timeout race of driver internal and SMP IO
Date:   Thu, 28 Feb 2019 22:50:58 +0800
Message-ID: <1551365462-128193-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1551365462-128193-1-git-send-email-john.garry@huawei.com>
References: <1551365462-128193-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

For internal IO and SMP IO, there is a time-out timer for them. In the
timer handler, it checks whether IO is done according to the flag
task->task_state_lock.

There is an issue which may cause system suspended: internal IO or SMP IO
is sent, but at that time because of hardware exception (such as inject
2Bit ECC error), so IO is not completed and also not timeout. But, at that
time, the SAS controller reset occurs to recover system. It will release
the resource and set the status of IO to be SAS_TASK_STATE_DONE, so when
IO timeout, it will never complete the completion of IO and wait for ever.

[  729.123632] Call trace:
[  729.126791] [<ffff00000808655c>] __switch_to+0x94/0xa8
[  729.133106] [<ffff000008d96e98>] __schedule+0x1e8/0x7fc
[  729.138975] [<ffff000008d974e0>] schedule+0x34/0x8c
[  729.144401] [<ffff000008d9b000>] schedule_timeout+0x1d8/0x3cc
[  729.150690] [<ffff000008d98218>] wait_for_common+0xdc/0x1a0
[  729.157101] [<ffff000008d98304>] wait_for_completion+0x28/0x34
[  729.165973] [<ffff000000dcefb4>] hisi_sas_internal_task_abort+0x2a0/0x424 [hisi_sas_test_main]
[  729.176447] [<ffff000000dd18f4>] hisi_sas_abort_task+0x244/0x2d8 [hisi_sas_test_main]
[  729.185258] [<ffff000008971714>] sas_eh_handle_sas_errors+0x1c8/0x7b8
[  729.192391] [<ffff000008972774>] sas_scsi_recover_host+0x130/0x398
[  729.199237] [<ffff00000894d8a8>] scsi_error_handler+0x148/0x5c0
[  729.206009] [<ffff0000080f4118>] kthread+0x10c/0x138
[  729.211563] [<ffff0000080855dc>] ret_from_fork+0x10/0x18

To solve the issue, callback function task_done of those IOs need to be
called when on SAS controller reset.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 923296653ed7..dd03dcbd3786 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -980,7 +980,8 @@ static void hisi_sas_do_release_task(struct hisi_hba *hisi_hba, struct sas_task
 		spin_lock_irqsave(&task->task_state_lock, flags);
 		task->task_state_flags &=
 			~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
-		task->task_state_flags |= SAS_TASK_STATE_DONE;
+		if (!slot->is_internal && task->task_proto != SAS_PROTOCOL_SMP)
+			task->task_state_flags |= SAS_TASK_STATE_DONE;
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
 	}
 
-- 
2.17.1

