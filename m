Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52274C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13807207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgAGIRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:17:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42248 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgAGIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:17:10 -0500
Received: by mail-io1-f69.google.com with SMTP id e7so32727250iog.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CF1DtUbvl3NqIQHwWCotHa59pd40wisr48XJ0Z4KZ7s=;
        b=NRIctQ6Y01crALQ6q/a2GOFMVKnjXXuancLX9pRmn09wy+IMa9NJuTYptBzObNi/wO
         Mys0mB+EJB+mhM7cDYpzBx5saoPhvaLEg0yO4VzUC1BLr2rn04JdxQdpmRhtXG/fkYTR
         ohxJht2m3x31TErhmj74fn3gSD2zSYzGAyigRWRURzSNj0iG1R8HaXX/NugXmwtFRBOU
         FWkREpNfDxf/wBg3lFahsawctFsuuRRsSbVTxfkzAy9DUHtOQW/L7zxPn+WeiNzuCmOu
         WOmtRx45mQG7WX9wjrjVSh/Iw2LgdDR5xZMx6dGhLk+RZ+tzp5nHplaHK0OuqBOiVLS1
         kVIA==
X-Gm-Message-State: APjAAAW3hdS4NrDH43bdm5LVBxKvWlG9U98o9SoZMtrtvnytvlK6Z8pX
        s/qt2ISsitZcnxipebhaeYhaF0EDsLDRbl2Ef+4CHKVNZ0TO
X-Google-Smtp-Source: APXvYqywoUBzH+xwG38s/p9kdXwe9hW14P6V3xEZhhojFC3BPUjV6R/Ulaj3SHgTjwqBa2/cPhr/XioPs7dwpEPC6Kh0+FfZYNkP
MIME-Version: 1.0
X-Received: by 2002:a02:8587:: with SMTP id d7mr82407375jai.39.1578385029689;
 Tue, 07 Jan 2020 00:17:09 -0800 (PST)
Date:   Tue, 07 Jan 2020 00:17:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000037cd5059b8867f8@google.com>
Subject: INFO: task hung in con_install
From:   syzbot <syzbot+370b0e19c5405cfd7173@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1170c085e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=874bac2ff63646fa
dashboard link: https://syzkaller.appspot.com/bug?extid=370b0e19c5405cfd7173
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+370b0e19c5405cfd7173@syzkaller.appspotmail.com

INFO: task syz-executor.4:30304 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D28552 30304   9223 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  __down_common kernel/locking/semaphore.c:220 [inline]
  __down+0x176/0x2c0 kernel/locking/semaphore.c:237
  down+0x64/0x90 kernel/locking/semaphore.c:61
  console_lock+0x29/0x80 kernel/printk/printk.c:2289
  con_install+0x4a/0x410 drivers/tty/vt/vt.c:3228
  tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
  tty_init_dev drivers/tty/tty_io.c:1341 [inline]
  tty_init_dev+0xf9/0x470 drivers/tty/tty_io.c:1318
  tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
  tty_open+0x4a5/0xbb0 drivers/tty/tty_io.c:2035
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
RIP: 0033:0x4146b1
Code: 18 48 8d 6c 24 18 48 8d 05 3c 2b 04 00 48 89 44 24 08 48 8b 44 24 28  
48 89 44 24 10 48 8d 44 24 08 48 89 04 24 e8 4f 57 04 00 <48> 8b 6c 24 18  
48 83 c4 20 c3 e8 90 58 04 00 eb ae cc cc cc cc cc
RSP: 002b:00007fd6e11307a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004146b1
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007fd6e11307d0
RBP: 000000000075bf20 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007fd6e11316d4
R13: 00000000004cb17d R14: 00000000004e4888 R15: 00000000ffffffff
INFO: task syz-executor.1:30305 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D28552 30305   9214 0x00004004
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
RIP: 0033:0x4146b1
Code: 18 48 8d 6c 24 18 48 8d 05 3c 2b 04 00 48 89 44 24 08 48 8b 44 24 28  
48 89 44 24 10 48 8d 44 24 08 48 89 04 24 e8 4f 57 04 00 <48> 8b 6c 24 18  
48 83 c4 20 c3 e8 90 58 04 00 eb ae cc cc cc cc cc
RSP: 002b:00007fd548a717a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004146b1
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007fd548a717d0
RBP: 000000000075bf20 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007fd548a726d4
R13: 00000000004cb17d R14: 00000000004e4888 R15: 00000000ffffffff
INFO: task syz-executor.3:30397 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D28552 30397   9220 0x00004004
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
RIP: 0033:0x4146b1
Code: 18 48 8d 6c 24 18 48 8d 05 3c 2b 04 00 48 89 44 24 08 48 8b 44 24 28  
48 89 44 24 10 48 8d 44 24 08 48 89 04 24 e8 4f 57 04 00 <48> 8b 6c 24 18  
48 83 c4 20 c3 e8 90 58 04 00 eb ae cc cc cc cc cc
RSP: 002b:00007efd38a3e7a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004146b1
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007efd38a3e7d0
RBP: 000000000075bf20 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007efd38a3f6d4
R13: 00000000004cb17d R14: 00000000004e4888 R15: 00000000ffffffff
INFO: task syz-executor.3:30508 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D28304 30508   9220 0x00000004
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
RIP: 0033:0x4146b1
Code: 18 48 8d 6c 24 18 48 8d 05 3c 2b 04 00 48 89 44 24 08 48 8b 44 24 28  
48 89 44 24 10 48 8d 44 24 08 48 89 04 24 e8 4f 57 04 00 <48> 8b 6c 24 18  
48 83 c4 20 c3 e8 90 58 04 00 eb ae cc cc cc cc cc
RSP: 002b:00007efd38a1d7a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004146b1
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007efd38a1d7d0
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007efd38a1e6d4
R13: 00000000004cb17d R14: 00000000004e4888 R15: 00000000ffffffff
INFO: task syz-executor.5:30847 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28552 30847   7317 0x00004004
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
RIP: 0033:0x4146b1
Code: 18 48 8d 6c 24 18 48 8d 05 3c 2b 04 00 48 89 44 24 08 48 8b 44 24 28  
48 89 44 24 10 48 8d 44 24 08 48 89 04 24 e8 4f 57 04 00 <48> 8b 6c 24 18  
48 83 c4 20 c3 e8 90 58 04 00 eb ae cc cc cc cc cc
RSP: 002b:00007f2455ce37a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004146b1
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007f2455ce37d0
RBP: 000000000075bf20 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007f2455ce46d4
R13: 00000000004cb067 R14: 00000000004e4738 R15: 00000000ffffffff
INFO: task syz-executor.5:30861 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28240 30861   7317 0x00000004
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
RIP: 0033:0x4146b1
Code: 18 48 8d 6c 24 18 48 8d 05 3c 2b 04 00 48 89 44 24 08 48 8b 44 24 28  
48 89 44 24 10 48 8d 44 24 08 48 89 04 24 e8 4f 57 04 00 <48> 8b 6c 24 18  
48 83 c4 20 c3 e8 90 58 04 00 eb ae cc cc cc cc cc
RSP: 002b:00007f2455cc27a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004146b1
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007f2455cc27d0
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000064 R11: 0000000000000293 R12: 00007f2455cc36d4
R13: 00000000004cb067 R14: 00000000004e4738 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1112:
  #0: ffffffff899a5680 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/9080:
  #0: ffff888098d8ab20 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/9171:
  #0: ffff888093c28090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000175b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9172:
  #0: ffff8880a8e31090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000173b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9173:
  #0: ffff88809655b090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000176b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9174:
  #0: ffff8880a2d99090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900016cb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9175:
  #0: ffff8880a2ff4090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000174b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9176:
  #0: ffff8882156f2090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900011202e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/7654:
  #0: ffff88805c8ef090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900078932e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by syz-executor.4/30304:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
  #1: ffff88809fb0d198 (&tty->legacy_mutex){+.+.}, at: tty_lock+0xc7/0x130  
