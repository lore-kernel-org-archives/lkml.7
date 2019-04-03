Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB0C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DE02084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfDCDJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:09:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728483AbfDCDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:09:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 1E26DE6CD093160B361D;
        Wed,  3 Apr 2019 11:09:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 11:09:09 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: minor optimization for datapath
Date:   Wed, 3 Apr 2019 11:07:55 +0800
Message-ID: <1554260881-44948-7-git-send-email-tanhuazhong@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch adds a likely case for hns3_fill_desc and
limits the local variables' scope as much as possible,
also avoid div operation when the tqp_vector->num_tqps
is one.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 21085c4..5b34d2e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1012,7 +1012,6 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
 	struct hns3_desc *desc = &ring->desc[ring->next_to_use];
 	struct device *dev = ring_to_dev(ring);
-	u16 bdtp_fe_sc_vld_ra_ri = 0;
 	struct skb_frag_struct *frag;
 	unsigned int frag_buf_num;
 	int k, sizeoflast;
@@ -1080,12 +1079,30 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 
 	desc_cb->length = size;
 
+	if (likely(size <= HNS3_MAX_BD_SIZE)) {
+		u16 bdtp_fe_sc_vld_ra_ri = 0;
+
+		desc_cb->priv = priv;
+		desc_cb->dma = dma;
+		desc_cb->type = type;
+		desc->addr = cpu_to_le64(dma);
+		desc->tx.send_size = cpu_to_le16(size);
+		hns3_set_txbd_baseinfo(&bdtp_fe_sc_vld_ra_ri, frag_end);
+		desc->tx.bdtp_fe_sc_vld_ra_ri =
+			cpu_to_le16(bdtp_fe_sc_vld_ra_ri);
+
+		ring_ptr_move_fw(ring, next_to_use);
+		return 0;
+	}
+
 	frag_buf_num = hns3_tx_bd_count(size);
 	sizeoflast = size & HNS3_TX_LAST_SIZE_M;
 	sizeoflast = sizeoflast ? sizeoflast : HNS3_MAX_BD_SIZE;
 
 	/* When frag size is bigger than hardware limit, split this frag */
 	for (k = 0; k < frag_buf_num; k++) {
+		u16 bdtp_fe_sc_vld_ra_ri = 0;
+
 		/* The txbd's baseinfo of DESC_TYPE_PAGE & DESC_TYPE_SKB */
 		desc_cb->priv = priv;
 		desc_cb->dma = dma + HNS3_MAX_BD_SIZE * k;
@@ -2891,7 +2908,7 @@ static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
 	struct hns3_enet_tqp_vector *tqp_vector =
 		container_of(napi, struct hns3_enet_tqp_vector, napi);
 	bool clean_complete = true;
-	int rx_budget;
+	int rx_budget = budget;
 
 	if (unlikely(test_bit(HNS3_NIC_STATE_DOWN, &priv->state))) {
 		napi_complete(napi);
@@ -2905,7 +2922,8 @@ static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
 		hns3_clean_tx_ring(ring);
 
 	/* make sure rx ring budget not smaller than 1 */
-	rx_budget = max(budget / tqp_vector->num_tqps, 1);
+	if (tqp_vector->num_tqps > 1)
+		rx_budget = max(budget / tqp_vector->num_tqps, 1);
 
 	hns3_for_each_ring(ring, tqp_vector->rx_group) {
 		int rx_cleaned = hns3_clean_rx_ring(ring, rx_budget,
-- 
2.7.4

