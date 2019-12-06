Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DADC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E11D24685
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNKB/1qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLFIKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:10:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42316 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfLFIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:10:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so2942361pfz.9;
        Fri, 06 Dec 2019 00:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWjIQPSCnZAqMEo9KKcbyLcnI9pOcDMwn+53dM8YZLg=;
        b=rNKB/1qtIOwF/5SOsqGXty6+srlWmS7hy9e8OZzKUj3bIRuKz31vHH2O3i8OZWeIwV
         5tSYaXTHIuR205ExYxmZtdfVtlTonNi1vwqIL57OX5v3AjVi8EEU2y89PzMu5rZ8eXep
         c2ZZCP064IY6NhZFZ79rPUBoDpDldMT8kIsaGVUYEsKzzkFLRgpUTtzSo2xxBRenC+9G
         AX6hbicBufxOWEemv27ZqrXL2Hj0iLN7v/2PB2TWHWqXVCPIV0IVdLx2AOc2zIj8WZLH
         an8xeDfQn7q5BCT7Z8Y4iR4uUGA4a2KuuU4+4eisUjIAIDXBiT604MEFCG8HDPxjabvc
         kz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWjIQPSCnZAqMEo9KKcbyLcnI9pOcDMwn+53dM8YZLg=;
        b=FBb/0QCrh80/bnrUU5jG6P2+pVDUNKPve4FoATjUt8UkoGA/eay0D4J/KShzqJOAHy
         qSg5zVIMx+NDV8lJV7Uv6E4UGnetz7xhWM/O/BVBTeZnHY4BXHAzXsb2ZcgFkalN06IR
         WgL5NRfnSeC3plurAQJ0RCNp6L9Ub7ZOnZlBGWHnrVCXVUwTrJl8honfkaElRey8gKsc
         X8j4exJifUOg42XuvNB6v6q7s7hsuCUUIy1/DvB34iV+h/FrlnZ/5/tYEmJ0+QevE8tH
         5XMbX81U9jJjB5nB5ch9RTwz/590gElGJB8hEZp4LkBiUhCiWl90xSxEDMHSiArV4UNu
         WUZQ==
X-Gm-Message-State: APjAAAXsGim6ZHBBsL+zTKgU/s0a2VyEHnq0SqRMxqLTzLnNrKEG5uny
        bX6rN813lx/8uXaoomq68QE=
X-Google-Smtp-Source: APXvYqwdMdyYunA+rs4a88f2zzwPEX+fEEFZ0vzJLxWx332Vfe7WD48DtT1CUTxP/+oEoz0mkIqofA==
X-Received: by 2002:a62:6416:: with SMTP id y22mr13268141pfb.167.1575619806523;
        Fri, 06 Dec 2019 00:10:06 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.193])
        by smtp.googlemail.com with ESMTPSA id d2sm2305489pja.1.2019.12.06.00.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 00:10:05 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] doc: listRCU: Add some more listRCU patterns in the kernel
Date:   Fri,  6 Dec 2019 13:37:51 +0530
Message-Id: <20191206080750.21745-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203063941.6981-1-frextrite@gmail.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add more information about listRCU patterns taking examples
from audit subsystem in the linux kernel.

- The initially written audit examples are kept, even though they are
slightly different in the kernel.

- Modify inline text for better passage quality.

- Fix typo in code-blocks and improve code comments.

- Add text formatting (italics, bold and code) for better emphasis.

Patch originally submitted at
https://lore.kernel.org/patchwork/patch/1082804/

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Balance out plain-text reading and Sphinx generated HTML.
- Remove code blocks from functions included in kerneldoc
  and other functions that currently don't have a kerneldoc
  entry, but may have one in the future.
