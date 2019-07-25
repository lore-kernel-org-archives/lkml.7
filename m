Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60721C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AED92238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gJaBrFV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfGYQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:04:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbfGYQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:04:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG4BK21072926
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:04:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG4BK21072926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070652;
        bh=cnpu3Spl81Ccm/C41jJa2bUWpeLBMbpsxx6iohrSSdA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gJaBrFV1xRg90RgqKpe0QCb7XjRRQVXJXLm/WoZZGgPKexEX9Hd3ulJ5AOaYLKSHs
         hOVnYO8bPWFV3NTJof/irqKuDY+6kuqyn9O0lckyAEmvCyWZQtvgbBtDR1qQvoDCA/
         PnZyEYUZr0eRElnecJrpYBLk5Ui1RVFU71kVHfFrE/0RBrTvuftVEmkyTiI73+FeXT
         2COSEFFHC5dGSPQ6LLfQdcUOXv2jlYfuD8PkUgPokSNcigNC5QXoikh+OWVcpOERRb
         lITS5m9Te2Cqz1AxXzhqI4mmIerId+/SLWXl/MeHvKfNBcay6DqnuIu4HxV6UagV/O
         RIuldhQZBFe/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG4Axk1072922;
        Thu, 25 Jul 2019 09:04:10 -0700
Date:   Thu, 25 Jul 2019 09:04:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-30a35f79faadfeb1b89a7fdb3875f14063519041@git.kernel.org>
Cc:     bvanassche@acm.org, tglx@linutronix.de, will@kernel.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        akpm@linux-foundation.org, duyuyang@gmail.com,
        torvalds@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, longman@redhat.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          frederic@kernel.org, duyuyang@gmail.com, hpa@zytor.com,
          peterz@infradead.org, longman@redhat.com, arnd@arndb.de,
          will@kernel.org, tglx@linutronix.de, bvanassche@acm.org,
          akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
          mingo@kernel.org
In-Reply-To: <20190628102919.2345242-1-arnd@arndb.de>
References: <20190628102919.2345242-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Clean up #ifdef checks
Git-Commit-ID: 30a35f79faadfeb1b89a7fdb3875f14063519041
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  30a35f79faadfeb1b89a7fdb3875f14063519041
Gitweb:     https://git.kernel.org/tip/30a35f79faadfeb1b89a7fdb3875f14063519041
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 28 Jun 2019 12:29:03 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:39:26 +0200

locking/lockdep: Clean up #ifdef checks

As Will Deacon points out, CONFIG_PROVE_LOCKING implies TRACE_IRQFLAGS,
so the conditions I added in the previous patch, and some others in the
same file can be simplified by only checking for the former.

No functional change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Yuyang Du <duyuyang@gmail.com>
Fixes: 886532aee3cd ("locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
Link: https://lkml.kernel.org/r/20190628102919.2345242-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 341f52117f88..4861cf8e274b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -448,7 +448,7 @@ static void print_lockdep_off(const char *bug_msg)
 
 unsigned long nr_stack_trace_entries;
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the graph_lock.
@@ -491,7 +491,7 @@ unsigned int max_lockdep_depth;
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Locking printouts:
  */
@@ -2969,7 +2969,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit new_bit);
 
@@ -3608,7 +3608,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
-#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#else /* CONFIG_PROVE_LOCKING */
 
 static inline int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
@@ -3627,7 +3627,7 @@ static inline int separate_irq_context(struct task_struct *curr,
 	return 0;
 }
 
-#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * Initialize a lock instance's lock-class mapping info:
@@ -4321,8 +4321,7 @@ static void __lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie
  */
 static void check_flags(unsigned long flags)
 {
-#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
-    defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
 	if (!debug_locks)
 		return;
 
