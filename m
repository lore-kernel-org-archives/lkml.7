Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E3EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3340020811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNJCga+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCSRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:52:16 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33669 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCSRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:52:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id z6so12263694vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ujmk147faWtjPzsKh7iCqt+9xCD/NBZvc9Bqu3/KOQ8=;
        b=JNJCga+ijl20TUPqrF5QLh9DhZZlB8zlL5q0LjqGEJtjZA/Pkh4D6v/8XVzSycXJ5O
         +lYrmdUo6HYanvf2N20ujXL10j49dDAdCzCttzhFKcHmLOVW1rOP1pqjSLVkFZAE25Ey
         xdSoXuKG8MQ41nVa8HC+7kT9pBa56B4bh34yqVydae8WxVYUlq85LEWrYuHqsv2N2TMs
         THGA2CgV1qHQnX0bqeLHa2can9OHSTjNRN87H2GlXR8ptsId09MyQs4lUH8Fj7J5HFLL
         EZXZ7U0HS55xCDWXT6o2wuqRXZDY+7YZUiGv5zcFQxSsygS94+w7ORUklABpsKJEn7Rb
         z9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ujmk147faWtjPzsKh7iCqt+9xCD/NBZvc9Bqu3/KOQ8=;
        b=uZ5emIHBZ/t5y9b+NuyRh1EZwmbUD3qPYnLGGmHUL6iJShqQuVdRd2eF0dtYdAr28c
         QIbxL4TYuKOR+azMk9JqTt4+CIilZOPal5R08YsC6VqYb/rXMOWGsmjluL3adG5ehSQa
         533ssWzPnRydIN1c7fmg0dM6WXspftE/ijEBgIMPf1taJD2/n3xs08kCPf3u3s6AAgE5
         VorsarHJwfwRMDvSJVhKmxLTp4XVju9uc339zy3CbV7QTuSQq7oxqMjYDcM7Dl+Oculk
         UDCs23h7VjdDnymVc4gjDcs6x158he16X3WZmoOguolXGArMIrqbyH8vLGdWtLqCxS8p
         2ZcQ==
X-Gm-Message-State: APjAAAVbFBccmSZRpCnTxyWvn8GMo6B/SqKRUXJJbiHy3qzDbR3OmYZa
        B8hAN6TXjxtXYVn12Q2fgQ8pGPesAknEr3hqy02V8A==
X-Google-Smtp-Source: APXvYqwXDxZS8YVzeS88aSnYi6ELHJVoHB5h3wvpDRzR4pPs9CFUbBXCWDaSGaRBqXQdY7fpvRs7nezKnbj6FcQ9mVI=
X-Received: by 2002:a67:ff07:: with SMTP id v7mr2176894vsp.231.1553017933859;
 Tue, 19 Mar 2019 10:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com> <20190319110549.GC5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190319110549.GC5996@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Mar 2019 10:52:01 -0700
Message-ID: <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 18, 2019 at 11:29:25PM -0700, Stephane Eranian wrote:
>
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -3410,7 +3410,7 @@ tfa_get_event_constraints(struct cpu_hw_
> > >         /*
> > >          * Without TFA we must not use PMC3.
> > >          */
> > > -       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
> > > +       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
> > >                 c = dyn_constraint(cpuc, c, idx);
> > >                 c->idxmsk64 &= ~(1ULL << 3);
> > >                 c->weight--;
> > >
> > >
>
> > I was not cc'd on the patch that added  allow_tsx_force_abort, so I
>
> Yeah, that never was public :-( I didn't particularly like that, but
> that's the way it is.
>
> > will give some comments here.
>
> > If I understand the goal of the control parameter it is to turn on/off
> > the TFA workaround and thus determine whether or not PMC3 is
> > available. I don't know why you would need to make this a runtime
> > tunable.
>
> Not quite; the control on its own doesn't directly write the MSR. And
> even when the work-around is allowed, we'll not set the MSR unless there
> is also demand for PMC3.
>
Trying to understand this better here. When the workaround is enabled
(tfa=0), you lose
PMC3 and transactions operate normally. When it is disabled (tfa=1),
transactions are
all aborted and PMC3 is available. If you are saying that when there
is a PMU event
requesting PMC3, then you need PMC3 avail, so you set the MSR so that
tfa=1 forcing
all transactions to abort. But in that case, you are modifying the
execution of the workload
when you are monitoring it, assuming it uses TSX.  You want lowest
overhead and no
modifications to how the workload operates, otherwise how
representative is the data you are
collecting? I understand that there is no impact on apps not using
TSX, well, except on context
switch where you have to toggle that MSR. But for workloads using TSX,
there is potentially
an impact.

> It is a runtime tunable because boot parameters suck.
>
> > That seems a bit dodgy. But given the code you have here right now, we
> > have to deal with it. A sysadmin could flip the control at any time,
> > including when PMC3 is already in used by some events. I do not see
> > the code that schedules out all the events on all CPUs once PMC3
> > becomes unavailable. You cannot just rely on the next context-switch
> > or timer tick for multiplexing.
>
> Yeah, meh. You're admin, you can 'fix' it. In practise I don't expect
> most people to care about the knob, and the few people that do, should
> be able to make it work.

I don't understand how this can work reliably. You have a knob to toggle
that MSR. Then, you have another one inside perf_events and then the sysadmin
has to make sure nobody (incl. NMI watchdog) is using the PMU when
this all happens.
How can this be a practical solution? Am I missing something here?
