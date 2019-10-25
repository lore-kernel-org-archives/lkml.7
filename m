Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D0CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BF02084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572011711;
	bh=B4DUFriqZcFFuyn1w6X7MkgyeS1ormCP/XOxkdR5JcY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bPP9cyO0EM9oevW4Q7sYEhJC9/arTi0GxQpa9FW9Xep+RVawrc65M6Rhg+DoB2Cuz
	 3SYNFpEVCnbQumfub0KoMYUYAcbrb7Hjd+qQzAJqjKBvZHw5kSrdZlbRvXtN7nyD5L
	 Y4au16C/BvQ0I9pv+uTTwsBynzJL9OzBT3QbbVhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504959AbfJYNzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502258AbfJYNzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:55:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC3D20679;
        Fri, 25 Oct 2019 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011707;
        bh=B4DUFriqZcFFuyn1w6X7MkgyeS1ormCP/XOxkdR5JcY=;
        h=From:To:Cc:Subject:Date:From;
        b=vmtl4mgf6pfn/fP9OC0nlwQ0WwEzSxKM6aQrIlPbsW036BKj7CdsCEhtOtkcQgn0V
         PKMMvCg6FhWeCAORu/GlvMDEGqKIdHO+JxrCNkRUqzxzBdU6daR9Zg5xry1YigypbZ
         uSc9EK6PJwrBKFYLgMXc4cBWGddp6Mf8buTKEtPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>,
        syzbot+eb349eeee854e389c36d@syzkaller.appspotmail.com,
        syzbot+4a0643a653ac375612d1@syzkaller.appspotmail.com,
        Edward Cree <ecree@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 01/33] net: ipv6: fix listify ip6_rcv_finish in case of forwarding
Date:   Fri, 25 Oct 2019 09:54:33 -0400
Message-Id: <20191025135505.24762-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit c7a42eb49212f93a800560662d17d5293960d3c3 ]

We need a similar fix for ipv6 as Commit 0761680d5215 ("net: ipv4: fix
listify ip_rcv_finish in case of forwarding") does for ipv4.

This issue can be reprocuded by syzbot since Commit 323ebb61e32b ("net:
use listified RX for handling GRO_NORMAL skbs") on net-next. The call
trace was:

  kernel BUG at include/linux/skbuff.h:2225!
  RIP: 0010:__skb_pull include/linux/skbuff.h:2225 [inline]
  RIP: 0010:skb_pull+0xea/0x110 net/core/skbuff.c:1902
  Call Trace:
    sctp_inq_pop+0x2f1/0xd80 net/sctp/inqueue.c:202
    sctp_endpoint_bh_rcv+0x184/0x8d0 net/sctp/endpointola.c:385
    sctp_inq_push+0x1e4/0x280 net/sctp/inqueue.c:80
    sctp_rcv+0x2807/0x3590 net/sctp/input.c:256
    sctp6_rcv+0x17/0x30 net/sctp/ipv6.c:1049
    ip6_protocol_deliver_rcu+0x2fe/0x1660 net/ipv6/ip6_input.c:397
    ip6_input_finish+0x84/0x170 net/ipv6/ip6_input.c:438
    NF_HOOK include/linux/netfilter.h:305 [inline]
    NF_HOOK include/linux/netfilter.h:299 [inline]
    ip6_input+0xe4/0x3f0 net/ipv6/ip6_input.c:447
    dst_input include/net/dst.h:442 [inline]
    ip6_sublist_rcv_finish+0x98/0x1e0 net/ipv6/ip6_input.c:84
    ip6_list_rcv_finish net/ipv6/ip6_input.c:118 [inline]
    ip6_sublist_rcv+0x80c/0xcf0 net/ipv6/ip6_input.c:282
    ipv6_list_rcv+0x373/0x4b0 net/ipv6/ip6_input.c:316
    __netif_receive_skb_list_ptype net/core/dev.c:5049 [inline]
    __netif_receive_skb_list_core+0x5fc/0x9d0 net/core/dev.c:5097
    __netif_receive_skb_list net/core/dev.c:5149 [inline]
    netif_receive_skb_list_internal+0x7eb/0xe60 net/core/dev.c:5244
    gro_normal_list.part.0+0x1e/0xb0 net/core/dev.c:5757
    gro_normal_list net/core/dev.c:5755 [inline]
    gro_normal_one net/core/dev.c:5769 [inline]
    napi_frags_finish net/core/dev.c:5782 [inline]
    napi_gro_frags+0xa6a/0xea0 net/core/dev.c:5855
    tun_get_user+0x2e98/0x3fa0 drivers/net/tun.c:1974
    tun_chr_write_iter+0xbd/0x156 drivers/net/tun.c:2020

Fixes: d8269e2cbf90 ("net: ipv6: listify ipv6_rcv() and ip6_rcv_finish()")
Fixes: 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
Reported-by: syzbot+eb349eeee854e389c36d@syzkaller.appspotmail.com
Reported-by: syzbot+4a0643a653ac375612d1@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_input.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index a593aaf257483..2bb0b66181a74 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -80,8 +80,10 @@ static void ip6_sublist_rcv_finish(struct list_head *head)
 {
 	struct sk_buff *skb, *next;
 
-	list_for_each_entry_safe(skb, next, head, list)
+	list_for_each_entry_safe(skb, next, head, list) {
+		skb_list_del_init(skb);
 		dst_input(skb);
+	}
 }
 
 static void ip6_list_rcv_finish(struct net *net, struct sock *sk,
-- 
2.20.1

