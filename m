Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2731217F9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383276;
	bh=rxifHShgDK6BaHrF++DXZtdZcyy6KQLBsTZCsmQ+7Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIsgL6trdpAz4mla1f+hbfvBgsc0NGnVceQpemRT0sNvBEhjEmSkpUN7+Woeuob/5
	 2L/XVTcqi11aKjF8n6gi0TAn/DSRQHUD0D5Hv0ftZKHkHwiSEPtir9URlmeKEkk601
	 3nlk+hkrrtsvVlh/ivW1ka2pToWf30Hj3y/fLzQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJFReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbfJFReb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:34:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F13E21479;
        Sun,  6 Oct 2019 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383270;
        bh=rxifHShgDK6BaHrF++DXZtdZcyy6KQLBsTZCsmQ+7Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaRtH7aCRXCyT3P1htAK7xQZ2IiZGQOYv2FZL9KtEhuSYptJ56AmJq5Baz/XQ50r1
         fmAfctyqa45j1qDMGS1CORozgkvvpLMLHqAPrz1sLYv7xGADQPY7XpgO7o+6JvvFeF
         VtGmpuEfJpqffVUVmU1TLGkT3EO7MxnHIlGoR7kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 009/137] net: Unpublish sk from sk_reuseport_cb before call_rcu
Date:   Sun,  6 Oct 2019 19:19:53 +0200
Message-Id: <20191006171210.323569529@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

[ Upstream commit 8c7138b33e5c690c308b2a7085f6313fdcb3f616 ]

The "reuse->sock[]" array is shared by multiple sockets.  The going away
sk must unpublish itself from "reuse->sock[]" before making call_rcu()
call.  However, this unpublish-action is currently done after a grace
period and it may cause use-after-free.

The fix is to move reuseport_detach_sock() to sk_destruct().
Due to the above reason, any socket with sk_reuseport_cb has
to go through the rcu grace period before freeing it.

It is a rather old bug (~3 yrs).  The Fixes tag is not necessary
the right commit but it is the one that introduced the SOCK_RCU_FREE
logic and this fix is depending on it.

Fixes: a4298e4522d6 ("net: add SOCK_RCU_FREE socket flag")
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1696,8 +1696,6 @@ static void __sk_destruct(struct rcu_hea
 		sk_filter_uncharge(sk, filter);
 		RCU_INIT_POINTER(sk->sk_filter, NULL);
 	}
-	if (rcu_access_pointer(sk->sk_reuseport_cb))
-		reuseport_detach_sock(sk);
 
 	sock_disable_timestamp(sk, SK_FLAGS_TIMESTAMP);
 
@@ -1724,7 +1722,14 @@ static void __sk_destruct(struct rcu_hea
 
 void sk_destruct(struct sock *sk)
 {
-	if (sock_flag(sk, SOCK_RCU_FREE))
+	bool use_call_rcu = sock_flag(sk, SOCK_RCU_FREE);
+
+	if (rcu_access_pointer(sk->sk_reuseport_cb)) {
+		reuseport_detach_sock(sk);
+		use_call_rcu = true;
+	}
+
+	if (use_call_rcu)
 		call_rcu(&sk->sk_rcu, __sk_destruct);
 	else
 		__sk_destruct(&sk->sk_rcu);


