Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532CEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3242176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfK2J7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:59:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2J7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:59:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iad3j-0002SG-LH; Fri, 29 Nov 2019 10:59:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 449C71C2116;
        Fri, 29 Nov 2019 10:59:31 +0100 (CET)
Date:   Fri, 29 Nov 2019 09:59:31 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlock/debug: Fix various data races
Cc:     Qian Cai <cai@lca.pw>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191120155715.28089-1-elver@google.com>
References: <20191120155715.28089-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <157502157113.21853.17291169803723090357.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1a365e822372ba24c9da0822bc583894f6f3d821
Gitweb:        https://git.kernel.org/tip/1a365e822372ba24c9da0822bc583894f6f3d821
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 20 Nov 2019 16:57:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Nov 2019 08:03:27 +01:00

locking/spinlock/debug: Fix various data races

This fixes various data races in spinlock_debug. By testing with KCSAN,
it is observable that the console gets spammed with data races reports,
suggesting these are extremely frequent.

Example data race report:

  read to 0xffff8ab24f403c48 of 4 bytes by task 221 on cpu 2:
   debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
   do_raw_spin_lock+0x9b/0x210 kernel/locking/spinlock_debug.c:112
   __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
   _raw_spin_lock+0x39/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   get_partial_node.isra.0.part.0+0x32/0x2f0 mm/slub.c:1873
   get_partial_node mm/slub.c:1870 [inline]
  <snip>

  write to 0xffff8ab24f403c48 of 4 bytes by task 167 on cpu 3:
   debug_spin_unlock kernel/locking/spinlock_debug.c:103 [inline]
   do_raw_spin_unlock+0xc9/0x1a0 kernel/locking/spinlock_debug.c:138
   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:159 [inline]
   _raw_spin_unlock_irqrestore+0x2d/0x50 kernel/locking/spinlock.c:191
   spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
   free_debug_processing+0x1b3/0x210 mm/slub.c:1214
   __slab_free+0x292/0x400 mm/slub.c:2864
  <snip>

As a side-effect, with KCSAN, this eventually locks up the console, most
likely due to deadlock, e.g. .. -> printk lock -> spinlock_debug ->
KCSAN detects data race -> kcsan_print_report() -> printk lock ->
deadlock.

This fix will 1) avoid the data races, and 2) allow using lock debugging
together with KCSAN.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20191120155715.28089-1-elver@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/spinlock_debug.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 399669f..472dd46 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -51,19 +51,19 @@ EXPORT_SYMBOL(__rwlock_init);
 
 static void spin_dump(raw_spinlock_t *lock, const char *msg)
 {
-	struct task_struct *owner = NULL;
+	struct task_struct *owner = READ_ONCE(lock->owner);
 
-	if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
-		owner = lock->owner;
+	if (owner == SPINLOCK_OWNER_INIT)
+		owner = NULL;
 	printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
 		msg, raw_smp_processor_id(),
 		current->comm, task_pid_nr(current));
 	printk(KERN_EMERG " lock: %pS, .magic: %08x, .owner: %s/%d, "
 			".owner_cpu: %d\n",
-		lock, lock->magic,
+		lock, READ_ONCE(lock->magic),
 		owner ? owner->comm : "<none>",
 		owner ? task_pid_nr(owner) : -1,
-		lock->owner_cpu);
+		READ_ONCE(lock->owner_cpu));
 	dump_stack();
 }
 
@@ -80,16 +80,16 @@ static void spin_bug(raw_spinlock_t *lock, const char *msg)
 static inline void
 debug_spin_lock_before(raw_spinlock_t *lock)
 {
-	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
-	SPIN_BUG_ON(lock->owner == current, lock, "recursion");
-	SPIN_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	SPIN_BUG_ON(READ_ONCE(lock->magic) != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	SPIN_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
 static inline void debug_spin_lock_after(raw_spinlock_t *lock)
 {
-	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner = current;
+	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
+	WRITE_ONCE(lock->owner, current);
 }
 
 static inline void debug_spin_unlock(raw_spinlock_t *lock)
@@ -99,8 +99,8 @@ static inline void debug_spin_unlock(raw_spinlock_t *lock)
 	SPIN_BUG_ON(lock->owner != current, lock, "wrong owner");
 	SPIN_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
+	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
+	WRITE_ONCE(lock->owner_cpu, -1);
 }
 
 /*
@@ -187,8 +187,8 @@ static inline void debug_write_lock_before(rwlock_t *lock)
 
 static inline void debug_write_lock_after(rwlock_t *lock)
 {
-	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner = current;
+	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
+	WRITE_ONCE(lock->owner, current);
 }
 
 static inline void debug_write_unlock(rwlock_t *lock)
@@ -197,8 +197,8 @@ static inline void debug_write_unlock(rwlock_t *lock)
 	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
 	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
+	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
+	WRITE_ONCE(lock->owner_cpu, -1);
 }
 
 void do_raw_write_lock(rwlock_t *lock)
