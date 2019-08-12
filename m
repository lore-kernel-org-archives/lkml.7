Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34DE2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt1OeiDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfHLUoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:44:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38131 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:44:06 -0400
Received: by mail-vs1-f66.google.com with SMTP id 62so7910983vsl.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNotvuaKUiD4s70SkhI8tdw3KwjmNCIekjphV52WZsU=;
        b=tt1OeiDI0+5uSTg1GiAOQYdrY4Kw96REhxS5sytDogqwT0+xOSs8Zd0mLMXDY4Kofw
         0LHNQ8ppKSzt/a8eT3ROsF4rGSEgrAOWKWjvId7bVHoAUYnJ5LJ0ZFdDGa3L6OOtmehf
         7XC7rCq/Atu1lnxNhgcA+TcwXrFPXU6IVJX3buPA8bRF+OkyFpY4fjGwI6WkBzjd83A0
         Fz0cwqaDPKLcosiC9Fjfqn8jMv3jA32kB3uk7ca0B6qdfS33t+tDF4dRnZZLMzY9Rt8Q
         ZSsWcA0oEG/fvJ9q9x6SPen7qC3I7DQ8v2P7gbcFuYiFy4xj8wR+zKCtRu+U7Sp3XlMP
         HjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNotvuaKUiD4s70SkhI8tdw3KwjmNCIekjphV52WZsU=;
        b=B7KzC9BqdCBa609S68zw4lzzsBySUol9bUyM9jZcQJX2rvDJxiikmNCAi4CgmUtN7N
         iMQu8irpT2NjswD0S/oSkrJEswVgHxz6I7GfiVUp0Mx6SZrNxMrWEO9Dr+4o85GVsf14
         3HpJbl0wrsVnl/i7/TtN26fKg3/HLmz9DBljiLullbRtelLZ0stxQpv91oKgfdsnlY8y
         5ZyadKgjgEF69zbG+dSkX64xhAeOASYZyv6zUefqczZbQSS+2kx9Ti3NIWyBG78BFCMj
         jofg3yjG7+sN5wgCm/iGLT14BBSDXpcZ7mwrFpwHUhNGS07KtzVwUou2s4rsS6XNgD/x
         JHsg==
X-Gm-Message-State: APjAAAUcffIeNadiqn4fk8aMQPsb7d2oxLqmtG9aHJCDxYfT34lh56+/
        0huP/LWyN4TbEzpEeIPvYNHRXMVzJrN6xXggCr8=
X-Google-Smtp-Source: APXvYqym/jLEedFM91BT/pTCqBZu4yyIUWWYmEDpC3/tgXKVMMKJ3z3CjRPAN7bHN8Fz/VIb1DdOiufPpZEXe8jC0ck=
X-Received: by 2002:a67:1143:: with SMTP id 64mr23794225vsr.133.1565642644816;
 Mon, 12 Aug 2019 13:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190812200939.23784-1-areber@redhat.com>
