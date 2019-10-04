Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAA6C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D756208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSsfi6Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfJDCGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:06:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbfJDCGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:06:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so4984691wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7hbmUW/4WCH9p4zRmVpafZNlZ2iNUJMF9ROGzPM3LI=;
        b=XSsfi6Dv5agA0/jkN5hnV5fTgj2VBR5qbvhp+UpqiM0+oeXmF8vHT6VjNGmbcgO6t8
         Mns316HqkUAhuh0ON+seRJtQZlHkyZM00dp9NbNcvTutFneenD6B5waI+rA+NJ7LJFbQ
         KPFuMfgxEp+U1Ta3Q4874/cFE+MRhRjZ43dPlVr0j4/ATHSmeh3eVgjRrbO0vyRKa1yg
         dKuPEzcuRAOP8gd3xasfau9l8k/JPoCz+jCK5b8U9c2ulCrkdkMfQdweyCDsgN6XvArT
         ohF7OQ9bOD3b4CqugDHArr2b4QfSvOObbib9WFu47kPhSibgbhTaMnZoxObhrfahD2Qm
         1raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7hbmUW/4WCH9p4zRmVpafZNlZ2iNUJMF9ROGzPM3LI=;
        b=n9sUJGuF/As3x20BvXsmyDFFwTPuUUOyVN+vJsaZexPgiWvWdQKhQB4t0KHlE1C9bL
         FJ+XQGXSQgnCq/ToAkJI7Mt1GkFbzl4lHQ/T0pjdYOMr3DOX5VZM6tvAEEo7P6x3g+di
         erpKjClk4cqf3Ce2JVVkqzeSeZRPQzDdcthEqqv8lamwCTQfn2BhqpB6jOEmjOpt2/V8
         mdwc4yIPUfrQAG1qZEM7QC953QXIDW1ZOyQ/tKgugOF7egSEQUBHl50OCd4+uln6Sg3t
         R6S4XNqh1Q4S2Q07EvjeRiyiB1H2HrjSu6TPeLl5LMk+Kv2ucwKrM9SPt4b8GBFuvPIr
         RsIA==
X-Gm-Message-State: APjAAAWgX/C/sRQceA1SKgVnOJOkWEP/hSVqY1rha2mv0ZQ7KM0kFEN6
        Ai05Xn2zxEeYnbz7ytQKcO5faUs+9zgj1stQd+yDzw==
X-Google-Smtp-Source: APXvYqzXqbB4k/9rxpzywqCj+TmVB68ZFjRPuO1QmKYyWgUvKVPD/E56ScnTqyRmOUf6fiEUiPJfOaWj3oYheA5FUwU=
X-Received: by 2002:adf:97cb:: with SMTP id t11mr2777791wrb.312.1570154768234;
 Thu, 03 Oct 2019 19:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191004001243.140897-1-xueweiz@google.com> <20191004005423.GA19076@lorien.usersys.redhat.com>
In-Reply-To: <20191004005423.GA19076@lorien.usersys.redhat.com>
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Thu, 3 Oct 2019 19:05:56 -0700
Message-ID: <CAPtwhKrswHQ1Ue2YO2hJi7h-Dsk6eGPiQ2UmLCq1AxGxMoHr2w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: scale quota and period without losing
 quota/period ratio precision
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        trivial@kernel.org, Neel Natu <neelnatu@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc neelnatu@google.com and haoluo@google.com, they helped a lot
for this issue. Sorry I forgot to include them when sending out the patch.

