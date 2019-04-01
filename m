Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33131C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BFF21925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138286;
	bh=MAKyT5I3x2YqrjQn1vi6XzIEbBEw6LRsVcQTzLXS+dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sf+1qAV1UCyg1k5rkOlaPCQgOeD8AZJcGJhup1hl904qgBLzKw8z6Khn7e8E/W/Wu
	 TX9RNq05ZtfAZxj6lYM2C05UvLY66oHG8jewCNXhOOgOz3aKDD7I66/kk/2b4SPvi5
	 upeY/IksxEyZKNt4R+nEHI1GObLGDYM/KAN38zuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfDAREp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDAREo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:04:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5913421929;
        Mon,  1 Apr 2019 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138283;
        bh=MAKyT5I3x2YqrjQn1vi6XzIEbBEw6LRsVcQTzLXS+dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qo1Qx1302AF/k+S5KlegpNWkUX3+PwFXZ7RgwGUpMlfRiLHEbOdh55qXthweKf9rv
         fnLvXkHGm7jSszNbEZPfsRuXp41zOPRo7mUAeJv4DKR9K/6NFsYcK2woUbIDoyZ9Bj
         FbvkLTolwHy7JosVWfg7YnbftQnUNnUrF2/OqaWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 022/146] tcp: do not use ipv6 header for ipv4 flow
Date:   Mon,  1 Apr 2019 19:00:34 +0200
Message-Id: <20190401170050.463535439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 89e4130939a20304f4059ab72179da81f5347528 ]

When a dual stack tcp listener accepts an ipv4 flow,
it should not attempt to use an ipv6 header or tcp_v6_iif() helper.

Fixes: 1397ed35f22d ("ipv6: add flowinfo for tcp6 pkt_options for all cases")
Fixes: df3687ffc665 ("ipv6: add the IPV6_FL_F_REFLECT flag to IPV6_FL_A_GET")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/tcp_ipv6.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1112,11 +1112,11 @@ static struct sock *tcp_v6_syn_recv_sock
 		newnp->ipv6_fl_list = NULL;
 		newnp->pktoptions  = NULL;
 		newnp->opt	   = NULL;
-		newnp->mcast_oif   = tcp_v6_iif(skb);
-		newnp->mcast_hops  = ipv6_hdr(skb)->hop_limit;
-		newnp->rcv_flowinfo = ip6_flowinfo(ipv6_hdr(skb));
+		newnp->mcast_oif   = inet_iif(skb);
+		newnp->mcast_hops  = ip_hdr(skb)->ttl;
+		newnp->rcv_flowinfo = 0;
 		if (np->repflow)
-			newnp->flow_label = ip6_flowlabel(ipv6_hdr(skb));
+			newnp->flow_label = 0;
 
 		/*
 		 * No need to charge this sock to the relevant IPv6 refcnt debug socks count


