Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB0C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341692087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VLpyKurK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393207AbfHBNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:19:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37707 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393185AbfHBNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:19:48 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so32287715iog.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDfH89TOWdqOqnUJpz1Xn0XGQFvLVnvsXuX4C0+q0Fc=;
        b=VLpyKurKar6KfTshBHaXjM/LfLUKPbkWN4PV1RotQzaHGOB/Smnpn9vQhb1N3f7VwN
         FZaOY01CSrQLJK+VbG0/mN55sUpe0Wj/Gi8lM9yABgE8PTKSNTfZXEgoHGLsCMwez4Ns
         rDuzb3vgqyIopxd2nz+biuGvx1rBfF/jPzsY1n+trjGq7055yJ40kQdP++ZmQHezOEJX
         Eg+HNvmFON7ZR8oUpTkYgqLkkrO13cVjeIzHfGQ+aqtII4VETwHp0u6n3kkCns6caPqW
         qEDlc8TyXyDR1360pRQ3WsxeeU51Hkuywo8eCZzcfsnpVW50tmO63o4evhdaxe+PxMWv
         1hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDfH89TOWdqOqnUJpz1Xn0XGQFvLVnvsXuX4C0+q0Fc=;
        b=HcCfmAF9xP+MkC1lnqx1en8uOYPVMuktwBrNIEXMXliVknslo5WyZmX55XG9+QiQDt
         hWyemkMWvbqjQcVvbcJzt/PxHQAg/5nrZjzXARzrq8BlHZypJ9D7CBjjcfD0ydxQfXiC
         lutyIMKpDRnaFIT0lzo/dfLD9ZUrROnIqzzbMmlXe8q7SLO1/wmrkjDB5/R45HgoJYGK
         iqA83L/95eOk9hQRbhIfEgNCde8TRWh3ntnSs0iavGCEsdfEeV6iMG17iM6jCnfBbZX3
         AXPFJzM+kuRT8EcxwpWNlQD/XyNbl9g0JJf/9rR13hcR2KHirAwcKfGfX4cyoMvXqfL4
         0ehw==
X-Gm-Message-State: APjAAAV9ttdEYqnaNytehyteCsqW6PB/j26Rs6FG6S9TfMzcrYfa5LGT
        IuprI5mTbsb9EEN1MafH3G5es8IiuIk=
X-Google-Smtp-Source: APXvYqyKCKukCx1vf3nlIe49GPE9M2UHxkAmD4zfC2Z8PpY46sCciMj3c7jnplib+tIjlb6weB9BDA==
X-Received: by 2002:a02:a07:: with SMTP id 7mr140478035jaw.65.1564751986894;
        Fri, 02 Aug 2019 06:19:46 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id v3sm57388782iom.53.2019.08.02.06.19.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:19:45 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri, 2 Aug 2019 15:19:44 +0200
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802131943.hkvcssv74j25xmmt@brauner.io>
References: <20190731161223.2928-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731161223.2928-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 06:12:22PM +0200, Adrian Reber wrote:
> The main motivation to add CLONE_SET_TID to clone3() is CRIU.
> 
> To restore a process with the same PID/TID CRIU currently uses
> /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> ns_last_pid and then (quickly) does a clone(). This works most of the
> time, but it is racy. It is also slow as it requires multiple syscalls.

Can you elaborate how this is racy, please. Afaict, CRIU will always
usually restore in a new pid namespace that it controls, right? What is
the exact race?

> 
> Extending clone3() to support CLONE_SET_TID makes it possible restore a
> process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> race free (as long as the desired PID/TID is available).
> 
> This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> on clone3() with set_tid as they are currently in place for ns_last_pid.
> 
> v2:
>  - Removed (size < sizeof(struct clone_args)) as discussed with
>    Christian and Dmitry
>  - Added comment to ((set_tid != 1) && idr_get_cursor() <= 1) (Oleg)
>  - Use idr_alloc() instead of idr_alloc_cyclic() (Oleg)

Fwiw, the changelog should be placed after the "---" after your SOB, so
rather :):

Signed-off-by: Adrian Reber <areber@redhat.com>
---
v2:
 - Removed (size < sizeof(struct clone_args)) as discussed with
   Christian and Dmitry
 - Added comment to ((set_tid != 1) && idr_get_cursor() <= 1) (Oleg)
 - Use idr_alloc() instead of idr_alloc_cyclic() (Oleg)
---

> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  include/linux/pid.h        |  2 +-
>  include/linux/sched/task.h |  1 +
>  include/uapi/linux/sched.h |  2 ++
>  kernel/fork.c              | 25 ++++++++++++++++---------
>  kernel/pid.c               | 30 +++++++++++++++++++++++-------
>  5 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 2a83e434db9d..052000db0ced 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -116,7 +116,7 @@ extern struct pid *find_vpid(int nr);
>  extern struct pid *find_get_pid(int nr);
>  extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
>  
> -extern struct pid *alloc_pid(struct pid_namespace *ns);
> +extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t set_tid);
>  extern void free_pid(struct pid *pid);
>  extern void disable_pid_allocation(struct pid_namespace *ns);
>  
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0497091e40c1..4f2a80564332 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -26,6 +26,7 @@ struct kernel_clone_args {
>  	unsigned long stack;
>  	unsigned long stack_size;
>  	unsigned long tls;
> +	pid_t set_tid;
>  };
>  
>  /*
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index b3105ac1381a..8c4e803e8147 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -32,6 +32,7 @@
>  #define CLONE_NEWPID		0x20000000	/* New pid namespace */
>  #define CLONE_NEWNET		0x40000000	/* New network namespace */
>  #define CLONE_IO		0x80000000	/* Clone io context */
> +#define CLONE_SET_TID		0x100000000ULL	/* set if the desired TID is set in set_tid */
>  
>  /*
>   * Arguments for the clone3 syscall
> @@ -45,6 +46,7 @@ struct clone_args {
>  	__aligned_u64 stack;
>  	__aligned_u64 stack_size;
>  	__aligned_u64 tls;
> +	__aligned_u64 set_tid;
>  };
>  
>  /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e76ea3..405f98ce4c83 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2031,7 +2031,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {
> -		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
> +		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid);
>  		if (IS_ERR(pid)) {
>  			retval = PTR_ERR(pid);
>  			goto bad_fork_cleanup_thread;
> @@ -2530,14 +2530,12 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
>  					      size_t size)
>  {
> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>  	struct clone_args args;
>  
>  	if (unlikely(size > PAGE_SIZE))
>  		return -E2BIG;
>  
> -	if (unlikely(size < sizeof(struct clone_args)))
> -		return -EINVAL;
> -
>  	if (unlikely(!access_ok(uargs, size)))
>  		return -EFAULT;
>  
> @@ -2562,6 +2560,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  	if (copy_from_user(&args, uargs, size))
>  		return -EFAULT;
>  
> +	if ((args.flags & CLONE_SET_TID) && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> +		return -EPERM;

Have you made sure that this makes sense with all flags, e.g. does this
make sense when specified with CLONE_THREAD?

> +
>  	*kargs = (struct kernel_clone_args){
>  		.flags		= args.flags,
>  		.pidfd		= u64_to_user_ptr(args.pidfd),
> @@ -2571,6 +2572,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		.stack		= args.stack,
>  		.stack_size	= args.stack_size,
>  		.tls		= args.tls,
> +		.set_tid	= args.set_tid,
>  	};
>  
>  	return 0;
> @@ -2578,11 +2580,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  
>  static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>  {
> -	/*
> -	 * All lower bits of the flag word are taken.
> -	 * Verify that no other unknown flags are passed along.
> -	 */
> -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> +	/* Verify that no other unknown flags are passed along. */
> +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_SET_TID))
> +		return false;
> +
> +	/* Fail if set_tid is set without CLONE_SET_TID */
> +	if (kargs->set_tid && !(kargs->flags & CLONE_SET_TID))
> +		return false;
> +
> +	/* Also fail if set_tid is invalid */
> +	if ((kargs->set_tid <= 0) && (kargs->flags & CLONE_SET_TID))
>  		return false;
>  
>  	/*
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 0a9f2e437217..977f3ac39d7f 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -157,7 +157,7 @@ void free_pid(struct pid *pid)
>  	call_rcu(&pid->rcu, delayed_put_pid);
>  }
>  
> -struct pid *alloc_pid(struct pid_namespace *ns)
> +struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
>  {
>  	struct pid *pid;
>  	enum pid_type type;
> @@ -186,12 +186,28 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
>  			pid_min = RESERVED_PIDS;
>  
> -		/*
> -		 * Store a null pointer so find_pid_ns does not find
> -		 * a partially initialized PID (see below).
> -		 */
> -		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -				      pid_max, GFP_ATOMIC);
> +		if (set_tid) {
> +			/*
> +			 * Also fail if a PID != 1 is requested
> +			 * and no PID 1 exists.
> +			 */
> +			if ((set_tid >= pid_max) || ((set_tid != 1) &&
> +				(idr_get_cursor(&tmp->idr) <= 1))) {
> +				spin_unlock_irq(&pidmap_lock);
> +				retval = -EINVAL;
> +				goto out_free;
> +			}
> +			nr = idr_alloc(&tmp->idr, NULL, set_tid,
> +				       set_tid + 1, GFP_ATOMIC);

Hm, feels to me that we should report a different error code than EAGAIN
when the allocation fails for set_tid. Right now you get EAGAIN for both
the non set_tid and the set_tid codepath.
But for set_tid the error that you likely should surface is EEXIST, i.e.
that pid is already taken.

> +			set_tid = 0;
> +		} else {
> +			/*
> +			 * Store a null pointer so find_pid_ns does not find
> +			 * a partially initialized PID (see below).
> +			 */
> +			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> +					      pid_max, GFP_ATOMIC);
> +		}
>  		spin_unlock_irq(&pidmap_lock);
>  		idr_preload_end();
>  
> -- 
> 2.21.0
> 
