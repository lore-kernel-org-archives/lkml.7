Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F2DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847D520863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEYMkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:40:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfEYMkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:40:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 54EFCA889B5BE5229129;
        Sat, 25 May 2019 20:40:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:40:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: remove set but not used variables 'buff_addr' and 'ci_h'
Date:   Sat, 25 May 2019 20:40:06 +0800
Message-ID: <20190525124006.21284-1-yuehaibing@huawei.com>
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

drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_fw_crash_buffer_show:
drivers/scsi/megaraid/megaraid_sas_base.c:3138:16: warning: variable buff_addr set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_get_pd_list:
drivers/scsi/megaraid/megaraid_sas_base.c:4426:13: warning: variable ci_h set but not used [-Wunused-but-set-variable]

'buff_addr' is never used since inroduction in
commit fc62b3fc9021 ("megaraid_sas : Firmware crash dump feature support")

'ci_h' is not used since commit 9b3d028f3468 ("scsi: megaraid_sas:
Pre-allocate frequently used DMA buffers")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 39d173ed5b69..92e576228d5f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3135,7 +3135,6 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	u32 size;
-	unsigned long buff_addr;
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
 	unsigned long src_addr;
 	unsigned long flags;
@@ -3152,8 +3151,6 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 		return -EINVAL;
 	}
 
-	buff_addr = (unsigned long) buf;
-
 	if (buff_offset > (instance->fw_crash_buffer_size * dmachunk)) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump offset is out of range\n");
@@ -4401,7 +4398,6 @@ megasas_get_pd_list(struct megasas_instance *instance)
 	struct megasas_dcmd_frame *dcmd;
 	struct MR_PD_LIST *ci;
 	struct MR_PD_ADDRESS *pd_addr;
-	dma_addr_t ci_h = 0;
 
 	if (instance->pd_list_not_supported) {
 		dev_info(&instance->pdev->dev, "MR_DCMD_PD_LIST_QUERY "
@@ -4410,7 +4406,6 @@ megasas_get_pd_list(struct megasas_instance *instance)
 	}
 
 	ci = instance->pd_list_buf;
-	ci_h = instance->pd_list_buf_h;
 
 	cmd = megasas_get_cmd(instance);
 
-- 
2.17.1


