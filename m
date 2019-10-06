Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E46C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DEF2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382434;
	bh=btIa0ZHhdskAhD1AHsqYrNAnTzJcJwLkUyEocZemCtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCL8Fcq/H2+3RXxeiyR3Zi8MuDkVQ4Fsh+GMJFVCyiCb34KOKDN9zv+qpIEnHFPpv
	 iM534UUFF7arJhxl1vsbMOL04Qx5QqUc4EmHdhcuz50nnI9DABsn9S26lsS/8BGAos
	 fSx2fnmPo10a7LaRQ6ZuuJSxp6zJrgnyChv3makA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJFRUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfJFRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D9520867;
        Sun,  6 Oct 2019 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382428;
        bh=btIa0ZHhdskAhD1AHsqYrNAnTzJcJwLkUyEocZemCtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYIjbh37FXOsZuVO7GyBF4VE0tXqpHOo53hbbe227spdD3l/GKoAbt3ccq4M0ef4F
         76Q2hFjKYM1aHCRM8SD5R0+Sp3K3vBoJv1zAZuaSGjVxnqimw7uTNt4MoCrk7zY1aD
         98wtNr0ttEHm949ms2/02eYbL/yTeWg0tbcFj51w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 27/36] net: ipv4: avoid mixed n_redirects and rate_tokens usage
Date:   Sun,  6 Oct 2019 19:19:09 +0200
Message-Id: <20191006171056.823426812@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171038.266461022@linuxfoundation.org>
References: <20191006171038.266461022@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit b406472b5ad79ede8d10077f0c8f05505ace8b6d ]

Since commit c09551c6ff7f ("net: ipv4: use a dedicated counter
for icmp_v4 redirect packets") we use 'n_redirects' to account
for redirect packets, but we still use 'rate_tokens' to compute
the redirect packets exponential backoff.

If the device sent to the relevant peer any ICMP error packet
after sending a redirect, it will also update 'rate_token' according
to the leaking bucket schema; typically 'rate_token' will raise
above BITS_PER_LONG and the redirect packets backoff algorithm
will produce undefined behavior.

Fix the issue using 'n_redirects' to compute the exponential backoff
in ip_rt_send_redirect().

Note that we still clear rate_tokens after a redirect silence period,
to avoid changing an established behaviour.

The root cause predates git history; before the mentioned commit in
the critical scenario, the kernel stopped sending redirects, after
the mentioned commit the behavior more randomic.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: c09551c6ff7f ("net: ipv4: use a dedicated counter for icmp_v4 redirect packets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -897,16 +897,15 @@ void ip_rt_send_redirect(struct sk_buff
 	if (peer->rate_tokens == 0 ||
 	    time_after(jiffies,
 		       (peer->rate_last +
-			(ip_rt_redirect_load << peer->rate_tokens)))) {
+			(ip_rt_redirect_load << peer->n_redirects)))) {
 		__be32 gw = rt_nexthop(rt, ip_hdr(skb)->daddr);
 
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);
 		peer->rate_last = jiffies;
-		++peer->rate_tokens;
 		++peer->n_redirects;
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 		if (log_martians &&
-		    peer->rate_tokens == ip_rt_redirect_number)
+		    peer->n_redirects == ip_rt_redirect_number)
 			net_warn_ratelimited("host %pI4/if%d ignores redirects for %pI4 to %pI4\n",
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);


