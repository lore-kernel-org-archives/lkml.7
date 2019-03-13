Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5A121019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCMXL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:11:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbfCMXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:11:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DN3RDT145936
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:11:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r78r5x4p3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:11:56 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Mar 2019 23:11:56 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 23:11:52 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DNBpUx17170480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 23:11:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC62B2064;
        Wed, 13 Mar 2019 23:11:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B4CDB2065;
        Wed, 13 Mar 2019 23:11:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 23:11:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6F4D516C3573; Wed, 13 Mar 2019 16:11:55 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:11:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eial Czerwacki <eial@scalemp.com>,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Reply-To: paulmck@linux.ibm.com
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
 <20190313212255.GY13351@linux.ibm.com>
 <20190313212912.GK50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313212912.GK50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031323-0060-0000-0000-0000031BEB5E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010753; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173969; UDB=6.00613841; IPR=6.00954633;
 MB=3.00025968; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-13 23:11:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031323-0061-0000-0000-00004899B998
Message-Id: <20190313231155.GC13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:29:12PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 13, 2019 at 02:22:55PM -0700, Paul E. McKenney wrote:
> > Should I define DEFINE_SRCU() and DEFINE_STATIC_SRCU() only if
> > !defined(MODULE)?
> 
> Yeah, that sounds like a great idea with comments explaining why it's
> like that.

Like this?

 * Build-time srcu_struct definition is not allowed in modules because
 * otherwise it is necessary to increase the size of the reserved region
 * each time a DEFINE_SRCU() or DEFINE_STATIC_SRCU() are added to a
 * kernel module.  Kernel modules should instead declare an srcu_struct
 * and then invoke init_srcu_struct() from their module_init function and
 * cleanup_srcu_struct() from their module_exit function.  Note that modules
 * using call_srcu() will also need to invoke srcu_barrier() from their
 * module_exit function.

Also, it looks like Barret beat me to this suggestion.  ;-)

In addition, rcutorture and rcuperf needed to be updated because
they used to use DEFINE_STATIC_STRUCT() whether built in or built
as a loadable module.

How does the (very lightly tested) patch below look to you all?

							Thanx, Paul

------------------------------------------------------------------------

commit 34f67df09cc0c6bf082a7cfca435373caeeb8d82
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Mar 13 16:06:22 2019 -0700

    srcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
    
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
index c29761152874..b44208b3bf95 100644
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
+	srcu_ctlp = &srcu_ctl_perf
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
@@ -238,24 +248,25 @@ static struct rcu_perf_ops srcu_ops = {
 	.exp_sync	= srcu_perf_synchronize_expedited,
 	.name		= "srcu"
 };
+#endif
 
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
@@ -265,7 +276,10 @@ static struct rcu_perf_ops srcud_ops = {
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
@@ -594,7 +608,11 @@ rcu_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+		&rcu_ops,
+#ifndef MODULE
+		&srcu_ops,
+#endif
+		&srcud_ops, &tasks_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
@@ -605,6 +623,11 @@ rcu_perf_init(void)
 		cur_ops = perf_ops[i];
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
index 5ff797fd3715..e4674c550b0f 100644
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
@@ -581,25 +592,25 @@ static struct rcu_torture_ops srcu_ops = {
 	.irq_capable	= 1,
 	.name		= "srcu"
 };
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
@@ -611,14 +622,17 @@ static struct rcu_torture_ops srcud_ops = {
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
@@ -2235,7 +2249,11 @@ rcu_torture_init(void)
 	int cpu;
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
-		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
+		&rcu_ops, &rcu_busted_ops,
+#ifndef MODULE
+		&srcu_ops,
+#endif
+		&srcud_ops,
 		&busted_srcud_ops, &tasks_ops,
 	};
 
@@ -2247,6 +2265,11 @@ rcu_torture_init(void)
 		cur_ops = torture_ops[i];
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

