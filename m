Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB46C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C85A2175B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6ixMUng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDFBgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:36:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40008 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDFBgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 21:36:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so6749340ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 18:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QP1SDOPZl/6k7+sXbCo2czSGDxnmJCS95XH1llYWFo=;
        b=D6ixMUngec0ouTud9Qitc7Ha9yLZyNUxE/GOCYnXU7MX2Jk5XP+hrxQ6t/+mj9iSHj
         wKjlpD3DLEDERlZo/NPPPx6YFKq4+2Mo2D9UICOwSDrViPTeHjG3iXVg84/ynI9QFe2O
         0Cz0UHYcITOsgkXUBxT4kQYw9Xlse1XdwXlqhOYUxFqawrO4wy4j20CzFgFrPV/InzKt
         UxrKBUVJk/fOXCn3/EFmAaKu4vTW1bHjpm/9rpacnm/KZ2t0p14kGPHablU63qy5x5NC
         W23AUlRi4PFa3PtNjTtGP/ClwAPphn+rDsOb4GykrSHE2IyECGzwi5wyMvtzbPGBD/Vf
         9urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QP1SDOPZl/6k7+sXbCo2czSGDxnmJCS95XH1llYWFo=;
        b=Y9jLJxxes/msbz0e6aLT6ow5hpWG4e0lIf0ZYhS9T05yk0RJLMtQuExUCidzLl1gx6
         9zHwGUbIpuO9zt8rfmTcUgYKoS+dLV83E1k8metq+y1s49TpsFdYh4ni8/9VRS/69FeZ
         mEDVePiS9I+xOudj3cwytcnhY5QF/ADkcYCfZj6iONXnz/0yCKzFk54XoPnwYIzYX2gk
         5hOFJNFfT3wtPGuYWDUX2uCiu3RtcQ63YmYK0H3Ga7ZUI095lr55DftfZQ6qvVNH+xr7
         QKLAs818NZ1hCsO6/tjDSBtM0QEvplgZ1HGSLAw8x5bYS7f3sSA6DQlOKy0Yfsp2b56r
         VoqA==
X-Gm-Message-State: APjAAAWGC1corTW1sY3oisXhVKYanMEaCdLOwr4Jv15a/vTVWtd7C49h
        9wREh63l3gn+FEWnSTTuUnd7px9lg7tF4tPmtAI=
X-Google-Smtp-Source: APXvYqzoB0HZ+ZAF1qoOM1hk2KKkUxeHxibfJIG+lHv2cxwvKamFsGXD4p/QH/TS+LiyC1CXUxDZiR1HwgxsYIT7V4A=
X-Received: by 2002:a2e:8794:: with SMTP id n20mr8731370lji.76.1554514595857;
 Fri, 05 Apr 2019 18:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <20190218173514.796920915@infradead.org>
 <d7a408c0-b86a-da56-5440-d7cb380708c6@arm.com> <20190221164146.GV32494@hirez.programming.kicks-ass.net>
 <CAERHkrv1W4vC9h1g1iifcdLeMAHar3KiHS=hP=Y2iUyM2wswhg@mail.gmail.com>
