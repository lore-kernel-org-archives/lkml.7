Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83D5208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLSldahI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCEStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:49:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43559 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfCEStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:49:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so6364168pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jlWY8QQpjmhxoL259UkHAOTZNLaYmT7f5ofEVhukLjU=;
        b=RLSldahIg06CoT0IEO0KPLe+/BX8EwMKPTt4VBYlqUNPsrFqPa9IukxFs+yGcl9x/t
         wK6KvSod+36ofF9o9t79CKWDsH0naCxdxn1etrn6p6pEhhyrIO4gYfhW5w5p8B9N54I2
         EgV2aMPCg7ddcOMXl4uXFdCacowuQBnUDHeNH+RJxq7Loz3JsGF6erPQPMa6Glrbghh+
         C4cq1hogp++XO7F7Oi8FC2YHGD37O0933Hx4e+O+QDSVF9G1R+Yip8JG3z7Vq2KmCsXm
         MuBUFK7F+bg1BwFUj6YhTKyosmJMZHVPhsRHE7u4S5bYyzStinwH+xu6OpRBp4j10VG3
         U5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=jlWY8QQpjmhxoL259UkHAOTZNLaYmT7f5ofEVhukLjU=;
        b=cgwhOkhuI6RbkktEwEvQ9eS5hPnc+3ZqmjagKuODhSd8MsJr2NHDCkm3+IemI2YtMk
         JJFWrJ3g/rW9icrEA+s1146Rg6gIpeR1KL5I96hdRludVPoUycwb1hkoilScTl/1MEIw
         q1Jcwf28vjrtmp2QW1pVWtBZxgqi2xNv67PQUB04+A+0Z61nYqfFSaSzmiugZ5d/1vyq
         pu/ZvqhhouYsmZ+wotZ4r3wqbQbdd1QfiBKZeFoIGohp7WpQJYI/nggsN7KnztRlfb8q
         Hp4KeKT31gHDoyRGXPN+wu7xPte+g09kL58CogrDs7l8gCXyP5qO+Yu6AyO4521VoYc8
         vraw==
X-Gm-Message-State: APjAAAXc4yY+Kzf2iWEUY8eNniLky46n0VClfASZsObuhhX4B7lustEw
        EXeMTEJ5QPgYpZAX6DE+QQ8DkfJD7go=
X-Google-Smtp-Source: APXvYqxWIOCeS0cZotYBMXVtQqKCDzZHeJxonpID9mQhqTVMCzE5gFZrONWr/Ldk0Y0aAaoYe+ey2w==
X-Received: by 2002:a63:fe58:: with SMTP id x24mr2661394pgj.255.1551811744996;
        Tue, 05 Mar 2019 10:49:04 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id i13sm10376851pgq.17.2019.03.05.10.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 10:49:02 -0800 (PST)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <20190301145209.GA9304@pauld.bos.csb>
        <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
        <20190304190510.GB5366@lorien.usersys.redhat.com>
Date:   Tue, 05 Mar 2019 10:49:01 -0800
In-Reply-To: <20190304190510.GB5366@lorien.usersys.redhat.com> (Phil Auld's
        message of "Mon, 4 Mar 2019 14:05:11 -0500")
Message-ID: <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

>> >
>> > 	raw_spin_lock(&cfs_b->lock);
>> > 	for (;;) {
>> > 		overrun = hrtimer_forward_now(timer, cfs_b->period);
>> > 		if (!overrun)
>> > 			break;
>> >
>> > 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
>> > 	}
>> > 	if (idle)
>> > 		cfs_b->period_active = 0;
>> > 	raw_spin_unlock(&cfs_b->lock);
>> >
>> >
>> > There's no guarantee that hrtimer_forward_now() will ever return 0 and also 
>> > do_sched_cfs_period_timer() will drop and re-acquire the cfs_b->lock to call 
>> > distribute_cfs_runtime. 
>> >
>> > I considered code to tune the period and quota up (proportionally so they have the same 
>> > relative effect) but I did not like that because of the above statement and the fact that 
>> > it would be changing the valid values the user configured. I have two versions that do that 
>> > differently but they both still call out for protection from the forever loop. I think they 
>> > add complexity for no real gain.
>> >
>> > For my current testing I'm using a more direct but less elegant approach of simply limiting 
>> > the number of times the loop can execute. This has the potential to skip handling a period 
>> > I think but will prevent the problem reliably. I'm not sure how many iterations this loop 
>> > was expected to take. I'm seeing numbers in the low thousands at times.
>> 
>> I mean the answer should be "do_sched_cfs_period_timer runs once" the
>> vast majority of the time; if it's not then your machine/setup can't
>> handle whatever super low period you've set, or there's some bad
>> behavior somewhere in the period timer handling.
>> CFS_PERIOD_TIMER_EXIT_COUNT could reasonably be like 2 or 3 - this would
>> mean that you've already spent an entire period inside the handler.
>>
>
> Thanks for looking at this.
>
> That's sort of what I though, too. Would it not make more sense to get rid
> of the loop? I find forever loops inherently suspect.

