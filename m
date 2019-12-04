Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E954C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FFA20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483376;
	bh=z1eVLwXiLmA33ZjS/VWvvXhkVIz7u9fA+N+baWptQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVdjVNaoUnIobLJuXJ95k2jOn7/91Xb73GkYIg0ZEA0+tJRXrWZa+8jveDPMjro6C
	 8ZyLhBYAV8fgH+5jTH+xSRvhDMBwwvEU6xcF9tZcTPGAKYnN08YPwvP9qugCu4PJ7l
	 osqwCV7HHQppID9Up0Iip6Ff3Z4i70/gFPtxZe0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfLDSQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbfLDSNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:13:25 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00D9206DF;
        Wed,  4 Dec 2019 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483205;
        bh=z1eVLwXiLmA33ZjS/VWvvXhkVIz7u9fA+N+baWptQ2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hhw13M8olCkLRkwlxQV0J8fFQG3A9XJYWM4tBIhjkOe3MEdsNz4XQah9w4oxD4eNP
         xoFOscrRNkwk8PQqdm7VxkC3gleVsqCIIJ3/urd7F6j0EoMJ9Q2iWLP7VjiFfsPuhI
         f9z1rBbuRG4LUGKO1nqBoP9EKRP/m2iN2gGX3ns8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 096/125] net: fix possible overflow in __sk_mem_raise_allocated()
Date:   Wed,  4 Dec 2019 18:56:41 +0100
Message-Id: <20191204175324.924827132@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
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
index d8d14ae8892a7..aed436567d70b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1201,7 +1201,7 @@ static inline void sk_sockets_allocated_inc(struct sock *sk)
 	percpu_counter_inc(sk->sk_prot->sockets_allocated);
 }
 
-static inline int
+static inline u64
 sk_sockets_allocated_read_positive(struct sock *sk)
 {
 	return percpu_counter_read_positive(sk->sk_prot->sockets_allocated);
diff --git a/net/core/sock.c b/net/core/sock.c
index d224933514074..41794a698da66 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2156,7 +2156,7 @@ int __sk_mem_schedule(struct sock *sk, int size, int kind)
 	}
 
 	if (sk_has_memory_pressure(sk)) {
-		int alloc;
+		u64 alloc;
 
 		if (!sk_under_memory_pressure(sk))
 			return 1;
-- 
2.20.1



