Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BBD20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbfJOTTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:19:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389490AbfJOTS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:59 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLB-00067i-W6; Tue, 15 Oct 2019 21:18:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH 26/34] Documentation/RCU: Use CONFIG_PREEMPTION where appropriate
Date:   Tue, 15 Oct 2019 21:18:13 +0200
Message-Id: <20191015191821.11479-27-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config option `CONFIG_PREEMPT' is used for the preemption model
"Low-Latency Desktop". The config option `CONFIG_PREEMPTION' is enabled
when kernel preemption is enabled which is true for the `CONFIG_PREEMPT'
and `CONFIG_PREEMPT_RT' preemption models.

Use `CONFIG_PREEMPTION' if it applies to both preemption models and not
just to `CONFIG_PREEMPT'.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../Expedited-Grace-Periods.html              |  8 +++----
 .../RCU/Design/Requirements/Requirements.html | 24 +++++++++----------
 Documentation/RCU/checklist.txt               |  4 ++--
 Documentation/RCU/rcubarrier.txt              |  8 +++----
 Documentation/RCU/stallwarn.txt               |  4 ++--
 Documentation/RCU/whatisRCU.txt               |  7 +++---
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Gra=
ce-Periods.html b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedite=
d-Grace-Periods.html
index 57300db4b5ff6..31c99382994e0 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Peri=
ods.html
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Peri=
ods.html
@@ -56,8 +56,8 @@ sections.
 RCU-preempt Expedited Grace Periods</a></h2>
=20
 <p>
-<tt>CONFIG_PREEMPT=3Dy</tt> kernels implement RCU-preempt.
-The overall flow of the handling of a given CPU by an RCU-preempt
+<tt>CONFIG_PREEMPT=3Dy</tt> and <tt>CONFIG_PREEMPT_RT=3Dy</tt> kernels imp=
lement
+RCU-preempt. The overall flow of the handling of a given CPU by an RCU-pre=
empt
 expedited grace period is shown in the following diagram:
=20
 <p><img src=3D"ExpRCUFlow.svg" alt=3D"ExpRCUFlow.svg" width=3D"55%">
@@ -140,8 +140,8 @@ or offline, among other things.
 RCU-sched Expedited Grace Periods</a></h2>
=20
 <p>
-<tt>CONFIG_PREEMPT=3Dn</tt> kernels implement RCU-sched.
-The overall flow of the handling of a given CPU by an RCU-sched
+<tt>CONFIG_PREEMPT=3Dn</tt> and <tt>CONFIG_PREEMPT_RT=3Dn</tt> kernels imp=
lement
+RCU-sched. The overall flow of the handling of a given CPU by an RCU-sched
 expedited grace period is shown in the following diagram:
=20
 <p><img src=3D"ExpSchedFlow.svg" alt=3D"ExpSchedFlow.svg" width=3D"55%">
diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Docu=
mentation/RCU/Design/Requirements/Requirements.html
index 467251f7fef69..348c5db1ff2bb 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -106,7 +106,7 @@ big RCU read-side critical section.
 Production-quality implementations of <tt>rcu_read_lock()</tt> and
 <tt>rcu_read_unlock()</tt> are extremely lightweight, and in
 fact have exactly zero overhead in Linux kernels built for production
-use with <tt>CONFIG_PREEMPT=3Dn</tt>.
+use with <tt>CONFIG_PREEMPTION=3Dn</tt>.
=20
 <p>
 This guarantee allows ordering to be enforced with extremely low
@@ -1499,7 +1499,7 @@ costs have plummeted.
 However, as I learned from Matt Mackall's
 <a href=3D"http://elinux.org/Linux_Tiny-FAQ">bloatwatch</a>
 efforts, memory footprint is critically important on single-CPU systems wi=
th
-non-preemptible (<tt>CONFIG_PREEMPT=3Dn</tt>) kernels, and thus
+non-preemptible (<tt>CONFIG_PREEMPTION=3Dn</tt>) kernels, and thus
 <a href=3D"https://lkml.kernel.org/g/20090113221724.GA15307@linux.vnet.ibm=
.com">tiny RCU</a>
 was born.
 Josh Triplett has since taken over the small-memory banner with his
@@ -1887,7 +1887,7 @@ constructs, there are limitations.
 <p>
 Implementations of RCU for which <tt>rcu_read_lock()</tt>
 and <tt>rcu_read_unlock()</tt> generate no code, such as
