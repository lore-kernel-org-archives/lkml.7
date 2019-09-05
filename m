Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ACE206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567704714;
	bh=EEMFdAxLLoVOnA+CEfSYc8kyvxbkjmXoUK2PyeJFfss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ByvdoWplt/06LL1zxQK2G4UvPVF+rolfIyarUdw93qPz+BooyNknVfuqcqDtvYrkd
	 HLxfHa7cDOSa/6/7P4OPfmf5REUyfcVx97+enLBHVfTFUnFwt54OYMzw2pr1OkeiXn
	 6lH3wrvs4jr79LlS6KRaUMndMHs4fBVu7oXdJjHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbfIERbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732679AbfIERbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:31:52 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA4B206A5;
        Thu,  5 Sep 2019 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567704712;
        bh=EEMFdAxLLoVOnA+CEfSYc8kyvxbkjmXoUK2PyeJFfss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdkLfl2QY47MxNAsP3UvsrXMR1ubrmiFnF4wpUt7zNqephKiSsnBdYEx+yu9CCfw4
         aXNwKIouvajQAewklJUF+vPoFQ1EKF2chCsmerUcbdZX43G0VBIJRbZ7vU6+pYpVgU
         XBGDEOfcu5RGJMB7rpXtFZ7LuwJjHOkVjVoLfSy0=
Date:   Thu, 5 Sep 2019 19:31:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 2/6] posix-cpu-timers: Fix permission check regression
Message-ID: <20190905173148.GE18251@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905120539.797994508@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120539.797994508@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:41PM +0200, Thomas Gleixner wrote:
> The recent consolidation of the three permission checks introduced a subtle
> regression. For timer_create() with a process wide timer it returns the
> current task if the lookup through the PID which is encoded into the
> clockid results in returning current.
> 
> That's broken because it does not validate whether the current task is the
> group leader.
> 
> That was caused by the two different variants of permission checks:
> 
>   - posix_cpu_timer_get() allowed access to the process wide clock when the
>     looked up task is current. That's not an issue because the process wide
>     clock is in the shared sighand.
> 
>   - posix_cpu_timer_create() made sure that the looked up task is the group
>     leader.
> 
> Restore the previous state.
> 
> Note, that these permission checks are more than questionable, but that's
> subject to follow up changes.
> 
> Fixes: 6ae40e3fdcd3 ("posix-cpu-timers: Provide task validation functions")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -47,25 +47,42 @@ void update_rlimit_cpu(struct task_struc
>  /*
>   * Functions for validating access to tasks.
>   */
> -static struct task_struct *lookup_task(const pid_t pid, bool thread)
> +static struct task_struct *lookup_task(const pid_t pid, bool thread,
> +				       bool gettime)
>  {
>  	struct task_struct *p;
>  
> +	/*
> +	 * If the encoded PID is 0, then the timer is targeted at current
> +	 * or the process to which current belongs.
> +	 */
>  	if (!pid)
>  		return thread ? current : current->group_leader;
>  
>  	p = find_task_by_vpid(pid);
> -	if (!p || p == current)
> +	if (!p)
>  		return p;
> +
>  	if (thread)
>  		return same_thread_group(p, current) ? p : NULL;
> -	if (p == current)
> -		return p;
> +
> +	if (gettime) {
> +		/*
> +		 * For clock_gettime() the task does not need to be the
> +		 * actual group leader. tsk->sighand gives access to the
> +		 * group's clock.
> +		 */

I'm a bit confused with the explanation. Why is it fine to do so with clock
and not with timer? tsk->sighand gives access to the group's timer as
well.

> +		return (p == current || thread_group_leader(p)) ? p : NULL;
> +	}
> +
> +	/*
> +	 * For processes require that p is group leader.
> +	 */
>  	return has_group_leader_pid(p) ? p : NULL;
>  }
