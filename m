Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4F120684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="c0UgjJLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDZHlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:41:13 -0400
Received: from first.geanix.com ([116.203.34.67]:59666 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfDZHkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:09 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 71E0C308E68;
        Fri, 26 Apr 2019 07:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263919; bh=+lrDbuO8ARbZogAI4/reIhkg2z59QWgVZlRkANDwfwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c0UgjJLQVpQq2rMqWDrgoopvKPkZJ9WGeb9ZvC+cU8mYVRdYZhEkYZSn3V1HHKFq+
         ROVxEJuFLSdfQLmYkXWc5TcaUkkodPUGPizhr8H+S1Is1MYGCIabSmeFeTdX1dCqYb
         sv90pRAwwgJDMgQPFf1I1Hb3mrmLM40gNhYSmQGA1Yp3cuiWmGsO6n3RjbO+FbUN+n
         v/37uf79NwWtCNwndmqIWAyO3LM5nRdYb0Tgd3RdMOVOBr6bizSIbQTKSHAd4ZaUgI
         oBNoyb94RQ56C2Vna28g2AJg1zvV4qb0spuVkQCyB5U0B2Oal98fYLvfuNcO/42W7t
         /hcJAgIZyALpQ==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] net: ll_temac: Fix iommu/swiotlb leak
Date:   Fri, 26 Apr 2019 09:32:27 +0200
Message-Id: <20190426073231.4008-9-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmap the actual buffer length, not the amount of data received.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 309f149..56d8077 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -821,7 +821,7 @@ static void ll_temac_recv(struct net_device *ndev)
 		length = be32_to_cpu(cur_p->app4) & 0x3FFF;
 
 		dma_unmap_single(ndev->dev.parent, be32_to_cpu(cur_p->phys),
-				 length, DMA_FROM_DEVICE);
+				 XTE_MAX_JUMBO_FRAME_SIZE, DMA_FROM_DEVICE);
 
 		skb_put(skb, length);
 		skb->protocol = eth_type_trans(skb, ndev);
-- 
2.4.11

