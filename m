Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F8C206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IRqbM4Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDZO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:58:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33611 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDZO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:58:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so4920019wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=El9zRuDtiQOhXmxCPgHuzVsiz1WJMBZpxXepcS6HILU=;
        b=IRqbM4AbW1nVoJmEiGjUsm9Xv3ZUIfs9Di//OllrN+fQEpJomJ0tik/I+ta4zEpU2t
         CiXDK1QhhrhhhLjlfvb1Vq3wZSKtYssTyLkeHvPpW765abwQLQgh/U981UZzq682FKY9
         22JCvNOtigTrFjvMc/cKSG5y9jUWH/wnHzt+UKGI1/XlSfZu6dcizLUNv0L4z5SACCHt
         T3mvru/XGuDqsECEzReCDfaoDNKiANPa2F3geqVt4WdknkvOKy0ln8vauKT06R8qbF56
         wE8r6ugFV+Gb6FA8u9I1CLq/a4jV4fzM2/xJiwdaJLnbA+ViE4CRmfrjZPR4dsgjq14l
         fpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=El9zRuDtiQOhXmxCPgHuzVsiz1WJMBZpxXepcS6HILU=;
        b=YPqlyhbaW+yjI9bZfhuY/EjhCuMYsMv68GBpE2EORzG70OVvJ1Ynp8cTAyI41cSXw4
         YSkrdQ4WGOl9gxyQUJm5WvgIlhR4gDbHZDQBMqnE6BnBQVo4WPSTUQeRGf6oqKU0sTkO
         Qw6z12e9xIK6HB9WHo5cblmVUeLRH1o6NZqSjB2ssYnjDPeYvPhVjCnIaAM88PHkFI0y
         K8dGprNo+YxwDakXXCz10OskAS7n3RDXjq5TPA4Exle8KKUb2rUPZs/7opRz4Nln8Bwm
         Ps3wH1ZzqT57canJd5cor1BU9eiTqDEkk0U1zKPp/9gpvvY4rptbcqU2FWb4TWD4+LjR
         +svg==
X-Gm-Message-State: APjAAAVYJnpa1AQwsr53Wop9GvGgE53QS8Zc7VMtnF4KXzXOHWg+0C7y
        aY9Oyp3MO/bt+wyC+QaEIGIOQfJqzEFXCg==
X-Google-Smtp-Source: APXvYqxiSvUUBgyZSmPFzk2xuuwnYDIL11Pk9m03f/siLiJ/qfVS9Xtw9KjPEBTLcaBkUlbWKVIX4A==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr12408074wrv.131.1556290718529;
        Fri, 26 Apr 2019 07:58:38 -0700 (PDT)
Received: from brauner.io (v22018046084765073.goodsrv.de. [185.183.158.195])
        by smtp.gmail.com with ESMTPSA id t15sm27608503wmt.2.2019.04.26.07.58.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 07:58:37 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:58:35 +0200
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
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v1 1/2] Add polling support to pidfd
Message-ID: <20190426145834.awxkctdtufw27deo@brauner.io>
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

That should be of the form:

Cc: First Name <email@address.com>


> Co-developed-by: Daniel Colascione <dancol@google.com>

Every CDB needs to come with a SOB.

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
