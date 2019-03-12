Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893A1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3222C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8aK5P/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCLHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:45:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42802 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:45:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id p1so1260963lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8GpXjHQhN5JEy0F6qrmijXYCVBQ8QZq/nDp6zdIxjY=;
        b=r8aK5P/mtT7AY3OWpbkXSzrG8ooHaktsmo4F5j8gnOd75sldfWqLBP9B6XMilt+t/X
         /XhlzOFBNBPiAjNmoLpYWkFpCD69s4ObY13YipYiK5Ej4KYhxaKvchR6A8GThtpg0Sg/
         OnYB0JQAwVsm+hMZbGYKDP0iSbyYe3mBs0/PmUz2D9zZNzDUHqXeRGb6Ih5j7LfUBb62
         4PB7Cl0Sui4s4cHYzXKGnqwHpLvbDHFvqs/PN/+ljkzrQ/hMfr0uJZ33V8+WDbDszElV
         BUenUxkRXbz6n1AyxNjEf5PRSL5E++xmB/OyOtswHFZXYlU9IgDEYp8NIq6LCx1IGEcB
         gqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8GpXjHQhN5JEy0F6qrmijXYCVBQ8QZq/nDp6zdIxjY=;
        b=ISkednK44ADQ9ZoFHAz5lSSWV2LLQwTz9OZP5TZqklK6U6+H/7JVF5Z52edYxD132d
         QkSU/7NzZytesLpyq+9pE5f+HZp6MZvv9WWBlED//zNoOfI8lRSRzgVCEWOhtQQpLdw0
         6ZJfX/PEuBnDe59L3mZS9CGuAm+ukCm0AnZzAQ3dOGUqwtUSlJWEoOcqv8EcZOVGlIhn
         meF8pyDX84voUc55oC4Q1R8DmrCyt1COwzhr0O+lIu/bwyBxpukkQldtxT/C4LF4ZgWB
         b5KSGSKpKAwbGAu6ZZhwRbRwb1tJQBAjIv1GshA5fOcFz6FqwVdn/NCsr6l3nyyWTGUT
         +Itw==
X-Gm-Message-State: APjAAAX9AOseb+kNYF+hNwDI0Cibe3NSrL8A5acyJ5+Q+O3MWZjilCXA
        u9GectdKOydEX+oIZg+b5JYhXkCRH4vAYkIW7fk=
X-Google-Smtp-Source: APXvYqzsBvzU1UDefJJZoDMRTLOKhH5ny8QvzPytZuv+03bY5EZ2uE0BBPVucVg9dzqPCKFmHlPuAmCOmrpJqjXzcFQ=
X-Received: by 2002:a19:520e:: with SMTP id m14mr19568795lfb.64.1552376734328;
 Tue, 12 Mar 2019 00:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net> <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com> <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
In-Reply-To: <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 12 Mar 2019 15:45:22 +0800
Message-ID: <CAERHkrvjOfVz9xGWZOTGvcUcMETyBdQ2NPj-0USQNU1QTDXR3Q@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 7:36 AM Subhra Mazumdar
<subhra.mazumdar@oracle.com> wrote:
>
>
> On 3/11/19 11:34 AM, Subhra Mazumdar wrote:
> >
> > On 3/10/19 9:23 PM, Aubrey Li wrote:
> >> On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
> >> <subhra.mazumdar@oracle.com> wrote:
> >>> expected. Most of the performance recovery happens in patch 15 which,
> >>> unfortunately, is also the one that introduces the hard lockup.
> >>>
> >> After applied Subhra's patch, the following is triggered by enabling
> >> core sched when a cgroup is
> >> under heavy load.
> >>
> > It seems you are facing some other deadlock where printk is involved.
> > Can you
> > drop the last patch (patch 16 sched: Debug bits...) and try?
> >
> > Thanks,
> > Subhra
> >
> Never Mind, I am seeing the same lockdep deadlock output even w/o patch
> 16. Btw
> the NULL fix had something missing,

One more NULL pointer dereference:

