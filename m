Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26536208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfE1GAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:00:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfE1GAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:00:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EE7D8791914B541E114;
        Tue, 28 May 2019 14:00:48 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 May 2019 14:00:39 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoshaokai@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <xuechaojing@huawei.com>
Subject: [PATCH net-next] hinic: fix a bug in set rx mode
Date:   Mon, 27 May 2019 22:10:05 +0000
Message-ID: <20190527221005.10073-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in set_rx_mode, __dev_mc_sync and netdev_for_each_mc_addr will
repeatedly set the multicast mac address. so we delete this loop.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index e64bc664f687..cfd3f4232cac 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -724,7 +724,6 @@ static void set_rx_mode(struct work_struct *work)
 {
 	struct hinic_rx_mode_work *rx_mode_work = work_to_rx_mode_work(work);
 	struct hinic_dev *nic_dev = rx_mode_work_to_nic_dev(rx_mode_work);
-	struct netdev_hw_addr *ha;
 
 	netif_info(nic_dev, drv, nic_dev->netdev, "set rx mode work\n");
 
@@ -732,9 +731,6 @@ static void set_rx_mode(struct work_struct *work)
 
 	__dev_uc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
 	__dev_mc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
-
-	netdev_for_each_mc_addr(ha, nic_dev->netdev)
-		add_mac_addr(nic_dev->netdev, ha->addr);
 }
 
 static void hinic_set_rx_mode(struct net_device *netdev)
-- 
2.17.1

