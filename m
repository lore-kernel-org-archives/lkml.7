Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3349C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C79206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367272;
	bh=QBcKwjpbcgEy+/01KitUT60i9hru4saSyLEoRhsyRc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H7P+rxUojiwHIVsQnV/RPkKUJRrZesp0c4wW2wK1FoSLJEI6tsHbGxlGNnLfNtWC2
	 xwPKvfTjIAXRHKA9XOIXUgxL98aLlpWrga0ZEWShqb1FRLtI3bfkPLIv8E9L/oOK0o
	 Pn7SRA+oHro+Ckyj/bRsc5QxjdLnnqHhTIgGQur0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfB1PVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388588AbfB1POB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6AD20C01;
        Thu, 28 Feb 2019 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366840;
        bh=QBcKwjpbcgEy+/01KitUT60i9hru4saSyLEoRhsyRc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xigw46mkkn8/B4ZjxkdN7+H9a6Ds16DRoDXiiCkg7M/wKZ8Z9qXfcLHMtI2fooxVL
         Bn0lvat/MYPuju9HjuWo/qzZXiJAeHD8TTZN4qpT44kDnO/KUKQRQir4F5qZUWdYGM
         oGezFBkbKSQyii5dfNZbD4ngx6/9m8ndtGX6EI6c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/36] net: stmmac: Send TSO packets always from Queue 0
Date:   Thu, 28 Feb 2019 10:13:14 -0500
Message-Id: <20190228151337.12176-13-sashal@kernel.org>
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

[ Upstream commit c5acdbee22a1b200dde07effd26fd1f649e9ab8a ]

The number of TSO enabled channels in HW can be different than the
number of total channels. There is no way to determined, at runtime, the
number of TSO capable channels and its safe to assume that if TSO is
enabled then at least channel 0 will be TSO capable.

Lets always send TSO packets from Queue 0.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a901feaad4e15..bed71e295d9ff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3019,8 +3019,17 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
-		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
+		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+			/*
+			 * There is no way to determine the number of TSO
+			 * capable Queues. Let's use always the Queue 0
+			 * because if TSO is supported then at least this
+			 * one will be capable.
+			 */
+			skb_set_queue_mapping(skb, 0);
+
 			return stmmac_tso_xmit(skb, dev);
+		}
 	}
 
 	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
-- 
2.19.1