- Leave in code blocks for:
	- CONSTANTS
	- variables
	- functions used as an example for explaining
		(audit_upd_rule(), timerfd_setup_cancel() etc)
	- macros (since they don't have a kerneldoc entry)
		(read_lock(), write_lock())

 Documentation/RCU/listRCU.rst | 275 ++++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 64 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index 7956ff33042b..55d2b30db481 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -4,12 +4,61 @@ Using RCU to Protect Read-Mostly Linked Lists
 =============================================
 
 One of the best applications of RCU is to protect read-mostly linked lists
-("struct list_head" in list.h).  One big advantage of this approach
+(``struct list_head`` in list.h).  One big advantage of this approach
 is that all of the required memory barriers are included for you in
 the list macros.  This document describes several applications of RCU,
 with the best fits first.
 
-Example 1: Read-Side Action Taken Outside of Lock, No In-Place Updates
+
+Example 1: Read-mostly list: Deferred Destruction
+-------------------------------------------------
+
+A widely used usecase for RCU lists in the kernel is lockless iteration over
+all processes in the system. ``task_struct::tasks`` represents the list node that
+links all the processes. The list can be traversed in parallel to any list
+additions or removals.
+
+The traversal of the list is done using ``for_each_process()`` which is defined
+by the 2 macros::
+
+	#define next_task(p) \
+		list_entry_rcu((p)->tasks.next, struct task_struct, tasks)
+
+	#define for_each_process(p) \
+		for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+
+The code traversing the list of all processes typically looks like::
+
+	rcu_read_lock();
+	for_each_process(p) {
+		/* Do something with p */
+	}
+	rcu_read_unlock();
+
+The simplified code for removing a process from a task list is::
+
+	void release_task(struct task_struct *p)
+	{
+		write_lock(&tasklist_lock);
+		list_del_rcu(&p->tasks);
+		write_unlock(&tasklist_lock);
+		call_rcu(&p->rcu, delayed_put_task_struct);
+	}
+
+When a process exits, ``release_task()`` calls ``list_del_rcu(&p->tasks)`` under
+``tasklist_lock`` writer lock protection, to remove the task from the list of
+all tasks. The ``tasklist_lock`` prevents concurrent list additions/removals
+from corrupting the list. Readers using ``for_each_process()`` are not protected
+with the ``tasklist_lock``. To prevent readers from noticing changes in the list
+pointers, the ``task_struct`` object is freed only after one or more grace
+periods elapse (with the help of call_rcu()). This deferring of destruction
+ensures that any readers traversing the list will see valid ``p->tasks.next``
+pointers and deletion/freeing can happen in parallel with traversal of the list.
+This pattern is also called an **existence lock**, since RCU pins the object in
+memory until all existing readers finish.
+
+
+Example 2: Read-Side Action Taken Outside of Lock: No In-Place Updates
 ----------------------------------------------------------------------
 
 The best applications are cases where, if reader-writer locking were
@@ -26,7 +75,7 @@ added or deleted, rather than being modified in place.
 
 A straightforward example of this use of RCU may be found in the
 system-call auditing support.  For example, a reader-writer locked
-implementation of audit_filter_task() might be as follows::
+implementation of ``audit_filter_task()`` might be as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -34,7 +83,7 @@ implementation of audit_filter_task() might be as follows::
 		enum audit_state   state;
 
 		read_lock(&auditsc_lock);
-		/* Note: audit_netlink_sem held by caller. */
+		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 				read_unlock(&auditsc_lock);
@@ -58,7 +107,7 @@ This means that RCU can be easily applied to the read side, as follows::
 		enum audit_state   state;
 
 		rcu_read_lock();
-		/* Note: audit_netlink_sem held by caller. */
+		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry_rcu(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 				rcu_read_unlock();
@@ -69,18 +118,18 @@ This means that RCU can be easily applied to the read side, as follows::
 		return AUDIT_BUILD_CONTEXT;
 	}
 
-The read_lock() and read_unlock() calls have become rcu_read_lock()
+The ``read_lock()`` and ``read_unlock()`` calls have become rcu_read_lock()
 and rcu_read_unlock(), respectively, and the list_for_each_entry() has
-become list_for_each_entry_rcu().  The _rcu() list-traversal primitives
+become list_for_each_entry_rcu().  The **_rcu()** list-traversal primitives
 insert the read-side memory barriers that are required on DEC Alpha CPUs.
 
-The changes to the update side are also straightforward.  A reader-writer
-lock might be used as follows for deletion and insertion::
+The changes to the update side are also straightforward. A reader-writer lock
+might be used as follows for deletion and insertion::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
 	{
-		struct audit_entry  *e;
+		struct audit_entry *e;
 
 		write_lock(&auditsc_lock);
 		list_for_each_entry(e, list, list) {
@@ -113,9 +162,9 @@ Following are the RCU equivalents for these two functions::
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
 	{
-		struct audit_entry  *e;
+		struct audit_entry *e;
 
-		/* Do not use the _rcu iterator here, since this is the only
+		/* No need to use the _rcu iterator here, since this is the only
 		 * deletion routine. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
@@ -139,41 +188,41 @@ Following are the RCU equivalents for these two functions::
 		return 0;
 	}
 
-Normally, the write_lock() and write_unlock() would be replaced by
-a spin_lock() and a spin_unlock(), but in this case, all callers hold
-audit_netlink_sem, so no additional locking is required.  The auditsc_lock
-can therefore be eliminated, since use of RCU eliminates the need for
-writers to exclude readers.  Normally, the write_lock() calls would
-be converted into spin_lock() calls.
+Normally, the ``write_lock()`` and ``write_unlock()`` would be replaced by a
+spin_lock() and a spin_unlock(). But in this case, all callers hold
+``audit_filter_mutex``, so no additional locking is required. The
+``auditsc_lock`` can therefore be eliminated, since use of RCU eliminates the
+need for writers to exclude readers.
 
 The list_del(), list_add(), and list_add_tail() primitives have been
 replaced by list_del_rcu(), list_add_rcu(), and list_add_tail_rcu().
-The _rcu() list-manipulation primitives add memory barriers that are
-needed on weakly ordered CPUs (most of them!).  The list_del_rcu()
-primitive omits the pointer poisoning debug-assist code that would
-otherwise cause concurrent readers to fail spectacularly.
+The **_rcu()** list-manipulation primitives add memory barriers that are needed on
+weakly ordered CPUs (most of them!).  The list_del_rcu() primitive omits the
+pointer poisoning debug-assist code that would otherwise cause concurrent
+readers to fail spectacularly.
 
-So, when readers can tolerate stale data and when entries are either added
-or deleted, without in-place modification, it is very easy to use RCU!
+So, when readers can tolerate stale data and when entries are either added or
+deleted, without in-place modification, it is very easy to use RCU!
 
-Example 2: Handling In-Place Updates
+
+Example 3: Handling In-Place Updates
 ------------------------------------
 
-The system-call auditing code does not update auditing rules in place.
-However, if it did, reader-writer-locked code to do so might look as
-follows (presumably, the field_count is only permitted to decrease,
-otherwise, the added fields would need to be filled in)::
+The system-call auditing code does not update auditing rules in place.  However,
+if it did, the reader-writer-locked code to do so might look as follows
+(assuming only ``field_count`` is updated, otherwise, the added fields would
+need to be filled in)::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
 					 __u32 newaction,
 					 __u32 newfield_count)
 	{
-		struct audit_entry  *e;
-		struct audit_newentry *ne;
+		struct audit_entry *e;
+		struct audit_entry *ne;
 
 		write_lock(&auditsc_lock);
-		/* Note: audit_netlink_sem held by caller. */
+		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
@@ -188,16 +237,16 @@ otherwise, the added fields would need to be filled in)::
 
 The RCU version creates a copy, updates the copy, then replaces the old
 entry with the newly updated entry.  This sequence of actions, allowing
-concurrent reads while doing a copy to perform an update, is what gives
-RCU ("read-copy update") its name.  The RCU code is as follows::
+concurrent reads while making a copy to perform an update, is what gives
+RCU (*read-copy update*) its name.  The RCU code is as follows::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
 					 __u32 newaction,
 					 __u32 newfield_count)
 	{
-		struct audit_entry  *e;
-		struct audit_newentry *ne;
+		struct audit_entry *e;
+		struct audit_entry *ne;
 
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
@@ -215,34 +264,45 @@ RCU ("read-copy update") its name.  The RCU code is as follows::
 		return -EFAULT;		/* No matching rule */
 	}
 
-Again, this assumes that the caller holds audit_netlink_sem.  Normally,
-the reader-writer lock would become a spinlock in this sort of code.
+Again, this assumes that the caller holds ``audit_filter_mutex``.  Normally, the
+writer lock would become a spinlock in this sort of code.
 
-Example 3: Eliminating Stale Data
+Another use of this pattern can be found in the openswitch driver's *connection
+tracking table* code in ``ct_limit_set()``.  The table holds connection tracking
+entries and has a limit on the maximum entries.  There is one such table
+per-zone and hence one *limit* per zone.  The zones are mapped to their limits
+through a hashtable using an RCU-managed hlist for the hash chains. When a new
+limit is set, a new limit object is allocated and ``ct_limit_set()`` is called
+to replace the old limit object with the new one using list_replace_rcu().
+The old limit object is then freed after a grace period using kfree_rcu().
+
+
+Example 4: Eliminating Stale Data
 ---------------------------------
 
-The auditing examples above tolerate stale data, as do most algorithms
+The auditing example above tolerates stale data, as do most algorithms
 that are tracking external state.  Because there is a delay from the
 time the external state changes before Linux becomes aware of the change,
-additional RCU-induced staleness is normally not a problem.
+additional RCU-induced staleness is generally not a problem.
 
 However, there are many examples where stale data cannot be tolerated.
 One example in the Linux kernel is the System V IPC (see the ipc_lock()
-function in ipc/util.c).  This code checks a "deleted" flag under a
-per-entry spinlock, and, if the "deleted" flag is set, pretends that the
+function in ipc/util.c).  This code checks a *deleted* flag under a
+per-entry spinlock, and, if the *deleted* flag is set, pretends that the
 entry does not exist.  For this to be helpful, the search function must
-return holding the per-entry spinlock, as ipc_lock() does in fact do.
+return holding the per-entry lock, as ipc_lock() does in fact do.
+
+.. _quick_quiz:
 
 Quick Quiz:
-	Why does the search function need to return holding the per-entry lock for
-	this deleted-flag technique to be helpful?
+	For the deleted-flag technique to be helpful, why is it necessary
+	to hold the per-entry lock while returning from the search function?
 
-:ref:`Answer to Quick Quiz <answer_quick_quiz_list>`
+:ref:`Answer to Quick Quiz <quick_quiz_answer>`
 
-If the system-call audit module were to ever need to reject stale data,
-one way to accomplish this would be to add a "deleted" flag and a "lock"
-spinlock to the audit_entry structure, and modify audit_filter_task()
-as follows::
+If the system-call audit module were to ever need to reject stale data, one way
+to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
+audit_entry structure, and modify ``audit_filter_task()`` as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -267,20 +327,20 @@ as follows::
 	}
 
 Note that this example assumes that entries are only added and deleted.
