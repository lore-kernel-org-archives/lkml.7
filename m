Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72DBC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1itqkF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEPIBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36717 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so1426196pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEBcW9pa6vw4lsJ/r5uwUgCge3DTSJs/KVXNTlf+G34=;
        b=n1itqkF95cYSUnFNTGorSLiznzIj8oVgyEIGeY00m7C8YOksZF0RZTq1UJxfuKCJcK
         BwZt75LdqOPono0auqwIY+dWiEGSW5hfO1QqfFD+UbCa/OppMnFLj6zkWj8J7juNTcIC
         RtnCHKqt9DOwOLk7/TVIOvgQ5WUOm9WCJd17jY+DEQVBCcVsYh2Qbk0J0fw52nW6Uxrf
         y2jkMCkbZUN0/gmNKm9VQjd09CuQMjF4IC4lG94UiMRYLmnwvK2lJCXRN5KSxniCyWVz
         psJhRr2PIXXxqhCb6xmW0Bo+vOGp6nw/e9nf/+5jE99MRWxHfYi00NPjTz5FZkKqp6la
         oCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEBcW9pa6vw4lsJ/r5uwUgCge3DTSJs/KVXNTlf+G34=;
        b=X8U26BuNEGmBY0dUs6ZdLaOvPnBI7Lj6WRTEBjD3B2gmURwiKYhLJBQaUSug8Pk0nO
         yzGfO+HzCZf/QCjjyszmdHCASxbIf3uOcPpHZGCgf4a8P5eWQKEjsETxiJQ+r2k+cERT
         xFGKt00KTBQ73TZS6/Z4Ekc4bvquT2t2CZ5Ys5tQS8HURldLRNeS5huqg6/ZZBemSR6e
         ce3DOi784CMFnGWjPr5HiQGEFXXNLiZdXvl6I5gfmE0uR+LqfUp8FkWHtI0ydHMhnI71
         ha8OAMUgTc+3UEKgyt5AELVzitIPnwjHCDnL3JVYX+NbAiSnBMy+mfK5PG2+DazjWzxc
         jHiw==
X-Gm-Message-State: APjAAAXo55Nw+SdC8mY2FbEsdltv3/EziGc/PMGkT4S9ipgr7Bytr5Fp
        dfA063fjgf6y0Vbfpj2EXFg=
X-Google-Smtp-Source: APXvYqxPgumdQ3r0FOMXEC587S2jYNtx50Q7yeH9VBjnJJrEp05zQNxeV4N/Yn1kCgygPr4EdOGA0g==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr52138526pfn.105.1557993659209;
        Thu, 16 May 2019 01:00:59 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:58 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 10/17] locking/lockdep: Support read-write lock's deadlock detection
Date:   Thu, 16 May 2019 16:00:08 +0800
Message-Id: <20190516080015.16033-11-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A read-write lock is different from an exclusive lock in that read locks
can be concurrent, while a write lock is essentially the same as an
exclusive lock.

Read-write locks have not been well supported for deadlock detection so
far. This patch series designs and implements an algorithm to add this
important missing feature to lockdep.

To articulate the algorithm plainly, lets first give an abstract of the
problem to solve. And, to make the problem simple and easy to describe,
recursive-read locks are not considered; they will be covered later, and
actually adding recursive-read lock is very easy if the read-lock problem
is solved.

Problem statement
-----------------

Waiting relations in a circular fashion are at the heart of a deadlock:
a circle is universally *necessary* for any deadlock, albeit not
*sufficient* with read-write locks. A deadlock circle can be arbitrarily
long with many tasks contributing some arcs. But no matter how long the
circle is, it has to complete with a final arc, so the problem to solve
can be stated as:

Lemma #1
--------

  A deadlock can be and can only be detected at the *final* arc when it
  completes a circle.

Assume there are n tasks contribute to that circle, denoted as T_1, T_2,
..., T_n, these tasks can be grouped as (T_1, ..., T_n-1) and T_n. And
by combining the former virtually, we get a big T1 and T2 (with task
numbers adjusted). This essentially means:

Lemma #2
--------

  Two tasks can virtually represent any situation with any number of
  tasks to check for deadlock.

Actually, how long the circle is does not really matter since the
problem as stated is what a difference the final missing arc can make:
deadlock or not; therefore, we need a few locks that are just enough to
represent all the possibilities. And this leads to:

Lemma #3
--------

  Any deadlock scenario can be converted to an ABBA deadlock.

