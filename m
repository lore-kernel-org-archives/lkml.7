Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A8C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AE9214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfIOR3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:29:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46864 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:29:07 -0400
Received: by mail-io1-f70.google.com with SMTP id t11so5698647ioc.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=a9cFkhOCt6eMc+RXi53o5AjIyN62uEvim+sZkVasi3s=;
        b=YK6ETDChaIGwqezMzRBvV9ky8yzWJH3uUd32MV8Szdf035Z859bps3EIOuksBqxid2
         FhjYtGol58voKxvBSHSc0mS/uTrlT8z2WHmClUsjDtBmWcL8Qe2n3vHWimpJr8SF62JY
         IBbVVyC91Y/gw9G6ZqITFaeWbz5xwQETudSOlXvbnsTsmVW01v3ZgpikdBS8pgPshgo6
         2AUpqDPOzU0Jz32etYxUozIjB/YjxJxKrBflgc60tC2OwEcECCCfeDahgUtbILgebk6j
         U1JZWu7AfWZTLxrJb+GGdch302Z3FSgHw+ROYJx6TElXNKBgSvX2zDTJOO2fTpfoJgyE
         3ZXg==
X-Gm-Message-State: APjAAAUC03wxpTsyE4NDfya1RtSQrRcZg7mecelcS0NzAO4+k0roPQry
        5ILXv2GiHy2IhF0bkDkKXRbpyGm4fBJikmard/9H0nUc6BIj
X-Google-Smtp-Source: APXvYqx4AjMp5lKHZMWzhEk800ZeqfA8B04AO+X41xeiKZ8nBtsH0CeD5z/Bo6RNa3o7JaBT7Br9Th1kqs33mKraBg8xB5+IEGn9
MIME-Version: 1.0
X-Received: by 2002:a6b:1682:: with SMTP id 124mr10910899iow.99.1568568546420;
 Sun, 15 Sep 2019 10:29:06 -0700 (PDT)
Date:   Sun, 15 Sep 2019 10:29:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003fcf305929ad36a@google.com>
Subject: INFO: rcu detected stall in call_timer_fn (2)
From:   syzbot <syzbot+f33388c0f89e31abe109@syzkaller.appspotmail.com>
To:     bp@alien8.de, cai@lca.pw, drake@endlessm.com, hpa@zytor.com,
        jacob.jun.pan@linux.intel.com, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@redhat.com, puwen@hygon.cn,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3120b9a6 Merge tag 'ipc-fixes' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b5c7fa600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a6f31647968de
dashboard link: https://syzkaller.appspot.com/bug?extid=f33388c0f89e31abe109
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109a5185600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b81af1600000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107909a5600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=127909a5600000
console output: https://syzkaller.appspot.com/x/log.txt?x=147909a5600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f33388c0f89e31abe109@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (10499 ticks this GP) idle=f02/1/0x4000000000000002  
softirq=28069/28069 fqs=0
	(t=10501 jiffies g=43153 q=3)
