Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E19FC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1C20869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbfKFXIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45501 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKFXIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:07 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPE-0004iq-K7; Thu, 07 Nov 2019 00:08:04 +0100
Message-Id: <20191106224556.049705556@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:36 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [patch 02/12] futex: Move futex exit handling into futex code
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The futex exit handling is #ifdeffed into mm_release() which is not pretty
to begin with. But upcoming changes to address futex exit races need to add
more functionality to this exit code.

Split it out into a function, move it into futex code and make the various
futex exit functions static.

Preparatory only and no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/compat.h |    2 --
 include/linux/futex.h  |   27 ++++++++++++++-------------
 kernel/fork.c          |   25 +++----------------------
 kernel/futex.c         |   33 +++++++++++++++++++++++++++++----
 4 files changed, 46 insertions(+), 41 deletions(-)

--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -410,8 +410,6 @@ struct compat_kexec_segment;
 struct compat_mq_attr;
 struct compat_msgbuf;
 
-extern void compat_exit_robust_list(struct task_struct *curr);
-
 #define BITS_PER_COMPAT_LONG    (8*sizeof(compat_long_t))
 
 #define BITS_TO_COMPAT_LONGS(bits) DIV_ROUND_UP(bits, BITS_PER_COMPAT_LONG)
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -48,15 +48,24 @@ union futex_key {
 #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = NULL } }
 
 #ifdef CONFIG_FUTEX
-extern void exit_robust_list(struct task_struct *curr);
 
-long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
-	      u32 __user *uaddr2, u32 val2, u32 val3);
-#else
-static inline void exit_robust_list(struct task_struct *curr)
+static inline void futex_init_task(struct task_struct *tsk)
 {
+	tsk->robust_list = NULL;
+#ifdef CONFIG_COMPAT
+	tsk->compat_robust_list = NULL;
+#endif
+	INIT_LIST_HEAD(&tsk->pi_state_list);
+	tsk->pi_state_cache = NULL;
 }
 
+void futex_mm_release(struct task_struct *tsk);
+
+long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
+	      u32 __user *uaddr2, u32 val2, u32 val3);
+#else
+static inline void futex_init_task(struct task_struct *tsk) { }
+static inline void futex_mm_release(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
@@ -65,12 +74,4 @@ static inline long do_futex(u32 __user *
 }
 #endif
 
-#ifdef CONFIG_FUTEX_PI
-extern void exit_pi_state_list(struct task_struct *curr);
-#else
-static inline void exit_pi_state_list(struct task_struct *curr)
-{
-}
-#endif
-
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1286,20 +1286,7 @@ static int wait_for_vfork_done(struct ta
 void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	/* Get rid of any futexes when releasing the mm */
-#ifdef CONFIG_FUTEX
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
-		tsk->robust_list = NULL;
-	}
-#ifdef CONFIG_COMPAT
-	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
-		tsk->compat_robust_list = NULL;
-	}
-#endif
-	if (unlikely(!list_empty(&tsk->pi_state_list)))
-		exit_pi_state_list(tsk);
-#endif
+	futex_mm_release(tsk);
 
 	uprobe_free_utask(tsk);
 
@@ -2062,14 +2049,8 @@ static __latent_entropy struct task_stru
 #ifdef CONFIG_BLOCK
 	p->plug = NULL;
 #endif
-#ifdef CONFIG_FUTEX
-	p->robust_list = NULL;
-#ifdef CONFIG_COMPAT
-	p->compat_robust_list = NULL;
-#endif
-	INIT_LIST_HEAD(&p->pi_state_list);
-	p->pi_state_cache = NULL;
-#endif
+	futex_init_task(p);
+
 	/*
 	 * sigaltstack should be cleared when sharing the same VM
 	 */
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -325,6 +325,12 @@ static inline bool should_fail_futex(boo
 }
 #endif /* CONFIG_FAIL_FUTEX */
 
+#ifdef CONFIG_COMPAT
+static void compat_exit_robust_list(struct task_struct *curr);
+#else
+static inline void compat_exit_robust_list(struct task_struct *curr) { }
+#endif
+
 static inline void futex_get_mm(union futex_key *key)
 {
 	mmgrab(key->private.mm);
@@ -890,7 +896,7 @@ static void put_pi_state(struct futex_pi
  * Kernel cleans up PI-state, but userspace is likely hosed.
  * (Robust-futex cleanup is separate and might save the day for userspace.)
  */
-void exit_pi_state_list(struct task_struct *curr)
+static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head = &curr->pi_state_list;
 	struct futex_pi_state *pi_state;
@@ -960,7 +966,8 @@ void exit_pi_state_list(struct task_stru
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
 }
-
+#else
+static inline void exit_pi_state_list(struct task_struct *curr) { }
 #endif
 
 /*
@@ -3588,7 +3595,7 @@ static inline int fetch_robust_entry(str
  *
  * We silently return on any sign of list-walking problem.
  */
-void exit_robust_list(struct task_struct *curr)
+static void exit_robust_list(struct task_struct *curr)
 {
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
@@ -3653,6 +3660,24 @@ void exit_robust_list(struct task_struct
 	}
 }
 
+void futex_mm_release(struct task_struct *tsk)
+{
+	if (unlikely(tsk->robust_list)) {
+		exit_robust_list(tsk);
+		tsk->robust_list = NULL;
+	}
+
+	if (IS_ENABLED(CONFIG_COMPAT)) {
+		if (unlikely(tsk->compat_robust_list)) {
+			compat_exit_robust_list(tsk);
+			tsk->compat_robust_list = NULL;
+		}
+	}
+
+	if (unlikely(!list_empty(&tsk->pi_state_list)))
+		exit_pi_state_list(tsk);
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
@@ -3780,7 +3805,7 @@ static void __user *futex_uaddr(struct r
  *
  * We silently return on any sign of list-walking problem.
  */
-void compat_exit_robust_list(struct task_struct *curr)
+static void compat_exit_robust_list(struct task_struct *curr)
 {
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;


