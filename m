Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC10C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B5521655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfLLJcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:32:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43086 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfLLJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:32:10 -0500
Received: by mail-il1-f197.google.com with SMTP id j17so1163173ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RjslYRUOo0q0rMudk1+FiH7RsU98uAOL3OhEFinj1oY=;
        b=QPphFVcD3bIJgFiup5t/9O5+J30vcf1ajAVFoPfPnRwAwZiNvJnjr26kpQnUb9VQNo
         lM84ieBC1t84MImDyadCwecSy51NPCWwPocdi1qADLDecQ8F+0eNaDwfBYbrk4QABYyE
         c4Y00Hcp/wwSaID1MkLtQ2BtNcCz+eJ5JmumulqxbN2CQgYr3R63Q3CX0CjyCZ0DWB69
         tjIDilqpxSGLaXdY3i3FFYO25J7n6vG4TzLQFeHM8ct07vX2ILuC/G1yAhzjpklHz13v
         QVoehcYW690mVPXvFzkkF7FohTmevuKDqJLXbBd6tnrhyAZzifKrQPSJ4i/dtmN6B7+W
         9vSA==
X-Gm-Message-State: APjAAAUq3O8G8Mx8sbR48dImPgI4DIfxxuWIIJlOs6jmoqlRlJB2ET/N
        6SdaexMZoK/0K886YGYSicPrrhn5X2SCsOlYAb6sXeYCh2uz
X-Google-Smtp-Source: APXvYqyy9sfbAApHrwsa7prbwPxboPY45cld365wgzC124ILrQJMU3GCwjQub/cqvzght82mHWWc5YHnvqJ9ibaurri1V3GTBzl2
MIME-Version: 1.0
X-Received: by 2002:a5d:9596:: with SMTP id a22mr2152416ioo.143.1576143129444;
 Thu, 12 Dec 2019 01:32:09 -0800 (PST)
Date:   Thu, 12 Dec 2019 01:32:09 -0800
In-Reply-To: <0000000000003a2af3059905d1dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000588ca705997e6be4@google.com>
Subject: Re: INFO: task hung in paste_selection
From:   syzbot <syzbot+a172213a651850d94cf2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    687dec9b Merge tag 'erofs-for-5.5-rc2-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107fee46e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=a172213a651850d94cf2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108cc589e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151c7646e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a172213a651850d94cf2@syzkaller.appspotmail.com

INFO: task syz-executor608:13178 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor608 D28160 13178   8968 0x00004004
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
RIP: 0033:0x441319
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdacd52ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000004
RBP: 000000000007f769 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor608:13179 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor608 D28160 13179   8970 0x00004004
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
RIP: 0033:0x441319
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdacd52ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000004
RBP: 000000000007f777 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor608:13180 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor608 D28160 13180   8964 0x00004004
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
RIP: 0033:0x441319
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdacd52ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000004
RBP: 000000000007f781 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor608:13181 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor608 D28160 13181   8965 0x00004004
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
RIP: 0033:0x441319
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdacd52ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000004
RBP: 000000000007f780 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor608:13182 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor608 D28160 13182   8967 0x00004004
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
RIP: 0033:0x441319
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdacd52ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000004
RBP: 000000000007f78a R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1108:
  #0: ffffffff899a56c0 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/8846:
  #0: ffff88809ae4bae0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
5 locks held by getty/8936:
2 locks held by getty/8937:
  #0: ffff888099c1d090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000184b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8938:
  #0: ffff88809f500090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000183b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8939:
  #0: ffff888095772090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000182b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8940:
  #0: ffff8880a6d4b090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017bb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8941:
  #0: ffff8880a93c3090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000181b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8942:
  #0: ffff8880a4853090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000178b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by syz-executor608/13177:
2 locks held by syz-executor608/13178:
  #0: ffff888094651090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
2 locks held by syz-executor608/13179:
  #0: ffff888094651090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
2 locks held by syz-executor608/13180:
  #0: ffff888094651090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
2 locks held by syz-executor608/13181:
  #0: ffff888094651090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
2 locks held by syz-executor608/13182:
  #0: ffff888094651090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1108 Comm: khungtaskd Not tainted 5.5.0-rc1-syzkaller #0
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
CPU: 1 PID: 8936 Comm: getty Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:reschedule_interrupt+0x0/0x20 arch/x86/entry/entry_64.S:853
Code: 66 2e 0f 1f 84 00 00 00 00 00 68 03 ff ff ff e8 b6 f0 ff ff e8 41 24  
00 00 e9 ab f1 ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 <68> 02 ff ff ff  
e8 96 f0 ff ff e8 61 1f 00 00 e9 8b f1 ff ff 66 90
RSP: 0018:ffffc90001d27788 EFLAGS: 00000082
RAX: 1ffffffff13266ad RBX: ffff8880a6e30600 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8880a6e30e94
RBP: ffffc90001d277b8 R08: 1ffffffff1659db5 R09: fffffbfff1659db6
R10: fffffbfff1659db5 R11: ffffffff8b2cedaf R12: ffff8880ae937340
R13: ffff88808e9f2580 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f428f28f700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f428f294000 CR3: 00000000a7e2d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  finish_lock_switch kernel/sched/core.c:3124 [inline]
  finish_task_switch+0x147/0x750 kernel/sched/core.c:3224
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x93c/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  __down_common kernel/locking/semaphore.c:220 [inline]
  __down+0x176/0x2c0 kernel/locking/semaphore.c:237
  down+0x64/0x90 kernel/locking/semaphore.c:61
  console_lock+0x29/0x80 kernel/printk/printk.c:2289
  con_flush_chars drivers/tty/vt/vt.c:3212 [inline]
  con_flush_chars drivers/tty/vt/vt.c:3204 [inline]
  con_write+0x83/0xd0 drivers/tty/vt/vt.c:3136
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f428ebba370
Code: 73 01 c3 48 8b 0d c8 4a 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb  
ea 90 90 83 3d 85 a2 2b 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 0e 8a 01 00 48 89 04 24
RSP: 002b:00007ffc758b2218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f428ebba370
RDX: 0000000000000001 RSI: 00007f428ee6f823 RDI: 0000000000000001
RBP: 00007f428ee6f823 R08: 0000000000000065 R09: 00007f428f28f700
R10: 0000000000000022 R11: 0000000000000246 R12: 00007f428ee6f7a0
R13: 0000000000000001 R14: 00000000004059fb R15: 00007ffc758b2514