rcu: rcu_preempt kthread starved for 10502 jiffies! g43153 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29392    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3254 [inline]
  __schedule+0x755/0x1580 kernel/sched/core.c:3880
  schedule+0xd9/0x260 kernel/sched/core.c:3947
  schedule_timeout+0x486/0xc50 kernel/time/timer.c:1807
  rcu_gp_fqs_loop kernel/rcu/tree.c:1611 [inline]
  rcu_gp_kthread+0x9b2/0x18c0 kernel/rcu/tree.c:1768
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 23362 Comm: syz-executor241 Not tainted 5.3.0-rc8+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:34 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:200 [inline]
RIP: 0010:native_write_msr+0xb/0x30 arch/x86/include/asm/msr.h:164
Code: c3 0f 21 f0 c3 0f 0b 0f 1f 84 00 00 00 00 00 0f 0b 0f 1f 40 00 66 2e  
0f 1f 84 00 00 00 00 00 89 f9 89 f0 0f 30 0f 1f 44 00 00 <c3> 55 48 c1 e2  
20 89 f6 48 89 e5 48 09 d6 31 d2 e8 90 24 1f 02 5d
RSP: 0018:ffff8880ae809ac8 EFLAGS: 00000046
RAX: 000000000000003e RBX: 0000000000000838 RCX: 0000000000000838
RDX: 0000000000000000 RSI: 000000000000003e RDI: 0000000000000838
RBP: ffff8880ae809ae0 R08: ffff888095c62500 R09: fffffbfff134afb0
R10: fffffbfff134afaf R11: ffffffff89a57d7f R12: ffff8880ae820180
R13: 000000000000003e R14: 0000000000000000 R15: 0000000000000000
FS:  00007fc6756a4700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000096b61000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  apic_write arch/x86/include/asm/apic.h:398 [inline]
  lapic_next_event+0x51/0x80 arch/x86/kernel/apic/apic.c:468
  clockevents_program_event+0x25c/0x370 kernel/time/clockevents.c:334
  tick_program_event+0xb4/0x130 kernel/time/tick-oneshot.c:44
  hrtimer_interrupt+0x369/0x770 kernel/time/hrtimer.c:1522
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1106 [inline]
  smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1131
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
RIP: 0010:__preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94  
[inline]
RIP: 0010:rcu_read_unlock_sched_notrace include/linux/rcupdate.h:730  
[inline]
RIP: 0010:trace_timer_expire_entry include/trace/events/timer.h:90 [inline]
RIP: 0010:call_timer_fn+0x607/0x780 kernel/time/timer.c:1321
Code: 28 10 00 44 0f b6 35 7d 3a 3f 08 31 ff 44 89 f6 e8 5e 29 10 00 45 84  
f6 0f 84 de 00 00 00 e8 10 28 10 00 65 ff 0d 21 b1 9f 7e <41> 0f 94 c6 31  
ff 44 89 f6 e8 3b 29 10 00 45 84 f6 0f 84 7d fb ff
RSP: 0018:ffff8880ae809d10 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: ffff888095c62500 RBX: ffff88805ed1a800 RCX: ffffffff81624cb6
RDX: 0000000000000100 RSI: ffffffff81624ce0 RDI: 0000000000000005
RBP: ffff8880ae809dd8 R08: ffff888095c62500 R09: fffffbfff134afb0
R10: fffffbfff134afaf R11: ffffffff89a57d7f R12: 0000000000000101
R13: ffff8880ae809db0 R14: 0000000000000000 R15: dffffc0000000000
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x697/0x17a0 kernel/time/timer.c:1698
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1133
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x20/0x50 kernel/kcov.c:102
Code: ff 90 90 90 90 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 40 fe 01 00  
65 8b 15 04 89 8f 7e 81 e2 00 01 1f 00 48 8b 75 08 75 2b <8b> 90 f0 12 00  
00 83 fa 02 75 20 48 8b 88 f8 12 00 00 8b 80 f4 12
RSP: 0018:ffff88805fa87948 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff888095c62500 RBX: ffff88805fa87a98 RCX: ffffffff8166d913
RDX: 0000000000000000 RSI: ffffffff8166d91d RDI: 0000000000000004
RBP: ffff88805fa87948 R08: ffff888095c62500 R09: ffffed100bf50f19
R10: ffffed100bf50f18 R11: 0000000000000003 R12: 0000000000000001
R13: ffffed100bf50f53 R14: 0000000000000000 R15: 0000000000000000
  futex_wait_setup+0x2ad/0x390 kernel/futex.c:2700
  futex_wait+0x1fc/0x5e0 kernel/futex.c:2730
  do_futex+0x175/0x1dc0 kernel/futex.c:3646
  __do_sys_futex kernel/futex.c:3707 [inline]
  __se_sys_futex kernel/futex.c:3675 [inline]
  __x64_sys_futex+0x3f7/0x590 kernel/futex.c:3675
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44cd49
Code: e8 0c d4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc6756a3cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000006dec68 RCX: 000000000044cd49
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dec68
RBP: 00000000006dec60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dec6c
R13: 00007fffc43033df R14: 00007fc6756a49c0 R15: 000000000000002d
NMI backtrace for cpu 1
CPU: 1 PID: 23361 Comm: syz-executor241 Not tainted 5.3.0-rc8+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x183/0x1cf kernel/rcu/tree_stall.h:254
  print_cpu_stall kernel/rcu/tree_stall.h:455 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:529 [inline]
  rcu_pending kernel/rcu/tree.c:2736 [inline]
  rcu_sched_clock_irq.cold+0x4dd/0xc13 kernel/rcu/tree.c:2183
  update_process_times+0x32/0x80 kernel/time/timer.c:1639
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
  tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1296
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1106 [inline]
  smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1131
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:176 [inline]
RIP: 0010:check_memory_region+0x9/0x1a0 mm/kasan/generic.c:192
Code: 00 55 48 89 f2 be f8 00 00 00 48 89 e5 e8 0f bd 8f 05 5d c3 0f 1f 00  
66 2e 0f 1f 84 00 00 00 00 00 48 85 f6 0f 84 34 01 00 00 <48> b8 ff ff ff  
ff ff 7f ff ff 55 0f b6 d2 48 39 c7 48 89 e5 41 55
RSP: 0018:ffff888064fbf960 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffffc90000c72388 RCX: ffffffff81595bd7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc90000c72388
RBP: ffff888064fbf968 R08: 1ffff9200018e471 R09: fffff5200018e472
R10: fffff5200018e471 R11: ffffc90000c7238b R12: 0000000000000001
R13: 0000000000000003 R14: fffff5200018e471 R15: 0000000000000001
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  virt_spin_lock arch/x86/include/asm/qspinlock.h:83 [inline]
  native_queued_spin_lock_slowpath+0xb7/0x9f0 kernel/locking/qspinlock.c:325
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:654 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
  do_raw_spin_lock+0x20e/0x2e0 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x37/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  futex_wake+0x1dc/0x4d0 kernel/futex.c:1618
  do_futex+0x358/0x1dc0 kernel/futex.c:3651
  __do_sys_futex kernel/futex.c:3707 [inline]
  __se_sys_futex kernel/futex.c:3675 [inline]
  __x64_sys_futex+0x3f7/0x590 kernel/futex.c:3675
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44cd49
Code: e8 0c d4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc4303458 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fffc43034f0 RCX: 000000000044cd49
RDX: 000000000044cd49 RSI: 0000000000000081 RDI: 00000000006dec68
RBP: 00007fffc4303490 R08: 00007fff00000015 R09: 00007fff00000015
R10: 00007fff00000015 R11: 0000000000000246 R12: 00000000000ff0e0
R13: 00000000006dec60 R14: 00000000006dec6c R15: 000000000000002d


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
