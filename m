Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C17C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E155520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFMPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:49:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731701AbfFMJOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:14:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B9755194BDDE2808F94;
        Thu, 13 Jun 2019 17:14:19 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Jun 2019 17:14:09 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: delay ring buffer clearing during reset
Date:   Thu, 13 Jun 2019 17:12:31 +0800
Message-ID: <1560417152-53050-12-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560417152-53050-1-git-send-email-tanhuazhong@huawei.com>
References: <1560417152-53050-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The driver may not be able to disable the ring through firmware
when downing the netdev during reset process, which may cause
hardware accessing freed buffer problem.

This patch delays the ring buffer clearing to reset uninit
process because hardware will not access the ring buffer after
hardware reset is completed.

Fixes: bb6b94a896d4 ("net: hns3: Add reset interface implementation in client")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 1a602bd..735419e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -29,7 +29,7 @@
 #define hns3_tx_bd_count(S)	DIV_ROUND_UP(S, HNS3_MAX_BD_SIZE)
 
 static void hns3_clear_all_ring(struct hnae3_handle *h);
-static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h);
+static void hns3_force_clear_all_ring(struct hnae3_handle *h);
 static void hns3_remove_hw_addr(struct net_device *netdev);
 
 static const char hns3_driver_name[] = "hns3";
@@ -488,7 +488,12 @@ static void hns3_nic_net_down(struct net_device *netdev)
 	/* free irq resources */
 	hns3_nic_uninit_irq(priv);
 
-	hns3_clear_all_ring(priv->ae_handle);
+	/* delay ring buffer clearing to hns3_reset_notify_uninit_enet
+	 * during reset process, because driver may not be able
+	 * to disable the ring through firmware when downing the netdev.
+	 */
+	if (!hns3_nic_resetting(netdev))
+		hns3_clear_all_ring(priv->ae_handle);
 }
 
 static int hns3_nic_net_stop(struct net_device *netdev)
@@ -3914,7 +3919,7 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_del_all_fd_rules(netdev, true);
 
-	hns3_force_clear_all_rx_ring(handle);
+	hns3_force_clear_all_ring(handle);
 
 	hns3_nic_uninit_vector_data(priv);
 
@@ -4083,7 +4088,7 @@ static void hns3_force_clear_rx_ring(struct hns3_enet_ring *ring)
 	}
 }
 
-static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h)
+static void hns3_force_clear_all_ring(struct hnae3_handle *h)
 {
 	struct net_device *ndev = h->kinfo.netdev;
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
@@ -4091,6 +4096,9 @@ static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h)
 	u32 i;
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		ring = priv->ring_data[i].ring;
+		hns3_clear_tx_ring(ring);
+
 		ring = priv->ring_data[i + h->kinfo.num_tqps].ring;
 		hns3_force_clear_rx_ring(ring);
 	}
@@ -4321,7 +4329,8 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 		return 0;
 	}
 
-	hns3_force_clear_all_rx_ring(handle);
+	hns3_clear_all_ring(handle);
+	hns3_force_clear_all_ring(handle);
 
 	hns3_nic_uninit_vector_data(priv);
 
-- 
2.7.4