In-Reply-To: <CAERHkrv1W4vC9h1g1iifcdLeMAHar3KiHS=hP=Y2iUyM2wswhg@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 6 Apr 2019 09:36:24 +0800
Message-ID: <CAERHkrtcaErw=baWO5hv+yD07p4P9MSFSkiJoEcJU+OHd1fMZA@mail.gmail.com>
Subject: Re: [RFC][PATCH 15/16] sched: Trivial forced-newidle balancer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 4:31 PM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Fri, Feb 22, 2019 at 12:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Feb 21, 2019 at 04:19:46PM +0000, Valentin Schneider wrote:
> > > Hi,
> > >
> > > On 18/02/2019 16:56, Peter Zijlstra wrote:
> > > [...]
> > > > +static bool try_steal_cookie(int this, int that)
> > > > +{
> > > > +   struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
> > > > +   struct task_struct *p;
> > > > +   unsigned long cookie;
> > > > +   bool success = false;
> > > > +
> > > > +   local_irq_disable();
> > > > +   double_rq_lock(dst, src);
>
> Here, should we check dst and src's rq status before lock their rq?
> if src is idle, it could be in the progress of load balance already?
>
> Thanks,
> -Aubrey
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3e3162f..a1e0a6f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3861,6 +3861,13 @@ static bool try_steal_cookie(int this, int that)
>         unsigned long cookie;
>         bool success = false;
>
> +       /*
> +        * Don't steal if src is idle or has only one runnable task,
> +        * or dst has more than one runnable task
> +        */
> +       if (src->nr_running <= 1 || unlikely(dst->nr_running >= 1))
> +               return false;
> +
>         local_irq_disable();
>         double_rq_lock(dst, src);

This seems to eliminate a hard lockup on my side.

Thanks,
-Aubrey

[  122.961909] NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
[  122.961910] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  122.961940] irq event stamp: 8200
[  122.961941] hardirqs last  enabled at (8199): [<ffffffff81003829>]
trace_hardirqs_on_thunk+0x1a/0x1c
[  122.961942] hardirqs last disabled at (8200): [<ffffffff81003845>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  122.961942] softirqs last  enabled at (8192): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  122.961943] softirqs last disabled at (8185): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  122.961944] CPU: 0 PID: 2704 Comm: schbench Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  122.961945] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  122.961945] RIP: 0010:native_queued_spin_lock_slowpath+0x5c/0x1d0
[  122.961946] Code: ff ff ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00
8b 07 30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74
08 f3 90 <8b> 07 84 c0 75 f8 b8 05
[  122.961947] RSP: 0000:ffff888c09c03e78 EFLAGS: 00000002
[  122.961948] RAX: 0000000000740101 RBX: ffff888c0ade4400 RCX: 0000000000000540
[  122.961948] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0ade4400
[  122.961949] RBP: ffff888c0ade4400 R08: 0000000000000000 R09: 0000000000000001
[  122.961950] R10: ffff888c09c03e20 R11: 0000000000000000 R12: 00000000001e4400
[  122.961950] R13: 0000000000000000 R14: 0000000000000016 R15: ffff888be0340000
[  122.961951] FS:  00007f21e17ea700(0000) GS:ffff888c09c00000(0000)
knlGS:0000000000000000
[  122.961951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.961952] CR2: 00007f21e17ea728 CR3: 0000000be0b6a002 CR4: 00000000000606f0
[  122.961952] Call Trace:
[  122.961953]  <IRQ>
[  122.961953]  do_raw_spin_lock+0xb4/0xc0
[  122.961954]  _raw_spin_lock+0x4b/0x60
[  122.961954]  scheduler_tick+0x48/0x170
[  122.961955]  ? tick_sched_do_timer+0x60/0x60
[  122.961955]  update_process_times+0x40/0x50
[  122.961956]  tick_sched_handle+0x22/0x60
[  122.961956]  tick_sched_timer+0x37/0x70
[  122.961957]  __hrtimer_run_queues+0xed/0x3f0
[  122.961957]  hrtimer_interrupt+0x122/0x270
[  122.961958]  smp_apic_timer_interrupt+0x86/0x210
[  122.961958]  apic_timer_interrupt+0xf/0x20
[  122.961959]  </IRQ>
[  122.961959] RIP: 0033:0x7fff855a2839
[  122.961960] Code: 08 3b 15 6a c8 ff ff 75 df 31 c0 5d c3 b8 e4 00
00 00 5d 0f 05 c3 f3 90 eb ce 0f 1f 80 00 00 00 00 55 48 85 ff 48 89
e5 41 54 <49> 89 f4 53 74 30 48 8b
[  122.961961] RSP: 002b:00007f21e17e9e38 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  122.961962] RAX: 000000000002038b RBX: 00000000002dc6c0 RCX: 0000000000000000
[  122.961962] RDX: 00007f21e17e9e60 RSI: 0000000000000000 RDI: 00007f21e17e9e50
[  122.961963] RBP: 00007f21e17e9e40 R08: 0000000000000000 R09: 0000000000007a14
[  122.961963] R10: 00007f21e17e9e30 R11: 0000000000000246 R12: 00007f21e17e9ed0
[  122.961964] R13: 00007f2202716e6f R14: 0000000000000000 R15: 00007f21fc826b00
[  122.961964] Kernel panic - not syncing: Hard LOCKUP
[  122.961965] CPU: 0 PID: 2704 Comm: schbench Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  122.961966] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  122.961966] Call Trace:
[  122.961967]  <NMI>
[  122.961967]  dump_stack+0x7c/0xbb
[  122.961968]  panic+0x103/0x2c8
[  122.961968]  nmi_panic+0x35/0x40
[  122.961969]  watchdog_overflow_callback+0xfd/0x110
[  122.961969]  __perf_event_overflow+0x5a/0xe0
[  122.961970]  handle_pmi_common+0x1d1/0x280
[  122.961970]  ? intel_pmu_handle_irq+0xad/0x170
[  122.961971]  intel_pmu_handle_irq+0xad/0x170
[  122.961971]  perf_event_nmi_handler+0x2e/0x50
[  122.961972]  nmi_handle+0xc6/0x260
[  122.961972]  default_do_nmi+0xca/0x120
[  122.961972]  do_nmi+0x113/0x160
[  122.961973]  end_repeat_nmi+0x16/0x50
[  122.961973] RIP: 0010:native_queued_spin_lock_slowpath+0x5c/0x1d0
[  122.961974] Code: ff ff ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00
8b 07 30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74
08 f3 90 <8b> 07 84 c0 75 f8 b8 05
[  122.961975] RSP: 0000:ffff888c09c03e78 EFLAGS: 00000002
[  122.961976] RAX: 0000000000740101 RBX: ffff888c0ade4400 RCX: 0000000000000540
[  122.961976] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0ade4400
[  122.961977] RBP: ffff888c0ade4400 R08: 0000000000000000 R09: 0000000000000001
[  122.961978] R10: ffff888c09c03e20 R11: 0000000000000000 R12: 00000000001e4400
[  122.961978] R13: 0000000000000000 R14: 0000000000000016 R15: ffff888be0340000
[  122.961979]  ? native_queued_spin_lock_slowpath+0x5c/0x1d0
[  122.961980]  ? native_queued_spin_lock_slowpath+0x5c/0x1d0
[  122.961980]  </NMI>
[  122.961981]  <IRQ>
[  122.961981]  do_raw_spin_lock+0xb4/0xc0
[  122.961982]  _raw_spin_lock+0x4b/0x60
[  122.961982]  scheduler_tick+0x48/0x170
[  122.961983]  ? tick_sched_do_timer+0x60/0x60
[  122.961983]  update_process_times+0x40/0x50
[  122.961984]  tick_sched_handle+0x22/0x60
[  122.961984]  tick_sched_timer+0x37/0x70
[  122.961985]  __hrtimer_run_queues+0xed/0x3f0
[  122.961985]  hrtimer_interrupt+0x122/0x270
[  122.961986]  smp_apic_timer_interrupt+0x86/0x210
[  122.961986]  apic_timer_interrupt+0xf/0x20
[  122.961987]  </IRQ>
[  122.961987] RIP: 0033:0x7fff855a2839
[  122.961988] Code: 08 3b 15 6a c8 ff ff 75 df 31 c0 5d c3 b8 e4 00
00 00 5d 0f 05 c3 f3 90 eb ce 0f 1f 80 00 00 00 00 55 48 85 ff 48 89
e5 41 54 <49> 89 f4 53 74 30 48 8b
[  122.961989] RSP: 002b:00007f21e17e9e38 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  122.961990] RAX: 000000000002038b RBX: 00000000002dc6c0 RCX: 0000000000000000
[  122.961990] RDX: 00007f21e17e9e60 RSI: 0000000000000000 RDI: 00007f21e17e9e50
[  122.961991] RBP: 00007f21e17e9e40 R08: 0000000000000000 R09: 0000000000007a14
[  122.961991] R10: 00007f21e17e9e30 R11: 0000000000000246 R12: 00007f21e17e9ed0
[  122.961992] R13: 00007f2202716e6f R14: 0000000000000000 R15: 00007f21fc826b00
[  124.022169] Shutting down cpus with NMI
[  124.022170] Kernel Offset: disabled
[  124.022170] NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
[  124.022171] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022200] irq event stamp: 148640
[  124.022200] hardirqs last  enabled at (148639):
[<ffffffff810c7544>] sched_core_balance+0x164/0x5d0
[  124.022209] hardirqs last disabled at (148640):
[<ffffffff810c75b5>] sched_core_balance+0x1d5/0x5d0
[  124.022218] softirqs last  enabled at (148598):
[<ffffffff81e003a3>] __do_softirq+0x3a3/0x3f2
[  124.022226] softirqs last disabled at (148563):
[<ffffffff81095ea1>] irq_exit+0xc1/0xd0
[  124.022227] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G          I
  5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022228] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022229] RIP: 0010:native_queued_spin_lock_slowpath+0x17e/0x1d0
