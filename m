Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98FC2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240079;
	bh=271yDNJXyHxbrMUQ0GkW0RQ1lfakh7+icX+b4KUdDpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nl6tUmPB2xOAPAMCAfUWjH8SMSKLtq98RIpPO3m3ZPIdxhySXMew6gA5wy9uue1kA
	 jpYbx/P4ks8a1IZxur4tm9/88Uz2zUMjZFm8owDIQ5Ndlesmjvn/CtMEK/yKDmQGuk
	 79z+DXIkFeobBvONquG4q+EnsQxi8gpir0PLGXHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391049AbfKHTH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390608AbfKHTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEB12196F;
        Fri,  8 Nov 2019 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240075;
        bh=271yDNJXyHxbrMUQ0GkW0RQ1lfakh7+icX+b4KUdDpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaHbruLz8pwdyMj1S0trLU3iWs+zwW/53Bk18fGphLR2qbqOX/ZzHpQM+gU6fmdfV
         Qh2BtHXjOh+hFhFsbrH0YbnClQ1ZhDxAZKbuS3Ck+6Zh1DdaK55Emq+549X0SMfo18
         JgeQs1k4t9oKhYkxGGaqeb06rqwJeU8iLrN6r5W4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Thiemo Nagel <tnagel@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 081/140] dccp: do not leak jiffies on the wire
Date:   Fri,  8 Nov 2019 19:50:09 +0100
Message-Id: <20191108174910.223591276@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3d1e5039f5f87a8731202ceca08764ee7cb010d3 ]

For some reason I missed the case of DCCP passive
flows in my previous patch.

Fixes: a904a0693c18 ("inet: stop leaking jiffies on the wire")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Thiemo Nagel <tnagel@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ipv4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -416,7 +416,7 @@ struct sock *dccp_v4_request_recv_sock(c
 	RCU_INIT_POINTER(newinet->inet_opt, rcu_dereference(ireq->ireq_opt));
 	newinet->mc_index  = inet_iif(skb);
 	newinet->mc_ttl	   = ip_hdr(skb)->ttl;
-	newinet->inet_id   = jiffies;
+	newinet->inet_id   = prandom_u32();
 
 	if (dst == NULL && (dst = inet_csk_route_child_sock(sk, newsk, req)) == NULL)
 		goto put_and_exit;


