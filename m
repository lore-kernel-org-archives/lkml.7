Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C0BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E97220856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKQMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:12:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:12:30 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUCIU-0006eR-4o; Mon, 11 Nov 2019 16:12:10 +0000
Date:   Mon, 11 Nov 2019 17:12:09 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191111161207.zuymy7rq3wkhcq4x@wittgenstein>
References: <20191111131704.656169-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111131704.656169-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:17:03PM +0100, Adrian Reber wrote:
> The main motivation to add set_tid to clone3() is CRIU.
> 
> To restore a process with the same PID/TID CRIU currently uses
> /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> ns_last_pid and then (quickly) does a clone(). This works most of the
> time, but it is racy. It is also slow as it requires multiple syscalls.
> 
> Extending clone3() to support *set_tid makes it possible restore a
> process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> race free (as long as the desired PID/TID is available).
> 
> This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> on clone3() with *set_tid as they are currently in place for ns_last_pid.
> 
> The original version of this change was using a single value for
> set_tid. At the 2019 LPC, after presenting set_tid, it was, however,
> decided to change set_tid to an array to enable setting the PID of a
> process in multiple PID namespaces at the same time. If a process is
> created in a PID namespace it is possible to influence the PID inside
> and outside of the PID namespace. Details also in the corresponding
> selftest.
> 
> To create a process with the following PIDs:
> 
>       PID NS level         Requested PID
>         0 (host)              31496
>         1                        42
>         2                         1
> 
> For that example the two newly introduced parameters to struct
> clone_args (set_tid and set_tid_size) would need to be:
> 
>   set_tid[0] = 1;
>   set_tid[1] = 42;
>   set_tid[2] = 31496;
>   set_tid_size = 3;
> 
> If only the PIDs of the two innermost nested PID namespaces should be
> defined it would look like this:
> 
>   set_tid[0] = 1;
>   set_tid[1] = 42;
>   set_tid_size = 2;
> 
> The PID of the newly created process would then be the next available
> free PID in the PID namespace level 0 (host) and 42 in the PID namespace
> at level 1 and the PID of the process in the innermost PID namespace
> would be 1.

I'm not a fan of this array-based patch tbh, especially since afaict
CRIU has only vague plans to support restoring nested pid namespaces but
I won't stand in the way. :)

> 
> The set_tid array is used to specify the PID of a process starting
> from the innermost nested PID namespaces up to set_tid_size PID namespaces.
> 
> set_tid_size cannot be larger then the current PID namespace level.
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
> 
> v7:
>  - changed set_tid to be an array to set the PID of a process
>    in multiple nested PID namespaces at the same time as discussed
>    at LPC 2019 (container MC)
> ---
>  include/linux/pid.h           |  3 ++-
>  include/linux/pid_namespace.h |  2 ++
>  include/linux/sched/task.h    |  3 +++
>  include/uapi/linux/sched.h    |  2 ++
>  kernel/fork.c                 | 20 +++++++++++++-
>  kernel/pid.c                  | 50 ++++++++++++++++++++++++++++++-----
>  kernel/pid_namespace.c        |  2 --
>  7 files changed, 71 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 9645b1194c98..034b7df25888 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -120,7 +120,8 @@ extern struct pid *find_vpid(int nr);
>  extern struct pid *find_get_pid(int nr);
>  extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
>  
> -extern struct pid *alloc_pid(struct pid_namespace *ns);
> +extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> +			     size_t set_tid_size);
>  extern void free_pid(struct pid *pid);
>  extern void disable_pid_allocation(struct pid_namespace *ns);
>  
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 49538b172483..2ed6af88794b 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -12,6 +12,8 @@
>  #include <linux/ns_common.h>
>  #include <linux/idr.h>
>  
> +/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> +#define MAX_PID_NS_LEVEL 32
>  
>  struct fs_pin;
>  
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 4b1c3b664f51..f1879884238e 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -26,6 +26,9 @@ struct kernel_clone_args {
>  	unsigned long stack;
>  	unsigned long stack_size;
>  	unsigned long tls;
> +	pid_t *set_tid;
> +	/* Number of elements in *set_tid */
> +	size_t set_tid_size;
>  };
>  
>  /*
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 25b4fa00bad1..13f74c40a629 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -72,6 +72,8 @@ struct clone_args {
>  	__aligned_u64 stack;
>  	__aligned_u64 stack_size;
>  	__aligned_u64 tls;
> +	__aligned_u64 set_tid;
> +	__aligned_u64 set_tid_size;
>  };
>  #endif
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 55af6931c6ec..c70b9224997d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2026,7 +2026,8 @@ static __latent_entropy struct task_struct *copy_process(
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {
> -		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
> +		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid,
> +				args->set_tid_size);
>  		if (IS_ERR(pid)) {
>  			retval = PTR_ERR(pid);
>  			goto bad_fork_cleanup_thread;
> @@ -2527,6 +2528,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
>  					      size_t usize)
>  {
> +	int i;
>  	int err;
>  	struct clone_args args;
>  
> @@ -2539,6 +2541,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  	if (err)
>  		return err;
>  
> +	if (unlikely(args.set_tid_size > MAX_PID_NS_LEVEL))
> +		return -E2BIG;

I'd prefer EINVAL for this case. Mostly because we do that for other
arguments already. E2BIG currently only reflects invalid size of struct
clone_args itself and which makes it easy to spot for userspace and I'd
like to not overload that error too (The not-overloading-EINVAL-ship
has already sailed a long time ago.).

Also, it seems this misses some more checks, maybe?

if (!args.set_tid && args.set_tid_size > 0)
	return -EINVAL;

if (args.set_tid && args.set_tid_size == 0)
	return -EINVAL;

> +
>  	/*
>  	 * Verify that higher 32bits of exit_signal are unset and that
>  	 * it is a valid signal
> @@ -2556,8 +2561,17 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		.stack		= args.stack,
>  		.stack_size	= args.stack_size,
>  		.tls		= args.tls,
> +		.set_tid	= kargs->set_tid,

Everything setup here uses members from "args" not "kargs".
That difference is very easy to overlook should anything change in this
code in the future. I'd prefer if setting up both (set_tid and
set_tid_size) or at least the set_tid pointer would be done later,
after the copy_from_user() stuff.

So at the top of this function you could do:

pid_t *kset_tid = kargs->set_tid;

> +		.set_tid_size	= args.set_tid_size,
>  	};
>  
> +	for (i = 0; i < args.set_tid_size; i++) {
> +		if (copy_from_user(&kargs->set_tid[i],
> +		    u64_to_user_ptr(args.set_tid + (i * sizeof(args.set_tid))),
> +		    sizeof(pid_t)))
> +			return -EFAULT;
> +	}

All of this indexing doesn't look very nice and introduces racyness.
Can't we do something like:

	if (args->set_tid && copy_from_user(kset_tid, u64_to_user_ptr(args.set_tid), (kargs->set_tid_size * sizeof(pid_t))))
		return -EFAULT;
	kargs->set_tid = kset_tid;

Christian
