Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D81C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E2206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="I5V2ZQB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfDYWYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:24:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35808 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfDYWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:24:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so1483112ede.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 15:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zLWYfQ8wtfMkU0RYd/H+oiQ3kA9CQ8WRFYo7pkiEaUw=;
        b=I5V2ZQB43GbAa8f1I1We+8lAS168b4VKR/Pote5rEk1yb47u732X32TlQaLmVmqLAh
         n03qRSZJB7seuX/d7aytHMsdBVeF9qYJ4ftI+/lPKcK4hPaInfPdEFhNKI0yc0/CRr1z
         FS8ehQJjmV48262HJjkBTLntA8z1uEroVOuJz1fxBV8Q2isdUNH+boYyI1XoyROIZNJA
         1tIT+gm5eMJYFVS1MHWxBc8gSY1H4hOV02/96d3uoX2xBMvx7ALndw6J+nUP5SAm2Txm
         GVGoeH2jUXUSRDGU4kzAEoXr5y/kI/ohUBR1CUKXq6pagzRJD4lJRH88vWgus3z3zzYd
         RRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLWYfQ8wtfMkU0RYd/H+oiQ3kA9CQ8WRFYo7pkiEaUw=;
        b=HIG+QHdO4EL+FruWeQ1+6r0dqSrk7U4Zmk3Qqcn9LYfZC7r+jdJ/x5uB1+0K8G81H0
         ue+1PCQ4SrD7vMd4o5SVKIdxVhJ9pLH3ve2I518EUooMWdGWQPKPtBEO/aEzfxJTaPDI
         9BTZ3BoISFVHIwsqEpjz02ZKgTcK8Wbs+HnK44bsiIxO4/fzblbFbzHhrYobHtZHNoag
         iziPUUOH/zNZyeg7aZz5YMGGJeiqlD4heP6SAYBy/0iny467v2tQmuvg1xFMnPEQe29U
         vX2rT41fVhPRWRG+4nHt611obXUjptp0OtDCKjHLBv9Fv3mrDgWDqy/N6Y81D+3xBDdg
         aYEg==
X-Gm-Message-State: APjAAAVm9TrtErvUlIdICyXYzzYNqhYThrSvIGChngOxYt+F3cebMwFx
        rRa0VSVwRGO7F7S1u3dyJpyO6A==
X-Google-Smtp-Source: APXvYqzNZyGGrXHonxloPii7SqC+nObPzlg5gChXyHG8X2Frz2ERFiexaVN5xee6eucll+c3ua62YA==
X-Received: by 2002:a17:906:839a:: with SMTP id p26mr20119426ejx.254.1556231046208;
        Thu, 25 Apr 2019 15:24:06 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id a14sm5216757edc.61.2019.04.25.15.24.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 15:24:05 -0700 (PDT)
Date:   Fri, 26 Apr 2019 00:24:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, sspatil@google.com,
        jannh@google.com, surenb@google.com, timmurray@google.com,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        torvalds@linux-foundation.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jann@thejh.net>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Add polling support to pidfd
Message-ID: <20190425222359.sqhboc4x4daznr6r@brauner.io>
References: <20190425190010.46489-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425190010.46489-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:00:09PM -0400, Joel Fernandes (Google) wrote:
> pidfd are file descriptors referring to a process created with the
> CLONE_PIDFD clone(2) flag. Android low memory killer (LMK) needs pidfd
> polling support to replace code that currently checks for existence of
> /proc/pid for knowing that a process that is signalled to be killed has
> died, which is both racy and slow. The pidfd poll approach is race-free,
> and also allows the LMK to do other things (such as by polling on other
> fds) while awaiting the process being killed to die.

Thanks for the patch!

Ok, let me be a little bit anal.
Please start the commit message with what this patch does and then add
the justification why. You just say the "pidfd-poll" approach. You can
probably assume that CLONE_PIDFD is available for this patch. So
something like:

