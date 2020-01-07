Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE825C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CFF207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgAGIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:17:14 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43443 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgAGIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:17:11 -0500
Received: by mail-il1-f198.google.com with SMTP id o13so34852331ilf.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WOdugTychdgh0w01I2Ar/1X8m+R8RZsuT0oFufRn5UQ=;
        b=LfD/h8QGqwKTIrSzwgWltjWbbNYAKdWRkAKf7f4E4TLUKW5SgtAyM6SzYRdUhkCb22
         7Lw5KwdkhulUSC5ehFFMSSO3lhBAJORCN4RDDfJti3RF2cEXrs9Jb+n/aEronppnqIOg
         siRN+d8+R8VxR3q+t9/lpO+Z4J2ad+D1z8Hw5jZzvLkrRb+wUwYFctnKhYnswJUmgJ57
         6kRNymj0h1qbI40JY1Yi4lCjvrdiUXXPGZJDeCR8ycaFcrLDQ/OimrkRzPxVlQiGH1KH
         enTmMO0SnnKK/RodUjP5Qvl97c76hGYdgX7FBhMUx752Ti3GAtIdc1Bb9VcKvsmk4g5e
         YHOw==
X-Gm-Message-State: APjAAAX3j2NR0IDnZ4VvQaGgVBD2MqlI3eJtHapOA0LYSvU4bjhsaS/v
        4DfYxErE5/gF3a68yY7xeyEDvdf2vcgsuuIPhWuJmOjJrOIT
X-Google-Smtp-Source: APXvYqxl/8h4Ht/sBQ+QRgqZtXjY9b96aMCp2p2QF9kgC5v6vapoLDW39c8UGZYhEU9dvA6lCXAvNNprqx7ZMtQAhcj4c4PlMuyh
MIME-Version: 1.0
X-Received: by 2002:a05:6602:114:: with SMTP id s20mr75192631iot.131.1578385029952;
 Tue, 07 Jan 2020 00:17:09 -0800 (PST)
Date:   Tue, 07 Jan 2020 00:17:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000078348059b8867d2@google.com>
Subject: INFO: task hung in release_tty
From:   syzbot <syzbot+585ef057d3538fcc1639@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fd698849 Linux 5.5-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135b29c1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=874bac2ff63646fa
dashboard link: https://syzkaller.appspot.com/bug?extid=585ef057d3538fcc1639
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+585ef057d3538fcc1639@syzkaller.appspotmail.com

INFO: task syz-executor.3:5749 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D28160  5749   9203 0x80004002
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  __down_common kernel/locking/semaphore.c:220 [inline]
  __down+0x176/0x2c0 kernel/locking/semaphore.c:237
  down+0x64/0x90 kernel/locking/semaphore.c:61
  console_lock+0x29/0x80 kernel/printk/printk.c:2289
  con_shutdown+0x41/0x90 drivers/tty/vt/vt.c:3277
  release_tty+0xd3/0x470 drivers/tty/tty_io.c:1514
  tty_release_struct+0x3c/0x50 drivers/tty/tty_io.c:1629
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a9e9
Code: bd 4c 00 00 b9 00 00 40 00 e8 b3 4c 00 00 90 cc cc 64 48 8b 0c 25 f8  
ff ff ff 48 3b 61 10 0f 86 ff 00 00 00 48 83 ec 40 48 89 <6c> 24 38 48 8d  
6c 24 38 48 8b 42 08 48 89 44 24 30 84 00 48 8b 4a
RSP: 002b:0000000000a6fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 000000000045a9e9
RDX: 00000000004144c1 RSI: 0000000000a770d0 RDI: 0000000000000000
RBP: 00000000004c0308 R08: 000000000000000c R09: 0000000000a6fbf0
R10: 0000000000f72940 R11: 0000000000000246 R12: 000000000075bfc8
R13: 0000000000000004 R14: 0000000000000001 R15: 000000000075bfd4
INFO: task syz-executor.1:5948 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D28160  5948   9197 0x80004002
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  tty_release_struct+0x31/0x50 drivers/tty/tty_io.c:1628
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a9e9
Code: bd 4c 00 00 b9 00 00 40 00 e8 b3 4c 00 00 90 cc cc 64 48 8b 0c 25 f8  
ff ff ff 48 3b 61 10 0f 86 ff 00 00 00 48 83 ec 40 48 89 <6c> 24 38 48 8d  
6c 24 38 48 8b 42 08 48 89 44 24 30 84 00 48 8b 4a
RSP: 002b:0000000000a6fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 000000000045a9e9
RDX: 00000000004144c1 RSI: 0000000000a770d0 RDI: 0000000000000000
RBP: 00000000004c0308 R08: 000000000000000c R09: 0000000000a6fbf0
R10: 00000000021af940 R11: 0000000000000246 R12: 000000000075bfc8
R13: 0000000000000003 R14: 0000000000000001 R15: 000000000075bfd4
INFO: task syz-executor.5:5962 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28160  5962   9207 0x80004002
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  tty_release_struct+0x31/0x50 drivers/tty/tty_io.c:1628
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a9e9
Code: bd 4c 00 00 b9 00 00 40 00 e8 b3 4c 00 00 90 cc cc 64 48 8b 0c 25 f8  
ff ff ff 48 3b 61 10 0f 86 ff 00 00 00 48 83 ec 40 48 89 <6c> 24 38 48 8d  
6c 24 38 48 8b 42 08 48 89 44 24 30 84 00 48 8b 4a
RSP: 002b:0000000000a6fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 000000000045a9e9
RDX: 00000000004144c1 RSI: 0000000000a770d0 RDI: 0000000000000000
RBP: 00000000004c0308 R08: 000000000000000c R09: 0000000000a6fbf0
R10: 0000000001c44940 R11: 0000000000000246 R12: 000000000075bfc8
R13: 0000000000000003 R14: 0000000000000001 R15: 000000000075bfd4
INFO: task syz-executor.2:6670 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D28552  6670   9201 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  tty_open_by_driver drivers/tty/tty_io.c:1951 [inline]
  tty_open+0x3cb/0xbb0 drivers/tty/tty_io.c:2035
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3420 [inline]
  path_openat+0x10df/0x4500 fs/namei.c:3537
  do_filp_open+0x1a1/0x280 fs/namei.c:3567
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x414781
Code: 48 0f af de 48 8d 04 13 4c 89 d2 48 89 f3 eb 97 49 89 ca 31 f6 48 89  
d0 eb ee 48 8b 1d 78 51 7b 01 84 03 48 8b 14 d3 48 85 d2 <74> 1d 48 89 c3  
48 c1 e8 0d 48 25 ff 1f 00 00 48 8b 8c c2 00 00 20
RSP: 002b:00007fb9ea1627a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000414781
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007fb9ea1627d0
RBP: 000000000075bf20 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007fb9ea1636d4
R13: 00000000004cb2f9 R14: 00000000004e4b10 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1116:
  #0: ffffffff899a5680 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/9065:
  #0: ffff8880a6456120 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/9155:
  #0: ffff8880a3122090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000171b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9156:
  #0: ffff888095638090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900016ab2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9157:
  #0: ffff8880a25db090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000168b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9158:
  #0: ffff888094735090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000174b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9159:
  #0: ffff8880a4a8d090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000173b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9160:
  #0: ffff88809820d090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000172b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9161:
  #0: ffff888098d34090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900011102e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.2/16901:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_release_struct+0x31/0x50  
