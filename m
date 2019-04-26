Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0070FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC37020684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="P2LYY8+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfDZHkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:40:10 -0400
Received: from first.geanix.com ([116.203.34.67]:59614 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfDZHkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:08 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 03:40:06 EDT
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 17760308E5F;
        Fri, 26 Apr 2019 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263901; bh=92DviJikiys5ttnHqZkEfuer/TXINk4Ag4JsBdI35Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P2LYY8+DvgxnZNz6WXeMfA2frx9UXOGt/zMQNdaNN1GxXhmyhVtzdg7p71KsEtfPE
         vKl5A5z1YnKbfdoX03Yy3HoAWJK6VqeOmb3XXePzPqOJeLqbXzlESMi2pXkBzSgK++
         SYz5j5rwMEx8Da4jN+PkCGxHXdoGeSsVa1jroj4W+0QGb1nQrX8qeJ4ikxekoJOHBJ
         k/vS5uvODOk7HhuoR2oc1dNoCxIJ23i5G6VPnGX3SpLo0m22cI7QHNgplKFISjwYLr
         QdlB/zaErLEg9x/5Q91YjzmTJaNdiZV0/EBgodhgWzmUQOdtN5Rw2XVQI67Z/OIoO3
         M6t19cppNvpiw==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] net: ll_temac: Fix support for 64-bit platforms
Date:   Fri, 26 Apr 2019 09:32:22 +0200
Message-Id: <20190426073231.4008-4-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of buffer descriptor APP4 field (32-bit) for storing skb pointer
obviously does not work on 64-bit platforms.
As APP3 is also unused, we can use that to store the other half of 64-bit
pointer values.

Contrary to what is hinted at in commit message of commit 15bfe05c8d63
("net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit")
there are no other pointers stored in cdmac_bd.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/Kconfig         |  1 -
 drivers/net/ethernet/xilinx/ll_temac_main.c | 35 ++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index da4ec57..6d68c8a 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -34,7 +34,6 @@ config XILINX_AXI_EMAC
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
 	depends on (PPC || MICROBLAZE)
-	depends on !64BIT || BROKEN
 	select PHYLIB
 	---help---
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 4594fe3..a365bfd 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -619,11 +619,39 @@ static void temac_adjust_link(struct net_device *ndev)
 	mutex_unlock(&lp->indirect_mutex);
 }
 
+#ifdef CONFIG_64BIT
+
+void ptr_to_txbd(void *p, struct cdmac_bd *bd)
+{
+	bd->app3 = (u32)(((u64)p) >> 32);
+	bd->app4 = (u32)((u64)p & 0xFFFFFFFF);
+}
+
+void *ptr_from_txbd(struct cdmac_bd *bd)
+{
+	return (void *)(((u64)(bd->app3) << 32) | bd->app4);
+}
+
+#else
+
+void ptr_to_txbd(void *p, struct cmdac_bd *bd)
+{
+	bd->app4 = (u32)p;
+}
+
+void *ptr_from_txbd(struct cdmac_bd *bd)
+{
+	return (void *)(bd->app4);
+}
+
+#endif
+
 static void temac_start_xmit_done(struct net_device *ndev)
 {
 	struct temac_local *lp = netdev_priv(ndev);
 	struct cdmac_bd *cur_p;
 	unsigned int stat = 0;
+	struct sk_buff *skb;
 
 	cur_p = &lp->tx_bd_v[lp->tx_bd_ci];
 	stat = cur_p->app0;
@@ -631,8 +659,9 @@ static void temac_start_xmit_done(struct net_device *ndev)
 	while (stat & STS_CTRL_APP0_CMPLT) {
 		dma_unmap_single(ndev->dev.parent, cur_p->phys, cur_p->len,
 				 DMA_TO_DEVICE);
-		if (cur_p->app4)
-			dev_consume_skb_irq((struct sk_buff *)cur_p->app4);
+		skb = (struct sk_buff *)ptr_from_txbd(cur_p);
+		if (skb)
+			dev_consume_skb_irq(skb);
 		cur_p->app0 = 0;
 		cur_p->app1 = 0;
 		cur_p->app2 = 0;
@@ -711,7 +740,7 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cur_p->len = skb_headlen(skb);
 	cur_p->phys = dma_map_single(ndev->dev.parent, skb->data,
 				     skb_headlen(skb), DMA_TO_DEVICE);
-	cur_p->app4 = (unsigned long)skb;
+	ptr_to_txbd((void *)skb, cur_p);
 
 	for (ii = 0; ii < num_frag; ii++) {
 		lp->tx_bd_tail++;
-- 
2.4.11

