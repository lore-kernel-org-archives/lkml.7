Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B948AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791052073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576018608;
	bh=XWDREuj9dAdtDalevfFif+p6LIl9S2O4mIRyDr996/4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pnd7gwF4FFxKrxNyO6gn975LHINJ4isfyzSgooMehho8L1TDHjKavaVVigoss4Ryo
	 Qdm6FFuPgwgvNByebOKjMYu3CQ7RkiNmufBgOecu25jGtwnwVauRbmh7gkvUz9JmOZ
	 6nMSI3GphazmkTdtOr+/9xsfieUSHgRp66oChlhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLJW4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfLJW4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:56:47 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994B92053B;
        Tue, 10 Dec 2019 22:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576018605;
        bh=XWDREuj9dAdtDalevfFif+p6LIl9S2O4mIRyDr996/4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SP4ifQLvAuOKWVhyW64pmq5mrOWwJOo/YYVIh5Bul9lwGAl/Y51PLhuzJm+uNok70
         PHrhLHfHvp2cT6k9SFs2hUM7kTGbt+ly0Z99oT74r0JkEo6EG/ImO2NzR3Suow7ROL
         rrHYMqQbm9y5He1w7pDuYDGPu0kCc2q4cxtDvO+w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A68F352276D; Tue, 10 Dec 2019 14:56:45 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:56:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191210225645.GW2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
 <20191205103213.GB2871@hirez.programming.kicks-ass.net>
 <20191205144805.GR2889@paulmck-ThinkPad-P72>
 <20191206185208.GA25636@paulmck-ThinkPad-P72>
 <20191206220020.GA27511@paulmck-ThinkPad-P72>
 <20191209185908.GA8470@paulmck-ThinkPad-P72>
 <20191210090839.GJ2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210090839.GJ2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:08:39AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 09, 2019 at 10:59:08AM -0800, Paul E. McKenney wrote:
> > And it survived!  ;-)
> > 
> > Peter, could I please have your Signed-off-by?  Or take my Tested-by if
> > you would prefer to send it up some other way.
> 
> How's this?

Very good, thank you!  I have queued it on -rcu, but please let me
know if you would rather that it go in via some other path.

							Thanx, Paul

> ---
> Subject: cpu/hotplug, stop_machine: Fix stop_machine vs hotplug order
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Dec 10 09:34:54 CET 2019
> 
> Paul reported a very sporadic, rcutorture induced, workqueue failure.
> When the planets align, the workqueue rescuer's self-migrate fails and
> then triggers a WARN for running a work on the wrong CPU.
> 
> Tejun then figured that set_cpus_allowed_ptr()'s stop_one_cpu() call
> could be ignored! When stopper->enabled is false, stop_machine will
> insta complete the work, without actually doing the work. Worse, it
> will not WARN about this (we really should fix this).
> 
> It turns out there is a small window where a freshly online'ed CPU is
> marked 'online' but doesn't yet have the stopper task running:
> 
> 	BP				AP
> 
> 	bringup_cpu()
> 	  __cpu_up(cpu, idle)	 -->	start_secondary()
> 					...
> 					cpu_startup_entry()
> 	  bringup_wait_for_ap()
> 	    wait_for_ap_thread() <--	  cpuhp_online_idle()
> 					  while (1)
> 					    do_idle()
> 
> 					... available to run kthreads ...
> 
> 	    stop_machine_unpark()
> 	      stopper->enable = true;
> 
> Close this by moving the stop_machine_unpark() into
> cpuhp_online_idle(), such that the stopper thread is ready before we
> start the idle loop and schedule.
> 
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Debugged-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -525,8 +525,7 @@ static int bringup_wait_for_ap(unsigned
>  	if (WARN_ON_ONCE((!cpu_online(cpu))))
>  		return -ECANCELED;
>  
> -	/* Unpark the stopper thread and the hotplug thread of the target cpu */
> -	stop_machine_unpark(cpu);
> +	/* Unpark the hotplug thread of the target cpu */
>  	kthread_unpark(st->thread);
>  
>  	/*
> @@ -1089,8 +1088,8 @@ void notify_cpu_starting(unsigned int cp
>  
>  /*
>   * Called from the idle task. Wake up the controlling task which brings the
> - * stopper and the hotplug thread of the upcoming CPU up and then delegates
> - * the rest of the online bringup to the hotplug thread.
> + * hotplug thread of the upcoming CPU up and then delegates the rest of the
> + * online bringup to the hotplug thread.
>   */
>  void cpuhp_online_idle(enum cpuhp_state state)
>  {
> @@ -1100,6 +1099,12 @@ void cpuhp_online_idle(enum cpuhp_state
>  	if (state != CPUHP_AP_ONLINE_IDLE)
>  		return;
>  
> +	/*
> +	 * Unpart the stopper thread before we start the idle loop (and start
> +	 * scheduling); this ensures the stopper task is always available.
> +	 */
> +	stop_machine_unpark(smp_processor_id());
> +
>  	st->state = CPUHP_AP_ONLINE_IDLE;
>  	complete_ap_thread(st, true);
>  }
