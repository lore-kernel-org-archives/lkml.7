Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF56C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B442421655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428845;
	bh=5NwAp73nKV++WnnHW1SKK5D8ojELMkgVwqolVmj/iTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjcAbNvS0bFH9Mr1vO3D5htDJUs7MGkVS2Ec94PQ++MA61UdIcRjAdWYi4Jqvc3yI
	 yNVi2Is5YIQcnP/BEeOUk9M33VLpce+r4eBScb7o6EgQqmgnILwJ5SOi46Oh9N2whD
	 Afr4yOCocDjxand2wRyUU+Tgbo5VBeGc5al1LQNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfG2TeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbfG2Td7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:33:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89BB217D6;
        Mon, 29 Jul 2019 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428838;
        bh=5NwAp73nKV++WnnHW1SKK5D8ojELMkgVwqolVmj/iTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pchwhhqfqtJFic2T1HgKwliUmJg534ndH3BEragfQh+7++O9uOlXZNf5PyRvsDwGL
         BPe7XXn0m4STBM/8ofFkMq0HEEu0qwdR6ZYTXeLyRubNzgGgYi1yJnpvQuXrhqh9zb
         I8tGrfNwtptOTH95sd+n/0pdBMWGMdaxcbA4W6To=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Martin Weinelt <martin@linuxlounge.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 203/293] net: bridge: mcast: fix stale ipv6 hdr pointer when handling v6 query
Date:   Mon, 29 Jul 2019 21:21:34 +0200
Message-Id: <20190729190840.031452347@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 3b26a5d03d35d8f732d75951218983c0f7f68dff ]

We get a pointer to the ipv6 hdr in br_ip6_multicast_query but we may
call pskb_may_pull afterwards and end up using a stale pointer.
So use the header directly, it's just 1 place where it's needed.

Fixes: 08b202b67264 ("bridge br_multicast: IPv6 MLD support.")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Tested-by: Martin Weinelt <martin@linuxlounge.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_multicast.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1482,7 +1482,6 @@ static int br_ip6_multicast_query(struct
 				  struct sk_buff *skb,
 				  u16 vid)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct mld_msg *mld;
 	struct net_bridge_mdb_entry *mp;
 	struct mld2_query *mld2q;
@@ -1526,7 +1525,7 @@ static int br_ip6_multicast_query(struct
 
 	if (is_general_query) {
 		saddr.proto = htons(ETH_P_IPV6);
-		saddr.u.ip6 = ip6h->saddr;
+		saddr.u.ip6 = ipv6_hdr(skb)->saddr;
 
 		br_multicast_query_received(br, port, &br->ip6_other_query,
 					    &saddr, max_delay);


