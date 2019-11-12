Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32093C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39792067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEEmTpeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:27:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52413 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfKLR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:27:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so4144350wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezsIhe1GNm16S3puMGIvpD+Jx3sztUBZzOXQophYY/I=;
        b=FEEmTpeN5ZrY/aT3U30uEYPNrZUpIU5QYesr9P9pwYf1kIjxFGwV0paE4lMJopATyv
         GMqtHWLx/SEAyZ77ZTrXVAh+wQIRiGjWy6vBSD79bSsQR3JIexq2b47Xzr/40CgxOQf9
         7OTTamegj8Trj3dx8oEco9asudnNA3GiCEQ0SPyGcrv/xIV0xj5CRr4S/oKusox7WASI
         C6RwsPK/ecuBbJALdvH8KhYdryyYhoYl5Tf2iMRmZbQ893rKH1ujCeuzT9vDrGHAG7A9
         N/MKSSTMbQT4eseL8Bu9/8Xsuti8BgR7rWRg0+Fcjt75/RqQilxjA9Te1XskUKMBxFwi
         TJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezsIhe1GNm16S3puMGIvpD+Jx3sztUBZzOXQophYY/I=;
        b=ga7/pNCLGSf2gT0VIDPlriuwk8dsUzHvUhNENznMl25cW8m8iq/mDoWcasx0GsekMe
         iGzXmOB9lKRfjfzdNVDhKDMP2tzzgLelCZeSwAfj9YXHGImASjrwPkW/LcEbToViUIL4
         4+h5oFZE8r48cjP1kxjmGgCK4RSZBws2Dr6DkD1M9SCnh9pysF5BVhY3lqXwJV9qa/9U
         KjuJkSlktZ5IX/nZV9lPWIwa47m04xXKdzhfeEoNHbsKIzy/VaR4msvu20yRqJPowQ18
         WMgnEcDBuONbfbICRQdNmLvBR1fZ8TUB2VMjjA1XtbDBd4CzlywTFwGQzUg68heEO2HQ
         9Vsw==
X-Gm-Message-State: APjAAAWH431VoPvNUMyQju7XcofC98oQqsudCfuYmQ5ufK6gU2M1H0vG
        6Rs0zNuHtpv3EoBTd6w2UOYW568z2LS4Y7BSsPX2bw==
X-Google-Smtp-Source: APXvYqx3GzimoXXoGTO0Xrn1zwJE2StYKvhT/datgS/GsVK/cWi04Z5uHyYhEKpC1lmJuO5/nl4Xkq4mRlU2JVMemIs=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr5217623wmd.176.1573579640763;
 Tue, 12 Nov 2019 09:27:20 -0800 (PST)
MIME-Version: 1.0
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
 <20191112154144.GC168812@cmpxchg.org> <20191112154844.GD168812@cmpxchg.org> <20191112160821.GE168812@cmpxchg.org>
In-Reply-To: <20191112160821.GE168812@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Nov 2019 09:27:09 -0800
Message-ID: <CAJuCfpGoJdv9JFh8WgQE0WmuwMx1P4GLLfn85N5_vuCzqvoOBw@mail.gmail.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tim <xiejingfeng@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Nov 12, 2019 at 10:48:46AM -0500, Johannes Weiner wrote:
> > On Tue, Nov 12, 2019 at 10:41:46AM -0500, Johannes Weiner wrote:
> > > On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
> > > > In psi_update_stats, it is possible that period has value like
> > > > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
> > > > truncates u64 period to u32, results in zero divisor.
> > > > Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
> > > > truncation to 32-bit on 64-bit platforms.
> > > >
> > > > Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
> > >
> > > This is legit. When we stop the periodic averaging worker due to an
> > > idle CPU, the period after restart can be much longer than the ~4 sec
> > > in the lower 32 bits. See the missed_periods logic in update_averages.
> >
> > Argh, that's not right. Of course I notice right after hitting send.
> >
> > missed_periods are subtracted out of the difference between now and
> > the last update, so period should be not much bigger than 2s.
> >
> > Something else is going on here.
>
> Tim, does this happen right after boot? I wonder if it's because we're
> not initializing avg_last_update, and the initial delta between the
> last update (0) and the first scheduled update (sched_clock() + 2s)
> ends up bigger than 4 seconds somehow. Later on, the delta between the
> last and the scheduled update should always be ~2s. But for that to
> happen, it would require a pretty slow boot, or a sched_clock() that
> does not start at 0.
>
> Tim, if you have a coredump, can you extract the value of the other
> variables printed in the following patch?
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 84af7aa158bf..1b6836d23091 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -374,6 +374,10 @@ static u64 update_averages(struct psi_group *group, u64 now)
>          */
>         avg_next_update = expires + ((1 + missed_periods) * psi_period);
>         period = now - (group->avg_last_update + (missed_periods * psi_period));
> +
> +       WARN(period >> 32, "period=%ld now=%ld expires=%ld last=%ld missed=%ld\n",
> +            period, now, expires, group->avg_last_update, missed_periods);
> +
>         group->avg_last_update = now;
>
>         for (s = 0; s < NR_PSI_STATES - 1; s++) {
>
> And we may need something like this to make the tick initialization
> more robust regardless of the reported bug here:
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 84af7aa158bf..ce8f6748678a 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -185,7 +185,8 @@ static void group_init(struct psi_group *group)
>
>         for_each_possible_cpu(cpu)
>                 seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
> -       group->avg_next_update = sched_clock() + psi_period;
> +       group->avg_last_update = sched_clock();
> +       group->avg_next_update = group->avg_last_update + psi_period;
>         INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
>         /* Init trigger-related members */

Both fixes for group_init() and window_update() make sense to me.
window_update() division would be reproducible because win->size is
set during trigger setup and does not change afterwards. Since
userspace defines the window size in usecs this would require doing
some math and finding a value that yields zeros in 32 LSBs after
conversion into nsecs (see: t->win.size = window_us * NSEC_PER_USEC in
psi_trigger_create()). Haven't seen this issue because all my test
cases (1, 2, 10secs) had non-zero LSBs.
