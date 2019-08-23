Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFAEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAAB21019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405589AbfHWPdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:33:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35969 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405326AbfHWPdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:33:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1BYu-0005As-Og; Fri, 23 Aug 2019 17:33:12 +0200
Date:   Fri, 23 Aug 2019 17:33:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 01/38] posix-cpu-timers: Provide task validation
 functions
In-Reply-To: <20190821230319.GD22020@lenoir>
Message-ID: <alpine.DEB.2.21.1908231732030.1896@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192919.326097175@linutronix.de> <20190821223356.GC22020@lenoir> <20190821230319.GD22020@lenoir>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019, Frederic Weisbecker wrote:
> On Thu, Aug 22, 2019 at 12:33:56AM +0200, Frederic Weisbecker wrote:
> > On Wed, Aug 21, 2019 at 09:08:48PM +0200, Thomas Gleixner wrote:
> > > The code contains three slightly different copies of validating whether a
> > > given clock resolves to a valid task and whether the current caller has
> > > permissions to access it.
> > > 
> > > Create central functions. Replace check_clock() as a first step and rename
> > > it to something sensible.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  kernel/time/posix-cpu-timers.c |   65 +++++++++++++++++++++++++++--------------
> > >  1 file changed, 44 insertions(+), 21 deletions(-)
> > > 
> > > --- a/kernel/time/posix-cpu-timers.c
> > > +++ b/kernel/time/posix-cpu-timers.c
> > > @@ -35,27 +35,52 @@ void update_rlimit_cpu(struct task_struc
> > >  	spin_unlock_irq(&task->sighand->siglock);
> > >  }
> > >  
> > > -static int check_clock(const clockid_t which_clock)
> > > +/*
> > > + * Functions for validating access to tasks.
> > > + */
> > > +static struct task_struct *lookup_task(const pid_t pid, bool thread)
> > >  {
> > > -	int error = 0;
> > >  	struct task_struct *p;
> > > -	const pid_t pid = CPUCLOCK_PID(which_clock);
> > >  
> > > -	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
> > > -		return -EINVAL;
> > > +	if (!pid)
> > > +		return thread ? current : current->group_leader;
> > >  
> > > -	if (pid == 0)
> > > -		return 0;
> > > +	p = find_task_by_vpid(pid);
> > > +	if (!p || p == current)
> > > +		return p;
> > 
> > What if (p == current && !thread && !has_group_leader_pid(p)) ?
> 
> Ah looking at the next patch, posix_cpu_clock_get_task() and posix_cpu_clock_getres()
> had different ad-hoc checks for this specific case.
> 
> clock_getres() used to return -EINVAL while clock_get() doesn't
> care. They certainly should agree in their behaviour. I'm not sure which
> one is correct. It probably doesn't matter much.

Let me stare on the different variants again

Thanks,

	tglx
