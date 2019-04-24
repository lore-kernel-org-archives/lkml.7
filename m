Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA5C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430B92175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfDXLGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:06:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbfDXLGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:06:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 30EE86F8BDE6D0F8EBA1;
        Wed, 24 Apr 2019 19:06:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 19:06:40 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 01/12] net: hns3: fix data race between ring->next_to_clean
Date:   Wed, 24 Apr 2019 19:05:20 +0800
Message-ID: <1556103931-64031-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
References: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

hns3_clean_tx_ring calls hns3_nic_reclaim_one_desc to clean
buffers and set ring->next_to_clean, then hns3_nic_net_xmit
reuses the cleaned buffers. But there are no memory barriers
when buffers gets recycled, so the recycled buffers can be
corrupted.

This patch uses smp_store_release to update ring->next_to_clean
and smp_load_acquire to read ring->next_to_clean to properly
hand off buffers from hns3_clean_tx_ring to hns3_nic_net_xmit.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 14 +++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  7 +++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 176d4b9..9fdc87e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2214,14 +2214,22 @@ static void hns3_reuse_buffer(struct hns3_enet_ring *ring, int i)
 static void hns3_nic_reclaim_one_desc(struct hns3_enet_ring *ring, int *bytes,
 				      int *pkts)
 {
-	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_clean];
+	int ntc = ring->next_to_clean;
+	struct hns3_desc_cb *desc_cb;
 
+	desc_cb = &ring->desc_cb[ntc];
 	(*pkts) += (desc_cb->type == DESC_TYPE_SKB);
 	(*bytes) += desc_cb->length;
 	/* desc_cb will be cleaned, after hnae3_free_buffer_detach*/
-	hns3_free_buffer_detach(ring, ring->next_to_clean);
+	hns3_free_buffer_detach(ring, ntc);
 
-	ring_ptr_move_fw(ring, next_to_clean);
+	if (++ntc == ring->desc_num)
+		ntc = 0;
+
+	/* This smp_store_release() pairs with smp_load_acquire() in
+	 * ring_space called by hns3_nic_net_xmit.
+	 */
+	smp_store_release(&ring->next_to_clean, ntc);
 }
 
 static int is_valid_clean_head(struct hns3_enet_ring *ring, int h)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index cec56a5..2b4f5ea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -581,8 +581,11 @@ union l4_hdr_info {
 
 static inline int ring_space(struct hns3_enet_ring *ring)
 {
-	int begin = ring->next_to_clean;
-	int end = ring->next_to_use;
+	/* This smp_load_acquire() pairs with smp_store_release() in
+	 * hns3_nic_reclaim_one_desc called by hns3_clean_tx_ring.
+	 */
+	int begin = smp_load_acquire(&ring->next_to_clean);
+	int end = READ_ONCE(ring->next_to_use);
 
 	return ((end >= begin) ? (ring->desc_num - end + begin) :
 			(begin - end)) - 1;
-- 
2.7.4

