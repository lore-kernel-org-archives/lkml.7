Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96580CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F802070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211214;
	bh=x/NA11M+lOlNuOhGp8WHw4vTofgmxvwg0WMPXF6S4Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQ+KX7/x03Rofs/CZQ2LIZktrAsH2VIBefIqIwbkM1udQl7LWxVt24AKjV7Rxkc9r
	 EI7Ul1BsD5PkVYTqiI6+vY34hWuIfTmbFgfIrFOBXZF08zmL4K0LY5fYTHTgLhuknP
	 Zn1GqKHNCzaIs9vCQPC1PL7GkOwvWb1e4HxJsVFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfJ0VUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731622AbfJ0VUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:20:10 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC9F205C9;
        Sun, 27 Oct 2019 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211208;
        bh=x/NA11M+lOlNuOhGp8WHw4vTofgmxvwg0WMPXF6S4Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaGPUeM75Kkmk1P6CzyaeadUECSTMWqmBNyEVoerOw5Sl1xhHHnAJQLTo33GWA3uv
         mwoEQ8mxB6m7kXE5tdACuzjp3RlqiJUSWHOwINwxgskGYgngX+C5VSSN7fm2cLG2q7
         N4HrKx42O12Az5OQzCh7shm/QVdJPhAQg0dQ+q2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Wang <weiwan@google.com>,
        Ido Schimmel <idosch@idosch.org>,
        Jesse Hathaway <jesse@mbuki-mvuki.org>,
        Martin KaFai Lau <kafai@fb.com>,
        David Ahern <dsahern@gmail.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 069/197] ipv4: fix race condition between route lookup and invalidation
Date:   Sun, 27 Oct 2019 21:59:47 +0100
Message-Id: <20191027203355.379557651@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <weiwan@google.com>

[ Upstream commit 5018c59607a511cdee743b629c76206d9c9e6d7b ]

Jesse and Ido reported the following race condition:
<CPU A, t0> - Received packet A is forwarded and cached dst entry is
taken from the nexthop ('nhc->nhc_rth_input'). Calls skb_dst_set()

<t1> - Given Jesse has busy routers ("ingesting full BGP routing tables
from multiple ISPs"), route is added / deleted and rt_cache_flush() is
called

<CPU B, t2> - Received packet B tries to use the same cached dst entry
from t0, but rt_cache_valid() is no longer true and it is replaced in
rt_cache_route() by the newer one. This calls dst_dev_put() on the
original dst entry which assigns the blackhole netdev to 'dst->dev'

<CPU A, t3> - dst_input(skb) is called on packet A and it is dropped due
to 'dst->dev' being the blackhole netdev

There are 2 issues in the v4 routing code:
1. A per-netns counter is used to do the validation of the route. That
means whenever a route is changed in the netns, users of all routes in
the netns needs to redo lookup. v6 has an implementation of only
updating fn_sernum for routes that are affected.
2. When rt_cache_valid() returns false, rt_cache_route() is called to
throw away the current cache, and create a new one. This seems
unnecessary because as long as this route does not change, the route
cache does not need to be recreated.

To fully solve the above 2 issues, it probably needs quite some code
changes and requires careful testing, and does not suite for net branch.

So this patch only tries to add the deleted cached rt into the uncached
list, so user could still be able to use it to receive packets until
it's done.

Fixes: 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly")
Signed-off-by: Wei Wang <weiwan@google.com>
Reported-by: Ido Schimmel <idosch@idosch.org>
Reported-by: Jesse Hathaway <jesse@mbuki-mvuki.org>
Tested-by: Jesse Hathaway <jesse@mbuki-mvuki.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Cc: David Ahern <dsahern@gmail.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1482,7 +1482,7 @@ static bool rt_cache_route(struct fib_nh
 	prev = cmpxchg(p, orig, rt);
 	if (prev == orig) {
 		if (orig) {
-			dst_dev_put(&orig->dst);
+			rt_add_uncached_list(orig);
 			dst_release(&orig->dst);
 		}
 	} else {