"This patch makes pidfds pollable. Specifically, it allows listeners to
be informed when the process the pidfd referes to exits. This patch only
introduces the ability to poll thread-group leaders since pidfds
currently can only reference those..."

Then justify the use-case and then go into implementation details.
That's usually how I would think about this:
- Change the codebase to do X
- Why do we need X
- Are there any technical details worth mentioning in the commit message
(- Are there any controversial points that people stumbled upon but that
  have been settled sufficiently.)

> pidfd are file descriptors referring to a process created with the
> CLONE_PIDFD clone(2) flag. Android low memory killer (LMK) needs pidfd
> polling support to replace code that currently checks for existence of
> /proc/pid for knowing that a process that is signalled to be killed has
> died, which is both racy and slow. The pidfd poll approach is race-free,
> and also allows the LMK to do other things (such as by polling on other
> fds) while awaiting the process being killed to die.

> 
> It prevents a situation where a PID is reused between when LMK sends a
> kill signal and checks for existence of the PID, since the wrong PID is
> now possibly checked for existence.
> 
> In this patch, we follow the same existing mechanism in the kernel used
> when the parent of the task group is to be notified (do_notify_parent).
> This is when the tasks waiting on a poll of pidfd are also awakened.
> 
> We have decided to include the waitqueue in struct pid for the following
> reasons:
> 1. The wait queue has to survive for the lifetime of the poll. Including
> it in task_struct would not be option in this case because the task can
> be reaped and destroyed before the poll returns.
> 
> 2. By including the struct pid for the waitqueue means that during
> de_thread(), the new thread group leader automatically gets the new
> waitqueue/pid even though its task_struct is different.
> 
> Appropriate test cases are added in the second patch to provide coverage
> of all the cases the patch is handling.
> 
> Andy had a similar patch [1] in the past which was a good reference
> however this patch tries to handle different situations properly related
> to thread group existence, and how/where it notifies. And also solves
> other bugs (waitqueue lifetime).  Daniel had a similar patch [2]
> recently which this patch supercedes.
> 
> [1] https://lore.kernel.org/patchwork/patch/345098/
> [2] https://lore.kernel.org/lkml/20181029175322.189042-1-dancol@google.com/
> 
> Cc: luto@amacapital.net
> Cc: rostedt@goodmis.org
> Cc: dancol@google.com
> Cc: sspatil@google.com
> Cc: christian@brauner.io
> Cc: jannh@google.com
> Cc: surenb@google.com
> Cc: timmurray@google.com
> Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
> Cc: torvalds@linux-foundation.org
> Cc: kernel-team@android.com

These should all be in the form:

Cc: Firstname Lastname <email@address.com>

There are people missing from the Cc that really should be there...

Even though he usually doesn't respond that often, please Cc Al on this.
If he responds it's usually rather important.

Oleg has reviewed your RFC patch quite substantially and given valuable
feedback and has an opinion on this thing and is best acquainted with
the exit code. So please add him to the Cc of the commit message in the
appropriate form and also add him to the Cc of the thread.

Probably also want linux-api for good measure since a lot of people are
subscribed that would care about pollable pidfds. I'd also add Kees
since he had some interest in this work and David (Howells).

> Co-developed-by: Daniel Colascione <dancol@google.com>

