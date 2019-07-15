Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05542C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBB820896
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202024;
	bh=BPdIgGT0tqYI+OlkuCcMDMThltNWKW+ecBhdrrOI6Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfqax4UpR3WCNaarsVoVbQ0adgqUVWuo51TETr+yMDKK/YJhUjWvSe4NJX8bRq46Y
	 bqKvu44/jmqwi44z9qzwuxLe5PtCxRW6nOBALKrKZRVk9dx+CdHoGvJHR6awN4aoEz
	 4tQJQ1RotiiVlbDcsp/poM5SwtlW3Oz6VQZOGny4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404631AbfGOOrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405138AbfGOOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:46:59 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FD320896;
        Mon, 15 Jul 2019 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563202019;
        bh=BPdIgGT0tqYI+OlkuCcMDMThltNWKW+ecBhdrrOI6Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykwnRmRjRAuFbpi/AD1nobVSAbDCoZEeTDzlNz9ItI7eFnU8ce6zQqjXRol/pNZGe
         wS/pIOoETqms6yLWaN1XgpRqyK+BlOms9JVglAScar2MbiPU6zyCZz9jShAMG5iHer
         p5FtjjomjknmQnl53HkFX658YjorsscJem5CS3Rc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Hancock <hancock@sedsystems.ca>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 23/53] net: axienet: Fix race condition causing TX hang
Date:   Mon, 15 Jul 2019 10:45:05 -0400
Message-Id: <20190715144535.11636-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715144535.11636-1-sashal@kernel.org>
References: <20190715144535.11636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Hancock <hancock@sedsystems.ca>

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

