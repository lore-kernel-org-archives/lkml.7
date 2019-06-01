Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E5C28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EC6271BC
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="opV0nyWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfFAJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 05:41:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36521 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFAJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:41:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id m22so11630376ljc.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIaQdPqCvZFyBC5nfnFv5TPdjUZvyzxkA6GFPJG3yUQ=;
        b=opV0nyWc1cfqF5+eCYa/2JsuB0oELlPBifZETNCSuiFa3xegYl7KWCYHB9ZOGFWg6J
         eBAbt43SRAhijpdN5WhaeARcqbcgZyOIrfpDvOAGF/3kX89AtUL2mQUk8ohSuFN6Yygo
         F6YfIHM+SVq1swBigM/ljoCeHlKEql3ny6xLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIaQdPqCvZFyBC5nfnFv5TPdjUZvyzxkA6GFPJG3yUQ=;
        b=aIGyKSLQOC2wh/hVr7fZFa7RE9H7bc0f92bxM+jUDG2gvaAc3/59TJVvLD7VSyCx8l
         WYcpGjZlQP0pDJzPs1UUncDO1dCGlm+6rLWFigktjfnsR4QBjl1FUtMp5x7y2d8C6MeL
         4Do5kttI/7DlG2UWW4Ww61NtQCR/jU1Fv7q6dMuke4cWaCoKInPMPY9GM79sDhtzxvGm
         LfrJ+LFzVmDKNR9IGUkU7rP3KJuJIy7XS1I6PGX/AOg3PNrUoACvU9B1HUXqIh3BQuCK
         XDyxDhhS6fJuCcfzzK1n19fLOlfGtTNkfSyW9349IJoyB+cuGjZurhVv5gtTaj08T/sN
         BP/A==
X-Gm-Message-State: APjAAAXWHAEWdRUG1DwpvPPYZKaVwxtq4ZE78/H89aXEEt4cz+muOwQU
        vdXPPCBJzl7mQO1Ti4UmBbE2yfBTUJ1E/ne2RowjiE8Jiz8=
X-Google-Smtp-Source: APXvYqwx/u4RMbLNpf+y8mmaQ1jG5mIOLHyMkzYpgjl22COUQQq82LGwCZNwFTo9GDwZvgkn7LcJGCLmiTU0M3E3XRo=
X-Received: by 2002:a2e:9742:: with SMTP id f2mr8710125ljj.184.1559382099006;
 Sat, 01 Jun 2019 02:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190601093926.28158-1-joel@joelfernandes.org>
In-Reply-To: <20190601093926.28158-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 1 Jun 2019 05:41:27 -0400
Message-ID: <CAEXW_YQK2Y-UknCgOPe64mPCTM-hXbovF-6vSB44cag8aU8Ang@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] doc/rcu: Add some more listRCU patterns in the kernel
To:     LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.com>
Cc:     rcu <rcu@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        kernel-team <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to CC +Neil Brown , will do in the next posting, thanks!

