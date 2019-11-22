Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5173C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9466F20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402126;
	bh=AgPQJbwFNsAb9dtE2E6NbnSuKbebTz5BvpW4MjVAdZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vIqROV8aiHShZzDqd02HFEkhY1mjp5/aHMUAyxIsjpCmLqcDTJLCF2z9elOmnnCRo
	 0PuY187Ovoq1OuJIpQd4IWWXIvsRnneVL8sQ3mGz6ClUnReb2mGfP/xNeL5U9+Qwtr
	 ZPgRTNjIYGmVB1mVR8CdqI7UwepwLtKIq3ADwsnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfKVFzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfKVFww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9370C2072D;
        Fri, 22 Nov 2019 05:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401971;
        bh=AgPQJbwFNsAb9dtE2E6NbnSuKbebTz5BvpW4MjVAdZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnGpbNBDwY+iUWqfVHBQNtBD6WZs5ylLkFvy2H65d1H5kNlJ8Z5yyn4oBPBi6IL4a
         kdIxxGeMddZFlsWn3vYDkkaLMRa6EXQX3SMUQtfi3CFNQsGn0xI5Dlt1IbHi5qTPrq
         ofwJT3f8deJ5rA07fW4rwUgUbEPNW2t5rwfhCB0A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 191/219] net: fix possible overflow in __sk_mem_raise_allocated()
Date:   Fri, 22 Nov 2019 00:48:43 -0500
Message-Id: <20191122054911.1750-184-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
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
index 6c11078217769..f49bcaf1deefa 100644
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

