Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E3C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvZ0YZDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbfHWR2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:28:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37821 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389408AbfHWR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:28:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so6503262pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LlY7R9oI63QnnjzzCPznegjo2e3AtB25U8NRGe3mrEs=;
        b=BvZ0YZDVcFNF6hXlr+zCDxRH/ZfbM+zmnthSBPpJuKXNATNKTSumVzYUQobMNMz7k2
         9tCfAUdSZw6Wg09MCJ2wgBoJtl/6fzJ+VeBv4MQOkEs1MJdW/79R7W/2rX4YqMTgaQB1
         3Hk23csdEwwAWZLu1/wn0ChPrM1VAgzmWX4LwjC3uJKeH4TLQxxYKTmfO1I4xA2HyRG6
         tUXDO+yATvuHlj0+gINMfXyzEUe/hqmrUu0L0+vuf61xGgik6LI6YGPu7YLe6D9BGj+n
         OQ/JjSOj4RWjdoxFOtwzKwzuVlPNPNdSx/xVnamfoHWz82uSiuAnimE9lJdhDSpU+bB/
         8Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=LlY7R9oI63QnnjzzCPznegjo2e3AtB25U8NRGe3mrEs=;
        b=MPHuqB1dTDo/3h/1wv6wyLKgPVCgvnInMMbHFjierIx8TY9aETnqVFDYMAqrOaBuNP
         ftWxZ3RS8g4+5pNzAjlM5NZLmGnPdPuwMgJK8bwQuk7csmTrf5mkXXp3XbtO+XnGPJoc
         XqlG3msmCPFXy6z69ONJEjYo3/jslbb6SdvhZlQCKdjwh95ZtSIYh0JUIibx06Pz4KiL
         245UU9UKw7ee695VAUD//vpZUaEpDX+EjIZMYL79h2Bw1BgmebDRWELQKp/EJm1Xi9lb
         lJ0H4Yqhzmsn+Hv0v25iapRcccxpkzI8Iy/5m9VbRvwWNx48KjHZuKFpWkl8lZVDZ8JA
         f7uw==
X-Gm-Message-State: APjAAAXyv1Or3CN51gFDlYSeLFiWwXpxAXH16yntr6vxtHutC4hCfTzV
        sbTq7L8YAKnetmTrJJ2dJbjfWAj30N8hAQ==
X-Google-Smtp-Source: APXvYqxtbzehrWPSMGS6smJQ1eQuNO9A6R78aqo2uXT8q3zM7yrGaCk+z5elmBa+J61atiOTjZFvFQ==
X-Received: by 2002:a17:90a:8991:: with SMTP id v17mr6239174pjn.120.1566581284844;
        Fri, 23 Aug 2019 10:28:04 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id f63sm3804969pfa.144.2019.08.23.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 10:28:03 -0700 (PDT)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable warnings
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
        <xm26tvaaifoy.fsf@bsegall-linux.svl.corp.google.com>
        <CAC=E7cWYSEAjUhgN5vBECmR5ATXWmt4M7n8sNN0xXStEsb4YjA@mail.gmail.com>
Date:   Fri, 23 Aug 2019 10:28:02 -0700
In-Reply-To: <CAC=E7cWYSEAjUhgN5vBECmR5ATXWmt4M7n8sNN0xXStEsb4YjA@mail.gmail.com>
        (Dave Chiluk's message of "Fri, 23 Aug 2019 09:48:08 -0500")
Message-ID: <xm26h867iyfx.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chiluk <chiluk+linux@indeed.com> writes:

> On Wed, Aug 21, 2019 at 12:36 PM <bsegall@google.com> wrote:
>>
>> Qian Cai <cai@lca.pw> writes:
>>
>> > The linux-next commit "sched/fair: Fix low cpu usage with high
>> > throttling by removing expiration of cpu-local slices" [1] introduced a
>> > few compilation warnings,
>> >
>> > kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
>> > kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
>> > [-Wunused-but-set-variable]
>> > kernel/sched/fair.c: In function 'start_cfs_bandwidth':
>> > kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
>> > [-Wunused-but-set-variable]
>> >
>> > Also, __refill_cfs_bandwidth_runtime() does no longer update the
>> > expiration time, so fix the comments accordingly.
>> >
>> > [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux@indeed.com/
>> >
>> > Signed-off-by: Qian Cai <cai@lca.pw>
>>
>> Reviewed-by: Ben Segall <bsegall@google.com>
>>
>> > ---
>> >
>> > v2: Keep hrtimer_forward_now() in start_cfs_bandwidth() per Ben.
>> >
>> >  kernel/sched/fair.c | 19 ++++++-------------
>> >  1 file changed, 6 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 84959d3285d1..06782491691f 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>> >  }
>> >
>> >  /*
>> > - * Replenish runtime according to assigned quota and update expiration time.
>> > - * We use sched_clock_cpu directly instead of rq->clock to avoid adding
>> > - * additional synchronization around rq->lock.
>> > + * Replenish runtime according to assigned quota. We use sched_clock_cpu
>> > + * directly instead of rq->clock to avoid adding additional synchronization
>> > + * around rq->lock.
>> >   *
>> >   * requires cfs_b->lock
>> >   */
>> >  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>> >  {
>> > -     u64 now;
>> > -
>> > -     if (cfs_b->quota == RUNTIME_INF)
>> > -             return;
>> > -
>> > -     now = sched_clock_cpu(smp_processor_id());
>> > -     cfs_b->runtime = cfs_b->quota;
>> > +     if (cfs_b->quota != RUNTIME_INF)
>> > +             cfs_b->runtime = cfs_b->quota;
>> >  }
>> >
>> >  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>> > @@ -4989,15 +4984,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>> >
>> >  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>> >  {
>> > -     u64 overrun;
>> > -
>> >       lockdep_assert_held(&cfs_b->lock);
>> >
>> >       if (cfs_b->period_active)
>> >               return;
>> >
>> >       cfs_b->period_active = 1;
>> > -     overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>> > +     hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>> >       hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>> >  }
>
> Looks good.
> Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
>
> Sorry for the slow response, I was on vacation.
>
> @Ben do you think it would be useful to still capture overrun, and
> WARN on any overruns?  We wouldn't expect overruns, but their
> existence would indicate an over-loaded node or too short of a
> cfs_period.  Additionally, it would be interesting to see if we could
> capture the offset between when the bandwidth was refilled, and when
> the timer was supposed to fire.  I've always done all my calculations
> assuming that the timer fires and is handled exceedingly close to the
> time it was supposed to fire.  Although, if the node is running that
> overloaded you probably have many more problems than worrying about
> timer warnings.

That "overrun" there is not really an overrun - it's the number of
complete periods the timer has been inactive for. It was used so that a
given tg's period timer would keep the same
phase/offset/whatever-you-call-it, even if it goes idle for a while,
rather than having the next period start N ms after a task wakes up.

Also, poor choices by userspace is not generally something the kernel
generally WARNs on, as I understand it.
