Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0AFC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99B822512
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bYqDWz3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfGWKZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:25:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfGWKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:25:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so37987538wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PHxhFQt1zapvaqaSkTVoRirg4u/DymzfJXL7JSj+Zko=;
        b=bYqDWz3t5xdPBZs2HwRWiBqi33++e0IuplenCOUJpSWJOc4YewI34ueEeSTu3/zigI
         oYIHNFKqgTs3tZNw1W7x7ZxeONPx3/S+gA6/yDf0wHkyBqeP8FIuzpdLk2dp2Z6+a+aE
         q+uHOvD1oYBcujn+fx+wsP7ip9EPptpEK0wyjJ2urD+idJ8dV3rGIT/bUquZhdaNKCxV
         8uK6dQFElfnlqTNbCdrufsFFXBHlIAIpdHBA+fgHUnxKdzFJwf6H1bJX1ebUrQRRAQMS
         PPBs6FNeCHRLRVR9niOFuEXjYyxGp6hQCMoHwaYVxqDN8P63QZcWDF0Zg0PQ15ohgi5U
         oU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PHxhFQt1zapvaqaSkTVoRirg4u/DymzfJXL7JSj+Zko=;
        b=IBWYVrozDg3BLjNMIIPzoFetztGZHb+Ub6u5OUcD6jqbZUdN2zjGNjfdIdsRThgXoG
         yU0YTPIOMbyTe0smH7JIN2rcS1Yfdzv1qB+6fA/Mo39weuAvfJ5Hfo5I6d5jeATOg023
         DgOD31//fjvEDyiw2GiTLgD5eyg9Smcb06Xuxh36x5H3TV+K4s4EOPxHm8NnwD9urFXS
         ztI8E3ecrNqc+KT0b5NpLzYCtowYVMl7g3oXBGpGfcYzlN6VnC/4xTrOJO+hk5FEfBSA
         lVfSHpSz86u+aSMXMOvxJbKGovkr5CkLI9Ob6KNeVx8VNjUBS45R2iNXHqku9I8t/GOy
         mGoA==
X-Gm-Message-State: APjAAAWGwFla2lWp00/IN5Iz1/QRzxfJFop7D/Tm9U9ZmQ4HIIxrREOz
        hNQQQuXOVUxOTxpW+HmuesQ=
X-Google-Smtp-Source: APXvYqziErWJLj+mI3+RvUrbyqbn4AZW6CeNE0C9JKmFr1inzFDRdyWk37UoS/nz5tIydGWd/VWHJg==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr69535390wmf.52.1563877548220;
        Tue, 23 Jul 2019 03:25:48 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id s188sm33669288wmf.40.2019.07.23.03.25.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:25:47 -0700 (PDT)
Date:   Tue, 23 Jul 2019 12:25:46 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [GIT PULL] pidfd fixes
Message-ID: <20190723102545.3sotcok2tqjjntea@brauner.io>
References: <20190722142238.16129-1-christian@brauner.io>
 <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
 <20190723101249.GA8994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190723101249.GA8994@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:12:49PM +0200, Oleg Nesterov wrote:
> On 07/22, Linus Torvalds wrote:
> >
> > So if we set EXIT_ZOMBIE early, then I think we should change the
> > EXIT_DEAD case too. IOW, do something like this on top:
> > 
> >   --- a/kernel/exit.c
> >   +++ b/kernel/exit.c
> >   @@ -734,9 +734,10 @@ static void exit_notify(struct task_struct
> > *tsk, int group_dead)
> >                 autoreap = true;
> >         }
> > 
> >   -     tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
> >   -     if (tsk->exit_state == EXIT_DEAD)
> >   +     if (autoreap) {
> >   +             tsk->exit_state = EXIT_DEAD;
> >                 list_add(&tsk->ptrace_entry, &dead);
> >   +     }
> 
> Yes, this needs cleanups. Actually I was going to suggest another change
> below, this way do_notify_pidfd() is only called when it is really needed.
> But then I decided a trivial one-liner makes more sense for the start.

Yeah, that was my thinking exactly.

