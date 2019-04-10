Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600972083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfDJMNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:13:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDJMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:13:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3ACDEVh764902
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 05:13:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3ACDBFI764899;
        Wed, 10 Apr 2019 05:13:11 -0700
Date:   Wed, 10 Apr 2019 05:13:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-90c1cba2b3b3851c151229f61801919b2904d437@git.kernel.org>
Cc:     shhuiw@foxmail.com, tglx@linutronix.de, longman@redhat.com,
        mingo@kernel.org, hpa@zytor.com, bvanassche@acm.org,
        peterz@infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: shhuiw@foxmail.com, longman@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, bvanassche@acm.org,
          peterz@infradead.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190403233552.124673-1-bvanassche@acm.org>
References: <20190403233552.124673-1-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/lockdep: Zap lock classes even with
 lock debugging disabled
Git-Commit-ID: 90c1cba2b3b3851c151229f61801919b2904d437
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

Commit-ID:  90c1cba2b3b3851c151229f61801919b2904d437
Gitweb:     https://git.kernel.org/tip/90c1cba2b3b3851c151229f61801919b2904d437
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Wed, 3 Apr 2019 16:35:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 13:45:59 +0200

locking/lockdep: Zap lock classes even with lock debugging disabled

The following commit:

  a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")

changed the behavior of lockdep_free_key_range() from
unconditionally zapping lock classes into only zapping lock classes if
debug_lock == true. Not zapping lock classes if debug_lock == false leaves
dangling pointers in several lockdep datastructures, e.g. lock_class::name
in the all_lock_classes list.

The shell command "cat /proc/lockdep" causes the kernel to iterate the
all_lock_classes list. Hence the "unable to handle kernel paging request" cash
that Shenghui encountered by running cat /proc/lockdep.

Since the new behavior can cause cat /proc/lockdep to crash, restore the
pre-v5.1 behavior.

This patch avoids that cat /proc/lockdep triggers the following crash
with debug_lock == false:

  BUG: unable to handle kernel paging request at fffffbfff40ca448
  RIP: 0010:__asan_load1+0x28/0x50
  Call Trace:
   string+0xac/0x180
   vsnprintf+0x23e/0x820
   seq_vprintf+0x82/0xc0
   seq_printf+0x92/0xb0
   print_name+0x34/0xb0
   l_show+0x184/0x200
   seq_read+0x59e/0x6c0
   proc_reg_read+0x11f/0x170
   __vfs_read+0x4d/0x90
   vfs_read+0xc5/0x1f0
   ksys_read+0xab/0x130
   __x64_sys_read+0x43/0x50
   do_syscall_64+0x71/0x210
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: shenghui <shhuiw@foxmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
Link: https://lkml.kernel.org/r/20190403233552.124673-1-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbedda49..e16766ff184b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4689,8 +4689,8 @@ static void free_zapped_rcu(struct rcu_head *ch)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -4702,8 +4702,8 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
 
@@ -4744,21 +4744,17 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
-	int locked;
 
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	locked = graph_lock();
-	if (!locked)
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4911,9 +4907,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4925,8 +4920,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
