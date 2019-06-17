Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F1CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfFQMsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:48:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfFQMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:48:06 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCs9W-1hlgkL024W-008tQ9; Mon, 17 Jun 2019 14:47:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yuyang Du <duyuyang@gmail.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Date:   Mon, 17 Jun 2019 14:47:05 +0200
Message-Id: <20190617124718.1232976-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9y9mDTsxENvvAM8tJ4M4IfThpqKKt6FNbAOAb3z9kaq1Y3sL3OS
 hlpz9zjdetpupz/6oZSAoDazr16jf55Zsw0klHg771w4S6nMakzkLmyDv13OPERf5lKLQfW
 Y8i8J3Z386siprFI+CknhXdsXx9brsUXEWcZmyXvvlLHbuLTsHbfZ2KYRol0AKeTn/8tK7o
 F2ponCwisZ+Rar3eWUcJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9pdLL28vOL0=:/fDOi4z8GeFSe3wg15BqIQ
 i2UNOf8LfzJE6nOfRPbOut7QDm3T0uAoaTKRV5zmoN6McZU/wsMsr4Vj4Htta89qn3wlOPnGI
 UkMRha8DbAWTQS8a3jZxqOecjD2d0VgvsHvhrtwUapWandS04e4bdjp5d9VnVqCFszyrex50z
 w2JUA2+MabisXj5S6SSJhgiXGiJQ48uOHyBtmKLwpHEVKxI/UrQlimMd0HDNBTfazgch+ZvdU
 DXrQfeq0/DKOMoJ9fM1CwYgRkZHEGjtOdjYnrfqN/tTAGQ/nK/jFv5jkIo+J1rNVe4t9aBDl7
 /gY0WhnX//ERIHiqowNGwyFiqWxr1d5DjWBjpQ51/9RPWA0VR7eJX54uKBa7t1UAzo0Q2KES5
 2sz8qiWfmBn4xiVxf1IPiSVpKHcu+1jHtJ4VpIFLIIuuPdaMSLfXO7AvBgHja4iAYL/a8hj6Y
 BcQAU4CCsLY9ND8l2BtgDtgItHzE697KJJDVcRJwHxMv8FoPSVMol1T8y3VxObG79kxPvhcgf
 kMKmSeBh5E5LIpCrwNpoT/jMiVAyDjOTNXac62HHDuibwTVON94cKYpLfC8KllRmaub4azPwv
 4uAT+r+8MKjYV2PsaVbVkWVyCKmTi69MMNJeLcG1USvY+V/lwX/5XjTdjJGu3SpiLbNH5d2OS
 NVbRJbqJeUDNFCVkxUsZUXZkHTlhuXTTV4CKSpuMKrqY9+wZGa4j/8dysNLV3mffAfbxs/M2E
 mx7gzQPvPRd2B4PpiIEjAUoMJCcHiNx4Cc2YfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last cleanup patch triggered another issue, as now another function
should be moved into the same section:

kernel/locking/lockdep.c:3580:12: error: 'mark_lock' defined but not used [-Werror=unused-function]
 static int mark_lock(struct task_struct *curr, struct held_lock *this,

Move mark_lock() into the same #ifdef section as its only caller, and
remove the now-unused mark_lock_irq() stub helper.

Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/locking/lockdep.c | 73 +++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48a840adb281..43e880ceafc2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -437,13 +437,6 @@ static int verbose(struct lock_class *class)
 	return 0;
 }
 
-/*
- * Stack-trace: tightly packed array of stack backtrace
- * addresses. Protected by the graph_lock.
- */
-unsigned long nr_stack_trace_entries;
-static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
-
 static void print_lockdep_off(const char *bug_msg)
 {
 	printk(KERN_DEBUG "%s\n", bug_msg);
@@ -453,6 +446,15 @@ static void print_lockdep_off(const char *bug_msg)
 #endif
 }
 
+unsigned long nr_stack_trace_entries;
+
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+/*
+ * Stack-trace: tightly packed array of stack backtrace
+ * addresses. Protected by the graph_lock.
+ */
+static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
+
 static int save_trace(struct lock_trace *trace)
 {
 	unsigned long *entries = stack_trace + nr_stack_trace_entries;
@@ -475,6 +477,7 @@ static int save_trace(struct lock_trace *trace)
 
 	return 1;
 }
+#endif
 
 unsigned int nr_hardirq_chains;
 unsigned int nr_softirq_chains;
@@ -488,6 +491,7 @@ unsigned int max_lockdep_depth;
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 #endif
 
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 /*
  * Locking printouts:
  */
@@ -505,6 +509,7 @@ static const char *usage_str[] =
 #undef LOCKDEP_STATE
 	[LOCK_USED] = "INITIAL USE",
 };
+#endif
 
 const char * __get_key_name(struct lockdep_subclass_key *key, char *str)
 {
@@ -2964,12 +2969,10 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit new_bit);
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
-
-
 static void print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
@@ -3545,35 +3548,6 @@ static int separate_irq_context(struct task_struct *curr,
 	return 0;
 }
 
-#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
-
-static inline
-int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
-{
-	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
-	return 1;
-}
-
-static inline int
-mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
-{
-	return 1;
-}
-
-static inline unsigned int task_irq_context(struct task_struct *task)
-{
-	return 0;
-}
-
-static inline int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
-{
-	return 0;
-}
-
-#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
-
 /*
  * Mark a lock with a usage bit, and validate the state transition:
  */
@@ -3634,6 +3608,27 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
+#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+
+static inline int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
+{
+	return 1;
+}
+
+static inline unsigned int task_irq_context(struct task_struct *task)
+{
+	return 0;
+}
+
+static inline int separate_irq_context(struct task_struct *curr,
+		struct held_lock *hlock)
+{
+	return 0;
+}
+
+#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-- 
2.20.0

