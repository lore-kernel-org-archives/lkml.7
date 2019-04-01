Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6F321924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138794;
	bh=rTrDi0M2vX55Cpy6DIdLkQAqOdmdbXarG7/hx6r+dVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GAvqXsw4diqxzaKtmBwcyxcavVxYrqhQDAwP0r1MJVBD6Ik5xNPE6xIKFkFh+0xC+
	 9/ikSF9XkettgfRi4u3vgPkKylZINoKoRYhtVWpTNuENTIc+7MtubylIQ4y3bYj6oe
	 /d5WhtupgQNKJaWrR9Wy6AlAXIKC6eaypLZxGj8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfDARNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfDARNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C3CE21924;
        Mon,  1 Apr 2019 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138790;
        bh=rTrDi0M2vX55Cpy6DIdLkQAqOdmdbXarG7/hx6r+dVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vhyqrPfrFpLVsrDFhRxaHq5oZ8sitgjYKOvI9UF3u/yozF1qyZmSMo+QQSW7geHoH
         on534qT1TTupzxG0q2II7YL/7r2SbNol80w6U+MTJ9fZIiaVFpM+RmtuwONUNbY047
         vXirBcnVHCrRvgnZ25tBXktDgYtJnJyHGD479Kvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 021/134] tcp: do not use ipv6 header for ipv4 flow
Date:   Mon,  1 Apr 2019 19:00:57 +0200
Message-Id: <20190401170046.548358513@linuxfoundation.org>
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
@@ -1108,11 +1108,11 @@ static struct sock *tcp_v6_syn_recv_sock
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


