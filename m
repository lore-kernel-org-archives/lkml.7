Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C181C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 04:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031ED20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 04:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhQFpjFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCKEXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 00:23:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38561 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfCKEXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 00:23:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id k136so2333026lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 21:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LRd+8SASQkC8jKqB0I/39OTjz63JVAwR5bt2luVkU0=;
        b=rhQFpjFTgBt/EM8hG1QSLhDRL67ABBkK1ZYKE/AoWY4e1w50ER8ONtWqxxzya2nBlO
         oUjbqchf82VAmXmwr5P9LBhFoWcKZ3B7W8z74YioEiU1pYBecUJ+TNLKcOPGtwSfujjv
         US40HK+6LVdGmk/D5OBzvtbp43WjqzfEE8eHW+yKshvzJhFcPRqW/gX6Yn+siVz1S1rt
         TKR+raz/yEBiCcatFUSDVQKy0deE/uwtN5nGA06LBHukciVlkG6CLDBl2u3b73RUv2Kd
         3Ez5TTU+6BhS9ILPUxFgBeSc9V2TV6obxWJzzvh0CumaGkeIn+TU3Kw77fziHmA4KmFx
         IA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LRd+8SASQkC8jKqB0I/39OTjz63JVAwR5bt2luVkU0=;
        b=ag6xQXM95eAC+pq9oTOD8P2CcXkZStfkp+XnZy3IJaGXKBBpv/8T/ul5t9uNXcAbFF
         2I5Ra6zLKNwWCf7WrE3chNRDR2u/8cWPKAy5IgcrQOWjy7bdukzKKh5DbDnz2K4Bwzdy
         ++D9J/fYyOki/e2RZXqNbnCR+Hx3S5v3LoLgvAkCgdNWouvXCIOqhcww1IPpjZXHZVvr
         6ZJ5i7nlkUIMsiJ53SLcRFXdnwcUhUlrg2qkn5QHPJuBL2ANxi2jzvFAzZwMKV07+aBN
         /zpGhHYglUiQnnYsbnARk5soBH1lX+HHbzgYe93tAsL4L0ueC4xEY9Jvo1TflBqrGSAh
         RAbg==
X-Gm-Message-State: APjAAAWryVvWU19K521n0g1NeN8tptThHhT6L6cwkoZFWGX9H0wDIZuQ
        m4mRovIQUJc5Z26t/3akuHkD5P7/V7z3LaWa7DksmX08
X-Google-Smtp-Source: APXvYqzjIa+/qgemngLaHpDOANO8hpKnL9Ia5v7cyK+8odlybs7PWXaa/6mxj1NUuVQ24rvznVz2QcD2709EcdRUNQU=
X-Received: by 2002:ac2:53ab:: with SMTP id j11mr16007370lfh.49.1552278225711;
 Sun, 10 Mar 2019 21:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net> <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
In-Reply-To: <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Mon, 11 Mar 2019 12:23:34 +0800
Message-ID: <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Fr?d?ric Weisbecker" <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
<subhra.mazumdar@oracle.com> wrote:
>
> expected. Most of the performance recovery happens in patch 15 which,
> unfortunately, is also the one that introduces the hard lockup.
>

After applied Subhra's patch, the following is triggered by enabling
core sched when a cgroup is
under heavy load.

Mar 10 22:46:57 aubrey-ivb kernel: [ 2662.973792] core sched enabled
[ 2663.348371] WARNING: CPU: 5 PID: 3087 at kernel/sched/pelt.h:119
update_load_avg+00
[ 2663.357960] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_ni
[ 2663.443269] CPU: 5 PID: 3087 Comm: schbench Tainted: G          I
    5.0.0-rc8-7
