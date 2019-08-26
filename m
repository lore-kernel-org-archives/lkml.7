Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE962C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEDC21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566837130;
	bh=n2aP237Q+Aka+01H5FA4wxcmC9Cqs6iGTOPVmn8aiGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwtACFiX9cp+eogN6sv65fHJgkJDDV4BF6lxKCGSj0AEZw7jLKzfWpWiQNWPUUuSX
	 wHadBlvjE7pYevSR4ySJAZ/K8Q1FcroKXmW8gpqDgDKD04+6vRpNVoy5a2tlJc5ZhC
	 J1fTmiOMoib2NGMBzCxTDGyWZfQQsfCQ03X3OzFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfHZQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfHZQcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:32:09 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C2020874;
        Mon, 26 Aug 2019 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566837128;
        bh=n2aP237Q+Aka+01H5FA4wxcmC9Cqs6iGTOPVmn8aiGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oib9Zefy53GGK0GY8VF13Yz6tbT8uDn+7TihY2uM97fDm5y/fyHvozgoe28lvb8Tw
         DNPya0W0thpkxqlAxBkDrd3+E5+yRxtGePW2YMMZQGx3HRLaBfCMqfy2TlNg3feKNS
         EpMh+poB/r6+ZYQ5oG3FK1vaGepXnQX+T0aZo0L4=
Date:   Mon, 26 Aug 2019 18:32:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 28/38] posix-cpu-timers: Restructure expiry array
Message-ID: <20190826163204.GA14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.895254344@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.895254344@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:15PM +0200, Thomas Gleixner wrote:
>  /**
> - * task_cputimers_expired - Compare two task_cputime entities.
> + * task_cputimers_expired - Check whether posix CPU timers are expired
>   *
>   * @samples:	Array of current samples for the CPUCLOCK clocks
> - * @expiries:	Array of expiry values for the CPUCLOCK clocks
> + * @pct:	Pointer to a posix_cputimers container
>   *
> - * Returns true if any mmember of @samples is greater than the corresponding
> - * member of @expiries if that member is non zero. False otherwise
> + * Returns true if any member of @samples is greater than the corresponding
> + * member of @pct->bases[CLK].nextevt. False otherwise
>   */
> -static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)
> +static inline bool
> +task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
>  {
>  	int i;
>  
>  	for (i = 0; i < CPUCLOCK_MAX; i++) {
> -		if (expiries[i] && sample[i] >= expiries[i])
> +		if (sample[i] >= pct->bases[i].nextevt)

You may have false positive here if you don't check if pct->bases[i].nextevt
is 0. Probably no big deal by the end of the series since you change that 0
for KTIME_MAX later but right now it might hurt bisection with performance
issues (locking sighand at every tick...).

[...]

> @@ -1176,7 +1182,7 @@ void run_posix_cpu_timers(void)
>  void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
>  			   u64 *newval, u64 *oldval)
>  {
> -	u64 now, *expiry = tsk->signal->posix_cputimers.expiries + clkid;
> +	u64 now, *nextevt = &tsk->signal->posix_cputimers.bases[clkid].nextevt;

You're dereferencing the pointer before checking clkid sanity below.

>  
>  	if (WARN_ON_ONCE(clkid >= CPUCLOCK_SCHED))
>  		return;
> @@ -1207,8 +1213,8 @@ void set_process_cpu_timer(struct task_s
>  	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
>  	 * expiry cache is also used by RLIMIT_CPU!.
>  	 */
> -	if (expires_gt(*expiry, *newval))
> -		*expiry = *newval;
> +	if (expires_gt(*nextevt, *newval))
> +		*nextevt = *newval;
>  
>  	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
>  }
> 
> 
