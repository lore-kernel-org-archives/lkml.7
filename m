Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E951AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E9D21925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138779;
	bh=eCxzdvmY5hZesSqG5vznTUwdiL6CHGlBzHNUUM3tJBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPB/+rp7OIWTRREeN4UjyKM5Gz0S9/ykAgHRjXsj4Fcp1VVDIAzCHYRNHZSPPgzaT
	 eaGPRScKBfp4X8xVER899DkN0vCwvdHUZuGpVDMZE8tJmdGM0tQrxPGyZPy0QY7zYW
	 w5veHnVn17xysi+A2U02lxvOFLdbBi/phBvBdEZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfDARM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfDARMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A9D20883;
        Mon,  1 Apr 2019 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138772;
        bh=eCxzdvmY5hZesSqG5vznTUwdiL6CHGlBzHNUUM3tJBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azU9seZCP4KohrmBT/hLGyGSSthkLnsqM1HQNr7XJ0YjXrnor7ngxPMUS4dXvY9yK
         DTbWPcTrTvZtAMtyQT+2y7Y+tyD66ezGRmisE0N4ujf2yuk3p29XwPKIUWDwUT65Ii
         wfqFGpiu2AUWhVWxdm9mZmWDLTgxT+QNrQW6Wbzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 017/134] packets: Always register packet sk in the same order
Date:   Mon,  1 Apr 2019 19:00:53 +0200
Message-Id: <20190401170045.968154213@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -710,6 +710,12 @@ static inline void sk_add_node_rcu(struc
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
@@ -3245,7 +3245,7 @@ static int packet_create(struct net *net
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
-	sk_add_node_rcu(sk, &net->packet.sklist);
+	sk_add_node_tail_rcu(sk, &net->packet.sklist);
 	mutex_unlock(&net->packet.sklist_lock);
 
 	preempt_disable();


