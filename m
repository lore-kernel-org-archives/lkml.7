Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55722C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E4821907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Sb7Abv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfIRPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:05:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36377 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfIRPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:05:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so152067qtf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNiXJXbpb0+TBl7lrUPp67Hf99oaIMMv2MH8Jc5yN6g=;
        b=C4Sb7AbvRskZEz/Q0M45eyyuvUoS0tJv8zXAISuIPBjga568s9NpyvZCnW8qkoen6K
         RynVY6cfldIGekEKNGWvtmfTw1IEuqrHES8E0GOtLNeh2WzLQ0HhCVVi8t6PBS0mYtdB
         0lAyJYYojbJRieYUs/HijkvUZwU57k/omg/OtXjkytqhhqwdiM2rgj7WeEmQaPca9VSG
         ZLb2iBnDG1MsyZhPdikhF1Z3ale5Ad7i7YwlCTNQSVYgIUxVG1Qpz2FtmIv2JjcHvB/e
         N47uC4PkVcHf2uokCSEve1awJK75mYx4V63w/Rz+v/OZ4Qtz9FwvX4TcBBzsRCZP5Kt8
         A4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNiXJXbpb0+TBl7lrUPp67Hf99oaIMMv2MH8Jc5yN6g=;
        b=s3PDSFClo/advlHAzC4GlEFLLQf2uIhIKIFh1lw5IfXbHFuRDhS4MLJcP1JhP4urxV
         G4RlgRPzOHztAzOMJtRUrUIWu0weLIW75vNx0R7gBX9n0KJgX3zZgZcLziY0by+SUI2l
         BKf5/gPkLEGbClEF6fgwC4Je95nnFlWn6zjcyI6ICGZD34NJOKJVrSpIe8A6UjDVaUG6
         BNh+RAtvt0a36jiceyAdbG2sKxYNKnsekF2VA97b9vOKck3cEfxZGw7ZIreOcXmP7+7o
         s7f+Sfsg1SE896N3uInMgxUUfTzHG+8eoZb0R/fhd7TuDhSrK5VBDAx0C/6cMdoYLb1k
         HUNg==
X-Gm-Message-State: APjAAAXf7Fem9AxYo0lbcAn3879o6sDwtQKr0cfdgNoLQZ4FFxkAPU2j
        0Ozi8QkSPyvxJnPYxoTqw5UXcJ1x0YhjliZyCnUP/sHXgKc=
X-Google-Smtp-Source: APXvYqwywFKbICLbov40yfHdoSZAhfIX75FL6TFm0iVW/qbt4Qi3b0gT6CB8DV4/Y0zDBWi5bUHPPG0MvAQmEwsypZ4=
X-Received: by 2002:ac8:108b:: with SMTP id a11mr4531992qtj.380.1568819139472;
 Wed, 18 Sep 2019 08:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000674b3d0592d2015b@google.com>
In-Reply-To: <000000000000674b3d0592d2015b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Sep 2019 17:05:26 +0200
Message-ID: <CACT4Y+YX3yNz7Fc8wUKsVR-rzusqmTnzP6ysZx+=3CzhVHk36w@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_exit_group
To:     syzbot <syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, avagin@gmail.com,
        Christian Brauner <christian@brauner.io>, dbueso@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, prsood@codeaurora.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 1:19 PM syzbot
<syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    a7f89616 Merge branch 'for-5.3-fixes' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c33079600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=861a6f31647968de
> dashboard link: https://syzkaller.appspot.com/bug?extid=18379f2a19bc62c12565
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1066bb85600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e9f75e600000
>
> Bisection is inconclusive: the bug happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154d4969600000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=174d4969600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=134d4969600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com
>
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:    1-...!: (10499 ticks this GP) idle=63a/1/0x4000000000000002
> softirq=10978/10978 fqs=0
>         (t=10501 jiffies g=10601 q=227)
> rcu: rcu_preempt kthread starved for 10502 jiffies! g10601 f0x0
> RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
> rcu: RCU grace-period kthread stack dump:
> rcu_preempt     I29040    10      2 0x80004000
> Call Trace:
>   context_switch kernel/sched/core.c:3254 [inline]
>   __schedule+0x755/0x1580 kernel/sched/core.c:3880
>   schedule+0xd9/0x260 kernel/sched/core.c:3947
>   schedule_timeout+0x486/0xc50 kernel/time/timer.c:1807
>   rcu_gp_fqs_loop kernel/rcu/tree.c:1611 [inline]
>   rcu_gp_kthread+0x9b2/0x18c0 kernel/rcu/tree.c:1768
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Sending NMI from CPU 1 to CPUs 0:
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.403
> msecs
> NMI backtrace for cpu 0
> CPU: 0 PID: 10344 Comm: syz-executor933 Not tainted 5.3.0-rc8+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:hhf_dequeue+0x552/0xa20 net/sched/sch_hhf.c:436
> Code: ff ff 45 31 ff e9 b0 02 00 00 e8 49 05 ac fb 48 8d 43 f0 41 be 01 00
> 00 00 49 8d 95 c0 02 00 00 48 39 c2 74 34 e8 2e 05 ac fb <49> 8d bd ac 03
> 00 00 48 89 f8 48 c1 e8 03 42 0f b6 14 20 48 89 f8
> RSP: 0018:ffff8880ae809038 EFLAGS: 00000206
> RAX: ffff8880a3970100 RBX: ffff8880a8b1d538 RCX: ffffffff85c66b39
> RDX: 0000000000000100 RSI: ffffffff85c66fd2 RDI: 0000000000000005
> RBP: ffff8880ae809088 R08: ffff8880a3970100 R09: 0000000000000000
> R10: fffffbfff134afaf R11: ffff8880a3970100 R12: dffffc0000000000
> R13: ffff8880a8b1d240 R14: 0000000000000001 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006dab10 CR3: 0000000008c6d000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   dequeue_skb net/sched/sch_generic.c:258 [inline]
>   qdisc_restart net/sched/sch_generic.c:361 [inline]
>   __qdisc_run+0x1e7/0x19d0 net/sched/sch_generic.c:379
>   __dev_xmit_skb net/core/dev.c:3533 [inline]
>   __dev_queue_xmit+0x16f1/0x3650 net/core/dev.c:3838
>   dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
>   br_dev_queue_push_xmit+0x3f3/0x5c0 net/bridge/br_forward.c:52
>   NF_HOOK include/linux/netfilter.h:305 [inline]
>   NF_HOOK include/linux/netfilter.h:299 [inline]
>   br_forward_finish+0xfa/0x400 net/bridge/br_forward.c:65
>   NF_HOOK include/linux/netfilter.h:305 [inline]
>   NF_HOOK include/linux/netfilter.h:299 [inline]
>   __br_forward+0x641/0xb00 net/bridge/br_forward.c:109
>   deliver_clone+0x61/0xc0 net/bridge/br_forward.c:125
>   maybe_deliver+0x2c7/0x390 net/bridge/br_forward.c:181
>   br_flood+0x13a/0x3d0 net/bridge/br_forward.c:223
>   br_dev_xmit+0x98c/0x15a0 net/bridge/br_device.c:100
>   __netdev_start_xmit include/linux/netdevice.h:4406 [inline]
>   netdev_start_xmit include/linux/netdevice.h:4420 [inline]
>   xmit_one net/core/dev.c:3280 [inline]
>   dev_hard_start_xmit+0x1a3/0x9c0 net/core/dev.c:3296
>   __dev_queue_xmit+0x2b15/0x3650 net/core/dev.c:3869
>   dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
>   neigh_hh_output include/net/neighbour.h:500 [inline]
>   neigh_output include/net/neighbour.h:509 [inline]
>   ip_finish_output2+0x1726/0x2570 net/ipv4/ip_output.c:228
>   __ip_finish_output net/ipv4/ip_output.c:308 [inline]
>   __ip_finish_output+0x5fc/0xb90 net/ipv4/ip_output.c:290
>   ip_finish_output+0x38/0x1f0 net/ipv4/ip_output.c:318
>   NF_HOOK_COND include/linux/netfilter.h:294 [inline]
>   ip_output+0x21f/0x640 net/ipv4/ip_output.c:432
>   dst_output include/net/dst.h:436 [inline]
>   ip_local_out+0xbb/0x190 net/ipv4/ip_output.c:125
>   igmpv3_sendpack+0x1b5/0x2c0 net/ipv4/igmp.c:426
>   igmpv3_send_cr net/ipv4/igmp.c:721 [inline]
>   igmp_ifc_timer_expire+0x687/0xa00 net/ipv4/igmp.c:809

This should have been parsed as "INFO: rcu detected stall in
igmp_ifc_timer_expire" which was already reported:
https://syzkaller.appspot.com/bug?id=330ce4f7626354cc6444c457c9a5e82d8a8c5055
So let's do:
#syz fix: sch_hhf: ensure quantum and hhf_non_hh_weight are non-zero

+Paul, Tetsuo

However, I cannot make sense of this kernel output (nor syzbot).
Here is full console output:
https://syzkaller.appspot.com/x/log.txt?x=15c33079600000