[  124.022230] Code: 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09
f3 90 8b 42 08 85 c0 74 f7 48 8b 32 48 85 f6 74 07 0f 18 0e eb 02 f3
90 8b 07 <66> 85 c0 75 f7 41 89 c7
[  124.022230] RSP: 0000:ffffc9000634bcf8 EFLAGS: 00000002
[  124.022231] RAX: 00000000001c0101 RBX: ffff888c0abe4400 RCX: 0000000000080000
[  124.022232] RDX: ffff888c09fe5180 RSI: 0000000000000000 RDI: ffff888c0abe4400
[  124.022232] RBP: ffff888c0abe4400 R08: 0000000000080000 R09: 0000000000000001
[  124.022233] R10: ffffc9000634bca0 R11: 0000000000000000 R12: 0000000000000001
[  124.022233] R13: 0000000000000000 R14: ffff888c09fe4400 R15: 00000000001e4400
[  124.022234] FS:  0000000000000000(0000) GS:ffff888c09e00000(0000)
knlGS:0000000000000000
[  124.022235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022235] CR2: 00007f21f1ffae00 CR3: 0000000be0b6a002 CR4: 00000000000606e0
[  124.022236] Call Trace:
[  124.022237]  do_raw_spin_lock+0xb4/0xc0
[  124.022237]  _raw_spin_lock_nested+0x49/0x60
[  124.022238]  sched_core_balance+0x106/0x5d0
[  124.022238]  __balance_callback+0x49/0xa0
[  124.022239]  __schedule+0x12eb/0x1660
[  124.022239]  ? _raw_spin_unlock_irqrestore+0x4e/0x60
[  124.022240]  ? hrtimer_start_range_ns+0x1b7/0x340
[  124.022240]  schedule_idle+0x28/0x40
[  124.022241]  do_idle+0x169/0x2a0
[  124.022241]  cpu_startup_entry+0x19/0x20
[  124.022242]  start_secondary+0x17f/0x1d0
[  124.022242]  secondary_startup_64+0xa4/0xb0
[  124.022243] NMI watchdog: Watchdog detected hard LOCKUP on cpu 2
[  124.022243] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022272] irq event stamp: 154392
[  124.022273] hardirqs last  enabled at (154391):
[<ffffffff810c7544>] sched_core_balance+0x164/0x5d0
[  124.022273] hardirqs last disabled at (154392):
[<ffffffff810c75b5>] sched_core_balance+0x1d5/0x5d0
[  124.022274] softirqs last  enabled at (154374):
[<ffffffff81e003a3>] __do_softirq+0x3a3/0x3f2
[  124.022275] softirqs last disabled at (154309):
[<ffffffff81095ea1>] irq_exit+0xc1/0xd0
[  124.022275] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G          I
  5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022276] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022276] RIP: 0010:native_queued_spin_lock_slowpath+0x166/0x1d0
[  124.022277] Code: c1 e8 12 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48
81 c6 80 51 1e 00 48 03 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75
09 f3 90 <8b> 42 08 85 c0 74 f7 40
[  124.022278] RSP: 0000:ffffc90006353cf8 EFLAGS: 00000046
[  124.022279] RAX: 0000000000000000 RBX: ffff888c0a3e4400 RCX: 00000000000c0000
[  124.022279] RDX: ffff888c0a1e5180 RSI: ffff888c0a3e5180 RDI: ffff888c0a3e4400
[  124.022280] RBP: ffff888c0a3e4400 R08: 00000000000c0000 R09: 0000000000000001
[  124.022281] R10: ffffc90006353ca0 R11: 0000000000000000 R12: 0000000000000002
[  124.022281] R13: 0000000000000000 R14: ffff888c0a1e4400 R15: 00000000001e4400
[  124.022282] FS:  0000000000000000(0000) GS:ffff888c0a000000(0000)
knlGS:0000000000000000
[  124.022282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022283] CR2: 00007f21e1feb728 CR3: 0000000be0b6a005 CR4: 00000000000606e0
[  124.022283] Call Trace:
[  124.022284]  do_raw_spin_lock+0xb4/0xc0
[  124.022284]  _raw_spin_lock_nested+0x49/0x60
[  124.022285]  sched_core_balance+0x106/0x5d0
[  124.022285]  __balance_callback+0x49/0xa0
[  124.022286]  __schedule+0x12eb/0x1660
[  124.022286]  ? enqueue_entity+0x112/0x6f0
[  124.022287]  ? sched_clock+0x5/0x10
[  124.022287]  ? sched_clock_cpu+0xc/0xa0
[  124.022288]  ? lockdep_hardirqs_on+0x11d/0x190
[  124.022288]  schedule_idle+0x28/0x40
[  124.022289]  do_idle+0x169/0x2a0
[  124.022289]  cpu_startup_entry+0x19/0x20
[  124.022290]  start_secondary+0x17f/0x1d0
[  124.022290]  secondary_startup_64+0xa4/0xb0
[  124.022291] NMI watchdog: Watchdog detected hard LOCKUP on cpu 4
[  124.022292] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022321] irq event stamp: 13957
[  124.022321] hardirqs last  enabled at (13956): [<ffffffff81a10892>]
_raw_spin_unlock_irqrestore+0x32/0x60
[  124.022322] hardirqs last disabled at (13957): [<ffffffff81a10f32>]
_raw_spin_lock_irqsave+0x22/0x80
[  124.022323] softirqs last  enabled at (13946): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022323] softirqs last disabled at (13949): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022324] CPU: 4 PID: 2698 Comm: schbench Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022325] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022325] RIP: 0010:native_queued_spin_lock_slowpath+0x17e/0x1d0
[  124.022326] Code: 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09
f3 90 8b 42 08 85 c0 74 f7 48 8b 32 48 85 f6 74 07 0f 18 0e eb 02 f3
90 8b 07 <66> 85 c0 75 f7 41 89 c7
[  124.022327] RSP: 0000:ffff888c0a403da8 EFLAGS: 00000002
[  124.022328] RAX: 0000000000540101 RBX: ffff888c0a1e4400 RCX: 0000000000140000
[  124.022328] RDX: ffff888c0a5e5180 RSI: 0000000000000000 RDI: ffff888c0a1e4400
[  124.022329] RBP: ffff888c0a1e4400 R08: 0000000000140000 R09: 0000000000000001
[  124.022329] R10: ffff888c0a403d50 R11: 0000000000000000 R12: 0000000000000202
[  124.022330] R13: 000000000000003b R14: 0000000000000001 R15: ffff888c0b1e4400
[  124.022331] FS:  00007f21e47f0700(0000) GS:ffff888c0a400000(0000)
knlGS:0000000000000000
[  124.022331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022332] CR2: 00007f21f17fa728 CR3: 0000000be0b6a004 CR4: 00000000000606e0
[  124.022332] Call Trace:
[  124.022332]  <IRQ>
[  124.022333]  do_raw_spin_lock+0xb4/0xc0
[  124.022333]  _raw_spin_lock_irqsave+0x63/0x80
[  124.022334]  load_balance+0x358/0xde0
[  124.022334]  rebalance_domains+0x239/0x320
[  124.022335]  ? lockdep_hardirqs_on+0xa3/0x190
[  124.022335]  __do_softirq+0xd6/0x3f2
[  124.022336]  irq_exit+0xc1/0xd0
[  124.022336]  smp_apic_timer_interrupt+0xac/0x210
[  124.022337]  apic_timer_interrupt+0xf/0x20
[  124.022337]  </IRQ>
[  124.022338] RIP: 0033:0x7fff855a26dd
[  124.022339] Code: e2 20 48 09 c2 48 85 d2 49 8b 40 08 48 8b 0d c2
c9 ff ff 78 9b 48 39 d1 73 10 48 29 ca 8b 0d c2 c9 ff ff 48 0f af d1
48 01 d0 <8b> 0d b9 c9 ff ff 4d 8f
[  124.022339] RSP: 002b:00007f21e47efe00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  124.022340] RAX: 001c0b86d5d09d9a RBX: 00007f21e47efe50 RCX: 00000000005f0b1d
[  124.022341] RDX: 000063752327ca12 RSI: 00007f21e47efe50 RDI: 0000000000000000
[  124.022341] RBP: 00007f21e47efe10 R08: 00007fff8559f0a0 R09: 0000000000007f96
[  124.022342] R10: 00007f21e47efe30 R11: 0000000000000246 R12: 0000000000000000
[  124.022342] R13: 00007f2202716e6f R14: 0000000000000000 R15: 00007f21fc518628
[  124.022343] NMI watchdog: Watchdog detected hard LOCKUP on cpu 5
[  124.022344] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022372] irq event stamp: 132866
[  124.022373] hardirqs last  enabled at (132865):
[<ffffffff810c7544>] sched_core_balance+0x164/0x5d0
[  124.022374] hardirqs last disabled at (132866):
[<ffffffff810c75b5>] sched_core_balance+0x1d5/0x5d0
[  124.022375] softirqs last  enabled at (132834):
[<ffffffff81e003a3>] __do_softirq+0x3a3/0x3f2
[  124.022375] softirqs last disabled at (132825):
[<ffffffff81095ea1>] irq_exit+0xc1/0xd0
[  124.022376] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G          I
  5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022377] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022377] RIP: 0010:native_queued_spin_lock_slowpath+0x169/0x1d0
