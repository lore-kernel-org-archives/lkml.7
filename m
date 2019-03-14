Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3020854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCNMZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:25:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41667 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfCNMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:25:23 -0400
X-Originating-IP: 90.88.22.102
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 483C6E0006;
        Thu, 14 Mar 2019 12:25:20 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [RFC PATCH net] packets: Always register packet sk in the same order
Date:   Thu, 14 Mar 2019 13:24:50 +0100
Message-Id: <20190314122450.5242-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using fanouts with AF_PACKET, the demux functions such as
fanout_demux_cpu will return an index in the fanout socket array, which
corresponds to the selected socket.

The ordering of this array depends on the order the sockets were added
to a given fanout group, so for FANOUT_CPU this means sockets are bound
to cpus in the order they are configured, which is OK.

However, when stopping then restarting the interface these sockets are
bound to, the sockets are reassigned to the fanout group in the reverse
order, due to the fact that they were inserted at the head of the
interface's AF_PACKET socket list.

This means that traffic that was directed to the first socket in the
fanout group is now directed to the last one after an interface restart.

In the case of FANOUT_CPU, traffic from CPU0 will be directed to the
socket that used to receive traffic from the last CPU after an interface
restart.

This commit introduces a helper to add a socket at the tail of a list,
then uses it to register AF_PACKET sockets.

Fixes: 808f5114a920 ("packet: convert socket list to RCU (v3)")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Hi All,

I stumbled upon this issue when using FANOUT_CPU and came-up with this
patch, but I'm not sure that (a) this is really a bug (although this
behaviour is at least misleading) and (b) this is the correct fix,
so any input on this is welcome.

Also David, I'm not sure about the Fixes tag, from what I see, this
behaviour has always been there.

Thanks,

Maxime

 include/net/sock.h     | 6 ++++++
 net/packet/af_packet.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 328cb7cb7b0b..8de5ee258b93 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -710,6 +710,12 @@ static inline void sk_add_node_rcu(struct sock *sk, struct hlist_head *list)
 		hlist_add_head_rcu(&sk->sk_node, list);
 }
 
+static inline void sk_add_node_tail_rcu(struct sock *sk, struct hlist_head *list)
+{
+	sock_hold(sk);
+	hlist_add_tail_rcu(&sk->sk_node, list);
+}
+
 static inline void __sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
 {
 	hlist_nulls_add_head_rcu(&sk->sk_nulls_node, list);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8376bc1c1508..8754d7c93b84 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3243,7 +3243,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
-	sk_add_node_rcu(sk, &net->packet.sklist);
+	sk_add_node_tail_rcu(sk, &net->packet.sklist);
 	mutex_unlock(&net->packet.sklist_lock);
 
 	preempt_disable();
-- 
2.20.1

