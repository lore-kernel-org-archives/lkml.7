Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03233C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CC1214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413747;
	bh=tBycXqLkwO9DOmaC5zIjZFWaWTBJ/otXu1NK0ToNdEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxCNP8rKKq6Cf+ErGUKy1LV8Q5Gdg6zgPpIHG3QbeE/kpZA/oTbqvDRImqPHN2w8q
	 2dDOyiyemrc0nuxK/r+DcEKA11fP1uvgOgGgDiCFy+7tmCZPkfrTUXJuVBGjwZIaVd
	 LmPb7Dp0BMRrA1UaP6iv5wxnt6TKX1DjaR0S3oRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfCLSCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfCLRNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:06 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B422087C;
        Tue, 12 Mar 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410785;
        bh=tBycXqLkwO9DOmaC5zIjZFWaWTBJ/otXu1NK0ToNdEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOZOW2JWNKp5ImD3tMKRvDChA2bhfEXMSLCDeVIQxBu+nLMd5Ff6zdcD0L093f0n+
         hwkaAIxjeLN3UDVU0xqcd4LIsYIhfdc9wahxjnHRF4AZV5FCT3yOZGZji5uvYK37VJ
         cTjDyoMQIQnlCqgAL0nqyKMaKU3+OIEsLU2hft0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 106/171] net: stmmac: Disable EEE mode earlier in XMIT callback
Date:   Tue, 12 Mar 2019 10:08:06 -0700
Message-Id: <20190312170357.158599295@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f76f6ae3fa87..9340526d2a9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3031,6 +3031,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_q = &priv->tx_queue[queue];
 
+	if (priv->tx_path_in_lpi_mode)
+		stmmac_disable_eee_mode(priv);
+
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
 		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
@@ -3058,9 +3061,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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



