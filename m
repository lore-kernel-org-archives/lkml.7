Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCFAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9372120857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfDBO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:29:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731348AbfDBO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:29:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32ETfAl096207
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 10:29:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm880n22s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:29:44 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Apr 2019 15:29:36 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 15:29:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32ETTWX13631498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 14:29:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE54CB2065;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F45EB2068;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 14:29:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9AE1716C2E20; Tue,  2 Apr 2019 07:29:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 4/4] rcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
Date:   Tue,  2 Apr 2019 07:29:33 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402142816.GA13084@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040214-2213-0000-0000-0000036F7012
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010860; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183284; UDB=6.00619477; IPR=6.00964032;
 MB=3.00026260; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 14:29:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040214-2214-0000-0000-00005DE07E5D
Message-Id: <20190402142933.14547-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module
requires that the size of the reserved region be increased, which is
not something we want to be doing all that often.  Instead, loadable
modules should define an srcu_struct and invoke init_srcu_struct()
from their module_init function and cleanup_srcu_struct() from their
module_exit function.  Note that modules using call_srcu() will also
need to invoke srcu_barrier() from their module_exit function.

This commit enforces this advice by refusing to define DEFINE_SRCU()
and DEFINE_STATIC_SRCU() within loadable modules.

Suggested-by: Barret Rhoden <brho@google.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Looks-great-to-me-by: Tejun Heo <tj@kernel.org>
---
 include/linux/srcutree.h | 19 ++++++++++++----
 kernel/rcu/rcuperf.c     | 40 ++++++++++++++++++++++++++-------
 kernel/rcu/rcutorture.c  | 48 ++++++++++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 24 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 7f7c8c050f63..ac5ea1c72e97 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -105,6 +105,15 @@ struct srcu_struct {
  * Define and initialize a srcu struct at build time.
  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
  *
+ * Build-time srcu_struct definition is not allowed in modules because
+ * otherwise it is necessary to increase the size of the reserved region
+ * each time a DEFINE_SRCU() or DEFINE_STATIC_SRCU() are added to a
+ * kernel module.  Kernel modules should instead declare an srcu_struct
+ * and then invoke init_srcu_struct() from their module_init function and
+ * cleanup_srcu_struct() from their module_exit function.  Note that modules
+ * using call_srcu() will also need to invoke srcu_barrier() from their
+ * module_exit function.
+ *
  * Note that although DEFINE_STATIC_SRCU() hides the name from other
  * files, the per-CPU variable rules nevertheless require that the
  * chosen name be globally unique.  These rules also prohibit use of
@@ -120,11 +129,13 @@ struct srcu_struct {
  *
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
  */
-#define __DEFINE_SRCU(name, is_static)					\
-	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
+#ifndef MODULE
+#  define __DEFINE_SRCU(name, is_static)				\
+	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
 	is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
-#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
-#define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
+#  define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
+#  define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
+#endif
 
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b23c5f..8b24b1c929b0 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -139,6 +139,7 @@ struct rcu_perf_ops {
 	void (*sync)(void);
 	void (*exp_sync)(void);
 	const char *name;
+	const char *altname;
 };
 
 static struct rcu_perf_ops *cur_ops;
@@ -186,8 +187,16 @@ static struct rcu_perf_ops rcu_ops = {
  * Definitions for srcu perf testing.
  */
 
+static struct srcu_struct *srcu_ctlp;
+
+#ifndef MODULE
 DEFINE_STATIC_SRCU(srcu_ctl_perf);
-static struct srcu_struct *srcu_ctlp = &srcu_ctl_perf;
+
+static void srcu_sync_perf_init(void)
+{
+	srcu_ctlp = &srcu_ctl_perf;
+}
+#endif
 
 static int srcu_perf_read_lock(void) __acquires(srcu_ctlp)
 {
@@ -224,9 +233,10 @@ static void srcu_perf_synchronize_expedited(void)
 	synchronize_srcu_expedited(srcu_ctlp);
 }
 
+#ifndef MODULE
 static struct rcu_perf_ops srcu_ops = {
 	.ptype		= SRCU_FLAVOR,
-	.init		= rcu_sync_perf_init,
+	.init		= srcu_sync_perf_init,
 	.readlock	= srcu_perf_read_lock,
 	.readunlock	= srcu_perf_read_unlock,
 	.get_gp_seq	= srcu_perf_completed,
@@ -238,24 +248,28 @@ static struct rcu_perf_ops srcu_ops = {
 	.exp_sync	= srcu_perf_synchronize_expedited,
 	.name		= "srcu"
 };
+#define SRCU_OPS (&srcu_ops)
+#else /* #ifndef MODULE */
+#define SRCU_OPS NULL
+#endif /* #else #ifndef MODULE */
 
 static struct srcu_struct srcud;
 
-static void srcu_sync_perf_init(void)
+static void srcud_sync_perf_init(void)
 {
 	srcu_ctlp = &srcud;
 	init_srcu_struct(srcu_ctlp);
 }
 
-static void srcu_sync_perf_cleanup(void)
+static void srcud_sync_perf_cleanup(void)
 {
 	cleanup_srcu_struct(srcu_ctlp);
 }
 
 static struct rcu_perf_ops srcud_ops = {
 	.ptype		= SRCU_FLAVOR,
-	.init		= srcu_sync_perf_init,
-	.cleanup	= srcu_sync_perf_cleanup,
+	.init		= srcud_sync_perf_init,
+	.cleanup	= srcud_sync_perf_cleanup,
 	.readlock	= srcu_perf_read_lock,
 	.readunlock	= srcu_perf_read_unlock,
 	.get_gp_seq	= srcu_perf_completed,
@@ -265,7 +279,10 @@ static struct rcu_perf_ops srcud_ops = {
 	.gp_barrier	= srcu_rcu_barrier,
 	.sync		= srcu_perf_synchronize,
 	.exp_sync	= srcu_perf_synchronize_expedited,
-	.name		= "srcud"
+	.name		= "srcud",
+#ifndef MODULE
+	.altname	= "srcu" /* Avoid breaking kbuild test robot. */
+#endif
 };
 
 /*
@@ -598,7 +615,7 @@ rcu_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+		&rcu_ops, SRCU_OPS, &srcud_ops, &tasks_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
@@ -607,8 +624,15 @@ rcu_perf_init(void)
 	/* Process args and tell the world that the perf'er is on the job. */
 	for (i = 0; i < ARRAY_SIZE(perf_ops); i++) {
 		cur_ops = perf_ops[i];
+		if (!cur_ops)
+			continue;
 		if (strcmp(perf_type, cur_ops->name) == 0)
 			break;
+		if (cur_ops->altname &&
+		    strcmp(perf_type, cur_ops->altname) == 0) {
+			pr_alert("rcu-perf: substituting perf type: \"%s\" for \"%s\"\n", cur_ops->name, perf_type);
+			break;
+		}
 	}
 	if (i == ARRAY_SIZE(perf_ops)) {
 		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efaa5b3f4d3f..af31ddee7b36 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -300,6 +300,7 @@ struct rcu_torture_ops {
 	int can_boost;
 	int extendables;
 	const char *name;
+	const char *altname;
 };
 
 static struct rcu_torture_ops *cur_ops;
@@ -496,9 +497,18 @@ static struct rcu_torture_ops rcu_busted_ops = {
  * Definitions for srcu torture testing.
  */
 
-DEFINE_STATIC_SRCU(srcu_ctl);
 static struct srcu_struct srcu_ctld;
-static struct srcu_struct *srcu_ctlp = &srcu_ctl;
+static struct srcu_struct *srcu_ctlp;
+
+#ifndef MODULE
+DEFINE_STATIC_SRCU(srcu_ctl);
+
+static void srcu_torture_init(void)
+{
+	rcu_sync_torture_init();
+	srcu_ctlp = &srcu_ctl;
+}
+#endif
 
 static int srcu_torture_read_lock(void) __acquires(srcu_ctlp)
 {
@@ -565,9 +575,10 @@ static void srcu_torture_synchronize_expedited(void)
 	synchronize_srcu_expedited(srcu_ctlp);
 }
 
+#ifndef MODULE
 static struct rcu_torture_ops srcu_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= rcu_sync_torture_init,
+	.init		= srcu_torture_init,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
@@ -581,25 +592,28 @@ static struct rcu_torture_ops srcu_ops = {
 	.irq_capable	= 1,
 	.name		= "srcu"
 };
+#define SRCU_OPS (&srcu_ops)
+#else /* #ifndef MODULE */
+#define SRCU_OPS NULL
+#endif
 
-static void srcu_torture_init(void)
+static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
 	WARN_ON(init_srcu_struct(&srcu_ctld));
 	srcu_ctlp = &srcu_ctld;
 }
 
-static void srcu_torture_cleanup(void)
+static void srcud_torture_cleanup(void)
 {
 	cleanup_srcu_struct(&srcu_ctld);
-	srcu_ctlp = &srcu_ctl; /* In case of a later rcutorture run. */
 }
 
 /* As above, but dynamically allocated. */
 static struct rcu_torture_ops srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
-	.cleanup	= srcu_torture_cleanup,
+	.init		= srcud_torture_init,
+	.cleanup	= srcud_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
@@ -611,14 +625,17 @@ static struct rcu_torture_ops srcud_ops = {
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
 	.irq_capable	= 1,
-	.name		= "srcud"
+	.name		= "srcud",
+#ifndef MODULE
+	.altname	= "srcu" /* Avoid breaking kbuild test robot. */
+#endif
 };
 
 /* As above, but broken due to inappropriate reader extension. */
 static struct rcu_torture_ops busted_srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
-	.cleanup	= srcu_torture_cleanup,
+	.init		= srcud_torture_init,
+	.cleanup	= srcud_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
@@ -2239,7 +2256,7 @@ rcu_torture_init(void)
 	int cpu;
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
-		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
+		&rcu_ops, &rcu_busted_ops, SRCU_OPS, &srcud_ops,
 		&busted_srcud_ops, &tasks_ops,
 	};
 
@@ -2249,8 +2266,15 @@ rcu_torture_init(void)
 	/* Process args and tell the world that the torturer is on the job. */
 	for (i = 0; i < ARRAY_SIZE(torture_ops); i++) {
 		cur_ops = torture_ops[i];
+		if (!cur_ops)
+			continue;
 		if (strcmp(torture_type, cur_ops->name) == 0)
 			break;
+		if (cur_ops->altname &&
+		    strcmp(torture_type, cur_ops->altname) == 0) {
+			pr_alert("rcu-torture: substituting torture type: \"%s\" for \"%s\"\n", cur_ops->name, torture_type);
+			break;
+		}
 	}
 	if (i == ARRAY_SIZE(torture_ops)) {
 		pr_alert("rcu-torture: invalid torture type: \"%s\"\n",
-- 
2.17.1