In-Reply-To: <20190812200939.23784-1-areber@redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 12 Aug 2019 13:43:53 -0700
Message-ID: <CANaxB-z+DktJ2Kaqdpyp60oPwAtiKyctnoJA2gFZ2r=044DfjQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fork: extend clone3() to support setting a PID
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 1:10 PM Adrian Reber <areber@redhat.com> wrote:
>
> The main motivation to add set_tid to clone3() is CRIU.
>
> To restore a process with the same PID/TID CRIU currently uses
> /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> ns_last_pid and then (quickly) does a clone(). This works most of the
> time, but it is racy. It is also slow as it requires multiple syscalls.
>
> Extending clone3() to support set_tid makes it possible restore a
> process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> race free (as long as the desired PID/TID is available).
>
> This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> on clone3() with set_tid as they are currently in place for ns_last_pid.
>
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
> v2:
>  - Removed (size < sizeof(struct clone_args)) as discussed with
>    Christian and Dmitry
>  - Added comment to ((set_tid != 1) && idr_get_cursor() <= 1) (Oleg)
>  - Use idr_alloc() instead of idr_alloc_cyclic() (Oleg)
>
> v3:
>  - Return EEXIST if PID is already in use (Christian)
>  - Drop CLONE_SET_TID (Christian and Oleg)
>  - Use idr_is_empty() instead of idr_get_cursor() (Oleg)
>  - Handle different `struct clone_args` sizes (Dmitry)
>
> v4:
>  - Rework struct size check with defines (Christian)
>  - Reduce number of set_tid checks (Oleg)
>  - Less parentheses and more robust code (Oleg)
>  - Do ns_capable() on correct user_ns (Oleg, Christian)
>
> v5:
>  - make set_tid checks earlier in alloc_pid() (Christian)
>  - remove unnecessary comment and struct size check (Christian)
>
> v6:
>  - remove CLONE_SET_TID from description (Christian)
>  - add clone3() tests for different clone_args sizes (Christian)
>  - move more set_tid checks to alloc_pid() (Oleg)
>  - make all set_tid checks lockless (Oleg)
> ---
>  include/linux/pid.h        |  2 +-
>  include/linux/sched/task.h |  1 +
>  include/uapi/linux/sched.h |  1 +
>  kernel/fork.c              | 14 ++++++++++++--
>  kernel/pid.c               | 37 ++++++++++++++++++++++++++++++-------
>  5 files changed, 45 insertions(+), 10 deletions(-)
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
>         unsigned long stack;
>         unsigned long stack_size;
>         unsigned long tls;
> +       pid_t set_tid;
>  };
>
>  /*
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index b3105ac1381a..e1ce103a2c47 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -45,6 +45,7 @@ struct clone_args {
>         __aligned_u64 stack;
>         __aligned_u64 stack_size;
>         __aligned_u64 tls;
> +       __aligned_u64 set_tid;
>  };
>
>  /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e76ea3..8317d408a8d6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -117,6 +117,11 @@
>   */
>  #define MAX_THREADS FUTEX_TID_MASK
>
> +/*
> + * For different sizes of struct clone_args
> + */
> +#define CLONE3_ARGS_SIZE_V0 64
> +
>  /*
>   * Protected counters by write_lock_irq(&tasklist_lock)
>   */
> @@ -2031,7 +2036,7 @@ static __latent_entropy struct task_struct *copy_process(
>         stackleak_task_init(p);
>
>         if (pid != &init_struct_pid) {
> -               pid = alloc_pid(p->nsproxy->pid_ns_for_children);
> +               pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid);
>                 if (IS_ERR(pid)) {
>                         retval = PTR_ERR(pid);
>                         goto bad_fork_cleanup_thread;
> @@ -2535,9 +2540,13 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>         if (unlikely(size > PAGE_SIZE))
>                 return -E2BIG;
>
> -       if (unlikely(size < sizeof(struct clone_args)))
> +       if (unlikely(size < CLONE3_ARGS_SIZE_V0))
>                 return -EINVAL;
>
> +       if (size < sizeof(struct clone_args))
> +               memset((void *)&args + size, 0,
> +                               sizeof(struct clone_args) - size);
> +
>         if (unlikely(!access_ok(uargs, size)))
>                 return -EFAULT;
>
> @@ -2571,6 +2580,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>                 .stack          = args.stack,
>                 .stack_size     = args.stack_size,
>                 .tls            = args.tls,
> +               .set_tid        = args.set_tid,
>         };
>
>         return 0;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 0a9f2e437217..5cdab73b9094 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -157,7 +157,7 @@ void free_pid(struct pid *pid)
>         call_rcu(&pid->rcu, delayed_put_pid);
>  }
>
> -struct pid *alloc_pid(struct pid_namespace *ns)
> +struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
>  {
>         struct pid *pid;
>         enum pid_type type;
> @@ -166,6 +166,16 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>         struct upid *upid;
>         int retval = -ENOMEM;
>
> +       if (set_tid) {
> +               if (set_tid < 0 || set_tid >= pid_max)
> +                       return ERR_PTR(-EINVAL);
> +               /* Also fail if a PID != 1 is requested and no PID 1 exists */
> +               if (set_tid != 1 && !ns->child_reaper)
> +                       return ERR_PTR(-EINVAL);

What will happen if I will create a new pid namespace
(unsahre(CLONE_NEWPID)) and then call clone3 with tid which isn't
equal to 1?

Will I get the init process with the 5 pid?...

> +               if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
> +                       return ERR_PTR(-EPERM);
> +       }
> +
>         pid = kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
>         if (!pid)
>                 return ERR_PTR(retval);
> @@ -186,12 +196,25 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>                 if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
>                         pid_min = RESERVED_PIDS;
>
> -               /*
> -                * Store a null pointer so find_pid_ns does not find
> -                * a partially initialized PID (see below).
> -                */
> -               nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -                                     pid_max, GFP_ATOMIC);
> +               if (set_tid) {
> +                       nr = idr_alloc(&tmp->idr, NULL, set_tid,
> +                                       set_tid + 1, GFP_ATOMIC);
> +                       /*
> +                        * If ENOSPC is returned it means that the PID is
> +                        * alreay in use. Return EEXIST in that case.
> +                        */
> +                       if (nr == -ENOSPC)
> +                               nr = -EEXIST;
> +                       /* Only use set_tid for one PID namespace. */
> +                       set_tid = 0;
> +               } else {
> +                       /*
> +                        * Store a null pointer so find_pid_ns does not find
> +                        * a partially initialized PID (see below).
> +                        */
> +                       nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> +                                             pid_max, GFP_ATOMIC);
> +               }
>                 spin_unlock_irq(&pidmap_lock);
>                 idr_preload_end();
>
> --
> 2.21.0
>
