Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB27C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AAC21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLFJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:39:09 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36874 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFJjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:39:08 -0500
Received: by mail-il1-f197.google.com with SMTP id t19so4843221ila.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OrytzaAn3+lacXDAUIE2oscw4h2bfuo+pRQAwDlMSEA=;
        b=hkvx+48Gqcp9ekQMv86044AaDTp9OSx94JnwUaa6Vqi/UpmfnFo7oxMCqSJqyPF56A
         5sIeWQ5dHNAwcIlJPYFn8/E+9GbHAWRSo4ZRkWZa9NtNPGmQI6pyCu70Hy4z5oFfn2sW
         JAdupQsrAJGTIgSXAeO8WMp7R1knXK0J6M58dq/mPOPSzumVefot7L2vr5ehH8FM2Bue
         s65A8ONg+bHnsxrZLFfckkShuOmCFqNFrbRrvbLUkYN0Fg9s6f0iCo1nUY75DYtNW5Zo
         2WI1VVh6Cg9YOCDPXEKAoqhsNPItjBL2YrH0Oqo/jvrunwTbzRrQDhmY0kaE4n59pnHk
         KcaA==
X-Gm-Message-State: APjAAAXducBWJFdPVkfoKW4eMPREa4+8o2f+eyypdfLb12miPvz4IWNn
        p6oY3zkp7DSG8UlcgoIRv1wua/P2td3U5TJRaRWmbR6fXZ7k
X-Google-Smtp-Source: APXvYqzLxrvw8lC6Mq5F0OoVONEhG/8KDRrAFOBTMBuGiyqgl+mcDOiQjqHl/3Ah/g3ES68X6aMMzfshP5FTn/VYXlUcrqvzufAj
MIME-Version: 1.0
X-Received: by 2002:a92:4818:: with SMTP id v24mr12443185ila.96.1575625147687;
 Fri, 06 Dec 2019 01:39:07 -0800 (PST)
Date:   Fri, 06 Dec 2019 01:39:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2af3059905d1dc@google.com>
Subject: INFO: task hung in paste_selection
From:   syzbot <syzbot+a172213a651850d94cf2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    aedc0650 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1475090ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d189d07c6717979
dashboard link: https://syzkaller.appspot.com/bug?extid=a172213a651850d94cf2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a172213a651850d94cf2@syzkaller.appspotmail.com

INFO: task syz-executor.5:13549 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28536 13549   8906 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
  paste_selection+0x11d/0x460 drivers/tty/vt/selection.c:361
  tioclinux+0x133/0x480 drivers/tty/vt/vt.c:3044
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: Bad RIP value.
RSP: 002b:00007f044b9acc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000020000180 RSI: 000000000000541c RDI: 0000000000000007
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f044b9ad6d4
R13: 00000000004c5962 R14: 00000000004dbb78 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1088:
  #0: ffffffff897a4080 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/8764:
  #0: ffff8880a94c53e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8855:
  #0: ffff8880a691c090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880a691c118 (&tty->atomic_write_lock){+.+.}, at:  
tty_write_lock+0x23/0x90 drivers/tty/tty_io.c:888
2 locks held by getty/8856:
  #0: ffff88809d355090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000182b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8857:
  #0: ffff88809799b090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000180b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8858:
  #0: ffff88809535f090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017fb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8859:
  #0: ffff888096e67090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017eb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8860:
  #0: ffff8880a9088090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000181b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8861:
  #0: ffff88809a733090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000176b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
3 locks held by syz-executor.3/13496:
2 locks held by syz-executor.5/13549:
  #0: ffff8880a691c090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1088 Comm: khungtaskd Not tainted 5.4.0-syzkaller #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 13496 Comm: syz-executor.3 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:in_lock_functions+0x17/0x20 kernel/locking/spinlock.c:398
Code: 0f 1f 00 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 31 c0 48 81  
ff 58 8a c6 87 72 0c 31 c0 48 81 ff fd 98 c6 87 0f 92 c0 <c3> cc cc cc cc  
cc cc cc cc 55 48 89 e5 41 57 41 56 41 55 49 c7 c5
RSP: 0018:ffffc900018d7868 EFLAGS: 00000297
RAX: 0000000000000000 RBX: ffffffff87c56be5 RCX: 1ffffffff1685c9c
RDX: 0000000000000000 RSI: ffffffff83dd7b30 RDI: ffffffff87c56be5
RBP: ffffc900018d7880 R08: ffff888069fee1c0 R09: ffffed1014d2388d
R10: ffffed1014d2388c R11: ffff8880a691c467 R12: ffff888069fee1c0
R13: ffff888069fee1e4 R14: ffffed100d3fdc38 R15: 0000000000000001
FS:  00007f4190eb5700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000009b00e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  schedule+0xd5/0x2b0 kernel/sched/core.c:4154
  paste_selection+0x2f5/0x460 drivers/tty/vt/selection.c:367
  tioclinux+0x133/0x480 drivers/tty/vt/vt.c:3044
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4190eb4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000020000180 RSI: 000000000000541c RDI: 0000000000000007
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4190eb56d4
R13: 00000000004c5962 R14: 00000000004dbb78 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
