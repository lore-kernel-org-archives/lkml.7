Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778BC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C412073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJ6NRvsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfLDN6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:58:24 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35600 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfLDN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:58:23 -0500
Received: by mail-qv1-f68.google.com with SMTP id d17so3079918qvs.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQZRT9h5gGn+PRANbfIUGJFXwRG2sVqXF2x1gIv9kfs=;
        b=tJ6NRvsbIsUmgHEdcym0Wc0fsQFAhfkuw+O0JBwruAYPf3PJnDMVpvvu8UJR4DbDC+
         1TUjzSVM7P+ef8JRDrBmBHc0cum5nfW1g/MqxCrb4dBwstFdDHzZ69Uc1y49M5eFjKkH
         RL7r2d+Ika4blGjFxeITtmakwhCmWTYLz68iG15wKzH9z0/JMHrTFZi071S8IqysiMiS
         hBpEmerf0W0Bcocz8B85YtexLNMezMR78/wGAZ7ilQFuNTS0jrWdBkEj7s6Qv5eMw8L/
         f7EtY/9pX87CZ5jc63IpzCv/C1Z+9OfrTChuvRmSdTNtqxi9/EVkOvttqc0SLANPUMUw
         tDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQZRT9h5gGn+PRANbfIUGJFXwRG2sVqXF2x1gIv9kfs=;
        b=FRCDUjCrZdiP8pt5L7s8ouGs/k0nAB44+H807A9cZKX0qo8xtUM0vh5IkTz54JJo3w
         wadJPJNokcGfEQd6zerKHIm9xw1Uns+G49eff6Enhky+nFiv263ZjjaGPOF/EpNoIcj2
         im6pMJN0y/Ae188YWcr82dKxd8uQgqz6rf68L6ACXTStoWaCYwj9oalPvLcgR21Q7VWV
         Ov6Bf5cwsIhxcvTQECNTKQbgeeog2H5DqJIYR/1Gx82YD+fKPnRAHsH13laFb+XRYUVv
         cA8HEvuU+MiFp+U+RMH/5PrI3n4o50ZbW09dy3JCLbOaQizy5PNoxmisfhwZZ023LiV2
         vbGw==
X-Gm-Message-State: APjAAAUmQM3PxF2RlLX29IXDAwAKx22TEROI2f/eZtXskd5d6aD6LE/6
        tEY9SnmNHfI0FQXj0lt9YYBDpsKSjAEAfXcVMJ+JdQ==
X-Google-Smtp-Source: APXvYqxUT1PoMIpiOgUyl37nZdqmUEn3reGYvzlq+uXR01+gVXhkfGPq9D9ZKMFJxj7ayYKHGK6k6lod70gglwcsczc=
X-Received: by 2002:a0c:b446:: with SMTP id e6mr2700026qvf.159.1575467901712;
 Wed, 04 Dec 2019 05:58:21 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
In-Reply-To: <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Dec 2019 14:58:10 +0100
Message-ID: <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>, christian@kellner.me,
        cyphar@cyphar.com, "Reshetova, Elena" <elena.reshetova@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>, ldv@altlinux.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 9:38 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 9:27 AM syzbot
> <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f11c2ae00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9bbcda576154a4b4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=de8d933e7d153aa0c1bb
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com
>
> Something seriously broken in smack+kasan+vmap stacks, we now have 60
> rcu stalls all over the place and counting. This is one of the
> samples. I've duped 2 other samples to this one, you can see them on
> the dashboard:
> https://syzkaller.appspot.com/bug?extid=de8d933e7d153aa0c1bb
>
> I see 2 common this across all stalls:
> 1. They all happen on the instance that uses smack (which is now
> effectively dead), see smack instance here:
> https://syzkaller.appspot.com/upstream
> 2. They all contain this frame in the stack trace:
> free_thread_stack+0x168/0x590 kernel/fork.c:280
> The last commit that touches this file is "fork: support VMAP_STACK
> with KASAN_VMALLOC".
> That may be very likely the root cause. +Daniel

