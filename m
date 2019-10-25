Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EBBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C03222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfJYSIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:08:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46884 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731495AbfJYSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:05:44 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iO3xx-0008PC-1x; Fri, 25 Oct 2019 19:05:37 +0100
Received: from ben by deadeye with local (Exim 4.92.2)
        (envelope-from <ben@decadent.org.uk>)
        id 1iO3xw-0001kJ-8Y; Fri, 25 Oct 2019 19:05:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jay Vosburgh" <j.vosburgh@gmail.com>,
        "Andy Gospodarek" <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Cong Wang" <xiyou.wangcong@gmail.com>,
        "Veaceslav Falico" <vfalico@gmail.com>
Date:   Fri, 25 Oct 2019 19:03:36 +0100
Message-ID: <lsq.1572026582.768948953@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 35/47] bonding: validate ip header before check
 IPPROTO_IGMP
In-Reply-To: <lsq.1572026581.992411028@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.76-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 9d1bc24b52fb8c5d859f9a47084bf1179470e04c upstream.

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
[bwh: Backported to 3.16:
 - Keep using ACCESS_ONCE(), dev_kfree_skb_any(), …_can_tx()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/bonding/bond_main.c | 37 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3700,8 +3700,8 @@ static u32 bond_rr_gen_slave_id(struct b
 static int bond_xmit_roundrobin(struct sk_buff *skb, struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct iphdr *iph = ip_hdr(skb);
 	struct slave *slave;
+	int slave_cnt;
 	u32 slave_id;
 
 	/* Start with the curr_active_slave that joined the bond as the
@@ -3710,23 +3710,32 @@ static int bond_xmit_roundrobin(struct s
 	 * send the join/membership reports.  The curr_active_slave found
 	 * will send all of this type of traffic.
 	 */
-	if (iph->protocol == IPPROTO_IGMP && skb->protocol == htons(ETH_P_IP)) {
-		slave = rcu_dereference(bond->curr_active_slave);
-		if (slave && bond_slave_can_tx(slave))
-			bond_dev_queue_xmit(bond, skb, slave->dev);
-		else
-			bond_xmit_slave_id(bond, skb, 0);
-	} else {
-		int slave_cnt = ACCESS_ONCE(bond->slave_cnt);
+	if (skb->protocol == htons(ETH_P_IP)) {
+		int noff = skb_network_offset(skb);
+		struct iphdr *iph;
+
+		if (unlikely(!pskb_may_pull(skb, noff + sizeof(*iph))))
+			goto non_igmp;
 
-		if (likely(slave_cnt)) {
-			slave_id = bond_rr_gen_slave_id(bond);
-			bond_xmit_slave_id(bond, skb, slave_id % slave_cnt);
-		} else {
-			dev_kfree_skb_any(skb);
+		iph = ip_hdr(skb);
+		if (iph->protocol == IPPROTO_IGMP) {
+			slave = rcu_dereference(bond->curr_active_slave);
+			if (slave && bond_slave_can_tx(slave))
+				bond_dev_queue_xmit(bond, skb, slave->dev);
+			else
+				bond_xmit_slave_id(bond, skb, 0);
+			return NETDEV_TX_OK;
 		}
 	}
 
+non_igmp:
+	slave_cnt = ACCESS_ONCE(bond->slave_cnt);
+	if (likely(slave_cnt)) {
+		slave_id = bond_rr_gen_slave_id(bond);
+		bond_xmit_slave_id(bond, skb, slave_id % slave_cnt);
+	} else {
+		dev_kfree_skb_any(skb);
+	}
 	return NETDEV_TX_OK;
 }
 

