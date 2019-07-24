Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E003A2238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996806;
	bh=Q1EZqeCQWhCsHZTbAIDBuishbOzwnTWReFcUtB+aeCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRvfmy4EpqRRj2ppd/Mf1rZpyiQtMpCGNhGRHFAjyrn6m9xnI2/55OWcVSzadewxU
	 wgUeUY4wRxpBmkciCqnARxj6PWUNhS0kUJs/YVyBDtCqeMRk4j2OOrXr8Xadtmu5Fe
	 8WsNC7vWF22UtMV6EOliSqKvthYmDt+Y1X5uV88c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfGXTdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388834AbfGXTdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:33:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BF322BEA;
        Wed, 24 Jul 2019 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996798;
        bh=Q1EZqeCQWhCsHZTbAIDBuishbOzwnTWReFcUtB+aeCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfWpeJa4cM1ehjdLoV2hP0LiCyK2Zwq/vDvpoMwhuhfm0TXsLsSS6/U2myQ8liTDK
         l4bWTUwzM4UR9xWxRgG1RL0tp02KnT23rOTcglO606XC6mHEl57hPoyL3IblSzVq95
         j5/dJIp97z0FMrKF4zU2sot8gdvKoNVQaMe42n/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+e5be16aa39ad6e755391@syzkaller.appspotmail.com
Subject: [PATCH 5.2 221/413] bonding: validate ip header before check IPPROTO_IGMP
Date:   Wed, 24 Jul 2019 21:18:32 +0200
Message-Id: <20190724191750.592371357@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9d1bc24b52fb8c5d859f9a47084bf1179470e04c ]

bond_xmit_roundrobin() checks for IGMP packets but it parses
the IP header even before checking skb->protocol.

We should validate the IP header with pskb_may_pull() before
using iph->protocol.

Reported-and-tested-by: syzbot+e5be16aa39ad6e755391@syzkaller.appspotmail.com
Fixes: a2fd940f4cff ("bonding: fix broken multicast with round-robin mode")
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 37 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 799fc38c5c34..b0aab3a0a1bf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3866,8 +3866,8 @@ static netdev_tx_t bond_xmit_roundrobin(struct sk_buff *skb,
 					struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct iphdr *iph = ip_hdr(skb);
 	struct slave *slave;
+	int slave_cnt;
 	u32 slave_id;
 
 	/* Start with the curr_active_slave that joined the bond as the
@@ -3876,23 +3876,32 @@ static netdev_tx_t bond_xmit_roundrobin(struct sk_buff *skb,
 	 * send the join/membership reports.  The curr_active_slave found
 	 * will send all of this type of traffic.
 	 */
-	if (iph->protocol == IPPROTO_IGMP && skb->protocol == htons(ETH_P_IP)) {
-		slave = rcu_dereference(bond->curr_active_slave);
-		if (slave)
-			bond_dev_queue_xmit(bond, skb, slave->dev);
-		else
-			bond_xmit_slave_id(bond, skb, 0);
-	} else {
-		int slave_cnt = READ_ONCE(bond->slave_cnt);
+	if (skb->protocol == htons(ETH_P_IP)) {
+		int noff = skb_network_offset(skb);
+		struct iphdr *iph;
 
-		if (likely(slave_cnt)) {
-			slave_id = bond_rr_gen_slave_id(bond);
-			bond_xmit_slave_id(bond, skb, slave_id % slave_cnt);
-		} else {
-			bond_tx_drop(bond_dev, skb);
+		if (unlikely(!pskb_may_pull(skb, noff + sizeof(*iph))))
+			goto non_igmp;
+
+		iph = ip_hdr(skb);
+		if (iph->protocol == IPPROTO_IGMP) {
+			slave = rcu_dereference(bond->curr_active_slave);
+			if (slave)
+				bond_dev_queue_xmit(bond, skb, slave->dev);
+			else
+				bond_xmit_slave_id(bond, skb, 0);
+			return NETDEV_TX_OK;
 		}
 	}
 
+non_igmp:
+	slave_cnt = READ_ONCE(bond->slave_cnt);
+	if (likely(slave_cnt)) {
+		slave_id = bond_rr_gen_slave_id(bond);
+		bond_xmit_slave_id(bond, skb, slave_id % slave_cnt);
+	} else {
+		bond_tx_drop(bond_dev, skb);
+	}
 	return NETDEV_TX_OK;
 }
 
-- 
2.20.1



