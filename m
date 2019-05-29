Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC5C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB50208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfE2KAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:00:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfE2KAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:00:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96C3825A9C013174C762;
        Wed, 29 May 2019 18:00:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 29 May 2019 18:00:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 4/6] scsi: hisi_sas: Change the type of some numbers to unsigned
Date:   Wed, 29 May 2019 17:58:45 +0800
Message-ID: <1559123927-160502-5-git-send-email-john.garry@huawei.com>
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

From: Xiang Chen <chenxiang66@hisilicon.com>

It reports a error as follows from some tools at two places in our code:
runtime error: left shift of 4 by 29 places cannot be represented in type
'int'
So change the type of the two number to unsigned to avoid the error.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3efb1e72bdab..492ada65d41a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1344,7 +1344,7 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 	if (parent_dev && DEV_IS_EXPANDER(parent_dev->dev_type))
 		hdr->dw0 |= cpu_to_le32(3 << CMD_HDR_CMD_OFF);
 	else
-		hdr->dw0 |= cpu_to_le32(4 << CMD_HDR_CMD_OFF);
+		hdr->dw0 |= cpu_to_le32(4U << CMD_HDR_CMD_OFF);
 
 	switch (task->data_dir) {
 	case DMA_TO_DEVICE:
@@ -1412,7 +1412,7 @@ static void prep_abort_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 
 	/* dw0 */
-	hdr->dw0 = cpu_to_le32((5 << CMD_HDR_CMD_OFF) | /*abort*/
+	hdr->dw0 = cpu_to_le32((5U << CMD_HDR_CMD_OFF) | /*abort*/
 			       (port->id << CMD_HDR_PORT_OFF) |
 				   (dev_is_sata(dev)
 					<< CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
-- 
2.17.1

