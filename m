Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCA0222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950869;
	bh=hkE3djVetnvqBS1YIlZacEzmgwQ31kas5IS+lXjAyMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/rV3zFgYGZuluE9inx4GIFaKZM6r1v6SQZAMGVcYQiEqFOfDKumYVhkOEXGb8WvZ
	 FtN3d8U7IwciE+0wS1tYVgBW4EPMWC7zr0tPHSEf+tV4ob2XY1SpmZKvKQCoAiPMq+
	 qPvSOFF4rLc5jA3cVa4MNr/RUWN2NUNTkRakue1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfLJEHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:45 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1C0E2080D;
        Tue, 10 Dec 2019 04:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950865;
        bh=hkE3djVetnvqBS1YIlZacEzmgwQ31kas5IS+lXjAyMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrpGDPyxg7hIr43+E8XhRcq0s/70O93e7dT+fi9V8zjwU9BrhcCCLCd1+noA1w+Pz
         I2WQlODrV3/uh1SkQbR1ID7e/cS6WW3F8Fj47WmJ74Yc0Fq9bM5GyvcVtXkLR3BAwt
         OuNq76So+zEAr0ynRyggpn5OadqaOYg359tiUSFk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/12] rcu: Fix harmless omission of "CONFIG_" from #if condition
Date:   Mon,  9 Dec 2019 20:07:32 -0800
Message-Id: <20191210040741.2943-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The C preprocessor macros SRCU and TINY_RCU should instead be CONFIG_SRCU
and CONFIG_TINY_RCU, respectively in the #f in kernel/rcu/rcu.h. But
there is no harm when "TINY_RCU" is wrongly used, which are always
non-defined, which makes "!defined(TINY_RCU)" always true, which means
the code block is always included, and the included code block doesn't
cause any compilation error so far in CONFIG_TINY_RCU builds.  It is
also the reason this change should not be taken in -stable.

This commit adds the needed "CONFIG_" prefix to both macros.

Not for -stable.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ab504fb..4732594 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -281,7 +281,7 @@ void rcu_test_sync_prims(void);
  */
 extern void resched_cpu(int cpu);
 
-#if defined(SRCU) || !defined(TINY_RCU)
+#if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU)
 
 #include <linux/rcu_node_tree.h>
 
@@ -418,7 +418,7 @@ do {									\
 #define raw_lockdep_assert_held_rcu_node(p)				\
 	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
 
-#endif /* #if defined(SRCU) || !defined(TINY_RCU) */
+#endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
 
 #ifdef CONFIG_SRCU
 void srcu_init(void);
-- 
2.9.5

