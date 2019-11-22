Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF48C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B372068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403274;
	bh=rQ5ldQcxVnKsALniRRUFyzeOtkp1YGSrRvd9GjrfY3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOR99o5EMpA1Jr3nVnoGRvcp7cahQLTc8b27n7MQOZ9K0s7pzWRZT51mwD2xq9mcN
	 KWRxgfGPrzoKuHB5TaGMCwk03loLjfGCsRPuwG0fcViQkoU/El06Ou6lXohaZEGgHH
	 uiJRW4XIQh+Z2WC0oelnbElf7py1ZbXgriMWMAEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfKVGOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbfKVGON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:14:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B532070B;
        Fri, 22 Nov 2019 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403253;
        bh=rQ5ldQcxVnKsALniRRUFyzeOtkp1YGSrRvd9GjrfY3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1m1QLmt7hiHPqZSJeUuLVRULaPM6gyTKzG+Vt0+99mBLy19T3U2GQzYHWPQQOzDSk
         65XPkj6gWTnhmpji8HV3vaqvShmCyNqx0EQB12RlPBHKXGD0fv6EIT083TRxhKHIEq
         ddSHjuJm7Kbo1BhVWhJRetxJtZbdWINBoT3O2LMI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 62/68] net: fix possible overflow in __sk_mem_raise_allocated()
Date:   Fri, 22 Nov 2019 01:12:55 -0500
Message-Id: <20191122061301.4947-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 5ed4786a2058b..de4434284a34b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1282,7 +1282,7 @@ static inline void sk_sockets_allocated_inc(struct sock *sk)
 	percpu_counter_inc(prot->sockets_allocated);
 }
 
-static inline int
+static inline u64
 sk_sockets_allocated_read_positive(struct sock *sk)
 {
 	struct proto *prot = sk->sk_prot;
diff --git a/net/core/sock.c b/net/core/sock.c
index 8aa4a5f895723..0f4c15fcd87d3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2122,7 +2122,7 @@ int __sk_mem_schedule(struct sock *sk, int size, int kind)
 	}
 
 	if (sk_has_memory_pressure(sk)) {
-		int alloc;
+		u64 alloc;
 
 		if (!sk_under_memory_pressure(sk))
 			return 1;
-- 
2.20.1

