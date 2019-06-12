Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12CBC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD1421744
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362044;
	bh=si4mMdgTk4GVVzTXALR+L88eOHilkKvVWPs4TbvLr4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k8jaE0iW3JTiZAnCGPwQ8U9qMebTzH1q/sv5D6L50DQrrbXpVjxyg5WBrCpFZXiky
	 TSKKTIuZrqeLCToaR6Mqn51Dqr56SJ+/a0GAXYAeNZFZ1s07BebA5O2zVz4A4+rjcW
	 lZkb1SxxGIv9KmtrPp8r1ev/CNKtfCJYuKKsC2QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfFLRyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:54:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbfFLRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=abL5ZX7qmzeE/2L66oNqI3If9VXSAUhO3BltLAiDXwM=; b=DSR2QRp92Rq6fBOxjlP2ROSTNn
        Crn8OthJzyYcooKy0O7jDykzd7revUosVS+MxG4JDN4efdGAHRzVUXBePEKCCxNWTkOtz2vRb0KQn
        ahBDvx9mKnTMzqrJGqwvJJd8bd4/2aNdx5YO3HABM6knOX1KcH6PYUX7Dqq5/vXEjBmEcf3lAUwOC
        mH5TFbCe1wZtDiEJotM6xFCWhtavdxfWmmbQ7891qtcNj+me7JpBWQe/0jNJdvRlMZ4wkG7jP+yft
        D4vtsCQFwoClkhlPf931CIKt0A4Xie+RQUSSEG082cvT4U78J01HeN6+uavg5KvyMNffJSiSKOCdf
        +Sw7ylUg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qx-0002Dq-Ne; Wed, 12 Jun 2019 17:53:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001hi-Oy; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 27/28] docs: scheduler: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:53:03 -0300
Message-Id: <ce9ca0101ef402821bb7b69e500b8662b87ca725.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare to add them to the Kernel API book,
convert the files to ReST format.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-uids   |   2 +-
 .../{completion.txt => completion.rst}        |  38 +--
 Documentation/scheduler/index.rst             |  29 ++
 .../{sched-arch.txt => sched-arch.rst}        |  18 +-
 .../{sched-bwc.txt => sched-bwc.rst}          |  30 +-
 ...{sched-deadline.txt => sched-deadline.rst} | 295 +++++++++---------
 ...ed-design-CFS.txt => sched-design-CFS.rst} |  15 +-
 .../{sched-domains.txt => sched-domains.rst}  |   8 +-
 .../{sched-energy.txt => sched-energy.rst}    |  47 +--
 ...-nice-design.txt => sched-nice-design.rst} |   6 +-
 ...{sched-rt-group.txt => sched-rt-group.rst} |  28 +-
 .../{sched-stats.txt => sched-stats.rst}      |  35 ++-
 Documentation/scheduler/text_files.rst        |   5 +
 Documentation/vm/numa.rst                     |   2 +-
 init/Kconfig                                  |   6 +-
 kernel/sched/deadline.c                       |   2 +-
 16 files changed, 332 insertions(+), 234 deletions(-)
 rename Documentation/scheduler/{completion.txt => completion.rst} (94%)
 create mode 100644 Documentation/scheduler/index.rst
 rename Documentation/scheduler/{sched-arch.txt => sched-arch.rst} (81%)
 rename Documentation/scheduler/{sched-bwc.txt => sched-bwc.rst} (90%)
 rename Documentation/scheduler/{sched-deadline.txt => sched-deadline.rst} (88%)
 rename Documentation/scheduler/{sched-design-CFS.txt => sched-design-CFS.rst} (97%)
 rename Documentation/scheduler/{sched-domains.txt => sched-domains.rst} (97%)
 rename Documentation/scheduler/{sched-energy.txt => sched-energy.rst} (96%)
 rename Documentation/scheduler/{sched-nice-design.txt => sched-nice-design.rst} (98%)
 rename Documentation/scheduler/{sched-rt-group.txt => sched-rt-group.rst} (95%)
 rename Documentation/scheduler/{sched-stats.txt => sched-stats.rst} (91%)
 create mode 100644 Documentation/scheduler/text_files.rst

diff --git a/Documentation/ABI/testing/sysfs-kernel-uids b/Documentation/ABI/testing/sysfs-kernel-uids
index 28f14695a852..4182b7061816 100644
--- a/Documentation/ABI/testing/sysfs-kernel-uids
+++ b/Documentation/ABI/testing/sysfs-kernel-uids
@@ -11,4 +11,4 @@ Description:
 		example would be, if User A has shares = 1024 and user
 		B has shares = 2048, User B will get twice the CPU
 		bandwidth user A will. For more details refer
-		Documentation/scheduler/sched-design-CFS.txt
+		Documentation/scheduler/sched-design-CFS.rst
diff --git a/Documentation/scheduler/completion.txt b/Documentation/scheduler/completion.rst
similarity index 94%
rename from Documentation/scheduler/completion.txt
rename to Documentation/scheduler/completion.rst
index e5b9df4d8078..9f039b4f4b09 100644
--- a/Documentation/scheduler/completion.txt
+++ b/Documentation/scheduler/completion.rst
@@ -1,3 +1,4 @@
+================================================
 Completions - "wait for completion" barrier APIs
 ================================================
 
@@ -46,7 +47,7 @@ it has to wait for it.
 
 To use completions you need to #include <linux/completion.h> and
 create a static or dynamic variable of type 'struct completion',
