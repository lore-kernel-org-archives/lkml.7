Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D72C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F522084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDCDKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:10:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728543AbfDCDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:09:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 22BBF486C279BAE7B6B3;
        Wed,  3 Apr 2019 11:09:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 11:09:10 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: add protect when handling mac addr list
Date:   Wed, 3 Apr 2019 11:07:57 +0800
Message-ID: <1554260881-44948-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

It used netdev->uc and netdev->mc list in function
hns3_recover_hw_addr() and hns3_remove_hw_addr().
We should add protect for them.

Fixes: f05e21097121 ("net: hns3: Clear mac vlan table entries when unload driver or function reset")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 5b34d2e..476c23d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3791,12 +3791,13 @@ static int hns3_recover_hw_addr(struct net_device *ndev)
 	struct netdev_hw_addr *ha, *tmp;
 	int ret = 0;
 
+	netif_addr_lock_bh(ndev);
 	/* go through and sync uc_addr entries to the device */
 	list = &ndev->uc;
 	list_for_each_entry_safe(ha, tmp, &list->list, list) {
 		ret = hns3_nic_uc_sync(ndev, ha->addr);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* go through and sync mc_addr entries to the device */
@@ -3804,9 +3805,11 @@ static int hns3_recover_hw_addr(struct net_device *ndev)
 	list_for_each_entry_safe(ha, tmp, &list->list, list) {
 		ret = hns3_nic_mc_sync(ndev, ha->addr);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+out:
+	netif_addr_unlock_bh(ndev);
 	return ret;
 }
 
@@ -3817,6 +3820,7 @@ static void hns3_remove_hw_addr(struct net_device *netdev)
 
 	hns3_nic_uc_unsync(netdev, netdev->dev_addr);
 
+	netif_addr_lock_bh(netdev);
 	/* go through and unsync uc_addr entries to the device */
 	list = &netdev->uc;
 	list_for_each_entry_safe(ha, tmp, &list->list, list)
@@ -3827,6 +3831,8 @@ static void hns3_remove_hw_addr(struct net_device *netdev)
 	list_for_each_entry_safe(ha, tmp, &list->list, list)
 		if (ha->refcount > 1)
 			hns3_nic_mc_unsync(netdev, ha->addr);
+
+	netif_addr_unlock_bh(netdev);
 }
 
 static void hns3_clear_tx_ring(struct hns3_enet_ring *ring)
-- 
2.7.4

