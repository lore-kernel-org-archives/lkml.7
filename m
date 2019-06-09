Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0897DC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37EE20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100943;
	bh=+p/j7VtJkxXKygDn9Ou6xbFo1HpAs874xIRoz5BVtpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3N2sYWJ2sLz5VuDDrnxJLhBcZhN9LkLdDdGYs4WY4mpnVttwafDLlNBG13UE8eGB
	 ZlMYF/gf1Uw3nCyrOKLlmm+nwyZeRlahmjRkvmjh2a64pCnpmRxrurh6lRXV0d597J
	 CTCd1tVCdy/MkXWDg9W0AZ3tKgre4ACuiLtJ3tR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfFIQo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbfFIQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3C420833;
        Sun,  9 Jun 2019 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098664;
        bh=+p/j7VtJkxXKygDn9Ou6xbFo1HpAs874xIRoz5BVtpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ai+8LBSL708LuVtTTGoTUaoscI9YxqMqd8N4M4k1hGHUTepfE5kpn4ADGD3e/y5p/
         viD7JsYzF06srTMVPj4DURtV/vqs3ReYiskVD0yP8PBCx7Ji2Qu/UtC1KGGaYdXeic
         mRl31I7h+SOmS/5EPs2XKVjxVpNqRR6Ze9Ey7y3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 17/70] neighbor: Call __ipv4_neigh_lookup_noref in neigh_xmit
Date:   Sun,  9 Jun 2019 18:41:28 +0200
Message-Id: <20190609164128.497688325@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 4b2a2bfeb3f056461a90bd621e8bd7d03fa47f60 ]

Commit cd9ff4de0107 changed the key for IFF_POINTOPOINT devices to
INADDR_ANY but neigh_xmit which is used for MPLS encapsulations was not
updated to use the altered key. The result is that every packet Tx does
a lookup on the gateway address which does not find an entry, a new one
is created only to find the existing one in the table right before the
insert since arp_constructor was updated to reset the primary key. This
is seen in the allocs and destroys counters:
    ip -s -4 ntable show | head -10 | grep alloc

which increase for each packet showing the unnecessary overhread.

Fix by having neigh_xmit use __ipv4_neigh_lookup_noref for NEIGH_ARP_TABLE.

Fixes: cd9ff4de0107 ("ipv4: Make neigh lookup keys for loopback/point-to-point devices be INADDR_ANY")
Reported-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/neighbour.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -31,6 +31,7 @@
 #include <linux/times.h>
 #include <net/net_namespace.h>
 #include <net/neighbour.h>
+#include <net/arp.h>
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/netevent.h>
@@ -2984,7 +2985,13 @@ int neigh_xmit(int index, struct net_dev
 		if (!tbl)
 			goto out;
 		rcu_read_lock_bh();
-		neigh = __neigh_lookup_noref(tbl, addr, dev);
+		if (index == NEIGH_ARP_TABLE) {
+			u32 key = *((u32 *)addr);
+
+			neigh = __ipv4_neigh_lookup_noref(dev, key);
+		} else {
+			neigh = __neigh_lookup_noref(tbl, addr, dev);
+		}
 		if (!neigh)
 			neigh = __neigh_create(tbl, addr, dev, false);
 		err = PTR_ERR(neigh);


