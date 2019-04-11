Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35332C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36DB2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDKMs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:48:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfDKMra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:47:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A37E31944EADB8149C1D;
        Thu, 11 Apr 2019 20:47:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:47:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 2/9] scsi: hisi_sas: Remedy inconsistent PHY down state in software
Date:   Thu, 11 Apr 2019 20:46:37 +0800
Message-ID: <1554986804-233706-3-git-send-email-john.garry@huawei.com>
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

Currently there are two scenarioes which may cause PHY state of hardware
(which is 0) is inconsistent with the state held in software:
- Unplug SAS wire before get_phys_state when SAS controller reset, then the interrupts
of phy down are ignored, phy state is 0 before reset, and it also gets 0 after
reset, so phy down doesn't occur even if unpluged SAS wire;
- For v3 hw later version, it will close bus when 2 bit ECC error occur.
So if unplug SAS wire at that time, interrupts of phy down also not occur.
So at last it will cause host reset. It also get phy state 0 before and
after reset, the same issue occurs.

To solve it, use hisi_sas_phy_down() directly in rescan topology function.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a1eaddcf740d..e7401e2bea27 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1427,9 +1427,9 @@ static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 old_state,
 					sas_ha->notify_port_event(sas_phy,
 							PORTE_BROADCAST_RCVD);
 			}
-		} else if (old_state & (1 << phy_no))
-			/* PHY down but was up before */
+		} else {
 			hisi_sas_phy_down(hisi_hba, phy_no, 0);
+		}
 
 	}
 }
-- 
2.17.1

