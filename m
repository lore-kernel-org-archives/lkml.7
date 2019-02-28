Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35742133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfB1Ov3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:51:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727779AbfB1Ov3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:51:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A8DD0B02891370821443;
        Thu, 28 Feb 2019 22:51:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 22:51:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/6] scsi: hisi_sas: Set PHY linkrate when disconnected
Date:   Thu, 28 Feb 2019 22:51:00 +0800
Message-ID: <1551365462-128193-5-git-send-email-john.garry@huawei.com>
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

When the PHY comes down, we currently do not set the negotiated linkrate:
root@(none)$ pwd
/sys/class/sas_phy/phy-0:0
root@(none)$ more enable
1
root@(none)$ more negotiated_linkrate
12.0 Gbit
root@(none)$ echo 0 > enable
root@(none)$ more negotiated_linkrate
12.0 Gbit
root@(none)$

This patch fixes the driver code to set it properly when the PHY comes
down.

If the PHY had been enabled, then set unknown; otherwise, flag as
disabled.

The logical place to set the negotiated linkrate for this scenario is PHY
down routine, which is called from the PHY down ISR.

However, it is not possible to know if the PHY comes down due to PHY
disable or loss of link, as sas_phy.enabled member is not set until after
the transport disable routine is complete, which races with the PHY down
ISR.

As an imperfect solution, use sas_phy_data.enable as the flag to know if
the PHY is down due to disable. It's imperfect, as sas_phy_data is
internal to libsas.

I can't see another way without adding a new field to hisi_sas_phy and
managing it, or changing SCSI SAS transport.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index dd03dcbd3786..d8204bc3931b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,6 +10,7 @@
  */
 
 #include "hisi_sas.h"
+#include "../libsas/sas_internal.h"
 #define DRV_NAME "hisi_sas"
 
 #define DEV_IS_GONE(dev) \
@@ -2126,9 +2127,18 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
 
 static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
 {
+	struct asd_sas_phy *sas_phy = &phy->sas_phy;
+	struct sas_phy *sphy = sas_phy->phy;
+	struct sas_phy_data *d = sphy->hostdata;
+
 	phy->phy_attached = 0;
 	phy->phy_type = 0;
 	phy->port = NULL;
+
+	if (d->enable)
+		sphy->negotiated_linkrate = SAS_LINK_RATE_UNKNOWN;
+	else
+		sphy->negotiated_linkrate = SAS_PHY_DISABLED;
 }
 
 void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy)
-- 
2.17.1