-Linux-kernel RCU when <tt>CONFIG_PREEMPT=3Dn</tt>, can be
+Linux-kernel RCU when <tt>CONFIG_PREEMPTION=3Dn</tt>, can be
 nested arbitrarily deeply.
 After all, there is no overhead.
 Except that if all these instances of <tt>rcu_read_lock()</tt>
@@ -2229,7 +2229,7 @@ be a no-op.
 <p>
 However, once the scheduler has spawned its first kthread, this early
 boot trick fails for <tt>synchronize_rcu()</tt> (as well as for
-<tt>synchronize_rcu_expedited()</tt>) in <tt>CONFIG_PREEMPT=3Dy</tt>
+<tt>synchronize_rcu_expedited()</tt>) in <tt>CONFIG_PREEMPTION=3Dy</tt>
 kernels.
 The reason is that an RCU read-side critical section might be preempted,
 which means that a subsequent <tt>synchronize_rcu()</tt> really does have
@@ -2568,7 +2568,7 @@ The compiler must not be permitted to transform this =
source code into
=20
 <p>
 If the compiler did make this transformation in a
-<tt>CONFIG_PREEMPT=3Dn</tt> kernel build, and if <tt>get_user()</tt> did
+<tt>CONFIG_PREEMPTION=3Dn</tt> kernel build, and if <tt>get_user()</tt> did
 page fault, the result would be a quiescent state in the middle
 of an RCU read-side critical section.
 This misplaced quiescent state could result in line&nbsp;4 being
@@ -2906,7 +2906,7 @@ in conjunction with the
 The real-time-latency response requirements are such that the
 traditional approach of disabling preemption across RCU
 read-side critical sections is inappropriate.
-Kernels built with <tt>CONFIG_PREEMPT=3Dy</tt> therefore
+Kernels built with <tt>CONFIG_PREEMPTION=3Dy</tt> therefore
 use an RCU implementation that allows RCU read-side critical
 sections to be preempted.
 This requirement made its presence known after users made it
@@ -3064,7 +3064,7 @@ includes
 <tt>rcu_barrier_bh()</tt>, and
 <tt>rcu_read_lock_bh_held()</tt>.
 However, the update-side APIs are now simple wrappers for other RCU
-flavors, namely RCU-sched in CONFIG_PREEMPT=3Dn kernels and RCU-preempt
+flavors, namely RCU-sched in CONFIG_PREEMPTION=3Dn kernels and RCU-preempt
 otherwise.
=20
 <h3><a name=3D"Sched Flavor">Sched Flavor (Historical)</a></h3>
@@ -3088,12 +3088,12 @@ of an RCU read-side critical section can be a quies=
cent state.
 Therefore, <i>RCU-sched</i> was created, which follows &ldquo;classic&rdqu=
o;
 RCU in that an RCU-sched grace period waits for for pre-existing
 interrupt and NMI handlers.
-In kernels built with <tt>CONFIG_PREEMPT=3Dn</tt>, the RCU and RCU-sched
+In kernels built with <tt>CONFIG_PREEMPTION=3Dn</tt>, the RCU and RCU-sched
 APIs have identical implementations, while kernels built with
-<tt>CONFIG_PREEMPT=3Dy</tt> provide a separate implementation for each.
+<tt>CONFIG_PREEMPTION=3Dy</tt> provide a separate implementation for each.
=20
 <p>
-Note well that in <tt>CONFIG_PREEMPT=3Dy</tt> kernels,
+Note well that in <tt>CONFIG_PREEMPTION=3Dy</tt> kernels,
 <tt>rcu_read_lock_sched()</tt> and <tt>rcu_read_unlock_sched()</tt>
 disable and re-enable preemption, respectively.
 This means that if there was a preemption attempt during the
@@ -3302,12 +3302,12 @@ The tasks-RCU API is quite compact, consisting only=
 of
 <tt>call_rcu_tasks()</tt>,
 <tt>synchronize_rcu_tasks()</tt>, and
 <tt>rcu_barrier_tasks()</tt>.
-In <tt>CONFIG_PREEMPT=3Dn</tt> kernels, trampolines cannot be preempted,
+In <tt>CONFIG_PREEMPTION=3Dn</tt> kernels, trampolines cannot be preempted,
 so these APIs map to
 <tt>call_rcu()</tt>,
 <tt>synchronize_rcu()</tt>, and
 <tt>rcu_barrier()</tt>, respectively.
