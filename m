Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB64208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140048;
	bh=WDOuuZncKiVVc+A8w0IivT8plyZp/lKOJspiED1lhE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dH25sH7av1N7KqgglsWw3fi5w+CiOchWPmHNFK5w+fi9yYEyxINu4rR9TD7pHItvg
	 mqO8yDm+rXKJFbxzNW7yXZFxTmqDC7iX6BaO5i97HJxoPKnH2pQCVXTRv6xpLYix7T
	 Aj+1BT0mYxoUiO84OdETt4CBdGfroUT38HRxCC38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbfDAReH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733061AbfDAReD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93D220856;
        Mon,  1 Apr 2019 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140043;
        bh=WDOuuZncKiVVc+A8w0IivT8plyZp/lKOJspiED1lhE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksxdQUSE3s0FG2b5tX0UeNIz0RkFrVvejNA6KhhLlVLSxmoLkxEHrc+QyQmiPctOW
         jFNj+CI2IzEICOLIxGtbcUJNT5sZe6e8Bi2iQGbKlVlhKCnepDj8h0yjAlLa2p0G5S
         jKbE/2h29vf49fGBFeRWM6a6uGgBD4qstY74HDLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 090/131] dccp: do not use ipv6 header for ipv4 flow
Date:   Mon,  1 Apr 2019 19:02:40 +0200
Message-Id: <20190401170059.523492015@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e0aa67709f89d08c8d8e5bdd9e0b649df61d0090 ]

When a dual stack dccp listener accepts an ipv4 flow,
it should not attempt to use an ipv6 header or
inet6_iif() helper.

Fixes: 3df80d9320bc ("[DCCP]: Introduce DCCPv6")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ipv6.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -427,8 +427,8 @@ static struct sock *dccp_v6_request_recv
 		newnp->ipv6_mc_list = NULL;
 		newnp->ipv6_ac_list = NULL;
 		newnp->ipv6_fl_list = NULL;
-		newnp->mcast_oif   = inet6_iif(skb);
-		newnp->mcast_hops  = ipv6_hdr(skb)->hop_limit;
+		newnp->mcast_oif   = inet_iif(skb);
+		newnp->mcast_hops  = ip_hdr(skb)->ttl;
 
 		/*
 		 * No need to charge this sock to the relevant IPv6 refcnt debug socks count


