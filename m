Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7695C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B0724670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLGRZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:25:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:46328 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfLGRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:25:10 -0500
Received: by mail-il1-f199.google.com with SMTP id s85so7965256ild.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 09:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xLP8G6QTOrxF3cZLHOdxhoMT8wRTn4AVg54Rs59OOgA=;
        b=SiJGncozKHB2WPgtHKP3y4oUy6GLMGipuweh1ULTtffO6tlp8RAXfPx7M85cwqcXgB
         JcEfvSYQztyrxE0RH7Y7JHALXFM3KO8r43kXwlZdNq3T4XA+Z+U6DiJEGehA/9d2kUAT
         rJWRWUgePNO0m/8J2UJ5DwV84xji4EbTV2158eiw+T9rM+QvH+KRMqepAAjiDKOF2Z0k
         nGYmu/ybIYlz9RScybd0WU10ULk3QaeHxGJqotVc5RiZjHZ5LJq8CRCZlmRup7aN2alY
         3XSiB58EyT5pnPnW2LPKD0u7HPVy6O9iVh/PaWDi3Z0fvVEqi3DD9guHpR+VINHPdTxh
         svug==
X-Gm-Message-State: APjAAAWgMqi9V7jDmyEqWui0XEQPYvr1kkwYSuaSwhBtPirGObGpmB+5
        cUOTOxcQtRlhMFgvkMxXrN/POT97JdxdqMpsBPfaoiTKuRMT
X-Google-Smtp-Source: APXvYqwzUsYz2Re0zEZVbYDepM9BU5SDYtYC0J8qOECtKuSF6N2vzvRUL6ApetrDkf5817zfmQUBBSS0+kNsV+Mkiey9ItcTvz81
MIME-Version: 1.0
X-Received: by 2002:a92:45d2:: with SMTP id z79mr20306288ilj.76.1575739509264;
 Sat, 07 Dec 2019 09:25:09 -0800 (PST)
Date:   Sat, 07 Dec 2019 09:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b55d8805992071b5@google.com>
Subject: INFO: task hung in tty_ldisc_hangup
From:   syzbot <syzbot+3105793febc8f3e591ce@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ada90eb Merge tag 'drm-next-2019-12-06' of git://anongit...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13725446e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=3105793febc8f3e591ce
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118ae77ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142ffc32e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120c41dae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=160c41dae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3105793febc8f3e591ce@syzkaller.appspotmail.com

INFO: task login:10239 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
login           D27648 10239      1 0x80000002
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  down_write_failed drivers/tty/tty_ldsem.c:262 [inline]
  __ldsem_down_write_nested+0x3b2/0x8f0 drivers/tty/tty_ldsem.c:324
  ldsem_down_write+0x33/0x40 drivers/tty/tty_ldsem.c:366
  __tty_ldisc_lock drivers/tty/tty_ldisc.c:315 [inline]
  tty_ldisc_lock+0x66/0xb0 drivers/tty/tty_ldisc.c:339
  tty_ldisc_hangup+0x1c6/0x640 drivers/tty/tty_ldisc.c:745
  __tty_hangup.part.0+0x2fb/0x750 drivers/tty/tty_io.c:625
  __tty_hangup drivers/tty/tty_io.c:575 [inline]
  tty_vhangup_session+0x25/0x30 drivers/tty/tty_io.c:735
  disassociate_ctty.part.0+0xb4/0x740 drivers/tty/tty_jobctrl.c:267
  disassociate_ctty+0x81/0xa0 drivers/tty/tty_jobctrl.c:261
  do_exit+0x1b42/0x2ef0 kernel/exit.c:795
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f0f83c781e8
Code: Bad RIP value.
RSP: 002b:00007ffd44a828e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0f83c781e8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007f0f83f4d840 R08: 00000000000000e7 R09: ffffffffffffffa8
R10: 00007f0f83f53740 R11: 0000000000000246 R12: 00007f0f83f4d840
R13: 0000000000000001 R14: 0000000000000001 R15: 000000000060b798

Showing all locks held in the system:
1 lock held by khungtaskd/1104:
  #0: ffffffff899a4280 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/9591:
  #0: ffff888098116b60 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/9714:
  #0: ffff88808ec58090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018e32e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9715:
  #0: ffff8880a7428090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900019632e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9716:
  #0: ffff8880a8e92090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900019032e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9717:
  #0: ffff888093f73090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900019532e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9718:
  #0: ffff888098ddf090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900019432e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9719:
  #0: ffff8880a72d4090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018a32e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by login/10239:
  #0: ffff88809b2d2198 (&tty->legacy_mutex){+.+.}, at: tty_lock+0xc7/0x130  
drivers/tty/tty_mutex.c:19
  #1: ffff88809b2d2090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_write+0x33/0x40 drivers/tty/tty_ldsem.c:366
2 locks held by syz-executor540/10274:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1104 Comm: khungtaskd Not tainted 5.4.0-syzkaller #0
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
CPU: 0 PID: 10274 Comm: syz-executor540 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:preempt_count_add+0x22/0x160 kernel/sched/core.c:3779
Code: 0f 1f 84 00 00 00 00 00 48 c7 c0 e0 24 63 8b 55 48 ba 00 00 00 00 00  
fc ff df 48 89 c1 48 89 e5 41 54 83 e0 07 48 c1 e9 03 53 <83> c0 03 89 fb  
0f b6 14 11 38 d0 7c 08 84 d2 0f 85 00 01 00 00 8b
RSP: 0018:ffffc90003247628 EFLAGS: 00000806
RAX: 0000000000000000 RBX: ffffc900032476a8 RCX: 1ffffffff16c649c
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90003247638 R08: 1ffff11015d07044 R09: ffffed1015d07045
R10: ffffed1015d07044 R11: ffff8880ae838223 R12: ffff8880ae837400
R13: ffffffff899c3620 R14: ffff8880906b4180 R15: 000000000000106e
FS:  0000000001203880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 0000000097677000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rcu_lockdep_current_cpu_online kernel/rcu/tree.c:969 [inline]
  rcu_lockdep_current_cpu_online+0x34/0x130 kernel/rcu/tree.c:961
  rcu_read_lock_held_common kernel/rcu/update.c:109 [inline]
  rcu_read_lock_held_common+0xbd/0x130 kernel/rcu/update.c:99
  rcu_read_lock_held+0x5b/0xb0 kernel/rcu/update.c:281
  task_css_set include/linux/cgroup.h:478 [inline]
  task_dfl_cgroup include/linux/cgroup.h:547 [inline]
  cgroup_account_cputime include/linux/cgroup.h:776 [inline]
  update_curr+0x693/0x8d0 kernel/sched/fair.c:860
  pick_next_task_fair+0x221/0xc70 kernel/sched/fair.c:6680
  pick_next_task kernel/sched/core.c:3921 [inline]
  __schedule+0x375/0x1f90 kernel/sched/core.c:4051
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
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
RIP: 0033:0x441219
Code: e8 3c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffbf09e3f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441219
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000004
RBP: 000000000008ba8c R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402040
R13: 00000000004020d0 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