-which has only two fields:
+which has only two fields::
 
 	struct completion {
 		unsigned int done;
@@ -57,7 +58,7 @@ This provides the ->wait waitqueue to place tasks on for waiting (if any), and
 the ->done completion flag for indicating whether it's completed or not.
 
 Completions should be named to refer to the event that is being synchronized on.
-A good example is:
+A good example is::
 
 	wait_for_completion(&early_console_added);
 
@@ -81,7 +82,7 @@ have taken place, even if these wait functions return prematurely due to a timeo
 or a signal triggering.
 
 Initializing of dynamically allocated completion objects is done via a call to
-init_completion():
+init_completion()::
 
 	init_completion(&dynamic_object->done);
 
@@ -100,7 +101,8 @@ but be aware of other races.
 
 For static declaration and initialization, macros are available.
 
-For static (or global) declarations in file scope you can use DECLARE_COMPLETION():
+For static (or global) declarations in file scope you can use
+DECLARE_COMPLETION()::
 
 	static DECLARE_COMPLETION(setup_done);
 	DECLARE_COMPLETION(setup_done);
@@ -111,7 +113,7 @@ initialized to 'not done' and doesn't require an init_completion() call.
 When a completion is declared as a local variable within a function,
 then the initialization should always use DECLARE_COMPLETION_ONSTACK()
 explicitly, not just to make lockdep happy, but also to make it clear
-that limited scope had been considered and is intentional:
+that limited scope had been considered and is intentional::
 
 	DECLARE_COMPLETION_ONSTACK(setup_done)
 
@@ -140,11 +142,11 @@ Waiting for completions:
 ------------------------
 
 For a thread to wait for some concurrent activity to finish, it
-calls wait_for_completion() on the initialized completion structure:
+calls wait_for_completion() on the initialized completion structure::
 
 	void wait_for_completion(struct completion *done)
 
-A typical usage scenario is:
+A typical usage scenario is::
 
 	CPU#1					CPU#2
 
@@ -192,17 +194,17 @@ A common problem that occurs is to have unclean assignment of return types,
 so take care to assign return-values to variables of the proper type.
 
 Checking for the specific meaning of return values also has been found
-to be quite inaccurate, e.g. constructs like:
+to be quite inaccurate, e.g. constructs like::
 
 	if (!wait_for_completion_interruptible_timeout(...))
 
 ... would execute the same code path for successful completion and for the
-interrupted case - which is probably not what you want.
+interrupted case - which is probably not what you want::
 
 	int wait_for_completion_interruptible(struct completion *done)
 
 This function marks the task TASK_INTERRUPTIBLE while it is waiting.
-If a signal was received while waiting it will return -ERESTARTSYS; 0 otherwise.
+If a signal was received while waiting it will return -ERESTARTSYS; 0 otherwise::
 
 	unsigned long wait_for_completion_timeout(struct completion *done, unsigned long timeout)
 
@@ -214,7 +216,7 @@ Timeouts are preferably calculated with msecs_to_jiffies() or usecs_to_jiffies()
 to make the code largely HZ-invariant.
 
 If the returned timeout value is deliberately ignored a comment should probably explain
-why (e.g. see drivers/mfd/wm8350-core.c wm8350_read_auxadc()).
+why (e.g. see drivers/mfd/wm8350-core.c wm8350_read_auxadc())::
 
 	long wait_for_completion_interruptible_timeout(struct completion *done, unsigned long timeout)
 
@@ -225,14 +227,14 @@ jiffies if completion occurred.
 
 Further variants include _killable which uses TASK_KILLABLE as the
 designated tasks state and will return -ERESTARTSYS if it is interrupted,
-or 0 if completion was achieved.  There is a _timeout variant as well:
+or 0 if completion was achieved.  There is a _timeout variant as well::
 
 	long wait_for_completion_killable(struct completion *done)
 	long wait_for_completion_killable_timeout(struct completion *done, unsigned long timeout)
 
 The _io variants wait_for_completion_io() behave the same as the non-_io
 variants, except for accounting waiting time as 'waiting on IO', which has
-an impact on how the task is accounted in scheduling/IO stats:
+an impact on how the task is accounted in scheduling/IO stats::
 
 	void wait_for_completion_io(struct completion *done)
 	unsigned long wait_for_completion_io_timeout(struct completion *done, unsigned long timeout)
@@ -243,11 +245,11 @@ Signaling completions:
 
 A thread that wants to signal that the conditions for continuation have been
 achieved calls complete() to signal exactly one of the waiters that it can
-continue:
+continue::
 
 	void complete(struct completion *done)
 
-... or calls complete_all() to signal all current and future waiters:
+... or calls complete_all() to signal all current and future waiters::
 
 	void complete_all(struct completion *done)
 
@@ -268,7 +270,7 @@ probably are a design bug.
 
 Signaling completion from IRQ context is fine as it will appropriately
 lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never
-sleep. 
+sleep.
 
 
 try_wait_for_completion()/completion_done():
@@ -276,14 +278,14 @@ try_wait_for_completion()/completion_done():
 
 The try_wait_for_completion() function will not put the thread on the wait
 queue but rather returns false if it would need to enqueue (block) the thread,
-else it consumes one posted completion and returns true.
+else it consumes one posted completion and returns true::
 
 	bool try_wait_for_completion(struct completion *done)
 
 Finally, to check the state of a completion without changing it in any way,
 call completion_done(), which returns false if there are no posted
 completions that were not yet consumed by waiters (implying that there are
-waiters) and true otherwise;
+waiters) and true otherwise::
 
 	bool completion_done(struct completion *done)
 
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
new file mode 100644
index 000000000000..058be77a4c34
--- /dev/null
+++ b/Documentation/scheduler/index.rst
@@ -0,0 +1,29 @@
+:orphan:
+
+===============
+Linux Scheduler
+===============
+
+.. toctree::
+    :maxdepth: 1
+
+
+    completion
+    sched-arch
+    sched-bwc
+    sched-deadline
+    sched-design-CFS
+    sched-domains
+    sched-energy
+    sched-nice-design
+    sched-rt-group
+    sched-stats
+
+    text_files
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/scheduler/sched-arch.txt b/Documentation/scheduler/sched-arch.rst
similarity index 81%
rename from Documentation/scheduler/sched-arch.txt
rename to Documentation/scheduler/sched-arch.rst
index a2f27bbf2cba..0eaec669790a 100644
--- a/Documentation/scheduler/sched-arch.txt
+++ b/Documentation/scheduler/sched-arch.rst
@@ -1,4 +1,6 @@
-	CPU Scheduler implementation hints for architecture specific code
+=================================================================
+CPU Scheduler implementation hints for architecture specific code
+=================================================================
 
 	Nick Piggin, 2005
 
@@ -35,9 +37,10 @@ Your cpu_idle routines need to obey the following rules:
 4. The only time interrupts need to be disabled when checking
    need_resched is if we are about to sleep the processor until
    the next interrupt (this doesn't provide any protection of
-   need_resched, it prevents losing an interrupt).
+   need_resched, it prevents losing an interrupt):
+
+	4a. Common problem with this type of sleep appears to be::
 
