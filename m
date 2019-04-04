Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30569C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915420882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfDDIrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728643AbfDDIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A540D6AE4AE9E3F32888;
        Thu,  4 Apr 2019 16:47:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:46:54 +0800
From:   Yonglong Liu <liuyonglong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH net 4/6] net: hns: fix ICMP6 neighbor solicitation messages discard problem
Date:   Thu, 4 Apr 2019 16:46:45 +0800
Message-ID: <1554367607-130891-5-git-send-email-liuyonglong@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
References: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICMP6 neighbor solicitation messages will be discard by the Hip06
chips, because of not setting forwarding pool. Enable promisc mode
has the same problem.

This patch fix the wrong forwarding table configs for the multicast
vague matching when enable promisc mode, and add forwarding pool
for the forwarding table.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 33 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index ac55db0..f5ff07c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2750,6 +2750,17 @@ int hns_dsaf_get_regs_count(void)
 	return DSAF_DUMP_REGS_NUM;
 }
 
+static int hns_dsaf_get_port_id(u8 port)
+{
+	if (port < DSAF_SERVICE_NW_NUM)
+		return port;
+
+	if (port >= DSAF_BASE_INNER_PORT_NUM)
+		return port - DSAF_BASE_INNER_PORT_NUM + DSAF_SERVICE_NW_NUM;
+
+	return -EINVAL;
+}
+
 static void set_promisc_tcam_enable(struct dsaf_device *dsaf_dev, u32 port)
 {
 	struct dsaf_tbl_tcam_ucast_cfg tbl_tcam_ucast = {0, 1, 0, 0, 0x80};
@@ -2815,23 +2826,33 @@ static void set_promisc_tcam_enable(struct dsaf_device *dsaf_dev, u32 port)
 	memset(&temp_key, 0x0, sizeof(temp_key));
 	mask_entry.addr[0] = 0x01;
 	hns_dsaf_set_mac_key(dsaf_dev, &mask_key, mask_entry.in_vlan_id,
-			     port, mask_entry.addr);
+			     0xf, mask_entry.addr);
 	tbl_tcam_mcast.tbl_mcast_item_vld = 1;
 	tbl_tcam_mcast.tbl_mcast_old_en = 0;
 
-	if (port < DSAF_SERVICE_NW_NUM) {
-		mskid = port;
-	} else if (port >= DSAF_BASE_INNER_PORT_NUM) {
-		mskid = port - DSAF_BASE_INNER_PORT_NUM + DSAF_SERVICE_NW_NUM;
-	} else {
+	/* set MAC port to handle multicast */
+	mskid = hns_dsaf_get_port_id(port);
+	if (mskid == -EINVAL) {
 		dev_err(dsaf_dev->dev, "%s,pnum(%d)error,key(%#x:%#x)\n",
 			dsaf_dev->ae_dev.name, port,
 			mask_key.high.val, mask_key.low.val);
 		return;
 	}
+	dsaf_set_bit(tbl_tcam_mcast.tbl_mcast_port_msk[mskid / 32],
+		     mskid % 32, 1);
 
+	/* set pool bit map to handle multicast */
+	mskid = hns_dsaf_get_port_id(port_num);
+	if (mskid == -EINVAL) {
+		dev_err(dsaf_dev->dev,
+			"%s, pool bit map pnum(%d)error,key(%#x:%#x)\n",
+			dsaf_dev->ae_dev.name, port_num,
+			mask_key.high.val, mask_key.low.val);
+		return;
+	}
 	dsaf_set_bit(tbl_tcam_mcast.tbl_mcast_port_msk[mskid / 32],
 		     mskid % 32, 1);
+
 	memcpy(&temp_key, &mask_key, sizeof(mask_key));
 	hns_dsaf_tcam_mc_cfg_vague(dsaf_dev, entry_index, &tbl_tcam_data_mc,
 				   (struct dsaf_tbl_tcam_data *)(&mask_key),
-- 
2.8.1

