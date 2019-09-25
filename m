Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B8C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180DF21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="erg1HrlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392741AbfIYUDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:03:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44880 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIYUDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:03:15 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so84706iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/RTPptMzVlxWY6kHXdS0P3xSNWevs200xt+aATskwU=;
        b=erg1HrlJng3dStEDefsrPZCNWQSvBlUR8Da1WM8mj7tT7syQA+1jnrAgrs+oaKM63S
         tXi4rvN+XMuX+yHICWCEYgS15KCtl0iFfVyl6EdEfEmkMNMZB4hgQzGbJU39gy9jR/F5
         Y8zQ11MMPrhJuWEd7d/t/OcE/0fNbzNthWUm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/RTPptMzVlxWY6kHXdS0P3xSNWevs200xt+aATskwU=;
        b=piBDyoAsItl7ObcUqx0jj2UTX0Eb9XaD2BzTerZi0PMVe9sXi78HCocsz4z6M//RRT
         3t09/kqsalyzJl0Yrxlq1CmEPRhxuOpG0KyMoh7pvQtwEGPuejdB3sm9kcutIYKtJW83
         wUv1kfagDtw1bGzbWHwDKg4J4CV2NPbQhUKeBaJnz1jNQc9aGJULiTZwYfrgBGzKZz/g
         W4Ri9fEApHQRCmIFlhw4edJ+kYHND75v5aZEcT1hJgVRRFRdV2/ZTI3Dwia3BFZrjjt1
         tYVECoizWr1QGtiwszmFuoajiKkt6d2xPi50+eg9TK8GAbZXQO16jsipqCwciJPw9Nez
         zK9A==
X-Gm-Message-State: APjAAAWjMkGnkBFIDDN1myGsfFRTxKglxhwdDXJbY0jeuU8T4Sdwfa1X
        +otCZG8vXOOrL1TJ73qKNb5wmlZvvTc=
X-Google-Smtp-Source: APXvYqw6wQSzzTpdRFCgLlrvhyQ561MJKnXWSRwpNp5vio+OvFgQlXezzhlp01G2HuHbXQ8i6PT/LA==
X-Received: by 2002:a6b:8e92:: with SMTP id q140mr1277109iod.205.1569441794220;
        Wed, 25 Sep 2019 13:03:14 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id g8sm300733ioc.0.2019.09.25.13.03.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:03:13 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id a1so172965ioc.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:03:13 -0700 (PDT)
X-Received: by 2002:a92:4a11:: with SMTP id m17mr1653859ilf.142.1569441793167;
 Wed, 25 Sep 2019 13:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190731183732.178134-1-dianders@chromium.org> <20190830145237.aoysubwetqe3eggj@holly.lan>
