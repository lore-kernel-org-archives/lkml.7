Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC692086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rl3XhvxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfJCT1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:27:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37067 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:27:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so3693043oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52Mg07dQkN/KgqaFhPCi4LxnJtO5hzy5vEl2iOqJhXg=;
        b=Rl3XhvxBLp1pm9YJv409CIqJTF8gWIZf+7lDHQYRLQILtuvBwdlj+Jgwz/ZV4XPLu/
         PP8FOQXQqyh8ZABMivhGySR+LiFa7fbMZAZ6Ogx554yttBsAtsKVlIqU9qTYgtZA11A7
         u0jgRaIgIDJj5akT8MBa23WOmZVnYoghxwNHyyNpuh+b2YDedTCMSapsx4jq4KNwkFtR
         2tDV+nfaRw+/HoJ3sh9i1bhPDVLn1ZBYsTP1tcvSTLj/DrcfJNiqDC0X77IfdwEic1sM
         ejop0GWC/y14N8Tec0qEw95UlyPPYOmGKi3Ee9ltkUO2ToA74MORWnnEVSQWG5svQlCF
         FGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52Mg07dQkN/KgqaFhPCi4LxnJtO5hzy5vEl2iOqJhXg=;
        b=nC2Fhpz3Dc6c3yKJKRx2yUR6jenUbS2e08UU+4rrdrJ+CdvUkKg3nGrWgeNF69fhnH
         3J2sUNYfxCUF1kNU0MNWZaH5QjpfqIEklUOjSztxfZ8AltBOLrvYOxlaYNyA7iePTr2O
         ki7Ivfe0pKJnRmWESIxo2/H2Ecn/VVZc64TsNTSdaISnZEg2T154z9YXBPOgTUoU5fIE
         hNvFZq3yWDVelpWeHITBvg3TrG0Sp7pHxIMA4kHh1fbUi6UOe2fqqoKaF5NTltreFMEw
         zmbN09c4uRGbhklwaBQfquCIMEput21FgqZijTBbNUeKNCB7PvkE88abK7cudRhAm+gN
         U1NQ==
X-Gm-Message-State: APjAAAX7104Jk5DQBXK+IBJ5lbedXyNopfM7tUKfzVnCZnyltZAq1tVg
        tTb+/32LGeK47aWJ6Hk/zmgWi0vzaTXasXXfIE+2HA==
X-Google-Smtp-Source: APXvYqyy0InBwqHNwSMOEWa4FEAAbj17Mdxk9E/w7LfNUaDgSHgGHPbCnLM2hUFeffvnvEiWoFHsRWYWOP3f5M7ZaH0=
X-Received: by 2002:aca:4b85:: with SMTP id y127mr4144838oia.70.1570130839954;
 Thu, 03 Oct 2019 12:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920163123.GC55224@lakrids.cambridge.arm.com> <CACT4Y+ZwyBhR8pB7jON8eVObCGbJ54L8Sbz6Wfmy3foHkPb_fA@mail.gmail.com>
 <CANpmjNM+aEzySwuMDkEvsVaeTooxExuTRAv-nzjhp7npT8a3ag@mail.gmail.com> <20191003161233.GB38140@lakrids.cambridge.arm.com>
In-Reply-To: <20191003161233.GB38140@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 3 Oct 2019 21:27:08 +0200
Message-ID: <CANpmjNMBehv0UUuEko-F-ygegX+YS+Km3ggFB0tnBoCpRRXhSw@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019 at 18:12, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Sep 20, 2019 at 07:51:04PM +0200, Marco Elver wrote:
> > On Fri, 20 Sep 2019 at 18:47, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 6:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > >
> > > > Nice!
> > > >
> > > > BTW kcsan_atomic_next() is missing a stub definition in <linux/kcsan.h>
> > > > when !CONFIG_KCSAN:
> > > >
> > > > https://github.com/google/ktsan/commit/a22a093a0f0d0b582c82cdbac4f133a3f61d207c#diff-19d7c475b4b92aab8ba440415ab786ec
> > > >
> > > > ... and I think the kcsan_{begin,end}_atomic() stubs need to be static
> > > > inline too.
> >
> > Thanks for catching, fixed and pushed. Feel free to rebase your arm64 branch.
>
> Great; I've just done so!
>
> What's the plan for posting a PATCH or RFC series?

I'm planning to send some patches, but with the amount of data-races
being found I need to prioritize what we send first. Currently the
plan is to let syzbot find data-races, and we'll start by sending a
few critical reports that syzbot found. Syzbot should be set up fully
and start finding data-races within next few days.

> The rest of this email is rabbit-holing on the issue KCSAN spotted;
> sorry about that!

Thanks for looking into this! I think you're right, and please do feel
free to send a proper patch out.

Thanks,
-- Marco

