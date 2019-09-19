Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83133C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470AC21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931564;
	bh=eRqoDxPhzvVbfx3W3pJb3IwRfIRBOVWrUZjCX5SJ9ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwPkXQSpa4v84FD1wTIHuWdvhAKD5nijUgT6i2oNAtHiZwgaIo3GKBoUlG56DVkgD
	 e9u5wkJUjJBsCMfO4OrQJ+S6OQ5svm+021X+fGavK0IbnJYlW2Gguz/41I9f6Mgrlg
	 /ADjjMlaaqgHd+LRo6qzNI4LpXUTcOowxvHlY7oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbfISWTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392452AbfISWTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:19:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B584820678;
        Thu, 19 Sep 2019 22:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931559;
        bh=eRqoDxPhzvVbfx3W3pJb3IwRfIRBOVWrUZjCX5SJ9ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B43Kgd1PQ0Pk17am7g9gr5SaWL+4zQZlkNPjFeC8ZuDKa0zE86Was6GhAtdwHq8UB
         Sfy+ikWwSJMyTi7vTwCGf/XNKkVGN9+7nfhVPULafwvJZjXwJkdVH8mUNVzmuxJlxI
         xWibVcRJnoVZNcmbuhhhGf7nqI0hNR9D7V/qlx9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/74] ipv6: Fix the link time qualifier of ping_v6_proc_exit_net()
Date:   Fri, 20 Sep 2019 00:03:16 +0200
Message-Id: <20190919214801.207325640@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d23dbc479a8e813db4161a695d67da0e36557846 ]

The '.exit' functions from 'pernet_operations' structure should be marked
as __net_exit, not __net_init.

Fixes: d862e5461423 ("net: ipv6: Implement /proc/net/icmp6.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -239,7 +239,7 @@ static int __net_init ping_v6_proc_init_
 	return ping_proc_register(net, &ping_v6_seq_afinfo);
 }
 
-static void __net_init ping_v6_proc_exit_net(struct net *net)
+static void __net_exit ping_v6_proc_exit_net(struct net *net)
 {
 	return ping_proc_unregister(net, &ping_v6_seq_afinfo);
 }