In-Reply-To: <20190830145237.aoysubwetqe3eggj@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Sep 2019 13:03:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URLYwLZ0R0zzrH5xKdRWD52X7Qn_MaLdXjvWYv8vF+6Q@mail.gmail.com>
Message-ID: <CAD=FV=URLYwLZ0R0zzrH5xKdRWD52X7Qn_MaLdXjvWYv8vF+6Q@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Fix stack crawling on 'running' CPUs that aren't
 the master
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 30, 2019 at 7:52 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Jul 31, 2019 at 11:37:32AM -0700, Douglas Anderson wrote:
> > In kdb when you do 'btc' (back trace on CPU) it doesn't necessarily
> > give you the right info.  Specifically on many architectures
> > (including arm64, where I tested) you can't dump the stack of a
> > "running" process that isn't the process running on the current CPU.
> > This can be seen by this:
> >
> >  echo SOFTLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> >  # wait 2 seconds
> >  <sysrq>g
> >
> > Here's what I see now on rk3399-gru-kevin.  I see the stack crawl for
> > the CPU that handled the sysrq but everything else just shows me stuck
> > in __switch_to() which is bogus:
> >
> > ======
> >
> > [0]kdb> btc
> > btc: cpu status: Currently on cpu 0
> > Available cpus: 0, 1-3(I), 4, 5(I)
> > Stack traceback for pid 0
> > 0xffffff801101a9c0        0        0  1    0   R  0xffffff801101b3b0 *swapper/0
> > Call trace:
> >  dump_backtrace+0x0/0x138
> >  ...
> >  kgdb_compiled_brk_fn+0x34/0x44
> >  ...
> >  sysrq_handle_dbg+0x34/0x5c
> > Stack traceback for pid 0
> > 0xffffffc0f175a040        0        0  1    1   I  0xffffffc0f175aa30  swapper/1
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f65616c0
> > Stack traceback for pid 0
> > 0xffffffc0f175d040        0        0  1    2   I  0xffffffc0f175da30  swapper/2
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f65806c0
> > Stack traceback for pid 0
> > 0xffffffc0f175b040        0        0  1    3   I  0xffffffc0f175ba30  swapper/3
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f659f6c0
> > Stack traceback for pid 1474
> > 0xffffffc0dde8b040     1474      727  1    4   R  0xffffffc0dde8ba30  bash
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  __schedule+0x464/0x618
> >  0xffffffc0dde8b040
> > Stack traceback for pid 0
> > 0xffffffc0f17b0040        0        0  1    5   I  0xffffffc0f17b0a30  swapper/5
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f65dd6c0
> >
> > ===
> >
> > The problem is that 'btc' eventually boils down to
> >   show_stack(task_struct, NULL);
> >
> > ...and show_stack() doesn't work for "running" CPUs because their
> > registers haven't been stashed.
> >
> > On x86 things might work better (I haven't tested) because kdb has a
> > special case for x86 in kdb_show_stack() where it passes the stack
> > pointer to show_stack().  This wouldn't work on arm64 where the stack
> > crawling function seems needs the "fp" and "pc", not the "sp" which is
> > presumably why arm64's show_stack() function totally ignores the "sp"
> > parameter.
> >
> > NOTE: we _can_ get a good stack dump for all the cpus if we manually
> > switch each one to the kdb master and do a back trace.  AKA:
> >   cpu 4
> >   bt
> > ...will give the expected trace.  That's because now arm64's
> > dump_backtrace will now see that "tsk == current" and go through a
> > different path.
> >
> > In this patch I fix the problems by catching a request to stack crawl
> > a task that's running on a CPU and then I ask that CPU to do the stack
> > crawl.
> >
> > NOTE: this will (presumably) change what stack crawls are printed for
> > x86 machines.  Now kdb functions will show up in the stack crawl.
> > Presumably this is OK but if it's not we can go back and add a special
> > case for x86 again.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I think this approach can be made work but there are problems as things
> exist today, see below.
>
>
> > ---
> >
> > Changes in v2:
> > - Totally new approach; now arch agnostic.
> >
> >  kernel/debug/debug_core.c |  5 +++++
> >  kernel/debug/debug_core.h |  1 +
> >  kernel/debug/kdb/kdb_bt.c | 44 ++++++++++++++++++++++++++++++---------
> >  3 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 5cc608de6883..a89c72714fe6 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -92,6 +92,8 @@ static int kgdb_use_con;
> >  bool dbg_is_early = true;
> >  /* Next cpu to become the master debug core */
> >  int dbg_switch_cpu;
> > +/* cpu number of slave we request a stack crawl of */
> > +int dbg_slave_dumpstack_cpu = -1;
> >
> >  /* Use kdb or gdbserver mode */
> >  int dbg_kdb_mode = 1;
> > @@ -580,6 +582,9 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
> >                               atomic_xchg(&kgdb_active, cpu);
> >                               break;
> >                       }
> > +             } else if (dbg_slave_dumpstack_cpu == cpu) {
>
> Couldn't this be encoded in the exception state?

Yup, but it requires exporting the exception state from debug_core.c
(or exporting a function that sets this).  Ah, but below you said you
wanted the whole stack crawling on a CPU moved to debug_core.c, so
done.


> > +                     dump_stack();
> > +                     dbg_slave_dumpstack_cpu = -1;
>
> >               } else if (kgdb_info[cpu].exception_state & DCPU_IS_SLAVE) {
> >                       if (!raw_spin_is_locked(&dbg_slave_lock))
> >                               goto return_normal;
> > diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
> > index b4a7c326d546..dca74d5caef2 100644
> > --- a/kernel/debug/debug_core.h
> > +++ b/kernel/debug/debug_core.h
> > @@ -62,6 +62,7 @@ extern int dbg_io_get_char(void);
> >  /* Switch from one cpu to another */
> >  #define DBG_SWITCH_CPU_EVENT -123456
> >  extern int dbg_switch_cpu;
> > +extern int dbg_slave_dumpstack_cpu;
> >
> >  /* gdbstub interface functions */
> >  extern int gdb_serial_stub(struct kgdb_state *ks);
> > diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> > index 7e2379aa0a1e..10095ae05826 100644
> > --- a/kernel/debug/kdb/kdb_bt.c
> > +++ b/kernel/debug/kdb/kdb_bt.c
> > @@ -10,6 +10,7 @@
> >   */
> >
> >  #include <linux/ctype.h>
> > +#include <linux/delay.h>
> >  #include <linux/string.h>
> >  #include <linux/kernel.h>
> >  #include <linux/sched/signal.h>
> > @@ -22,20 +23,43 @@
> >  static void kdb_show_stack(struct task_struct *p, void *addr)
> >  {
> >       int old_lvl = console_loglevel;
> > +     int time_left;
> > +     int cpu;
> > +
> >       console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
> >       kdb_trap_printk++;
> > -     kdb_set_current_task(p);
> > -     if (addr) {
> > -             show_stack((struct task_struct *)p, addr);
> > -     } else if (kdb_current_regs) {
> > -#ifdef CONFIG_X86
> > -             show_stack(p, &kdb_current_regs->sp);
> > -#else
> > -             show_stack(p, NULL);
> > -#endif
> > +
> > +     if (!addr && kdb_task_has_cpu(p)) {
> > +             cpu = kdb_process_cpu(p);
> > +
> > +             if (cpu == raw_smp_processor_id()) {
> > +                     dump_stack();
> > +                     goto exit;
>
> This goto is not for error recovery but looks like it is. Why can't we
> use normal control flow here (extracting the remote stack dump logic
> into a seperate function if the right margin is getting too close)?
>
> In fact to be honest a function call would be useful anyway since I'd
> rather have all the resulting horror in a single file (debug_core.c).

Sure.  Done.


> > +             }
> > +
> > +             /*
> > +              * In general architectures don't support dumping the stack
> > +              * of a "running" process that's not the current one so if
> > +              * we want to dump the stack of a running process that's not
> > +              * the master then we'll set a global letting the slave
> > +              * (which should be looping) know to dump its own stack.
> > +              */
> > +             dbg_slave_dumpstack_cpu = cpu;
> > +             for (time_left = MSEC_PER_SEC; time_left; time_left--) {
> > +                     udelay(1000);
> > +                     if (dbg_slave_dumpstack_cpu == -1)
> > +                             break;
> > +             }
>
> This timeout does not interact correctly with the pager (the timer does
> not get reset when we sit in the pager loop waiting for user to tell us
> to continue).

Nice catch, thanks.  Probably the easiest thing to do is to get rid of
this timeout but put in a check to make sure that the CPU has the
"IN_SLAVE" flag set.  This was important since you otherwise could get
into this code path by doing "ps" to see what process was running on a
non-rounded-up CPU and then "btp <pid>".  v3 should handle this
without the timeout.


-Doug