> [...]
>
> > > > We have some interesting splats at boot time in stop_machine, which
> > > > don't seem to have been hit/fixed on x86 yet in the kcsan-with-fixes
> > > > branch, e.g.
> > > >
> > > > [    0.237939] ==================================================================
> > > > [    0.239431] BUG: KCSAN: data-race in multi_cpu_stop+0xa8/0x198 and set_state+0x80/0xb0
> > > > [    0.241189]
> > > > [    0.241606] write to 0xffff00001003bd00 of 4 bytes by task 24 on cpu 3:
> > > > [    0.243435]  set_state+0x80/0xb0
> > > > [    0.244328]  multi_cpu_stop+0x16c/0x198
> > > > [    0.245406]  cpu_stopper_thread+0x170/0x298
> > > > [    0.246565]  smpboot_thread_fn+0x40c/0x560
> > > > [    0.247696]  kthread+0x1a8/0x1b0
> > > > [    0.248586]  ret_from_fork+0x10/0x18
> > > > [    0.249589]
> > > > [    0.250006] read to 0xffff00001003bd00 of 4 bytes by task 14 on cpu 1:
> > > > [    0.251804]  multi_cpu_stop+0xa8/0x198
> > > > [    0.252851]  cpu_stopper_thread+0x170/0x298
> > > > [    0.254008]  smpboot_thread_fn+0x40c/0x560
> > > > [    0.255135]  kthread+0x1a8/0x1b0
> > > > [    0.256027]  ret_from_fork+0x10/0x18
> > > > [    0.257036]
> > > > [    0.257449] Reported by Kernel Concurrency Sanitizer on:
> > > > [    0.258918] CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.3.0-00007-g67ab35a199f4-dirty #3
> > > > [    0.261241] Hardware name: linux,dummy-virt (DT)
> > > > [    0.262517] ==================================================================>
> >
> > Thanks, the fixes in -with-fixes were ones I only encountered with
> > Syzkaller, where I disable KCSAN during boot. I've just added a fix
> > for this race and pushed to kcsan-with-fixes.
>
> I think that's:
>
>   https://github.com/google/ktsan/commit/c1bc8ab013a66919d8347c2392f320feabb14f92
>
> ... but that doesn't look quite right to me, as it leaves us with the shape:
>
>         do {
>                 if (READ_ONCE(msdata->state) != curstate) {
>                         curstate = msdata->state;
>                         switch (curstate) {
>                                 ...
>                         }
>                         ack_state(msdata);
>                 }
>         } while (curstate != MULTI_STOP_EXIT);
>
> I don't believe that we have a guarantee of read-after-read ordering
> between the READ_ONCE(msdata->state) and the subsequent plain access of
> msdata->state, as we've been caught out on that in the past, e.g.
>
>   https://lore.kernel.org/lkml/1506527369-19535-1-git-send-email-will.deacon@arm.com/
>
> ... which I think means we could switch on a stale value of
> msdata->state. That would mean we might handle the same state twice,
> calling ack_state() more times than expected and corrupting the count.
>
> The compiler could also replace uses of curstate with a reload of
> msdata->state. If it did so for the while condition, we could skip the
> expected ack_state() for MULTI_STOP_EXIT, though it looks like that
> might not matter.
>
> I think we need to make sure that we use a consistent snapshot,
> something like the below. Assuming I'm not barking up the wrong tree, I
> can spin this as a proper patch.
>
> Thanks,
> Mark.
>
> ---->8----
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index b4f83f7bdf86..67a0b454b5b5 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -167,7 +167,7 @@ static void set_state(struct multi_stop_data *msdata,
>         /* Reset ack counter. */
>         atomic_set(&msdata->thread_ack, msdata->num_threads);
>         smp_wmb();
> -       msdata->state = newstate;
> +       WRITE_ONCE(msdata->state, newstate);
>  }
>
>  /* Last one to ack a state moves to the next state. */
> @@ -186,7 +186,7 @@ void __weak stop_machine_yield(const struct cpumask *cpumask)
>  static int multi_cpu_stop(void *data)
>  {
>         struct multi_stop_data *msdata = data;
> -       enum multi_stop_state curstate = MULTI_STOP_NONE;
> +       enum multi_stop_state newstate, curstate = MULTI_STOP_NONE;
>         int cpu = smp_processor_id(), err = 0;
>         const struct cpumask *cpumask;
>         unsigned long flags;
> @@ -210,8 +210,9 @@ static int multi_cpu_stop(void *data)
>         do {
>                 /* Chill out and ensure we re-read multi_stop_state. */
>                 stop_machine_yield(cpumask);
> -               if (msdata->state != curstate) {
> -                       curstate = msdata->state;
> +               newstate = READ_ONCE(msdata->state);
> +               if (newstate != curstate) {
> +                       curstate = newstate;
>                         switch (curstate) {
>                         case MULTI_STOP_DISABLE_IRQ:
>                                 local_irq_disable();
>
