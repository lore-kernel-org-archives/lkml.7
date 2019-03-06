Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ADEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99B720675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2qpQ7bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfCFKQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:16:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54113 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbfCFKQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:16:17 -0500
Received: by mail-it1-f193.google.com with SMTP id v2so8659665ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=364R9KyMkRDw/XnQWTVu2NBY45bC2q61uAGFqOw/RR4=;
        b=o2qpQ7bJ/XGSCaGSHZfhTumMBc6Ohwlqq2ZG32L+jGrhUTGVPUUxt021zb6/fvFdz6
         5CD5ayXOkzUL3mboC4PNuXNzA/C34/QYz0iTz51fagq7vqbAItl2Rpdosh88Vj/Exk0D
         FAkmY70ow3De/U5XyuuAT3hW6WRi9l2dlgoPCiiIu/LlV9Pu8E2bCXkaXFaj59TqookF
         AvAq45iRPdo57F/8U4SWCZOUIhvN02z1kEw2y/8FHoFEFACROuWbwHWNE4Ox37a/XxSy
         L2FgPPTC9gIrN+2gVx6zf3rizRzChSkpkJTPh7ExPgLNbd2WKmCHHL42FSxxD0ByzZrT
         jo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=364R9KyMkRDw/XnQWTVu2NBY45bC2q61uAGFqOw/RR4=;
        b=rCV5Gtfv8wE0dN9FLGqqDpUgzpkV9/q090g30cthIYUKGyiGjt94OvTAZrCxv3kHsB
         B8dDXCp8UNvCgLLzrxNwh2XtAOirYb61PXiLULhYlHT29xvfpV7tSE6XMuiP+QmJYVmL
         twSmdcjN6nre4eYD3UrHRDe+8LsMt7OSyIYNhHDTE3oPeJ5rplRjRteKVSbSDKKp+h50
         O/vwrwn1RhnxUvlGvAjgv/TO0bx4w2hL0M2dX3cDKIXIv+Ci0JSIPhGjEWczDtXvGXDh
         t5cTINm+fNhU1A6aXA5hkVKQCkJfrB6Gt/vmgTom8mfL+1Orip2xFuXS3melLN9pITz8
         K+sg==
X-Gm-Message-State: APjAAAVfVxqpJnKMWi7DBvIfaiL/Sv3eiYm5BmcmXsWDqh/3427wHxKH
        SomSz+p/UryGBmPAwZInPEeDgELeZnQfLR43xWvcxqKw
X-Google-Smtp-Source: APXvYqxso40j+eq46x3rSd4XFsmrK/av6qG3j7nxoheoKl2xRYi433dHerBuExDgbAv2jliEzSr8kZ8g5Cu2RsYtClg=
X-Received: by 2002:a24:c043:: with SMTP id u64mr1541785itf.59.1551867375975;
 Wed, 06 Mar 2019 02:16:15 -0800 (PST)
MIME-Version: 1.0
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com> <20190306100907.GT32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306100907.GT32477@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Mar 2019 18:15:39 +0800
Message-ID: <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 6:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 04:43:46PM +0800, Yafang Shao wrote:
> > When I'm using trace_sched_stat_{iowait, blocked, wait, sleep} to
> > measure how long the processes are stalled, there's always no output from
> > trace_pipe while there're really some tasks in uninterruptible sleep
> > state. That makes me confused, so I try to investigate why.
> > Finally I find the reason is that CONFIG_SCHEDSTATS is not set.
> >
> > To avoid such kind of confusion, we should not expose these tracepoints
> > if CONFIG_SCHEDSTATS is not set.
>
> Yeah, lets not sprinkle #ifdef. Big fat NAK.
>
> Also, the below seem to indicate your compiler is stupid. Without
> CONFIG_SCHEDSTAT, schedstat_enabled() should be a constant 0 and DCE
> should delete all code.
>

My compiler is GCC-7.3.0.
I don't know which comipler could be smart enough to remove the
definition of these tracepoints.
Could you pls. tell me what compiler you are using ?

> > @@ -976,6 +982,7 @@ static void update_curr_fair(struct rq *rq)
> >  static inline void
> >  update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> > +#ifdef CONFIG_SCHEDSTATS
> >       if (!schedstat_enabled())
> >               return;
> >
> > @@ -988,12 +995,13 @@ static void update_curr_fair(struct rq *rq)
> >
> >       if (flags & ENQUEUE_WAKEUP)
> >               update_stats_enqueue_sleeper(cfs_rq, se);
> > +#endif
> >  }
> >
> >  static inline void
> >  update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> > -
> > +#ifdef CONFIG_SCHEDSTATS
> >       if (!schedstat_enabled())
> >               return;
> >
> > @@ -1014,6 +1022,7 @@ static void update_curr_fair(struct rq *rq)
> >                       __schedstat_set(se->statistics.block_start,
> >                                     rq_clock(rq_of(cfs_rq)));
> >       }
> > +#endif
> >  }
> >
> >  /*
> > @@ -4090,6 +4099,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >       update_stats_curr_start(cfs_rq, se);
> >       cfs_rq->curr = se;
> >
> > +#ifdef CONFIG_SCHEDSTATS
> >       /*
> >        * Track our maximum slice length, if the CPU's load is at
> >        * least twice that of our own weight (i.e. dont track it
> > @@ -4100,6 +4110,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                       max((u64)schedstat_val(se->statistics.slice_max),
> >                           se->sum_exec_runtime - se->prev_sum_exec_runtime));
> >       }
> > +#endif
> >
> >       se->prev_sum_exec_runtime = se->sum_exec_runtime;
> >  }
> > --
> > 1.8.3.1
> >