-	4a. Common problem with this type of sleep appears to be:
 	        local_irq_disable();
 	        if (!need_resched()) {
 	                local_irq_enable();
@@ -51,10 +54,10 @@ Your cpu_idle routines need to obey the following rules:
    although it may be reasonable to do some background work or enter
    a low CPU priority.
 
-   	5a. If TIF_POLLING_NRFLAG is set, and we do decide to enter
-	    an interrupt sleep, it needs to be cleared then a memory
-	    barrier issued (followed by a test of need_resched with
-	    interrupts disabled, as explained in 3).
+      - 5a. If TIF_POLLING_NRFLAG is set, and we do decide to enter
+	an interrupt sleep, it needs to be cleared then a memory
+	barrier issued (followed by a test of need_resched with
+	interrupts disabled, as explained in 3).
 
 arch/x86/kernel/process.c has examples of both polling and
 sleeping idle functions.
@@ -71,4 +74,3 @@ sh64 - Is sleeping racy vs interrupts? (See #4a)
 
 sparc - IRQs on at this point(?), change local_irq_save to _disable.
       - TODO: needs secondary CPUs to disable preempt (See #1)
-
diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.rst
similarity index 90%
rename from Documentation/scheduler/sched-bwc.txt
rename to Documentation/scheduler/sched-bwc.rst
index f6b1873f68ab..3a9064219656 100644
--- a/Documentation/scheduler/sched-bwc.txt
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -1,8 +1,9 @@
+=====================
 CFS Bandwidth Control
 =====================
 
 [ This document only discusses CPU bandwidth control for SCHED_NORMAL.
-  The SCHED_RT case is covered in Documentation/scheduler/sched-rt-group.txt ]
+  The SCHED_RT case is covered in Documentation/scheduler/sched-rt-group.rst ]
 
 CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
 specification of the maximum CPU bandwidth available to a group or hierarchy.
@@ -27,7 +28,8 @@ cpu.cfs_quota_us: the total available run-time within a period (in microseconds)
 cpu.cfs_period_us: the length of a period (in microseconds)
 cpu.stat: exports throttling statistics [explained further below]
 
-The default values are:
+The default values are::
+
 	cpu.cfs_period_us=100ms
 	cpu.cfs_quota=-1
 
@@ -55,7 +57,8 @@ For efficiency run-time is transferred between the global pool and CPU local
 on large systems.  The amount transferred each time such an update is required
 is described as the "slice".
 
-This is tunable via procfs:
+This is tunable via procfs::
+
 	/proc/sys/kernel/sched_cfs_bandwidth_slice_us (default=5ms)
 
 Larger slice values will reduce transfer overheads, while smaller values allow
@@ -66,6 +69,7 @@ Statistics
 A group's bandwidth statistics are exported via 3 fields in cpu.stat.
 
 cpu.stat:
+
 - nr_periods: Number of enforcement intervals that have elapsed.
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
@@ -78,12 +82,15 @@ Hierarchical considerations
 The interface enforces that an individual entity's bandwidth is always
 attainable, that is: max(c_i) <= C. However, over-subscription in the
 aggregate case is explicitly allowed to enable work-conserving semantics
-within a hierarchy.
+within a hierarchy:
+
   e.g. \Sum (c_i) may exceed C
+
 [ Where C is the parent's bandwidth, and c_i its children ]
 
 
 There are two ways in which a group may become throttled:
+
 	a. it fully consumes its own quota within a period
 	b. a parent's quota is fully consumed within its period
 
@@ -92,7 +99,7 @@ be allowed to until the parent's runtime is refreshed.
 
 Examples
 --------
-1. Limit a group to 1 CPU worth of runtime.
+1. Limit a group to 1 CPU worth of runtime::
 
 	If period is 250ms and quota is also 250ms, the group will get
 	1 CPU worth of runtime every 250ms.
@@ -100,10 +107,10 @@ Examples
 	# echo 250000 > cpu.cfs_quota_us /* quota = 250ms */
 	# echo 250000 > cpu.cfs_period_us /* period = 250ms */
 
-2. Limit a group to 2 CPUs worth of runtime on a multi-CPU machine.
+2. Limit a group to 2 CPUs worth of runtime on a multi-CPU machine
 
-	With 500ms period and 1000ms quota, the group can get 2 CPUs worth of
-	runtime every 500ms.
+   With 500ms period and 1000ms quota, the group can get 2 CPUs worth of
+   runtime every 500ms::
 
 	# echo 1000000 > cpu.cfs_quota_us /* quota = 1000ms */
 	# echo 500000 > cpu.cfs_period_us /* period = 500ms */
@@ -112,11 +119,10 @@ Examples
 
 3. Limit a group to 20% of 1 CPU.
 
-	With 50ms period, 10ms quota will be equivalent to 20% of 1 CPU.
+   With 50ms period, 10ms quota will be equivalent to 20% of 1 CPU::
 
 	# echo 10000 > cpu.cfs_quota_us /* quota = 10ms */
 	# echo 50000 > cpu.cfs_period_us /* period = 50ms */
 
-	By using a small period here we are ensuring a consistent latency
-	response at the expense of burst capacity.
-
+   By using a small period here we are ensuring a consistent latency
+   response at the expense of burst capacity.
diff --git a/Documentation/scheduler/sched-deadline.txt b/Documentation/scheduler/sched-deadline.rst
similarity index 88%
rename from Documentation/scheduler/sched-deadline.txt
rename to Documentation/scheduler/sched-deadline.rst
index a7514343b660..3391e86d810c 100644
--- a/Documentation/scheduler/sched-deadline.txt
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -1,29 +1,29 @@
-			  Deadline Task Scheduling
-			  ------------------------
+========================
+Deadline Task Scheduling
+========================
 
-CONTENTS
-========
+.. CONTENTS
 
- 0. WARNING
- 1. Overview
- 2. Scheduling algorithm
-   2.1 Main algorithm
-   2.2 Bandwidth reclaiming
- 3. Scheduling Real-Time Tasks
-   3.1 Definitions
-   3.2 Schedulability Analysis for Uniprocessor Systems
-   3.3 Schedulability Analysis for Multiprocessor Systems
-   3.4 Relationship with SCHED_DEADLINE Parameters
- 4. Bandwidth management
-   4.1 System-wide settings
-   4.2 Task interface
-   4.3 Default behavior
-   4.4 Behavior of sched_yield()
- 5. Tasks CPU affinity
-   5.1 SCHED_DEADLINE and cpusets HOWTO
- 6. Future plans
- A. Test suite
- B. Minimal main()
+    0. WARNING
+    1. Overview
+    2. Scheduling algorithm
+      2.1 Main algorithm
+      2.2 Bandwidth reclaiming
+    3. Scheduling Real-Time Tasks
+      3.1 Definitions
+      3.2 Schedulability Analysis for Uniprocessor Systems
+      3.3 Schedulability Analysis for Multiprocessor Systems
+      3.4 Relationship with SCHED_DEADLINE Parameters
+    4. Bandwidth management
+      4.1 System-wide settings
+      4.2 Task interface
+      4.3 Default behavior
+      4.4 Behavior of sched_yield()
+    5. Tasks CPU affinity
+      5.1 SCHED_DEADLINE and cpusets HOWTO
+    6. Future plans
+    A. Test suite
+    B. Minimal main()
 
 
 0. WARNING
@@ -44,7 +44,7 @@ CONTENTS
 
 
 2. Scheduling algorithm
-==================
+=======================
 
 2.1 Main algorithm
 ------------------
@@ -80,7 +80,7 @@ CONTENTS
     a "remaining runtime". These two parameters are initially set to 0;
 
   - When a SCHED_DEADLINE task wakes up (becomes ready for execution),
-    the scheduler checks if
+    the scheduler checks if::
 
                  remaining runtime                  runtime
         ----------------------------------    >    ---------
@@ -97,7 +97,7 @@ CONTENTS
     left unchanged;
 
   - When a SCHED_DEADLINE task executes for an amount of time t, its
-    remaining runtime is decreased as
+    remaining runtime is decreased as::
 
          remaining runtime = remaining runtime - t
 
@@ -112,7 +112,7 @@ CONTENTS
 
   - When the current time is equal to the replenishment time of a
     throttled task, the scheduling deadline and the remaining runtime are
-    updated as
+    updated as::
 
          scheduling deadline = scheduling deadline + period
          remaining runtime = remaining runtime + runtime
@@ -129,7 +129,7 @@ CONTENTS
  Reclamation of Unused Bandwidth) algorithm [15, 16, 17] and it is enabled
  when flag SCHED_FLAG_RECLAIM is set.
 
- The following diagram illustrates the state names for tasks handled by GRUB:
+ The following diagram illustrates the state names for tasks handled by GRUB::
 
                              ------------
                  (d)        |   Active   |
@@ -168,7 +168,7 @@ CONTENTS
       breaking the real-time guarantees.
 
       The 0-lag time for a task entering the ActiveNonContending state is
-      computed as
+      computed as::
 
                         (runtime * dl_period)
              deadline - ---------------------
@@ -183,7 +183,7 @@ CONTENTS
       the task's utilization must be removed from the previous runqueue's active
       utilization and must be added to the new runqueue's active utilization.
       In order to avoid races between a task waking up on a runqueue while the
-       "inactive timer" is running on a different CPU, the "dl_non_contending"
+      "inactive timer" is running on a different CPU, the "dl_non_contending"
       flag is used to indicate that a task is not on a runqueue but is active
       (so, the flag is set when the task blocks and is cleared when the
       "inactive timer" fires or when the task  wakes up).
@@ -222,36 +222,36 @@ CONTENTS
 
 
  Let's now see a trivial example of two deadline tasks with runtime equal
- to 4 and period equal to 8 (i.e., bandwidth equal to 0.5):
+ to 4 and period equal to 8 (i.e., bandwidth equal to 0.5)::
 
-     A            Task T1
-     |
-     |                               |
-     |                               |
-     |--------                       |----
-     |       |                       V
-     |---|---|---|---|---|---|---|---|--------->t
-     0   1   2   3   4   5   6   7   8
+         A            Task T1
+         |
+         |                               |
+         |                               |
+         |--------                       |----
+         |       |                       V
+         |---|---|---|---|---|---|---|---|--------->t
+         0   1   2   3   4   5   6   7   8
 
 
-     A            Task T2
-     |
-     |                               |
-     |                               |
-     |       ------------------------|
-     |       |                       V
-     |---|---|---|---|---|---|---|---|--------->t
-     0   1   2   3   4   5   6   7   8
+         A            Task T2
+         |
+         |                               |
+         |                               |
+         |       ------------------------|
+         |       |                       V
+         |---|---|---|---|---|---|---|---|--------->t
+         0   1   2   3   4   5   6   7   8
 
 
-     A            running_bw
-     |
-   1 -----------------               ------
-     |               |               |
-  0.5-               -----------------
-     |                               |
-     |---|---|---|---|---|---|---|---|--------->t
-     0   1   2   3   4   5   6   7   8
+         A            running_bw
+         |
+       1 -----------------               ------
+         |               |               |
+      0.5-               -----------------
+         |                               |
+         |---|---|---|---|---|---|---|---|--------->t
+         0   1   2   3   4   5   6   7   8
 
 
   - Time t = 0:
@@ -284,7 +284,7 @@ CONTENTS
 
 
 2.3 Energy-aware scheduling
-------------------------
+---------------------------
 
  When cpufreq's schedutil governor is selected, SCHED_DEADLINE implements the
  GRUB-PA [19] algorithm, reducing the CPU operating frequency to the minimum
@@ -299,15 +299,20 @@ CONTENTS
 3. Scheduling Real-Time Tasks
 =============================
 
- * BIG FAT WARNING ******************************************************
- *
- * This section contains a (not-thorough) summary on classical deadline
- * scheduling theory, and how it applies to SCHED_DEADLINE.
- * The reader can "safely" skip to Section 4 if only interested in seeing
- * how the scheduling policy can be used. Anyway, we strongly recommend
- * to come back here and continue reading (once the urge for testing is
- * satisfied :P) to be sure of fully understanding all technical details.
- ************************************************************************
+
+
+ ..  BIG FAT WARNING ******************************************************
+
+ .. warning::
+
+   This section contains a (not-thorough) summary on classical deadline
+   scheduling theory, and how it applies to SCHED_DEADLINE.
+   The reader can "safely" skip to Section 4 if only interested in seeing
+   how the scheduling policy can be used. Anyway, we strongly recommend
+   to come back here and continue reading (once the urge for testing is
+   satisfied :P) to be sure of fully understanding all technical details.
+
+ .. ************************************************************************
 
  There are no limitations on what kind of task can exploit this new
  scheduling discipline, even if it must be said that it is particularly
@@ -329,6 +334,7 @@ CONTENTS
  sporadic with minimum inter-arrival time P is r_{j+1} >= r_j + P. Finally,
  d_j = r_j + D, where D is the task's relative deadline.
  Summing up, a real-time task can be described as
+
 	Task = (WCET, D, P)
 
  The utilization of a real-time task is defined as the ratio between its
@@ -352,13 +358,15 @@ CONTENTS
  between the finishing time of a job and its absolute deadline).
  More precisely, it can be proven that using a global EDF scheduler the
  maximum tardiness of each task is smaller or equal than
+
 	((M − 1) · WCET_max − WCET_min)/(M − (M − 2) · U_max) + WCET_max
+
  where WCET_max = max{WCET_i} is the maximum WCET, WCET_min=min{WCET_i}
  is the minimum WCET, and U_max = max{WCET_i/P_i} is the maximum
  utilization[12].
 
 3.2 Schedulability Analysis for Uniprocessor Systems
-------------------------
+----------------------------------------------------
 
  If M=1 (uniprocessor system), or in case of partitioned scheduling (each
  real-time task is statically assigned to one and only one CPU), it is
@@ -370,7 +378,9 @@ CONTENTS
  a task as WCET_i/min{D_i,P_i}, and EDF is able to respect all the deadlines
  of all the tasks running on a CPU if the sum of the densities of the tasks
  running on such a CPU is smaller or equal than 1:
+
 	sum(WCET_i / min{D_i, P_i}) <= 1
+
  It is important to notice that this condition is only sufficient, and not
  necessary: there are task sets that are schedulable, but do not respect the
  condition. For example, consider the task set {Task_1,Task_2} composed by
@@ -379,7 +389,9 @@ CONTENTS
  (Task_1 is scheduled as soon as it is released, and finishes just in time
  to respect its deadline; Task_2 is scheduled immediately after Task_1, hence
  its response time cannot be larger than 50ms + 10ms = 60ms) even if
+
 	50 / min{50,100} + 10 / min{100, 100} = 50 / 50 + 10 / 100 = 1.1
+
  Of course it is possible to test the exact schedulability of tasks with
  D_i != P_i (checking a condition that is both sufficient and necessary),
  but this cannot be done by comparing the total utilization or density with
@@ -399,7 +411,7 @@ CONTENTS
  4 Linux uses an admission test based on the tasks' utilizations.
 
 3.3 Schedulability Analysis for Multiprocessor Systems
-------------------------
+------------------------------------------------------
 
  On multiprocessor systems with global EDF scheduling (non partitioned
  systems), a sufficient test for schedulability can not be based on the
@@ -428,7 +440,9 @@ CONTENTS
  between total utilization (or density) and a fixed constant. If all tasks
  have D_i = P_i, a sufficient schedulability condition can be expressed in
  a simple way:
+
 	sum(WCET_i / P_i) <= M - (M - 1) · U_max
+
  where U_max = max{WCET_i / P_i}[10]. Notice that for U_max = 1,
  M - (M - 1) · U_max becomes M - M + 1 = 1 and this schedulability condition
  just confirms the Dhall's effect. A more complete survey of the literature
@@ -447,7 +461,7 @@ CONTENTS
  the tasks are limited.
 
 3.4 Relationship with SCHED_DEADLINE Parameters
-------------------------
+-----------------------------------------------
 
  Finally, it is important to understand the relationship between the
  SCHED_DEADLINE scheduling parameters described in Section 2 (runtime,
@@ -473,6 +487,7 @@ CONTENTS
  this task, as it is not possible to respect its temporal constraints.
 
  References:
+
   1 - C. L. Liu and J. W. Layland. Scheduling algorithms for multiprogram-
       ming in a hard-real-time environment. Journal of the Association for
       Computing Machinery, 20(1), 1973.
@@ -550,7 +565,7 @@ CONTENTS
  The interface used to control the CPU bandwidth that can be allocated
  to -deadline tasks is similar to the one already used for -rt
  tasks with real-time group scheduling (a.k.a. RT-throttling - see
- Documentation/scheduler/sched-rt-group.txt), and is based on readable/
+ Documentation/scheduler/sched-rt-group.rst), and is based on readable/
  writable control files located in procfs (for system wide settings).
  Notice that per-group settings (controlled through cgroupfs) are still not
  defined for -deadline tasks, because more discussion is needed in order to
@@ -596,11 +611,13 @@ CONTENTS
  Specifying a periodic/sporadic task that executes for a given amount of
  runtime at each instance, and that is scheduled according to the urgency of
  its own timing constraints needs, in general, a way of declaring:
+
   - a (maximum/typical) instance execution time,
   - a minimum interval between consecutive instances,
   - a time constraint by which each instance must be completed.
 
  Therefore:
+
   * a new struct sched_attr, containing all the necessary fields is
     provided;
   * the new scheduling related syscalls that manipulate it, i.e.,
@@ -658,21 +675,21 @@ CONTENTS
 ------------------------------------
 
  An example of a simple configuration (pin a -deadline task to CPU0)
- follows (rt-app is used to create a -deadline task).
+ follows (rt-app is used to create a -deadline task)::
 
- mkdir /dev/cpuset
- mount -t cgroup -o cpuset cpuset /dev/cpuset
- cd /dev/cpuset
- mkdir cpu0
- echo 0 > cpu0/cpuset.cpus
- echo 0 > cpu0/cpuset.mems
- echo 1 > cpuset.cpu_exclusive
- echo 0 > cpuset.sched_load_balance
- echo 1 > cpu0/cpuset.cpu_exclusive
- echo 1 > cpu0/cpuset.mem_exclusive
- echo $$ > cpu0/tasks
- rt-app -t 100000:10000:d:0 -D5 (it is now actually superfluous to specify
- task affinity)
+   mkdir /dev/cpuset
+   mount -t cgroup -o cpuset cpuset /dev/cpuset
+   cd /dev/cpuset
+   mkdir cpu0
+   echo 0 > cpu0/cpuset.cpus
+   echo 0 > cpu0/cpuset.mems
+   echo 1 > cpuset.cpu_exclusive
+   echo 0 > cpuset.sched_load_balance
+   echo 1 > cpu0/cpuset.cpu_exclusive
+   echo 1 > cpu0/cpuset.mem_exclusive
+   echo $$ > cpu0/tasks
+   rt-app -t 100000:10000:d:0 -D5 # it is now actually superfluous to specify
+				  # task affinity
 
 6. Future plans
 ===============
@@ -711,7 +728,7 @@ Appendix A. Test suite
  rt-app is available at: https://github.com/scheduler-tools/rt-app.
 
  Thread parameters can be specified from the command line, with something like
- this:
+ this::
 
   # rt-app -t 100000:10000:d -t 150000:20000:f:10 -D5
 
@@ -721,27 +738,27 @@ Appendix A. Test suite
  of 5 seconds.
 
  More interestingly, configurations can be described with a json file that
- can be passed as input to rt-app with something like this:
+ can be passed as input to rt-app with something like this::
 
   # rt-app my_config.json
 
  The parameters that can be specified with the second method are a superset
  of the command line options. Please refer to rt-app documentation for more
- details (<rt-app-sources>/doc/*.json).
+ details (`<rt-app-sources>/doc/*.json`).
 
  The second testing application is a modification of schedtool, called
  schedtool-dl, which can be used to setup SCHED_DEADLINE parameters for a
  certain pid/application. schedtool-dl is available at:
  https://github.com/scheduler-tools/schedtool-dl.git.
 
- The usage is straightforward:
+ The usage is straightforward::
 
   # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
 
  With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
  of 10ms every 100ms (note that parameters are expressed in microseconds).
  You can also use schedtool to create a reservation for an already running
- application, given that you know its pid:
+ application, given that you know its pid::
 
   # schedtool -E -t 10000000:100000000 my_app_pid
 
@@ -750,43 +767,43 @@ Appendix B. Minimal main()
 
  We provide in what follows a simple (ugly) self-contained code snippet
  showing how SCHED_DEADLINE reservations can be created by a real-time
- application developer.
-
- #define _GNU_SOURCE
- #include <unistd.h>
- #include <stdio.h>
- #include <stdlib.h>
- #include <string.h>
- #include <time.h>
- #include <linux/unistd.h>
- #include <linux/kernel.h>
- #include <linux/types.h>
- #include <sys/syscall.h>
- #include <pthread.h>
-
- #define gettid() syscall(__NR_gettid)
-
- #define SCHED_DEADLINE	6
-
- /* XXX use the proper syscall numbers */
- #ifdef __x86_64__
- #define __NR_sched_setattr		314
- #define __NR_sched_getattr		315
- #endif
-
- #ifdef __i386__
- #define __NR_sched_setattr		351
- #define __NR_sched_getattr		352
- #endif
-
- #ifdef __arm__
- #define __NR_sched_setattr		380
- #define __NR_sched_getattr		381
- #endif
-
- static volatile int done;
-
- struct sched_attr {
+ application developer::
+
+   #define _GNU_SOURCE
+   #include <unistd.h>
+   #include <stdio.h>
+   #include <stdlib.h>
+   #include <string.h>
+   #include <time.h>
+   #include <linux/unistd.h>
+   #include <linux/kernel.h>
+   #include <linux/types.h>
+   #include <sys/syscall.h>
+   #include <pthread.h>
+
+   #define gettid() syscall(__NR_gettid)
+
+   #define SCHED_DEADLINE	6
+
+   /* XXX use the proper syscall numbers */
+   #ifdef __x86_64__
+   #define __NR_sched_setattr		314
+   #define __NR_sched_getattr		315
+   #endif
+
+   #ifdef __i386__
+   #define __NR_sched_setattr		351
+   #define __NR_sched_getattr		352
+   #endif
+
+   #ifdef __arm__
+   #define __NR_sched_setattr		380
+   #define __NR_sched_getattr		381
+   #endif
+
+   static volatile int done;
+
+   struct sched_attr {
 	__u32 size;
 
 	__u32 sched_policy;
@@ -802,25 +819,25 @@ Appendix B. Minimal main()
 	__u64 sched_runtime;
 	__u64 sched_deadline;
 	__u64 sched_period;
- };
+   };
 
- int sched_setattr(pid_t pid,
+   int sched_setattr(pid_t pid,
 		  const struct sched_attr *attr,
 		  unsigned int flags)
- {
+   {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
- }
+   }
 
- int sched_getattr(pid_t pid,
+   int sched_getattr(pid_t pid,
 		  struct sched_attr *attr,
 		  unsigned int size,
 		  unsigned int flags)
- {
+   {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
- }
+   }
 
- void *run_deadline(void *data)
- {
+   void *run_deadline(void *data)
+   {
 	struct sched_attr attr;
 	int x = 0;
 	int ret;
@@ -851,10 +868,10 @@ Appendix B. Minimal main()
 
 	printf("deadline thread dies [%ld]\n", gettid());
 	return NULL;
- }
+   }
 
- int main (int argc, char **argv)
- {
+   int main (int argc, char **argv)
+   {
 	pthread_t thread;
 
 	printf("main thread [%ld]\n", gettid());
@@ -868,4 +885,4 @@ Appendix B. Minimal main()
 
 	printf("main dies [%ld]\n", gettid());
 	return 0;
- }
+   }
diff --git a/Documentation/scheduler/sched-design-CFS.txt b/Documentation/scheduler/sched-design-CFS.rst
similarity index 97%
rename from Documentation/scheduler/sched-design-CFS.txt
rename to Documentation/scheduler/sched-design-CFS.rst
index d1328890ef28..53b30d1967cf 100644
--- a/Documentation/scheduler/sched-design-CFS.txt
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -1,9 +1,10 @@
-                      =============
-                      CFS Scheduler
-                      =============
+=============
+CFS Scheduler
+=============
 
 
 1.  OVERVIEW
+============
 
 CFS stands for "Completely Fair Scheduler," and is the new "desktop" process
 scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is the
@@ -27,6 +28,7 @@ is its actual runtime normalized to the total number of running tasks.
 
 
 2.  FEW IMPLEMENTATION DETAILS
+==============================
 
 In CFS the virtual runtime is expressed and tracked via the per-task
 p->se.vruntime (nanosec-unit) value.  This way, it's possible to accurately
@@ -49,6 +51,7 @@ algorithm variants to recognize sleepers.
 
 
 3.  THE RBTREE
+==============
 
 CFS's design is quite radical: it does not use the old data structures for the
 runqueues, but it uses a time-ordered rbtree to build a "timeline" of future
@@ -84,6 +87,7 @@ picked and the current task is preempted.
 
 
 4.  SOME FEATURES OF CFS
+========================
 
 CFS uses nanosecond granularity accounting and does not rely on any jiffies or
 other HZ detail.  Thus the CFS scheduler has no notion of "timeslices" in the
@@ -113,6 +117,7 @@ result.
 
 
 5. Scheduling policies
+======================
 
 CFS implements three scheduling policies:
 
@@ -137,6 +142,7 @@ SCHED_IDLE.
 
 
 6.  SCHEDULING CLASSES
+======================
 
 The new CFS scheduler has been designed in such a way to introduce "Scheduling
 Classes," an extensible hierarchy of scheduler modules.  These modules
@@ -197,6 +203,7 @@ This is the (partial) list of the hooks:
 
 
 7.  GROUP SCHEDULER EXTENSIONS TO CFS
+=====================================
 
 Normally, the scheduler operates on individual tasks and strives to provide
 fair CPU time to each task.  Sometimes, it may be desirable to group tasks and
@@ -219,7 +226,7 @@ SCHED_BATCH) tasks.
 
 When CONFIG_FAIR_GROUP_SCHED is defined, a "cpu.shares" file is created for each
 group created using the pseudo filesystem.  See example steps below to create
-task groups and modify their CPU share using the "cgroups" pseudo filesystem.
+task groups and modify their CPU share using the "cgroups" pseudo filesystem::
 
 	# mount -t tmpfs cgroup_root /sys/fs/cgroup
 	# mkdir /sys/fs/cgroup/cpu
diff --git a/Documentation/scheduler/sched-domains.txt b/Documentation/scheduler/sched-domains.rst
similarity index 97%
rename from Documentation/scheduler/sched-domains.txt
rename to Documentation/scheduler/sched-domains.rst
index 4af80b1c05aa..f7504226f445 100644
--- a/Documentation/scheduler/sched-domains.txt
+++ b/Documentation/scheduler/sched-domains.rst
@@ -1,3 +1,7 @@
+=================
+Scheduler Domains
+=================
+
 Each CPU has a "base" scheduling domain (struct sched_domain). The domain
 hierarchy is built from these base domains via the ->parent pointer. ->parent
 MUST be NULL terminated, and domain structures should be per-CPU as they are
@@ -46,7 +50,9 @@ CPU's runqueue and the newly found busiest one and starts moving tasks from it
 to our runqueue. The exact number of tasks amounts to an imbalance previously
 computed while iterating over this sched domain's groups.
 
-*** Implementing sched domains ***
+Implementing sched domains
+==========================
+
 The "base" domain will "span" the first level of the hierarchy. In the case
 of SMT, you'll span all siblings of the physical CPU, with each group being
 a single virtual CPU.
diff --git a/Documentation/scheduler/sched-energy.txt b/Documentation/scheduler/sched-energy.rst
similarity index 96%
rename from Documentation/scheduler/sched-energy.txt
rename to Documentation/scheduler/sched-energy.rst
index d97207b9accb..9580c57a52bc 100644
--- a/Documentation/scheduler/sched-energy.txt
+++ b/Documentation/scheduler/sched-energy.rst
@@ -1,6 +1,6 @@
-			   =======================
-			   Energy Aware Scheduling
-			   =======================
+=======================
+Energy Aware Scheduling
+=======================
 
 1. Introduction
 ---------------
@@ -12,7 +12,7 @@ with a minimal impact on throughput. This document aims at providing an
 introduction on how EAS works, what are the main design decisions behind it, and
 details what is needed to get it to run.
 
-Before going any further, please note that at the time of writing:
+Before going any further, please note that at the time of writing::
 
    /!\ EAS does not support platforms with symmetric CPU topologies /!\
 
@@ -33,13 +33,13 @@ To make it clear from the start:
  - power = energy/time = [joule/second] = [watt]
 
 The goal of EAS is to minimize energy, while still getting the job done. That
-is, we want to maximize:
+is, we want to maximize::
 
 	performance [inst/s]
 	--------------------
 	    power [W]
 
-which is equivalent to minimizing:
+which is equivalent to minimizing::
 
 	energy [J]
 	-----------
@@ -97,7 +97,7 @@ domains can contain duplicate elements.
 
 Example 1.
     Let us consider a platform with 12 CPUs, split in 3 performance domains
-    (pd0, pd4 and pd8), organized as follows:
+    (pd0, pd4 and pd8), organized as follows::
 
 	          CPUs:   0 1 2 3 4 5 6 7 8 9 10 11
 	          PDs:   |--pd0--|--pd4--|---pd8---|
@@ -108,6 +108,7 @@ Example 1.
     containing 6 CPUs. The two root domains are denoted rd1 and rd2 in the
     above figure. Since pd4 intersects with both rd1 and rd2, it will be
     present in the linked list '->pd' attached to each of them:
+
        * rd1->pd: pd0 -> pd4
        * rd2->pd: pd4 -> pd8
 
@@ -159,9 +160,9 @@ Example 2.
     Each performance domain has three Operating Performance Points (OPPs).
     The CPU capacity and power cost associated with each OPP is listed in
     the Energy Model table. The util_avg of P is shown on the figures
-    below as 'PP'.
+    below as 'PP'::
 
-    CPU util.
+     CPU util.
       1024                 - - - - - - -              Energy Model
                                                +-----------+-------------+
                                                |  Little   |     Big     |
@@ -188,8 +189,7 @@ Example 2.
     (which is coherent with the behaviour of the schedutil CPUFreq
     governor, see Section 6. for more details on this topic).
 
-    Case 1. P is migrated to CPU1
-    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+    **Case 1. P is migrated to CPU1**::
 
       1024                 - - - - - - -
 
@@ -207,8 +207,7 @@ Example 2.
             CPU0   CPU1     CPU2   CPU3
 
 
-    Case 2. P is migrated to CPU3
-    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+    **Case 2. P is migrated to CPU3**::
 
       1024                 - - - - - - -
 
@@ -226,8 +225,7 @@ Example 2.
             CPU0   CPU1     CPU2   CPU3
 
 
-    Case 3. P stays on prev_cpu / CPU 0
-    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+    **Case 3. P stays on prev_cpu / CPU 0**::
 
       1024                 - - - - - - -
 
@@ -324,7 +322,9 @@ hardware properties and on other features of the kernel being enabled. This
 section lists these dependencies and provides hints as to how they can be met.
 
 
-  6.1 - Asymmetric CPU topology
+6.1 - Asymmetric CPU topology
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 
 As mentioned in the introduction, EAS is only supported on platforms with
 asymmetric CPU topologies for now. This requirement is checked at run-time by
@@ -347,7 +347,8 @@ significant savings on SMP platforms have been observed yet. This restriction
 could be amended in the future if proven otherwise.
 
 
-  6.2 - Energy Model presence
+6.2 - Energy Model presence
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 EAS uses the EM of a platform to estimate the impact of scheduling decisions on
 energy. So, your platform must provide power cost tables to the EM framework in
@@ -358,7 +359,8 @@ Please also note that the scheduling domains need to be re-built after the
 EM has been registered in order to start EAS.
 
 
-  6.3 - Energy Model complexity
+6.3 - Energy Model complexity
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The task wake-up path is very latency-sensitive. When the EM of a platform is
 too complex (too many CPUs, too many performance domains, too many performance
@@ -388,7 +390,8 @@ two possible options:
        hence enabling it to cope with larger EMs in reasonable time.
 
 
-  6.4 - Schedutil governor
+6.4 - Schedutil governor
+^^^^^^^^^^^^^^^^^^^^^^^^
 
 EAS tries to predict at which OPP will the CPUs be running in the close future
 in order to estimate their energy consumption. To do so, it is assumed that OPPs
@@ -405,7 +408,8 @@ frequency requests and energy predictions.
 Using EAS with any other governor than schedutil is not supported.
 
 
-  6.5 Scale-invariant utilization signals
+6.5 Scale-invariant utilization signals
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 In order to make accurate prediction across CPUs and for all performance
 states, EAS needs frequency-invariant and CPU-invariant PELT signals. These can
@@ -416,7 +420,8 @@ Using EAS on a platform that doesn't implement these two callbacks is not
 supported.
 
 
-  6.6 Multithreading (SMT)
+6.6 Multithreading (SMT)
+^^^^^^^^^^^^^^^^^^^^^^^^
 
 EAS in its current form is SMT unaware and is not able to leverage
 multithreaded hardware to save energy. EAS considers threads as independent
diff --git a/Documentation/scheduler/sched-nice-design.txt b/Documentation/scheduler/sched-nice-design.rst
similarity index 98%
rename from Documentation/scheduler/sched-nice-design.txt
rename to Documentation/scheduler/sched-nice-design.rst
index 3ac1e46d5365..0571f1b47e64 100644
--- a/Documentation/scheduler/sched-nice-design.txt
+++ b/Documentation/scheduler/sched-nice-design.rst
@@ -1,3 +1,7 @@
+=====================
+Scheduler Nice Design
+=====================
+
 This document explains the thinking about the revamped and streamlined
 nice-levels implementation in the new Linux scheduler.
 
@@ -14,7 +18,7 @@ much stronger than they were before in 2.4 (and people were happy about
 that change), and we also intentionally calibrated the linear timeslice
 rule so that nice +19 level would be _exactly_ 1 jiffy. To better
 understand it, the timeslice graph went like this (cheesy ASCII art
-alert!):
+alert!)::
 
 
                    A
diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.rst
similarity index 95%
rename from Documentation/scheduler/sched-rt-group.txt
rename to Documentation/scheduler/sched-rt-group.rst
index c09f7a3fee66..d27d3f3712fd 100644
--- a/Documentation/scheduler/sched-rt-group.txt
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -1,18 +1,18 @@
-				Real-Time group scheduling
-				--------------------------
+==========================
+Real-Time group scheduling
+==========================
 
-CONTENTS
-========
+.. CONTENTS
 
-0. WARNING
-1. Overview
-  1.1 The problem
-  1.2 The solution
-2. The interface
-  2.1 System-wide settings
-  2.2 Default behaviour
-  2.3 Basis for grouping tasks
-3. Future plans
+   0. WARNING
+   1. Overview
+     1.1 The problem
+     1.2 The solution
+   2. The interface
+     2.1 System-wide settings
+     2.2 Default behaviour
+     2.3 Basis for grouping tasks
+   3. Future plans
 
 
 0. WARNING
@@ -159,9 +159,11 @@ Consider two sibling groups A and B; both have 50% bandwidth, but A's
 period is twice the length of B's.
 
 * group A: period=100000us, runtime=50000us
+
 	- this runs for 0.05s once every 0.1s
 
 * group B: period= 50000us, runtime=25000us
+
 	- this runs for 0.025s twice every 0.1s (or once every 0.05 sec).
 
 This means that currently a while (1) loop in A will run for the full period of
diff --git a/Documentation/scheduler/sched-stats.txt b/Documentation/scheduler/sched-stats.rst
similarity index 91%
rename from Documentation/scheduler/sched-stats.txt
rename to Documentation/scheduler/sched-stats.rst
index 8259b34a66ae..0cb0aa714545 100644
--- a/Documentation/scheduler/sched-stats.txt
+++ b/Documentation/scheduler/sched-stats.rst
@@ -1,3 +1,7 @@
+====================
+Scheduler Statistics
+====================
+
 Version 15 of schedstats dropped counters for some sched_yield:
 yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
 identical to version 14.
@@ -35,19 +39,23 @@ CPU statistics
 cpu<N> 1 2 3 4 5 6 7 8 9
 
 First field is a sched_yield() statistic:
+
      1) # of times sched_yield() was called
 
 Next three are schedule() statistics:
+
      2) This field is a legacy array expiration count field used in the O(1)
 	scheduler. We kept it for ABI compatibility, but it is always set to zero.
      3) # of times schedule() was called
      4) # of times schedule() left the processor idle
 
 Next two are try_to_wake_up() statistics:
