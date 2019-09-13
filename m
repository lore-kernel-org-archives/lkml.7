Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471DEC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175BD206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380183;
	bh=ztAw2WI8XHTgR5UIIm3S9StiBL4Qf7ooKL7SmAatFEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfH/RnIh9qWZVW3/ZzYHK1xJHgygO8aXPyMBmmL1jlyCcz7EIKFjKFEFQKkHI6H5y
	 DPPcIZkit08bRPAe1QKiqXcbfFANZ5ZkzdFE/8bib0ABwY6s1zOGQZ6zd503YRNsq8
	 uquuZEDT/yldIztuXRuYZ1H8RWn/kBoZLkYP8AyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbfIMNJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388533AbfIMNJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:09:39 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75F1206A5;
        Fri, 13 Sep 2019 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380178;
        bh=ztAw2WI8XHTgR5UIIm3S9StiBL4Qf7ooKL7SmAatFEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyImmD+83g/0Dpk0Jlz4l5Lox4AKnBqMDVGaNnQwhICjByvD6IDuLjDoqPuu8ExJu
         9I4rzrewCwRD1HRRPX5DcOrSQLnFNb20TounpfKZtU33ZnxYWeE9l3u0rNS9pDPOiz
         +1dHLJbAPvOhewuuMhS0RVSC5SFxJ+Xv7bhm3Z8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Peter Oskolkov <posk@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4.9 07/14] ip6: fix skb leak in ip6frag_expire_frag_queue()
Date:   Fri, 13 Sep 2019 14:07:00 +0100
Message-Id: <20190913130444.894079575@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130440.264749443@linuxfoundation.org>
References: <20190913130440.264749443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 47d3d7fdb10a21c223036b58bd70ffdc24a472c4 upstream.

Since ip6frag_expire_frag_queue() now pulls the head skb
from frag queue, we should no longer use skb_get(), since
this leads to an skb leak.

Stefan Bader initially reported a problem in 4.4.stable [1] caused
by the skb_get(), so this patch should also fix this issue.

296583.091021] kernel BUG at /build/linux-6VmqmP/linux-4.4.0/net/core/skbuff.c:1207!
[296583.091734] Call Trace:
[296583.091749]  [<ffffffff81740e50>] __pskb_pull_tail+0x50/0x350
[296583.091764]  [<ffffffff8183939a>] _decode_session6+0x26a/0x400
[296583.091779]  [<ffffffff817ec719>] __xfrm_decode_session+0x39/0x50
[296583.091795]  [<ffffffff818239d0>] icmpv6_route_lookup+0xf0/0x1c0
[296583.091809]  [<ffffffff81824421>] icmp6_send+0x5e1/0x940
[296583.091823]  [<ffffffff81753238>] ? __netif_receive_skb+0x18/0x60
[296583.091838]  [<ffffffff817532b2>] ? netif_receive_skb_internal+0x32/0xa0
[296583.091858]  [<ffffffffc0199f74>] ? ixgbe_clean_rx_irq+0x594/0xac0 [ixgbe]
[296583.091876]  [<ffffffffc04eb260>] ? nf_ct_net_exit+0x50/0x50 [nf_defrag_ipv6]
[296583.091893]  [<ffffffff8183d431>] icmpv6_send+0x21/0x30
[296583.091906]  [<ffffffff8182b500>] ip6_expire_frag_queue+0xe0/0x120
[296583.091921]  [<ffffffffc04eb27f>] nf_ct_frag6_expire+0x1f/0x30 [nf_defrag_ipv6]
[296583.091938]  [<ffffffff810f3b57>] call_timer_fn+0x37/0x140
[296583.091951]  [<ffffffffc04eb260>] ? nf_ct_net_exit+0x50/0x50 [nf_defrag_ipv6]
[296583.091968]  [<ffffffff810f5464>] run_timer_softirq+0x234/0x330
[296583.091982]  [<ffffffff8108a339>] __do_softirq+0x109/0x2b0

Fixes: d4289fcc9b16 ("net: IP6 defrag: use rbtrees for IPv6 defrag")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Stefan Bader <stefan.bader@canonical.com>
Cc: Peter Oskolkov <posk@google.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/ipv6_frag.h |    1 -
 1 file changed, 1 deletion(-)

--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -94,7 +94,6 @@ ip6frag_expire_frag_queue(struct net *ne
 		goto out;
 
 	head->dev = dev;
-	skb_get(head);
 	spin_unlock(&fq->q.lock);
 
 	icmpv6_send(head, ICMPV6_TIME_EXCEED, ICMPV6_EXC_FRAGTIME, 0);


