Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA83F20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126996;
	bh=R4tRPvY5/IJXlbFVC0BZ6aF41u8Befvt50c0JXMgfh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEvccQCqXpdlQHKvDr/St7p9B16au3gUYCtg7m6cZzdwNcQIJqoBdkUGJeaZxHqyl
	 8iX1eA6xSVGUyZNB/dFVmnXFf2/2XIcfWN6tTOKXa0Cgd+1EPJhcOX1p2L5+Z0ASG0
	 oYBtIeDs2IO3iox5w1N7BzzoNKi3CnctkJcqx7Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbfDXR3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390860AbfDXR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:47 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0092820811;
        Wed, 24 Apr 2019 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126986;
        bh=R4tRPvY5/IJXlbFVC0BZ6aF41u8Befvt50c0JXMgfh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM1I6IpPHYOM8LS8FGFyySgenZmsGRIujzLCDDEk9G69nxLgMzJJkE8yRqWNnAmZa
         6MSpY+0nilH7NxCZT1iqJOvSIMLdRuId7WMojso1PMS/SJq+yys1OkV9pexXFbHQjo
         FcW2AavnOf5KKi3Hcgh//j8MuVStj4NAX2xvyEZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 19/96] route: Avoid crash from dereferencing NULL rt->from
Date:   Wed, 24 Apr 2019 19:09:24 +0200
Message-Id: <20190424170921.130819267@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Lemon <jonathan.lemon@gmail.com>

[ Upstream commit 9c69a13205151c0d801de9f9d83a818e6e8f60ec ]

When __ip6_rt_update_pmtu() is called, rt->from is RCU dereferenced, but is
never checked for null - rt6_flush_exceptions() may have removed the entry.

[ 1913.989004] RIP: 0010:ip6_rt_cache_alloc+0x13/0x170
[ 1914.209410] Call Trace:
[ 1914.214798]  <IRQ>
[ 1914.219226]  __ip6_rt_update_pmtu+0xb0/0x190
[ 1914.228649]  ip6_tnl_xmit+0x2c2/0x970 [ip6_tunnel]
[ 1914.239223]  ? ip6_tnl_parse_tlv_enc_lim+0x32/0x1a0 [ip6_tunnel]
[ 1914.252489]  ? __gre6_xmit+0x148/0x530 [ip6_gre]
[ 1914.262678]  ip6gre_tunnel_xmit+0x17e/0x3c7 [ip6_gre]
[ 1914.273831]  dev_hard_start_xmit+0x8d/0x1f0
[ 1914.283061]  sch_direct_xmit+0xfa/0x230
[ 1914.291521]  __qdisc_run+0x154/0x4b0
[ 1914.299407]  net_tx_action+0x10e/0x1f0
[ 1914.307678]  __do_softirq+0xca/0x297
[ 1914.315567]  irq_exit+0x96/0xa0
[ 1914.322494]  smp_apic_timer_interrupt+0x68/0x130
[ 1914.332683]  apic_timer_interrupt+0xf/0x20
[ 1914.341721]  </IRQ>

Fixes: a68886a69180 ("net/ipv6: Make from in rt6_info rcu protected")
Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Reviewed-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2367,6 +2367,10 @@ static void __ip6_rt_update_pmtu(struct
 
 		rcu_read_lock();
 		from = rcu_dereference(rt6->from);
+		if (!from) {
+			rcu_read_unlock();
+			return;
+		}
 		nrt6 = ip6_rt_cache_alloc(from, daddr, saddr);
 		if (nrt6) {
 			rt6_do_update_pmtu(nrt6, mtu);