Mar 12 02:24:46 aubrey-ivb kernel: [  201.916741] core sched enabled
[  201.950203] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
[  201.950254] ------------[ cut here ]------------
[  201.959045] #PF error: [normal kernel read fault]
[  201.964272] !se->on_rq
[  201.964287] WARNING: CPU: 22 PID: 2965 at kernel/sched/fair.c:6849
set_next_buddy+0x52/0x70
[  201.969596] PGD 8000000be9ed7067 P4D 8000000be9ed7067 PUD c00911067 PMD 0
[  201.972300] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  201.981712] Oops: 0000 [#1] SMP PTI
[  201.989463] CPU: 22 PID: 2965 Comm: schbench Tainted: G          I
     5.0.0-rc8-00542-gd697415be692-dirty #13
[  202.074710] CPU: 27 PID: 2947 Comm: schbench Tainted: G          I
     5.0.0-rc8-00542-gd697415be692-dirty #13
[  202.078662] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  202.078674] RIP: 0010:set_next_buddy+0x52/0x70
[  202.090135] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  202.090144] RIP: 0010:rb_insert_color+0x17/0x190
[  202.101623] Code: 48 85 ff 74 10 8b 47 40 85 c0 75 e2 80 3d 9e e5
6a 01 00 74 02 f3 c3 48 c7 c7 5c 05 2c 82 c6 05 8c e5 6a 01 01 e8 2e
bb fb ff <0f> 0b c3 83 bf 04 03 0e
[  202.113216] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 17 48 85 d2 0f 84 4d 01 00 00 48 8b 02 a8 01 0f 85 6d
01 00 00 <48> 8b 48 08 49 89 c0 44
[  202.118263] RSP: 0018:ffffc9000a5cbbb0 EFLAGS: 00010086
[  202.129858] RSP: 0018:ffffc9000a463cc0 EFLAGS: 00010046
[  202.135102] RAX: 0000000000000000 RBX: ffff88980047e800 RCX: 0000000000000000
[  202.135105] RDX: ffff888be28caa40 RSI: 0000000000000001 RDI: ffffffff8110c3fa
[  202.156251] RAX: 0000000000000000 RBX: ffff888bfeb80000 RCX: ffff888bfeb80000
[  202.156255] RDX: ffff888be28c8348 RSI: ffff88980b5e50c8 RDI: ffff888bfeb80348
[  202.177390] RBP: ffff88980047ea00 R08: 0000000000000000 R09: 00000000001e3a80
[  202.177393] R10: ffffc9000a5cbb28 R11: 0000000000000000 R12: ffff888c0b9e4400
[  202.183317] RBP: ffff88980b5e4400 R08: 000000000000014f R09: ffff8898049cf000
[  202.183320] R10: 0000000000000078 R11: ffff8898049cfc5c R12: 0000000000000004
[  202.189241] R13: ffff888be28caa40 R14: 0000000000000009 R15: 0000000000000009
[  202.189245] FS:  00007f05f87f8700(0000) GS:ffff888c0b800000(0000)
knlGS:0000000000000000
[  202.197310] R13: ffffc9000a463d20 R14: 0000000000000246 R15: 000000000000001c
[  202.197314] FS:  00007f0611cca700(0000) GS:ffff88980b200000(0000)
knlGS:0000000000000000
[  202.205373] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.205377] CR2: 00007f05e9fdb728 CR3: 0000000be4d0e006 CR4: 00000000000606e0
[  202.213441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.213444] CR2: 0000000000000008 CR3: 0000000be4d0e005 CR4: 00000000000606e0
[  202.221509] Call Trace:
[  202.229574] Call Trace:
[  202.237640]  dequeue_task_fair+0x7e/0x1b0
[  202.245700]  enqueue_task+0x6f/0xb0
[  202.253761]  __schedule+0xcc8/0x1570
[  202.261823]  ttwu_do_activate+0x6a/0xc0
[  202.270985]  schedule+0x28/0x70
[  202.279042]  try_to_wake_up+0x20b/0x510
[  202.288206]  futex_wait_queue_me+0xbf/0x130
[  202.294714]  wake_up_q+0x3f/0x80
[  202.302773]  futex_wait+0xeb/0x240
[  202.309282]  futex_wake+0x157/0x180
[  202.317353]  ? __switch_to_asm+0x40/0x70
[  202.320158]  do_futex+0x451/0xad0
[  202.322970]  ? __switch_to_asm+0x34/0x70
[  202.322980]  ? __switch_to_asm+0x40/0x70
[  202.327541]  ? do_nanosleep+0xcc/0x1a0
[  202.331521]  do_futex+0x479/0xad0
[  202.335599]  ? hrtimer_nanosleep+0xe7/0x230
[  202.339954]  ? lockdep_hardirqs_on+0xf0/0x180
[  202.343548]  __x64_sys_futex+0x134/0x180
[  202.347906]  ? _raw_spin_unlock_irq+0x29/0x40
[  202.352660]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  202.356343]  ? finish_task_switch+0x9a/0x2c0
[  202.360228]  do_syscall_64+0x60/0x1b0
[  202.364197]  ? __schedule+0xbcd/0x1570
[  202.368663]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  202.372448]  __x64_sys_futex+0x134/0x180
[  202.376913] RIP: 0033:0x7f06129e14d9
[  202.381380]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  202.385650] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 08
[  202.389436]  do_syscall_64+0x60/0x1b0
[  202.394190] RSP: 002b:00007f0611cc9e88 EFLAGS: 00000246 ORIG_RAX:
00000000000000ca
[  202.399147]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  202.403612] RAX: ffffffffffffffda RBX: 00007f0604a30390 RCX: 00007f06129e14d9
[  202.403614] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 00007f060461d2a0
[  202.408565] RIP: 0033:0x7f06129e14d9
[  202.413905] RBP: 00007f0604a30390 R08: 0000000000000000 R09: 0000000000000000
[  202.413908] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
[  202.418760] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 08
[  202.418763] RSP: 002b:00007f05f87f7e68 EFLAGS: 00000246 ORIG_RAX:
00000000000000ca
[  202.422937] R13: 00007f06125d0c88 R14: 0000000000000010 R15: 00007f06125d0c58
[  202.422945] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  202.427209] RAX: ffffffffffffffda RBX: 00007f060820a180 RCX: 00007f06129e14d9
[  202.427212] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f060820a180
[  202.432944] CR2: 0000000000000008
[  202.437416] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[  202.437419] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f05f87f7ed0
[  202.441506] ---[ end trace 1b953fe9220b3d88 ]---
[  202.441508] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
[  202.441510] #PF error: [normal kernel read fault]
[  202.441511] PGD 0 P4D 0
[  202.441514] Oops: 0000 [#2] SMP PTI
[  202.441516] CPU: 24 PID: 0 Comm: swapper/24 Tainted: G      D   I
    5.0.0-rc8-00542-gd697415be692-dirty #13
[  202.441517] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  202.441521] RIP: 0010:rb_insert_color+0x17/0x190
[  202.441522] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 17 48 85 d2 0f 84 4d 01 00 00 48 8b 02 a8 01 0f 85 6d
01 00 00 <48> 8b 48 08 49 89 c0 44
[  202.441523] RSP: 0018:ffff88980ac03e68 EFLAGS: 00010046
[  202.441525] RAX: 0000000000000000 RBX: ffff888bfddf5480 RCX: ffff888bfddf5480
[  202.441526] RDX: ffff888bfeb857c8 RSI: ffff88980ade50c8 RDI: ffff888bfddf57c8
[  202.441527] RBP: ffff88980ade4400 R08: 0000000000000077 R09: 0000000eb31aac68
[  202.441528] R10: 0000000000000078 R11: ffff889809de4418 R12: 0000000000000000
[  202.441529] R13: ffff88980ac03ec8 R14: 0000000000000046 R15: 0000000000000018
[  202.441531] FS:  0000000000000000(0000) GS:ffff88980ac00000(0000)
knlGS:0000000000000000
[  202.441532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.441533] CR2: 0000000000000008 CR3: 0000000002616004 CR4: 00000000000606e0
[  202.441534] Call Trace:
[  202.441536]  <IRQ>
[  202.441538]  enqueue_task+0x6f/0xb0
[  202.441541]  ttwu_do_activate+0x6a/0xc0
[  202.441544]  try_to_wake_up+0x20b/0x510
[  202.441549]  hrtimer_wakeup+0x1e/0x30
[  202.441551]  __hrtimer_run_queues+0x117/0x3d0
[  202.441553]  ? __hrtimer_init+0xb0/0xb0
[  202.441557]  hrtimer_interrupt+0xe5/0x240
[  202.441563]  smp_apic_timer_interrupt+0x81/0x1f0
[  202.441565]  apic_timer_interrupt+0xf/0x20
[  202.441567]  </IRQ>
[  202.441573] RIP: 0010:cpuidle_enter_state+0xbb/0x440
[  202.441574] Code: 0f 8b ff 80 7c 24 07 00 74 17 9c 58 66 66 90 66
90 f6 c4 02 0f 85 59 03 00 00 31 ff e8 5e 2b 92 ff e8 c9 0a 99 ff fb
66 66 90 <66> 66 90 45 85 ed 0f 85
[  202.441575] RSP: 0018:ffffc90006403ea0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  202.441577] RAX: 0000000000000000 RBX: ffffffff82700480 RCX: 000000000000001f
[  202.441578] RDX: 0000002f08578463 RSI: 000000002f858b0c RDI: ffffffff8181bca7
[  202.441579] RBP: ffffe8fffae03000 R08: 0000000000000002 R09: 00000000001e3a80
[  202.441580] R10: ffffc90006403e80 R11: 0000000000000000 R12: 0000002f08578463
[  202.441581] R13: 0000000000000005 R14: 0000000000000005 R15: 0000002f05150b84
[  202.441585]  ? cpuidle_enter_state+0xb7/0x440
[  202.441590]  do_idle+0x20f/0x2a0
[  202.441594]  cpu_startup_entry+0x19/0x20
[  202.441599]  start_secondary+0x17f/0x1d0
[  202.441602]  secondary_startup_64+0xa4/0xb0
[  202.441608] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  202.441637] CR2: 0000000000000008
[  202.441684] ---[ end trace 1b953fe9220b3d89 ]---
[  202.441686] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
[  202.441689] #PF error: [normal kernel read fault]
[  202.441690] PGD 8000000be9ed7067 P4D 8000000be9ed7067 PUD c00911067 PMD 0
[  202.443007] Oops: 0000 [#3] SMP PTI
[  202.443010] CPU: 0 PID: 3006 Comm: schbench Tainted: G      D   I
    5.0.0-rc8-00542-gd697415be692-dirty #13
[  202.443012] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  202.443016] RIP: 0010:rb_insert_color+0x17/0x190
[  202.443018] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 17 48 85 d2 0f 84 4d 01 00 00 48 8b 02 a8 01 0f 85 6d
01 00 00 <48> 8b 48 08 49 89 c0 44
[  202.443020] RSP: 0000:ffff888c09c03e68 EFLAGS: 00010046
[  202.443022] RAX: 0000000000000000 RBX: ffff888bfddf2a40 RCX: ffff888bfddf2a40
[  202.443024] RDX: ffff888be28cd7c8 RSI: ffff888c0b5e50c8 RDI: ffff888bfddf2d88
[  202.443026] RBP: ffff888c0b5e4400 R08: 0000000000000077 R09: 0000000e7267ab1a
[  202.443027] R10: 0000000000000078 R11: ffff888c0a5e4418 R12: 0000000000000004
[  202.443029] R13: ffff888c09c03ec8 R14: 0000000000000046 R15: 0000000000000014
[  202.443031] FS:  00007f05e37ce700(0000) GS:ffff888c09c00000(0000)
knlGS:0000000000000000
[  202.443033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.443034] CR2: 0000000000000008 CR3: 0000000be4d0e001 CR4: 00000000000606f0
[  202.443035] Call Trace:
[  202.443038]  <IRQ>
[  202.443041]  enqueue_task+0x6f/0xb0
[  202.443046]  ttwu_do_activate+0x6a/0xc0
[  202.443050]  try_to_wake_up+0x20b/0x510
[  202.443057]  hrtimer_wakeup+0x1e/0x30
[  202.443059]  __hrtimer_run_queues+0x117/0x3d0
[  202.443062]  ? __hrtimer_init+0xb0/0xb0
[  202.443067]  hrtimer_interrupt+0xe5/0x240
[  202.443074]  smp_apic_timer_interrupt+0x81/0x1f0
[  202.443077]  apic_timer_interrupt+0xf/0x20
[  202.443079]  </IRQ>
[  202.443081] RIP: 0033:0x7ffcf1fac6ac
[  202.443084] Code: 2d 81 e9 ff ff 4c 8b 05 82 e9 ff ff 0f 01 f9 66
90 41 8b 0c 24 39 cb 0f 84 07 01 00 00 41 8b 1c 24 85 db 75 d9 eb ba
0f 01 f9 <66> 90 48 c1 e2 20 48 0f
[  202.443085] RSP: 002b:00007f05e37cddf0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  202.443088] RAX: 0000000067252571 RBX: 00007f05e37cde50 RCX: 0000000000000000
[  202.443089] RDX: 000000000000bddd RSI: 00007f05e37cde50 RDI: 0000000000000000
[  202.443091] RBP: 00007f05e37cde10 R08: 0000000000000000 R09: 00007ffcf1fa90a0
[  202.443092] R10: 00007ffcf1fa9080 R11: 000000000000fd2a R12: 0000000000000000
[  202.443094] R13: 00007f0610cc7e6f R14: 0000000000000000 R15: 00007f05fca30390
[  202.443101] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  202.443146] CR2: 0000000000000008
[  202.443202] ---[ end trace 1b953fe9220b3d8a ]---
[  202.443206] BUG: scheduling while atomic: schbench/3006/0x00010000
[  202.443207] INFO: lockdep is turned off.
[  202.443208] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  202.443253] CPU: 0 PID: 3006 Comm: schbench Tainted: G      D   I
    5.0.0-rc8-00542-gd697415be692-dirty #13
