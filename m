Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8518C2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfDLI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbfDLI6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C2D68F58CF30741F09EE;
        Fri, 12 Apr 2019 16:58:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 16:58:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/6] scsi: libsas: Try to retain programmed min linkrate for SATA min pathway unmatch fixing
Date:   Fri, 12 Apr 2019 16:57:53 +0800
Message-ID: <1555059478-36224-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
References: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for fixing the linkrate matching during discovery such that
the linkrate of a SATA PHY does not exceed min pathway to initiator,
we set the SATA PHY programmed min linkrate to the same value as the
programmed max linkrate.

This is unnecessary, and we should be able to keep the same programmed
min linkrate if it is already lower than this new max programmed linkrate.

This patch makes that change.

In effect, this will not make much difference since we generally will
negotiate a linkrate at the programmed max linkrate, and the programmed
min linkrate will have no impact.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 93f297199d4c..dfdf3c94d326 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -826,9 +826,14 @@ static struct domain_device *sas_ex_discover_end_dev(
 #ifdef CONFIG_SCSI_SAS_ATA
 	if ((phy->attached_tproto & SAS_PROTOCOL_STP) || phy->attached_sata_dev) {
 		if (child->linkrate > parent->min_linkrate) {
+			struct sas_phy *cphy = child->phy;
+			enum sas_linkrate min_prate = cphy->minimum_linkrate,
+				parent_min_lrate = parent->min_linkrate,
+				min_linkrate = (min_prate > parent_min_lrate) ?
+					       parent_min_lrate : 0;
 			struct sas_phy_linkrates rates = {
 				.maximum_linkrate = parent->min_linkrate,
-				.minimum_linkrate = parent->min_linkrate,
+				.minimum_linkrate = min_linkrate,
 			};
 			int ret;
 
-- 
2.17.1

