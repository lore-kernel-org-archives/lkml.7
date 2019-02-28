Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7A1218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374029;
	bh=n1IlhGhZUrEdmwpaze4xmIXnAuLxkGveQd6nCi910JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrBAk8dyWONPKLbPGSirWf1t6SguxFHMT8qRqElOU7K0cN1YhZdWwK+PgdDp2/GiO
	 5C6AtbccKnXjOmm47RUKGj8hSJ9vR9t1RdMqNH2P4BYL6yMP3/wZs2bZ9oDgA0cUYh
	 4szHp3FMzix8hzLPzu8lA1/Y11A5HmT00UdLePZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbfB1RNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbfB1RNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:44 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6764218E0;
        Thu, 28 Feb 2019 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374023;
        bh=n1IlhGhZUrEdmwpaze4xmIXnAuLxkGveQd6nCi910JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKt2u4+/485I4XzYUuyeRvZuKu5O8uLitYn9gv+3BUHHTyIMq2i5XCY+cdpMrCpI/
         5iT6o3t8zsFg6bTBDSNujP5kgDjN0BzI065cumT0gingprjoLBk3uIuD05DEJC/JUt
         oB65mALMdpOql4/86ilDP5xxJdEonoQLLQHjqpHU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 15/37] softirq: Pass softirq vector number to lockdep on vector execution
Date:   Thu, 28 Feb 2019 18:12:20 +0100
Message-Id: <20190228171242.32144-16-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the softirq vector number to lockdep on callback execution so that
we know which one is involved while holding a lock. We will then be able
to pick up the proper LOCK_USED_IN_*_SOFTIRQ index to perform the
finegrained verifications.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/irqflags.h | 12 ++++++------
 kernel/softirq.c         |  8 ++++----
 lib/locking-selftest.c   |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..623030a74866 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -43,13 +43,13 @@ do {						\
 do {						\
 	current->hardirq_context--;		\
 } while (0)
-# define lockdep_softirq_enter()		\
+# define lockdep_softirq_enter(__VEC)		\
 do {						\
-	current->softirq_context++;		\
+	current->softirq_context |= BIT(__VEC);	\
 } while (0)
-# define lockdep_softirq_exit()			\
+# define lockdep_softirq_exit(__VEC)		\
 do {						\
-	current->softirq_context--;		\
+	current->softirq_context &= ~BIT(__VEC);\
 } while (0)
 #else
 # define trace_hardirqs_on()		do { } while (0)
@@ -60,8 +60,8 @@ do {						\
 # define trace_softirqs_enabled(p)	0
 # define trace_hardirq_enter()		do { } while (0)
 # define trace_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
+# define lockdep_softirq_enter(vec)	do { } while (0)
+# define lockdep_softirq_exit(vec)	do { } while (0)
 #endif
 
 #if defined(CONFIG_IRQSOFF_TRACER) || \
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d28813306b2c..2dcaef813acb 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -229,18 +229,15 @@ static inline bool lockdep_softirq_start(void)
 		trace_hardirq_exit();
 	}
 
-	lockdep_softirq_enter();
-
 	return in_hardirq;
 }
 
 static inline void lockdep_softirq_end(bool in_hardirq)
 {
-	lockdep_softirq_exit();
-
 	if (in_hardirq)
 		trace_hardirq_enter();
 }
+
 #else
 static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
@@ -288,9 +285,12 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
+		lockdep_softirq_enter(vec_nr);
 		trace_softirq_entry(vec_nr);
 		h->action(h);
 		trace_softirq_exit(vec_nr);
+		lockdep_softirq_exit(vec_nr);
+
 		if (unlikely(prev_count != preempt_count())) {
 			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
 			       vec_nr, softirq_to_name[vec_nr], h->action,
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf171eca..2bd782d7f2e5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -197,11 +197,11 @@ static void init_shared_classes(void)
 #define SOFTIRQ_ENTER()				\
 		local_bh_disable();		\
 		local_irq_disable();		\
-		lockdep_softirq_enter();	\
+		lockdep_softirq_enter(0);	\
 		WARN_ON(!in_softirq());
 
 #define SOFTIRQ_EXIT()				\
-		lockdep_softirq_exit();		\
+		lockdep_softirq_exit(0);	\
 		local_irq_enable();		\
 		local_bh_enable();
 
-- 
2.21.0

