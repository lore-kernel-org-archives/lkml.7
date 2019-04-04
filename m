Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C74206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfDDRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:05:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46062 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:05:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hC5ns-0006eV-KM; Thu, 04 Apr 2019 19:05:28 +0200
Date:   Thu, 4 Apr 2019 19:05:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [RFC PATCH] random: add a spinlock in addition to get_cpu_var()
Message-ID: <20190404170528.tlzai3jclzcbns3z@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-CPU variable batched_entropy_uXX is protected by get_cpu_var().
This is just a preempt_disable() which ensures that the variable is only
protected against other CPUs. It does not protect against users from
interrupt context. It possible that a preemptible context read slot 0
and an interrupt read the same value.

By adding the spinlock we would deadlock in such a scenario and have
lockdep coverage to warn us about it. And it does:

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
| irq event stamp: 107
| hardirqs last  enabled at (106): [<ffffffff9ddf72c4>] _raw_spin_unlock_irqrestore+0x54/0x70
| hardirqs last disabled at (107): [<ffffffff9d71c7bc>] __slab_alloc.isra.73+0x2c/0xa0
| softirqs last  enabled at (94): [<ffffffff9e0003dc>] __do_softirq+0x3dc/0x48d
| softirqs last disabled at (99): [<ffffffff9d5489a7>] run_ksoftirqd+0x37/0x60
| 
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
| no locks held by ksoftirqd/9/56.
| 
| stack backtrace:
| CPU: 9 PID: 56 Comm: ksoftirqd/9 Not tainted 5.1.0-rc3+ #42
| Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.00.01.0016.020120190930 02/01/2019
| Call Trace:
|  dump_stack+0x7d/0xbb
|  print_usage_bug+0x1ca/0x1e0
|  mark_lock+0x50f/0x580
|  __lock_acquire+0x267/0x1100
|  lock_acquire+0xa6/0x1b0
|  _raw_spin_lock+0x2a/0x40
|  get_random_u32+0x3e/0xe0
|  new_slab+0x15c/0x7b0
|  ___slab_alloc+0x492/0x620
|  __slab_alloc.isra.73+0x53/0xa0
|  kmem_cache_alloc_trace+0x20e/0x270
|  ipmi_alloc_recv_msg+0x16/0x40
|  i_ipmi_request+0x51c/0xaa0
|  send_channel_info_cmd+0x80/0xa0
|  channel_handler+0xd1/0x160
|  deliver_response+0xd6/0x100
|  deliver_local_response+0x9/0x20
|  handle_one_recv_msg+0x11c/0x10b0
|  handle_new_recv_msgs+0x1b1/0x270
|  tasklet_action_common.isra.19+0x67/0x1d0
|  __do_softirq+0xec/0x48d
|  run_ksoftirqd+0x37/0x60
|  smpboot_thread_fn+0x191/0x290
|  kthread+0xfe/0x130
|  ret_from_fork+0x3a/0x50

I had also another backtrace with in-IRQ usage. Should I resend the
patch with spinlock_irq_save() instead?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6d1c0..6b0dce50c2b92 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2211,6 +2211,7 @@ struct batched_entropy {
 		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
 	};
 	unsigned int position;
+	spinlock_t lock;
 };
 static rwlock_t batched_entropy_reset_lock = __RW_LOCK_UNLOCKED(batched_entropy_reset_lock);
 
@@ -2222,7 +2223,10 @@ static rwlock_t batched_entropy_reset_lock = __RW_LOCK_UNLOCKED(batched_entropy_
  * wait_for_random_bytes() should be called and return 0 at least once
  * at any point prior.
  */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64);
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
+	.lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+};
+
 u64 get_random_u64(void)
 {
 	u64 ret;
@@ -2243,7 +2247,8 @@ u64 get_random_u64(void)
 	warn_unseeded_randomness(&previous);
 
 	use_lock = READ_ONCE(crng_init) < 2;
-	batch = &get_cpu_var(batched_entropy_u64);
+	batch = raw_cpu_ptr(&batched_entropy_u64);
+	spin_lock(&batch->lock);
 	if (use_lock)
 		read_lock_irqsave(&batched_entropy_reset_lock, flags);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
@@ -2253,12 +2258,14 @@ u64 get_random_u64(void)
 	ret = batch->entropy_u64[batch->position++];
 	if (use_lock)
 		read_unlock_irqrestore(&batched_entropy_reset_lock, flags);
-	put_cpu_var(batched_entropy_u64);
+	spin_unlock(&batch->lock);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
 
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32);
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
+	.lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+};
 u32 get_random_u32(void)
 {
 	u32 ret;
@@ -2273,7 +2280,8 @@ u32 get_random_u32(void)
 	warn_unseeded_randomness(&previous);
 
 	use_lock = READ_ONCE(crng_init) < 2;
-	batch = &get_cpu_var(batched_entropy_u32);
+	batch = raw_cpu_ptr(&batched_entropy_u32);
+	spin_lock(&batch->lock);
 	if (use_lock)
 		read_lock_irqsave(&batched_entropy_reset_lock, flags);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
@@ -2283,7 +2291,7 @@ u32 get_random_u32(void)
 	ret = batch->entropy_u32[batch->position++];
 	if (use_lock)
 		read_unlock_irqrestore(&batched_entropy_reset_lock, flags);
-	put_cpu_var(batched_entropy_u32);
+	spin_unlock(&batch->lock);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
-- 
2.11.0

