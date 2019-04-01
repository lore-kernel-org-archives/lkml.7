Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9FA20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139584;
	bh=3gKjDylfmcQ0YsMisNHdLWUoXVAzcB1SICFQBH2owy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8+CFcnIBsrlfHqtD06oLFaLmrVQ5KHDemI622eRkv8zb0m1RzRIMcboyW745BTJ2
	 U8rJA2fzqZ7LXAU6R4yYMVpDl6nw+CHLBgdIG3xeSrAkSvKxtV2IrQru0ikj3mKvdB
	 KqMwumhBPpeBKuaZKN/JtmDgVNCWSLi1rstGhZN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfDAR0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732155AbfDAR0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E4B20856;
        Mon,  1 Apr 2019 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139579;
        bh=3gKjDylfmcQ0YsMisNHdLWUoXVAzcB1SICFQBH2owy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wur32Qz+VF/7jo3trI5xWnUxIKdZu7lsSK7h99Ii2nOpG6j4wsB6FCUbYcwDZiFKf
         Fcvre0kkoY5GZra0cuqy04cKh9Gt4V1xzqtRvkTawRRsJg7JJQoCrO08u+lNtINiqF
         M3WPCFZPouPll9xNrH6Yw8ZwAv+A6NVPUjVkRAvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 10/56] packets: Always register packet sk in the same order
Date:   Mon,  1 Apr 2019 19:02:26 +0200
Message-Id: <20190401170104.403669652@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit a4dc6a49156b1f8d6e17251ffda17c9e6a5db78a ]

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

Note that this changes the order in which sockets are listed in /proc and
with sock_diag.

Fixes: dc99f600698d ("packet: Add fanout support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sock.h     |    6 ++++++
 net/packet/af_packet.c |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -650,6 +650,12 @@ static inline void sk_add_node_rcu(struc
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
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3278,7 +3278,7 @@ static int packet_create(struct net *net
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
-	sk_add_node_rcu(sk, &net->packet.sklist);
+	sk_add_node_tail_rcu(sk, &net->packet.sklist);
 	mutex_unlock(&net->packet.sklist_lock);
 
 	preempt_disable();


