Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8247C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB112083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfDLI6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbfDLI63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:29 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BDD497B9900FE6028435;
        Fri, 12 Apr 2019 16:58:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 16:58:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/6] scsi: libsas: Stop hardcoding SAS address length
Date:   Fri, 12 Apr 2019 16:57:52 +0800
Message-ID: <1555059478-36224-2-git-send-email-john.garry@huawei.com>
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

Many times we use 8 for SAS address length, while we already have a macro
for this - SAS_ADDR_SIZE.

Replace instances of this with the macro. However, don't touch the
SAS address array sizes sas.h, as these are defined according to the
SAS spec.

Some missing whitespaces are also added, and whitespace indentation
in sas_hash_addr() is also fixed (see sas_hash_addr()).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 15 +++++------
 drivers/scsi/libsas/sas_init.c     | 40 ++++++++++++++++--------------
 include/scsi/libsas.h              |  6 ++---
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 17b45a0c7bc3..93f297199d4c 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1151,7 +1151,7 @@ static int sas_find_sub_addr(struct domain_device *dev, u8 *sub_addr)
 		     phy->attached_dev_type == SAS_FANOUT_EXPANDER_DEVICE) &&
 		    phy->routing_attr == SUBTRACTIVE_ROUTING) {
 
-			memcpy(sub_addr, phy->attached_sas_addr,SAS_ADDR_SIZE);
+			memcpy(sub_addr, phy->attached_sas_addr, SAS_ADDR_SIZE);
 
 			return 1;
 		}
@@ -1163,7 +1163,7 @@ static int sas_check_level_subtractive_boundary(struct domain_device *dev)
 {
 	struct expander_device *ex = &dev->ex_dev;
 	struct domain_device *child;
-	u8 sub_addr[8] = {0, };
+	u8 sub_addr[SAS_ADDR_SIZE] = {0, };
 
 	list_for_each_entry(child, &ex->children, siblings) {
 		if (child->dev_type != SAS_EDGE_EXPANDER_DEVICE &&
@@ -1173,7 +1173,7 @@ static int sas_check_level_subtractive_boundary(struct domain_device *dev)
 			sas_find_sub_addr(child, sub_addr);
 			continue;
 		} else {
-			u8 s2[8];
+			u8 s2[SAS_ADDR_SIZE];
 
 			if (sas_find_sub_addr(child, s2) &&
 			    (SAS_ADDR(sub_addr) != SAS_ADDR(s2))) {
@@ -1760,10 +1760,11 @@ static int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
 
 	res = sas_get_phy_discover(dev, phy_id, disc_resp);
 	if (res == 0) {
-		memcpy(sas_addr, disc_resp->disc.attached_sas_addr, 8);
+		memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
+		       SAS_ADDR_SIZE);
 		*type = to_dev_type(dr);
 		if (*type == 0)
-			memset(sas_addr, 0, 8);
+			memset(sas_addr, 0, SAS_ADDR_SIZE);
 	}
 	kfree(disc_resp);
 	return res;
@@ -2027,10 +2028,10 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
-	u8 sas_addr[8];
+	u8 sas_addr[SAS_ADDR_SIZE];
 	int res;
 
-	memset(sas_addr, 0, 8);
+	memset(sas_addr, 0, SAS_ADDR_SIZE);
 	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
 	switch (res) {
 	case SMP_RESP_NO_PHY:
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 221340ee8651..213c85557bf9 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -87,25 +87,27 @@ EXPORT_SYMBOL_GPL(sas_free_task);
 /*------------ SAS addr hash -----------*/
 void sas_hash_addr(u8 *hashed, const u8 *sas_addr)
 {
-        const u32 poly = 0x00DB2777;
-        u32     r = 0;
-        int     i;
-
-        for (i = 0; i < 8; i++) {
-                int b;
-                for (b = 7; b >= 0; b--) {
-                        r <<= 1;
-                        if ((1 << b) & sas_addr[i]) {
-                                if (!(r & 0x01000000))
-                                        r ^= poly;
-                        } else if (r & 0x01000000)
-                                r ^= poly;
-                }
-        }
-
-        hashed[0] = (r >> 16) & 0xFF;
-        hashed[1] = (r >> 8) & 0xFF ;
-        hashed[2] = r & 0xFF;
+	const u32 poly = 0x00DB2777;
+	u32 r = 0;
+	int i;
+
+	for (i = 0; i < SAS_ADDR_SIZE; i++) {
+		int b;
+
+		for (b = (SAS_ADDR_SIZE - 1); b >= 0; b--) {
+			r <<= 1;
+			if ((1 << b) & sas_addr[i]) {
+				if (!(r & 0x01000000))
+					r ^= poly;
+			} else if (r & 0x01000000) {
+				r ^= poly;
+			}
+		}
+	}
+
+	hashed[0] = (r >> 16) & 0xFF;
+	hashed[1] = (r >> 8) & 0xFF;
+	hashed[2] = r & 0xFF;
 }
 
 int sas_register_ha(struct sas_ha_struct *sas_ha)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 56b2dba7d911..cfaaf1254211 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -245,9 +245,9 @@ static inline struct sas_discovery_event *to_sas_discovery_event(struct work_str
 struct sas_discovery {
 	struct sas_discovery_event disc_work[DISC_NUM_EVENTS];
 	unsigned long    pending;
-	u8     fanout_sas_addr[8];
-	u8     eeds_a[8];
-	u8     eeds_b[8];
+	u8     fanout_sas_addr[SAS_ADDR_SIZE];
+	u8     eeds_a[SAS_ADDR_SIZE];
+	u8     eeds_b[SAS_ADDR_SIZE];
 	int    max_level;
 };
 
-- 
2.17.1