[  124.022378] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 80
51 1e 00 48 03 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09 f3 90
8b 42 08 <85> c0 74 f7 48 8b 32 46
[  124.022379] RSP: 0000:ffffc9000636bcf8 EFLAGS: 00000046
[  124.022380] RAX: 0000000000000000 RBX: ffff888c0abe4400 RCX: 0000000000180000
[  124.022380] RDX: ffff888c0a7e5180 RSI: ffff888c0abe5180 RDI: ffff888c0abe4400
[  124.022381] RBP: ffff888c0abe4400 R08: 0000000000180000 R09: 0000000000000001
[  124.022381] R10: ffffc9000636bca0 R11: 0000000000000000 R12: 0000000000000005
[  124.022382] R13: 0000000000000000 R14: ffff888c0a7e4400 R15: 00000000001e4400
[  124.022382] FS:  0000000000000000(0000) GS:ffff888c0a600000(0000)
knlGS:0000000000000000
[  124.022383] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022384] CR2: 00007f7956376889 CR3: 0000000be0b6a001 CR4: 00000000000606e0
[  124.022384] Call Trace:
[  124.022384]  do_raw_spin_lock+0xb4/0xc0
[  124.022385]  _raw_spin_lock_nested+0x49/0x60
[  124.022385]  sched_core_balance+0x106/0x5d0
[  124.022386]  __balance_callback+0x49/0xa0
[  124.022386]  __schedule+0x12eb/0x1660
[  124.022387]  ? enqueue_entity+0x112/0x6f0
[  124.022387]  ? sched_clock+0x5/0x10
[  124.022388]  ? sched_clock_cpu+0xc/0xa0
[  124.022388]  ? lockdep_hardirqs_on+0x11d/0x190
[  124.022389]  schedule_idle+0x28/0x40
[  124.022389]  do_idle+0x169/0x2a0
[  124.022390]  cpu_startup_entry+0x19/0x20
[  124.022390]  start_secondary+0x17f/0x1d0
[  124.022391]  secondary_startup_64+0xa4/0xb0
[  124.022392] NMI watchdog: Watchdog detected hard LOCKUP on cpu 7
[  124.022392] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022421] irq event stamp: 8164
[  124.022422] hardirqs last  enabled at (8163): [<ffffffff81003829>]
trace_hardirqs_on_thunk+0x1a/0x1c
[  124.022422] hardirqs last disabled at (8164): [<ffffffff81003845>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  124.022423] softirqs last  enabled at (8138): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022424] softirqs last disabled at (8129): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022424] CPU: 7 PID: 2733 Comm: schbench Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022425] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022426] RIP: 0010:native_queued_spin_lock_slowpath+0x169/0x1d0
[  124.022427] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 80
51 1e 00 48 03 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09 f3 90
8b 42 08 <85> c0 74 f7 48 8b 32 46
[  124.022427] RSP: 0000:ffff888c0aa03e78 EFLAGS: 00000046
[  124.022428] RAX: 0000000000000000 RBX: ffff888c0abe4400 RCX: 0000000000200000
[  124.022429] RDX: ffff888c0abe5180 RSI: ffff888c09fe5180 RDI: ffff888c0abe4400
[  124.022429] RBP: ffff888c0abe4400 R08: 0000000000200000 R09: 0000000000000001
[  124.022430] R10: ffff888c0aa03e20 R11: 0000000000000000 R12: 00000000001e4400
[  124.022430] R13: 0000000000000007 R14: 0000000000000002 R15: ffff888be038d480
[  124.022431] FS:  00007f21d47d0700(0000) GS:ffff888c0aa00000(0000)
knlGS:0000000000000000
[  124.022432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022432] CR2: 00007f21e07e8728 CR3: 0000000be0b6a001 CR4: 00000000000606e0
[  124.022433] Call Trace:
[  124.022433]  <IRQ>
[  124.022433]  do_raw_spin_lock+0xb4/0xc0
[  124.022434]  _raw_spin_lock+0x4b/0x60
[  124.022434]  scheduler_tick+0x48/0x170
[  124.022435]  ? tick_sched_do_timer+0x60/0x60
[  124.022435]  update_process_times+0x40/0x50
[  124.022436]  tick_sched_handle+0x22/0x60
[  124.022436]  tick_sched_timer+0x37/0x70
[  124.022437]  __hrtimer_run_queues+0xed/0x3f0
[  124.022437]  hrtimer_interrupt+0x122/0x270
[  124.022438]  smp_apic_timer_interrupt+0x86/0x210
[  124.022438]  apic_timer_interrupt+0xf/0x20
[  124.022439]  </IRQ>
[  124.022439] RIP: 0033:0x7fff855a262b
[  124.022440] Code: 41 0e 10 86 02 48 0d 06 60 c6 0c 07 08 00 00 4c
8d 54 24 08 48 63 ff 48 83 e4 f0 4c 8d 47 02 48 8d 05 59 ca ff ff 41
ff 72 f8 <55> 49 c1 e0 04 48 89 e1
[  124.022441] RSP: 002b:00007f21d47cfe18 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  124.022442] RAX: 00007fff8559f080 RBX: 00007f21d47cfe50 RCX: 0000000000000000
[  124.022442] RDX: 00007f21d47cfe60 RSI: 00007f21d47cfe50 RDI: 0000000000000000
[  124.022443] RBP: 00007f21d47cfe40 R08: 0000000000000002 R09: 00000000000079f0
[  124.022443] R10: 00007f21d47cfe30 R11: 0000000000000246 R12: 0000000000000000
[  124.022444] R13: 00007f2201714e6f R14: 0000000000000000 R15: 00007f21f8b34fd8
[  124.022446] NMI watchdog: Watchdog detected hard LOCKUP on cpu 16
[  124.022447] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022475] irq event stamp: 134706
[  124.022476] hardirqs last  enabled at (134705):
[<ffffffff810c7544>] sched_core_balance+0x164/0x5d0
[  124.022476] hardirqs last disabled at (134706):
[<ffffffff810c75b5>] sched_core_balance+0x1d5/0x5d0
[  124.022477] softirqs last  enabled at (134694):
[<ffffffff81e003a3>] __do_softirq+0x3a3/0x3f2
[  124.022478] softirqs last disabled at (134683):
[<ffffffff81095ea1>] irq_exit+0xc1/0xd0
[  124.022479] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022479] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022480] RIP: 0010:native_queued_spin_lock_slowpath+0x169/0x1d0
[  124.022481] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 80
51 1e 00 48 03 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09 f3 90
8b 42 08 <85> c0 74 f7 48 8b 32 46
[  124.022481] RSP: 0000:ffffc900063c3cf8 EFLAGS: 00000046
[  124.022482] RAX: 0000000000000000 RBX: ffff888c09fe4400 RCX: 0000000000440000
[  124.022483] RDX: ffff888c0ade5180 RSI: ffff88980b3e5180 RDI: ffff888c09fe4400
[  124.022483] RBP: ffff888c09fe4400 R08: 0000000000440000 R09: 0000000000000001
[  124.022484] R10: ffffc900063c3ca0 R11: 0000000000000000 R12: 0000000000000010
[  124.022485] R13: 0000000000000000 R14: ffff888c0ade4400 R15: 00000000001e4400
[  124.022485] FS:  0000000000000000(0000) GS:ffff888c0ac00000(0000)
knlGS:0000000000000000
[  124.022486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022486] CR2: 00007f21e77f5e30 CR3: 0000000be0b6a003 CR4: 00000000000606e0
[  124.022487] Call Trace:
[  124.022487]  do_raw_spin_lock+0xb4/0xc0
[  124.022488]  _raw_spin_lock_nested+0x49/0x60
[  124.022488]  sched_core_balance+0x106/0x5d0
[  124.022489]  __balance_callback+0x49/0xa0
[  124.022489]  __schedule+0x12eb/0x1660
[  124.022490]  ? _raw_spin_unlock_irqrestore+0x4e/0x60
[  124.022490]  ? hrtimer_start_range_ns+0x1b7/0x340
[  124.022491]  schedule_idle+0x28/0x40
[  124.022491]  do_idle+0x169/0x2a0
[  124.022492]  cpu_startup_entry+0x19/0x20
[  124.022492]  start_secondary+0x17f/0x1d0
[  124.022493]  secondary_startup_64+0xa4/0xb0
[  124.022493] NMI watchdog: Watchdog detected hard LOCKUP on cpu 17
[  124.022494] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022522] irq event stamp: 10038
[  124.022523] hardirqs last  enabled at (10037): [<ffffffff81003829>]
trace_hardirqs_on_thunk+0x1a/0x1c
[  124.022524] hardirqs last disabled at (10038): [<ffffffff81003845>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  124.022524] softirqs last  enabled at (10012): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022525] softirqs last disabled at (10001): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022525] CPU: 17 PID: 2681 Comm: schbench Tainted: G          I
     5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022526] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022527] RIP: 0010:native_queued_spin_lock_slowpath+0x169/0x1d0
