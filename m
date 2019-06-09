Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F5AC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFFA20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100921;
	bh=Bzxt5NMfeLaE9vx9o2lwazsyI1QEqtzUSCM57Sf5CY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CocZgIewTXdKwzEz8DxPLK8vUixaAsDBDvnE8eckj+rsKvFXP1ULSjEzSuysa4MIi
	 XcT3pBDRhdMBnYqneogJtcGuozzHXc3TdjvGxDjzcR/Wk53P0qKq8JAda01zXMXvWB
	 6UASbpN2dmND/6vl7bFGAzGLnEfoPGB9QA72AdPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfFIRV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfFIQpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:45:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2CE20840;
        Sun,  9 Jun 2019 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098703;
        bh=Bzxt5NMfeLaE9vx9o2lwazsyI1QEqtzUSCM57Sf5CY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJ7P6EQfE8ykmE2hhwxft1CJrWRk8xNVhtQU6DzNhlYeMVWRbM8KYdaa9bHljcHaP
         e7Yth5ti0W/0ZXDD/NY8YFpbtvJ1X1OST677KatCbO2SvyFXkyVuxbLrc1JnM7HM3l
         ovXeHW4A1YIfHOjgirVtBsvCRW9vlnHgQtQ2uzFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 03/70] ipv4: not do cache for local delivery if bc_forwarding is enabled
Date:   Sun,  9 Jun 2019 18:41:14 +0200
Message-Id: <20190609164127.734831392@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 0a90478b93a46bdcd56ba33c37566a993e455d54 ]

With the topo:

    h1 ---| rp1            |
          |     route  rp3 |--- h3 (192.168.200.1)
    h2 ---| rp2            |

If rp1 bc_forwarding is set while rp2 bc_forwarding is not, after
doing "ping 192.168.200.255" on h1, then ping 192.168.200.255 on
h2, and the packets can still be forwared.

This issue was caused by the input route cache. It should only do
the cache for either bc forwarding or local delivery. Otherwise,
local delivery can use the route cache for bc forwarding of other
interfaces.

This patch is to fix it by not doing cache for local delivery if
all.bc_forwarding is enabled.

Note that we don't fix it by checking route cache local flag after
rt_cache_valid() in "local_input:" and "ip_mkroute_input", as the
common route code shouldn't be touched for bc_forwarding.

Fixes: 5cbf777cfdf6 ("route: add support for directed broadcast forwarding")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1954,7 +1954,7 @@ static int ip_route_input_slow(struct sk
 	u32		itag = 0;
 	struct rtable	*rth;
 	struct flowi4	fl4;
-	bool do_cache;
+	bool do_cache = true;
 
 	/* IP on this device is disabled. */
 
@@ -2031,6 +2031,9 @@ static int ip_route_input_slow(struct sk
 	if (res->type == RTN_BROADCAST) {
 		if (IN_DEV_BFORWARD(in_dev))
 			goto make_route;
+		/* not do cache if bc_forwarding is enabled */
+		if (IPV4_DEVCONF_ALL(net, BC_FORWARDING))
+			do_cache = false;
 		goto brd_input;
 	}
 
@@ -2068,16 +2071,13 @@ brd_input:
 	RT_CACHE_STAT_INC(in_brd);
 
 local_input:
-	do_cache = false;
-	if (res->fi) {
-		if (!itag) {
-			rth = rcu_dereference(FIB_RES_NH(*res).nh_rth_input);
-			if (rt_cache_valid(rth)) {
-				skb_dst_set_noref(skb, &rth->dst);
-				err = 0;
-				goto out;
-			}
-			do_cache = true;
+	do_cache &= res->fi && !itag;
+	if (do_cache) {
+		rth = rcu_dereference(FIB_RES_NH(*res).nh_rth_input);
+		if (rt_cache_valid(rth)) {
+			skb_dst_set_noref(skb, &rth->dst);
+			err = 0;
+			goto out;
 		}
 	}
 


