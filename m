Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79BAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFEC21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfETNsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:48:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfETNsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:48:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9F584F835939B5E97F30;
        Mon, 20 May 2019 21:48:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 21:48:10 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2] scsi: libsas: no need to join wide port again in sas_ex_discover_dev()
Date:   Mon, 20 May 2019 22:06:00 +0800
Message-ID: <20190520140600.22861-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are processing events synchronously now, the second call of
sas_ex_join_wide_port() in sas_ex_discover_dev() is not needed. There
will be no races with other works in disco workqueue. So remove the
second sas_ex_join_wide_port().

I did not change the return value of 'res' to error when discover failed
because we need to continue to discover other phys if one phy discover
failed. So let's keep that logic as before and just add a debug log to
detect the failure. And directly return if second fanout expander
attatched to the parent expander because it has nothing to do after the
phy is disabled.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---

v2: Directly return in the "second fanout expander" case and change the
	log level to notice.

 drivers/scsi/libsas/sas_expander.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 83f2fd70ce76..a148be23ca09 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1104,7 +1104,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 				 SAS_ADDR(dev->sas_addr),
 				 phy_id);
 			sas_ex_disable_phy(dev, phy_id);
-			break;
+			return res;
 		} else
 			memcpy(dev->port->disc.fanout_sas_addr,
 			       ex_phy->attached_sas_addr, SAS_ADDR_SIZE);
@@ -1116,27 +1116,9 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 		break;
 	}
 
-	if (child) {
-		int i;
-
-		for (i = 0; i < ex->num_phys; i++) {
-			if (ex->ex_phy[i].phy_state == PHY_VACANT ||
-			    ex->ex_phy[i].phy_state == PHY_NOT_PRESENT)
-				continue;
-			/*
-			 * Due to races, the phy might not get added to the
-			 * wide port, so we add the phy to the wide port here.
-			 */
-			if (SAS_ADDR(ex->ex_phy[i].attached_sas_addr) ==
-			    SAS_ADDR(child->sas_addr)) {
-				ex->ex_phy[i].phy_state= PHY_DEVICE_DISCOVERED;
-				if (sas_ex_join_wide_port(dev, i))
-					pr_debug("Attaching ex phy%02d to wide port %016llx\n",
-						 i, SAS_ADDR(ex->ex_phy[i].attached_sas_addr));
-			}
-		}
-	}
-
+	if (!child)
+		pr_notice("ex %016llx phy%02d failed to discover\n",
+			  SAS_ADDR(dev->sas_addr), phy_id);
 	return res;
 }
 
-- 
2.17.2

