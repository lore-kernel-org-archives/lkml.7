Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B90CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579B521874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWDWWpdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCTTaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:30:39 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:34961 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCTTaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:30:39 -0400
Received: by mail-vs1-f49.google.com with SMTP id e1so2256703vsp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnh4d9FMsUh+puifdzo73TnsQigvSChyiiU4x35+CIQ=;
        b=gWDWWpdJ6kLJBQDd7dxSemaYYlqc64Au3rchGTXh4AKqUJwBv7AqeNXsBE1s3YPkLS
         A8pWl/do3PDEH0x8A31Ut8Ri0pjsZZo7A7ayt+BGm5yJ84iBKV+0ULjWoNgBCt+iDZhM
         zd7UyPpD2HWbamROD3W6tkxSnehkkh6xLqBCFo4L14TlUF2ePvFibgNWmUlAj0Qy/9fM
         SrTFKPY/DayJNXJjXsr0OCXAB/0rOP5JM/Q99GdfGtudgoQoLMCGW/2C5VntAHvjkbPY
         ZqG4QxEuo+BGQogGCnTdanPmTeqAGim2BMYUVLLj6d8PvrBLWbWCzHx2ocC8XOiL7I1O
         XdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnh4d9FMsUh+puifdzo73TnsQigvSChyiiU4x35+CIQ=;
        b=F+RewTjC1xwway7dY7uGny6bpy1zXgBJ8e+NPoEh09Wk5eY9KffLLaIzNgqRl3Vwc5
         60JpyZvVicO9N3kwPNAyBf3tntzEDmFW79bcnVPYxgicSIDfpmWqvQaO5fzDloft13AI
         PTnK8EwdaU5Nb0J1pnkYr9NtKW+lqvLH96KsajBNHQHnRVxufP4WOJhf2OtKTJTHjZ4R
         9H9u8j+oBvX4XSBg/+UBe0ogGSvDp/UXDms3Wa6NQ+GtZx/RnWX+/vDV1VtK8IvhcEQo
         yXYqC/LCo1MUQh5EOeX2kA3Ygf70lJd6VApa2FeUmG/fQPTkKYAEnVMhLPS32lDYSQL/
         OmPA==
X-Gm-Message-State: APjAAAW2kS5bKCdfA1699PMqdcsI6pdKYr/yLS5b7xZK1It+ZesXd2J5
        3qYEwWHUdDZBUeQDHLBGO4wwPXIV/1xcko4soINZ4w==
X-Google-Smtp-Source: APXvYqxntrVlpa2DjBcAxEZE4raGfPHH9lOt5SpHKCzESdADZ7tpD6LQ4PTEC2Nx6RLbO8+MhNRfooFb4dP5dCQe0pg=
X-Received: by 2002:a05:6102:d4:: with SMTP id u20mr6126580vsp.101.1553110237738;
 Wed, 20 Mar 2019 12:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130706.061994422@infradead.org>
 <CABPqkBSH5UBaV7+0JKgr4YmEke8Tu4Hry9GAFYT5C_gsncqf3A@mail.gmail.com> <20190320131108.GG6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190320131108.GG6058@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 20 Mar 2019 12:30:25 -0700
Message-ID: <CABPqkBQ+1zCJmYCH_cHrs3Z3t3iVyWLeiWD_nUy1niu4qFhvpg@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/8] perf/x86: Optimize x86_schedule_events()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 19, 2019 at 04:55:16PM -0700, Stephane Eranian wrote:
> > On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > @@ -858,8 +864,20 @@ int x86_schedule_events(struct cpu_hw_ev
> > >                 x86_pmu.start_scheduling(cpuc);
> > >
> > >         for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
> > > -               c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> > > -               cpuc->event_constraint[i] = c;
> > > +               c = cpuc->event_constraint[i];
> > > +
> > > +               /*
> > > +                * Request constraints for new events; or for those events that
> > > +                * have a dynamic constraint due to the HT workaround -- for
> > > +                * those the constraint can change due to scheduling activity
> > > +                * on the other sibling.
> > > +                */
> > > +               if (!c || ((c->flags & PERF_X86_EVENT_DYNAMIC) &&
> > > +                          is_ht_workaround_active(cpuc))) {
> > > +
> > > +                       c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> > > +                       cpuc->event_constraint[i] = c;
> > > +               }
>
> > On this one, I think there may be a problem with events with
> > shared_regs constraints.
>
> Hmm...
>
> > Constraint is dynamic as it depends on other events which share the
> > same MSR, yet it is not marked as DYNAMIC.
>
> it returns &emptyconstraint or a table constraint, depending on register
> state.
>
> > But this may be okay because these other events are all on the same
> > CPU and thus scheduled during the same ctx_sched_in(). Yet with the
> > swapping in intel_alt_er(), we need to double-check that we cannot
> > reuse a constraint which could be stale.
>
> > I believe this is okay, just double-check.
>
> I'm not sure I see a problem.
>
> So if we're the first event on a shared register, we claim the register
> and scheduling succeeds (barring other constraints).
>
> If we're the second event on a shared register (and have conflicting
> register state), we get the empty constraint. This _will_ cause
> scheduling to fail. We'll not cache the state and punt it back to the
> core code.
>
> So no future scheduling pass will come to see a shared reg constraint
> that could've changed.
>
> Now, there is indeed the intel_alt_er() thing, which slightly
> complicates this; then suppose we schedule an event on RSP0, another on
> RSP1, then remove the RSP0 one. Even in that case, the remaining RSP1
> event will not change its constraint, since intel_fixup_er() rewrites
> the event to be a native RSP1 event.
>
> So that too reduces to the prior case.
>
I came the same conclusion later yesterday. I think this is okay.

>
> That said; I have simplified the above condition to:
>
> @@ -858,8 +858,17 @@ int x86_schedule_events(struct cpu_hw_ev
>                 x86_pmu.start_scheduling(cpuc);
>
>         for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
> -               c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> -               cpuc->event_constraint[i] = c;
> +               c = cpuc->event_constraint[i];
> +
> +               /*
> +                * Request constraints for new events; or for those events that
> +                * have a dynamic constraint -- for those the constraint can
> +                * change due to external factors (sibling state, allow_tfa).
> +                */
> +               if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
> +                       c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> +                       cpuc->event_constraint[i] = c;
> +               }
>
Right now DYNAMIC is only casued by the HT bug, but it could change later on but
the logic here would remain. If HT workaround is disabled, then no
evnt is tagged with
DYNAMIC.

>                 wmin = min(wmin, c->weight);
>                 wmax = max(wmax, c->weight);
>
> Because any dynamic event can change from one moment to the next.
I agree.
