Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11356C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44B7206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfDWMH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWMH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:07:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95E885F79C;
        Tue, 23 Apr 2019 12:07:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id C0DFBF3655;
        Tue, 23 Apr 2019 12:07:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Apr 2019 14:07:25 +0200 (CEST)
Date:   Tue, 23 Apr 2019 14:07:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/sync: kill rcu_sync_type/gp_type
Message-ID: <20190423120724.GA6132@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 23 Apr 2019 12:07:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the RCU flavors were consolidated rcu_sync_type makes no sense,
all internal update functions except .held() doesn't depend on gp_type.

The patch adds RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held()) into
rcu_sync_is_idle() because this matches its current user, but probably
we should simply remove this check or introduce rcu_read_lock_any_held().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/percpu-rwsem.h  |  2 +-
 include/linux/rcu_sync.h      | 32 ++++++-------------------
 kernel/locking/percpu-rwsem.c |  2 +-
 kernel/rcu/sync.c             | 55 ++++---------------------------------------
 4 files changed, 14 insertions(+), 77 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 03cb4b6..6887636 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -20,7 +20,7 @@ struct percpu_rw_semaphore {
 #define DEFINE_STATIC_PERCPU_RWSEM(name)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 static struct percpu_rw_semaphore name = {				\
-	.rss = __RCU_SYNC_INITIALIZER(name.rss, RCU_SCHED_SYNC),	\
+	.rss = __RCU_SYNC_INITIALIZER(name.rss),			\
 	.read_count = &__percpu_rwsem_rc_##name,			\
 	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 6fc53a1..e7ae221 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -13,8 +13,6 @@
 #include <linux/wait.h>
 #include <linux/rcupdate.h>
 
-enum rcu_sync_type { RCU_SYNC, RCU_SCHED_SYNC, RCU_BH_SYNC };
-
 /* Structure to mediate between updaters and fastpath-using readers.  */
 struct rcu_sync {
 	int			gp_state;
@@ -23,52 +21,36 @@ struct rcu_sync {
 
 	int			cb_state;
 	struct rcu_head		cb_head;
-
-	enum rcu_sync_type	gp_type;
 };
 
-extern void rcu_sync_lockdep_assert(struct rcu_sync *);
-
 /**
  * rcu_sync_is_idle() - Are readers permitted to use their fastpaths?
  * @rsp: Pointer to rcu_sync structure to use for synchronization
  *
  * Returns true if readers are permitted to use their fastpaths.
- * Must be invoked within an RCU read-side critical section whose
- * flavor matches that of the rcu_sync struture.
+ * Must be invoked within an RCU-sched read-side critical section.
  */
 static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 {
-#ifdef CONFIG_PROVE_RCU
-	rcu_sync_lockdep_assert(rsp);
-#endif
+	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+			 "suspicious rcu_sync_is_idle() usage");
 	return !rsp->gp_state; /* GP_IDLE */
 }
 
-extern void rcu_sync_init(struct rcu_sync *, enum rcu_sync_type);
+extern void rcu_sync_init(struct rcu_sync *);
 extern void rcu_sync_enter_start(struct rcu_sync *);
 extern void rcu_sync_enter(struct rcu_sync *);
 extern void rcu_sync_exit(struct rcu_sync *);
 extern void rcu_sync_dtor(struct rcu_sync *);
 
-#define __RCU_SYNC_INITIALIZER(name, type) {				\
+#define __RCU_SYNC_INITIALIZER(name) {					\
 		.gp_state = 0,						\
 		.gp_count = 0,						\
 		.gp_wait = __WAIT_QUEUE_HEAD_INITIALIZER(name.gp_wait),	\
 		.cb_state = 0,						\
-		.gp_type = type,					\
 	}
 
-#define	__DEFINE_RCU_SYNC(name, type)	\
-	struct rcu_sync_struct name = __RCU_SYNC_INITIALIZER(name, type)
-
-#define DEFINE_RCU_SYNC(name)		\
-	__DEFINE_RCU_SYNC(name, RCU_SYNC)
-
-#define DEFINE_RCU_SCHED_SYNC(name)	\
-	__DEFINE_RCU_SYNC(name, RCU_SCHED_SYNC)
-
-#define DEFINE_RCU_BH_SYNC(name)	\
-	__DEFINE_RCU_SYNC(name, RCU_BH_SYNC)
+#define	DEFINE_RCU_SYNC(name)	\
+	struct rcu_sync name = __RCU_SYNC_INITIALIZER(name)
 
 #endif /* _LINUX_RCU_SYNC_H_ */
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 883cf1b..3784812 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -15,7 +15,7 @@ int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 		return -ENOMEM;
 
 	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
