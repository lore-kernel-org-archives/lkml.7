Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF6C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B432084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbfHAWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:38:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389754AbfHAWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:38:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb2SR125196;
        Thu, 1 Aug 2019 18:37:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477ykns4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:49 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MbWDT126063;
        Thu, 1 Aug 2019 18:37:49 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477yknrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:48 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MZIQ5026850;
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w6n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:37:47 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MblaU44564954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20C26B207B;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7888B2075;
        Thu,  1 Aug 2019 22:37:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4D12316C9A36; Thu,  1 Aug 2019 15:37:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/12] rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()
Date:   Thu,  1 Aug 2019 15:37:38 -0700
Message-Id: <20190801223747.15560-3-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223708.GA14862@linux.ibm.com>
References: <20190801223708.GA14862@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010238
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
and Linus's commit 66be4e66a7f4 ("rcu: locking and unlocking need to
always be at least barriers"), this last of which restores the barrier()
call to both rcu_read_lock() and rcu_read_unlock().

This commit removes barrier() calls that are no longer needed given that
the addition of them in Linus's commit noted above.  The combination of
this commit and Linus's commit effectively reverts commit bb73c52bad36
("rcu: Don't disable preemption for Tiny and Tree RCU readers").

Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Fix embarrassing typo located by Alan Stern. ]
---
 .../RCU/Design/Requirements/Requirements.html | 71 +++++++++++++++++++
 kernel/rcu/tree_plugin.h                      | 11 ---
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 5a9238a2883c..f04c467e55c5 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2129,6 +2129,8 @@ Some of the relevant points of interest are as follows:
 <li>	<a href="#Hotplug CPU">Hotplug CPU</a>.
 <li>	<a href="#Scheduler and RCU">Scheduler and RCU</a>.
 <li>	<a href="#Tracing and RCU">Tracing and RCU</a>.
+<li>	<a href="#Accesses to User Memory and RCU">
+Accesses to User Memory and RCU</a>.
 <li>	<a href="#Energy Efficiency">Energy Efficiency</a>.
 <li>	<a href="#Scheduling-Clock Interrupts and RCU">
 	Scheduling-Clock Interrupts and RCU</a>.
@@ -2521,6 +2523,75 @@ cannot be used.
 The tracing folks both located the requirement and provided the
 needed fix, so this surprise requirement was relatively painless.
 
+<h3><a name="Accesses to User Memory and RCU">
+Accesses to User Memory and RCU</a></h3>
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
 
-- 
2.17.1

