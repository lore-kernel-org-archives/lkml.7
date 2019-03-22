Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC58720449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254345;
	bh=L5HUj+v1YLD/hIoNONRBREIzUGLxGePjb49YEwLKfOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t960CtMIw5JJAoluITW+TA1qXRC+QEZg7G5MOaOocld9qz9exoBKVk7j+DNUdYyl/
	 hKh1Umu+YOZrXDukkGFG6Ux4mv5a2Sh6OeicYddHPvGfhfCXMay7LMYuUeg1h14zem
	 e+YNUBjafR6WFWme0MCWkXv9cxzD5xvnzdgHTQ70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfCVLcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbfCVLcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74ABC20449;
        Fri, 22 Mar 2019 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254341;
        bh=L5HUj+v1YLD/hIoNONRBREIzUGLxGePjb49YEwLKfOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvpkPBgJPJdTEDVD04oyE5NKdDUPNJdaPf53LjU9lrOESvsAYcDA1EjcZYFrFwRiO
         B4PkjhsInaFAy4ja1FeghrY5CkGyumpEKcnYnyl3Soi8qI/JdDb67QHHWckMpnqOHA
         WPqMO1Z/NIWVM2DXtdGC0tr4UYMTaig285rUVxvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Amit Cohen <amitc@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 078/230] ip6mr: Do not call __IP6_INC_STATS() from preemptible context
Date:   Fri, 22 Mar 2019 12:13:36 +0100
Message-Id: <20190322111242.125227996@linuxfoundation.org>
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

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 87c11f1ddbbad38ad8bad47af133a8208985fbdf ]

Similar to commit 44f49dd8b5a6 ("ipmr: fix possible race resulting from
improper usage of IP_INC_STATS_BH() in preemptible context."), we cannot
assume preemption is disabled when incrementing the counter and
accessing a per-CPU variable.

Preemption can be enabled when we add a route in process context that
corresponds to packets stored in the unresolved queue, which are then
forwarded using this route [1].

Fix this by using IP6_INC_STATS() which takes care of disabling
preemption on architectures where it is needed.

[1]
[  157.451447] BUG: using __this_cpu_add() in preemptible [00000000] code: smcrouted/2314
[  157.460409] caller is ip6mr_forward2+0x73e/0x10e0
[  157.460434] CPU: 3 PID: 2314 Comm: smcrouted Not tainted 5.0.0-rc7-custom-03635-g22f2712113f1 #1336
[  157.460449] Hardware name: Mellanox Technologies Ltd. MSN2100-CB2FO/SA001017, BIOS 5.6.5 06/07/2016
[  157.460461] Call Trace:
[  157.460486]  dump_stack+0xf9/0x1be
[  157.460553]  check_preemption_disabled+0x1d6/0x200
[  157.460576]  ip6mr_forward2+0x73e/0x10e0
[  157.460705]  ip6_mr_forward+0x9a0/0x1510
[  157.460771]  ip6mr_mfc_add+0x16b3/0x1e00
[  157.461155]  ip6_mroute_setsockopt+0x3cb/0x13c0
[  157.461384]  do_ipv6_setsockopt.isra.8+0x348/0x4060
[  157.462013]  ipv6_setsockopt+0x90/0x110
[  157.462036]  rawv6_setsockopt+0x4a/0x120
[  157.462058]  __sys_setsockopt+0x16b/0x340
[  157.462198]  __x64_sys_setsockopt+0xbf/0x160
[  157.462220]  do_syscall_64+0x14d/0x610
[  157.462349]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 0912ea38de61 ("[IPV6] MROUTE: Add stats in multicast routing module method ip6_mr_forward().")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Amit Cohen <amitc@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6mr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1990,10 +1990,10 @@ int ip6mr_compat_ioctl(struct sock *sk,
 
 static inline int ip6mr_forward2_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	IP6_INC_STATS_BH(net, ip6_dst_idev(skb_dst(skb)),
-			 IPSTATS_MIB_OUTFORWDATAGRAMS);
-	IP6_ADD_STATS_BH(net, ip6_dst_idev(skb_dst(skb)),
-			 IPSTATS_MIB_OUTOCTETS, skb->len);
+	IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+		      IPSTATS_MIB_OUTFORWDATAGRAMS);
+	IP6_ADD_STATS(net, ip6_dst_idev(skb_dst(skb)),
+		      IPSTATS_MIB_OUTOCTETS, skb->len);
 	return dst_output(net, sk, skb);
 }
 


