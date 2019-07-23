Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724D3C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A93120828
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbfGWKMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55977 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388794AbfGWKMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70ACC30C1351;
        Tue, 23 Jul 2019 10:12:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E56B60BEC;
        Tue, 23 Jul 2019 10:12:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Jul 2019 12:12:51 +0200 (CEST)
Date:   Tue, 23 Jul 2019 12:12:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [GIT PULL] pidfd fixes
Message-ID: <20190723101249.GA8994@redhat.com>
References: <20190722142238.16129-1-christian@brauner.io>
 <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 23 Jul 2019 10:12:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22, Linus Torvalds wrote:
>
> So if we set EXIT_ZOMBIE early, then I think we should change the
> EXIT_DEAD case too. IOW, do something like this on top:
> 
>   --- a/kernel/exit.c
>   +++ b/kernel/exit.c
>   @@ -734,9 +734,10 @@ static void exit_notify(struct task_struct
> *tsk, int group_dead)
>                 autoreap = true;
>         }
> 
>   -     tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
>   -     if (tsk->exit_state == EXIT_DEAD)
>   +     if (autoreap) {
>   +             tsk->exit_state = EXIT_DEAD;
>                 list_add(&tsk->ptrace_entry, &dead);
>   +     }

Yes, this needs cleanups. Actually I was going to suggest another change
below, this way do_notify_pidfd() is only called when it is really needed.
But then I decided a trivial one-liner makes more sense for the start.

I'll try to think. Perhaps we should also change do_notify_parent() to set
p->exit_state, at least if autoreap. Then the early exit_state = EXIT_ZOMBIE
won't look so confusing and we can do more (minor) cleanups.

Oleg.

--- x/kernel/exit.c
+++ x/kernel/exit.c
@@ -182,6 +182,13 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	put_task_struct(tsk);
 }
 
+static void do_notify_pidfd(struct task_struct *task)
+{
+	struct pid *pid;
+
+	pid = task_pid(task);
+	wake_up_all(&pid->wait_pidfd);
+}
 
 void release_task(struct task_struct *p)
 {
@@ -218,6 +225,8 @@ void release_task(struct task_struct *p)
 		zap_leader = do_notify_parent(leader, leader->exit_signal);
 		if (zap_leader)
 			leader->exit_state = EXIT_DEAD;
+
+		do_notify_pidfd(leader);
 	}
 
 	write_unlock_irq(&tasklist_lock);
@@ -710,7 +719,7 @@ static void forget_original_parent(struct task_struct *father,
  */
 static void exit_notify(struct task_struct *tsk, int group_dead)
 {
-	bool autoreap;
+	bool autoreap, xxx;
 	struct task_struct *p, *n;
 	LIST_HEAD(dead);
 
@@ -720,23 +729,22 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	if (group_dead)
 		kill_orphaned_pgrp(tsk->group_leader, NULL);
 
-	if (unlikely(tsk->ptrace)) {
-		int sig = thread_group_leader(tsk) &&
-				thread_group_empty(tsk) &&
-				!ptrace_reparented(tsk) ?
-			tsk->exit_signal : SIGCHLD;
+	autoreap = true;
+	xxx = thread_group_leader(tsk) && thread_group_empty(tsk);
+
+	if (xxx || unlikely(tsk->ptrace)) {
+		int sig = xxx && !ptrace_reparented(tsk)
+			? tsk->exit_signal : SIGCHLD;
 		autoreap = do_notify_parent(tsk, sig);
-	} else if (thread_group_leader(tsk)) {
-		autoreap = thread_group_empty(tsk) &&
-			do_notify_parent(tsk, tsk->exit_signal);
-	} else {
-		autoreap = true;
 	}
 
 	tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
 	if (tsk->exit_state == EXIT_DEAD)
 		list_add(&tsk->ptrace_entry, &dead);
 
+	if (xxx)
+		do_notify_pidfd(tsk);
+
 	/* mt-exec, de_thread() is waiting for group leader */
 	if (unlikely(tsk->signal->notify_count < 0))
 		wake_up_process(tsk->signal->group_exit_task);
--- x/kernel/signal.c
+++ x/kernel/signal.c
@@ -1881,14 +1881,6 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
-{
-	struct pid *pid;
-
-	pid = task_pid(task);
-	wake_up_all(&pid->wait_pidfd);
-}
-
 /*
  * Let a parent know about the death of a child.
  * For a stopped/continued status change, use do_notify_parent_cldstop instead.
@@ -1912,9 +1904,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
-	/* Wake up all pidfd waiters */
-	do_notify_pidfd(tsk);
-
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.

