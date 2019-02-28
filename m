Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DA420C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366847;
	bh=LvNXt+y9U4EHTHvmUBBk2je8AVU4ijZ5HMPDhHll3RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=emHFQG4WPZJagfpfjTQCdJmKaRAnv7CSHJugmaPOndBHEMcEY3QH1goSDMqAIBQM8
	 HPAbo6MG4YNTWruw8IQzbnIc6PmgBuJBJb7rwTlv1shP07vg2zT13EAFLRMRJHzp3r
	 0exHStEv0CM1f0xoxFDD4gQfLHBT5fpXPqrjGbA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfB1POG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388595AbfB1POC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28259218EA;
        Thu, 28 Feb 2019 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366842;
        bh=LvNXt+y9U4EHTHvmUBBk2je8AVU4ijZ5HMPDhHll3RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Alc35aXPHi7y1mLqk8dJYd2g4fhJyiWPpf7zFAFrkWmmkyK6oj0BznI8F7WeA7tTf
         1fcTs2Ana8I4LnZB+kxdX3F+qvUaqn6x5HOZafQo7cXlzO0sLwrVcJZFn89e9mNJao
         TXT3LER2gEPACXVAEzMEeno+1yoTVf0IjoFHbBAw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/36] net: stmmac: Disable EEE mode earlier in XMIT callback
Date:   Thu, 28 Feb 2019 10:13:15 -0500
Message-Id: <20190228151337.12176-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
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
index bed71e295d9ff..cd6d0045c39f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3017,6 +3017,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_q = &priv->tx_queue[queue];
 
+	if (priv->tx_path_in_lpi_mode)
+		stmmac_disable_eee_mode(priv);
+
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
 		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
@@ -3044,9 +3047,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
-	if (priv->tx_path_in_lpi_mode)
-		stmmac_disable_eee_mode(priv);
-
 	entry = tx_q->cur_tx;
 	first_entry = entry;
 
-- 
2.19.1

