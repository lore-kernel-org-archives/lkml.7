Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF48AC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE5025C4F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfE3PJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727603AbfE3PI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:08:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UF2DYC094883
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:08:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stepvhjkh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:08:55 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:08:54 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:08:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UF8kn423134604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:08:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3CC4B205F;
        Thu, 30 May 2019 15:08:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A37BB206C;
        Thu, 30 May 2019 15:08:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:08:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6730716C3620; Thu, 30 May 2019 08:08:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/4] rcu/sync: Kill rcu_sync_type/gp_type
Date:   Thu, 30 May 2019 08:08:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530150816.GA32130@linux.ibm.com>
References: <20190530150816.GA32130@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0072-0000-0000-000004354E9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210788; UDB=6.00636159; IPR=6.00991823;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:08:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0073-0000-0000-00004C6B664E
Message-Id: <20190530150846.32644-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

Now that the RCU flavors have been consolidated, rcu_sync_type makes no
sense because none of internal update functions aside from .held() depend
on gp_type.  This commit therefore removes this field and consolidates
the relevant code.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
[ paulmck: Added RCU and RCU-bh checks to rcu_sync_is_idle(). ]
[ paulmck: And applied subsequent feedback from Oleg Nesterov. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/percpu-rwsem.h  |  2 +-
 include/linux/rcu_sync.h      | 36 +++++++----------------
 kernel/locking/percpu-rwsem.c |  2 +-
 kernel/rcu/sync.c             | 55 ++++-------------------------------
 4 files changed, 17 insertions(+), 78 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 03cb4b6f842e..6887636ea169 100644
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
index 6fc53a1345b3..87971e85519c 100644
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
@@ -23,52 +21,38 @@ struct rcu_sync {
 
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
- * Returns true if readers are permitted to use their fastpaths.
- * Must be invoked within an RCU read-side critical section whose
- * flavor matches that of the rcu_sync struture.
+ * Returns true if readers are permitted to use their fastpaths.  Must be
+ * invoked within some flavor of RCU read-side critical section.
  */
 static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 {
-#ifdef CONFIG_PROVE_RCU
-	rcu_sync_lockdep_assert(rsp);
-#endif
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
+			 !rcu_read_lock_bh_held() &&
+			 !rcu_read_lock_sched_held(),
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
index f17dad99eec8..48cab93a47fd 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -17,7 +17,7 @@ int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 		return -ENOMEM;
 
 	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
-	rcu_sync_init(&sem->rss, RCU_SCHED_SYNC);
+	rcu_sync_init(&sem->rss);
 	__init_rwsem(&sem->rw_sem, name, rwsem_key);
 	rcuwait_init(&sem->writer);
 	sem->readers_block = 0;
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index a8304d90573f..ee427e138dad 100644
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
2.17.1

