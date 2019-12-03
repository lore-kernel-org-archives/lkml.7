Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73732C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAB9206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLCUPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:15:14 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36394 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLCUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:15:12 -0500
Received: by mail-io1-f72.google.com with SMTP id 202so3318217iou.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CwLSfE/Y1vBL15GsZLjJiZpTfs2T+fihUXimA9es2g0=;
        b=LYy/ZywilOL+8H949ebr/ljreg5K/lxDRgryKRTZE1qwGHiurBx85o/HI5SpkSyBta
         0B3o4GIDn0NrgqG2sTqRR9HkiztgNxiEYSusnlsjiSQ1F7CtlX4FQ25EuOTsmnvwRS2T
         f6lQ9bIUT3D5Ds+X80KspfB5fSvLGsPvnZpFpR1/c8d4k+gqFAqsT+NL1mmP3yfjuBrM
         HURkeyW4AirKUZ9cTJdyaLJ5VawVXnuxQhM0ySfnMM/EmTxW6CqEEGsXQ3cio5/abPG5
         +JBrZ7Eq9AepEJw+fabfGrFvFhW525Q4eJVA/87ByWNP014H2upZDimGNmPHkvUF5YLO
         BqHw==
X-Gm-Message-State: APjAAAUPdTlqRinizyeDFhlkFjaJCjSWQHeWqpe257jf3pFsWukcqaAR
        jXcSrnfkLGNJ2EUKc+vUi4q6SbDvC7cWMqSy+RU+rGnyMTFj
X-Google-Smtp-Source: APXvYqy/pBJzkX0cuJoHDDpVVYbogDEfJdh0sIn6vOdofFp5iUYIB3wVptYmnnWs/UuAkXkJKfccS5v0eSRGcXpgBDqc6faMXKOa
MIME-Version: 1.0
X-Received: by 2002:a5d:9eda:: with SMTP id a26mr3911109ioe.238.1575404111262;
 Tue, 03 Dec 2019 12:15:11 -0800 (PST)
Date:   Tue, 03 Dec 2019 12:15:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dff110598d25a9b@google.com>
Subject: INFO: task hung in fb_open
From:   syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, kraxel@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, peda@axentia.se,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1599f641e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
dashboard link: https://syzkaller.appspot.com/bug?extid=a4ae1442ccc637162dc1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com

INFO: task syz-executor823:8749 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor823 D28160  8749   8748 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_openat fs/open.c:1124 [inline]
  __se_sys_openat fs/open.c:1118 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1118
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441419
Code: Bad RIP value.
RSP: 002b:00007fffaaef6f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441419
RDX: 0000000000000000 RSI: 0000000020000840 RDI: ffffffffffffff9c
RBP: 00000000006cb018 R08: 0000000000000004 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor823:8750 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor823 D28160  8750   8747 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_openat fs/open.c:1124 [inline]
  __se_sys_openat fs/open.c:1118 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1118
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441419
Code: Bad RIP value.
RSP: 002b:00007fffaaef6f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441419
RDX: 0000000000000000 RSI: 0000000020000840 RDI: ffffffffffffff9c
RBP: 00000000006cb018 R08: 0000000000000004 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor823:8751 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor823 D28160  8751   8745 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_openat fs/open.c:1124 [inline]
  __se_sys_openat fs/open.c:1118 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1118
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441419
Code: Bad RIP value.
RSP: 002b:00007fffaaef6f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441419
RDX: 0000000000000000 RSI: 0000000020000840 RDI: ffffffffffffff9c
RBP: 00000000006cb018 R08: 0000000000000004 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor823:8752 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor823 D27992  8752   8743 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_openat fs/open.c:1124 [inline]
  __se_sys_openat fs/open.c:1118 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1118
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441419
Code: Bad RIP value.
RSP: 002b:00007fffaaef6f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441419
RDX: 0000000000000000 RSI: 0000000020000840 RDI: ffffffffffffff9c
RBP: 00000000006cb018 R08: 0000000000000004 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor823:8753 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor823 D28160  8753   8746 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_openat fs/open.c:1124 [inline]
  __se_sys_openat fs/open.c:1118 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1118
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441419
Code: Bad RIP value.
RSP: 002b:00007fffaaef6f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441419
RDX: 0000000000000000 RSI: 0000000020000840 RDI: ffffffffffffff9c
RBP: 00000000006cb018 R08: 0000000000000004 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1105:
  #0: ffffffff897a4240 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/8626:
  #0: ffff888099d3e860 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8716:
  #0: ffff888090469090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000178b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8717:
  #0: ffff888096224090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017eb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8718:
  #0: ffff888095f16090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000174b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8719:
  #0: ffff8880a7b99090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017bb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8720:
  #0: ffff8880a8021090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000177b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8721:
  #0: ffff8880a8ac3090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017db2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8722:
  #0: ffff8880a7a59090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000172b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by syz-executor823/8744:
1 lock held by syz-executor823/8749:
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450  
drivers/video/fbdev/core/fbmem.c:1406
1 lock held by syz-executor823/8750:
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450  
drivers/video/fbdev/core/fbmem.c:1406
1 lock held by syz-executor823/8751:
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450  
drivers/video/fbdev/core/fbmem.c:1406
1 lock held by syz-executor823/8752:
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450  
drivers/video/fbdev/core/fbmem.c:1406
1 lock held by syz-executor823/8753:
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff8880a3d59070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450  
drivers/video/fbdev/core/fbmem.c:1406

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1105 Comm: khungtaskd Not tainted 5.4.0-syzkaller #0
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
CPU: 0 PID: 8744 Comm: syz-executor823 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x20/0x50 kernel/kcov.c:102
Code: ff cc cc cc cc cc cc cc cc cc 55 48 89 e5 65 48 8b 04 25 c0 1e 02 00  
65 8b 15 f4 23 8d 7e 81 e2 00 01 1f 00 48 8b 75 08 75 2b <8b> 90 80 13 00  
00 83 fa 02 75 20 48 8b 88 88 13 00 00 8b 80 84 13
RSP: 0018:ffffc90001e072c8 EFLAGS: 00000246
RAX: ffff8880a5382000 RBX: 0000000000000000 RCX: ffffffff83b3479d
RDX: 0000000000000000 RSI: ffffffff83b34766 RDI: 0000000000000005
RBP: ffffc90001e072c8 R08: ffff8880a5382000 R09: 0000000000000040
R10: ffffed10147a952b R11: ffff8880a3d4a95f R12: 0000000000000050
R13: 0000000000000048 R14: ffff8880000a0000 R15: ffff8880000a0040
FS:  0000000000cbb880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 0000000098fe3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:64 [inline]
  bitfill_aligned+0x106/0x210 drivers/video/fbdev/core/cfbfillrect.c:35
  cfb_fillrect+0x423/0x7c0 drivers/video/fbdev/core/cfbfillrect.c:327
  vga16fb_fillrect+0x6ce/0x19b0 drivers/video/fbdev/vga16fb.c:951
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
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:726
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:748
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441419
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffaaef6f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441419
RDX: 0000000020000180 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
