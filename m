Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62CC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350AA205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596157;
	bh=f3eQH/L17R4itt+uGmaxmvAu8eJnLJWmIENYKmjLnFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8P+ywGT3Juyk7unOfpUrG8HXRD2ffTrelC/E5cq/7nBnvtMV0fQX2UmqNqgIq+Bn
	 eIMmD+4SKtJqGLVTdvI0NW2Kg6CY49ndXp5VN3rneo8iaF3pJ/F/WcNfagf7QDRRBU
	 KdcLpRemt5xdRlbJbwb2WNQQOMizN2dHs2bM+gTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfF0Amg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbfF0Amb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:42:31 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD8021871;
        Thu, 27 Jun 2019 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596151;
        bh=f3eQH/L17R4itt+uGmaxmvAu8eJnLJWmIENYKmjLnFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yk5oB3YT1wlUbUUn5ulZWDCOlU2ScR2qE6PZMyZk1x5blDJyyosc0oyJMcY1VK3WR
         yMaFnY5Vlun69uPgr/siIbHvoYBS3z5Vaqv9EKoFd/g8mwNAgufVB31HtTmX/Lmur8
         TZ8md+y3Aszr5i79p2MyMz7juiyujzmcACLr07SM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/21] ip6_tunnel: allow not to count pkts on tstats by passing dev as NULL
Date:   Wed, 26 Jun 2019 20:41:20 -0400
Message-Id: <20190627004122.21671-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004122.21671-1-sashal@kernel.org>
References: <20190627004122.21671-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6f6a8622057c92408930c31698394fae1557b188 ]

A similar fix to Patch "ip_tunnel: allow not to count pkts on tstats by
setting skb's dev to NULL" is also needed by ip6_tunnel.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip6_tunnel.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 1b1cf33cbfb0..2b6abd046087 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -149,9 +149,12 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 	pkt_len = skb->len - skb_inner_network_offset(skb);
 	err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
-	if (unlikely(net_xmit_eval(err)))
-		pkt_len = -1;
-	iptunnel_xmit_stats(dev, pkt_len);
+
+	if (dev) {
+		if (unlikely(net_xmit_eval(err)))
+			pkt_len = -1;
+		iptunnel_xmit_stats(dev, pkt_len);
+	}
 }
 #endif
 #endif
-- 
2.20.1

