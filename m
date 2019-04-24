Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6325E2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127289;
	bh=CFsPqLjug4sDyehlM1z1SOb1i2AOUbh+G+BNwBcP1JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2LVEGL8ZeedVVUu6NIwE93nEgGVww2Nd4DLxe4Y/5ZgvMycKHFZyY/NGR6rIj3O9
	 ig/T+oYn3bz9JljnG5n8AAq8Gc/clVY+0hT63C1YOUXvWWNGIRPLi5TpOpF/JprkrQ
	 B+SueAIochu8FUCsbowGHFrwWBc1GQa6hyzsBOT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391784AbfDXRes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391767AbfDXRep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:45 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03481218B0;
        Wed, 24 Apr 2019 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127284;
        bh=CFsPqLjug4sDyehlM1z1SOb1i2AOUbh+G+BNwBcP1JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsajYzMHK8dat6zXEIv0dlQLpZvJ0Q8T/jbfF0CuMh/nK89RwioQIIRXvu1iakd1d
         YKS7/EexzJijmv/nbBNQUeTDKXwCUsUSt9GLEVPxj9SI3+4EHDfAWmw9yEITRkymJa
         t8U5QzCPsmjJxK9B1htA+JAIR2R4exDORr917txU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 036/115] route: Avoid crash from dereferencing NULL rt->from
Date:   Wed, 24 Apr 2019 19:09:32 +0200
Message-Id: <20190424170927.169091255@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
@@ -2336,6 +2336,10 @@ static void __ip6_rt_update_pmtu(struct
 
 		rcu_read_lock();
 		from = rcu_dereference(rt6->from);
+		if (!from) {
+			rcu_read_unlock();
+			return;
+		}
 		nrt6 = ip6_rt_cache_alloc(from, daddr, saddr);
 		if (nrt6) {
 			rt6_do_update_pmtu(nrt6, mtu);


