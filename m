Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12062C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA78521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDWTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:33:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbfDWTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:33:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NJUDFb060493
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:33:10 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s28wu031n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:33:10 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 20:33:09 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 20:33:08 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NJX7M833489054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 19:33:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE90CB2065;
        Tue, 23 Apr 2019 19:33:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB405B205F;
        Tue, 23 Apr 2019 19:33:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.223.68])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 19:33:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3DA1416C0C33; Tue, 23 Apr 2019 12:33:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:33:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/sync: kill rcu_sync_type/gp_type
Reply-To: paulmck@linux.ibm.com
References: <20190423120724.GA6132@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423120724.GA6132@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042319-0068-0000-0000-000003B8F89C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010982; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193355; UDB=6.00625576; IPR=6.00974176;
 MB=3.00026561; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 19:33:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042319-0069-0000-0000-00004843FA73
Message-Id: <20190423193306.GU3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:07:24PM +0200, Oleg Nesterov wrote:
> Now that the RCU flavors were consolidated rcu_sync_type makes no sense,
> all internal update functions except .held() doesn't depend on gp_type.
> 
> The patch adds RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held()) into
> rcu_sync_is_idle() because this matches its current user, but probably
> we should simply remove this check or introduce rcu_read_lock_any_held().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Nice simplification!  Queued for testing and review, thank you!

I wordsmithed the commit log and merged in the RCU-bh and RCU checks
to rcu_sync_is_idle(), with the result shown below.  Does that work
OK, or did I mess something up?

							Thanx, Paul

------------------------------------------------------------------------

commit cdf54c0ad9951b1f9de63fce5e53a947105b17db
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Tue Apr 23 14:07:24 2019 +0200

    rcu/sync: Kill rcu_sync_type/gp_type
    
    Now that the RCU flavors have been consolidated, rcu_sync_type makes no
    sense because none of internal update functions aside from .held() depend
    on gp_type.  This commit therefore removes this field and consolidates
    the relevant code.
    
    Signed-off-by: Oleg Nesterov <oleg@redhat.com>
    [ paulmck: Added RCU and RCU-bh checks to rcu_sync_is_idle(). ]
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

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
index 6fc53a1345b3..c3326e6c664d 100644
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
index 883cf1b92d90..37848127d50e 100644
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

