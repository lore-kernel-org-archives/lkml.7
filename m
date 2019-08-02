Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1175F2182B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738241;
	bh=rMJZlTYIxbx1g3vg0UrpKxb8ys34X615dqBgUcL9hmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xRqw5ToFqyil0VMDYomnvWTr8o30Vo4BbzO4i/e2PZFkKny0VRaEQXktmhLisCjY7
	 5GK6FkwFwHlGUpOVUrG75QT2dlUTCx35Ht200YdR0zLvhEg1582p6VEHwY1Ynxq8mH
	 mgF6ZZJ9RHmsqT6DEx02MsVosaXsfkDzuI3V3OPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbfHBJaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389643AbfHBJae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:30:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358AE2182B;
        Fri,  2 Aug 2019 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738233;
        bh=rMJZlTYIxbx1g3vg0UrpKxb8ys34X615dqBgUcL9hmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVnF880n7w85CKSP9+2MhD2ECJSHR0J1gi3KCFH/DeHVFNVVvPZEbXdupkctgFnrQ
         BtkMpXhjFwTjCDX74B3C2gcdT7BJhvFwFKadVaznQPIMSEZqjxHmJQJaMwIGzRGIZN
         RhKmKti8eBP0Xu+Ztdby8Xe3AAdMfKhFlIw5a3lY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Hancock <hancock@sedsystems.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 024/158] net: axienet: Fix race condition causing TX hang
Date:   Fri,  2 Aug 2019 11:27:25 +0200
Message-Id: <20190802092208.478340339@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7de44285c1f69ccfbe8be1d6a16fcd956681fee6 ]

It is possible that the interrupt handler fires and frees up space in
the TX ring in between checking for sufficient TX ring space and
stopping the TX queue in axienet_start_xmit. If this happens, the
queue wake from the interrupt handler will occur before the queue is
stopped, causing a lost wakeup and the adapter's transmit hanging.

To avoid this, after stopping the queue, check again whether there is
sufficient space in the TX ring. If so, wake up the queue again.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 58ba579793f8..f1e969128a4e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -613,6 +613,10 @@ static void axienet_start_xmit_done(struct net_device *ndev)
 
 	ndev->stats.tx_packets += packets;
 	ndev->stats.tx_bytes += size;
+
+	/* Matches barrier in axienet_start_xmit */
+	smp_mb();
+
 	netif_wake_queue(ndev);
 }
 
@@ -667,9 +671,19 @@ static int axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
 
 	if (axienet_check_tx_bd_space(lp, num_frag)) {
-		if (!netif_queue_stopped(ndev))
-			netif_stop_queue(ndev);
-		return NETDEV_TX_BUSY;
+		if (netif_queue_stopped(ndev))
+			return NETDEV_TX_BUSY;
+
+		netif_stop_queue(ndev);
+
+		/* Matches barrier in axienet_start_xmit_done */
+		smp_mb();
+
+		/* Space might have just been freed - check again */
+		if (axienet_check_tx_bd_space(lp, num_frag))
+			return NETDEV_TX_BUSY;
+
+		netif_wake_queue(ndev);
 	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-- 
2.20.1



