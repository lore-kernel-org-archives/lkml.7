Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4CC49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 01:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8113121928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 01:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfIKBTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 21:19:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfIKBTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 21:19:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A34B2D290D4AACE16FC9;
        Wed, 11 Sep 2019 09:18:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Sep 2019 09:18:52 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <tsbogend@alpha.franken.de>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH v2 net] net: sonic: replace dev_kfree_skb in sonic_send_packet
Date:   Wed, 11 Sep 2019 09:36:23 +0800
Message-ID: <20190911013623.36897-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <a48a6690-eeb4-91d2-bed8-439d14b63e2f@cogentembedded.com>
References: <a48a6690-eeb4-91d2-bed8-439d14b63e2f@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sonic_send_packet will be processed in irq or non-irq 
context, so it would better use dev_kfree_skb_any
instead of dev_kfree_skb.

Fixes: d9fb9f384292 ("*sonic/natsemi/ns83829: Move the National Semi-conductor drivers")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v2: change 'none irq' to 'non-irq'.
 drivers/net/ethernet/natsemi/sonic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 18fd62fbfb64..b339125b2f09 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -233,7 +233,7 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 	laddr = dma_map_single(lp->device, skb->data, length, DMA_TO_DEVICE);
 	if (!laddr) {
 		pr_err_ratelimited("%s: failed to map tx DMA buffer.\n", dev->name);
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 
-- 
2.20.1

