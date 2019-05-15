Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B442B2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921598;
	bh=BrGBuaBYFEbSew5mma2LdrWM9G9Zzz1MNTXJovmdlt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qFTqHlvLflTS6wbuwjUj1WDXe9d3L3VPDXb9/83qSN+TfF2/4wmZvXK/KCyxM0P86
	 5McFZ0YqKCA9M4FNYDSl/HM4jgL5oeSwc1mCAIUAp9lPkmtWh6p2DdzY+ei6pl5rYB
	 N1MjpM/7766qamrFt0DE+GfzV1Qc6QGm9rqPAe6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfEOL75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730013AbfEOLPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:15:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB7EB20644;
        Wed, 15 May 2019 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918910;
        bh=BrGBuaBYFEbSew5mma2LdrWM9G9Zzz1MNTXJovmdlt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8f4eRUoEBhKb98CWNCUs5R55rAJ92i77noHnGz7OkdG+yuRKlhmWyLKnLPPayXmW
         50yzbk7vTgZwPG6T3A+/FEHO517vRCR+cR7MY/Hpuy++Gdj+4DNMxSibr5UFJKo7uf
         J6dGszvzkz5ovgEr0WjXb5HqwftoIS1Dzn2dKdSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 46/51] ipv4: Fix raw socket lookup for local traffic
Date:   Wed, 15 May 2019 12:56:21 +0200
Message-Id: <20190515090629.253646048@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 19e4e768064a87b073a4b4c138b55db70e0cfb9f ]

inet_iif should be used for the raw socket lookup. inet_iif considers
rt_iif which handles the case of local traffic.

As it stands, ping to a local address with the '-I <dev>' option fails
ever since ping was changed to use SO_BINDTODEVICE instead of
cmsg + IP_PKTINFO.

IPv6 works fine.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/raw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -169,6 +169,7 @@ static int icmp_filter(const struct sock
  */
 static int raw_v4_input(struct sk_buff *skb, const struct iphdr *iph, int hash)
 {
+	int dif = inet_iif(skb);
 	struct sock *sk;
 	struct hlist_head *head;
 	int delivered = 0;
@@ -181,8 +182,7 @@ static int raw_v4_input(struct sk_buff *
 
 	net = dev_net(skb->dev);
 	sk = __raw_v4_lookup(net, __sk_head(head), iph->protocol,
-			     iph->saddr, iph->daddr,
-			     skb->dev->ifindex);
+			     iph->saddr, iph->daddr, dif);
 
 	while (sk) {
 		delivered = 1;