-Additional mechanism is required to deal correctly with the
-update-in-place performed by audit_upd_rule().  For one thing,
-audit_upd_rule() would need additional memory barriers to ensure
-that the list_add_rcu() was really executed before the list_del_rcu().
+Additional mechanism is required to deal correctly with the update-in-place
+performed by ``audit_upd_rule()``.  For one thing, ``audit_upd_rule()`` would
+need additional memory barriers to ensure that the list_add_rcu() was really
+executed before the list_del_rcu().
 
-The audit_del_rule() function would need to set the "deleted"
-flag under the spinlock as follows::
+The ``audit_del_rule()`` function would need to set the ``deleted`` flag under the
+spinlock as follows::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
 	{
-		struct audit_entry  *e;
+		struct audit_entry *e;
 
-		/* Do not need to use the _rcu iterator here, since this
+		/* No need to use the _rcu iterator here, since this
 		 * is the only deletion routine. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
@@ -295,6 +355,91 @@ flag under the spinlock as follows::
 		return -EFAULT;		/* No matching rule */
 	}
 
+This too assumes that the caller holds ``audit_filter_mutex``.
+
+
+Example 5: Skipping Stale Objects
+---------------------------------
+
+For some usecases, reader performance can be improved by skipping stale objects
+during read-side list traversal if the object in concern is pending destruction
+after one or more grace periods. One such example can be found in the timerfd
+subsystem. When a ``CLOCK_REALTIME`` clock is reprogrammed - for example due to
+setting of the system time, then all programmed timerfds that depend on this
+clock get triggered and processes waiting on them to expire are woken up in
+advance of their scheduled expiry. To facilitate this, all such timers are added
+to an RCU-managed ``cancel_list`` when they are setup in
+``timerfd_setup_cancel()``::
+
+	static void timerfd_setup_cancel(struct timerfd_ctx *ctx, int flags)
+	{
+		spin_lock(&ctx->cancel_lock);
+		if ((ctx->clockid == CLOCK_REALTIME &&
+		    (flags & TFD_TIMER_ABSTIME) && (flags & TFD_TIMER_CANCEL_ON_SET)) {
+			if (!ctx->might_cancel) {
+				ctx->might_cancel = true;
+				spin_lock(&cancel_lock);
+				list_add_rcu(&ctx->clist, &cancel_list);
+				spin_unlock(&cancel_lock);
+			}
+		}
+		spin_unlock(&ctx->cancel_lock);
+	}
+
+When a timerfd is freed (fd is closed), then the ``might_cancel`` flag of the
+timerfd object is cleared, the object removed from the ``cancel_list`` and
+destroyed::
+
+	int timerfd_release(struct inode *inode, struct file *file)
+	{
+		struct timerfd_ctx *ctx = file->private_data;
+
+		spin_lock(&ctx->cancel_lock);
+		if (ctx->might_cancel) {
+			ctx->might_cancel = false;
+			spin_lock(&cancel_lock);
+			list_del_rcu(&ctx->clist);
+			spin_unlock(&cancel_lock);
+		}
+		spin_unlock(&ctx->cancel_lock);
+
+		hrtimer_cancel(&ctx->t.tmr);
+		kfree_rcu(ctx, rcu);
+		return 0;
+	}
+
+If the ``CLOCK_REALTIME`` clock is set, for example by a time server, the
+hrtimer framework calls ``timerfd_clock_was_set()`` which walks the
+``cancel_list`` and wakes up processes waiting on the timerfd. While iterating
+the ``cancel_list``, the ``might_cancel`` flag is consulted to skip stale
+objects::
+
+	void timerfd_clock_was_set(void)
+	{
+		struct timerfd_ctx *ctx;
+		unsigned long flags;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(ctx, &cancel_list, clist) {
+			if (!ctx->might_cancel)
+				continue;
+			spin_lock_irqsave(&ctx->wqh.lock, flags);
+			if (ctx->moffs != ktime_mono_to_real(0)) {
+				ctx->moffs = KTIME_MAX;
+				ctx->ticks++;
+				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			}
+			spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+		}
+		rcu_read_unlock();
+	}
+
+The key point here is, because RCU-traversal of the ``cancel_list`` happens
+while objects are being added and removed to the list, sometimes the traversal
+can step on an object that has been removed from the list. In this example, it
+is seen that it is better to skip such objects using a flag.
+
+
 Summary
 -------
 
@@ -303,19 +448,21 @@ the most amenable to use of RCU.  The simplest case is where entries are
 either added or deleted from the data structure (or atomically modified
 in place), but non-atomic in-place modifications can be handled by making
 a copy, updating the copy, then replacing the original with the copy.
-If stale data cannot be tolerated, then a "deleted" flag may be used
+If stale data cannot be tolerated, then a *deleted* flag may be used
 in conjunction with a per-entry spinlock in order to allow the search
 function to reject newly deleted data.
 
-.. _answer_quick_quiz_list:
+.. _quick_quiz_answer:
 
 Answer to Quick Quiz:
-	Why does the search function need to return holding the per-entry
-	lock for this deleted-flag technique to be helpful?
+	For the deleted-flag technique to be helpful, why is it necessary
+	to hold the per-entry lock while returning from the search function?
 
 	If the search function drops the per-entry lock before returning,
 	then the caller will be processing stale data in any case.  If it
 	is really OK to be processing stale data, then you don't need a
-	"deleted" flag.  If processing stale data really is a problem,
+	*deleted* flag.  If processing stale data really is a problem,
 	then you need to hold the per-entry lock across all of the code
 	that uses the value that was returned.
+
+:ref:`Back to Quick Quiz <quick_quiz>`
-- 
2.24.0