where AB comes from T1 and BA from T2 (T1 and T2 are made by Lemma #2),
which says any other associated locks in the graph are not critical or
necessary and thus may be ignored. For example:

    T1        T2
    --        --

    L1        L7
    L2        L2

    A         B
    L3        L3
    L4        L8
    B         A    [Deadlock]

    L5
    L6

from deadlock perspective is equivalent to an ABBA:

    T1        T2
    --        --

    A         B
    B         A    [Deadlock]

Despite the lemmas, three facts are relevant to the problem: (a) with a
new arc, determining whether it completes a circle is an easy task, (b)
a new direct arc (direct dependency) can introduce a number of indirect
arcs (indirect dependencies), and (c) checking all the additional arcs
(direct and indirect) efficiently is not so easy since lock operations are
frequent and lock graph can be gigantic. Actually, if it is free to check
any number of arcs, deadlock detection even with read-write locks is fairly
easy. That said performance is what the real difficulty is, so a good
algorithm should not only be self-evident that it does solve the problem
but also do so at low cost.

Here we try a start to solve it!

Having grasped the problem statement, we are good to proceed to a
divide-and-conquer approach to the solution: the entire problem is
broken down into a comprehensive list of simple and abstract problem
cases to solve, and if each and every one of them is solved, the entire
problem is solved.

The division is based on the type of the final arc or dependency in T2.
Based on Lemma #2, we use only two tasks in the following discussion.
And based on Lemma #3, these cases are all ABBAs. To be concise, the
following symbol R stands for read lock, W stands for write lock or
exclusive lock, and X stands for either R or W.

---------------------------------------------------------------
When the final dependency is ended with read lock and read lock
---------------------------------------------------------------

Case #1:

    T1        T2
    --        --

    W1        R2
    W2        R1   [Deadlock]

Case #2:

    T1        T2

    X1        R2
    R2        R1   [No deadlock]

------------------------------------------------------
When the final dependency is write lock and write lock
------------------------------------------------------

Case #3:

    T1        T2
    --        --

    X1        W2
    X2        W1   [Deadlock]

-----------------------------------------------------
When the final dependency is read lock and write lock
-----------------------------------------------------

Note that the final dependency is ended with write lock and read lock is
essentially the same as this one so that case is omitted.

Case #4:

    T1        T2
    --        --

    X1        R2
    W2        W1   [Deadlock]

Case #5:

    T1        T2
    --        --

    X1        R2
    R2        W1   [No deadlock]

Solving the above cases (no false positive or false negative) is
actually fairly easy to do; we therefore have our first *Simple
Algorithm*:

----------------
Simple Algorithm
----------------

Step 1
------

Keep track of each dependency's read or write ends. There is a
combination of four types:

   - read -> read
   - read -> write
   - write -> read
   - write -> write

Step 2
------

Redundancy check (as to whether adding a dependency into graph) for a
direct dependency needs to be beefed up considering dependency's read-
or write-ended types: a direct dependency is redundant to an indirect
dependency only if their ends have the same types. However, for
simplicity, direct dependencies can be added right away and if the
dependency to add already exists, the existing dependency can be
"upgraded": upgrade the end type towards more exclusive (the exlusiveness
increases from recursive read -> read -> write).

Step 3
------

Traverse the entire dependency graph (there may be more than one circle)
to find whether a deadlock circle can be formed by adding a new direct
dependency. A circle may or may not be a deadlock. The deciding rule is
simple: it is a deadlock if the new dependency to add have inversed
dependency with exclusive lock types in the graph (i.e., an ABBA according
to Lemma #3). Lock exclusiveness relations are listed as below:

   -  read and read       (no )
   -  read and write      (yes)
   - write and read       (yes)
   - write and write      (yes)

In order to find a deadlock circle efficiently, the new dependency's locks
can *start* from write-ended dependences if dependencies of all types are
kept (this is not our case since our read-ended dependencies are upgraded
if needed). Note that Step 3 can avoid the following false negative case
easily:

Case #6:

    T1        T2
    --        --

    R1
    R2

   (R1 R2 released)

    W1        R2
    W2        R1   [Deadlock]

*Simple Algorithm* done loosely described.

I wish we lived in a fairy-tale world that the problem has been solved
so easily, but the reality is not. Huge false negatives owing to
indirect dependencies could appear, which is illustrated as the
following case to further solve:

Case #7:

    T1        T2
    --        --

    X1        X3
    R2        R2
    X3        X1   [Deadlock]

where X1's and X3's in the two tasks create a deadlock scenario (they can
be any one of the deadlock cases above). When checking direct dependency
R2 -> X1, there is no obvious deadlock using our *Simple Algorithm*,
however, under the hood the actual deadlock is formed after R2 introduces an
indirect dependency X3 -> X1, which could comfortably be missed.

To detect deadlock scenario like Case #7, a naive option is to check all
additional indirect dependencies, but this option would be so
inefficient and thus is simply passed. To find an efficient solution
instead, lets first contrive a no-deadlock Case #8 for comparison (which
is essentially rewritten from Case #5).

Case #8:

    T1        T2
    --        --

    X1
    X3        R2
    R2        X1   [No deadlock]

Having considered Case #7 and Case #8, a final working algorithm can be
formulated:

---------------
Final Algorithm
---------------

This *Final Algorithm* is beefed up from Simple Algorithm using the
following lemmas:

Lemma #4
--------

  The direct dependency R2 -> X1 that serves in the path from X3 -> X1 is
  *critical*.

Although the actual deadlock in Case #7 cannot be easily found by our
*Simple Algorithm*, however, by strengthening the algorithm somehow the
deadlock *definitely* can be found at adding the direct dependency
(i.e., R2 -> X1 in Case #7), see Lemma #1. In other words, a *critical*
direct dependency (i.e., the final arc) suffices to find any deadlock if
there is a deadlock, otherwise there is no deadlock. As a matter of fact,
after a false deadlock (R2 -> X1 -> R2), if the search continues the true
deadlock (R2 -> X1 -> R2 -> X3 -> R2) will eventually be taken out of the
hood.

Lemma #5
--------

  Missed in Case #8, the game changer to Case #7 is that it has X3 in T2
  whereas Case #8 does not.

Having considered this, our *Final Algorithm* can be adjusted from the
*Simple Algorithm* by adding:

(a). Continue searching the graph to find a new circle.

(b). In the new circle, if previous locks in T2's stack (or chain) are in
     it and then check whether the circle is indeed a deadlock. This is
     done by checking each newly introduced indirect dependency (such as
     X3 -> X1 in Case #7) according to our Simple Algorithm as before.

(c). If a deadlock is found then the algorithm is done, otherwise go to
     (a) unless the entire graph is traversed.

Why does Lemma #5 work?

Lemma #6
--------

  Lemma #5 nicely raises a question whether a previous lock involved
  indirect dependency in T2 is *necessary*. The answer is yes, otherwise
  our *Simple Algorithm* has already solved the problem.

Lemma #7
--------

  It is also natual to ask whether an indirect dependencies with a
  starting lock in T2 only is *sufficient*: what if the indirect
  dependency has a starting lock from T1. The answer is yes too.

Because Lemma #2 and Lemma #3 say that any deadlock is an ABBA so that
T1 can only contribute an AB and T2 must have a BA. As a result, since we
assumed T1 has no deadlock and Lemma #4 says the new dependency is
*critical*, then any deadlock formed by the new direct or indirect
dependencies introduced in T2 (which is the BA part) will definitely be
found with *Simple Algorithm* or *Final Algorithm* respectively.

This is perhaps the most subtle and difficult part of this algorithm. To
test Lemma #7 holds true, one may try to contrive a case based on Case #8
or freely to generate a deadlock case if possible.

Anyway, we welcome any new cases. Cases matter in this algorithm because
as stated before, this algorithm solves the read-write lock deadlock
detection problem by having solved all the contrived cases (be it deadlock
or no deadlock). And if anyone comes up with a new case that is not covered
here, it likely will defeat this algorithm, but if otherwise this algorithm
just works sound and complete.

*Final Algorithm* done loosely described.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 143 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 019099e..d5a874b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -85,6 +85,7 @@
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 static struct task_struct *lockdep_selftest_task_struct;
+static bool inside_selftest(void);
 
 static int graph_lock(void)
 {
@@ -1784,17 +1785,24 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 }
 
 /*
- * Prove that the dependency graph starting at <src> can not
- * lead to <target>. If it can, there is a circle when adding
- * <target> -> <src> dependency.
+ * Prove that when adding <target> -> <src> dependency into the dependency
+ * graph, there is no deadlock. This is done by:
+ *
+ * 1. Determine whether the graph starting at <src> can lead to <target>.
+ *    If it can, there is a circle.
+ *
+ * 2. If there is a circle, there may or may not be a deadlock, which is
+ *    then comprehensively checked according to the general read-write
+ *    lock deadlock detection algorithm.
  *
  * Print an error and return 0 if it does.
  */
 static noinline int
-check_deadlock_graph(struct held_lock *src, struct held_lock *target,
-		     struct lock_trace *trace)
+check_deadlock_graph(struct task_struct *curr, struct held_lock *src,
+		     struct held_lock *target, struct lock_trace *trace)
 {
-	int ret;
+	int ret, i;
+	bool init = true;
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list src_entry = {
 		.class = hlock_class(src),
@@ -1803,19 +1811,122 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
+	while (true) {
+		ret = check_path(hlock_class(target), &src_entry,
+				 &target_entry, init);
+		init = false;
+
+		/* Found a circle, is it deadlock? */
+		if (unlikely(!ret)) {
+			struct lock_list *parent;
 
-	if (unlikely(!ret)) {
-		if (!trace->nr_entries) {
 			/*
-			 * If save_trace fails here, the printing might
-			 * trigger a WARN but because of the !nr_entries it
-			 * should not do bad things.
+			 * Note that we have an assumption that no lock
+			 * class can be both read and recursive-read.
+			 *
+			 * Check this direct dependency.
+			 *
+			 * Step 1: next's lock type and source dependency's
+			 * lock type are exclusive, no?
+			 *
+			 * Find the first dependency after source dependency.
 			 */
-			save_trace(trace);
-		}
+			parent = find_next_dep_in_path(&src_entry, target_entry);
+			if (!parent) {
+				DEBUG_LOCKS_WARN_ON(1);
+				return -3;
+			}
+
+			if (src->read & get_lock_type1(parent))
+				goto cont;
+
+			/*
+			 * Step 2: prev's lock type and target dependency's
+			 * lock type are exclusive, yes?
+			 */
+			if (!(target->read & get_lock_type2(target_entry)))
+				goto print;
+
+			/*
+			 * Check indirect dependency from even further
+			 * previous lock.
+			 */
+			for (i = 0; i < curr->lockdep_depth; i++) {
+				struct held_lock *prev = curr->held_locks + i;
+
+				if (prev->irq_context != src->irq_context)
+					continue;
 
-		print_circular_bug(&src_entry, target_entry, src, target);
+				/*
+				 * We arrived at the same prev lock in this
+				 * direct dependency checking.
+				 */
+				if (prev == target)
+					break;
+
+				/*
+				 * Since the src lock (the next lock to
+				 * acquire) is neither recursive nor nested
+				 * lock, so this prev class cannot be src
+				 * class, then does the path have this
+				 * previous lock?
+				 *
+				 * With read locks it would be possible a
+				 * lock can reoccur in a path. For example:
+				 *
+				 * -> RL1 -> RL2 -> RL3 -> RL1 -> ...
+				 *
+				 * and for another three examples:
+				 *
+				 * Ex1: -> RL1 -> WL2 -> RL3 -> RL1
+				 * Ex2: -> WL1 -> RL2 -> RL3 -> WL1
+				 * Ex3: -> RL1 -> RL2 -> RL3 -> WL1
+				 *
+				 * This can result in that a path may
+				 * encounter a lock twice or more, but we
+				 * used the breadth-first search algorithm
+				 * that will find the shortest path,
+				 * which means that this path can not have
+				 * the same (middle) lock multiple times.
+				 * However, is Ex3 a problem?
+				 */
+				parent = find_lock_in_path(hlock_class(prev),
+							   target_entry);
+				if (parent) {
+					/*
+					 * Yes, we have a candidiate indirect
+					 * dependency to check.
+					 *
+					 * Again step 2: new prev's lock
+					 * type and its dependency in graph
+					 * are exclusive, yes?
+					 *
+					 * Note that we don't need step 1
+					 * again.
+					 */
+					if (!(prev->read & get_lock_type2(parent)))
+						goto print;
+				}
+			}
+cont:
+			mark_lock_unaccessed(target_entry);
+			continue;
+print:
+			if (!trace->nr_entries) {
+				/*
+				 * If save_trace fails here, the printing
+				 * might trigger a WARN but because of the
+				 * !nr_entries it should not do bad things.
+				 */
+				save_trace(trace);
+			}
+
+			print_circular_bug(&src_entry, target_entry,
+					   src, target);
+			break;
+		} else
+			/* The graph is all traversed or an error occurred */
+			break;
 	}
 
 	return ret;
@@ -2510,7 +2621,7 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	ret = check_deadlock_graph(next, prev, trace);
+	ret = check_deadlock_graph(curr, next, prev, trace);
 	if (unlikely(ret <= 0))
 		return 0;
 
-- 
1.8.3.1