> 
> I'll try to think. Perhaps we should also change do_notify_parent() to set
> p->exit_state, at least if autoreap. Then the early exit_state = EXIT_ZOMBIE
> won't look so confusing and we can do more (minor) cleanups.

You mind sending that as a proper patch?
I also have a few more cleanups for other parts I intend to send later
this week. I'd pick this one up too.

> 
> Oleg.
> 
> --- x/kernel/exit.c
> +++ x/kernel/exit.c
> @@ -182,6 +182,13 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
>  	put_task_struct(tsk);
>  }
>  
> +static void do_notify_pidfd(struct task_struct *task)
> +{
> +	struct pid *pid;
> +
> +	pid = task_pid(task);
> +	wake_up_all(&pid->wait_pidfd);
> +}
>  
>  void release_task(struct task_struct *p)
>  {
> @@ -218,6 +225,8 @@ void release_task(struct task_struct *p)
>  		zap_leader = do_notify_parent(leader, leader->exit_signal);
>  		if (zap_leader)
>  			leader->exit_state = EXIT_DEAD;
> +
> +		do_notify_pidfd(leader);
>  	}
>  
>  	write_unlock_irq(&tasklist_lock);
> @@ -710,7 +719,7 @@ static void forget_original_parent(struct task_struct *father,
>   */
>  static void exit_notify(struct task_struct *tsk, int group_dead)
>  {
> -	bool autoreap;
> +	bool autoreap, xxx;

In case you don't mind the length of it how about:

bool autoreap, leading_empty_thread_group;

It's not the prettiest names but having rather descriptive var names in
these codepaths seems like a good idea to me.
It also reads very naturally further below:

if (leading_empty_thread_group || unlikely(tsk->ptrace)) {
 	int sig = leading_empty_thread_group && !ptrace_reparented(tsk)
 		? tsk->exit_signal : SIGCHLD;

>  	struct task_struct *p, *n;
>  	LIST_HEAD(dead);
>  
> @@ -720,23 +729,22 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	if (group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
> -	if (unlikely(tsk->ptrace)) {
> -		int sig = thread_group_leader(tsk) &&
> -				thread_group_empty(tsk) &&
> -				!ptrace_reparented(tsk) ?
> -			tsk->exit_signal : SIGCHLD;
> +	autoreap = true;
> +	xxx = thread_group_leader(tsk) && thread_group_empty(tsk);
> +
> +	if (xxx || unlikely(tsk->ptrace)) {
> +		int sig = xxx && !ptrace_reparented(tsk)
> +			? tsk->exit_signal : SIGCHLD;
>  		autoreap = do_notify_parent(tsk, sig);
> -	} else if (thread_group_leader(tsk)) {
> -		autoreap = thread_group_empty(tsk) &&
> -			do_notify_parent(tsk, tsk->exit_signal);
> -	} else {
> -		autoreap = true;
>  	}
>  
>  	tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
>  	if (tsk->exit_state == EXIT_DEAD)
>  		list_add(&tsk->ptrace_entry, &dead);
>  
> +	if (xxx)
> +		do_notify_pidfd(tsk);
> +
>  	/* mt-exec, de_thread() is waiting for group leader */
>  	if (unlikely(tsk->signal->notify_count < 0))
>  		wake_up_process(tsk->signal->group_exit_task);
> --- x/kernel/signal.c
> +++ x/kernel/signal.c
> @@ -1881,14 +1881,6 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	return ret;
>  }
>  
> -static void do_notify_pidfd(struct task_struct *task)
> -{
> -	struct pid *pid;
> -
> -	pid = task_pid(task);
> -	wake_up_all(&pid->wait_pidfd);
> -}
> -
>  /*
>   * Let a parent know about the death of a child.
>   * For a stopped/continued status change, use do_notify_parent_cldstop instead.
> @@ -1912,9 +1904,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	BUG_ON(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  
> -	/* Wake up all pidfd waiters */
> -	do_notify_pidfd(tsk);
> -
>  	if (sig != SIGCHLD) {
>  		/*
>  		 * This is only possible if parent == real_parent.
> 
