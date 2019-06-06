Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE463C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37402070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfFFNU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:20:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFFNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:20:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56DJ5Kr004301
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 09:20:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy13ng4fa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:20:03 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Jun 2019 14:19:41 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 14:19:35 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56DJY6F17760646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 13:19:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF01B206A;
        Thu,  6 Jun 2019 13:19:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64458B2067;
        Thu,  6 Jun 2019 13:19:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.209.205])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 13:19:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D487816C5DEA; Thu,  6 Jun 2019 06:19:33 -0700 (PDT)
Date:   Thu, 6 Jun 2019 06:19:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        herbert@gondor.apana.org.au, torvalds@linux-foundation.org
Subject: [PATCH RFC tip/core/rcu] Restore barrier() to rcu_read_lock() and
 rcu_read_unlock()
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060613-0060-0000-0000-0000034D0301
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011223; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214064; UDB=6.00638153; IPR=6.00995143;
 MB=3.00027206; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-06 13:19:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060613-0061-0000-0000-000049A8C8CC
Message-Id: <20190606131933.GA12576@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bb73c52bad36 ("rcu: Don't disable preemption for Tiny and Tree
RCU readers") removed the barrier() calls from rcu_read_lock() and
rcu_write_lock() in CONFIG_PREEMPT=n&&CONFIG_PREEMPT_COUNT=n kernels.
Within RCU, this commit was OK, but it failed to account for things like
get_user() that can pagefault and that can be reordered by the compiler.
Lack of the barrier() calls in rcu_read_lock() and rcu_read_unlock()
can cause these page faults to migrate into RCU read-side critical
sections, which in CONFIG_PREEMPT=n kernels could result in too-short
grace periods and arbitrary misbehavior.  Please see commit 386afc91144b
("spinlocks and preemption points need to be at least compiler barriers")
for more details.

This commit therefore restores the barrier() call to both rcu_read_lock()
and rcu_read_unlock().  It also removes them from places in the RCU update
machinery that used to need compensatory barrier() calls, effectively
reverting commit bb73c52bad36 ("rcu: Don't disable preemption for Tiny
and Tree RCU readers").

Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 5a9238a2883c..080b39cc1dbb 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2129,6 +2129,8 @@ Some of the relevant points of interest are as follows:
 <li>	<a href="#Hotplug CPU">Hotplug CPU</a>.
 <li>	<a href="#Scheduler and RCU">Scheduler and RCU</a>.
 <li>	<a href="#Tracing and RCU">Tracing and RCU</a>.
+<li>	<a href="#Accesses to User Mamory and RCU">
+Accesses to User Mamory and RCU</a>.
 <li>	<a href="#Energy Efficiency">Energy Efficiency</a>.
 <li>	<a href="#Scheduling-Clock Interrupts and RCU">
 	Scheduling-Clock Interrupts and RCU</a>.
@@ -2521,6 +2523,75 @@ cannot be used.
 The tracing folks both located the requirement and provided the
 needed fix, so this surprise requirement was relatively painless.
 
+<h3><a name="Accesses to User Mamory and RCU">
+Accesses to User Mamory and RCU</a></h3>
+
+<p>
+The kernel needs to access user-space memory, for example, to access
+data referenced by system-call parameters.
+The <tt>get_user()</tt> macro does this job.
+
+<p>
+However, user-space memory might well be paged out, which means
+that <tt>get_user()</tt> might well page-fault and thus block while
+waiting for the resulting I/O to complete.
+It would be a very bad thing for the compiler to reorder
+a <tt>get_user()</tt> invocation into an RCU read-side critical
+section.
+For example, suppose that the source code looked like this:
+
+<blockquote>
+<pre>
+ 1 rcu_read_lock();
+ 2 p = rcu_dereference(gp);
+ 3 v = p-&gt;value;
+ 4 rcu_read_unlock();
+ 5 get_user(user_v, user_p);
+ 6 do_something_with(v, user_v);
+</pre>
+</blockquote>
+
+<p>
+The compiler must not be permitted to transform this source code into
+the following:
+
+<blockquote>
+<pre>
+ 1 rcu_read_lock();
+ 2 p = rcu_dereference(gp);
+ 3 get_user(user_v, user_p); // BUG: POSSIBLE PAGE FAULT!!!
+ 4 v = p-&gt;value;
+ 5 rcu_read_unlock();
+ 6 do_something_with(v, user_v);
+</pre>
+</blockquote>
+
+<p>
+If the compiler did make this transformation in a
+<tt>CONFIG_PREEMPT=n</tt> kernel build, and if <tt>get_user()</tt> did
+page fault, the result would be a quiescent state in the middle
+of an RCU read-side critical section.
+This misplaced quiescent state could result in line&nbsp;4 being
+a use-after-free access, which could be bad for your kernel's
+actuarial statistics.
+Similar examples can be constructed with the call to <tt>get_user()</tt>
+preceding the <tt>rcu_read_lock()</tt>.
+
+<p>
+Unfortunately, <tt>get_user()</tt> doesn't have any particular
+ordering properties, and in some architectures the underlying <tt>asm</tt>
+isn't even marked <tt>volatile</tt>.
+And even if it was marked <tt>volatile</tt>, the above access to
+<tt>p-&gt;value</tt> is not volatile, so the compiler would not have any
+reason to keep those two accesses in order.
+
+<p>
+Therefore, the Linux-kernel definitions of <tt>rcu_read_lock()</tt>
+and <tt>rcu_read_unlock()</tt> must act as compiler barriers,
+at least for outermost instances of <tt>rcu_read_lock()</tt> and
+<tt>rcu_read_unlock()</tt> within a nested set of RCU read-side critical
+sections.
+
 <h3><a name="Energy Efficiency">Energy Efficiency</a></h3>
 
 <p>
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0c9b92799abc..8f7167478c1d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -56,14 +56,12 @@ void __rcu_read_unlock(void);
 
 static inline void __rcu_read_lock(void)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		preempt_disable();
+	preempt_disable();
 }
 
 static inline void __rcu_read_unlock(void)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		preempt_enable();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index acb225023ed1..3f1b5041de9b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -288,7 +288,6 @@ void rcu_note_context_switch(bool preempt)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
 
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
@@ -340,7 +339,6 @@ void rcu_note_context_switch(bool preempt)
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
 	trace_rcu_utilization(TPS("End context switch"));
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
@@ -828,11 +826,6 @@ static void rcu_qs(void)
  * dyntick-idle quiescent state visible to other CPUs, which will in
  * some cases serve for expedited as well as normal grace periods.
  * Either way, register a lightweight quiescent state.
- *
- * The barrier() calls are redundant in the common case when this is
- * called externally, but just in case this is called from within this
- * file.
- *
  */
 void rcu_all_qs(void)
 {
@@ -847,14 +840,12 @@ void rcu_all_qs(void)
 		return;
 	}
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
 		rcu_momentary_dyntick_idle();
 		local_irq_restore(flags);
 	}
 	rcu_qs();
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(rcu_all_qs);
@@ -864,7 +855,6 @@ EXPORT_SYMBOL_GPL(rcu_all_qs);
  */
 void rcu_note_context_switch(bool preempt)
 {
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	rcu_qs();
 	/* Load rcu_urgent_qs before other flags. */
@@ -877,7 +867,6 @@ void rcu_note_context_switch(bool preempt)
 		rcu_tasks_qs(current);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 