Every CDB needs to give a SOB as well.

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
> 
> RFC -> v1:
> * Based on CLONE_PIDFD patches: https://lwn.net/Articles/786244/
> * Updated selftests.
> * Renamed poll wake function to do_notify_pidfd.
> * Removed depending on EXIT flags
> * Removed POLLERR flag since semantics are controversial and
>   we don't have usecases for it right now (later we can add if there's
>   a need for it).
> 
>  include/linux/pid.h |  3 +++
>  kernel/fork.c       | 33 +++++++++++++++++++++++++++++++++
>  kernel/pid.c        |  2 ++
>  kernel/signal.c     | 14 ++++++++++++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 3c8ef5a199ca..1484db6ca8d1 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PID_H
>  
>  #include <linux/rculist.h>
> +#include <linux/wait.h>
>  
>  enum pid_type
>  {
> @@ -60,6 +61,8 @@ struct pid
>  	unsigned int level;
>  	/* lists of tasks that use this pid */
>  	struct hlist_head tasks[PIDTYPE_MAX];
> +	/* wait queue for pidfd notifications */
> +	wait_queue_head_t wait_pidfd;
>  	struct rcu_head rcu;
>  	struct upid numbers[1];
>  };
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5525837ed80e..fb3b614f6456 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1685,8 +1685,41 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  }
>  #endif
>  
> +static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
> +{
> +	struct task_struct *task;
> +	struct pid *pid;
> +	int poll_flags = 0;
> +
> +	/*
> +	 * tasklist_lock must be held because to avoid racing with
> +	 * changes in exit_state and wake up. Basically to avoid:
> +	 *
> +	 * P0: read exit_state = 0
> +	 * P1: write exit_state = EXIT_DEAD
> +	 * P1: Do a wake up - wq is empty, so do nothing
> +	 * P0: Queue for polling - wait forever.
> +	 */
> +	read_lock(&tasklist_lock);
> +	pid = file->private_data;
> +	task = pid_task(pid, PIDTYPE_PID);
> +	WARN_ON_ONCE(task && !thread_group_leader(task));
> +
> +	if (!task || (task->exit_state && thread_group_empty(task)))
> +		poll_flags = POLLIN | POLLRDNORM;

So we block until the thread-group is empty? Hm, the thread-group leader
remains in zombie state until all threads are gone. Should probably just
be a short comment somewhere that callers are only informed about a
whole thread-group exit and not about when the thread-group leader has
actually exited.

I would like the ability to extend this interface in the future to allow
for actually reading data from the pidfd on EPOLLIN.
POSIX specifies that POLLIN and POLLRDNORM are set even if the
message to be read is zero. So one cheap way of doing this would
probably be to do a 0 read/ioctl. That wouldn't hurt your very limited
usecase and people could test whether the read returned non-0 data and
if so they know this interface got extended. If we never extend it here
it won't matter.

> +
> +	if (!poll_flags)
> +		poll_wait(file, &pid->wait_pidfd, pts);
> +
> +	read_unlock(&tasklist_lock);
> +
> +	return poll_flags;
> +}


> +
> +
>  const struct file_operations pidfd_fops = {
>  	.release = pidfd_release,
> +	.poll = pidfd_poll,
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = pidfd_show_fdinfo,
>  #endif
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..5c90c239242f 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -214,6 +214,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  	for (type = 0; type < PIDTYPE_MAX; ++type)
>  		INIT_HLIST_HEAD(&pid->tasks[type]);
>  
> +	init_waitqueue_head(&pid->wait_pidfd);
> +
>  	upid = pid->numbers + ns->level;
>  	spin_lock_irq(&pidmap_lock);
>  	if (!(ns->pid_allocated & PIDNS_ADDING))
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 1581140f2d99..16e7718316e5 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1800,6 +1800,17 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	return ret;
>  }
>  
> +static void do_notify_pidfd(struct task_struct *task)

Maybe a short command that this helper can only be called when we know
that task is a thread-group leader wouldn't hurt so there's no confusion
later.

> +{
> +	struct pid *pid;
> +
> +	lockdep_assert_held(&tasklist_lock);
> +
> +	pid = get_task_pid(task, PIDTYPE_PID);
> +	wake_up_all(&pid->wait_pidfd);
> +	put_pid(pid);
> +}
> +
>  /*
>   * Let a parent know about the death of a child.
>   * For a stopped/continued status change, use do_notify_parent_cldstop instead.
> @@ -1823,6 +1834,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	BUG_ON(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  
> +	/* Wake up all pidfd waiters */
> +	do_notify_pidfd(tsk);
> +
>  	if (sig != SIGCHLD) {
>  		/*
>  		 * This is only possible if parent == real_parent.
> -- 
> 2.21.0.593.g511ec345e18-goog
