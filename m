Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7E6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E5D2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122352;
	bh=afDWeJqFwiCkdimdPuH1nag9yJ/0W2LKQy4KxV3gHXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X9/HSYrZJlMRiM6Q+UBIpOWfe76PYKZJ0RKJK4xi/EjETkYcfuWsi2mqfOaMWTX8V
	 OVuhsdS35w3ubMc/Pc6nMUoHCfxnZXbNzRWFlx41p+BvDBee0mpt5eoqdh75ygE4pb
	 ybQdQSaBuDQ6HHOZyOdevffTMEaR4vFH6k+zduR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404972AbfJCRFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404779AbfJCQjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:39:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E622070B;
        Thu,  3 Oct 2019 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120745;
        bh=afDWeJqFwiCkdimdPuH1nag9yJ/0W2LKQy4KxV3gHXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1xnthVLa0/YF+vuiPt141+92mblGMmSkCfPgAIBETfo7h3cGEtkaYzDsmwNjdWns
         bvPxfNJR/ZgEbZeztDBzsOE1ePJwdM3+ZgEL+nH88R28W9BYydnwu2bqY+OyX67IoC
         OplIUo1kRE4px8JHEb2qE0StawP/4BW4/7AR/WBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Yi Ren <c4tren@gmail.com>
Subject: [PATCH 5.3 022/344] ipv6: fix a typo in fib6_rule_lookup()
Date:   Thu,  3 Oct 2019 17:49:47 +0200
Message-Id: <20191003154542.274878159@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7b09c2d052db4b4ad0b27b97918b46a7746966fa ]

Yi Ren reported an issue discovered by syzkaller, and bisected
to the cited commit.

Many thanks to Yi, this trivial patch does not reflect the patient
work that has been done.

Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Wei Wang <weiwan@google.com>
Bisected-and-reported-by: Yi Ren <c4tren@gmail.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_fib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -318,7 +318,7 @@ struct dst_entry *fib6_rule_lookup(struc
 	if (rt->dst.error == -EAGAIN) {
 		ip6_rt_put_flags(rt, flags);
 		rt = net->ipv6.ip6_null_entry;
-		if (!(flags | RT6_LOOKUP_F_DST_NOREF))
+		if (!(flags & RT6_LOOKUP_F_DST_NOREF))
 			dst_hold(&rt->dst);
 	}
 


