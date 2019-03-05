Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5398A2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f578l717"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCEUpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:45:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfCEUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:45:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so6441448pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1WtnvJ7HfdSOGoUDWLRdgNZ2iFIBIOm0tY3BSIHEPnI=;
        b=f578l717TG6RJXmAu55ahSRsqI3hy9ZpA1M575YAaNGr4tEHUUABbHX3CRJin1CQfy
         +fk4n9WImDlwCB9Y0/vDr3kBOkpasN294OKEqv/NxW3L+J7pnI7eCQbt6O2kK3ODJr5E
         LMZHPd86c3ZV3B0shxlSHFB6X+NPmuo2lcsK3maHeMTpTFT/GhHUKOquBis7QyptVpcu
         e0sbGDKufZyYAyygBm9fvSrDlsxJZ0pQy3XTuTEACDGlMOCl4YbQHlwDTDRqDYmEC7+Q
         Exr/SlJzFu062hmElphvSeoQefN/qOKnwk3BRALj4TmuUfwPa0NMESh6EjSYArNKO/vF
         EA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=1WtnvJ7HfdSOGoUDWLRdgNZ2iFIBIOm0tY3BSIHEPnI=;
        b=SUZvub2RHkNL7wD5HCLX9PzgjGhqCZsydGPSIjZvhhmfO7pdLuKm18uGHnyKsoiXC4
         zgP67I3Ydin7E/60oaMFMrthOJ+ueFGswnscojUk/naBWyeIboVJuHLJI2YCfbxEWMtD
         7TMPfJHy8T03CDd5BIzvVooS6hQK2a4OjNfloQMO9lIFxNnNENTxHCUNAFtacFC3bRQA
         MlIJ6AQ92BH73EGq39XQj2S+IycHwErSBaFi/mrHYWLjpRbCb64uM/y+n/XWp//LsGdg
         pxZt1oo5XJT2x8oRWZIPtt/RQxhPASdWK9F+phY/Gx+6K09WXHeRCUP06FAqMmv3jut2
         6ILQ==
X-Gm-Message-State: APjAAAUJjCPNuMJWaO5f6nbqpf+BIYY+lV1iiYvX+7oJ9wEZ5Qsrs90X
        RbInSVI4RMBZ6RB72REbQo+WDjiJ++A=
X-Google-Smtp-Source: APXvYqzcWlwCQTd59ECxkB7C90ySTYzETKDGiaotq8ffLCF2qVbFeMPjmvVOyn4eA/iyNLlxF7Bc4A==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr3113399pgv.244.1551818736563;
        Tue, 05 Mar 2019 12:45:36 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id l12sm13495498pgn.83.2019.03.05.12.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 12:45:35 -0800 (PST)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <20190301145209.GA9304@pauld.bos.csb>
        <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
        <20190304190510.GB5366@lorien.usersys.redhat.com>
        <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
        <20190305200554.GA8786@pauld.bos.csb>
Date:   Tue, 05 Mar 2019 12:45:34 -0800
In-Reply-To: <20190305200554.GA8786@pauld.bos.csb> (Phil Auld's message of
        "Tue, 5 Mar 2019 15:05:54 -0500")
