Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A24C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3C20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLPK2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:28:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:28:11 -0500
Received: from [79.140.120.2] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ignbc-0006mW-DJ; Mon, 16 Dec 2019 10:28:00 +0000
Date:   Mon, 16 Dec 2019 11:27:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191216102758.4aasl4pzoz5rm4vx@wittgenstein>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:18:44AM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> When global init task get a chance to be killed, panic will happen in
> later calling steps by do_exit()->exit_notify()->forget_original_parent()
> ->find_child_reaper() if all init threads have exited.
> 
> However, it's hard to extract the coredump of init task from a kernel
> crashdump, since exit_mm() has released its mm before panic. In order
> to get the backtrace of init task in userspace, it's better to do panic
> earlier at the beginning of exitting route.
> 
> It's worth noting that we must take case of a multi-threaded init exitting
> issue. We need the test for is_global_init() && group_dead to ensure that
> it is all of init threads exiting and not just the current thread.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Just a comment and a nit I can fixup myself.

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

Oleg, wdyt?

> ---
> changes in v2:
>  - using is_global_init() && group_dead as panic condition.
>  - move up group_dead = atomic_dec_and_test(&tsk->signal->live).
>  - add comment for this change in do_exit().
> ---
>  kernel/exit.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index bcbd598..33364c8 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -517,10 +517,6 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
>  	}
>  
>  	write_unlock_irq(&tasklist_lock);
> -	if (unlikely(pid_ns == &init_pid_ns)) {
> -		panic("Attempted to kill init! exitcode=0x%08x\n",
> -			father->signal->group_exit_code ?: father->exit_code);
> -	}

This made me queasy at first but from what I can see this is safe to remove.
We could've only gotten here if:
task == child_reaper && !find_alive_thread() && pid_ns == init_pid_ns
that should be equivalent to the new
is_global_init(tsk) && group_dead
check, i.e. I think there's no condition we might loose by removing this
check.

>  
>  	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
>  		list_del_init(&p->ptrace_entry);
> @@ -728,6 +724,14 @@ void __noreturn do_exit(long code)
>  		panic("Attempted to kill the idle task!");
>  
>  	/*
> +	 * If all threads of global init have exited, do panic imeddiately

Nit: s/imeddiately/immediately/

but I can fix this up when applying.

> +	 * to get the coredump to find any clue for init task in userspace.
> +	 */
> +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> +	if (unlikely(is_global_init(tsk) && group_dead))
> +		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
> +
> +	/*
>  	 * If do_exit is called because this processes oopsed, it's possible
>  	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
>  	 * continuing. Amongst other possible reasons, this is to prevent
> @@ -764,7 +768,6 @@ void __noreturn do_exit(long code)
>  	if (tsk->mm)
>  		sync_mm_rss(tsk->mm);
>  	acct_update_integrals(tsk);
> -	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
>  #ifdef CONFIG_POSIX_TIMERS
>  		hrtimer_cancel(&tsk->signal->real_timer);
> -- 
> 1.9.1
> 