-In <tt>CONFIG_PREEMPT=3Dy</tt> kernels, trampolines can be preempted,
+In <tt>CONFIG_PREEMPTION=3Dy</tt> kernels, trampolines can be preempted,
 and these three APIs are therefore implemented by separate functions
 that check for voluntary context switches.
=20
diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.=
txt
index e98ff261a438b..087dc6c22c37c 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -210,8 +210,8 @@ over a rather long period of time, but improvements are=
 always welcome!
 	the rest of the system.
=20
 7.	As of v4.20, a given kernel implements only one RCU flavor,
-	which is RCU-sched for PREEMPT=3Dn and RCU-preempt for PREEMPT=3Dy.
-	If the updater uses call_rcu() or synchronize_rcu(),
+	which is RCU-sched for PREEMPTION=3Dn and RCU-preempt for
+	PREEMPTION=3Dy. If the updater uses call_rcu() or synchronize_rcu(),
 	then the corresponding readers my use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
 	or any pair of primitives that disables and re-enables preemption,
diff --git a/Documentation/RCU/rcubarrier.txt b/Documentation/RCU/rcubarrie=
r.txt
index a2782df697328..5aa93c215af46 100644
--- a/Documentation/RCU/rcubarrier.txt
+++ b/Documentation/RCU/rcubarrier.txt
@@ -6,8 +6,8 @@ RCU (read-copy update) is a synchronization mechanism that =
can be thought
 of as a replacement for read-writer locking (among other things), but with
 very low-overhead readers that are immune to deadlock, priority inversion,
 and unbounded latency. RCU read-side critical sections are delimited
-by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPT
-kernels, generate no code whatsoever.
+by rcu_read_lock() and rcu_read_unlock(), which, in
+non-CONFIG_PREEMPTION kernels, generate no code whatsoever.
=20
 This means that RCU writers are unaware of the presence of concurrent
 readers, so that RCU updates to shared data must be undertaken quite
@@ -303,10 +303,10 @@ Answer: This cannot happen. The reason is that on_eac=
h_cpu() has its last
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of
 	rcu_barrier_func() has completed. This by itself would prevent
-	a grace period from completing on non-CONFIG_PREEMPT kernels,
+	a grace period from completing on non-CONFIG_PREEMPTION kernels,
 	since each CPU must undergo a context switch (or other quiescent
 	state) before the grace period can complete. However, this is
-	of no use in CONFIG_PREEMPT kernels.
+	of no use in CONFIG_PREEMPTION kernels.
=20
 	Therefore, on_each_cpu() disables preemption across its call
 	to smp_call_function() and also across the local call to
diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.=
txt
index f48f4621ccbc2..bd510771b75ec 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -20,7 +20,7 @@ o	A CPU looping with preemption disabled.
=20
 o	A CPU looping with bottom halves disabled.
=20
-o	For !CONFIG_PREEMPT kernels, a CPU looping anywhere in the kernel
+o	For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the kernel
 	without invoking schedule().  If the looping in the kernel is
 	really expected and desirable behavior, you might need to add
 	some calls to cond_resched().
@@ -39,7 +39,7 @@ o	Anything that prevents RCU's grace-period kthreads from=
 running.
 	result in the "rcu_.*kthread starved for" console-log message,
 	which will include additional debugging information.
=20
-o	A CPU-bound real-time task in a CONFIG_PREEMPT kernel, which might
+o	A CPU-bound real-time task in a CONFIG_PREEMPTION kernel, which might
 	happen to preempt a low-priority task in the middle of an RCU
 	read-side critical section.   This is especially damaging if
 	that low-priority task is not permitted to run on any other CPU,
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.=
txt
index 7e1a8721637ab..7e03e8f80b293 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -648,9 +648,10 @@ Quick Quiz #1:	Why is this argument naive?  How could =
a deadlock
=20
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
-on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
-kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
-are the same as those shown in the preceding section, so they are omitted.
+on features such as hotplug CPU and the ability to run in
+CONFIG_PREEMPTION kernels. The definitions of rcu_dereference() and
+rcu_assign_pointer() are the same as those shown in the preceding
+section, so they are omitted.
=20
 	void rcu_read_lock(void) { }
=20
--=20
2.23.0