[ 2663.454520] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.2
[ 2663.466063] RIP: 0010:update_load_avg+0x52/0x5e0
[ 2663.471286] Code: 8b af 70 01 00 00 8b 3d 14 a6 6e 01 85 ff 74 1c
e9 4c 04 00 00 40
[ 2663.492350] RSP: 0000:ffffc9000a6a3dd8 EFLAGS: 00010046
[ 2663.498276] RAX: 0000000000000000 RBX: ffff888be7937600 RCX: 0000000000000001
[ 2663.506337] RDX: 0000000000000000 RSI: ffff888c09fe4418 RDI: 0000000000000046
[ 2663.514398] RBP: ffff888bdfb8aac0 R08: 0000000000000000 R09: ffff888bdfb9aad8
[ 2663.522459] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 2663.530520] R13: ffff888c09fe4400 R14: 0000000000000001 R15: ffff888bdfb8aa40
[ 2663.538582] FS:  00007f006a7cc700(0000) GS:ffff888c0a600000(0000)
knlGS:00000000000
[ 2663.547739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2663.554241] CR2: 0000000000604048 CR3: 0000000bfdd64006 CR4: 00000000000606e0
[ 2663.562310] Call Trace:
[ 2663.565128]  ? update_load_avg+0xa6/0x5e0
[ 2663.569690]  ? update_load_avg+0xa6/0x5e0
[ 2663.574252]  set_next_entity+0xd9/0x240
[ 2663.578619]  set_next_task_fair+0x6e/0xa0
[ 2663.583182]  __schedule+0x12af/0x1570
[ 2663.587350]  schedule+0x28/0x70
[ 2663.590937]  exit_to_usermode_loop+0x61/0xf0
[ 2663.595791]  prepare_exit_to_usermode+0xbf/0xd0
[ 2663.600936]  retint_user+0x8/0x18
[ 2663.604719] RIP: 0033:0x402057
[ 2663.608209] Code: 24 10 64 48 8b 04 25 28 00 00 00 48 89 44 24 38
31 c0 e8 2c eb ff
[ 2663.629351] RSP: 002b:00007f006a7cbe50 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff02
[ 2663.637924] RAX: 000000000029778f RBX: 00000000002dc6c0 RCX: 0000000000000002
[ 2663.645985] RDX: 00007f006a7cbe60 RSI: 0000000000000000 RDI: 00007f006a7cbe50
[ 2663.654046] RBP: 0000000000000006 R08: 0000000000000001 R09: 00007ffe965450a0
[ 2663.662108] R10: 00007f006a7cbe30 R11: 000000000003b368 R12: 00007f006a7cbed0
[ 2663.670160] R13: 00007f0098c1ce6f R14: 0000000000000000 R15: 00007f0084a30390
[ 2663.678226] irq event stamp: 27182
[ 2663.682114] hardirqs last  enabled at (27181): [<ffffffff81003f70>]
exit_to_usermo0
[ 2663.692348] hardirqs last disabled at (27182): [<ffffffff81a0affc>]
__schedule+0xd0
[ 2663.701716] softirqs last  enabled at (27004): [<ffffffff81e00359>]
__do_softirq+0a
[ 2663.711268] softirqs last disabled at (26999): [<ffffffff81095be1>]
irq_exit+0xc1/0
[ 2663.720247] ---[ end trace d46e59b84bcde977 ]---
[ 2663.725503] BUG: unable to handle kernel paging request at 00000000005df5f0
[ 2663.733377] #PF error: [WRITE]
[ 2663.736875] PGD 8000000bff037067 P4D 8000000bff037067 PUD bff0b1067
PMD bfbf02067 0
[ 2663.745954] Oops: 0002 [#1] SMP PTI
[ 2663.749931] CPU: 5 PID: 3078 Comm: schbench Tainted: G        W I
    5.0.0-rc8-7
[ 2663.761233] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.2
[ 2663.772836] RIP: 0010:native_queued_spin_lock_slowpath+0x183/0x1c0
[ 2663.779827] Code: f3 90 48 8b 32 48 85 f6 74 f6 eb e8 c1 ee 12 83
e0 03 83 ee 01 42
[ 2663.800970] RSP: 0000:ffffc9000a633e18 EFLAGS: 00010006
[ 2663.806892] RAX: 00000000005df5f0 RBX: ffff888bdfbf2a40 RCX: 0000000000180000
[ 2663.814954] RDX: ffff888c0a7e5180 RSI: 0000000000001fff RDI: ffff888bdfbf2a40
[ 2663.823015] RBP: ffff888bdfbf2a40 R08: 0000000000180000 R09: 0000000000000001
[ 2663.831068] R10: ffffc9000a633dc0 R11: ffff888bdfbf2a58 R12: 0000000000000046
[ 2663.839129] R13: ffff888bdfb8aa40 R14: ffff888be5b90d80 R15: ffff888be5b90d80
[ 2663.847182] FS:  00007f00797ea700(0000) GS:ffff888c0a600000(0000)
knlGS:00000000000
[ 2663.856330] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2663.862834] CR2: 00000000005df5f0 CR3: 0000000bfdd64006 CR4: 00000000000606e0
[ 2663.870895] Call Trace:
[ 2663.873715]  do_raw_spin_lock+0xab/0xb0
[ 2663.878095]  _raw_spin_lock_irqsave+0x63/0x80
[ 2663.883066]  __balance_callback+0x19/0xa0
[ 2663.887626]  __schedule+0x1113/0x1570
[ 2663.891803]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 2663.897142]  ? apic_timer_interrupt+0xa/0x20
[ 2663.901996]  ? interrupt_entry+0x9a/0xe0
[ 2663.906450]  ? apic_timer_interrupt+0xa/0x20
[ 2663.911307] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_ni
[ 2663.996886] CR2: 00000000005df5f0
[ 2664.000686] ---[ end trace d46e59b84bcde978 ]---
[ 2664.011393] RIP: 0010:native_queued_spin_lock_slowpath+0x183/0x1c0
[ 2664.018386] Code: f3 90 48 8b 32 48 85 f6 74 f6 eb e8 c1 ee 12 83
e0 03 83 ee 01 42
[ 2664.039529] RSP: 0000:ffffc9000a633e18 EFLAGS: 00010006
[ 2664.045452] RAX: 00000000005df5f0 RBX: ffff888bdfbf2a40 RCX: 0000000000180000
[ 2664.053513] RDX: ffff888c0a7e5180 RSI: 0000000000001fff RDI: ffff888bdfbf2a40
[ 2664.061574] RBP: ffff888bdfbf2a40 R08: 0000000000180000 R09: 0000000000000001
[ 2664.069635] R10: ffffc9000a633dc0 R11: ffff888bdfbf2a58 R12: 0000000000000046
[ 2664.077688] R13: ffff888bdfb8aa40 R14: ffff888be5b90d80 R15: ffff888be5b90d80
[ 2664.085749] FS:  00007f00797ea700(0000) GS:ffff888c0a600000(0000)
knlGS:00000000000
[ 2664.094897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2664.101402] CR2: 00000000005df5f0 CR3: 0000000bfdd64006 CR4: 00000000000606e0
[ 2664.109481]
[ 2664.109482] ======================================================
[ 2664.109483] WARNING: possible circular locking dependency detected
[ 2664.109483] 5.0.0-rc8-00542-gd697415be692-dirty #7 Tainted: G          I
[ 2664.109484] ------------------------------------------------------
[ 2664.109485] schbench/3087 is trying to acquire lock:
[ 2664.109485] 000000007a0032d4 ((console_sem).lock){-.-.}, at:
down_trylock+0xf/0x30
[ 2664.109488]
[ 2664.109497] but task is already holding lock:
[ 2664.109497] 00000000efdef567 (&rq->__lock){-.-.}, at: __schedule+0xfa/0x1570
[ 2664.109507]
[ 2664.109508] which lock already depends on the new lock.
[ 2664.109509]
[ 2664.109509]
[ 2664.109510] the existing dependency chain (in reverse order) is:
[ 2664.109510]
[ 2664.109511] -> #2 (&rq->__lock){-.-.}:
[ 2664.109513]        task_fork_fair+0x35/0x1c0
[ 2664.109513]        sched_fork+0xf4/0x1f0
[ 2664.109514]        copy_process.part.39+0x7ac/0x21f0
[ 2664.109515]        _do_fork+0xf9/0x6a0
[ 2664.109515]        kernel_thread+0x25/0x30
[ 2664.109516]        rest_init+0x22/0x240
[ 2664.109517]        start_kernel+0x49f/0x4bf
[ 2664.109517]        secondary_startup_64+0xa4/0xb0
[ 2664.109518]
[ 2664.109518] -> #1 (&p->pi_lock){-.-.}:
[ 2664.109520]        try_to_wake_up+0x3d/0x510
[ 2664.109521]        up+0x40/0x60
[ 2664.109521]        __up_console_sem+0x41/0x70
[ 2664.109522]        console_unlock+0x32a/0x610
[ 2664.109522]        vprintk_emit+0x14a/0x350
[ 2664.109523]        dev_vprintk_emit+0x11d/0x230
[ 2664.109524]        dev_printk_emit+0x4a/0x70
[ 2664.109524]        _dev_info+0x64/0x80
[ 2664.109525]        usb_new_device+0x105/0x490
[ 2664.109525]        hub_event+0x81f/0x1730
[ 2664.109526]        process_one_work+0x2a4/0x600
[ 2664.109527]        worker_thread+0x2d/0x3d0
[ 2664.109527]        kthread+0x116/0x130
[ 2664.109528]        ret_from_fork+0x3a/0x50
[ 2664.109528]
[ 2664.109529] -> #0 ((console_sem).lock){-.-.}:
[ 2664.109531]        _raw_spin_lock_irqsave+0x41/0x80
[ 2664.109531]        down_trylock+0xf/0x30
[ 2664.109532]        __down_trylock_console_sem+0x33/0xa0
[ 2664.109533]        console_trylock+0x13/0x60
[ 2664.109533]        vprintk_emit+0x13d/0x350
[ 2664.109534]        printk+0x52/0x6e
[ 2664.109534]        __warn+0x5f/0x110
[ 2664.109535]        report_bug+0xa5/0x110
[ 2664.109536]        fixup_bug.part.15+0x18/0x30
[ 2664.109536]        do_error_trap+0xbb/0x100
[ 2664.109537]        do_invalid_op+0x28/0x30
[ 2664.109537]        invalid_op+0x14/0x20
[ 2664.109538]        update_load_avg+0x52/0x5e0
[ 2664.109538]        set_next_entity+0xd9/0x240
[ 2664.109539]        set_next_task_fair+0x6e/0xa0
[ 2664.109540]        __schedule+0x12af/0x1570
[ 2664.109540]        schedule+0x28/0x70
[ 2664.109541]        exit_to_usermode_loop+0x61/0xf0
[ 2664.109542]        prepare_exit_to_usermode+0xbf/0xd0
[ 2664.109542]        retint_user+0x8/0x18
[ 2664.109542]
[ 2664.109543] other info that might help us debug this:
[ 2664.109544]
[ 2664.109544] Chain exists of:
[ 2664.109544]   (console_sem).lock --> &p->pi_lock --> &rq->__lock
[ 2664.109547]
[ 2664.109548]  Possible unsafe locking scenario:
[ 2664.109548]
[ 2664.109549]        CPU0                    CPU1
[ 2664.109549]        ----                    ----
[ 2664.109550]   lock(&rq->__lock);
[ 2664.109551]                                lock(&p->pi_lock);
[ 2664.109553]                                lock(&rq->__lock);
[ 2664.109554]   lock((console_sem).lock);
[ 2664.109555]
[ 2664.109556]  *** DEADLOCK ***
[ 2664.109556]
[ 2664.109557] 1 lock held by schbench/3087:
[ 2664.109557]  #0: 00000000efdef567 (&rq->__lock){-.-.}, at:
__schedule+0xfa/0x1570
[ 2664.109560]
[ 2664.109560] stack backtrace:
[ 2664.109561] CPU: 5 PID: 3087 Comm: schbench Tainted: G          I
    5.0.0-rc8-7
