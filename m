Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B8C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5320835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569247434;
	bh=pwXvFeRJ74oELh5A1ID0O5jPJIyhmMhXXqdO9auxWmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cmIYAhps7qpjt9STXrrKgO3p+tbbGxpxqotKx7SmlY497bkxjioXpnHvB4/rog6uY
	 grBhGRn7uuPzP1Byw5KHbTCVY8sE2o/3nIPg02RTQUKoB31KHaU4jGIA6lBSHS+nCl
	 rA2p0Qk06y9X2z/1Fpe+zl3RBwn2k4QA7HGDYpXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfIWODx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbfIWODv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:03:51 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFBF20673;
        Mon, 23 Sep 2019 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569247430;
        bh=pwXvFeRJ74oELh5A1ID0O5jPJIyhmMhXXqdO9auxWmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xet+PgpDuLyUypZes8zEg4ZD0cZvHlS+ngVUxzofQF9/vE5BRLT3TGmUvKkylyVed
         wxNWejz07hFiQgBNBj40jyQD74Tb6TDgmQDYIx7adWtwL/RQniDxl/5KnUcuLD3hPJ
         2uoiXgtN8QV0MqivHJtvBkbVe/pINhECcmDhpF10=
Date:   Mon, 23 Sep 2019 16:03:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 5/6] posix-cpu-timers: Sanitize thread clock permissions
Message-ID: <20190923140347.GA10778@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905120540.068959005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120540.068959005@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:44PM +0200, Thomas Gleixner wrote:
> The thread clock permissions are restricted to tasks of the same thread
> group, but that also prevents a ptracer from reading them. This is
> inconsistent vs. the process restrictions and unnecessary strict.
> 
> Relax it to ptrace permissions in the same way as process permissions are
> handled.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   56 +++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -51,6 +51,7 @@ void update_rlimit_cpu(struct task_struc
>  static struct task_struct *lookup_task(const pid_t pid, bool thread,
>  				       bool gettime)
>  {
> +	unsigned int mode = PTRACE_MODE_ATTACH_REALCREDS;
>  	struct task_struct *p;
>  
>  	/*
> @@ -64,44 +65,45 @@ static struct task_struct *lookup_task(c
>  	if (!p)
>  		return p;
>  
> -	if (thread)
> -		return same_thread_group(p, current) ? p : NULL;
> -
>  	if (gettime) {
>  		/*
>  		 * For clock_gettime() the task does not need to be the
>  		 * actual group leader. tsk->sighand gives access to the
> -		 * group's clock. current can obviously access itself, so
> -		 * spare the ptrace check below.
> +		 * group's clock.
> +		 *
> +		 * The trivial case is that p is current or in the same
> +		 * thread group, i.e. sharing p->signal. Spare the ptrace
> +		 * check in that case.
>  		 */
> -		if (p == current)
> +		if (same_thread_group(p, current))
>  			return p;
>  
> -		if (!thread_group_leader(p))
> -			return NULL;
> +		mode = PTRACE_MODE_READ_REALCREDS;
>  
> -		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> -			return NULL;
> -		return p;
> -	}
> +	} else if (thread) {
> +		/*
> +		 * Timer is going to be attached to a thread. If p is
> +		 * current or in the same thread group, granted.
> +		 */
> +		if (same_thread_group(p, current))
> +			return p;
>  
> -	/*
> -	 * For processes require that p is group leader.
> -	 */
> -	if (!has_group_leader_pid(p))
> -		return NULL;
> +	} else {
> +		/*
> +		 * For processes require that p is group leader.
> +		 */
> +		if (!has_group_leader_pid(p))
> +			return NULL;
>  
> -	/*
> -	 * Avoid the ptrace overhead when this is current's process
> -	 */
> -	if (same_thread_group(p, current))
> -		return p;
> +		/*
> +		 * Avoid the ptrace overhead when this is current's process
> +		 */
> +		if (same_thread_group(p, current))

Should it be "if (p == current)" ?

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> +			return p;
> +	}
>  
> -	/*
> -	 * Creating timers on processes which cannot be ptraced is not
> -	 * permitted:
> -	 */
> -	return ptrace_may_access(p, PTRACE_MODE_ATTACH_REALCREDS) ? p : NULL;
> +	/* Decide based on the ptrace permissions. */
> +	return ptrace_may_access(p, mode) ? p : NULL;
>  }
