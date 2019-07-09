Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A14C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C9C21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azlj9K+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfGICRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:17:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46398 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:17:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so18282978ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH9b4/aCMkNsnZ4BuxomBwO3b4FG8IrZIJyykUqzUl0=;
        b=azlj9K+YPc5o/9vggqyDJGvx8R+QnbmJ0fFuzzX1/odUJJYP+e9D58POKq6gSrbrCc
         sR7etj1bz1taiuANg7sESLf2zYP5pyrh8VNwKHGJKXTVZKrbghNO5vijlB1MTfXpeUAH
         pjkRydhv1LuYGeIJZ/EdewfnI21ZrS6xaMGyVzkY8o05x5NFMqEhF6HDns1yP50TQZ86
         3KtXUd6sUBSbOns6CX5IZRUPF/ClI78yG0BzFLniw/imhpotGsWt7tQT2XaOO+uTbZcV
         drfqyIPebRE2MuEfZl98FgQC1KQkrTzZ2CB8TAMDGfymUjnFWAVrhAy7KpS3BBrtrz8m
         lTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH9b4/aCMkNsnZ4BuxomBwO3b4FG8IrZIJyykUqzUl0=;
        b=dNvZxuG42SNQuqQ2OggRykqUTMkWhgVzBwx2SQotlodQo3eF34FWrJeXvSt0rcpEB6
         0FLVWkUoo4QIk6eYYbQZXX28J/Yn2qWYTEczI7tKmp96r5LrvghM+I+yW2HffkCH9jjD
         qFTWQ/5Ph5v3d6k+gRT/FTmdn6suqCY3KtoOARtKlRWAG8QsrCg5iHs6ISg9ZUFc+H2e
         lFiljiJnG/bREfCxQ/+PMeXRu4XG1hiUszuaNqAxHZM/KT2f5PJTOlS7oTZJrOrqnJSr
         Q+nsZr8Eg7GWLI02Yj+Fdvbd5TrQhoDEwumsAVsBWf3RA3O9JTF9n88ynVWpfCWApjCw
         AbPQ==
X-Gm-Message-State: APjAAAVDVMbV41J2D+X6YgMPQdk7WDHNftHjRRxlvrN+QZ5sVMHhGkHS
        RXtPh5ogD9Pdzo0We5bFT9EEvmBXg3DfiYC874c=
X-Google-Smtp-Source: APXvYqwiiFEVBl/Qmj+dGzMC28G6+Tk7OEcQdxkc+Zb3SHNJFFGUuqmK8FKFz/TRcVQsPVrGL2bT7WA6PEoEgKXwG7c=
X-Received: by 2002:a9d:62c4:: with SMTP id z4mr2390158otk.56.1562638652111;
 Mon, 08 Jul 2019 19:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <1561983877-4727-1-git-send-email-wanpengli@tencent.com> <20190709013914.GA23714@lenoir>
In-Reply-To: <20190709013914.GA23714@lenoir>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 9 Jul 2019 10:17:19 +0800
Message-ID: <CANRm+CzokVgwLAaYCb_=9+0mUAvTb=8b3MbRNjuFjukdtmO_sQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Cache timer busy housekeeping target
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 at 09:39, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Mon, Jul 01, 2019 at 08:24:37PM +0800, Wanpeng Li wrote:
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index 41dfff2..0d49bef 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -195,8 +195,10 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
> >                                        int pinned)
> >  {
> >  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> > -     if (static_branch_likely(&timers_migration_enabled) && !pinned)
> > -             return &per_cpu(hrtimer_bases, get_nohz_timer_target());
> > +     if (static_branch_likely(&timers_migration_enabled) && !pinned) {
> > +             base->last_target_cpu = get_nohz_timer_target(base->last_target_cpu);
> > +             return &per_cpu(hrtimer_bases, base->last_target_cpu);
>
>
> I'm not sure this is exactly what we intend to cache here.
>
> This doesn't return the last CPU for a given timer
> (that would be timer->flags & TIMER_CPUMASK) but the last CPU that
> was returned when "base" was passed.
>
> First of all, it's always initialized to CPU 0, which is perhaps
> not exactly what we want.
>
> Also the result can be very stale and awkward. If for some reason we have:
>
>         base(CPU 5)->last_target_cpu = 255
>
> then later a timer is enqueued to CPU 5, the next time we re-enqueue that
> timer will be to CPU 255, then the second re-enqueue will be to whatever
> value we have in base(CPU 255)->last_target_cpu, etc...
>
> For example imagine that:
>
>         base(CPU 255)->last_target_cpu = 5
>
> the timer will bounce between those two very distant CPU 5 and 255. So I think
> you rather want "timer->flags & TIMER_CPUMASK". But note that those flags
> can also be initialized to zero and therefore CPU 0, while we actually want
> the CPU of the timer enqueuer for a first use. And I can't think of a
> simple solution to solve that :-(  Perhaps keeping the enqueuer CPU as the
> first choice (as we do upstream) is still the best thing we have.

Got it, thanks for pointing out this.

Wanpeng