[ 2664.109562] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.2
[ 2664.109563] Call Trace:
[ 2664.109563]  dump_stack+0x85/0xcb
[ 2664.109564]  print_circular_bug.isra.37+0x1d7/0x1e4
[ 2664.109565]  __lock_acquire+0x139c/0x1430
[ 2664.109565]  ? lock_acquire+0x9e/0x180
[ 2664.109566]  lock_acquire+0x9e/0x180
[ 2664.109566]  ? down_trylock+0xf/0x30
[ 2664.109567]  _raw_spin_lock_irqsave+0x41/0x80
[ 2664.109567]  ? down_trylock+0xf/0x30
[ 2664.109568]  ? vprintk_emit+0x13d/0x350
[ 2664.109569]  down_trylock+0xf/0x30
[ 2664.109569]  __down_trylock_console_sem+0x33/0xa0
[ 2664.109570]  console_trylock+0x13/0x60
[ 2664.109571]  vprintk_emit+0x13d/0x350
[ 2664.109571]  ? update_load_avg+0x52/0x5e0
[ 2664.109572]  printk+0x52/0x6e
[ 2664.109573]  ? update_load_avg+0x52/0x5e0
[ 2664.109573]  __warn+0x5f/0x110
[ 2664.109574]  ? update_load_avg+0x52/0x5e0
[ 2664.109575]  ? update_load_avg+0x52/0x5e0
[ 2664.109575]  report_bug+0xa5/0x110
[ 2664.109576]  fixup_bug.part.15+0x18/0x30
[ 2664.109576]  do_error_trap+0xbb/0x100
[ 2664.109577]  do_invalid_op+0x28/0x30
[ 2664.109578]  ? update_load_avg+0x52/0x5e0
[ 2664.109578]  invalid_op+0x14/0x20
[ 2664.109579] RIP: 0010:update_load_avg+0x52/0x5e0
[ 2664.109580] Code: 8b af 70 01 00 00 8b 3d 14 a6 6e 01 85 ff 74 1c
e9 4c 04 00 00 40
[ 2664.109581] RSP: 0000:ffffc9000a6a3dd8 EFLAGS: 00010046
[ 2664.109582] RAX: 0000000000000000 RBX: ffff888be7937600 RCX: 0000000000000001
[ 2664.109582] RDX: 0000000000000000 RSI: ffff888c09fe4418 RDI: 0000000000000046
[ 2664.109583] RBP: ffff888bdfb8aac0 R08: 0000000000000000 R09: ffff888bdfb9aad8
[ 2664.109584] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 2664.109585] R13: ffff888c09fe4400 R14: 0000000000000001 R15: ffff888bdfb8aa40
[ 2664.109585]  ? update_load_avg+0x4e/0x5e0
[ 2664.109586]  ? update_load_avg+0xa6/0x5e0
[ 2664.109586]  ? update_load_avg+0xa6/0x5e0
[ 2664.109587]  set_next_entity+0xd9/0x240
[ 2664.109588]  set_next_task_fair+0x6e/0xa0
[ 2664.109588]  __schedule+0x12af/0x1570
[ 2664.109589]  schedule+0x28/0x70
[ 2664.109589]  exit_to_usermode_loop+0x61/0xf0
[ 2664.109590]  prepare_exit_to_usermode+0xbf/0xd0
[ 2664.109590]  retint_user+0x8/0x18
[ 2664.109591] RIP: 0033:0x402057
[ 2664.109592] Code: 24 10 64 48 8b 04 25 28 00 00 00 48 89 44 24 38
31 c0 e8 2c eb ff
[ 2664.109593] RSP: 002b:00007f006a7cbe50 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff02
[ 2664.109594] RAX: 000000000029778f RBX: 00000000002dc6c0 RCX: 0000000000000002
[ 2664.109595] RDX: 00007f006a7cbe60 RSI: 0000000000000000 RDI: 00007f006a7cbe50
[ 2664.109596] RBP: 0000000000000006 R08: 0000000000000001 R09: 00007ffe965450a0
[ 2664.109596] R10: 00007f006a7cbe30 R11: 000000000003b368 R12: 00007f006a7cbed0
[ 2664.109597] R13: 00007f0098c1ce6f R14: 0000000000000000 R15: 00007f0084a30390
