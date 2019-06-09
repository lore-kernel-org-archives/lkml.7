Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F8C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11868206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098856;
	bh=ItzDGbHblQGivKofGXtluzvl1JPij++RgJ9aLrrIhVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8NcAmRhculUt5iPik+lKYPNOfREeTnL1MjFsnD0Xa0WU1UZ4YGUxFPd6EqjhUMCw
	 X276YDpE3tHoLVo+YjkI6UiOITgJeRFrBNOCZB23En7LiUMuR6DG+1vXnBT4vCcRD6
	 Az+JFSFnlCzKZBHtMZEAh3salhkaISH25Zn8fNEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfFIQrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfFIQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:47:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE17720833;
        Sun,  9 Jun 2019 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098843;
        bh=ItzDGbHblQGivKofGXtluzvl1JPij++RgJ9aLrrIhVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVIOddl/okLsWgEZZkq1kbPBFqwPUt8hDoNtjOIyta14L/XvIyBHRV4rdqPtKzIWr
         h4++krGlNTiDEGoYWfaUJhr8xyZzvEGeHsiejDrHhG8m2BT/U98hgYrC9t1Q+RlYWq
         dVWfrRj8BinVf+2bO/Jj1Rxben1WADXnHwwGuJLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/51] ipv4: not do cache for local delivery if bc_forwarding is enabled
Date:   Sun,  9 Jun 2019 18:41:44 +0200
Message-Id: <20190609164127.337162226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
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
@@ -1960,7 +1960,7 @@ static int ip_route_input_slow(struct sk
 	u32		itag = 0;
 	struct rtable	*rth;
 	struct flowi4	fl4;
-	bool do_cache;
+	bool do_cache = true;
 
 	/* IP on this device is disabled. */
 
@@ -2037,6 +2037,9 @@ static int ip_route_input_slow(struct sk
 	if (res->type == RTN_BROADCAST) {
 		if (IN_DEV_BFORWARD(in_dev))
 			goto make_route;
+		/* not do cache if bc_forwarding is enabled */
+		if (IPV4_DEVCONF_ALL(net, BC_FORWARDING))
+			do_cache = false;
 		goto brd_input;
 	}
 
@@ -2074,16 +2077,13 @@ brd_input:
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
 