+
      5) # of times try_to_wake_up() was called
      6) # of times try_to_wake_up() was called to wake up the local cpu
 
 Next three are statistics describing scheduling latency:
+
      7) sum of all time spent running by tasks on this processor (in jiffies)
      8) sum of all time spent waiting to run by tasks on this processor (in
         jiffies)
@@ -67,24 +75,23 @@ The first field is a bit mask indicating what cpus this domain operates over.
 The next 24 are a variety of load_balance() statistics in grouped into types
 of idleness (idle, busy, and newly idle):
 
-     1) # of times in this domain load_balance() was called when the
+    1)  # of times in this domain load_balance() was called when the
         cpu was idle
-     2) # of times in this domain load_balance() checked but found
+    2)  # of times in this domain load_balance() checked but found
         the load did not require balancing when the cpu was idle
-     3) # of times in this domain load_balance() tried to move one or
+    3)  # of times in this domain load_balance() tried to move one or
         more tasks and failed, when the cpu was idle
-     4) sum of imbalances discovered (if any) with each call to
+    4)  sum of imbalances discovered (if any) with each call to
         load_balance() in this domain when the cpu was idle
-     5) # of times in this domain pull_task() was called when the cpu
+    5)  # of times in this domain pull_task() was called when the cpu
         was idle
