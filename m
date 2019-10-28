Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB90CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5A7204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfJ1TwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:52:12 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:57199 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfJ1TwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:52:12 -0400
Received: by mail-il1-f197.google.com with SMTP id e15so10607809ilq.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/NBmB+qLuJn/ADtyzPmxmqsWE/3aS1JnDhwYMNtyHPU=;
        b=qWan8fuTkdNuRhaoPos5ABz4e6W84UbqbDMUEu42kJGxFo4X6kCNkTqqitaLpbBXST
         XgxLFWj11D0bIqG4GQ6RATVRR9+ZBOT3a8Q3hKGUM+BxzLEJ2FJcJNXDs5QENxzgrSAI
         kukhiFiEi1NUtqz7+1k0smmEs2qJp6q607wrp9jjBDiQXIXau251xFCL4SPeqM6u40z5
         Vsn30Jc28sp1uMP09EIotmQRHI8JsodpMUa28SjzV02S8iXf1L4vs7RhAwMT4f09NPZv
         cUHO+HETlL8OfMtg8oId+y8tsjo422R37gt0q4BgUP8WwCM/vBtZYoEFlDXwIXgpndvX
         6Kbw==
X-Gm-Message-State: APjAAAWjfGpx2F4pqCFRhlZM+IYVwG2lbCjV5U/sQeiH0kORx9oKQKEP
        iHK87SAa+Bjb8m5CEFJLbhcTc1Pr3jEeY1Q/CjZ+iUBqKC8w
X-Google-Smtp-Source: APXvYqxoALSa3001UslYHRY1/moL395BlZG0KeoeNrvl5Bws0Uv4PAUdkYLWX4qsH2lUWlEuHJBCneQT5rVJhwGbWYXHfiQMafvZ
MIME-Version: 1.0
X-Received: by 2002:a92:4a06:: with SMTP id m6mr17981191ilf.153.1572292329275;
 Mon, 28 Oct 2019 12:52:09 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:52:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c50fd70595fdd5b2@google.com>
Subject: INFO: task hung in mpage_prepare_extent_to_map
From:   syzbot <syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com,
        darrick.wong@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        jack@suse.cz, jglisse@redhat.com, josef@toxicpanda.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sfr@canb.auug.org.au, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, william.kucharski@oracle.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    12d61c69 Add linux-next specific files for 20191024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a0fa97600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb75fd8c9fd5ed8
dashboard link: https://syzkaller.appspot.com/bug?extid=efb9e48b9fbdc49bb34a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dc4e00000

The bug was bisected to:

commit 9c61acffe2b8833152041f7b6a02d1d0a17fd378
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Oct 23 00:24:28 2019 +0000

     mm,thp: recheck each page before collapsing file THP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eb6ec0e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=101b6ec0e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17eb6ec0e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
Fixes: 9c61acffe2b8 ("mm,thp: recheck each page before collapsing file THP")

INFO: task khugepaged:1084 blocked for more than 143 seconds.
       Not tainted 5.4.0-rc4-next-20191024 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
khugepaged      D27568  1084      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  io_schedule+0x1c/0x70 kernel/sched/core.c:5780
  wait_on_page_bit_common mm/filemap.c:1175 [inline]
  __lock_page+0x422/0xab0 mm/filemap.c:1383
  lock_page include/linux/pagemap.h:480 [inline]
  mpage_prepare_extent_to_map+0xb3f/0xf90 fs/ext4/inode.c:2668
  ext4_writepages+0xb6a/0x2e70 fs/ext4/inode.c:2866
  ? 0xffffffff81000000
  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
  __filemap_fdatawrite_range+0x2bc/0x3b0 mm/filemap.c:421
  __filemap_fdatawrite mm/filemap.c:429 [inline]
  filemap_flush+0x24/0x30 mm/filemap.c:456
  collapse_file+0x36b1/0x41a0 mm/khugepaged.c:1652
  khugepaged_scan_file mm/khugepaged.c:1890 [inline]
  khugepaged_scan_mm_slot mm/khugepaged.c:1988 [inline]
  khugepaged_do_scan mm/khugepaged.c:2072 [inline]
  khugepaged+0x2da9/0x4360 mm/khugepaged.c:2117
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Showing all locks held in the system:
4 locks held by kworker/u4:0/7:
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8880a8284d28 ((wq_completion)writeback){+.+.}, at:  
process_one_work+0x88b/0x1740 kernel/workqueue.c:2240
  #1: ffff8880a988fdc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2244
  #2: ffff88809b03a0d8 (&type->s_umount_key#32){++++}, at:  
