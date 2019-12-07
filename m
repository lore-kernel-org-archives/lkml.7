Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3430C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A395224677
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLGRZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:25:11 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:54239 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:25:10 -0500
Received: by mail-io1-f71.google.com with SMTP id m10so7344902ioo.20
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 09:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qudlbjBQhSrocc4+6WLz4vgDTeNSziLeCxvyG2jwZtE=;
        b=pSawD1yaP2QPhD7j8wrnRAmDXikn60lKqe8CnUzel+Uh9HPE2JQypR6OrBHaW+eZst
         ngaAivA9Pio10+/gmA5Am1D/HOX8+KFTEEUjXvB7y+QgFOG6f0Klu4+1Eb1T5k10NcOW
         tbH6zAYP+GbMqCqZsdPEtOE0fm+La49b1aDdA6cTSD6In2eoxJah+YC9Q6CDttBk48wB
         SM8yVdbyqLtw1Uw8VOF2WTj5SkJBS/j+EvP2yQC0I/CZJsqQMFYrPBxCr+2OrvS1MIsj
         qPITuNU/36JX1klqFBQR6D9n0KhidbXkILOaMezJo/sMR7DASpLLWquyr7CSaRfHgeHi
         ROlA==
X-Gm-Message-State: APjAAAXkCFZCkbhziA9Gn4eCKJU0r7IO4BcHiPjqwl3u8Xmp9v1882vA
        dGewr5ZBNIzumWG95nCIdZWBKXSPBZTTD1BtN4T5dDIYYng8
X-Google-Smtp-Source: APXvYqxv2GePV49PF3QhN0wdSWENDZndIIlxW+FSMrVgiQ+uKL2hlbDzhONrcBA8XfIRFiYLltHZ+dMnKHIJnl8aoL4ocUtKqhqa
MIME-Version: 1.0
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr21480945ilg.137.1575739509530;
 Sat, 07 Dec 2019 09:25:09 -0800 (PST)
Date:   Sat, 07 Dec 2019 09:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b96b2b0599207174@google.com>
Subject: BUG: sleeping function called from invalid context in tpk_write
From:   syzbot <syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, john.wanghui@huawei.com,
        keescook@chromium.org, kernelfans@gmail.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, zhangshaokun@hisilicon.com,
        zhenzhong.duan@oracle.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea2d5da Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1706d1bce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=2eeef62ee31f9460ad65
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1199bb7ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109fd77ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at  
kernel/locking/mutex.c:938
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
1 lock held by swapper/1/0:
  #0: ffffc90000da8d50 ((&sp->resync_t)){+.-.}, at: lockdep_copy_map  
include/linux/lockdep.h:172 [inline]
  #0: ffffc90000da8d50 ((&sp->resync_t)){+.-.}, at: call_timer_fn+0xe0/0x780  
kernel/time/timer.c:1394
Preemption disabled at:
[<ffffffff8130614e>] start_secondary+0xde/0x410  
arch/x86/kernel/smpboot.c:228
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  __mutex_lock_common kernel/locking/mutex.c:938 [inline]
  __mutex_lock+0xc5/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  tpk_write+0x5d/0x340 drivers/char/ttyprintk.c:122
  resync_tnc+0x1b6/0x320 drivers/net/hamradio/6pack.c:522
  call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1404
  expire_timers kernel/time/timer.c:1449 [inline]
  __run_timers kernel/time/timer.c:1773 [inline]
  __run_timers kernel/time/timer.c:1740 [inline]
  run_timer_softirq+0x6c3/0x1790 kernel/time/timer.c:1786
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 98 81 eb f9 eb 8a cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 04 83 61  
00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d f4 82 61 00 fb f4 <c3> cc 55 48 89  
e5 41 57 41 56 41 55 41 54 53 e8 ce 93 9b f9 e8 79
RSP: 0018:ffffc90000d3fd68 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff13266ae RBX: ffff8880a99fa340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a99fabd4
RBP: ffffc90000d3fd98 R08: ffff8880a99fa340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8a790e80 R14: 0000000000000000 R15: 0000000000000001
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:690
  default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3c8/0x6e0 kernel/sched/idle.c:269
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:361
  start_secondary+0x2f4/0x410 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

