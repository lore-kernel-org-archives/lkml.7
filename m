Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C830C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000B021848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="GKd3AoxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395434AbfHWOsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:48:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34497 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393839AbfHWOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:48:35 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so20749279ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfqCsofuPUZH3SUHYqEnG0nV7DzlvKZ7SkByv9xZFEk=;
        b=GKd3AoxXx4yfeSwvUINFjoJs6OWnDdkp8IRzKX6P5x8SF7LHwftV45aITfgtb7e90T
         BhKjWzIObC//1+k9kdM4hQUL72WdXpxTyVLrZzxOM4jVO1dSMJPpEUdUfox5gqZkagpj
         aS3p017ykzRIBbQrYszCOaq0ZdC3ZHnJvjIY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfqCsofuPUZH3SUHYqEnG0nV7DzlvKZ7SkByv9xZFEk=;
        b=TiL8/JPDN/vIhxFV3uTEwAvEcaPrW+7iYlozC19aCD4GYhqA2w8W6S7JwbBRLqFxfz
         rCTzVua9mbOl49pfvJkv1PDuR60BJaJA4yNq/gB5YxMlNvf9OVrSwSqEAyHbAdnFpYZh
         eAJ5Jw9EYOPv4fyUIAOrxoHpZX2Kh5YYcJhkyNfuGOg2RAxLZXG4ymQTus86/idyCE4p
         PY63ugYYnjHF6db8mIgUJ5NkERKCi2jDb6RLYm8MupvmjGQs4kznlXli2+QZ9RPTf2ZT
         YyQoohhX+ClYtCDtcj4+Rye7QvlRJgEXZLtiOnqEvV9nyCHxjRZa2wxKVI50CQjVaUJu
         +RHw==
X-Gm-Message-State: APjAAAUGAQFB/63Y4jN9lilIY3VVUNKV4ZINos+FLhHAJ92OlX803U5c
        eZgIV4KjVgY9D7WhE1BdL0nblpTurUGBPsB7f18/rw==
X-Google-Smtp-Source: APXvYqwk+2CFvnT6NvUb9eOuFJFKqcG/yGGpUGXi0Sl2d6/g65bO1fXcehlShWQDKAbNdcIX+5B4/itOLqP5FYq7lOI=
X-Received: by 2002:a5e:d618:: with SMTP id w24mr7531431iom.73.1566571714710;
 Fri, 23 Aug 2019 07:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <1566326455-8038-1-git-send-email-cai@lca.pw> <xm26tvaaifoy.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26tvaaifoy.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Fri, 23 Aug 2019 09:48:08 -0500
Message-ID: <CAC=E7cWYSEAjUhgN5vBECmR5ATXWmt4M7n8sNN0xXStEsb4YjA@mail.gmail.com>
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable warnings
To:     Ben Segall <bsegall@google.com>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:36 PM <bsegall@google.com> wrote:
>
> Qian Cai <cai@lca.pw> writes:
>
> > The linux-next commit "sched/fair: Fix low cpu usage with high
> > throttling by removing expiration of cpu-local slices" [1] introduced a
> > few compilation warnings,
> >
> > kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> > kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
> > [-Wunused-but-set-variable]
> > kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> > kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
> > [-Wunused-but-set-variable]
> >
> > Also, __refill_cfs_bandwidth_runtime() does no longer update the
> > expiration time, so fix the comments accordingly.
> >
> > [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux@indeed.com/
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
>
> Reviewed-by: Ben Segall <bsegall@google.com>
>
> > ---
> >
> > v2: Keep hrtimer_forward_now() in start_cfs_bandwidth() per Ben.
> >
> >  kernel/sched/fair.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 84959d3285d1..06782491691f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
> >  }
> >
> >  /*
> > - * Replenish runtime according to assigned quota and update expiration time.
> > - * We use sched_clock_cpu directly instead of rq->clock to avoid adding
> > - * additional synchronization around rq->lock.
> > + * Replenish runtime according to assigned quota. We use sched_clock_cpu
> > + * directly instead of rq->clock to avoid adding additional synchronization
> > + * around rq->lock.
> >   *
> >   * requires cfs_b->lock
> >   */
> >  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
> >  {
> > -     u64 now;
> > -
> > -     if (cfs_b->quota == RUNTIME_INF)
> > -             return;
> > -
> > -     now = sched_clock_cpu(smp_processor_id());
> > -     cfs_b->runtime = cfs_b->quota;
> > +     if (cfs_b->quota != RUNTIME_INF)
> > +             cfs_b->runtime = cfs_b->quota;
> >  }
> >
> >  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> > @@ -4989,15 +4984,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >
> >  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >  {
> > -     u64 overrun;
> > -
> >       lockdep_assert_held(&cfs_b->lock);
> >
> >       if (cfs_b->period_active)
> >               return;
> >
> >       cfs_b->period_active = 1;
> > -     overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> > +     hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> >       hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> >  }

Looks good.
Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>

Sorry for the slow response, I was on vacation.

@Ben do you think it would be useful to still capture overrun, and
WARN on any overruns?  We wouldn't expect overruns, but their
existence would indicate an over-loaded node or too short of a
cfs_period.  Additionally, it would be interesting to see if we could
capture the offset between when the bandwidth was refilled, and when
the timer was supposed to fire.  I've always done all my calculations
assuming that the timer fires and is handled exceedingly close to the
time it was supposed to fire.  Although, if the node is running that
overloaded you probably have many more problems than worrying about
timer warnings.
