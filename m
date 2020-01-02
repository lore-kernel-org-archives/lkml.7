Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E6C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD6720866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005844;
	bh=231M9ZcOHkbunKVp1/YyJEDypQXx8MuXr0Vb+2TFM1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H4dsOcyEURCtoFo/d5M7+pnp0xcOHGRA7wFNAa6iNdmBVWO3QzQO0vp51/+OOnIiI
	 p1l20Sjnuj9ELUZ5naKB7yCkeYzfXeOx/dnja1Ybe3xUuekm0XZbXQ2Gou8XYw+Hr1
	 BqHtzqWrG70IZfKy3f5bDfI5UgDN61lyuVmU1zF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgABW5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgABWRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:17:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE27227BF;
        Thu,  2 Jan 2020 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003428;
        bh=231M9ZcOHkbunKVp1/YyJEDypQXx8MuXr0Vb+2TFM1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/okBfdPv0fRpo2xCJVLoJJuuvUgXuE9cWu9iJ2en6hRaaj1xKpOmafx1yvsvJhfL
         sPQcGQcSQLG15efmqs5/3GtzOoDhaNYbgz1sGl3X7UjndRBJAf6envLLHQD9zkAng0
         E60LO4TBBx7Ul/b8al/KRVikNMhxJ75Nmp9d3i+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antonio Messina <amessina@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 157/191] udp: fix integer overflow while computing available space in sk_rcvbuf
Date:   Thu,  2 Jan 2020 23:07:19 +0100
Message-Id: <20200102215846.228365652@linuxfoundation.org>
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

From: Antonio Messina <amessina@google.com>

[ Upstream commit feed8a4fc9d46c3126fb9fcae0e9248270c6321a ]

When the size of the receive buffer for a socket is close to 2^31 when
computing if we have enough space in the buffer to copy a packet from
the queue to the buffer we might hit an integer overflow.

When an user set net.core.rmem_default to a value close to 2^31 UDP
packets are dropped because of this overflow. This can be visible, for
instance, with failure to resolve hostnames.

This can be fixed by casting sk_rcvbuf (which is an int) to unsigned
int, similarly to how it is done in TCP.

Signed-off-by: Antonio Messina <amessina@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1475,7 +1475,7 @@ int __udp_enqueue_schedule_skb(struct so
 	 * queue contains some other skb
 	 */
 	rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
-	if (rmem > (size + sk->sk_rcvbuf))
+	if (rmem > (size + (unsigned int)sk->sk_rcvbuf))
 		goto uncharge_drop;
 
 	spin_lock(&list->lock);


