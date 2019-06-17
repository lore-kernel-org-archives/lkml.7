Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43886C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFAF2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfFQJLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfFQJLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:11:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92A13307D86F;
        Mon, 17 Jun 2019 09:11:33 +0000 (UTC)
Received: from xz-x1 (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12FDE7E5B1;
        Mon, 17 Jun 2019 09:11:26 +0000 (UTC)
Date:   Mon, 17 Jun 2019 17:11:22 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base properly
Message-ID: <20190617091122.GC12456@xz-x1>
References: <20190603132944.9726-1-peterx@redhat.com>
 <alpine.DEB.2.21.1906170732410.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906170732410.1760@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 17 Jun 2019 09:11:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:09:20AM +0200, Thomas Gleixner wrote:
> Peter,

Hi, Thomas,

Thanks for replying.

> 
> On Mon, 3 Jun 2019, Peter Xu wrote:
> 
> > get_target_base() in the timer code is not using the "base" parameter
> > at all.  My gut feeling is that instead of removing that extra
> > parameter, what we really want to do is "return the old base if it
> > does not suite for a new one".
> 
> Gut feelings are not really useful for technical decisions.
> 
> >  kernel/time/timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index 343c7ba33b1c..6ff6ffd2c719 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -868,7 +868,7 @@ get_target_base(struct timer_base *base, unsigned tflags)
> >  	    !(tflags & TIMER_PINNED))
> >  		return get_timer_cpu_base(tflags, get_nohz_timer_target());
> >  #endif
> > -	return get_timer_this_cpu_base(tflags);
> > +	return base;
> >  }
> 
> Timers are supposed to be queued on the local CPU except for the following
> cases:
> 
>  1) timer migration is enabled and the timer is not pinned
> 
>     In this case the get_nohz_timer_target() crystal ball logic tries to
>     find a useful base for the timer, which is doomed but its that way
>     until we reach the point where the pull model actually works.
> 
>  2) add_timer_on() is invoked which puts a timer on an explicit target
>     CPU. That's not using the above.
> 
> That has been that way forever and the base parameter is stale as older
> code used the base to check whether migration is enabled or not. When this
> was converted to a static branch the parameter stayed and got unused.
> 
> So your change would prevent moving the timer to the current CPU.
> 
> You might argue that in case of an explicit pinned timer, the above logic
> is wrong when the timer is modified as it might move to a different
> CPU. But from day one when the pinned logic was introduced, pinned just
> prevents it from being queued on a remote CPU. If you need a timer to stay
> on a particular CPU even if modified from a remote CPU, then the only way
> right now is to dequeue and requeue it with add_timer_on(). 

Indeed.  If add_timer_on() should always be used when with pinned
timers, IMHO it would be good to comment probably above TIMER_PINNED
about the fact so people will never misuse the interfaces (it seems to
be mis-used somehow but I cannot be 100% sure, please see below).

> 
> If we really want to change that, then we need to audit all usage sites of
> pinned timers and figure out whether this would break anything.
> 
> The proper change would be in that case:
> 
>       return pinned ? base : get_timer_this_cpu_base(tflags);

Purely for curiousity - why would we like to use current cpu base even
if it's unpinned?  My humble opinion is that if we use base directly
at least we can avoid potential migration of the timer.  But I can be
missing some real reason here...

> 
> But unless you can come up with a use case where the current logic is truly
> broken, I don't see a reason to do that.

It's not a lot of places that used TIMER_PINNED so I gave a quick look
on it.  Two conditions are always correct:

- when add_timer_on is used as explained, or,

- when timer_setup(..., TIMER_PINNED) is used in the same context as
  timer_mod() (e.g., mod_timer is called right after timer_setup).

For above two cases, the timer will always be running with expected
CPU that was pinned.

Though, I see two outliers:

======================

*** drivers/cpufreq/powernv-cpufreq.c:
powernv_cpufreq_cpu_init[867]  TIMER_PINNED | TIMER_DEFERRABLE);

*** net/ipv4/inet_timewait_sock.c:
inet_twsk_alloc[189]           timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);

======================

For the first one I can't say it's problematic since even if it's not
pinned correctly it has the logic to re-pin the timer so it'll finally
be fine:

void gpstate_timer_handler(struct timer_list *t)
{
        ...
	/*
	 * If the timer has migrated to the different cpu then bring
	 * it back to one of the policy->cpus
	 */
	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
		gpstates->timer.expires = jiffies + msecs_to_jiffies(1);
		add_timer_on(&gpstates->timer, cpumask_first(policy->cpus));
		spin_unlock(&gpstates->gpstate_lock);
		return;
	}
        ...
}

For the other one, the timer is setup during inet_twsk_alloc(), but
the mod_timer() is in __inet_twsk_schedule() which seems to be
problematic.

Thanks,

-- 
Peter Xu
