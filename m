Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E72AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3814522BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154813;
	bh=Ro0FAT0BGVOKoWB4ogETXCph+w+v7zxDCGjgX25mSfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSqmcDHTLSvus9P6nTCxlHGIWsObHa3xzt3CizfjqXTuT42vh09l6MeBZ/QD4hoc/
	 Bm4ZvZAxWlQZbOuCQiSYH3MJKKbN/FYQN95aJQ/ZpS9+gEFGUboIOBRsIEYmFoxgU/
	 r0K6RovJ6O/Q1hItU3E7rllFifFXo2ub3pIhAqzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbfGZP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388041AbfGZP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:26:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9401F205F4;
        Fri, 26 Jul 2019 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154802;
        bh=Ro0FAT0BGVOKoWB4ogETXCph+w+v7zxDCGjgX25mSfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/xSK/NWl3POynyaqjbBWzlFjzIU1BVDeVKFtOXrUTsBczy5o6d9Leu11vEc+Zc94
         2Q37HKngM1BE6lEQbRzHzQGLkARPrI1kGkgV3R3YOBUQ5nS6TnyqNr42H/SbKbLh1e
         LSI9xoMgh3YIaTAoRjdBzltKxy/RgVf2DyEGiuY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 30/66] net: bridge: dont cache ether dest pointer on input
Date:   Fri, 26 Jul 2019 17:24:29 +0200
Message-Id: <20190726152305.085650315@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 3d26eb8ad1e9b906433903ce05f775cf038e747f ]

We would cache ether dst pointer on input in br_handle_frame_finish but
after the neigh suppress code that could lead to a stale pointer since
both ipv4 and ipv6 suppress code do pskb_may_pull. This means we have to
always reload it after the suppress code so there's no point in having
it cached just retrieve it directly.

Fixes: 057658cb33fbf ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_input.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -74,7 +74,6 @@ int br_handle_frame_finish(struct net *n
 	struct net_bridge_fdb_entry *dst = NULL;
 	struct net_bridge_mdb_entry *mdst;
 	bool local_rcv, mcast_hit = false;
-	const unsigned char *dest;
 	struct net_bridge *br;
 	u16 vid = 0;
 
@@ -92,10 +91,9 @@ int br_handle_frame_finish(struct net *n
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, false);
 
 	local_rcv = !!(br->dev->flags & IFF_PROMISC);
-	dest = eth_hdr(skb)->h_dest;
-	if (is_multicast_ether_addr(dest)) {
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest)) {
 		/* by definition the broadcast is also a multicast address */
-		if (is_broadcast_ether_addr(dest)) {
+		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
 			pkt_type = BR_PKT_BROADCAST;
 			local_rcv = true;
 		} else {
@@ -145,7 +143,7 @@ int br_handle_frame_finish(struct net *n
 		}
 		break;
 	case BR_PKT_UNICAST:
-		dst = br_fdb_find_rcu(br, dest, vid);
+		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
 	default:
 		break;
 	}


