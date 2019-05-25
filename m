Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22597C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB46D2175B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEYMoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:44:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfEYMoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:44:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8FFA33F58BB835726D12;
        Sat, 25 May 2019 20:42:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:42:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: remove set but not used variables 'host' and 'wait_time'
Date:   Sat, 25 May 2019 20:42:02 +0800
Message-ID: <20190525124202.8120-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warnings:

drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_suspend:
drivers/scsi/megaraid/megaraid_sas_base.c:7269:20: warning: variable host set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_aen_polling:
drivers/scsi/megaraid/megaraid_sas_base.c:8397:15: warning: variable wait_time set but not used [-Wunused-but-set-variable]

'host' is never used since introduction in
commit 31ea7088974c ("[SCSI] megaraid_sas: add hibernation support")

'wait_time' is not used since commit
11c71cb4ab7c ("megaraid_sas: Do not allow PCI access during OCR")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 92e576228d5f..ed0f6ca578e5 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -7239,11 +7239,9 @@ static void megasas_shutdown_controller(struct megasas_instance *instance,
 static int
 megasas_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	struct Scsi_Host *host;
 	struct megasas_instance *instance;
 
 	instance = pci_get_drvdata(pdev);
-	host = instance->host;
 	instance->unload = 1;
 
 	dev_info(&pdev->dev, "%s is called\n", __func__);
@@ -8367,7 +8365,7 @@ megasas_aen_polling(struct work_struct *work)
 	struct megasas_instance *instance = ev->instance;
 	union megasas_evt_class_locale class_locale;
 	int event_type = 0;
-	u32 seq_num, wait_time = MEGASAS_RESET_WAIT_TIME;
+	u32 seq_num;
 	int error;
 	u8  dcmd_ret = DCMD_SUCCESS;
 
@@ -8377,10 +8375,6 @@ megasas_aen_polling(struct work_struct *work)
 		return;
 	}
 
-	/* Adjust event workqueue thread wait time for VF mode */
-	if (instance->requestorId)
-		wait_time = MEGASAS_ROUTINE_WAIT_TIME_VF;
-
 	/* Don't run the event workqueue thread if OCR is running */
 	mutex_lock(&instance->reset_mutex);
 
-- 
2.17.1


