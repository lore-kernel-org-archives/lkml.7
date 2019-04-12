Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547CDC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA7A2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfDLI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfDLI63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:29 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C747261A9F825433AED7;
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
Subject: [PATCH 3/6] scsi: libsas: Improve vague log in SAS rediscovery
Date:   Fri, 12 Apr 2019 16:57:54 +0800
Message-ID: <1555059478-36224-4-git-send-email-john.garry@huawei.com>
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

When an expander PHY which was part of a wideport disconnects, we would
see a log like this from sas_rediscover():
[   39.695554] sas: phy20 part of wide port with phy16

Here, phy20 is the PHY that disconnected, and phy16 is the lowest indexed
member PHY of the wideport.

The log implies the phy20 is still part of the wideport with phy16, so
is misleading or, at least, vague.

Improve the logs in SAS rediscovery by removing this log and adding
a log in sas_rediscover_dev() to tell what's really going on.

While we're at it, also make the logs in sas_find_bcast_dev() more
informative (and more consistent with the reset of the expander logs).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index dfdf3c94d326..6f569a65d791 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1876,10 +1876,12 @@ static int sas_find_bcast_dev(struct domain_device *dev,
 		if (phy_id != -1) {
 			*src_dev = dev;
 			ex->ex_change_count = ex_change_count;
-			pr_info("Expander phy change count has changed\n");
+			pr_info("ex %016llx phy%d change count has changed\n",
+				SAS_ADDR(dev->sas_addr), phy_id);
 			return res;
 		} else
-			pr_info("Expander phys DID NOT change\n");
+			pr_info("ex %016llx phys DID NOT change\n",
+				SAS_ADDR(dev->sas_addr));
 	}
 	list_for_each_entry(ch, &ex->children, siblings) {
 		if (ch->dev_type == SAS_EDGE_EXPANDER_DEVICE || ch->dev_type == SAS_FANOUT_EXPANDER_DEVICE) {
@@ -2028,14 +2030,22 @@ static bool dev_type_flutter(enum sas_device_type new, enum sas_device_type old)
 	return false;
 }
 
-static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
+static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
+			      bool last, int sibling)
 {
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
 	u8 sas_addr[SAS_ADDR_SIZE];
+	char msg[80] = "";
 	int res;
 
+	if (!last)
+		sprintf(msg, ", part of a wide port with phy%d", sibling);
+
+	pr_debug("ex %016llx rediscovering phy%d%s\n", SAS_ADDR(dev->sas_addr),
+		 phy_id, msg);
+
 	memset(sas_addr, 0, SAS_ADDR_SIZE);
 	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
 	switch (res) {
@@ -2115,13 +2125,11 @@ static int sas_rediscover(struct domain_device *dev, const int phy_id)
 				continue;
 			if (SAS_ADDR(phy->attached_sas_addr) ==
 			    SAS_ADDR(changed_phy->attached_sas_addr)) {
-				pr_debug("phy%d part of wide port with phy%d\n",
-					 phy_id, i);
 				last = false;
 				break;
 			}
 		}
-		res = sas_rediscover_dev(dev, phy_id, last);
+		res = sas_rediscover_dev(dev, phy_id, last, i);
 	} else
 		res = sas_discover_new(dev, phy_id);
 	return res;
-- 
2.17.1