I mean, probably better to have a loop than copy paste the code a couple
of times; you could rework the condition in your patch to be part of the
loop condition in general, though it might not be any clearer (heck,
the loop /could/ be for (;overrun = hrtimer_forward_now(...);) { ... },
it's just that's kinda questionable about whether it's clearer).

>
> I think the fact that we drop the lock to do the distribue is the real cuplrit.
> It's not do_sched_cfs_period_timer()'s code itself that takes the time,
> I think, it's the re-acquire of the cfs_b->lock and the contention on it due
> to all the cgroups. Lock_stat smaples during that run show pretty high contention
> on that lock and some really long wait times.

Tons of cgroups shouldn't increase contention; cfs_b->lock is
per-cgroup, and I don't see or remember anything offhand where it even
should be worse for deep nesting. Large machines with many cpus where
threads in the cgroup are running on each make it worse of course, and
tons of cgroups with throttling enabled have O(log n) cost on hrtimers
insertion and of course O(n) cost in actual runtime in irq handlers.

If you're seeing increasing contention as the cgroup depth or cgroup
count increases, that may be a good thing to fix regardless.

The lock has to be dropped due to lock ordering vs rq locks, and the
reverse order wouldn't be possible. That said, each cfs_rq unthrottle in
distribute grabs the lock, and then that cpu will grab the lock when it
wakes up, which can be while we're still in distribute. I'm not sure if
it would be possible to move the resched_curr calls until after doing
all the rest of unthrottle, and even if we did then we'd be taking each
rq lock twice, which wouldn't be great either. It might at least be
possible to coalesce all the cfs_b accounting in unthrottle to be done
in a single locked section, but I don't know if that would actually
help; it would still all have to be serialized regardless after all.

>
> My reproducer is artificial, but is designed to trigger the issue as has
> been hit in various customer workloads. So yes, it's exaggerated, but only
> so I don't have to wait weeks between hits :)
>
>
> Thanks,
> Phil
>
>> >
>> > A more complete fix to make sure do_sched_cfs_period_timer never takes longer than period 
>> > would be good but I'm not sure what that would be and we still have this potential forever
>> > loop. 
>> >
>> > Below is the bandaid version. 
>> >   
>> > Thoughts? 
>> >
>> >
>> > Cheers,
>> > Phil
>> >
>> > ---
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 310d0637fe4b..33e55620f891 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4859,12 +4859,16 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>> >         return HRTIMER_NORESTART;
>> >  }
>> >  
>> > +/* This is pretty arbitrary just to escape the "forever" loop before the watchdog
>> > + * kills us as there is no guarantee hrtimer_forward_now ever returns 0. */
>> > +#define CFS_PERIOD_TIMER_EXIT_COUNT 100
>> >  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>> >  {
>> >         struct cfs_bandwidth *cfs_b =
>> >                 container_of(timer, struct cfs_bandwidth, period_timer);
>> >         int overrun;
>> >         int idle = 0;
>> > +       int count = 0;
>> >  
>> >         raw_spin_lock(&cfs_b->lock);
>> >         for (;;) {
>> > @@ -4872,6 +4876,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>> >                 if (!overrun)
>> >                         break;
>> >  
>> > +               if (++count > CFS_PERIOD_TIMER_EXIT_COUNT) {
>> > +                       pr_warn_ratelimited("cfs_period_timer(%d): too many overruns. Consider raising cfs_period_us (%lld)\n",
>> > +                               smp_processor_id(), cfs_b->period/NSEC_PER_USEC);
>> > +                       // Make sure we restart the timer.
>> > +                       idle = 0;
>> > +                       break;
>> > +               }
>> > +
>> >                 idle = do_sched_cfs_period_timer(cfs_b, overrun);
>> >         }
>> >         if (idle)
