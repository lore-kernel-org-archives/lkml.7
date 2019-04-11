Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED762C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76ED2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfDKM2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:28:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfDKM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F28F4138148F555C9A4;
        Thu, 11 Apr 2019 20:26:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:26:34 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: minor refactor for hns3_rx_checksum
Date:   Thu, 11 Apr 2019 20:25:24 +0800
Message-ID: <1554985531-1827-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Change the parameters of hns3_rx_checksum to be more specific to
what is used internally, rather than passing in a pointer to the
whole hns3_desc. Reduces duplicate code and bring this function
inline with the approach used in hns3_set_gro_param.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 04eca3a..51e4ada 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2332,16 +2332,11 @@ static void hns3_nic_reuse_page(struct sk_buff *skb, int i,
 }
 
 static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
-			     struct hns3_desc *desc)
+			     u32 l234info, u32 bd_base_info)
 {
 	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
 	int l3_type, l4_type;
-	u32 bd_base_info;
 	int ol4_type;
-	u32 l234info;
-
-	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
-	l234info = le32_to_cpu(desc->rx.l234_info);
 
 	skb->ip_summed = CHECKSUM_NONE;
 
@@ -2753,7 +2748,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	/* This is needed in order to enable forwarding support */
 	hns3_set_gro_param(skb, l234info, bd_base_info);
 
-	hns3_rx_checksum(ring, skb, desc);
+	hns3_rx_checksum(ring, skb, l234info, bd_base_info);
 	*out_skb = skb;
 	hns3_set_rx_skb_rss_type(ring, skb);
 
-- 
2.7.4

