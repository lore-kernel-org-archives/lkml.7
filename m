Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226B21871
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfDKMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:47:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbfDKMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:47:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B4305CC29C2BA525B29B;
        Thu, 11 Apr 2019 20:47:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:47:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 5/9] scsi: hisi_sas: allocate different SAS address for directly attached situation
Date:   Thu, 11 Apr 2019 20:46:40 +0800
Message-ID: <1554986804-233706-6-git-send-email-john.garry@huawei.com>
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

From: Xiang Chen <chenxiang66@hisilicon.com>

In commit 8b8d66531555 ("scsi: hisi_sas: make SAS address of SATA
disks unique"), we ensured that each SATA disk in the system has a
unique SAS address, even if it is fake. That was for v2 hw.

Add this for v3 hw.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3b33816ea6e6..89551b772cd4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1380,6 +1380,7 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 		struct hisi_sas_initial_fis *initial_fis;
 		struct dev_to_host_fis *fis;
 		u8 attached_sas_addr[SAS_ADDR_SIZE] = {0};
+		struct Scsi_Host *shost = hisi_hba->shost;
 
 		dev_info(dev, "phyup: phy%d link_rate=%d(sata)\n", phy_no, link_rate);
 		initial_fis = &hisi_hba->initial_fis[phy_no];
@@ -1396,6 +1397,7 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 		sas_phy->oob_mode = SATA_OOB_MODE;
 		attached_sas_addr[0] = 0x50;
+		attached_sas_addr[6] = shost->host_no;
 		attached_sas_addr[7] = phy_no;
 		memcpy(sas_phy->attached_sas_addr,
 		       attached_sas_addr,
-- 
2.17.1

