Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C6C47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D17222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066402;
	bh=A76Bi9Ms/NtLN24ZvkPBSbMJ+ITUS55B+Nuwsw5rOQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZmfib5Ws/Q7+Al7GJhCBIGKwGWkkKRaMNcu+Ygs6d4XkVF/XFG0raZJfkIemyT/u
	 J5fkfJUQn7OMKsf7imYcAQZtvICgJfnuTuK/vNBgoEmQqlwUm1zLZsOlaTVRnjb/hJ
	 FlQO5qkOlA7qMcgUnxqvNN6D7R/6jIr8h6MTdCE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfJCBdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbfJCBdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FD62245B;
        Thu,  3 Oct 2019 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066389;
        bh=A76Bi9Ms/NtLN24ZvkPBSbMJ+ITUS55B+Nuwsw5rOQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNNrMe4aKN+TzhRDREG6E1ekC8dszc0HexVV0H5GOKWWgIT7HHVFx8j63+vA9kjcc
         N+LC3q4fRbab8iwUTqCHXY40LmWYJQ55qugUbvn9ArNAEvqVVhn9xMZYfF5XRyeVC+
         PnauqhuzJzK0EreXxDhEkjmESRvfH41LqQe3hkU8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 8/8] rcu: Fix uninitialized variable in nocb_gp_wait()
Date:   Wed,  2 Oct 2019 18:33:05 -0700
Message-Id: <20191003013305.12854-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We never set this to false.  This probably doesn't affect most people's
runtime because GCC will automatically initialize it to false at certain
common optimization levels.  But that behavior is related to a bug in
GCC and obviously should not be relied on.

Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7f..fa08d55 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1946,7 +1946,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	int __maybe_unused cpu = my_rdp->cpu;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
-	bool gotcbs;
+	bool gotcbs = false;
 	unsigned long j = jiffies;
 	bool needwait_gp = false; // This prevents actual uninitialized use.
 	bool needwake;
-- 
2.9.5

