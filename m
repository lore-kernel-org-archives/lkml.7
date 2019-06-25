Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB2C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0964B215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ip/wsRJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfFYIqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:46:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:46:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8k8kS3535912
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:46:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8k8kS3535912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452369;
        bh=zWD0RszlywYoxCwhvgC52O1JPWIYLiOShSE1SjW60rs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ip/wsRJVVKkPzI0rBelkmmpJXXUDU3ywtfNdMtt4Ovvx5gXKhgIK4aOzLs/FS9m29
         e5hi143Qa5DE6UmtrKBdnoOvONoy97zGeohr4F9eDWsXPvAYeojRIxoJc4/c16oo3x
         AztbnevreC2vP7ymPrLnIoP/6/hPlmlzXx+TyPw+xEisz7wDBh/3URfBqG1wZGSIzd
         eml968QxMQZOGamYYHPU+rUsahk8dKKQuQUzso5BmWoezjCqMD7GfsXk34RVd89mjR
         5aknVg2Whz/vxuKiRYzQwYJn+fpRKJaWO8Ieol97KOk1qhyv7fe6/ek0poM5te0Cyy
         dkApEZ+oq9FdA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8k7Vb3535909;
        Tue, 25 Jun 2019 01:46:07 -0700
Date:   Tue, 25 Jun 2019 01:46:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-886532aee3cd42d95196601ed16d7c3d4679e9e5@git.kernel.org>
Cc:     mingo@kernel.org, frederic@kernel.org, longman@redhat.com,
        paulmck@linux.vnet.ibm.com, bvanassche@acm.org,
        will.deacon@arm.com, tglx@linutronix.de, duyuyang@gmail.com,
        arnd@arndb.de, torvalds@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: will.deacon@arm.com, tglx@linutronix.de, frederic@kernel.org,
          mingo@kernel.org, longman@redhat.com, bvanassche@acm.org,
          paulmck@linux.vnet.ibm.com, peterz@infradead.org,
          akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
          arnd@arndb.de, duyuyang@gmail.com, torvalds@linux-foundation.org,
          hpa@zytor.com
In-Reply-To: <20190617124718.1232976-1-arnd@arndb.de>
References: <20190617124718.1232976-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Move mark_lock() inside
 CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Git-Commit-ID: 886532aee3cd42d95196601ed16d7c3d4679e9e5
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

Commit-ID:  886532aee3cd42d95196601ed16d7c3d4679e9e5
Gitweb:     https://git.kernel.org/tip/886532aee3cd42d95196601ed16d7c3d4679e9e5
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 17 Jun 2019 14:47:05 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 25 Jun 2019 10:17:07 +0200

locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING

The last cleanup patch triggered another issue, as now another function
should be moved into the same section:

 kernel/locking/lockdep.c:3580:12: error: 'mark_lock' defined but not used [-Werror=unused-function]
  static int mark_lock(struct task_struct *curr, struct held_lock *this,

Move mark_lock() into the same #ifdef section as its only caller, and
remove the now-unused mark_lock_irq() stub helper.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yuyang Du <duyuyang@gmail.com>
Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
Link: https://lkml.kernel.org/r/20190617124718.1232976-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 73 ++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5e368f485330..341f52117f88 100644
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
