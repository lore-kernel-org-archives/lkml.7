Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF755C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30DD218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787883;
	bh=vadi/Je55c5f/tGC/lMOM980cpfhNgS7P/ZpBGlasyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQOZhfwTadw4xy9rk/zmZJPvAlECISh6dy93L5K4zUM6uliQrV4/1fDu0qn3jwAkD
	 KK2Md759CvSp/2kzG6e429d7S6KBw25IugNlPL3CnqEyawA2UaJghaOAWGTEAjOBjT
	 2vzvNigxCq/v9BVHpIBNFVj+mrc+0wX72jZPxC5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfIRGYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbfIRGYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:24:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668CA21906;
        Wed, 18 Sep 2019 06:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787879;
        bh=vadi/Je55c5f/tGC/lMOM980cpfhNgS7P/ZpBGlasyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjG5ZzHymJb5WCnY7Z6Zg9605unDMzT6vM+ZEusHKeIwUOdg/CoOiORfPVmsQzN1l
         /eP/rUWO6TdA/gUYJRqJTDH0RyPiVhySujhPZV0rSC9cKKyKLiwcjgUN3/S9bFnov4
         A8rQ9/iYnjQ9t25FiMeoYXTGaPTL3UxpiYN6leo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 18/85] ipv6: addrconf_f6i_alloc - fix non-null pointer check to !IS_ERR()
Date:   Wed, 18 Sep 2019 08:18:36 +0200
Message-Id: <20190918061234.724056122@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej Żenczykowski" <maze@google.com>

[ Upstream commit 8652f17c658d03f5c87b8dee6e8e52480c6cd37d ]

Fixes a stupid bug I recently introduced...
ip6_route_info_create() returns an ERR_PTR(err) and not a NULL on error.

Fixes: d55a2e374a94 ("net-ipv6: fix excessive RTF_ADDRCONF flag on ::1/128 local route (and others)'")
Cc: David Ahern <dsahern@gmail.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3859,7 +3859,7 @@ struct fib6_info *addrconf_f6i_alloc(str
 	}
 
 	f6i = ip6_route_info_create(&cfg, gfp_flags, NULL);
-	if (f6i)
+	if (!IS_ERR(f6i))
 		f6i->dst_nocount = true;
 	return f6i;
 }


