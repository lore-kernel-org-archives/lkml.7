Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C232133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfB1Ovn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:51:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733178AbfB1Ovg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:51:36 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B22FBD312F0EDEA25D42;
        Thu, 28 Feb 2019 22:51:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 22:51:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 6/6] scsi: hisi_sas: Change SERDES_CFG init value to increase reliability of HiLink
Date:   Thu, 28 Feb 2019 22:51:02 +0800
Message-ID: <1551365462-128193-7-git-send-email-john.garry@huawei.com>
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

With default value of register SERDES_CFG, the link is not stable for some
special disks when running IO. According to HW guys' suggestion, need to
make the bit10~19 value of register SERDES_CFG the max value to increase
the reliability of the HiLink.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: Yupeng Zhou <zhouyupeng1@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 720721196b12..e2f2c04355b9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -129,6 +129,7 @@
 #define PHY_CTRL_RESET_MSK		(0x1 << PHY_CTRL_RESET_OFF)
 #define CMD_HDR_PIR_OFF			8
 #define CMD_HDR_PIR_MSK			(0x1 << CMD_HDR_PIR_OFF)
+#define SERDES_CFG			(PORT_BASE + 0x1c)
 #define SL_CFG				(PORT_BASE + 0x84)
 #define AIP_LIMIT			(PORT_BASE + 0x90)
 #define SL_CONTROL			(PORT_BASE + 0x94)
@@ -525,6 +526,7 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 		}
 		hisi_sas_phy_write32(hisi_hba, i, PROG_PHY_LINK_RATE,
 			prog_phy_link_rate);
+		hisi_sas_phy_write32(hisi_hba, i, SERDES_CFG, 0xffc00);
 		hisi_sas_phy_write32(hisi_hba, i, SAS_RX_TRAIN_TIMER, 0x13e80);
 		hisi_sas_phy_write32(hisi_hba, i, CHL_INT0, 0xffffffff);
 		hisi_sas_phy_write32(hisi_hba, i, CHL_INT1, 0xffffffff);
-- 
2.17.1

