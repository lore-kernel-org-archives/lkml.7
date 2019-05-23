Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAADC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A582075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640492;
	bh=nZGcgFc2z8V4eaNeBmEJckrEFcB5RsTgV1d1vKVSKko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHtYFssogmId2zrGzUlwemSF7eB9uAQ5Kx5dHKc3J3qNMDtc2uCGaW7palUqpHzAa
	 gkPVkn9/FuXyl1z1rzb4V30CSkENNFiyhVfG37wOacpSqnq01DUvWdVDfzI7i0dLWL
	 wRpuTxVJFpsZsSZMgIWx9OGvx8CWsXpr4lULmJa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfEWTlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389233AbfEWTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7802133D;
        Thu, 23 May 2019 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639194;
        bh=nZGcgFc2z8V4eaNeBmEJckrEFcB5RsTgV1d1vKVSKko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzTbwweZKLyGstodRi1KDDU6LVul3fqBbVh4ZydsoYkah9+tmPkDt7txd5z5Qb+rP
         h9nqvvSm7CTASY0LWAccXOoC27CUuKxtJb1r61/nZi00U2DNX/Ts6LIfcUq7aIf0ZP
         2ubh/wb6gPl4Prx3PdvmHcb4lw+1B8thHCFNC6Ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Wei Wang <weiwan@google.com>, David Ahern <dsahern@gmail.com>,
        Martin Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 002/139] ipv6: prevent possible fib6 leaks
Date:   Thu, 23 May 2019 21:04:50 +0200
Message-Id: <20190523181720.502832383@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 61fb0d01680771f72cc9d39783fb2c122aaad51e ]

At ipv6 route dismantle, fib6_drop_pcpu_from() is responsible
for finding all percpu routes and set their ->from pointer
to NULL, so that fib6_ref can reach its expected value (1).

The problem right now is that other cpus can still catch the
route being deleted, since there is no rcu grace period
between the route deletion and call to fib6_drop_pcpu_from()

This can leak the fib6 and associated resources, since no
notifier will take care of removing the last reference(s).

I decided to add another boolean (fib6_destroying) instead
of reusing/renaming exception_bucket_flushed to ease stable backports,
and properly document the memory barriers used to implement this fix.

This patch has been co-developped with Wei Wang.

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Wei Wang <weiwan@google.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin Lau <kafai@fb.com>
Acked-by: Wei Wang <weiwan@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip6_fib.h |    3 ++-
 net/ipv6/ip6_fib.c    |   12 +++++++++---
 net/ipv6/route.c      |    7 +++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -171,7 +171,8 @@ struct fib6_info {
 					dst_nocount:1,
 					dst_nopolicy:1,
 					dst_host:1,
-					unused:3;
+					fib6_destroying:1,
+					unused:2;
 
 	struct fib6_nh			fib6_nh;
 	struct rcu_head			rcu;
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -909,6 +909,12 @@ static void fib6_drop_pcpu_from(struct f
 {
 	int cpu;
 
+	/* Make sure rt6_make_pcpu_route() wont add other percpu routes
+	 * while we are cleaning them here.
+	 */
+	f6i->fib6_destroying = 1;
+	mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
+
 	/* release the reference to this fib entry from
 	 * all of its cached pcpu routes
 	 */
@@ -932,6 +938,9 @@ static void fib6_purge_rt(struct fib6_in
 {
 	struct fib6_table *table = rt->fib6_table;
 
+	if (rt->rt6i_pcpu)
+		fib6_drop_pcpu_from(rt, table);
+
 	if (atomic_read(&rt->fib6_ref) != 1) {
 		/* This route is used as dummy address holder in some split
 		 * nodes. It is not leaked, but it still holds other resources,
@@ -953,9 +962,6 @@ static void fib6_purge_rt(struct fib6_in
 			fn = rcu_dereference_protected(fn->parent,
 				    lockdep_is_held(&table->tb6_lock));
 		}
-
-		if (rt->rt6i_pcpu)
-			fib6_drop_pcpu_from(rt, table);
 	}
 }
 
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1260,6 +1260,13 @@ static struct rt6_info *rt6_make_pcpu_ro
 	prev = cmpxchg(p, NULL, pcpu_rt);
 	BUG_ON(prev);
 
+	if (rt->fib6_destroying) {
+		struct fib6_info *from;
+
+		from = xchg((__force struct fib6_info **)&pcpu_rt->from, NULL);
+		fib6_info_release(from);
+	}
+
 	return pcpu_rt;
 }
 