On Thu, Oct 3, 2019 at 5:55 PM Phil Auld <pauld@redhat.com> wrote:
>
> Hi,
>
> On Thu, Oct 03, 2019 at 05:12:43PM -0700 Xuewei Zhang wrote:
> > quota/period ratio is used to ensure a child task group won't get more
> > bandwidth than the parent task group, and is calculated as:
> > normalized_cfs_quota() = [(quota_us << 20) / period_us]
> >
> > If the quota/period ratio was changed during this scaling due to
> > precision loss, it will cause inconsistency between parent and child
> > task groups. See below example:
> > A userspace container manager (kubelet) does three operations:
> > 1) Create a parent cgroup, set quota to 1,000us and period to 10,000us.
> > 2) Create a few children cgroups.
> > 3) Set quota to 1,000us and period to 10,000us on a child cgroup.
> >
> > These operations are expected to succeed. However, if the scaling of
> > 147/128 happens before step 3), quota and period of the parent cgroup
> > will be changed:
> > new_quota: 1148437ns, 1148us
> > new_period: 11484375ns, 11484us
> >
> > And when step 3) comes in, the ratio of the child cgroup will be 104857,
> > which will be larger than the parent cgroup ratio (104821), and will
> > fail.
> >
> > Scaling them by a factor of 2 will fix the problem.
>
> I have no issues with the concept. We went around a bit about the actual
> numbers and made it an approximation.
>
> >
> > Fixes: 2e8e19226398 ("sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup")
> > Signed-off-by: Xuewei Zhang <xueweiz@google.com>
> > ---
> >  kernel/sched/fair.c | 36 ++++++++++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 83ab35e2374f..b3d3d0a231cd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4926,20 +4926,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> >               if (++count > 3) {
> >                       u64 new, old = ktime_to_ns(cfs_b->period);
> >
> > -                     new = (old * 147) / 128; /* ~115% */
> > -                     new = min(new, max_cfs_quota_period);
> > -
> > -                     cfs_b->period = ns_to_ktime(new);
> > -
> > -                     /* since max is 1s, this is limited to 1e9^2, which fits in u64 */
> > -                     cfs_b->quota *= new;
> > -                     cfs_b->quota = div64_u64(cfs_b->quota, old);
> > -
> > -                     pr_warn_ratelimited(
> > -     "cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> > -                             smp_processor_id(),
> > -                             div_u64(new, NSEC_PER_USEC),
> > -                             div_u64(cfs_b->quota, NSEC_PER_USEC));
> > +                     /*
> > +                      * Grow period by a factor of 2 to avoid lossing precision.
> > +                      * Precision loss in the quota/period ratio can cause __cfs_schedulable
> > +                      * to fail.
> > +                      */
> > +                     new = old * 2;
> > +                     if (new < max_cfs_quota_period) {
>
> I don't like this part as much. There may be a value between
> max_cfs_quota_period/2 and max_cfs_quota_period that would get us out of
> the loop. Possibly in practice it won't matter but here you trigger the
> warning and take no action to keep it from continuing.
>
> Also, if you are actually hitting this then you might want to just start at
> a higher but proportional quota and period.

I'd like to do what you suggested. A quick idea would be to scale period to
max_cfs_quota_period, and scale quota proportionally. However the naive
implementation won't work under this edge case:
original:
quota: 500,000us  period: 570,000us
after scaling:
quota: 877,192us  period: 1,000,000us
original ratio: 919803
new ratio: 919802

To do this right, the code would have to keep an eye out on the precision loss,
and increase quota by 1us sometimes to cancel out the precision loss.

Also, I think this case is not that important. Because if we are
hitting this case, that
suggests the period is already >0.5s. And if we are still hitting
timeouts with a 0.5s
period, scaling it to 1s probably won't help much.
When this happens, I'd imagine the parent cgroup would have a LOT of child
cgroups. It might make sense for the userspace to create the parent cgroup with
1s period.

If you think automatically scaling 0.5s+ to 1s is still important, I'm
happy to stash
this patch, and send in another one that handles the 0.5+s -> 1s
scaling the right
way. :) Thanks!

Best regards,
Xuewei

>
>
> Cheers,
> Phil
>
> > +                             cfs_b->period = ns_to_ktime(new);
> > +                             cfs_b->quota *= 2;
> > +
> > +                             pr_warn_ratelimited(
> > +     "cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
> > +                                     smp_processor_id(),
> > +                                     div_u64(new, NSEC_PER_USEC),
> > +                                     div_u64(cfs_b->quota, NSEC_PER_USEC));
> > +                     } else {
> > +                             pr_warn_ratelimited(
> > +     "cfs_period_timer[cpu%d]: period too short, but cannot scale up without losing precision (cfs_period_us = %lld, cfs_quota_us = %lld)\n",
> > +                                     smp_processor_id(),
> > +                                     div_u64(old, NSEC_PER_USEC),
> > +                                     div_u64(cfs_b->quota, NSEC_PER_USEC));
> > +                     }
> >
> >                       /* reset count so we don't come right back in here */
> >                       count = 0;
> > --
> > 2.23.0.581.g78d2f28ef7-goog
> >
>
> --