Message-ID: <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Tue, Mar 05, 2019 at 10:49:01AM -0800 bsegall@google.com wrote:
>> Phil Auld <pauld@redhat.com> writes:
>> 
>> >> >
>> >> > 	raw_spin_lock(&cfs_b->lock);
>> >> > 	for (;;) {
>> >> > 		overrun = hrtimer_forward_now(timer, cfs_b->period);
>> >> > 		if (!overrun)
>> >> > 			break;
>> >> >
>> >> > 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
>> >> > 	}
>> >> > 	if (idle)
>> >> > 		cfs_b->period_active = 0;
>> >> > 	raw_spin_unlock(&cfs_b->lock);
>> >> >
>> >> >
>> >> > There's no guarantee that hrtimer_forward_now() will ever return 0 and also 
>> >> > do_sched_cfs_period_timer() will drop and re-acquire the cfs_b->lock to call 
>> >> > distribute_cfs_runtime. 
>> >> >
>> >> > I considered code to tune the period and quota up (proportionally so they have the same 
>> >> > relative effect) but I did not like that because of the above statement and the fact that 
>> >> > it would be changing the valid values the user configured. I have two versions that do that 
>> >> > differently but they both still call out for protection from the forever loop. I think they 
>> >> > add complexity for no real gain.
>> >> >
>> >> > For my current testing I'm using a more direct but less elegant approach of simply limiting 
>> >> > the number of times the loop can execute. This has the potential to skip handling a period 
>> >> > I think but will prevent the problem reliably. I'm not sure how many iterations this loop 
>> >> > was expected to take. I'm seeing numbers in the low thousands at times.
>> >> 
>> >> I mean the answer should be "do_sched_cfs_period_timer runs once" the
>> >> vast majority of the time; if it's not then your machine/setup can't
>> >> handle whatever super low period you've set, or there's some bad
>> >> behavior somewhere in the period timer handling.
>> >> CFS_PERIOD_TIMER_EXIT_COUNT could reasonably be like 2 or 3 - this would
>> >> mean that you've already spent an entire period inside the handler.
>> >>
>> >
>> > Thanks for looking at this.
>> >
>> > That's sort of what I though, too. Would it not make more sense to get rid
>> > of the loop? I find forever loops inherently suspect.
>> 
>> I mean, probably better to have a loop than copy paste the code a couple
>> of times; you could rework the condition in your patch to be part of the
>> loop condition in general, though it might not be any clearer (heck,
>> the loop /could/ be for (;overrun = hrtimer_forward_now(...);) { ... },
>> it's just that's kinda questionable about whether it's clearer).
>> 
>
> So I'm not clear on this loop thing, though.  If it's okay for the loop
> to run 2-3 times that implies it's okay for do_sched_cfs_period_timer() 
> to take longer than a period to run.  So if that's expected twice or 
> thrice what would ensure it does not continually take that long?

So, the loop was originally copied from the rt period timer, and I'm not
sure we really thought that much about it. hrtimer_forward_now returing
!0 twice is probably best to allow, because the hrtimer could be
delayed most-but-not-all of a period; the third time means that the
fault is definitely in do_sched_cfs_period_timer though and if it was
too slow once there's no reason it could not continue to be slow. I was
just being vague on which of 2 or 3 winds up with that exact meaning.

>
>
>> >
>> > I think the fact that we drop the lock to do the distribue is the real cuplrit.
>> > It's not do_sched_cfs_period_timer()'s code itself that takes the time,
>> > I think, it's the re-acquire of the cfs_b->lock and the contention on it due
>> > to all the cgroups. Lock_stat smaples during that run show pretty high contention
>> > on that lock and some really long wait times.
>> 
>> Tons of cgroups shouldn't increase contention; cfs_b->lock is
>> per-cgroup, and I don't see or remember anything offhand where it even
>> should be worse for deep nesting. Large machines with many cpus where
>> threads in the cgroup are running on each make it worse of course, and
>> tons of cgroups with throttling enabled have O(log n) cost on hrtimers
>> insertion and of course O(n) cost in actual runtime in irq handlers.
>
> The lock is per cgroup but it's taken in assign_cfs_rq_runtime() via 
> __account_cfs_rq_runtime() from every non-idle cpu, I think.

Yes, that's proportional to cpus though, not cgroups.

>
>> 
>> If you're seeing increasing contention as the cgroup depth or cgroup
>> count increases, that may be a good thing to fix regardless.
>
> I'll look at it some more. 
>
> Interestingly, if I limit the number of child cgroups to the number of 
> them I'm actually putting processes into (16 down from 2500) the problem
> does not reproduce.

That is indeed interesting, and definitely not something we'd want to
matter. (Particularly if it's not root->a->b->c...->throttled_cgroup or
root->throttled->a->...->thread vs root->throttled_cgroup, which is what
I was originally thinking of)

>
> Fwiw this is a 80 cpu (incl. smt) 4-numa system. So there are a lot 
> of cfs_rqs that might be doing __account_cfs_rq_runtime().
>
> Here is lock_stat output from a short bit of the run when the pr_warn has come a couple of times. 
> Edited for screen width. This is the 8th lock on the list. (I wonder in this case of the really long 
> holds are the pr_warn firing.)

Yeah, it's probably best to check without the pr_warn.

>  
> class name       &cfs_b->lock:
> con-bounces      33770
> contentions      33776
> waittime-min         0.10
> waittime-max     48088.04
> waittime-total  856027.70
> waittime-avg        25.34  
> acq-bounces     148379
> acquisitions    162184 
> holdtime-min         0.00 
> holdtime-max     48240.79
> holdtime-total  354683.04  
> holdtime-avg         2.19
>                  
>              ------------
>              &cfs_b->lock          29414          [<00000000cfc57971>] __account_cfs_rq_runtime+0xd5/0x1a0
>              &cfs_b->lock           4195          [<00000000754af0b8>] throttle_cfs_rq+0x193/0x2c0
>              &cfs_b->lock            166          [<00000000b6333ad0>] unthrottle_cfs_rq+0x54/0x1d0
>              &cfs_b->lock              1          [<00000000fc0c15d2>] sched_cfs_period_timer+0xe6/0x1d0
>              ------------
>              &cfs_b->lock          28602          [<00000000cfc57971>] __account_cfs_rq_runtime+0xd5/0x1a0
>              &cfs_b->lock           3215          [<00000000754af0b8>] throttle_cfs_rq+0x193/0x2c0
>              &cfs_b->lock           1938          [<00000000b6333ad0>] unthrottle_cfs_rq+0x54/0x1d0
>              &cfs_b->lock             21          [<00000000fc0c15d2>] sched_cfs_period_timer+0xe6/0x1d0
>
>
>> 
>> The lock has to be dropped due to lock ordering vs rq locks, and the
>> reverse order wouldn't be possible. That said, each cfs_rq unthrottle in
>> distribute grabs the lock, and then that cpu will grab the lock when it
>> wakes up, which can be while we're still in distribute. I'm not sure if
>> it would be possible to move the resched_curr calls until after doing
>> all the rest of unthrottle, and even if we did then we'd be taking each
>> rq lock twice, which wouldn't be great either. It might at least be
>> possible to coalesce all the cfs_b accounting in unthrottle to be done
>> in a single locked section, but I don't know if that would actually
>> help; it would still all have to be serialized regardless after all.
>
> Yeah, that makes sense, thanks.
>
> Cheers,
> Phil
>
>> 
>> >
>> > My reproducer is artificial, but is designed to trigger the issue as has
>> > been hit in various customer workloads. So yes, it's exaggerated, but only
>> > so I don't have to wait weeks between hits :)
>> >
>> >
>> > Thanks,
>> > Phil
>> >
>> >> >
>> >> > A more complete fix to make sure do_sched_cfs_period_timer never takes longer than period 
>> >> > would be good but I'm not sure what that would be and we still have this potential forever
>> >> > loop. 
>> >> >
>> >> > Below is the bandaid version. 
>> >> >   
>> >> > Thoughts? 
>> >> >
>> >> >
>> >> > Cheers,
>> >> > Phil
>> >> >
>> >> > ---
>> >> >
>> >> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> >> > index 310d0637fe4b..33e55620f891 100644
>> >> > --- a/kernel/sched/fair.c
>> >> > +++ b/kernel/sched/fair.c
>> >> > @@ -4859,12 +4859,16 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>> >> >         return HRTIMER_NORESTART;
>> >> >  }
>> >> >  
>> >> > +/* This is pretty arbitrary just to escape the "forever" loop before the watchdog
>> >> > + * kills us as there is no guarantee hrtimer_forward_now ever returns 0. */
>> >> > +#define CFS_PERIOD_TIMER_EXIT_COUNT 100
>> >> >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>> >> >  {
>> >> >         struct cfs_bandwidth *cfs_b =
>> >> >                 container_of(timer, struct cfs_bandwidth, period_timer);
>> >> >         int overrun;
>> >> >         int idle = 0;
>> >> > +       int count = 0;
>> >> >  
>> >> >         raw_spin_lock(&cfs_b->lock);
>> >> >         for (;;) {
>> >> > @@ -4872,6 +4876,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>> >> >                 if (!overrun)
>> >> >                         break;
>> >> >  
>> >> > +               if (++count > CFS_PERIOD_TIMER_EXIT_COUNT) {
>> >> > +                       pr_warn_ratelimited("cfs_period_timer(%d): too many overruns. Consider raising cfs_period_us (%lld)\n",
>> >> > +                               smp_processor_id(), cfs_b->period/NSEC_PER_USEC);
>> >> > +                       // Make sure we restart the timer.
>> >> > +                       idle = 0;
>> >> > +                       break;
>> >> > +               }
>> >> > +
>> >> >                 idle = do_sched_cfs_period_timer(cfs_b, overrun);
>> >> >         }
>> >> >         if (idle)
