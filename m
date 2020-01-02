Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD71C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818F227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003464;
	bh=AT2WhW5MQNZ6Kd2PuTjD5TTU9q9gqdrKbc7+j7RSLoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jrrHeRJ0xFzVOa6KDkdrDJGU8gLQoMVFMeKB1JWDkmkCJ1v6xlq2vOV00sXgg7e6Z
	 4p5C9RFkBw16x9StdaCDrdQyFkOCkpWP08Dql8QM3rMS26wIeKLBB2yv+BTpx4Gj+O
	 Gn3Sei4IHTOuNh3bEOgmPOkxVikkVDg114JDBEWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgABWRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgABWRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:17:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801AF227BF;
        Thu,  2 Jan 2020 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003457;
        bh=AT2WhW5MQNZ6Kd2PuTjD5TTU9q9gqdrKbc7+j7RSLoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czXFKUXinBqJaiBfCfRejAD6cDt8fdQV10CTmOnoIS10XOGe4SFpJxNxpZfid+iFz
         XtFCf/Wv+FvfCgSmdm79WPxVAkcpj1XdmGLBT9G5FimpTZ0s+SJjbJ/YPwU85GfxxP
         RNknWeZaq/aEmUIR6bp2eTzf1pV83fi0a2i0aSsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 168/191] ip6_gre: do not confirm neighbor when do pmtu update
Date:   Thu,  2 Jan 2020 23:07:30 +0100
Message-Id: <20200102215847.311928164@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 675d76ad0ad5bf41c9a129772ef0aba8f57ea9a7 ]

When we do ipv6 gre pmtu update, we will also do neigh confirm currently.
This will cause the neigh cache be refreshed and set to REACHABLE before
xmit.

But if the remote mac address changed, e.g. device is deleted and recreated,
we will not able to notice this and still use the old mac address as the neigh
cache is REACHABLE.

Fix this by disable neigh confirm when do pmtu update

v5: No change.
v4: No change.
v3: Do not remove dst_confirm_neigh, but add a new bool parameter in
    dst_ops.update_pmtu to control whether we should do neighbor confirm.
    Also split the big patch to small ones for each area.
v2: Remove dst_confirm_neigh in __ip6_rt_update_pmtu.

Reported-by: Jianlin Shi <jishi@redhat.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1040,7 +1040,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, true);
+		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);


