Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC00C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC16218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366736;
	bh=mfNMajR4WlVtApmmNHGMrLuKWmu4u+3ziuBltPe9hxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUegkZAAR9Kzfc3lEoQLbIqjFpnTDprgr/RjuDHDH2wnrifBvRUVA4FUu5tfD8OK2
	 +azJcfpgLmWYsexh6P3vL6shKW68dyfl1hdxTut8Eulm98Qtqq59YFvqXomggYZ6z9
	 HMDoBWpf8Klpyqv33m55gpm3uYFymaYuh83Ynkpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfB1PMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388159AbfB1PMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:12:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51841214D8;
        Thu, 28 Feb 2019 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366727;
        bh=mfNMajR4WlVtApmmNHGMrLuKWmu4u+3ziuBltPe9hxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1u63yYvwQ02bHytWFe+0pAn5+4bum5ltyOM9Haw1cW0kdxB4VQz5j60qH/pCqjF+
         L/PAx2T+9uWgBnZixjdnK0jh5GQ7ZUCBUHkj49LUZW89JQ6zL84uQdkoGNTyDY91mb
         Ef8LilISnHFx2YeyBbhsrZqNQ9Rb9NTMcVZERZ4Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/64] net: stmmac: Disable EEE mode earlier in XMIT callback
Date:   Thu, 28 Feb 2019 10:10:32 -0500
Message-Id: <20190228151105.11277-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>

[ Upstream commit e2cd682deb231ba6f80524bb84e57e7138261149 ]

In stmmac xmit callback we use a different flow for TSO packets but TSO
xmit callback is not disabling the EEE mode.

Fix this by disabling earlier the EEE mode, i.e. before calling the TSO
xmit callback.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 57c56e2957058..43ab9e905bed9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3028,6 +3028,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_q = &priv->tx_queue[queue];
 
+	if (priv->tx_path_in_lpi_mode)
+		stmmac_disable_eee_mode(priv);
+
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
 		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
@@ -3055,9 +3058,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
-	if (priv->tx_path_in_lpi_mode)
-		stmmac_disable_eee_mode(priv);
-
 	entry = tx_q->cur_tx;
 	first_entry = entry;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
-- 
2.19.1

