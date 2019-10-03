Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD62C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35310222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067017;
	bh=rotuVr8T+0nH2VJEluJRScYkA/ofar/x0CByUKr1zYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vpiTn7S2lM8mlKXbjQjgqyqqqYsN/bibEU3Yg7doUSxaA2kBQkHc9iUHicAKowJ2E
	 ZE1GaoZSHi2TpiZtyAg4q2KbvknrkxAFzrRZLYpB3KWRvi8h7J4qGHG8rzWDMqx+M+
	 YGyXJl1oESkEvFxivecqMo1TKFEx2k6AIYE4qDYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJCBng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfJCBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:43:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DF7222C5;
        Thu,  3 Oct 2019 01:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066993;
        bh=rotuVr8T+0nH2VJEluJRScYkA/ofar/x0CByUKr1zYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0cSwzfgP4CdMi/Y04TcV13gJxLnhpwf96lljXXzc+5CjBH7f9cAgNQT+k+ML4pHH
         aEWpcJpq4jIKKa+A23ysWzFqZQngIebEkAr4uoes9A0gR+mbHYPbwJzXvYiKl2hgkO
         WMRSf9mxzPQRWWUzzJMduqVSWhFFg4FqVf2+CdDU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-afs@lists.infradead.org
Subject: [PATCH tip/core/rcu 5/9] fs/afs: Replace rcu_swap_protected() with rcu_replace()
Date:   Wed,  2 Oct 2019 18:43:06 -0700
Message-Id: <20191003014310.13262-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014153.GA13156@paulmck-ThinkPad-P72>
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: <linux-afs@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>
---
 fs/afs/vl_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 21eb0c0..e594598 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -279,8 +279,8 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 			struct afs_addr_list *old = addrs;
 
 			write_lock(&server->lock);
-			rcu_swap_protected(server->addresses, old,
-					   lockdep_is_held(&server->lock));
+			old = rcu_replace(server->addresses, old,
+					  lockdep_is_held(&server->lock));
 			write_unlock(&server->lock);
 			afs_put_addrlist(old);
 		}
-- 
2.9.5

