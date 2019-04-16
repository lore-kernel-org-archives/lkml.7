Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5413B2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfDPOJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:09:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfDPOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:09:05 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hGOlg-000347-Cj; Tue, 16 Apr 2019 16:09:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] random: Add a spinlock_t to struct batched_entropy
Date:   Tue, 16 Apr 2019 16:08:58 +0200
Message-Id: <20190416140858.31980-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-CPU variable batched_entropy_uXX is protected by get_cpu_var().
This is just a preempt_disable() which ensures that the variable is only
from the local CPU. It does not protect against users on the same CPU
from another context. It is possible that a preemptible context reads
slot 0 and then an interrupt occurs and the same value is read again.

The above scenario is confirmed by lockdep if we add a spinlock:
| ================================
| WARNING: inconsistent lock state
| 5.1.0-rc3+ #42 Not tainted
| --------------------------------
| inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
| ksoftirqd/9/56 [HC0[0]:SC1[1]:HE0:SE0] takes:
| (____ptrval____) (batched_entropy_u32.lock){+.?.}, at: get_random_u32+0x3e/0xe0
| {SOFTIRQ-ON-W} state was registered at:
|   _raw_spin_lock+0x2a/0x40
|   get_random_u32+0x3e/0xe0
|   new_slab+0x15c/0x7b0
|   ___slab_alloc+0x492/0x620
|   __slab_alloc.isra.73+0x53/0xa0
|   kmem_cache_alloc_node+0xaf/0x2a0
|   copy_process.part.41+0x1e1/0x2370
|   _do_fork+0xdb/0x6d0
|   kernel_thread+0x20/0x30
|   kthreadd+0x1ba/0x220
|   ret_from_fork+0x3a/0x50
…
| other info that might help us debug this:
|  Possible unsafe locking scenario:
|
|        CPU0
|        ----
|   lock(batched_entropy_u32.lock);
|   <Interrupt>
|     lock(batched_entropy_u32.lock);
|
|  *** DEADLOCK ***
|
| stack backtrace:
| Call Trace:
…
|  kmem_cache_alloc_trace+0x20e/0x270
|  ipmi_alloc_recv_msg+0x16/0x40
…
|  __do_softirq+0xec/0x48d
|  run_ksoftirqd+0x37/0x60
|  smpboot_thread_fn+0x191/0x290
|  kthread+0xfe/0x130
|  ret_from_fork+0x3a/0x50

Add a spinlock_t to the batched_entropy data structure and acquire the
lock while accessing it. Acquire the lock with disabled interrupts
because this function may be used from interrupt context.

Remove the batched_entropy_reset_lock lock. Now that we have a lock for
the data scructure, we can access it from a remote CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 52 ++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6d1c0..8d25c7b1f99bc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2211,8 +2211,8 @@ struct batched_entropy {
 		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
 	};
 	unsigned int position;
+	spinlock_t batch_lock;
 };
-static rwlock_t batched_entropy_reset_lock = __RW_LOCK_UNLOCKED(batched_entropy_reset_lock);
 
 /*
  * Get a random word for internal kernel use only. The quality of the random
@@ -2222,12 +2222,14 @@ static rwlock_t batched_entropy_reset_lock = __RW_LOCK_UNLOCKED(batched_entropy_
  * wait_for_random_bytes() should be called and return 0 at least once
  * at any point prior.
  */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64);
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
+	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+};
+
 u64 get_random_u64(void)
 {
 	u64 ret;
-	bool use_lock;
-	unsigned long flags = 0;
+	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
 
@@ -2242,28 +2244,25 @@ u64 get_random_u64(void)
 
 	warn_unseeded_randomness(&previous);
 
-	use_lock = READ_ONCE(crng_init) < 2;
-	batch = &get_cpu_var(batched_entropy_u64);
-	if (use_lock)
-		read_lock_irqsave(&batched_entropy_reset_lock, flags);
+	batch = raw_cpu_ptr(&batched_entropy_u64);
+	spin_lock_irqsave(&batch->batch_lock, flags);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
 		extract_crng((u8 *)batch->entropy_u64);
 		batch->position = 0;
 	}
 	ret = batch->entropy_u64[batch->position++];
-	if (use_lock)
-		read_unlock_irqrestore(&batched_entropy_reset_lock, flags);
-	put_cpu_var(batched_entropy_u64);
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
 
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32);
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
+	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+};
 u32 get_random_u32(void)
 {
 	u32 ret;
-	bool use_lock;
-	unsigned long flags = 0;
+	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
 
@@ -2272,18 +2271,14 @@ u32 get_random_u32(void)
 
 	warn_unseeded_randomness(&previous);
 
-	use_lock = READ_ONCE(crng_init) < 2;
-	batch = &get_cpu_var(batched_entropy_u32);
-	if (use_lock)
-		read_lock_irqsave(&batched_entropy_reset_lock, flags);
+	batch = raw_cpu_ptr(&batched_entropy_u32);
+	spin_lock_irqsave(&batch->batch_lock, flags);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
 		extract_crng((u8 *)batch->entropy_u32);
 		batch->position = 0;
 	}
 	ret = batch->entropy_u32[batch->position++];
-	if (use_lock)
-		read_unlock_irqrestore(&batched_entropy_reset_lock, flags);
-	put_cpu_var(batched_entropy_u32);
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
@@ -2297,12 +2292,19 @@ static void invalidate_batched_entropy(void)
 	int cpu;
 	unsigned long flags;
 
-	write_lock_irqsave(&batched_entropy_reset_lock, flags);
 	for_each_possible_cpu (cpu) {
-		per_cpu_ptr(&batched_entropy_u32, cpu)->position = 0;
-		per_cpu_ptr(&batched_entropy_u64, cpu)->position = 0;
+		struct batched_entropy *batched_entropy;
+
+		batched_entropy = per_cpu_ptr(&batched_entropy_u32, cpu);
+		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
+		batched_entropy->position = 0;
+		spin_unlock(&batched_entropy->batch_lock);
+
+		batched_entropy = per_cpu_ptr(&batched_entropy_u64, cpu);
+		spin_lock(&batched_entropy->batch_lock);
+		batched_entropy->position = 0;
+		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
 	}
-	write_unlock_irqrestore(&batched_entropy_reset_lock, flags);
 }
 
 /**
-- 
2.20.1

