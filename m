Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C1C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0748F2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFYsFC6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfGMIrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 04:47:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41364 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfGMIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 04:47:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so11144588eds.8;
        Sat, 13 Jul 2019 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKh1W7omwWLA2k9sKjo76Pevd8zQpf7ZgCucbVdxePk=;
        b=WFYsFC6ZV2mwPVXgz84QxWoezyTFRAI3+7Pvqz42wPspAmlXrPmCEqtjFdQ4NbN1IW
         2Mj2Blx1aOQhugsYGs5Zjwuwpv6j0Tk6YV+LfNtTo81psSKoVj80DdmZ9Xfr2mIB0lwO
         tjk731FbsaafBPIpXDDcY3jSQFunmTBA7gezSYEDDccasM+fOZC+fBwpJfMRNkukvCgd
         /wbSZkB3TzOUF0z1s9X5UwIxGg38F4dFlxUpyjp2OgU4TwzlReEabYDcMrvunULBwVQi
         bCPCrMBsOJtG2IfXpsQoeWQXBUjNkDBFgI4Hfh5wItzkeHiLGyYu9Q2yoC1aySYtO5st
         +Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKh1W7omwWLA2k9sKjo76Pevd8zQpf7ZgCucbVdxePk=;
        b=BUDyrkHC4dQVUXtNoa5JpGYwqHunfuo0PvpqpVx01Dw6hFbEbRooM6Uy2kXDTEVStP
         reZkFd7n9HhmDNkYD/+8m8tCyGnuydekALmYGuTedwNv44DjIHPM5YWxogRPanCLriSY
         wovmPNHGlrz8VXW5MbMIZHhfHWCxVfKvzCLsrzPh7NdJg5tiLxJRjeGCc1AfSwHS9D/e
         BBG6fYlmmM/PiMubnTHDu6N2gt9J9piEpc3bFK+WzzJ11fQcQYlANX9dsJDuGrMRgK0o
         GF9ACzptlm+0j3YUIaANvGGVxz/UZLB6DBBaCh1Wda2FV7wBkO1MHGcVUIVsIlZJrrFx
         9Imw==
X-Gm-Message-State: APjAAAXhZ0pd/7cxbtef6Q6g8rW+v5a7razenIESOeMx5sZ/qtm8g91n
        squ2ei9+6NeHSle7uRpXEtYwGcg1B0PcT2iDf8s=
X-Google-Smtp-Source: APXvYqwMcolUP9NhbhbrymbCCZllb/0oQrvT4PipY+yJEllSkg8TWHYWI1nRLTniFu9P6tcNgjR0rLp1J5KC3FApV78=
X-Received: by 2002:a05:6402:14d4:: with SMTP id f20mr13107423edx.125.1563007661149;
 Sat, 13 Jul 2019 01:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190708130359.GA42888@google.com> <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com> <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com> <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com> <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com> <20190712063240.GD7702@X58A-UD3R> <20190712125116.GB92297@google.com>
In-Reply-To: <20190712125116.GB92297@google.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Sat, 13 Jul 2019 17:47:31 +0900
Message-ID: <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 9:51 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > anywhere.
> > >
> > > Any idea why it was added but not used?
> > >
> > > I am interested in dumping this value just for fun, and seeing what I get.
> > >
> > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > look like.
> >
> > Hi,
> >
> >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> >       rcu: Remove debugfs tracing
> >
> > removed all debugfs tracing, gp_max also included.
> >
> > And you sounds great. And even looks not that hard to add it like,
> >
> > :)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ad9dc86..86095ff 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> >       raw_spin_lock_irq_rcu_node(rnp);
> >       rcu_state.gp_end = jiffies;
> >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > -     if (gp_duration > rcu_state.gp_max)
> > +     if (gp_duration > rcu_state.gp_max) {
> >               rcu_state.gp_max = gp_duration;
> > +             trace_rcu_grace_period(something something);
> > +     }
>
> Yes, that makes sense. But I think it is much better off as a readable value
> from a virtual fs. The drawback of tracing for this sort of thing are:
>  - Tracing will only catch it if tracing is on
>  - Tracing data can be lost if too many events, then no one has a clue what
>    the max gp time is.
>  - The data is already available in rcu_state::gp_max so copying it into the
>    trace buffer seems a bit pointless IMHO
>  - It is a lot easier on ones eyes to process a single counter than process
>    heaps of traces.
>
> I think a minimal set of RCU counters exposed to /proc or /sys should not
> hurt and could do more good than not. The scheduler already does this for
> scheduler statistics. I have seen Peter complain a lot about new tracepoints
> but not much (or never) about new statistics.
>
> Tracing has its strengths but may not apply well here IMO. I think a counter
> like this could be useful for tuning of things like the jiffies_*_sched_qs,
> the stall timeouts and also any other RCU knobs. What do you think?

I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
looks like undoing what Paul did at ae91aa0ad.

I think you're rational enough. I just wondered how Paul think of it.

-- 
Thanks,
Byungchul