trylock_super+0x22/0x110 fs/super.c:418
  #3: ffff88809b03c990 (&sbi->s_journal_flag_rwsem){.+.+}, at:  
do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
1 lock held by khungtaskd/1077:
  #0: ffffffff88faba80 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5336
1 lock held by khugepaged/1084:
  #0: ffff88809b03c990 (&sbi->s_journal_flag_rwsem){.+.+}, at:  
do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
1 lock held by rsyslogd/8623:
  #0: ffff888098f5d860 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8713:
  #0: ffff8880a1ca4090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f392e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8714:
  #0: ffff8880a0faf090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f352e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8715:
  #0: ffff8880a0b1e090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f192e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8716:
  #0: ffff8880a9486090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f112e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8717:
  #0: ffff8880a161a090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f312e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8718:
  #0: ffff888095db3090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f212e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8719:
  #0: ffff88809b09e090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f092e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
1 lock held by syz-execprog/8740:
  #0: ffff8880a657d3e8 (&ei->i_mmap_sem){++++}, at:  
ext4_filemap_fault+0x7e/0xb2 fs/ext4/inode.c:6291

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1077 Comm: khungtaskd Not tainted 5.4.0-rc4-next-20191024 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:269 [inline]
  watchdog+0xc8f/0x1350 kernel/hung_task.c:353
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc4-next-20191024 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:update_group_capacity+0xa/0x920 kernel/sched/fair.c:7647
Code: e8 0b 84 5b 00 e9 57 fd ff ff 48 8b 7d c8 e8 1d 84 5b 00 e9 49 fe ff  
ff 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df <55> 48 89 e5 41  
57 41 56 49 89 fe 48 83 c7 08 48 89 fa 41 55 48 c1
RSP: 0018:ffff8880ae809878 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff8880ae809a50 RCX: ffffffff8153db8d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880a9813000
RBP: ffff8880ae809b20 R08: 1ffff110153038a4 R09: ffffed10153038a5
R10: ffffed10153038a4 R11: ffff8880a981c527 R12: dffffc0000000000
R13: ffff8880a981c520 R14: ffff8880ae809af8 R15: ffff8880ae809c30
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c420000240 CR3: 00000000a5df3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  load_balance+0x389/0x2a90 kernel/sched/fair.c:8987
  rebalance_domains+0x66a/0xba0 kernel/sched/fair.c:9413
  _nohz_idle_balance+0x336/0x3f0 kernel/sched/fair.c:9826
  nohz_idle_balance kernel/sched/fair.c:9872 [inline]
  run_rebalance_domains+0x1c6/0x2d0 kernel/sched/fair.c:10056
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  scheduler_ipi+0x38c/0x610 kernel/sched/core.c:2347
  smp_reschedule_interrupt+0x78/0x4c0 arch/x86/kernel/smp.c:244
  reschedule_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:853
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: a8 95 5a fa eb 8a 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 84 a7 53  
00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 74 a7 53 00 fb f4 <c3> 90 55 48 89  
e5 41 57 41 56 41 55 41 54 53 e8 be 75 0c fa e8 79
RSP: 0018:ffffffff88e07ce8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff02
RAX: 1ffffffff11e643f RBX: ffffffff88e7a1c0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffffffff88e7aa5c
RBP: ffffffff88e07d18 R08: ffffffff88e7a1c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff89c81680 R14: 0000000000000000 R15: 0000000000000000
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
  default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3b7/0x6e0 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
  rest_init+0x23b/0x371 init/main.c:451
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x904/0x943 init/main.c:784
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:471
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
