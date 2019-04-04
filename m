Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B55C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E705F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDDIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728672AbfDDIrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B790CF2E92CE66AB8C37;
        Thu,  4 Apr 2019 16:47:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:46:53 +0800
From:   Yonglong Liu <liuyonglong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH net 1/6] net: hns: fix KASAN: use-after-free in hns_nic_net_xmit_hw()
Date:   Thu, 4 Apr 2019 16:46:42 +0800
Message-ID: <1554367607-130891-2-git-send-email-liuyonglong@huawei.com>
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

From: Liubin Shu <shuliubin@huawei.com>

This patch is trying to fix the issue due to:
[27237.844750] BUG: KASAN: use-after-free in hns_nic_net_xmit_hw+0x708/0xa18[hns_enet_drv]

After hnae_queue_xmit() in hns_nic_net_xmit_hw(), can be
interrupted by interruptions, and than call hns_nic_tx_poll_one()
to handle the new packets, and free the skb. So, when turn back to
hns_nic_net_xmit_hw(), calling skb->len will cause use-after-free.

This patch update tx ring statistics in hns_nic_tx_poll_one() to
fix the bug.

Signed-off-by: Liubin Shu <shuliubin@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 60e7d7a..e5a7c07 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -376,8 +376,6 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 	wmb(); /* commit all data before submit */
 	assert(skb->queue_mapping < priv->ae_handle->q_num);
 	hnae_queue_xmit(priv->ae_handle->qs[skb->queue_mapping], buf_num);
-	ring->stats.tx_pkts++;
-	ring->stats.tx_bytes += skb->len;
 
 	return NETDEV_TX_OK;
 
@@ -999,6 +997,9 @@ static int hns_nic_tx_poll_one(struct hns_nic_ring_data *ring_data,
 		/* issue prefetch for next Tx descriptor */
 		prefetch(&ring->desc_cb[ring->next_to_clean]);
 	}
+	/* update tx ring statistics. */
+	ring->stats.tx_pkts += pkts;
+	ring->stats.tx_bytes += bytes;
 
 	NETIF_TX_UNLOCK(ring);
 
-- 
2.8.1

