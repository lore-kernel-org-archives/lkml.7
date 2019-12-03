Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B97C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBF020863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413722;
	bh=fvyBd8sXl1lzT7qyyD1yBBl5FrdPpIvsakCUmBErZB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFJhlECJFlLrXV6T0RKOVD2NnRFhqquqaPPukKhg3uwXM7WUdFUpu3j1yp5sON2dn
	 e1pIsDLk19TQXqwJUzR2yprY1VIc2q7WVyBZXp1ZW7d7i3GDZ1ajTt5eydI3xTvjfc
	 efGYb0Gq8ejjsAaC9jROfRXezY58ctfqpdq3oKIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfLCWzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbfLCWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF9920863;
        Tue,  3 Dec 2019 22:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413717;
        bh=fvyBd8sXl1lzT7qyyD1yBBl5FrdPpIvsakCUmBErZB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGijSmLf3bUW0ZV0u6PpwfiKJfhVlq1ieW2RYPcxGyYFxoI5KVaiJDQLGwcJx9XMj
         7S+adNvESCygnkV1SOWlvMht24tSXgZ9Gr3qbzqWlaWQOmPzkCMrMF0pD1GB/zop+T
         bfE0wlao+GxB6sqsLzB9d6W2KU40RXtsj+CzR7z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 235/321] net: fix possible overflow in __sk_mem_raise_allocated()
Date:   Tue,  3 Dec 2019 23:35:01 +0100
Message-Id: <20191203223439.357056985@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5bf325a53202b8728cf7013b72688c46071e212e ]

With many active TCP sockets, fat TCP sockets could fool
__sk_mem_raise_allocated() thanks to an overflow.

They would increase their share of the memory, instead
of decreasing it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 2 +-
 net/core/sock.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0252c0d003104..4545a9ecc2193 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1272,7 +1272,7 @@ static inline void sk_sockets_allocated_inc(struct sock *sk)
 	percpu_counter_inc(sk->sk_prot->sockets_allocated);
 }
 
-static inline int
+static inline u64
 sk_sockets_allocated_read_positive(struct sock *sk)
 {
 	return percpu_counter_read_positive(sk->sk_prot->sockets_allocated);
diff --git a/net/core/sock.c b/net/core/sock.c
index ba4f843cdd1d1..bbde5f6a7dc91 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2435,7 +2435,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	}
 
 	if (sk_has_memory_pressure(sk)) {
-		int alloc;
+		u64 alloc;
 
 		if (!sk_under_memory_pressure(sk))
 			return 1;
-- 
2.20.1