drivers/tty/tty_mutex.c:19
1 lock held by syz-executor.2/30294:
1 lock held by syz-executor.1/30305:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/30397:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.3/30508:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.5/30847:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035
1 lock held by syz-executor.5/30861:
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open_by_driver  
drivers/tty/tty_io.c:1951 [inline]
  #0: ffffffff89eceb20 (tty_mutex){+.+.}, at: tty_open+0x3cb/0xbb0  
drivers/tty/tty_io.c:2035

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1112 Comm: khungtaskd Not tainted 5.5.0-rc4-syzkaller #0
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
CPU: 1 PID: 30294 Comm: syz-executor.2 Not tainted 5.5.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x1/0x50 kernel/kcov.c:180
Code: cc cc cc cc cc cc cc cc cc 65 48 8b 04 25 c0 1e 02 00 48 8b 80 98 13  
00 00 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 <48> 89 e5 65 48  
8b 04 25 c0 1e 02 00 65 8b 15 84 f0 8c 7e 81 e2 00
RSP: 0018:ffffc900071375c0 EFLAGS: 00000246
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff83b4fb70
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc90007137610 R08: ffff88805bfc80c0 R09: 0000000000000040
R10: fffffbfff14f33af R11: ffffffff8a799d7b R12: 0000000000001400
R13: 0000000000000040 R14: ffff8880000a0000 R15: 0000000000000000
FS:  00007f8228648700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bedbd8000 CR3: 00000000a28f9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  cfb_fillrect+0x423/0x7c0 drivers/video/fbdev/core/cfbfillrect.c:327
  vga16fb_fillrect+0x6ce/0x19b0 drivers/video/fbdev/vga16fb.c:951
  bit_clear_margins+0x30b/0x530 drivers/video/fbdev/core/bitblit.c:232
  fbcon_clear_margins+0x1e9/0x250 drivers/video/fbdev/core/fbcon.c:1372
  fbcon_do_set_font+0x81f/0x960 drivers/video/fbdev/core/fbcon.c:2604
  fbcon_set_font+0x72e/0x860 drivers/video/fbdev/core/fbcon.c:2696
  con_font_set drivers/tty/vt/vt.c:4538 [inline]
  con_font_op+0xe30/0x1270 drivers/tty/vt/vt.c:4603
  vt_ioctl+0xd2e/0x26d0 drivers/tty/vt/vt_ioctl.c:913
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
RIP: 0033:0x45a919
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8228647c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a919
RDX: 0000000020000100 RSI: 0000000000004b61 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82286486d4
R13: 00000000004c5c8b R14: 00000000004dc080 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
