Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E1EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8494828024
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NKB2F0yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfFCNKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:10:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:10:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DAhoi605284
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:10:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DAhoi605284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567444;
        bh=+/YblooBhmh3VfISkyyYscIzCqvmEDgFKMuMVsNEiHk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NKB2F0yhcI5q1Da4nB6DFEzrGJHVUyH32RALDOdPKFNTLKfWGBqlyjFfci53TYTEe
         FHJkfDRHiWS0evQgp5hQ1EJdz/hLHOQ1rNhYQMRIbZtCoTkmbQTsgKYFDs9qRiYJNa
         h11RJX1flKWKiXYO9ndNWnitHSFegxpsd/th4jbnremO47Iab+9A7iiJVkW9W5ks6D
         43gruBgNt6f6oO7KLa54noTseT5MYtgOD2WryqDiIadi112Uw6XW96smLctskkeldW
         3jgZj24RC1+cfECXQRKgOqCMIhHP4Q8MSQQqly4Gk2AGPfIKiGhop9Pw2/L7tIN2rR
         cDNmL5eRCG5SA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DAhAt605281;
        Mon, 3 Jun 2019 06:10:43 -0700
Date:   Mon, 3 Jun 2019 06:10:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-e196e479a3b844da6e6e71e0d2a8694040cb4e52@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, duyuyang@gmail.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, duyuyang@gmail.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190506081939.74287-8-duyuyang@gmail.com>
References: <20190506081939.74287-8-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Use lockdep_init_task for task
 initiation consistently
Git-Commit-ID: e196e479a3b844da6e6e71e0d2a8694040cb4e52
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

Commit-ID:  e196e479a3b844da6e6e71e0d2a8694040cb4e52
Gitweb:     https://git.kernel.org/tip/e196e479a3b844da6e6e71e0d2a8694040cb4e52
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:23 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:42 +0200

locking/lockdep: Use lockdep_init_task for task initiation consistently

Despite that there is a lockdep_init_task() which does nothing, lockdep
initiates tasks by assigning lockdep fields and does so inconsistently. Fix
this by using lockdep_init_task().

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-8-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  |  7 ++++++-
 init/init_task.c         |  2 ++
 kernel/fork.c            |  3 ---
 kernel/locking/lockdep.c | 11 ++++++++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 851d44fa5457..5d05b8149f19 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -287,6 +287,8 @@ extern void lockdep_free_key_range(void *start, unsigned long size);
 extern asmlinkage void lockdep_sys_exit(void);
 extern void lockdep_set_selftest_task(struct task_struct *task);
 
+extern void lockdep_init_task(struct task_struct *task);
+
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
@@ -411,6 +413,10 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 
 #else /* !CONFIG_LOCKDEP */
 
+static inline void lockdep_init_task(struct task_struct *task)
+{
+}
+
 static inline void lockdep_off(void)
 {
 }
@@ -503,7 +509,6 @@ enum xhlock_context_t {
 	{ .name = (_name), .key = (void *)(_key), }
 
 static inline void lockdep_invariant_state(bool force) {}
-static inline void lockdep_init_task(struct task_struct *task) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
 
 #ifdef CONFIG_LOCK_STAT
diff --git a/init/init_task.c b/init/init_task.c
index c70ef656d0f4..1b15cb90d64f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -166,6 +166,8 @@ struct task_struct init_task
 	.softirqs_enabled = 1,
 #endif
 #ifdef CONFIG_LOCKDEP
+	.lockdep_depth = 0, /* no locks held yet */
+	.curr_chain_key = 0,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..735d0b4a89e2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1984,9 +1984,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->pagefault_disabled = 0;
 
 #ifdef CONFIG_LOCKDEP
-	p->lockdep_depth = 0; /* no locks held yet */
-	p->curr_chain_key = 0;
-	p->lockdep_recursion = 0;
 	lockdep_init_task(p);
 #endif
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bc1efc12a8c5..b7d9c28ecf3b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -359,6 +359,13 @@ static inline u64 iterate_chain_key(u64 key, u32 idx)
 	return k0 | (u64)k1 << 32;
 }
 
+void lockdep_init_task(struct task_struct *task)
+{
+	task->lockdep_depth = 0; /* no locks held yet */
+	task->curr_chain_key = 0;
+	task->lockdep_recursion = 0;
+}
+
 void lockdep_off(void)
 {
 	current->lockdep_recursion++;
@@ -4589,9 +4596,7 @@ void lockdep_reset(void)
 	int i;
 
 	raw_local_irq_save(flags);
-	current->curr_chain_key = 0;
-	current->lockdep_depth = 0;
-	current->lockdep_recursion = 0;
+	lockdep_init_task(current);
 	memset(current->held_locks, 0, MAX_LOCK_DEPTH*sizeof(struct held_lock));
 	nr_hardirq_chains = 0;
 	nr_softirq_chains = 0;