-     6) # of times in this domain pull_task() was called even though
+    6)  # of times in this domain pull_task() was called even though
         the target task was cache-hot when idle
-     7) # of times in this domain load_balance() was called but did
+    7)  # of times in this domain load_balance() was called but did
         not find a busier queue while the cpu was idle
-     8) # of times in this domain a busier queue was found while the
+    8)  # of times in this domain a busier queue was found while the
         cpu was idle but no busier group was found
-
-     9) # of times in this domain load_balance() was called when the
+    9)  # of times in this domain load_balance() was called when the
         cpu was busy
     10) # of times in this domain load_balance() checked but found the
         load did not require balancing when busy
@@ -117,21 +124,25 @@ of idleness (idle, busy, and newly idle):
         was just becoming idle but no busier group was found
 
    Next three are active_load_balance() statistics:
+
     25) # of times active_load_balance() was called
     26) # of times active_load_balance() tried to move a task and failed
     27) # of times active_load_balance() successfully moved a task
 
    Next three are sched_balance_exec() statistics:
+
     28) sbe_cnt is not used
     29) sbe_balanced is not used
     30) sbe_pushed is not used
 
    Next three are sched_balance_fork() statistics:
+
     31) sbf_cnt is not used
     32) sbf_balanced is not used
     33) sbf_pushed is not used
 
    Next three are try_to_wake_up() statistics:
