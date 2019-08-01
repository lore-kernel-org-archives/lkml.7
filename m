Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324EF217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfHAD6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:58:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbfHAD5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:57:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 747D9A86CF3BF4E64737;
        Thu,  1 Aug 2019 11:57:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 11:57:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: minor cleanup in hns3_clean_rx_ring
Date:   Thu, 1 Aug 2019 11:55:39 +0800
Message-ID: <1564631745-36733-7-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564631745-36733-1-git-send-email-tanhuazhong@huawei.com>
References: <1564631745-36733-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The unused_count variable is used to indicate how many
RX BD need attaching new buffer in hns3_clean_rx_ring,
and the clean_count variable has the similar meaning.

This patch removes the clean_count variable and use
unused_count to uniformly indicate the RX BD that need
attaching new buffer.

This patch also clean up some coding style related to
variable assignment in hns3_clean_rx_ring.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 79973a0..ed05fb9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2909,24 +2909,22 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 		       void (*rx_fn)(struct hns3_enet_ring *, struct sk_buff *))
 {
 #define RCB_NOF_ALLOC_RX_BUFF_ONCE 16
-	int recv_pkts, recv_bds, clean_count, err;
 	int unused_count = hns3_desc_unused(ring);
 	struct sk_buff *skb = ring->skb;
-	int num;
+	int recv_pkts = 0;
+	int recv_bds = 0;
+	int err, num;
 
 	num = readl_relaxed(ring->tqp->io_base + HNS3_RING_RX_RING_FBDNUM_REG);
 	rmb(); /* Make sure num taken effect before the other data is touched */
 
-	recv_pkts = 0, recv_bds = 0, clean_count = 0;
 	num -= unused_count;
 	unused_count -= ring->pending_buf;
 
 	while (recv_pkts < budget && recv_bds < num) {
 		/* Reuse or realloc buffers */
-		if (clean_count + unused_count >= RCB_NOF_ALLOC_RX_BUFF_ONCE) {
-			hns3_nic_alloc_rx_buffers(ring,
-						  clean_count + unused_count);
-			clean_count = 0;
+		if (unused_count >= RCB_NOF_ALLOC_RX_BUFF_ONCE) {
+			hns3_nic_alloc_rx_buffers(ring, unused_count);
 			unused_count = hns3_desc_unused(ring) -
 					ring->pending_buf;
 		}
@@ -2940,7 +2938,7 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 			goto out;
 		} else if (unlikely(err)) {  /* Do jump the err */
 			recv_bds += ring->pending_buf;
-			clean_count += ring->pending_buf;
+			unused_count += ring->pending_buf;
 			ring->skb = NULL;
 			ring->pending_buf = 0;
 			continue;
@@ -2948,7 +2946,7 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 
 		rx_fn(ring, skb);
 		recv_bds += ring->pending_buf;
-		clean_count += ring->pending_buf;
+		unused_count += ring->pending_buf;
 		ring->skb = NULL;
 		ring->pending_buf = 0;
 
@@ -2957,8 +2955,8 @@ int hns3_clean_rx_ring(struct hns3_enet_ring *ring, int budget,
 
 out:
 	/* Make all data has been write before submit */
-	if (clean_count + unused_count > 0)
-		hns3_nic_alloc_rx_buffers(ring, clean_count + unused_count);
+	if (unused_count > 0)
+		hns3_nic_alloc_rx_buffers(ring, unused_count);
 
 	return recv_pkts;
 }
-- 
2.7.4

