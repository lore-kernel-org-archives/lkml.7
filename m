Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF4A208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfGAI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:27:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49311 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfGAI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:27:05 -0400
Received: by mail-io1-f71.google.com with SMTP id x24so14388460ioh.16
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 01:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3FQnHpaKwCT6VjRvCTnjD2uUm2GjYizzy54nGU48VEE=;
        b=idwaZrMsbFmVA5l6XwW00MWytElAvmSn/WzBWXdDOMEp9P3clIlsLMJIdgBSSbZjZy
         vmdXFb09fmJpirzyb4ONPVkXPDoUHxL93YB3VgtbCaf5pK6b7Rz2I1X7zTD9k+hX49An
         BJGucBfE0gGCd0dHptHDQz6sskxTjDEdLvAnbHzKKF5qC2/uaddUm5DQ6PjYN6Cnq9px
         px5EhqK5PQjuPjaQ2p41LTGHs1zSXcrtXKXn3Ox3j0R2BBTvpZft1m9loz+W0bBXp93h
         sonlNui6NnxtFIii201+BQHOxHZUhT2zx85+c14r1YexXUtTNFcc57kR9TTvEazLXDrY
         Fp5g==
X-Gm-Message-State: APjAAAWyP9DmZq6vvEkj+62t8RnPX3sgcM/E7Z6AbfD/d3kFh6jH6jlt
        kByEHhM6KTqpAtk73zb7tkpZrrN3TnSkHcS77m+yzqZ9AJwa
X-Google-Smtp-Source: APXvYqy60drmCs8E9tyq0Xm8LSXVaeW40nuKJ7Hp9N26C8HLOvWvYK3aJ5OsNQpxKP2P/DUSit7w8jxtB2prJYqlBgjgEKFG/lbc
MIME-Version: 1.0
X-Received: by 2002:a02:3b62:: with SMTP id i34mr27803008jaf.91.1561969624713;
 Mon, 01 Jul 2019 01:27:04 -0700 (PDT)
Date:   Mon, 01 Jul 2019 01:27:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a193aa058c9a6499@google.com>
Subject: INFO: task hung in exit_mm
From:   syzbot <syzbot+8cc1843d4eec9c0dfb35@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org, avagin@gmail.com,
        davem@davemloft.net, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        prsood@codeaurora.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    249155c2 Merge branch 'parisc-5.2-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1306be61a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=8cc1843d4eec9c0dfb35
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a85379a00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119f6249a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=139f6249a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=159f6249a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8cc1843d4eec9c0dfb35@syzkaller.appspotmail.com

INFO: task syz-executor.0:8352 blocked for more than 143 seconds.
       Not tainted 5.2.0-rc6+ #7
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D24576  8352   8340 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:2818 [inline]
  __schedule+0x658/0x9e0 kernel/sched/core.c:3445
  schedule+0x131/0x1d0 kernel/sched/core.c:3509
  __rwsem_down_read_failed_common+0x345/0x790 kernel/locking/rwsem-xadd.c:495
  rwsem_down_read_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:515
  __down_read+0x72/0x1a0 kernel/locking/rwsem.h:178
  down_read+0x45/0x50 kernel/locking/rwsem.c:26
  exit_mm+0xdb/0x630 kernel/exit.c:513
  do_exit+0x5c3/0x2300 kernel/exit.c:864
  do_group_exit+0x15c/0x2a0 kernel/exit.c:981
  __do_sys_exit_group+0x17/0x20 kernel/exit.c:992
  __se_sys_exit_group+0x14/0x20 kernel/exit.c:990
  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:990
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459519
Code: Bad RIP value.
RSP: 002b:00007ffdb1483048 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000459519
RDX: 0000000000413201 RSI: fffffffffffffff7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffff R09: 00007ffdb14830a0
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdb14830a0 R14: 0000000000000000 R15: 00007ffdb14830b0
INFO: task syz-executor.0:8355 blocked for more than 143 seconds.
       Not tainted 5.2.0-rc6+ #7
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D25512  8355   8340 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:2818 [inline]
  __schedule+0x658/0x9e0 kernel/sched/core.c:3445
  schedule+0x131/0x1d0 kernel/sched/core.c:3509
  __rwsem_down_read_failed_common+0x345/0x790 kernel/locking/rwsem-xadd.c:495
  rwsem_down_read_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:515
  __down_read+0x72/0x1a0 kernel/locking/rwsem.h:178
  down_read+0x45/0x50 kernel/locking/rwsem.c:26
  exit_mm+0xdb/0x630 kernel/exit.c:513
  do_exit+0x5c3/0x2300 kernel/exit.c:864
  do_group_exit+0x15c/0x2a0 kernel/exit.c:981
  get_signal+0x6df/0x21f0 kernel/signal.c:2640
  do_signal+0x7b/0x750 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop arch/x86/entry/common.c:164 [inline]
  prepare_exit_to_usermode+0x2f5/0x4f0 arch/x86/entry/common.c:199
  syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
  do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459519