[  124.022528] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 80
51 1e 00 48 03 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09 f3 90
8b 42 08 <85> c0 74 f7 48 8b 32 46
[  124.022528] RSP: 0000:ffff888c0ae03e78 EFLAGS: 00000046
[  124.022529] RAX: 0000000000000000 RBX: ffff888c09fe4400 RCX: 0000000000480000
[  124.022530] RDX: ffff888c0afe5180 RSI: ffff88980a1e5180 RDI: ffff888c09fe4400
[  124.022531] RBP: ffff888c09fe4400 R08: 0000000000480000 R09: 0000000000000001
[  124.022531] R10: ffff888c0ae03e20 R11: 0000000000000000 R12: 00000000001e4400
[  124.022532] R13: 0000000000000011 R14: 0000000000000002 R15: ffff888be006d480
[  124.022533] FS:  00007f21f1ffb700(0000) GS:ffff888c0ae00000(0000)
knlGS:0000000000000000
[  124.022533] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022534] CR2: 00007f21e4ff1728 CR3: 0000000be0b6a004 CR4: 00000000000606e0
[  124.022534] Call Trace:
[  124.022535]  <IRQ>
[  124.022535]  do_raw_spin_lock+0xb4/0xc0
[  124.022536]  _raw_spin_lock+0x4b/0x60
[  124.022536]  scheduler_tick+0x48/0x170
[  124.022537]  ? tick_sched_do_timer+0x60/0x60
[  124.022537]  update_process_times+0x40/0x50
[  124.022538]  tick_sched_handle+0x22/0x60
[  124.022538]  tick_sched_timer+0x37/0x70
[  124.022538]  __hrtimer_run_queues+0xed/0x3f0
[  124.022539]  hrtimer_interrupt+0x122/0x270
[  124.022540]  smp_apic_timer_interrupt+0x86/0x210
[  124.022540]  apic_timer_interrupt+0xf/0x20
[  124.022540]  </IRQ>
[  124.022541] RIP: 0033:0x7fff855a26af
[  124.022542] Code: ff 4c 8b 1d 83 e9 ff ff 0f 01 f9 66 90 8b 0d 68
e9 ff ff 41 39 ca 75 d6 48 c1 e2 20 48 09 d0 48 f7 e3 4c 01 da eb 0c
0f 01 f9 <66> 90 48 c1 e2 20 48 0f
[  124.022542] RSP: 002b:00007f21f1ffae00 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  124.022543] RAX: 00000000e4479e7b RBX: 00007f21f1ffae50 RCX: 0000000000000011
[  124.022544] RDX: 0000000000000068 RSI: 00007f21f1ffae50 RDI: 0000000000000000
[  124.022545] RBP: 00007f21f1ffae10 R08: 00007fff8559f0a0 R09: 00000000000079f0
[  124.022545] R10: 00007f21f1ffae30 R11: 0000000000000246 R12: 0000000000000000
[  124.022546] R13: 00007f2201f15e6f R14: 0000000000000000 R15: 00007f21f4105508
[  124.022546] NMI watchdog: Watchdog detected hard LOCKUP on cpu 18
[  124.022547] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022575] irq event stamp: 8788
[  124.022576] hardirqs last  enabled at (8787): [<ffffffff81003829>]
trace_hardirqs_on_thunk+0x1a/0x1c
[  124.022577] hardirqs last disabled at (8788): [<ffffffff81003845>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  124.022577] softirqs last  enabled at (8782): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022578] softirqs last disabled at (8775): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022579] CPU: 18 PID: 2741 Comm: schbench Tainted: G          I
     5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022579] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022580] RIP: 0010:native_queued_spin_lock_slowpath+0x5c/0x1d0