================================
WARNING: inconsistent lock state
5.4.0-syzkaller #0 Tainted: G        W
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/1/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffff8c110ab0 (&tpk_port.port_write_mutex){+.?.}, at:  
tpk_write+0x5d/0x340 drivers/char/ttyprintk.c:122
{SOFTIRQ-ON-W} state was registered at:
   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
   __mutex_lock_common kernel/locking/mutex.c:959 [inline]
   __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
   tpk_write+0x5d/0x340 drivers/char/ttyprintk.c:122
   tnc_init drivers/net/hamradio/6pack.c:536 [inline]
   sixpack_open+0x8d6/0xaaf drivers/net/hamradio/6pack.c:632
   tty_ldisc_open.isra.0+0xa3/0x110 drivers/tty/tty_ldisc.c:464
   tty_set_ldisc+0x30e/0x6b0 drivers/tty/tty_ldisc.c:591
   tiocsetd drivers/tty/tty_io.c:2337 [inline]
   tty_ioctl+0xe8d/0x14f0 drivers/tty/tty_io.c:2597
   vfs_ioctl fs/ioctl.c:47 [inline]
   file_ioctl fs/ioctl.c:545 [inline]
   do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
   ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
   __do_sys_ioctl fs/ioctl.c:756 [inline]
   __se_sys_ioctl fs/ioctl.c:754 [inline]
   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
irq event stamp: 195718
hardirqs last  enabled at (195718): [<ffffffff81006743>]  
trace_hardirqs_on_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:41
hardirqs last disabled at (195717): [<ffffffff8100675f>]  
trace_hardirqs_off_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:42
softirqs last  enabled at (195642): [<ffffffff814732ac>]  
_local_bh_enable+0x1c/0x30 kernel/softirq.c:162
softirqs last disabled at (195643): [<ffffffff81475cab>] invoke_softirq  
kernel/softirq.c:373 [inline]
softirqs last disabled at (195643): [<ffffffff81475cab>]  
irq_exit+0x19b/0x1e0 kernel/softirq.c:413

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&tpk_port.port_write_mutex);
   <Interrupt>
     lock(&tpk_port.port_write_mutex);

  *** DEADLOCK ***

1 lock held by swapper/1/0:
  #0: ffffc90000da8d50 ((&sp->resync_t)){+.-.}, at: lockdep_copy_map  
include/linux/lockdep.h:172 [inline]
  #0: ffffc90000da8d50 ((&sp->resync_t)){+.-.}, at: call_timer_fn+0xe0/0x780  
kernel/time/timer.c:1394

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_usage_bug.cold+0x327/0x378 kernel/locking/lockdep.c:3101
  valid_state kernel/locking/lockdep.c:3112 [inline]
  mark_lock_irq kernel/locking/lockdep.c:3309 [inline]
  mark_lock+0xbb4/0x1220 kernel/locking/lockdep.c:3666
  mark_usage kernel/locking/lockdep.c:3566 [inline]
  __lock_acquire+0x1e8e/0x4a00 kernel/locking/lockdep.c:3909
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __mutex_lock_common kernel/locking/mutex.c:959 [inline]
  __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  tpk_write+0x5d/0x340 drivers/char/ttyprintk.c:122
  resync_tnc+0x1b6/0x320 drivers/net/hamradio/6pack.c:522
  call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1404
  expire_timers kernel/time/timer.c:1449 [inline]
  __run_timers kernel/time/timer.c:1773 [inline]
  __run_timers kernel/time/timer.c:1740 [inline]
  run_timer_softirq+0x6c3/0x1790 kernel/time/timer.c:1786
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 98 81 eb f9 eb 8a cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 04 83 61  
00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d f4 82 61 00 fb f4 <c3> cc 55 48 89  
e5 41 57 41 56 41 55 41 54 53 e8 ce 93 9b f9 e8 79
RSP: 0018:ffffc90000d3fd68 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff13266ae RBX: ffff8880a99fa340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a99fabd4
RBP: ffffc90000d3fd98 R08: ffff8880a99fa340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8a790e80 R14: 0000000000000000 R15: 0000000000000001
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:690
  default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3c8/0x6e0 kernel/sched/idle.c:269
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:361
  start_secondary+0x2f4/0x410 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at kernel/locking/mutex.c:737 mutex_unlock+0x1d/0x30  
kernel/locking/mutex.c:744


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