[  202.443254] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  202.443255] Call Trace:
[  202.443257]  <IRQ>
[  202.443260]  dump_stack+0x85/0xcb
[  202.443263]  __schedule_bug+0x62/0x90
[  202.443266]  __schedule+0x118f/0x1570
[  202.443273]  ? down_trylock+0xf/0x30
[  202.443278]  ? is_bpf_text_address+0x5/0xe0
[  202.443282]  schedule+0x28/0x70
[  202.443285]  schedule_timeout+0x221/0x4b0
[  202.443290]  ? vprintk_emit+0x1f9/0x350
[  202.443298]  __down_interruptible+0x86/0x100
[  202.443304]  ? down_interruptible+0x42/0x50
[  202.443307]  down_interruptible+0x42/0x50
[  202.443312]  pstore_dump+0x9e/0x340
[  202.443316]  ? lock_acquire+0x9e/0x180
[  202.443319]  ? kmsg_dump+0xe1/0x1d0
[  202.443325]  kmsg_dump+0x99/0x1d0
[  202.443331]  oops_end+0x6e/0xd0
[  202.443336]  no_context+0x1bd/0x540
[  202.443341]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  202.443347]  page_fault+0x1e/0x30
[  202.443350] RIP: 0010:rb_insert_color+0x17/0x190
[  202.443352] Code: f3 c3 31 c0 c3 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 48 8b 17 48 85 d2 0f 84 4d 01 00 00 48 8b 02 a8 01 0f 85 6d
01 00 00 <48> 8b 48 08 49 89 c0 44
[  202.443353] RSP: 0000:ffff888c09c03e68 EFLAGS: 00010046
[  202.443355] RAX: 0000000000000000 RBX: ffff888bfddf2a40 RCX: ffff888bfddf2a40
[  202.443357] RDX: ffff888be28cd7c8 RSI: ffff888c0b5e50c8 RDI: ffff888bfddf2d88
[  202.443358] RBP: ffff888c0b5e4400 R08: 0000000000000077 R09: 0000000e7267ab1a
[  202.443360] R10: 0000000000000078 R11: ffff888c0a5e4418 R12: 0000000000000004
[  202.443361] R13: ffff888c09c03ec8 R14: 0000000000000046 R15: 0000000000000014
[  202.443370]  enqueue_task+0x6f/0xb0
[  202.443374]  ttwu_do_activate+0x6a/0xc0
[  202.443377]  try_to_wake_up+0x20b/0x510
[  202.443383]  hrtimer_wakeup+0x1e/0x30
[  202.443385]  __hrtimer_run_queues+0x117/0x3d0
[  202.443387]  ? __hrtimer_init+0xb0/0xb0
[  202.443393]  hrtimer_interrupt+0xe5/0x240
[  202.443398]  smp_apic_timer_interrupt+0x81/0x1f0
[  202.443401]  apic_timer_interrupt+0xf/0x20
[  202.443402]  </IRQ>
[  202.443404] RIP: 0033:0x7ffcf1fac6ac
[  202.443406] Code: 2d 81 e9 ff ff 4c 8b 05 82 e9 ff ff 0f 01 f9 66
90 41 8b 0c 24 39 cb 0f 84 07 01 00 00 41 8b 1c 24 85 db 75 d9 eb ba
0f 01 f9 <66> 90 48 c1 e2 20 48 0f
[  202.443407] RSP: 002b:00007f05e37cddf0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  202.443409] RAX: 0000000067252571 RBX: 00007f05e37cde50 RCX: 0000000000000000
[  202.443411] RDX: 000000000000bddd RSI: 00007f05e37cde50 RDI: 0000000000000000
[  202.443412] RBP: 00007f05e37cde10 R08: 0000000000000000 R09: 00007ffcf1fa90a0
[  202.443414] R10: 00007ffcf1fa9080 R11: 000000000000fd2a R12: 0000000000000000
[  202.443415] R13: 00007f0610cc7e6f R14: 0000000000000000 R15: 00007f05fca30390
[  202.447384] R13: 00007f06114c8e6f R14: 0000000000000000 R15: 00007f060820a150
[  202.447392] irq event stamp: 6766
[  203.839390] hardirqs last  enabled at (6765): [<ffffffff810044f2>]
do_syscall_64+0x12/0x1b0
[  203.848842] hardirqs last disabled at (6766): [<ffffffff81a0affc>]
__schedule+0xdc/0x1570
[  203.858097] softirqs last  enabled at (6760): [<ffffffff81e00359>]
__do_softirq+0x359/0x40a
[  203.867558] softirqs last disabled at (6751): [<ffffffff81095be1>]
irq_exit+0xc1/0xd0
[  203.876423] ---[ end trace 1b953fe9220b3d8b ]---