[  124.022581] Code: ff ff ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00
8b 07 30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74
08 f3 90 <8b> 07 84 c0 75 f8 b8 05
[  124.022581] RSP: 0000:ffff888c0b003e78 EFLAGS: 00000002
[  124.022582] RAX: 0000000000540101 RBX: ffff888c0a1e4400 RCX: 0000000000000540
[  124.022583] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0a1e4400
[  124.022584] RBP: ffff888c0a1e4400 R08: 0000000000000000 R09: 0000000000000001
[  124.022584] R10: ffff888c0b003e20 R11: 0000000000000000 R12: 00000000001e4400
[  124.022585] R13: 0000000000000012 R14: 0000000000000002 R15: ffff888be03a2a40
[  124.022585] FS:  00007f21d07c8700(0000) GS:ffff888c0b000000(0000)
knlGS:0000000000000000
[  124.022586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022586] CR2: 00007f21df7e6728 CR3: 0000000be0b6a003 CR4: 00000000000606e0
[  124.022587] Call Trace:
[  124.022587]  <IRQ>
[  124.022588]  do_raw_spin_lock+0xb4/0xc0
[  124.022588]  _raw_spin_lock+0x4b/0x60
[  124.022589]  scheduler_tick+0x48/0x170
[  124.022589]  ? tick_sched_do_timer+0x60/0x60
[  124.022590]  update_process_times+0x40/0x50
[  124.022590]  tick_sched_handle+0x22/0x60
[  124.022591]  tick_sched_timer+0x37/0x70
[  124.022591]  __hrtimer_run_queues+0xed/0x3f0
[  124.022592]  hrtimer_interrupt+0x122/0x270
[  124.022592]  smp_apic_timer_interrupt+0x86/0x210
[  124.022593]  apic_timer_interrupt+0xf/0x20
[  124.022593]  </IRQ>
[  124.022593] RIP: 0033:0x402050
[  124.022594] Code: 48 83 ec 40 48 8d 7c 24 10 64 48 8b 04 25 28 00
00 00 48 89 44 24 38 31 c0 e8 2c eb ff ff eb 0c 66 2e 0f 1f 84 00 00
00 00 00 <f3> 90 31 f6 48 89 e7 e0
[  124.022595] RSP: 002b:00007f21d07c7e50 EFLAGS: 00000283 ORIG_RAX:
ffffffffffffff13
[  124.022596] RAX: 0000000000051d87 RBX: 00000000002dc6c0 RCX: 0000000000000000
[  124.022596] RDX: 00007f21d07c7e60 RSI: 00007f21d07c7e50 RDI: 00007f21d07c7e70
[  124.022597] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000007a06
[  124.022598] R10: 00007f21d07c7e30 R11: 0000000000000246 R12: 00007f21d07c7ed0
[  124.022598] R13: 00007f2201714e6f R14: 0000000000000000 R15: 00007f21f8f480f8
[  124.022599] NMI watchdog: Watchdog detected hard LOCKUP on cpu 19
[  124.022599] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022628] irq event stamp: 132622
[  124.022628] hardirqs last  enabled at (132621):
[<ffffffff810c7544>] sched_core_balance+0x164/0x5d0
[  124.022629] hardirqs last disabled at (132622):
[<ffffffff810c75b5>] sched_core_balance+0x1d5/0x5d0
[  124.022630] softirqs last  enabled at (132576):
[<ffffffff81095dde>] irq_enter+0x5e/0x60
[  124.022630] softirqs last disabled at (132575):
[<ffffffff81095dc3>] irq_enter+0x43/0x60
[  124.022631] CPU: 19 PID: 0 Comm: swapper/19 Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022632] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022632] RIP: 0010:native_queued_spin_lock_slowpath+0x5e/0x1d0
[  124.022633] Code: ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00 8b 07
30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74 08 f3
90 8b 07 <84> c0 75 f8 b8 01 00 06
[  124.022634] RSP: 0000:ffffc900063dbcf8 EFLAGS: 00000002
[  124.022635] RAX: 00000000000c0101 RBX: ffff888c0a3e4400 RCX: 000000000000c980
[  124.022635] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0a3e4400
[  124.022636] RBP: ffff888c0a3e4400 R08: 0000000000000000 R09: 0000000000000001
[  124.022636] R10: ffffc900063dbca0 R11: 0000000000000000 R12: 0000000000000013
[  124.022637] R13: 0000000000000000 R14: ffff888c0b3e4400 R15: 00000000001e4400
[  124.022638] FS:  0000000000000000(0000) GS:ffff888c0b200000(0000)
knlGS:0000000000000000
[  124.022638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022639] CR2: 00007f21e7ff7728 CR3: 0000000be0b6a003 CR4: 00000000000606e0
[  124.022639] Call Trace:
[  124.022640]  do_raw_spin_lock+0xb4/0xc0
[  124.022640]  _raw_spin_lock_nested+0x49/0x60
[  124.022641]  sched_core_balance+0x106/0x5d0
[  124.022641]  __balance_callback+0x49/0xa0
[  124.022642]  __schedule+0x12eb/0x1660
[  124.022642]  ? enqueue_entity+0x112/0x6f0
[  124.022643]  ? sched_clock+0x5/0x10
[  124.022643]  ? sched_clock_cpu+0xc/0xa0
[  124.022643]  ? lockdep_hardirqs_on+0x11d/0x190
[  124.022644]  schedule_idle+0x28/0x40
[  124.022644]  do_idle+0x169/0x2a0
[  124.022645]  cpu_startup_entry+0x19/0x20
[  124.022645]  start_secondary+0x17f/0x1d0
[  124.022646]  secondary_startup_64+0xa4/0xb0
[  124.022647] NMI watchdog: Watchdog detected hard LOCKUP on cpu 20
[  124.022647] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022676] irq event stamp: 12904
[  124.022676] hardirqs last  enabled at (12903): [<ffffffff81004552>]
do_syscall_64+0x12/0x1b0
[  124.022677] hardirqs last disabled at (12904): [<ffffffff81a07e92>]
__schedule+0xe2/0x1660
[  124.022677] softirqs last  enabled at (12890): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022678] softirqs last disabled at (12883): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022679] CPU: 20 PID: 2688 Comm: schbench Tainted: G          I
     5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022679] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022680] RIP: 0010:native_queued_spin_lock_slowpath+0x169/0x1d0