-	rcu_sync_init(&sem->rss, RCU_SCHED_SYNC);
+	rcu_sync_init(&sem->rss);
 	__init_rwsem(&sem->rw_sem, name, rwsem_key);
 	rcuwait_init(&sem->writer);
 	sem->readers_block = 0;
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index a8304d9..ee427e1 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -10,65 +10,20 @@
 #include <linux/rcu_sync.h>
 #include <linux/sched.h>
 
-#ifdef CONFIG_PROVE_RCU
-#define __INIT_HELD(func)	.held = func,
-#else
-#define __INIT_HELD(func)
-#endif
-
-static const struct {
-	void (*sync)(void);
-	void (*call)(struct rcu_head *, void (*)(struct rcu_head *));
-	void (*wait)(void);
-#ifdef CONFIG_PROVE_RCU
-	int  (*held)(void);
-#endif
-} gp_ops[] = {
-	[RCU_SYNC] = {
-		.sync = synchronize_rcu,
-		.call = call_rcu,
-		.wait = rcu_barrier,
-		__INIT_HELD(rcu_read_lock_held)
-	},
-	[RCU_SCHED_SYNC] = {
-		.sync = synchronize_rcu,
-		.call = call_rcu,
-		.wait = rcu_barrier,
-		__INIT_HELD(rcu_read_lock_sched_held)
-	},
-	[RCU_BH_SYNC] = {
-		.sync = synchronize_rcu,
-		.call = call_rcu,
-		.wait = rcu_barrier,
-		__INIT_HELD(rcu_read_lock_bh_held)
-	},
-};
-
 enum { GP_IDLE = 0, GP_PENDING, GP_PASSED };
 enum { CB_IDLE = 0, CB_PENDING, CB_REPLAY };
 
 #define	rss_lock	gp_wait.lock
 
-#ifdef CONFIG_PROVE_RCU
-void rcu_sync_lockdep_assert(struct rcu_sync *rsp)
-{
-	RCU_LOCKDEP_WARN(!gp_ops[rsp->gp_type].held(),
-			 "suspicious rcu_sync_is_idle() usage");
-}
-
-EXPORT_SYMBOL_GPL(rcu_sync_lockdep_assert);
-#endif
-
 /**
  * rcu_sync_init() - Initialize an rcu_sync structure
  * @rsp: Pointer to rcu_sync structure to be initialized
  * @type: Flavor of RCU with which to synchronize rcu_sync structure
  */
-void rcu_sync_init(struct rcu_sync *rsp, enum rcu_sync_type type)
+void rcu_sync_init(struct rcu_sync *rsp)
 {
 	memset(rsp, 0, sizeof(*rsp));
 	init_waitqueue_head(&rsp->gp_wait);
-	rsp->gp_type = type;
 }
 
 /**
@@ -114,7 +69,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 
 	WARN_ON_ONCE(need_wait && need_sync);
 	if (need_sync) {
-		gp_ops[rsp->gp_type].sync();
+		synchronize_rcu();
 		rsp->gp_state = GP_PASSED;
 		wake_up_all(&rsp->gp_wait);
 	} else if (need_wait) {
@@ -167,7 +122,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
 		 * to catch a later GP.
 		 */
 		rsp->cb_state = CB_PENDING;
-		gp_ops[rsp->gp_type].call(&rsp->cb_head, rcu_sync_func);
+		call_rcu(&rsp->cb_head, rcu_sync_func);
 	} else {
 		/*
 		 * We're at least a GP after rcu_sync_exit(); eveybody will now
@@ -195,7 +150,7 @@ void rcu_sync_exit(struct rcu_sync *rsp)
 	if (!--rsp->gp_count) {
 		if (rsp->cb_state == CB_IDLE) {
 			rsp->cb_state = CB_PENDING;
-			gp_ops[rsp->gp_type].call(&rsp->cb_head, rcu_sync_func);
+			call_rcu(&rsp->cb_head, rcu_sync_func);
 		} else if (rsp->cb_state == CB_PENDING) {
 			rsp->cb_state = CB_REPLAY;
 		}
@@ -220,7 +175,7 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 	spin_unlock_irq(&rsp->rss_lock);
 
 	if (cb_state != CB_IDLE) {
-		gp_ops[rsp->gp_type].wait();
+		rcu_barrier();
 		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
 	}
 }
-- 
2.5.0