drivers/tty/tty_io.c:1628
1 lock held by syz-executor.3/5749:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_release_struct+0x31/0x50  
drivers/tty/tty_io.c:1628
1 lock held by syz-executor.1/5948:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_release_struct+0x31/0x50  
drivers/tty/tty_io.c:1628
1 lock held by syz-executor.5/5962:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_release_struct+0x31/0x50  
drivers/tty/tty_io.c:1628
2 locks held by syz-executor.4/6053:
1 lock held by syz-executor.2/6670:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.1/7297:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.1/7299:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.1/7300:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.1/7303:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.1/7308:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/7315:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/7320:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/7321:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/7334:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/7336:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.5/7319:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.5/7323:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.5/7326:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1116 Comm: khungtaskd Not tainted 5.5.0-rc4-syzkaller #0
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
CPU: 0 PID: 6053 Comm: syz-executor.4 Not tainted 5.5.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_cmp4+0xd/0x20 kernel/kcov.c:248
Code: d6 0f b7 f7 bf 02 00 00 00 48 89 e5 48 8b 4d 08 e8 58 ff ff ff 5d c3  
66 0f 1f 44 00 00 55 89 f2 89 fe bf 04 00 00 00 48 89 e5 <48> 8b 4d 08 e8  
3a ff ff ff 5d c3 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0018:ffffc900077f7398 EFLAGS: 00000286
RAX: 0000000000040000 RBX: 0000000000000050 RCX: ffffc90012dbb000
RDX: 000000000000001e RSI: 0000000000000050 RDI: 0000000000000004
RBP: ffffc900077f7398 R08: ffff88805b088500 R09: ffffed1043195044
R10: ffffed1043195043 R11: ffff888218ca821f R12: 000000000000001e
R13: ffff8880000a001e R14: ffff8880000a0000 R15: 0000000000000000
FS:  00007fa5c7d87700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c010c40870 CR3: 00000000a3b19000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vga16fb_fillrect+0xa20/0x19b0 drivers/video/fbdev/vga16fb.c:922
  bit_clear_margins+0x30b/0x530 drivers/video/fbdev/core/bitblit.c:232
  fbcon_clear_margins+0x1e9/0x250 drivers/video/fbdev/core/fbcon.c:1372
  fbcon_switch+0xd7f/0x17f0 drivers/video/fbdev/core/fbcon.c:2354
  redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:997
  fbcon_modechanged+0x5c3/0x790 drivers/video/fbdev/core/fbcon.c:2991
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a9e9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa5c7d86c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a9e9
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa5c7d876d4
R13: 00000000004c3208 R14: 00000000004d8678 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