Code: Bad RIP value.
RSP: 002b:00007f33b051bcf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000075bfd0 RCX: 0000000000459519
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000075bfd0
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075bfd4
R13: 00007ffdb1482e3f R14: 00007f33b051c9c0 R15: 000000000075bfd4

Showing all locks held in the system:
1 lock held by khungtaskd/1043:
  #0: 000000004a05a158 (rcu_read_lock){....}, at: rcu_lock_acquire+0x4/0x30  
include/linux/rcupdate.h:207
1 lock held by rsyslogd/7880:
  #0: 00000000946eafbf (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x243/0x2e0  
fs/file.c:801
2 locks held by getty/7970:
  #0: 00000000837c576c (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 000000008890c3b0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/7971:
  #0: 00000000b66a4c98 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000d588511a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/7972:
  #0: 00000000881b5f61 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000343a7af4 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/7973:
  #0: 000000009862f21e (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 0000000033c60fb7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/7974:
  #0: 00000000b1abdc0b (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 0000000040853254 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/7975:
  #0: 00000000fff02dba (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 0000000036cfe603 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/7976:
  #0: 0000000059ae43cb (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 0000000032d54919 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.0/8352:
  #0: 0000000049c5e979 (&mm->mmap_sem#2){++++}, at: exit_mm+0xdb/0x630  
kernel/exit.c:513
2 locks held by syz-executor.0/8354:
1 lock held by syz-executor.0/8355:
  #0: 0000000049c5e979 (&mm->mmap_sem#2){++++}, at: exit_mm+0xdb/0x630  
kernel/exit.c:513

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1043 Comm: khungtaskd Not tainted 5.2.0-rc6+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  nmi_cpu_backtrace+0x89/0x160 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x125/0x230 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace+0x17/0x20 include/linux/nmi.h:146
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xbb9/0xbd0 kernel/hung_task.c:289
  kthread+0x325/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8354 Comm: syz-executor.0 Not tainted 5.2.0-rc6+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:lock_is_held_type+0x26c/0x2b0 kernel/locking/lockdep.c:4346
Code: c7 c7 90 63 aa 88 e8 43 4a 54 00 48 83 3d 9b d2 4f 07 00 74 56 4c 89  
e7 57 9d 0f 1f 44 00 00 89 d8 48 83 c4 28 5b 41 5c 41 5d <41> 5e 41 5f 5d  
c3 44 89 e9 80 e1 07 80 c1 03 38 c1 7c a8 4c 89 ef
RSP: 0018:ffff8880a4d87708 EFLAGS: 00000296
RAX: 0000000000000000 RBX: ffff88809f0c6040 RCX: 1ffff110149b0f10
RDX: dffffc0000000000 RSI: ffff88809f0c68e0 RDI: 0000000000000286
RBP: ffff8880a4d87718 R08: ffffffff818fd4ed R09: 0000000000000000
R10: ffffed101155a22f R11: 1ffff1101155a22e R12: 0000000000000000
R13: 1ffff11013e18c0a R14: dffffc0000000000 R15: 1ffff11013e18d17
FS:  00007f33b053d700(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000941bd000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_is_held include/linux/lockdep.h:356 [inline]
  ___might_sleep+0x84/0x530 kernel/sched/core.c:6103
  __might_sleep+0x8f/0x100 kernel/sched/core.c:6091
  __mutex_lock_common+0xc8/0x2fc0 kernel/locking/mutex.c:909
  __mutex_lock kernel/locking/mutex.c:1073 [inline]
  mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1088
  perf_mmap+0x76d/0x16c0 kernel/events/core.c:5672
  call_mmap include/linux/fs.h:1877 [inline]
  mmap_region+0x186d/0x1d80 mm/mmap.c:1788
  do_mmap+0x9de/0x1010 mm/mmap.c:1561
  do_mmap_pgoff include/linux/mm.h:2402 [inline]
  vm_mmap_pgoff+0x190/0x240 mm/util.c:363
  ksys_mmap_pgoff+0x4ed/0x5f0 mm/mmap.c:1611
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0x103/0x120 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459519
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f33b053cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000459519
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 000000000075bf20 R08: 0000000000000003 R09: 0000000000000000
R10: 0080000000000011 R11: 0000000000000246 R12: 00007f33b053d6d4
R13: 00000000004c5822 R14: 00000000004d9ed8 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
