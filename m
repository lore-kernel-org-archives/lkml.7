Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5854C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F44F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfDLI62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbfDLI61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFEB922D21713472FF63;
        Fri, 12 Apr 2019 16:58:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 16:58:16 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/6] scsi: libsas: Do discovery on empty PHY to update PHY info
Date:   Fri, 12 Apr 2019 16:57:56 +0800
Message-ID: <1555059478-36224-6-git-send-email-john.garry@huawei.com>
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

When we discover the PHY is empty in sas_rediscover_dev(), the PHY
information (like negotiated linkrate) is not updated.

As such, for a user examining sysfs for that PHY, they would see
incorrect values:
root@(none)$ cd /sys/class/sas_phy/phy-0:0:20
root@(none)$ more negotiated_linkrate
3.0 Gbit
root@(none)$ echo 0 > enable
root@(none)$ more negotiated_linkrate
3.0 Gbit

So fix this, simply discover the PHY again, even though we know it's
empty; in the above example, this gives us:
root@(none)$ more negotiated_linkrate
Phy disabled

We must do this after unregistering the device associated with the PHY
(in sas_unregister_devs_sas_addr()).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 6f569a65d791..ad96bc843acc 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -2068,6 +2068,11 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
 		phy->phy_state = PHY_EMPTY;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
+		/*
+		 * Even though the PHY is empty, for convenience we discover
+		 * the PHY to update the PHY info, like negotiated linkrate.
+		 */
+		sas_ex_phy_discover(dev, phy_id);
 		return res;
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
-- 
2.17.1

