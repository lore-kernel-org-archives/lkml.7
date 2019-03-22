Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B22183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260484;
	bh=Nh40Bkq47hiR0oqbK4JtsE4PzriVjsAkEBDBsAD08es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LmxC7DvZqBACIqLtZQ+QB5nOhVnYEIld/lI/hhjHz97Q1tRDaAd6yqbTmKdrjt9Lv
	 aOd1rnA3RMstlHXo3VUcSqiRiqQLdYEcjwRGsIByOJ8fKdOv6saHjMgYZPUXeUYVoK
	 uEmRvIX9uPkxYpiP6lBACNPPL/qo7rtoA+OBjtzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfCVNOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbfCVL3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4864720449;
        Fri, 22 Mar 2019 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254143;
        bh=Nh40Bkq47hiR0oqbK4JtsE4PzriVjsAkEBDBsAD08es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdq7JRHI4GDg/mWBgTdQo9nJlv/1iOFG2xKUZufaLBq4W9eZb41rjFPITMdfks9AP
         7n+eBb59FXDYRCxjBdodthyBYT7APs3yRPcGGsMg86Tl2DoNRBAdbQ33gkONo3Izpr
         Rd7acEvxFjK0w1XAjcG0Kt12L2JPZjsYTu6aTniI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 029/230] Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"
Date:   Fri, 22 Mar 2019 12:12:47 +0100
Message-Id: <20190322111238.731308639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

commit 278e2148c07559dd4ad8602f22366d61eb2ee7b7 upstream.

This reverts commit 5a2de63fd1a5 ("bridge: do not add port to router list
when receives query with source 0.0.0.0") and commit 0fe5119e267f ("net:
bridge: remove ipv6 zero address check in mcast queries")

The reason is RFC 4541 is not a standard but suggestive. Currently we
will elect 0.0.0.0 as Querier if there is no ip address configured on
bridge. If we do not add the port which recives query with source
0.0.0.0 to router list, the IGMP reports will not be about to forward
to Querier, IGMP data will also not be able to forward to dest.

As Nikolay suggested, revert this change first and add a boolopt api
to disable none-zero election in future if needed.

Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Reported-by: Sebastian Gottschall <s.gottschall@newmedia-net.de>
Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
Fixes: 0fe5119e267f ("net: bridge: remove ipv6 zero address check in mcast queries")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/br_multicast.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1261,14 +1261,7 @@ static void br_multicast_query_received(
 		return;
 
 	br_multicast_update_query_timer(br, query, max_delay);
-
-	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
-	 * the arrival port for IGMP Queries where the source address
-	 * is 0.0.0.0 should not be added to router port list.
-	 */
-	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    saddr->proto == htons(ETH_P_IPV6))
-		br_multicast_mark_router(br, port);
+	br_multicast_mark_router(br, port);
 }
 
 static int br_ip4_multicast_query(struct net_bridge *br,


