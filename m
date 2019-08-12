Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F65720679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHLQhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLQhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D6763D956;
        Mon, 12 Aug 2019 16:37:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB56F5C1B5;
        Mon, 12 Aug 2019 16:37:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 12 Aug 2019 18:37:13 +0200 (CEST)
Date:   Mon, 12 Aug 2019 18:37:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v5 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190812163710.GC31560@redhat.com>
References: <20190811203327.5385-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811203327.5385-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 12 Aug 2019 16:37:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11, Adrian Reber wrote:
>
>  include/linux/pid.h        |  2 +-
>  include/linux/sched/task.h |  1 +
>  include/uapi/linux/sched.h |  1 +
>  kernel/fork.c              | 22 ++++++++++++++++++++--
>  kernel/pid.c               | 36 +++++++++++++++++++++++++++++-------
>  5 files changed, 52 insertions(+), 10 deletions(-)

Looks good to me...

A couple of nits below, but I won't insist, feel free to ignore.

> +/*
> + * Different sizes of struct clone_args
> + */
> +#define CLONE3_ARGS_SIZE_V0 64

I don't really understand why do we want the "size < CLONE3_ARGS_SIZE_V0"
check in copy_clone_args_from_user(), but I won't argue.

> +/* V1 includes set_tid */
> +#define CLONE3_ARGS_SIZE_V1 72

unused?

> @@ -2031,7 +2038,13 @@ static __latent_entropy struct task_struct *copy_process(
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {
> -		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
> +		if (args->set_tid && !ns_capable(
> +				p->nsproxy->pid_ns_for_children->user_ns,
> +				CAP_SYS_ADMIN)) {
> +			retval = -EPERM;
> +			goto bad_fork_cleanup_thread;
> +		}
> +		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid);

copy_process() is already huge and complex, why not move this check into
alloc_pid() ? Again, note that is accepts the same ->pid_ns_for_children.

> @@ -166,6 +166,9 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  	struct upid *upid;
>  	int retval = -ENOMEM;
>  
> +	if (set_tid < 0 || set_tid >= pid_max)
> +		return ERR_PTR(-EINVAL);
> +
>  	pid = kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
>  	if (!pid)
>  		return ERR_PTR(retval);
> @@ -186,12 +189,31 @@ struct pid *alloc_pid(struct pid_namespace *ns)
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
> +			nr = -EINVAL;
> +			if (set_tid == 1 || !idr_is_empty(&tmp->idr))

On the second thought, I think we should check ns->child_reaper != NULL
rather than !idr_is_empty(), this looks more robust and clean.

And this way alloc_pid() can do everything lockless at the start,

	if (set_tid) {
		if (set_tid < 0 || set_tid >= pid_max)
			return ERR_PTR(-EINVAL);
		if (set_tid != 1 && !ns->child_reaper)
			return ERR_PTR(-EINVAL);
		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
			return ERR_PTR(-EPERM);
	}


and just for record... this is off-topic and I need to recheck, but
today "ns->pid_allocated = 0" in free_pid() doesn't look right to me...
This logic predates unshare(CLONE_PIDNS).

Oleg.