I've stopped smack syzbot instance b/c it produces infinite stream of
assorted crashes due to this.
Please ping syzkaller@googlegroups.com when this is fixed, I will
re-enable the instance.

> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >         (detected by 1, t=10502 jiffies, g=6629, q=331)
> > rcu: All QSes seen, last rcu_preempt kthread activity 10503
> > (4294953794-4294943291), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > syz-executor.0  R  running task    24648  8293   8292 0x0000400a
> > Call Trace:
> >   <IRQ>
> >   sched_show_task+0x40f/0x560 kernel/sched/core.c:5954
> >   print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
> >   check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
> >   rcu_pending kernel/rcu/tree.c:2827 [inline]
> >   rcu_sched_clock_irq+0x1861/0x1ad0 kernel/rcu/tree.c:2271
> >   update_process_times+0x12d/0x180 kernel/time/timer.c:1726
> >   tick_sched_handle kernel/time/tick-sched.c:167 [inline]
> >   tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
> >   __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
> >   __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1576
> >   hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1638
> >   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
> >   smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
> >   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> >   </IRQ>
> > RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> > RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
> > RIP: 0010:__sanitizer_cov_trace_pc+0x1c/0x50 kernel/kcov.c:102
> > Code: cc 07 48 89 de e8 64 02 3b 00 5b 5d c3 cc 48 8b 04 24 65 48 8b 0c 25
> > c0 1d 02 00 65 8b 15 b8 81 8b 7e f7 c2 00 01 1f 00 75 2c <8b> 91 80 13 00
> > 00 83 fa 02 75 21 48 8b 91 88 13 00 00 48 8b 32 48
> > RSP: 0018:ffffc900021c7c28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> > RAX: ffffffff81487433 RBX: 0000000000000000 RCX: ffff88809428a100
> > RDX: 0000000000000001 RSI: 00000000fffffffc RDI: ffffea0002479240
> > RBP: ffffc900021c7c50 R08: dffffc0000000000 R09: fffffbfff1287025
> > R10: fffffbfff1287025 R11: 0000000000000000 R12: dffffc0000000000
> > R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff888091c57428
> >   free_thread_stack+0x168/0x590 kernel/fork.c:280
> >   release_task_stack kernel/fork.c:440 [inline]
> >   put_task_stack+0xa3/0x130 kernel/fork.c:451
> >   finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
> >   context_switch kernel/sched/core.c:3388 [inline]
> >   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
> >   preempt_schedule_common kernel/sched/core.c:4236 [inline]
> >   preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
> >   ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
> >   __raw_read_unlock include/linux/rwlock_api_smp.h:227 [inline]
> >   _raw_read_unlock+0x3a/0x40 kernel/locking/spinlock.c:255
> >   kill_something_info kernel/signal.c:1586 [inline]
> >   __do_sys_kill kernel/signal.c:3640 [inline]
> >   __se_sys_kill+0x5e9/0x6c0 kernel/signal.c:3634
> >   __x64_sys_kill+0x5b/0x70 kernel/signal.c:3634
> >   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x422a17
> > Code: 44 00 00 48 c7 c2 d4 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e
> > 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 3e 00 00 00 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 dd 32 ff ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fff38dca538 EFLAGS: 00000293 ORIG_RAX: 000000000000003e
> > RAX: ffffffffffffffda RBX: 0000000000000064 RCX: 0000000000422a17
> > RDX: 0000000000000bb8 RSI: 0000000000000009 RDI: 00000000fffffffe
> > RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000001c62940
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000008
> > R13: 00007fff38dca570 R14: 000000000000f0b6 R15: 00007fff38dca580
> > rcu: rcu_preempt kthread starved for 10533 jiffies! g6629 f0x2
> > RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> > rcu: RCU grace-period kthread stack dump:
> > rcu_preempt     R  running task    29032    10      2 0x80004008
> > Call Trace:
> >   context_switch kernel/sched/core.c:3388 [inline]
> >   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
> >   schedule+0x181/0x210 kernel/sched/core.c:4155
> >   schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
> >   rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
> >   rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
> >   kthread+0x332/0x350 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000036decf0598c8762e%40google.com.
