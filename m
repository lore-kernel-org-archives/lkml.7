Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77591C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44265208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfD0PYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33460 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbfD0PP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:26 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2x-00014G-Uw; Sat, 27 Apr 2019 16:15:24 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004aY-FY; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Wenhao Zhang" <zhangwenhao8@huawei.com>,
        "Zhiqiang Liu" <liuzhiqiang26@huawei.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.669742497@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 147/202] net: fix IPv6 prefix route residue
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

commit e75913c93f7cd5f338ab373c34c93a655bd309cb upstream.

Follow those steps:
 # ip addr add 2001:123::1/32 dev eth0
 # ip addr add 2001:123:456::2/64 dev eth0
 # ip addr del 2001:123::1/32 dev eth0
 # ip addr del 2001:123:456::2/64 dev eth0
and then prefix route of 2001:123::1/32 will still exist.

This is because ipv6_prefix_equal in check_cleanup_prefix_route
func does not check whether two IPv6 addresses have the same
prefix length. If the prefix of one address starts with another
shorter address prefix, even though their prefix lengths are
different, the return value of ipv6_prefix_equal is true.

Here I add a check of whether two addresses have the same prefix
to decide whether their prefixes are equal.

Fixes: 5b84efecb7d9 ("ipv6 addrconf: don't cleanup prefix route for IFA_F_NOPREFIXROUTE")
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reported-by: Wenhao Zhang <zhangwenhao8@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -943,7 +943,8 @@ check_cleanup_prefix_route(struct inet6_
 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
 		if (ifa == ifp)
 			continue;
-		if (!ipv6_prefix_equal(&ifa->addr, &ifp->addr,
+		if (ifa->prefix_len != ifp->prefix_len ||
+		    !ipv6_prefix_equal(&ifa->addr, &ifp->addr,
 				       ifp->prefix_len))
 			continue;
 		if (ifa->flags & (IFA_F_PERMANENT | IFA_F_NOPREFIXROUTE))

