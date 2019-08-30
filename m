Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D8DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E6F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wzFlPK/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfH3Q0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:26:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40799 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3Q0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:26:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id w16so4952126pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M40HXfhf3xwJ1Orm+mXfqCiDTbdQrAOv8g4phHFgpG8=;
        b=wzFlPK/UqW537RvnpuNlJVlNhQG0rzh+oF5Tzgf2zOgAMW/lUuKWz/pixCQLDC+kIV
         IeLA9aTSrFokxF3M0C5NEb+rSXPDfqAlinrOjDShG9NIhI+fILlfsF86Nb8wHvlWQwSY
         gryCtgmULJlXN0OBXgK0ZS2KBVVlFDluWs88o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M40HXfhf3xwJ1Orm+mXfqCiDTbdQrAOv8g4phHFgpG8=;
        b=Dy+Y8LNKCry16pShjmSyjaqjs0mTzx/p1k0YhR8nUe9HWhGJw5cDOmbuqO/24+3wzx
         pgNZ9ZFifacAQl1pA7J1JcIHDsLM6VXNAQytnwI5CApw2y0pl7gQ4PxhM9l6IaWSbMC4
         LlcCGnQkwdl4MblFMsSPVuuC6znZQhwzMWL79b6LfD9lJGdnjlU3NJnItetB5X+vhu6k
         ozpu1j89mWspeJouWFknPIefgjjavfW+E/I7USgELQaAIigt9oRJNUoWqesYR4/Wvo4y
         789jZUVhPTdzgM/oG/TH9d28FGhIMQQjFNTMM3Ptn61dCeST6q0TWQtjXgtP6JbkjBKr
         YhPg==
X-Gm-Message-State: APjAAAWa3o4zh8+gDMCE+AmeZmY/caKDbn3v8nwKFSgL+nm3DK46LxKq
        9rF1RlPolVSPKA3XznehZBF482xEuPc=
X-Google-Smtp-Source: APXvYqwKfukrW1Ndrec24roSC3S0sPBY3iLY7gwIQIg/d4kRiKO56lE3QvAJTwwYzNveuPMi3g2S7w==
X-Received: by 2002:aa7:9495:: with SMTP id z21mr18979669pfk.220.1567182398761;
        Fri, 30 Aug 2019 09:26:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o3sm21012782pje.1.2019.08.30.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:26:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
Date:   Fri, 30 Aug 2019 12:26:27 -0400
Message-Id: <20190830162628.232306-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is unused and can be removed now. Revert was straightforward.

Tested with light rcutorture.

Link: http://lore.kernel.org/r/CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


---
Only made some commit message changes in this since v1.

 include/linux/rcutiny.h |  3 --
 kernel/rcu/tree.c       | 82 ++++++++++-------------------------------
 2 files changed, 19 insertions(+), 66 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b7607e2667ae..b3f689711289 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -14,9 +14,6 @@
 
 #include <asm/param.h> /* for HZ */
 
-/* Never flag non-existent other CPUs! */
-static inline bool rcu_eqs_special_set(int cpu) { return false; }
-
 static inline unsigned long get_state_synchronize_rcu(void)
 {
 	return 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68ebf0eb64c8..417dd00b9e87 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -69,20 +69,10 @@
 
 /* Data structures. */
 
-/*
- * Steal a bit from the bottom of ->dynticks for idle entry/exit
- * control.  Initially this is for TLB flushing.
- */
-#define RCU_DYNTICK_CTRL_MASK 0x1
-#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
-#ifndef rcu_eqs_special_exit
-#define rcu_eqs_special_exit() do { } while (0)
-#endif
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+	.dynticks = ATOMIC_INIT(1),
 };
 struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
@@ -229,20 +219,15 @@ void rcu_softirq_qs(void)
 static void rcu_dynticks_eqs_enter(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	int seq;
+	int special;
 
 	/*
-	 * CPUs seeing atomic_add_return() must see prior RCU read-side
+	 * CPUs seeing atomic_inc_return() must see prior RCU read-side
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	/* Better be in an extended quiescent state! */
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_CTR));
-	/* Better not have special action (TLB flush) pending! */
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_MASK));
+	special = atomic_inc_return(&rdp->dynticks);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && special & 0x1);
 }
 
 /*
@@ -252,22 +237,15 @@ static void rcu_dynticks_eqs_enter(void)
 static void rcu_dynticks_eqs_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	int seq;
+	int special;
 
 	/*
-	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
+	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     !(seq & RCU_DYNTICK_CTRL_CTR));
-	if (seq & RCU_DYNTICK_CTRL_MASK) {
-		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
-		smp_mb__after_atomic(); /* _exit after clearing mask. */
-		/* Prefer duplicate flushes to losing a flush. */
-		rcu_eqs_special_exit();
-	}
+	special = atomic_inc_return(&rdp->dynticks);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
 }
 
 /*
@@ -284,9 +262,9 @@ static void rcu_dynticks_eqs_online(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
+	if (atomic_read(&rdp->dynticks) & 0x1)
 		return;
-	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	atomic_add(0x1, &rdp->dynticks);
 }
 
 /*
@@ -298,7 +276,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
+	return !(atomic_read(&rdp->dynticks) & 0x1);
 }
 
 /*
@@ -309,7 +287,7 @@ int rcu_dynticks_snap(struct rcu_data *rdp)
 {
 	int snap = atomic_add_return(0, &rdp->dynticks);
 
-	return snap & ~RCU_DYNTICK_CTRL_MASK;
+	return snap;
 }
 
 /*
@@ -318,7 +296,7 @@ int rcu_dynticks_snap(struct rcu_data *rdp)
  */
 static bool rcu_dynticks_in_eqs(int snap)
 {
-	return !(snap & RCU_DYNTICK_CTRL_CTR);
+	return !(snap & 0x1);
 }
 
 /*
@@ -331,28 +309,6 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 	return snap != rcu_dynticks_snap(rdp);
 }
 
-/*
- * Set the special (bottom) bit of the specified CPU so that it
- * will take special action (such as flushing its TLB) on the
- * next exit from an extended quiescent state.  Returns true if
- * the bit was successfully set, or false if the CPU was not in
- * an extended quiescent state.
- */
-bool rcu_eqs_special_set(int cpu)
-{
-	int old;
-	int new;
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-
-	do {
-		old = atomic_read(&rdp->dynticks);
-		if (old & RCU_DYNTICK_CTRL_CTR)
-			return false;
-		new = old | RCU_DYNTICK_CTRL_MASK;
-	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
-	return true;
-}
-
 /*
  * Let the RCU core know that this CPU has gone through the scheduler,
  * which is a quiescent state.  This is called when the need for a
@@ -366,13 +322,13 @@ bool rcu_eqs_special_set(int cpu)
  */
 void rcu_momentary_dyntick_idle(void)
 {
-	int special;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	int special = atomic_add_return(2, &rdp->dynticks);
 
-	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
-				    &this_cpu_ptr(&rcu_data)->dynticks);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
+	WARN_ON_ONCE(!(special & 0x1));
+
+	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
-- 
2.23.0.187.g17f5b7556c-goog
