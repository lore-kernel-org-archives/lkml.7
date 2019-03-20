Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DAD2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfCTKVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:21:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727529AbfCTKVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:21:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D42F4F35A92E9DDB29AB;
        Wed, 20 Mar 2019 18:21:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 18:21:37 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Add softreset in hisi_sas_I_T_nexus_reset()
Date:   Wed, 20 Mar 2019 18:21:34 +0800
Message-ID: <1553077294-129863-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

We found out that for v2 hw, a SATA disk can not be written to after
the system comes up.

In commit ffb1c820b8b6 ("scsi: hisi_sas: remove the check of sas_dev
status in hisi_sas_I_T_nexus_reset()"), we introduced a path where we may
issue an internal abort for a SATA device, but without following it with a
softreset.

We need to always follow an internal abort with a software reset, as per HW
programming flow, so add this.

Fixes: ffb1c820b8b6 ("scsi: hisi_sas: remove the check of sas_dev status in hisi_sas_I_T_nexus_reset()")
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---

Hi James, Martin,

Please consider this patch for 5.1 fixes. It's fixes a big regression,
where we can no longer access SATA disks, like here:
https://storage.kernelci.org/next/master/next-20190213/arm64/defconfig/gcc-7/lab-collabora/boot-hip07-d05.html

Thanks,
John

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 3c3cf89f713f..14bac4966c87 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1801,6 +1801,12 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 	}
 	hisi_sas_dereg_device(hisi_hba, device);
 
+	if (dev_is_sata(device)) {
+		rc = hisi_sas_softreset_ata_disk(device);
+		if (rc)
+			return TMF_RESP_FUNC_FAILED;
+	}
+
 	rc = hisi_sas_debug_I_T_nexus_reset(device);
 
 	if ((rc == TMF_RESP_FUNC_COMPLETE) || (rc == -ENODEV))
-- 
2.17.1

