Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A37E21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139234;
	bh=MkmTcrxERynSMgkjrxgoeVpiJZHMIVGgKqg8HH9HO/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfGKv20IbTKvYKTWahJ9Ykhusg5tVHXTsfdAE4YMDpXHAxtP3T2yTTX4hy9u7p/ti
	 yiOizOKxZ+jAcm3Bgoa9mQGIh5sg6Rc7KWFnU3fhileuasz62Ri38XspXehVgnVTHE
	 wZV9jktewsvcqGKGYUfDb4JFGLH2+4+lL5aQewZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfDARUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbfDARU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:20:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961D1206DD;
        Mon,  1 Apr 2019 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139227;
        bh=MkmTcrxERynSMgkjrxgoeVpiJZHMIVGgKqg8HH9HO/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTQjZjoNz/6TY5WczU2gByLTAgbC6qx1J5evlKpYrxXHDXBn7yGJuZHkWosjys5zs
         X0BKhWw6veXe7dV+wK83ELJkhdne/y74Dej1qdYDimq2BhwD5m1iDA6+BtYyqGvyh+
         /7AKP6KXxMWCN7omx2lyB07s6UT3jq+A0Lm0WI/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 015/107] tcp: do not use ipv6 header for ipv4 flow
Date:   Mon,  1 Apr 2019 19:01:30 +0200
Message-Id: <20190401170046.906934940@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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
@@ -1083,11 +1083,11 @@ static struct sock *tcp_v6_syn_recv_sock
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