On Sat, Jun 1, 2019 at 5:39 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> We keep the initially written audit examples and add to it, since the
> code that audit has is still relevant even though slightly different in
> the kernel.
>
> Cc: rcu@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/RCU/listRCU.txt | 154 +++++++++++++++++++++++++++++++---
>  1 file changed, 144 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
> index adb5a3782846..af5bf1bd689c 100644
> --- a/Documentation/RCU/listRCU.txt
> +++ b/Documentation/RCU/listRCU.txt
> @@ -7,8 +7,54 @@ is that all of the required memory barriers are included for you in
>  the list macros.  This document describes several applications of RCU,
>  with the best fits first.
>
> -
> -Example 1: Read-Side Action Taken Outside of Lock, No In-Place Updates
> +Example 1: Read-mostly list: Deferred Destruction
> +
> +A widely used usecase for RCU lists in the kernel is lockless iteration over
> +all processes in the system. task_struct::tasks represents the list node that
> +links all the processes. The list can be traversed in parallel to any list
> +additions or removals.
> +
> +The traversal of the list is done using for_each_process() which is defined by
> +the 2 macros:
> +
> +#define next_task(p) \
> +       list_entry_rcu((p)->tasks.next, struct task_struct, tasks)
> +
> +#define for_each_process(p) \
> +       for (p = &init_task ; (p = next_task(p)) != &init_task ; )
> +
> +The code traversing the list of all processes typically looks like:
> +rcu_read_lock();
> +for_each_process(p) {
> +       /* Do something with p */
> +}
> +rcu_read_unlock();
> +
> +Thes code (simplified) removing a process from the task lists is in
> +release_task():
> +
> +void release_task(struct task_struct *p)
> +{
> +       write_lock(&tasklist_lock);
> +       list_del_rcu(&p->tasks);
> +       write_unlock(&tasklist_lock);
> +       call_rcu(&p->rcu, delayed_put_task_struct);
> +}
> +
> +When a process exits, release_task() calls list_del_rcu(&p->tasks) to remove
> +the task from the list of all tasks, under tasklist_lock writer lock
> +protection. The tasklist_lock prevents concurrent list adds/removes from
> +corrupting the list. Readers using for_each_process() are not protected with
> +the tasklist_lock. To prevent readers from appearing to notice changes in the
> +list pointers, the task_struct object is freed only after one more more grace
> +periods elapse (with the help of call_rcu). This deferring of destruction
> +ensures that any readers traversing the list will see valid p->tasks.next
> +pointers and deletion/freeing can happen in parallel to traversal of the list.
> +This pattern is also called an "existence lock" sometimes, since RCU makes sure
> +the object exists in memory as long as readers exist, that are traversing.
> +
> +
> +Example 2: Read-Side Action Taken Outside of Lock, No In-Place Updates
>
>  The best applications are cases where, if reader-writer locking were
>  used, the read-side lock would be dropped before taking any action
> @@ -32,7 +78,7 @@ implementation of audit_filter_task() might be as follows:
>                 enum audit_state   state;
>
>                 read_lock(&auditsc_lock);
> -               /* Note: audit_netlink_sem held by caller. */
> +               /* Note: audit_filter_mutex held by caller. */
>                 list_for_each_entry(e, &audit_tsklist, list) {
>                         if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
>                                 read_unlock(&auditsc_lock);
> @@ -56,7 +102,7 @@ This means that RCU can be easily applied to the read side, as follows:
>                 enum audit_state   state;
>
>                 rcu_read_lock();
> -               /* Note: audit_netlink_sem held by caller. */
> +               /* Note: audit_filter_mutex held by caller. */
>                 list_for_each_entry_rcu(e, &audit_tsklist, list) {
>                         if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
>                                 rcu_read_unlock();
> @@ -139,7 +185,7 @@ Following are the RCU equivalents for these two functions:
>
>  Normally, the write_lock() and write_unlock() would be replaced by
>  a spin_lock() and a spin_unlock(), but in this case, all callers hold
> -audit_netlink_sem, so no additional locking is required.  The auditsc_lock
> +audit_filter_mutex, so no additional locking is required.  The auditsc_lock
>  can therefore be eliminated, since use of RCU eliminates the need for
>  writers to exclude readers.  Normally, the write_lock() calls would
>  be converted into spin_lock() calls.
> @@ -155,7 +201,7 @@ So, when readers can tolerate stale data and when entries are either added
>  or deleted, without in-place modification, it is very easy to use RCU!
>
>
> -Example 2: Handling In-Place Updates
> +Example 3: Handling In-Place Updates
>
>  The system-call auditing code does not update auditing rules in place.
>  However, if it did, reader-writer-locked code to do so might look as
> @@ -171,7 +217,7 @@ otherwise, the added fields would need to be filled in):
>                 struct audit_newentry *ne;
>
>                 write_lock(&auditsc_lock);
> -               /* Note: audit_netlink_sem held by caller. */
> +               /* Note: audit_filter_mutex held by caller. */
>                 list_for_each_entry(e, list, list) {
>                         if (!audit_compare_rule(rule, &e->rule)) {
>                                 e->rule.action = newaction;
> @@ -213,13 +259,23 @@ RCU ("read-copy update") its name.  The RCU code is as follows:
>                 return -EFAULT;         /* No matching rule */
>         }
>
> -Again, this assumes that the caller holds audit_netlink_sem.  Normally,
> +Again, this assumes that the caller holds audit_filter_mutex.  Normally,
>  the reader-writer lock would become a spinlock in this sort of code.
>
> +Another use of this pattern can be found in the openswitch driver's "connection
> +tracking table" code (ct_limit_set()). The table holds connection tracking
> +entries and has a limit on the maximum entries. There is one such table
> +per-zone and hence one "limit" per zone. The zones are mapped to their limits
> +through a hashtable using an RCU-managed hlist for the hash chains. When a new
> +limit is to be set, a new limit object is allocated and ct_limit_set() is
> +called to replace the old limit object with the new one using
> +list_replace_rcu(). The old limit object is then freed after a grace period
> +using kfree_rcu().
> +
>
> -Example 3: Eliminating Stale Data
> +Example 4: Eliminating Stale Data
>
> -The auditing examples above tolerate stale data, as do most algorithms
> +The auditing exampes above tolerates stale data, as do most algorithms
>  that are tracking external state.  Because there is a delay from the
>  time the external state changes before Linux becomes aware of the change,
>  additional RCU-induced staleness is normally not a problem.
> @@ -291,6 +347,84 @@ flag under the spinlock as follows:
>         }
>
>
> +EXAMPLE 5: Skipping Stale Objects
> +
> +Stale data can also be eliminated for performance reasons since it is pointless
> +to process items in a list, if the object is being destroyed.  One such example
> +can be found in the timerfd subsystem. When a CLOCK_REALTIME clock is
> +reprogrammed - for example due to setting of the system time, then all programmed
> +timerfds that depend on this clock get triggered and processes waiting on them
> +to expire are woken up in advance of their scheduled expiry. To facilitate
> +this, all such timers are added to a 'cancel_list' when they are setup in
> +timerfd_setup_cancel:
> +
> +static void timerfd_setup_cancel(struct timerfd_ctx *ctx, int flags)
> +{
> +       spin_lock(&ctx->cancel_lock);
> +       if ((ctx->clockid == CLOCK_REALTIME &&
> +           (flags & TFD_TIMER_ABSTIME) && (flags & TFD_TIMER_CANCEL_ON_SET)) {
> +               if (!ctx->might_cancel) {
> +                       ctx->might_cancel = true;
> +                       spin_lock(&cancel_lock);
> +                       list_add_rcu(&ctx->clist, &cancel_list);
> +                       spin_unlock(&cancel_lock);
> +               }
> +       }
> +       spin_unlock(&ctx->cancel_lock);
> +}
> +
> +When a timerfd is freed (fd is closed), then the might_cancel flag of the
> +timerfd object is cleared, the object removed from the cancel_list and destroyed:
> +
> +int timerfd_release(struct inode *inode, struct file *file)
> +{
> +       struct timerfd_ctx *ctx = file->private_data;
> +
> +       spin_lock(&ctx->cancel_lock);
> +       if (ctx->might_cancel) {
> +               ctx->might_cancel = false;
> +               spin_lock(&cancel_lock);
> +               list_del_rcu(&ctx->clist);
> +               spin_unlock(&cancel_lock);
> +       }
> +       spin_unlock(&ctx->cancel_lock);
> +
> +       hrtimer_cancel(&ctx->t.tmr);
> +       kfree_rcu(ctx, rcu);
> +       return 0;
> +}
> +
> +If the CLOCK_REALTIME clock is set, for example by a time server, the hrtimer
> +framework calls timerfd_clock_was_set() which walks the cancel_list and wakes
> +up processes waiting on the timerfd. While iterating the cancel list, the
> +might_cancel flag is consulted to skip stale objects:
> +
> +void timerfd_clock_was_set(void)
> +{
> +       struct timerfd_ctx *ctx;
> +       unsigned long flags;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(ctx, &cancel_list, clist) {
> +               if (!ctx->might_cancel)
> +                       continue;
> +               spin_lock_irqsave(&ctx->wqh.lock, flags);
> +               if (ctx->moffs != ktime_mono_to_real(0)) {
> +                       ctx->moffs = KTIME_MAX;
> +                       ctx->ticks++;
> +                       wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> +               }
> +               spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +       }
> +       rcu_read_unlock();
> +}
> +
> +The key point here is, because RCU-traversal of the cancel_list happens while
> +objects are being added and removed to the list, sometimes the traversal can
> +step on an object that has been removed from the list. In this example, it is
> +seen that it is better to skip such objects using a flag.
> +
> +
>  Summary
>
>  Read-mostly list-based data structures that can tolerate stale data are
> --
> 2.22.0.rc1.311.g5d7573a151-goog
>