+
     34) # of times in this domain try_to_wake_up() awoke a task that
         last ran on a different cpu in this domain
     35) # of times in this domain try_to_wake_up() moved a task to the
@@ -139,10 +150,11 @@ of idleness (idle, busy, and newly idle):
     36) # of times in this domain try_to_wake_up() started passive balancing
 
 /proc/<pid>/schedstat
-----------------
+---------------------
 schedstats also adds a new /proc/<pid>/schedstat file to include some of
 the same information on a per-process level.  There are three fields in
 this file correlating for that process to:
+
      1) time spent on the cpu
      2) time spent waiting on a runqueue
      3) # of timeslices run on this cpu
@@ -151,4 +163,5 @@ A program could be easily written to make use of these extra fields to
 report on how well a particular process or set of processes is faring
 under the scheduler's policies.  A simple version of such a program is
 available at
+
     http://eaglet.rain.com/rick/linux/schedstat/v12/latency.c
diff --git a/Documentation/scheduler/text_files.rst b/Documentation/scheduler/text_files.rst
new file mode 100644
index 000000000000..0bc50307b241
--- /dev/null
+++ b/Documentation/scheduler/text_files.rst
@@ -0,0 +1,5 @@
+Scheduler pelt c program
+------------------------
+
+.. literalinclude:: sched-pelt.c
+    :language: c
diff --git a/Documentation/vm/numa.rst b/Documentation/vm/numa.rst
index 0d830edae8fe..130f3cfa1c19 100644
--- a/Documentation/vm/numa.rst
+++ b/Documentation/vm/numa.rst
@@ -99,7 +99,7 @@ Local allocation will tend to keep subsequent access to the allocated memory
 as long as the task on whose behalf the kernel allocated some memory does not
 later migrate away from that memory.  The Linux scheduler is aware of the
 NUMA topology of the platform--embodied in the "scheduling domains" data
