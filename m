Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBCCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFE72171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412281;
	bh=K5M615LjojqEM3Yc7x2dx8MJgoDx0a0ELlFOxcvKjas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZCfAcKjD7+ZRSENTgVI3yJ6uCT+YH/7xb8NfSmXoYi7F9V6KR5+GOXmNNc3nxlvWX
	 gI3ch/8t6sWHaQ3PqVNXgYHNlmYRXvboYbcfXJHpBjBNXclbLvXsVNtJAVQCJgAAba
	 CFUwp5UyGssYIg/+p0nskLSeNgI/NjGxCXbba/MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfCLRhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbfCLRQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC122186A;
        Tue, 12 Mar 2019 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411009;
        bh=K5M615LjojqEM3Yc7x2dx8MJgoDx0a0ELlFOxcvKjas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3xLtxVJlcb6MRQv4nN2uzFa5Gb8LEUpctunfeIC01N6C3X+j9RA3774CBbuNKfVL
         J3QwVxmA6v3KIuvKf01obx4JlYE2iMMDk5/GRzscAk3dhQAGO+qN8nuchfc+vF17kO
         oFu06Mu5FunVqQ957vyUD5KrYE7Y14Xw3KVpMvhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 097/135] net: stmmac: Send TSO packets always from Queue 0
Date:   Tue, 12 Mar 2019 10:09:04 -0700
Message-Id: <20190312170350.133400731@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0e66a5082140..b1454c63e675 100644
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



