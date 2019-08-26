Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148CAC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4406217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfHZVq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:46:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHZVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:46:25 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2Moh-00063e-FC; Mon, 26 Aug 2019 23:46:23 +0200
Date:   Mon, 26 Aug 2019 23:46:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 28/38] posix-cpu-timers: Restructure expiry array
In-Reply-To: <20190826210639.GC14309@lenoir>
Message-ID: <alpine.DEB.2.21.1908262345430.1939@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192921.895254344@linutronix.de> <20190826210639.GC14309@lenoir>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Frederic Weisbecker wrote:
> On Wed, Aug 21, 2019 at 09:09:15PM +0200, Thomas Gleixner wrote:
> > @@ -884,7 +888,7 @@ static void check_process_timers(struct
> >  				 struct list_head *firing)
> >  {
> >  	struct signal_struct *const sig = tsk->signal;
> > -	struct list_head *timers = sig->posix_cputimers.cpu_timers;
> > +	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
> >  	u64 utime, ptime, virt_expires, prof_expires;
> >  	u64 sum_sched_runtime, sched_expires;
> >  	struct task_cputime cputime;
> > @@ -912,9 +916,12 @@ static void check_process_timers(struct
> >  	ptime = utime + cputime.stime;
> >  	sum_sched_runtime = cputime.sum_exec_runtime;
> >  
> > -	prof_expires = check_timers_list(timers, firing, ptime);
> > -	virt_expires = check_timers_list(++timers, firing, utime);
> > -	sched_expires = check_timers_list(++timers, firing, sum_sched_runtime);
> > +	prof_expires = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
> > +					 firing, ptime);
> > +	virt_expires = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
> > +					 firing, utime);
> > +	sched_expires = check_timers_list(&base[CLPCLOCK_SCHED].cpu_timers,
> 
>                                                 ^^
> 0-day bot should have warned by now.

It didn't but my own testing found it and I fixed it locally already

