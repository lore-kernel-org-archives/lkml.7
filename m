Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E55DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BE7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfCUD2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:28:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfCUD2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:28:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39767AF682FEF9CFFBEA;
        Thu, 21 Mar 2019 11:28:44 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Mar 2019 11:28:38 +0800
From:   l00371289 <linyunsheng@huawei.com>
To:     <davem@davemloft.net>
CC:     <huangdaode@hisilicon.com>, <xuwei5@hisilicon.com>,
        <liguozhu@hisilicon.com>, <Yisen.Zhuang@huawei.com>,
        <john.garry@huawei.com>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: hns3: fix for not calculating tx bd num correctly
Date:   Thu, 21 Mar 2019 11:28:43 +0800
Message-ID: <1553138923-122549-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When there is only one byte in a frag, the current calculation
using "(size + HNS3_MAX_BD_SIZE - 1) >> HNS3_MAX_BD_SIZE_OFFSET"
will return zero, because HNS3_MAX_BD_SIZE is 65535 and
HNS3_MAX_BD_SIZE_OFFSET is 16. So it will cause tx error when
a frag's size is one byte.

This patch fixes it by using DIV_ROUND_UP.

Fixes: 3fe13ed95dd3 ("net: hns3: avoid mult + div op in critical data path")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 13 ++++++-------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  1 -
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 1c1f17e..162cb9a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -22,6 +22,7 @@
 #include "hns3_enet.h"
 
 #define hns3_set_field(origin, shift, val)	((origin) |= ((val) << (shift)))
+#define hns3_tx_bd_count(S)	DIV_ROUND_UP(S, HNS3_MAX_BD_SIZE)
 
 static void hns3_clear_all_ring(struct hnae3_handle *h);
 static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h);
@@ -1079,7 +1080,7 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 
 	desc_cb->length = size;
 
-	frag_buf_num = (size + HNS3_MAX_BD_SIZE - 1) >> HNS3_MAX_BD_SIZE_OFFSET;
+	frag_buf_num = hns3_tx_bd_count(size);
 	sizeoflast = size & HNS3_TX_LAST_SIZE_M;
 	sizeoflast = sizeoflast ? sizeoflast : HNS3_MAX_BD_SIZE;
 
@@ -1124,14 +1125,13 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 	int i;
 
 	size = skb_headlen(skb);
-	buf_num = (size + HNS3_MAX_BD_SIZE - 1) >> HNS3_MAX_BD_SIZE_OFFSET;
+	buf_num = hns3_tx_bd_count(size);
 
 	frag_num = skb_shinfo(skb)->nr_frags;
 	for (i = 0; i < frag_num; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
 		size = skb_frag_size(frag);
-		bdnum_for_frag = (size + HNS3_MAX_BD_SIZE - 1) >>
-				 HNS3_MAX_BD_SIZE_OFFSET;
+		bdnum_for_frag = hns3_tx_bd_count(size);
 		if (unlikely(bdnum_for_frag > HNS3_MAX_BD_PER_FRAG))
 			return -ENOMEM;
 
@@ -1139,8 +1139,7 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 	}
 
 	if (unlikely(buf_num > HNS3_MAX_BD_PER_FRAG)) {
-		buf_num = (skb->len + HNS3_MAX_BD_SIZE - 1) >>
-			  HNS3_MAX_BD_SIZE_OFFSET;
+		buf_num = hns3_tx_bd_count(skb->len);
 		if (ring_space(ring) < buf_num)
 			return -EBUSY;
 		/* manual split the send packet */
@@ -1169,7 +1168,7 @@ static int hns3_nic_maybe_stop_tx(struct sk_buff **out_skb, int *bnum,
 	buf_num = skb_shinfo(skb)->nr_frags + 1;
 
 	if (unlikely(buf_num > HNS3_MAX_BD_PER_FRAG)) {
-		buf_num = (skb->len + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+		buf_num = hns3_tx_bd_count(skb->len);
 		if (ring_space(ring) < buf_num)
 			return -EBUSY;
 		/* manual split the send packet */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 1db0bd4..75669cd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -193,7 +193,6 @@ enum hns3_nic_state {
 #define HNS3_VECTOR_INITED			1
 
 #define HNS3_MAX_BD_SIZE			65535
-#define HNS3_MAX_BD_SIZE_OFFSET		16
 #define HNS3_MAX_BD_PER_FRAG			8
 #define HNS3_MAX_BD_PER_PKT			MAX_SKB_FRAGS
 
-- 
2.8.1