[  124.022681] Code: 48 c1 ee 0b 83 e8 01 83 e6 60 48 98 48 81 c6 80
51 1e 00 48 03 34 c5 40 48 39 82 48 89 16 8b 42 08 85 c0 75 09 f3 90
8b 42 08 <85> c0 74 f7 48 8b 32 46
[  124.022681] RSP: 0018:ffffc9000a1c39b8 EFLAGS: 00000046
[  124.022682] RAX: 0000000000000000 RBX: ffff888c0a1e4400 RCX: 0000000000540000
[  124.022683] RDX: ffff888c0b5e5180 RSI: ffff888c0a5e5180 RDI: ffff888c0a1e4400
[  124.022683] RBP: ffff888c0a1e4400 R08: 0000000000540000 R09: 0000000000000001
[  124.022684] R10: ffffc9000a1c3960 R11: 0000000000000000 R12: 0000000000000002
[  124.022685] R13: 000000000000003b R14: 0000000000000001 R15: ffff888c0b1e4400
[  124.022685] FS:  00007f21ea7fc700(0000) GS:ffff888c0b400000(0000)
knlGS:0000000000000000
[  124.022686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022686] CR2: 00007f795684d2a0 CR3: 0000000be0b6a003 CR4: 00000000000606e0
[  124.022687] Call Trace:
[  124.022687]  do_raw_spin_lock+0xb4/0xc0
[  124.022688]  _raw_spin_lock_irqsave+0x63/0x80
[  124.022688]  load_balance+0x358/0xde0
[  124.022689]  ? update_dl_rq_load_avg+0x121/0x280
[  124.022689]  newidle_balance+0x1d0/0x580
[  124.022690]  __schedule+0x120f/0x1660
[  124.022690]  ? lock_acquire+0xab/0x180
[  124.022691]  ? attach_entity_load_avg+0x140/0x170
[  124.022691]  ? sched_clock+0x5/0x10
[  124.022692]  ? sched_clock_cpu+0xc/0xa0
[  124.022692]  schedule+0x32/0x70
[  124.022692]  futex_wait_queue_me+0xbf/0x130
[  124.022693]  futex_wait+0xf6/0x250
[  124.022693]  ? __switch_to_asm+0x34/0x70
[  124.022694]  ? __switch_to_asm+0x40/0x70
[  124.022694]  ? __switch_to_asm+0x34/0x70
[  124.022695]  ? __switch_to_asm+0x40/0x70
[  124.022695]  ? __switch_to_asm+0x34/0x70
[  124.022696]  ? __switch_to_asm+0x40/0x70
[  124.022696]  do_futex+0x311/0xb80
[  124.022697]  ? __schedule+0xde3/0x1660
[  124.022697]  __x64_sys_futex+0x88/0x180
[  124.022698]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  124.022698]  do_syscall_64+0x60/0x1b0
[  124.022699]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  124.022699] RIP: 0033:0x7f2202c2d4d9
[  124.022700] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 08
[  124.022701] RSP: 002b:00007f21ea7fbe68 EFLAGS: 00000246 ORIG_RAX:
00000000000000ca
[  124.022702] RAX: ffffffffffffffda RBX: 00007f21fc20a180 RCX: 00007f2202c2d4d9
[  124.022702] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f21fc20a180
[  124.022703] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[  124.022704] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f21ea7fbed0
[  124.022704] R13: 00007f2202716e6f R14: 0000000000000000 R15: 00007f21fc20a150
[  124.022705] NMI watchdog: Watchdog detected hard LOCKUP on cpu 21
[  124.022705] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022734] irq event stamp: 7710
[  124.022734] hardirqs last  enabled at (7709): [<ffffffff81003829>]
trace_hardirqs_on_thunk+0x1a/0x1c
[  124.022735] hardirqs last disabled at (7710): [<ffffffff81003845>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  124.022736] softirqs last  enabled at (7704): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022736] softirqs last disabled at (7697): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022737] CPU: 21 PID: 2719 Comm: schbench Tainted: G          I
     5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022737] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022738] RIP: 0010:native_queued_spin_lock_slowpath+0x5c/0x1d0
[  124.022739] Code: ff ff ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00
8b 07 30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74
08 f3 90 <8b> 07 84 c0 75 f8 b8 05
[  124.022739] RSP: 0000:ffff888c0b603e78 EFLAGS: 00000002
[  124.022740] RAX: 00000000006c0101 RBX: ffff888c0a7e4400 RCX: 0000000000000540
[  124.022741] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0a7e4400
[  124.022742] RBP: ffff888c0a7e4400 R08: 0000000000000000 R09: 0000000000000001
[  124.022742] R10: ffff888c0b603e20 R11: 0000000000000000 R12: 00000000001e4400
[  124.022743] R13: 0000000000000015 R14: 0000000000000002 R15: ffff888be0362a40
[  124.022743] FS:  00007f21dafdd700(0000) GS:ffff888c0b600000(0000)
knlGS:0000000000000000
[  124.022744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022744] CR2: 00007f21dafdd728 CR3: 0000000be0b6a002 CR4: 00000000000606e0
[  124.022745] Call Trace:
[  124.022745]  <IRQ>
[  124.022746]  do_raw_spin_lock+0xb4/0xc0
[  124.022746]  _raw_spin_lock+0x4b/0x60
[  124.022747]  scheduler_tick+0x48/0x170
[  124.022747]  ? tick_sched_do_timer+0x60/0x60
[  124.022748]  update_process_times+0x40/0x50
[  124.022748]  tick_sched_handle+0x22/0x60
[  124.022749]  tick_sched_timer+0x37/0x70
[  124.022749]  __hrtimer_run_queues+0xed/0x3f0
[  124.022750]  hrtimer_interrupt+0x122/0x270
[  124.022750]  smp_apic_timer_interrupt+0x86/0x210
[  124.022751]  apic_timer_interrupt+0xf/0x20
[  124.022751]  </IRQ>
[  124.022752] RIP: 0033:0x400b70
[  124.022752] Code: 68 03 00 00 00 e9 b0 ff ff ff ff 25 e2 34 20 00
68 04 00 00 00 e9 a0 ff ff ff ff 25 da 34 20 00 68 05 00 00 00 e9 90
ff ff ff <ff> 25 d2 34 20 00 68 00
[  124.022753] RSP: 002b:00007f21dafdce48 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  124.022754] RAX: 000000000001bd7b RBX: 00000000002dc6c0 RCX: 0000000000000000
[  124.022755] RDX: 00007f21dafdce60 RSI: 0000000000000000 RDI: 00007f21dafdce50
[  124.022755] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000007a06
[  124.022756] R10: 00007f21dafdce30 R11: 0000000000000246 R12: 00007f21dafdced0
[  124.022756] R13: 00007f2202716e6f R14: 0000000000000000 R15: 00007f21fcf480f8
[  124.022757] NMI watchdog: Watchdog detected hard LOCKUP on cpu 22
[  124.022758] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022786] irq event stamp: 14310
[  124.022787] hardirqs last  enabled at (14309): [<ffffffff81003829>]
trace_hardirqs_on_thunk+0x1a/0x1c
[  124.022787] hardirqs last disabled at (14310): [<ffffffff81003845>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  124.022788] softirqs last  enabled at (14308): [<ffffffff81e003a3>]
__do_softirq+0x3a3/0x3f2
[  124.022788] softirqs last disabled at (14301): [<ffffffff81095ea1>]
irq_exit+0xc1/0xd0
[  124.022789] CPU: 22 PID: 2702 Comm: schbench Tainted: G          I
     5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022790] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022790] RIP: 0010:native_queued_spin_lock_slowpath+0x5e/0x1d0
