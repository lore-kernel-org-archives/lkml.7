Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4B4C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3459A2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556965615;
	bh=e1o4mFFNofXkPR/ecgVDEav2/lkN45hLVFmaojZ77Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGyLj4bZhtU9uBBLd3Gpo2ZB3dxuvQf6wt/2mPO8rLOjHsmDhJCwH8xLgXlCAAWtD
	 ZIg1wpqXKkeFc0/wx20lkfVc71S1mK13tTJLCOw7MV556Yc+G5uAOscO+QivHX+Wdv
	 om0a/nNb88wnOwQvPq9pMZO7zCgnS81ERvOa1zEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfEDK0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfEDK0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:26:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1ECC20870;
        Sat,  4 May 2019 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965611;
        bh=e1o4mFFNofXkPR/ecgVDEav2/lkN45hLVFmaojZ77Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN82J/E/LMPbH6StFNUKLMJeqJq8bvS1FMLzpZk8Xpe1+ZtADZ4YkRN7GbTpsWaj0
         TrkAnpQB26+UG3JS0RTQMRjc9TF3BlbpoUxphPgddXeNYKMrCw1M9oPaYV5SjlQztG
         ttWg3p7JwzV/zYxd41sEzH7965Esv1MwgLtMEPlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 07/32] l2tp: use rcu_dereference_sk_user_data() in l2tp_udp_encap_recv()
Date:   Sat,  4 May 2019 12:24:52 +0200
Message-Id: <20190504102452.764103982@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
References: <20190504102452.523724210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c1c477217882c610a2ba0268f5faf36c9c092528 ]

Canonical way to fetch sk_user_data from an encap_rcv() handler called
from UDP stack in rcu protected section is to use rcu_dereference_sk_user_data(),
otherwise compiler might read it multiple times.

Fixes: d00fa9adc528 ("il2tp: fix races with tunnel socket close")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -909,7 +909,7 @@ int l2tp_udp_encap_recv(struct sock *sk,
 {
 	struct l2tp_tunnel *tunnel;
 
-	tunnel = l2tp_tunnel(sk);
+	tunnel = rcu_dereference_sk_user_data(sk);
 	if (tunnel == NULL)
 		goto pass_up;
 


