Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777DC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052621738
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599275;
	bh=OyvPrMEsL5zESbuuUbF6mok4H+383Nhd1CEAyymND5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgqZSLSfCdftexBxfJ2hR3PsU4oQp06YiJCrag1R+DVZeGXkM/+asbz7rvXi+V738
	 yskFh/zlYAfoNbkijLt+Mpm/EeISBaw6H09akgY+x4HA5AaBlxdx2hGdZwYcWR3uvy
	 9wv5BV0Mxi02I9NRzqZSXAag6HgRS5/6dW83wBbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfGHPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfGHPVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:21:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F42216E3;
        Mon,  8 Jul 2019 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599268;
        bh=OyvPrMEsL5zESbuuUbF6mok4H+383Nhd1CEAyymND5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HScheexg3J8PHfJdGCEJdNc+tIT9gGXi3Po60k8KIaD4osYrIvXrHt4Q37FJNdVqc
         FK4zOHpGLpIBIRJ2gPz0auILwSCZzLzx0MHQe6j8bVlHpS9TpczpqShjpw5BXJQ4Ae
         ZN7bjvVmv6s/wug2sisKovUpA5cBaaA9HuteMQ50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 060/102] ipv4: Use return value of inet_iif() for __raw_v4_lookup in the while loop
Date:   Mon,  8 Jul 2019 17:12:53 +0200
Message-Id: <20190708150529.566741992@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Suryaputra <ssuryaextr@gmail.com>

[ Upstream commit 38c73529de13e1e10914de7030b659a2f8b01c3b ]

In commit 19e4e768064a8 ("ipv4: Fix raw socket lookup for local
traffic"), the dif argument to __raw_v4_lookup() is coming from the
returned value of inet_iif() but the change was done only for the first
lookup. Subsequent lookups in the while loop still use skb->dev->ifIndex.

Fixes: 19e4e768064a8 ("ipv4: Fix raw socket lookup for local traffic")
Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/raw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -197,7 +197,7 @@ static int raw_v4_input(struct sk_buff *
 		}
 		sk = __raw_v4_lookup(net, sk_next(sk), iph->protocol,
 				     iph->saddr, iph->daddr,
-				     skb->dev->ifindex);
+				     dif);
 	}
 out:
 	read_unlock(&raw_v4_hashinfo.lock);