-structures [see Documentation/scheduler/sched-domains.txt]--and the scheduler
+structures [see Documentation/scheduler/sched-domains.rst]--and the scheduler
 attempts to minimize task migration to distant scheduling domains.  However,
 the scheduler does not take a task's NUMA footprint into account directly.
 Thus, under sufficient imbalance, tasks can migrate between nodes, remote
diff --git a/init/Kconfig b/init/Kconfig
index ab41ffa08d79..6db89d4155d8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -734,7 +734,7 @@ menuconfig CGROUPS
 	  use with process control subsystems such as Cpusets, CFS, memory
 	  controls or device isolation.
 	  See
-		- Documentation/scheduler/sched-design-CFS.txt	(CFS)
+		- Documentation/scheduler/sched-design-CFS.rst	(CFS)
 		- Documentation/cgroup-v1/ (features for grouping, isolation
 					  and resource control)
 
@@ -835,7 +835,7 @@ config CFS_BANDWIDTH
 	  tasks running within the fair group scheduler.  Groups with no limit
 	  set are considered to be unconstrained and will run with no
 	  restriction.
-	  See Documentation/scheduler/sched-bwc.txt for more information.
+	  See Documentation/scheduler/sched-bwc.rst for more information.
 
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
@@ -846,7 +846,7 @@ config RT_GROUP_SCHED
 	  to task groups. If enabled, it will also make it impossible to
 	  schedule realtime tasks for non-root users until you allocate
 	  realtime bandwidth for them.
-	  See Documentation/scheduler/sched-rt-group.txt for more information.
+	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
 endif #CGROUP_SCHED
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c1ef30861068..2df20e15b576 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -726,7 +726,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
  * refill the runtime and set the deadline a period in the future,
  * because keeping the current (absolute) deadline of the task would
  * result in breaking guarantees promised to other tasks (refer to
- * Documentation/scheduler/sched-deadline.txt for more information).
+ * Documentation/scheduler/sched-deadline.rst for more information).
  *
  * This function returns true if:
  *
-- 
2.21.0

