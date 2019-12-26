Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEBEC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927C220740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLZVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:25:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39189 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfLZVZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:25:10 -0500
Received: by mail-il1-f198.google.com with SMTP id n6so21712756ile.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 13:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6IJPcXe+juLl8jzBJQc1BqLt+0Vp3GWTy2GpjY0LKTY=;
        b=Qc5/t1rLgd+l9Tj5xf7tzajhV7+w7WUDHMRl2PiHZ6eilU+DHfanRLBHlbwsnT/ael
         hy0vdBreWIMkKmKabIB0OjxMKUeEXBdfsvhO9erGbFHkt6WdzX6nn32BGcL9xtq1Q4zL
         aA29RD4Jt49BVMuiaeT06MdAagpU8gHGaevz6aJPZfmLF5rk6EMR+JvdemdkK9WY53Uu
         03z1/YyTR5KYdAX9p5xyW2xwxIxFTUdYMOmoOxaKPWwvznAxYLCeQxGa30eT8RtzVDcb
         sqh2tWHAwQU1H+3FGHZhDNhOjl4HJSOKOeLpLaXRO7+EOE96HsS1XhUAcut/R0TheZW7
         xIwA==
X-Gm-Message-State: APjAAAX6CjChzRuDq1MNIYlw1UITjPrIHEsFZ83apvIZ+V530y2ONeXs
        SqCqblYZyqPQxvPyQjQWqNccRU9TF2mEBoE8+u6JwoHeZ7pB
X-Google-Smtp-Source: APXvYqyobAtA2s2KbBgZHuJqufBOagLb5DPorQmugr0ywAH1wUP81TdDkdxzc8r9CkXlhJsQoLQGnalW5y9Y85DyoDBGfnocG0JB
MIME-Version: 1.0
X-Received: by 2002:a92:503:: with SMTP id q3mr36439641ile.160.1577395509353;
 Thu, 26 Dec 2019 13:25:09 -0800 (PST)
Date:   Thu, 26 Dec 2019 13:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000016d8b059aa2030e@google.com>
Subject: INFO: task hung in sync_inodes_sb (3)
From:   syzbot <syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1150ecc6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=2b9e54155c8c25d8d165
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152bdc56e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c489ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com

INFO: task syz-executor221:9352 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor221 D27256  9352   9350 0x00004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  io_schedule+0x1c/0x70 kernel/sched/core.c:5799
  wait_on_page_bit_common mm/filemap.c:1175 [inline]
  wait_on_page_bit+0x27c/0xa60 mm/filemap.c:1224
  wait_on_page_writeback+0x1b2/0x4f0 mm/page-writeback.c:2822
  __filemap_fdatawait_range+0x145/0x340 mm/filemap.c:526
  filemap_fdatawait_keep_errors+0x22/0x30 mm/filemap.c:621
  wait_sb_inodes fs/fs-writeback.c:2436 [inline]
  sync_inodes_sb+0x6e4/0xb50 fs/fs-writeback.c:2558
  __sync_filesystem fs/sync.c:34 [inline]
  sync_filesystem fs/sync.c:67 [inline]
  sync_filesystem+0x168/0x260 fs/sync.c:48
  generic_shutdown_super+0x75/0x370 fs/super.c:448
  kill_block_super+0xa0/0x100 fs/super.c:1444
  deactivate_locked_super+0x95/0x100 fs/super.c:335
  deactivate_super fs/super.c:366 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:362
  cleanup_mnt+0x351/0x4c0 fs/namespace.c:1102
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1109
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4487d7
Code: Bad RIP value.
RSP: 002b:00007ffd80a6c6d8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000000000003fdba RCX: 00000000004487d7
RDX: 0000000000400c50 RSI: 0000000000000002 RDI: 00007ffd80a6c780
RBP: 00000000000024b2 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000005 R11: 0000000000000202 R12: 00007ffd80a6d7e0
R13: 000000000226f940 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1113:
  #0: ffffffff899a5680 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/9238:
  #0: ffff8880a3d68120 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/9328:
  #0: ffff8880a89d3090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000177b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9329:
  #0: ffff8880984fa090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017eb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9330:
  #0: ffff88809f659090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017db2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9331:
  #0: ffff888090379090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017cb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9332:
  #0: ffff88809882c090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017bb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9333:
  #0: ffff888094fd5090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017ab2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9334:
  #0: ffff888099af1090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900011512e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by syz-executor221/9352:
  #0: ffff8880979960d8 (&type->s_umount_key#41){+.+.}, at: deactivate_super  
fs/super.c:365 [inline]
  #0: ffff8880979960d8 (&type->s_umount_key#41){+.+.}, at:  
deactivate_super+0x1aa/0x1d0 fs/super.c:362
  #1: ffff8880979968b8 (&s->s_sync_lock){+.+.}, at: wait_sb_inodes  
fs/fs-writeback.c:2375 [inline]
  #1: ffff8880979968b8 (&s->s_sync_lock){+.+.}, at:  
sync_inodes_sb+0x246/0xb50 fs/fs-writeback.c:2558

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1113 Comm: khungtaskd Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb11/0x10c0 kernel/hung_task.c:289
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_is_held kernel/locking/lockdep.c:4303 [inline]
RIP: 0010:lock_is_held_type+0x177/0x320 kernel/locking/lockdep.c:4522
Code: b8 48 8d 83 98 08 00 00 45 31 ff 48 89 45 d0 48 b8 00 00 00 00 00 fc  
ff df 49 c1 ec 03 49 01 c4 8b 83 90 08 00 00 85 c0 7f 27 <e9> 0d 01 00 00  
41 0f b6 04 24 41 83 c7 01 84 c0 74 08 3c 03 0f 8e
RSP: 0018:ffffc90000da8e18 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff8880a99fa340 RCX: 0000000000000000
RDX: 1ffff1101533f57a RSI: 00000000ffffffff RDI: ffff8880a99fabd4
RBP: ffffc90000da8e60 R08: ffff8880a99fa340 R09: ffffed1015d2703d
R10: ffffed1015d2703c R11: ffff8880ae9381e3 R12: ffffed101533f57a
R13: 0000000000000001 R14: ffffffff899a5600 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001cc8000 CR3: 00000000a3d91000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  lock_is_held include/linux/lockdep.h:361 [inline]
  rcu_read_lock_sched_held+0x9c/0xd0 kernel/rcu/update.c:122
  trace_softirq_entry include/trace/events/irq.h:128 [inline]
  __do_softirq+0x78f/0x98c kernel/softirq.c:291
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  scheduler_ipi+0x38c/0x610 kernel/sched/core.c:2348
  smp_reschedule_interrupt+0x78/0x4c0 arch/x86/kernel/smp.c:244
  reschedule_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:853
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 78 3b ea f9 eb 8a cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 54 cb 5f  
00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 44 cb 5f 00 fb f4 <c3> cc 55 48 89  
e5 41 57 41 56 41 55 41 54 53 e8 3e 0f 9a f9 e8 79
RSP: 0018:ffffc90000d3fd68 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff02
RAX: 1ffffffff132669e RBX: ffff8880a99fa340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a99fabd4
RBP: ffffc90000d3fd98 R08: ffff8880a99fa340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8a799900 R14: 0000000000000000 R15: 0000000000000001
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:690
  default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3c8/0x6e0 kernel/sched/idle.c:269
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:361
  start_secondary+0x2f4/0x410 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
