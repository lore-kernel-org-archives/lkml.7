Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E970F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EICSuyBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfB1TBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:01:47 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:36650 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727165AbfB1TBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:01:47 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 9B8C21120;
        Thu, 28 Feb 2019 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1551380506;
        bh=d48Ubzp7ujVzNBGaN4zuOjOPz8+LnNQavnenvBW3mas=;
        h=Date:To:Subject:From;
        b=EICSuyBQy7/9tpfx2EjglYycb9pN2ifKJUTjJFldepGfPIhWPen7py8Qz9xZ8/mF/
         U6lxukHQXEo6cH6q7EOtPk6mgUKRY/0vKbvdHDU8Y8PPNelJHdzkkXMR9ECsJg6MNM
         09Nw0fojUk65EmbHUzKwvx5iccDu00g2eqI+TGoi/pTTU3FtmCNfA2OnvQ9il6y6C+
         I+6xt1ujOQlTqqypOr9bjCjT/SA7wrfFzoeOd2Q4up+MS7p6/geifrI7NbhYcJ2LDO
         c0dgpOTTnbd+2abK4VOPYDdUGnnTDuV4axfcPSaPE5hQUnm/0ks7ZQrm8BhbYkSCVZ
         GPKZDcIciBtQw==
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 984A2111B;
        Thu, 28 Feb 2019 11:01:46 -0800 (PST)
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id 802CD95C016B; Thu, 28 Feb 2019 11:01:46 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:01:46 -0800
To:     yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net,
        maxim@arista.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, fruggeri@arista.com
Subject: [PATCH] net: ipv6: check net in ip6_call_ra_chain
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20190228190146.802CD95C016B@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ip6_call_ra_chain is called when IPv6 packet with Router Alert option
is forwarded.
It needs to check if the net of the socket is the same as the net of the
input device, otherwise the packet gets delivered to every IPv6 socket
listening for Router Alerts, no matter which network namespace it is in.

Suggested-by: Maxim Martynov <maxim@arista.com>
Signed-off-by: Maxim Martynov <maxim@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>

---
 net/ipv6/ip6_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5f9fa0302b5a..3ed25e17dff3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -299,7 +299,8 @@ static int ip6_call_ra_chain(struct sk_buff *skb, int sel)
 		struct sock *sk = ra->sk;
 		if (sk && ra->sel == sel &&
 		    (!sk->sk_bound_dev_if ||
-		     sk->sk_bound_dev_if == skb->dev->ifindex)) {
+		     sk->sk_bound_dev_if == skb->dev->ifindex) &&
+		    net_eq(sock_net(sk), dev_net(skb->dev))) {
 			if (last) {
 				struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 				if (skb2)
-- 
2.19.1

