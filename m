Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D221C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE682184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDKMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:47:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfDKMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:47:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D5A563E6FF00AA29964B;
        Thu, 11 Apr 2019 20:47:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:47:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 7/9] scsi: hisi_sas: Don't hard reset disk during controller reset
Date:   Thu, 11 Apr 2019 20:46:42 +0800
Message-ID: <1554986804-233706-8-git-send-email-john.garry@huawei.com>
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

In the function of hisi_sas_init_device(), we added ops->hardreset() to
clear affiliation of STP target port or handle [STP pending] state.

Function hisi_sas_init_device() will be called when a device is found or
during controller reset. At controller reset, we call
hisi_sas_init_device() to re-init the disks, so calling hardreset() is
unnecessary and it also will cause some delay at controller reset.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index ede812759991..c02cf78a20c7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -754,7 +754,8 @@ static int hisi_sas_init_device(struct domain_device *device)
 		 * STP target port
 		 */
 		local_phy = sas_get_local_phy(device);
-		if (!scsi_is_sas_phy_local(local_phy)) {
+		if (!scsi_is_sas_phy_local(local_phy) &&
+		    !test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags)) {
 			unsigned long deadline = ata_deadline(jiffies, 20000);
 			struct sata_device *sata_dev = &device->sata_dev;
 			struct ata_host *ata_host = sata_dev->ata_host;
-- 
2.17.1

