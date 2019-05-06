Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E214CC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD52205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEFCuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 22:50:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfEFCuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 22:50:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9235E3BCD15ECC9C1EE8;
        Mon,  6 May 2019 10:50:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 10:50:12 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: unify the page reusing for page size 4K and 64K
Date:   Mon, 6 May 2019 10:48:50 +0800
Message-ID: <1557110932-683-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557110932-683-1-git-send-email-tanhuazhong@huawei.com>
References: <1557110932-683-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When page size is 64K, RX buffer is currently not reused when the
page_offset is moved to last buffer. This patch adds checking to
decide whether the buffer page can be reused when last_offset is
moved beyond last offset.

If the driver is the only user of page when page_offset is moved
to beyond last offset, then buffer can be reused and page_offset
is set to zero.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 45 +++++++------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 25d607c..b6e73fe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2328,50 +2328,31 @@ static void hns3_nic_reuse_page(struct sk_buff *skb, int i,
 				struct hns3_enet_ring *ring, int pull_len,
 				struct hns3_desc_cb *desc_cb)
 {
-	struct hns3_desc *desc;
-	u32 truesize;
-	int size;
-	int last_offset;
-	bool twobufs;
-
-	twobufs = ((PAGE_SIZE < 8192) &&
-		hnae3_buf_size(ring) == HNS3_BUFFER_SIZE_2048);
-
-	desc = &ring->desc[ring->next_to_clean];
-	size = le16_to_cpu(desc->rx.size);
-
-	truesize = hnae3_buf_size(ring);
-
-	if (!twobufs)
-		last_offset = hnae3_page_size(ring) - hnae3_buf_size(ring);
+	struct hns3_desc *desc = &ring->desc[ring->next_to_clean];
+	int size = le16_to_cpu(desc->rx.size);
+	u32 truesize = hnae3_buf_size(ring);
 
 	skb_add_rx_frag(skb, i, desc_cb->priv, desc_cb->page_offset + pull_len,
 			size - pull_len, truesize);
 
-	 /* Avoid re-using remote pages,flag default unreuse */
-	if (unlikely(page_to_nid(desc_cb->priv) != numa_node_id()))
-		return;
-
-	if (twobufs) {
-		/* If we are only owner of page we can reuse it */
-		if (likely(page_count(desc_cb->priv) == 1)) {
-			/* Flip page offset to other buffer */
-			desc_cb->page_offset ^= truesize;
-
-			desc_cb->reuse_flag = 1;
-			/* bump ref count on page before it is given*/
-			get_page(desc_cb->priv);
-		}
+	/* Avoid re-using remote pages, or the stack is still using the page
+	 * when page_offset rollback to zero, flag default unreuse
+	 */
+	if (unlikely(page_to_nid(desc_cb->priv) != numa_node_id()) ||
+	    (!desc_cb->page_offset && page_count(desc_cb->priv) > 1))
 		return;
-	}
 
 	/* Move offset up to the next cache line */
 	desc_cb->page_offset += truesize;
 
-	if (desc_cb->page_offset <= last_offset) {
+	if (desc_cb->page_offset + truesize <= hnae3_page_size(ring)) {
 		desc_cb->reuse_flag = 1;
 		/* Bump ref count on page before it is given*/
 		get_page(desc_cb->priv);
+	} else if (page_count(desc_cb->priv) == 1) {
+		desc_cb->reuse_flag = 1;
+		desc_cb->page_offset = 0;
+		get_page(desc_cb->priv);
 	}
 }
 
-- 
2.7.4

