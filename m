Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08020C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB659205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012915;
	bh=UgTjlc2QNNj2DJv7LAYQwFyJq4Ea+Eu9pXIlImpn1AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hisCAw9URQ+AevDxQJgCXJ04R6p2tVG1e4kNldoXHtjYerM7zE21tuJ+ox+gwX4Ts
	 vYZBJP6MOVYrMROG4BADT64/ql4npptAJxNOX6VwXmZvNFMgaoYOyE5DLNSUg7sveX
	 aT8ySfmQTNJJq7cMBRdUrHYwcpb1gN8jfrPowFEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfLJVVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbfLJVLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E065A24697;
        Tue, 10 Dec 2019 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012300;
        bh=UgTjlc2QNNj2DJv7LAYQwFyJq4Ea+Eu9pXIlImpn1AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtO/imSFlzEA9o+w+Zg2MZtaOdUhFAJLD834gOKmg3Oa93KBg8/Kva+MPJ5ff5lsa
         5mLLBcKCGZwAJWdJCAr5VLeNNuNZY8CoEXiPRGhoQs/Sa/685XoNF9id+5vzBaRm3H
         Isu5m6DD9tL64sRY1HxgGGSdpbMbiQ8xIrKtW+tc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 237/350] net: avoid potential false sharing in neighbor related code
Date:   Tue, 10 Dec 2019 16:05:42 -0500
Message-Id: <20191210210735.9077-198-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 25c7a6d1f90e208ec27ca854b1381ed39842ec57 ]

There are common instances of the following construct :

	if (n->confirmed != now)
		n->confirmed = now;

A C compiler could legally remove the conditional.

Use READ_ONCE()/WRITE_ONCE() to avoid this problem.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/arp.h   |  4 ++--
 include/net/ndisc.h |  8 ++++----
 include/net/sock.h  | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/arp.h b/include/net/arp.h
index c8f580a0e6b1f..4950191f6b2bf 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -57,8 +57,8 @@ static inline void __ipv4_confirm_neigh(struct net_device *dev, u32 key)
 		unsigned long now = jiffies;
 
 		/* avoid dirtying neighbour */
-		if (n->confirmed != now)
-			n->confirmed = now;
+		if (READ_ONCE(n->confirmed) != now)
+			WRITE_ONCE(n->confirmed, now);
 	}
 	rcu_read_unlock_bh();
 }
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index b2f715ca05672..b5ebeb3b0de0e 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -414,8 +414,8 @@ static inline void __ipv6_confirm_neigh(struct net_device *dev,
 		unsigned long now = jiffies;
 
 		/* avoid dirtying neighbour */
-		if (n->confirmed != now)
-			n->confirmed = now;
+		if (READ_ONCE(n->confirmed) != now)
+			WRITE_ONCE(n->confirmed, now);
 	}
 	rcu_read_unlock_bh();
 }
@@ -431,8 +431,8 @@ static inline void __ipv6_confirm_neigh_stub(struct net_device *dev,
 		unsigned long now = jiffies;
 
 		/* avoid dirtying neighbour */
-		if (n->confirmed != now)
-			n->confirmed = now;
+		if (READ_ONCE(n->confirmed) != now)
+			WRITE_ONCE(n->confirmed, now);
 	}
 	rcu_read_unlock_bh();
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index 718e62fbe869d..013396e50b91f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1940,8 +1940,8 @@ struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie);
 
 static inline void sk_dst_confirm(struct sock *sk)
 {
-	if (!sk->sk_dst_pending_confirm)
-		sk->sk_dst_pending_confirm = 1;
+	if (!READ_ONCE(sk->sk_dst_pending_confirm))
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 1);
 }
 
 static inline void sock_confirm_neigh(struct sk_buff *skb, struct neighbour *n)
@@ -1951,10 +1951,10 @@ static inline void sock_confirm_neigh(struct sk_buff *skb, struct neighbour *n)
 		unsigned long now = jiffies;
 
 		/* avoid dirtying neighbour */
-		if (n->confirmed != now)
-			n->confirmed = now;
-		if (sk && sk->sk_dst_pending_confirm)
-			sk->sk_dst_pending_confirm = 0;
+		if (READ_ONCE(n->confirmed) != now)
+			WRITE_ONCE(n->confirmed, now);
+		if (sk && READ_ONCE(sk->sk_dst_pending_confirm))
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	}
 }
 
-- 
2.20.1