[  124.022791] Code: ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00 8b 07
30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74 08 f3
90 8b 07 <84> c0 75 f8 b8 01 00 06
[  124.022792] RSP: 0000:ffff888c0b803e78 EFLAGS: 00000002
[  124.022793] RAX: 0000000000000101 RBX: ffff888c0a9e4400 RCX: 0000000000000540
[  124.022793] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0a9e4400
[  124.022794] RBP: ffff888c0a9e4400 R08: 0000000000000000 R09: 0000000000000001
[  124.022794] R10: ffff888c0b803e20 R11: 0000000000000000 R12: 00000000001e4400
[  124.022795] R13: 0000000000000016 R14: 0000000000000006 R15: ffff888be0335480
[  124.022795] FS:  00007f21e27ec700(0000) GS:ffff888c0b800000(0000)
knlGS:0000000000000000
[  124.022796] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022797] CR2: 00007f21e27ec728 CR3: 0000000be0b6a003 CR4: 00000000000606e0
[  124.022797] Call Trace:
[  124.022797]  <IRQ>
[  124.022798]  do_raw_spin_lock+0xb4/0xc0
[  124.022798]  _raw_spin_lock+0x4b/0x60
[  124.022799]  scheduler_tick+0x48/0x170
[  124.022799]  ? tick_sched_do_timer+0x60/0x60
[  124.022800]  update_process_times+0x40/0x50
[  124.022800]  tick_sched_handle+0x22/0x60
[  124.022801]  tick_sched_timer+0x37/0x70
[  124.022801]  __hrtimer_run_queues+0xed/0x3f0
[  124.022802]  hrtimer_interrupt+0x122/0x270
[  124.022802]  smp_apic_timer_interrupt+0x86/0x210
[  124.022803]  apic_timer_interrupt+0xf/0x20
[  124.022804]  </IRQ>
[  124.022804] RIP: 0010:smp_call_function_many+0x20e/0x270
[  124.022805] Code: f5 89 00 3b 05 e7 ed 66 01 0f 83 7e fe ff ff 48
63 d0 48 8b 0b 48 03 0c d5 40 48 39 82 8b 51 18 83 e2 01 74 0a f3 90
8b 51 18 <83> e2 01 75 f6 eb c8 09
[  124.022806] RSP: 0000:ffffc9000a237bc0 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  124.022807] RAX: 0000000000000000 RBX: ffff888c0b9e5400 RCX: ffff888c09dead60
[  124.022807] RDX: 0000000000000003 RSI: 0000000000000200 RDI: ffff888c0b9e5408
[  124.022808] RBP: ffff888c0b9e5408 R08: 0000000000000001 R09: 0000000000000000
[  124.022808] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8107d070
[  124.022809] R13: ffffc9000a237cc0 R14: 0000000000000001 R15: 0000000000000200
[  124.022810]  ? flush_tlb_func_common+0x300/0x300
[  124.022810]  ? flush_tlb_func_common+0x300/0x300
[  124.022811]  ? flush_tlb_func_common+0x300/0x300
[  124.022811]  on_each_cpu_mask+0x25/0x90
[  124.022812]  ? x86_configure_nx+0x50/0x50
[  124.022812]  on_each_cpu_cond_mask+0x97/0xd0
[  124.022813]  flush_tlb_mm_range+0xd5/0x140
[  124.022813]  ? sched_clock_cpu+0xc/0xa0
[  124.022814]  ? change_protection+0xa7b/0xaf0
[  124.022814]  ? _cond_resched+0x16/0x40
[  124.022814]  change_protection+0xa7b/0xaf0
[  124.022815]  change_prot_numa+0x18/0x30
[  124.022815]  task_numa_work+0x217/0x330
[  124.022816]  task_work_run+0x7e/0xa0
[  124.022816]  exit_to_usermode_loop+0xe0/0xf0
[  124.022817]  prepare_exit_to_usermode+0x9f/0xd0
[  124.022817]  retint_user+0x8/0x18
[  124.022818] RIP: 0033:0x7fff855a2615
[  124.022819] Code: 0c 07 08 00 00 1c 00 00 00 fc 00 00 00 c8 02 00
00 2a 00 00 00 00 41 0e 10 86 02 48 0d 06 60 c6 0c 07 08 00 00 4c 8d
54 24 08 <48> 63 ff 48 83 e4 f0 48
[  124.022819] RSP: 002b:00007f21e27ebe28 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  124.022820] RAX: 00000000001e2ec1 RBX: 00007f21e27ebe50 RCX: 0000000000000001
[  124.022821] RDX: 00007f21e27ebe60 RSI: 00007f21e27ebe50 RDI: 0000000000000000
[  124.022821] RBP: 00007f21e27ebe40 R08: 0000000000000001 R09: 0000000000007daa
[  124.022822] R10: 00007f21e27ebe30 R11: 0000000000000246 R12: 0000000000000000
[  124.022823] R13: 00007f2202716e6f R14: 0000000000000000 R15: 00007f21fc721eb8
[  124.022823] NMI watchdog: Watchdog detected hard LOCKUP on cpu 23
[  124.022824] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  124.022852] irq event stamp: 141222
[  124.022853] hardirqs last  enabled at (141221):
[<ffffffff810c7544>] sched_core_balance+0x164/0x5d0
[  124.022854] hardirqs last disabled at (141222):
[<ffffffff810c75b5>] sched_core_balance+0x1d5/0x5d0
[  124.022854] softirqs last  enabled at (141112):
[<ffffffff81e003a3>] __do_softirq+0x3a3/0x3f2
[  124.022855] softirqs last disabled at (141101):
[<ffffffff81095ea1>] irq_exit+0xc1/0xd0
[  124.022856] CPU: 23 PID: 0 Comm: swapper/23 Tainted: G          I
    5.0.0-rc8-00544-gf24f5e9-dirty #20
[  124.022857] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  124.022857] RIP: 0010:native_queued_spin_lock_slowpath+0x5e/0x1d0
[  124.022858] Code: ff 75 40 f0 0f ba 2f 08 0f 82 cd 00 00 00 8b 07
30 e4 09 c6 f7 c6 00 ff ff ff 75 1b 85 f6 74 0e 8b 07 84 c0 74 08 f3
90 8b 07 <84> c0 75 f8 b8 01 00 06
[  124.022859] RSP: 0000:ffffc900063fbcf8 EFLAGS: 00000002
[  124.022860] RAX: 00000000001c0101 RBX: ffff888c0abe4400 RCX: 000000000000c980
[  124.022860] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffff888c0abe4400
[  124.022861] RBP: ffff888c0abe4400 R08: 0000000000000000 R09: 0000000000000001
[  124.022861] R10: ffffc900063fbca0 R11: 0000000000000000 R12: 0000000000000017
[  124.022862] R13: 0000000000000000 R14: ffff888c0bbe4400 R15: 00000000001e4400
[  124.022863] FS:  0000000000000000(0000) GS:ffff888c0ba00000(0000)
knlGS:0000000000000000
[  124.022863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.022864] CR2: 00007f21eb7fe728 CR3: 0000000be0b6a002 CR4: 00000000000606e0
[  124.022864] Call Trace:
[  124.022865]  do_raw_spin_lock+0xb4/0xc0
[  124.022865]  _raw_spin_lock_nested+0x49/0x60
[  124.022866]  sched_core_balance+0x106/0x5d0
[  124.022866]  __balance_callback+0x49/0xa0
[  124.022867]  __schedule+0x12eb/0x1660
[  124.022867]  ? _raw_spin_unlock_irqrestore+0x4e/0x60
[  124.022868]  ? hrtimer_start_range_ns+0x1b7/0x340
[  124.022868]  schedule_idle+0x28/0x40
[  124.022868]  do_idle+0x169/0x2a0
[  124.022869]  cpu_startup_entry+0x19/0x20
[  124.022869]  start_secondary+0x17f/0x1d0
[  124.022870]  secondary_startup_64+0xa4/0xb0
[  129.616038] ---[ end Kernel panic - not syncing: Hard LOCKUP ]---