This is "self-detected stall" which was detected in rcu_gp_kthread (?
usually these are detected in interrupts, no?)
and then the kthread runs on CPU 1 on top of the igmp_ifc_timer_expire
handler running in an interrupt (how can a kthread run on the
interrupt stack?)
and then it does NMI traceback for CPU 0, but that runs on CPU 1
(shouldn't NMI traceback run on CPU 0 too?)

Any ideas what exactly happened here and how one can make sense of
such output to attribute it to some kernel activity that caused the
stall?





>   call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1322
>   expire_timers kernel/time/timer.c:1366 [inline]
>   __run_timers kernel/time/timer.c:1685 [inline]
>   __run_timers kernel/time/timer.c:1653 [inline]
>   run_timer_softirq+0x697/0x17a0 kernel/time/timer.c:1698
>   __do_softirq+0x262/0x98c kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0x19b/0x1e0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:537 [inline]
>   smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>   </IRQ>
> RIP: 0010:__raw_write_unlock_irq include/linux/rwlock_api_smp.h:268 [inline]
> RIP: 0010:_raw_write_unlock_irq+0x54/0x90 kernel/locking/spinlock.c:343
> Code: c0 60 f4 d2 88 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00
> 75 33 48 83 3d 05 bf 94 01 00 74 20 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00
> e8 62 8c 10 fa 65 8b 05 93 c8 c3 78 85 c0 74 06 41
> RSP: 0018:ffff8880a406fd70 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffffff11a5e8c RBX: ffff88809fbda740 RCX: 1ffffffff134b5ee
> RDX: dffffc0000000000 RSI: ffffffff8177f15e RDI: ffffffff873e3538
> RBP: ffff8880a406fd78 R08: ffff8880a3970100 R09: fffffbfff134afb0
> R10: fffffbfff134afaf R11: ffffffff89a57d7f R12: ffffffff88c090c0
> R13: 0000000000000011 R14: ffff8880a3970100 R15: 0000000000000000
>   exit_notify kernel/exit.c:745 [inline]
>   do_exit+0x13ab/0x2e50 kernel/exit.c:900
>   do_group_exit+0x135/0x360 kernel/exit.c:983
>   __do_sys_exit_group kernel/exit.c:994 [inline]
>   __se_sys_exit_group kernel/exit.c:992 [inline]
>   __x64_sys_exit_group+0x44/0x50 kernel/exit.c:992
>   do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440f88
> Code: Bad RIP value.
> RSP: 002b:00007ffe302d02b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440f88
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004c6eb0 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d95e0 R14: 0000000000000000 R15: 0000000000000000
> NMI backtrace for cpu 1
> CPU: 1 PID: 10345 Comm: syz-executor933 Not tainted 5.3.0-rc8+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
>   nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
>   arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>   rcu_dump_cpu_stacks+0x183/0x1cf kernel/rcu/tree_stall.h:254
>   print_cpu_stall kernel/rcu/tree_stall.h:455 [inline]
>   check_cpu_stall kernel/rcu/tree_stall.h:529 [inline]
>   rcu_pending kernel/rcu/tree.c:2736 [inline]
>   rcu_sched_clock_irq.cold+0x4dd/0xc13 kernel/rcu/tree.c:2183
>   update_process_times+0x32/0x80 kernel/time/timer.c:1639
>   tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
>   tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1296
>   __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
>   __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1451
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
>   smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1135
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>   </IRQ>
> RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:656 [inline]
> RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:84 [inline]
> RIP: 0010:native_queued_spin_lock_slowpath+0x132/0x9f0
> kernel/locking/qspinlock.c:325
> Code: 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 37 07 00 00 48
> 81 c4 98 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 f3 90 <e9> 73 ff ff ff
> 8b 45 98 4c 8d 65 d8 3d 00 01 00 00 0f 84 e5 00 00
> RSP: 0018:ffff8880946ef2f8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000000 RBX: ffff8880a8b1d328 RCX: ffffffff81595c17
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880a8b1d328
> RBP: ffff8880946ef3b8 R08: 1ffff11015163a65 R09: ffffed1015163a66
> R10: ffffed1015163a65 R11: ffff8880a8b1d32b R12: 0000000000000001
> R13: 0000000000000003 R14: ffffed1015163a65 R15: 0000000000000001
>   pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:654 [inline]
>   queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
>   queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
>   do_raw_spin_lock+0x20e/0x2e0 kernel/locking/spinlock_debug.c:113
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
>   _raw_spin_lock_bh+0x3b/0x50 kernel/locking/spinlock.c:175
>   spin_lock_bh include/linux/spinlock.h:343 [inline]
>   sch_tree_lock include/net/sch_generic.h:570 [inline]
>   hhf_change+0x2e3/0xad0 net/sched/sch_hhf.c:537
>   qdisc_change net/sched/sch_api.c:1321 [inline]
>   tc_modify_qdisc+0xfcf/0x1c50 net/sched/sch_api.c:1623
>   rtnetlink_rcv_msg+0x463/0xb00 net/core/rtnetlink.c:5223
>   netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
>   rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5241
>   netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
>   netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
>   netlink_sendmsg+0x8a5/0xd60 net/netlink/af_netlink.c:1917
>   sock_sendmsg_nosec net/socket.c:637 [inline]
>   sock_sendmsg+0xd7/0x130 net/socket.c:657
>   ___sys_sendmsg+0x803/0x920 net/socket.c:2311
>   __sys_sendmsg+0x105/0x1d0 net/socket.c:2356
>   __do_sys_sendmsg net/socket.c:2365 [inline]
>   __se_sys_sendmsg net/socket.c:2363 [inline]
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2363
>   do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x442399
> Code: e8 9c 07 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 3b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe302d02f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000442399
> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
> RBP: 000000000003c361 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00000000004032f0 R14: 0000000000000000 R15: 0000000000000000
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000674b3d0592d2015b%40google.com.
