Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85189C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AB020865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shGuoSU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfKIDPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:15:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35399 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfKIDPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:15:30 -0500
Received: by mail-io1-f67.google.com with SMTP id x21so8528495iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 19:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTePlIibcPPRwDJW61R58dns9ZtGg0EphJI1+lP4650=;
        b=shGuoSU3zyD+CfvzCFtgP8hN8r3ZwSl3xJcFtOa7hdJ/9l9pcE3p0DTfM599nZ72Jf
         WVtOOMwG7XbwAAzr3U8Gr+ReHIKpawcGHBtUBs5UmoXRq6Ld2BkG0l+Acmhha08Xdyek
         RekNtAhQuFgq4bbNxNzQLvtW9U1lQo128taegImfHlQUzoWz4EooajhWJ+Qc/NwWkck3
         WgFWhy7QwZBPwJLOROOMF6qhkqvHV+U/2aP2ac4AwmnwQzYcWu9irjU86kyfghONQeUF
         S/vQBBxSLI1FPOzdeCOS2KzaIf6yL3Gf4bTXdsGs08dc57gS/OeBBtyu4420eGhKof4P
         0MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTePlIibcPPRwDJW61R58dns9ZtGg0EphJI1+lP4650=;
        b=Na0ZjE/wu0Px1vg2yw/nyW/kszGLJsBYYHUQQfWx10TE+2z3Y/JjiciGeLh94Pm3gj
         WXjcWb+o6HpetAkR1+orEi3pk3mPwhI29KWZVevtACb1XeCyjbyAPwXMWULmyw3VAj56
         AhPMzlsNLz1YBIMhhrsyk6tT2FxClEsj+qseEeUlC5NZhalnJddU9EJqYWgQYt/4Mq8Z
         i1QkuIw4CC8OxIwOWz3DxBpZf0V2TSeKFTrG9DaPRIZriaWDFDXvG3D/ggzgkvt97pWF
         f0zQdFJpJuQlozfYMIPsAE0yrLcmZ/bPPCxkJS/pvh+CY/ICrMI737uY+jlF0Nhnqx/U
         NEgQ==
X-Gm-Message-State: APjAAAVqAPufwCq5QU/Ryb3m0FDuePcDLoxhVMAv4YpuqJ2+stXSi7Wt
        QldaOZwL4gnXPkDighsFZ6Ydk3XBGoSDa+KvvbsuUg==
X-Google-Smtp-Source: APXvYqy7i2TqiYvVMmum3+6MQyp/aFZccmd6UAjQkQ70Ez4zbpnsb0hxmKv07Rg6ImAMfy4pFbTZ1ss5OT9YaavkF2Q=
X-Received: by 2002:a02:90c7:: with SMTP id c7mr14246794jag.12.1573269327387;
 Fri, 08 Nov 2019 19:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20191107193738.195914-1-edumazet@google.com> <20191108192448.GB20975@paulmck-ThinkPad-P72>
 <CANn89iKNLESN7U7BtyzkC6WLVn__Hm727A5cRm6PDuzG5+E4vA@mail.gmail.com> <20191108234224.GF20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191108234224.GF20975@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 19:15:16 -0800
Message-ID: <CANn89iJsh5X4k2SsT0iNdRJPs4k2Hun3EJak1iomcKahmEJJwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] list: add hlist_unhashed_lockless()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Nov 08, 2019 at 12:17:49PM -0800, Eric Dumazet wrote:
> > On Fri, Nov 8, 2019 at 11:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Nov 07, 2019 at 11:37:37AM -0800, Eric Dumazet wrote:
> > > > We would like to use hlist_unhashed() from timer_pending(),
> > > > which runs without protection of a lock.
> > > >
> > > > Note that other callers might also want to use this variant.
> > > >
> > > > Instead of forcing a READ_ONCE() for all hlist_unhashed()
> > > > callers, add a new helper with an explicit _lockless suffix
> > > > in the name to better document what is going on.
> > > >
> > > > Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
> > > > and hlist_add_before()/hlist_add_behind() to pair with
> > > > the READ_ONCE().
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > >
> > > I have queued this, but if you prefer it go some other way:
> > >
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > But shouldn't the uses in include/linux/rculist.h also be converted
> > > into the patch below?  If so, I will squash the following into your
> > > patch.
> > >
> > >                                                 Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> >
> > Agreed, thanks for the addition of this Paul.
>
> Very good, squashed and pushed, thank you!
>

I have another KCSAN report of a bug that will force us to use
hlist_unhashed_lockless() from sk_unhashed()

(Meaning we also need to add some WRITE_ONCE() annotations to
include/linux/list_nulls.h )

BUG: KCSAN: data-race in inet_unhash / inet_unhash

write to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 1:
 __hlist_nulls_del include/linux/list_nulls.h:88 [inline]
 hlist_nulls_del_init_rcu include/linux/rculist_nulls.h:36 [inline]
 __sk_nulls_del_node_init_rcu include/net/sock.h:676 [inline]
 inet_unhash+0x38f/0x4a0 net/ipv4/inet_hashtables.c:612
 tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
 tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
 tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
 tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
 tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
 tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
 call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
 arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1af/0x280 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 start_secondary+0x208/0x260 arch/x86/kernel/smpboot.c:264
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

read to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 0:
 sk_unhashed include/net/sock.h:607 [inline]
 inet_unhash+0x3d/0x4a0 net/ipv4/inet_hashtables.c:592
 tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
 tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
 tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
 tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
 tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
 tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
 call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
 arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1af/0x280 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 rest_init+0xec/0xf6 init/main.c:452
 arch_call_rest_init+0x17/0x37
 start_kernel+0x838/0x85e init/main.c:786
 x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
 x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
