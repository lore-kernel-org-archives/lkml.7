Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27305C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D740921823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfLFJfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:35:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52796 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:35:10 -0500
Received: by mail-io1-f72.google.com with SMTP id e124so4405814iof.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1M7kkxJiaPihCnJ43F4oWX8v2NNv/A9GhMtoRhF2bZk=;
        b=ocT0bmRQpui0EisBv5AsowmFqaFTqQYabqmhHtXHFJgjw3Iu/ctxnxfv3mpQjTqiHz
         0jiAUfYGCd6EVDg9O8SvOClBRru1r36HVXFEEuef7Sej3kjoSx8F8Sb0Rc7sX+ZGFImx
         LPrFfny4pMO1+DZ7yuUPBJQMT4m6RlvNmdR46DIsK1kForIkmn2riS0v9Zvjq8cZdulM
         /FQ1Zkr/mGeyk+D21e1rkjpxFS5gLcREIIXWQerdwwmZHscAcnnwsLarXK/ET6rnDlfU
         j8j3T9D/fqTCJ4LZ6fEXPsa2vlQ5CfURqBn4MLcgoNHgAz/j3tmi+GMRn8UcbuEYct0a
         Me0Q==
X-Gm-Message-State: APjAAAVOysYZ9sa38aFCX8tuL4bewBt7XUbSzmQVa/KVv1trN9MINhMS
        sgKcIuhINQaad0zPBldKL0bM6JGjcLytzH5MVlf0TDt3de06
X-Google-Smtp-Source: APXvYqysOHVqt4rehXIykLvUMMAZs7COs/8tM3Rt3cgpfrzj5Iw3slLUqEVzZCaCccnETh9G/N4A/wOqIJ+Rz78Q9XXeRiipAwgn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:280e:: with SMTP id d14mr9383723ioe.249.1575624908890;
 Fri, 06 Dec 2019 01:35:08 -0800 (PST)
Date:   Fri, 06 Dec 2019 01:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe6c39059905c289@google.com>
Subject: INFO: task hung in flush_to_ldisc
From:   syzbot <syzbot+e199b43b49192126ff69@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63de3747 Merge tag 'tag-chrome-platform-for-v5.5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e7d59ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d189d07c6717979
dashboard link: https://syzkaller.appspot.com/bug?extid=e199b43b49192126ff69
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e199b43b49192126ff69@syzkaller.appspotmail.com

INFO: task kworker/u4:0:7 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:0    D24280     7      2 0x80004000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  flush_to_ldisc+0x3d/0x390 drivers/tty/tty_buffer.c:505
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task login:9555 blocked for more than 143 seconds.
       Not tainted 5.4.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
login           D23224  9555      1 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  __flush_work+0x4fe/0xa50 kernel/workqueue.c:3041
  flush_work+0x18/0x20 kernel/workqueue.c:3062
  tty_buffer_flush_work+0x16/0x20 drivers/tty/tty_buffer.c:618
  n_tty_read+0xb1c/0x1c10 drivers/tty/n_tty.c:2199
  tty_read+0x1a0/0x2a0 drivers/tty/tty_io.c:869
  __vfs_read+0x8a/0x110 fs/read_write.c:425
  vfs_read+0x1f0/0x440 fs/read_write.c:461
  ksys_read+0x14f/0x290 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read fs/read_write.c:595 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:595
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f9a079ec310
Code: Bad RIP value.
RSP: 002b:00007ffd2af2dca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9a079ec310
RDX: 00000000000001ff RSI: 00007ffd2af2df10 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00007f9a082cf700 R09: 0000000000000000
R10: 00007ffd2af2dc60 R11: 0000000000000246 R12: 00007ffd2af2df10
R13: 0000000000000000 R14: 0000000000000001 R15: 000000000060b798

Showing all locks held in the system:
3 locks held by kworker/u4:0/7:
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
set_work_data kernel/workqueue.c:615 [inline]
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
  #0: ffff8880aa433928 ((wq_completion)events_unbound){+.+.}, at:  
process_one_work+0x88b/0x1740 kernel/workqueue.c:2235
  #1: ffffc90000cdfdc0 ((work_completion)(&buf->work)){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2239
  #2: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at: flush_to_ldisc+0x3d/0x390  
drivers/tty/tty_buffer.c:505
1 lock held by khungtaskd/1115:
  #0: ffffffff897a4080 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/9433:
  #0: ffff8880a36c8620 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by login/9555:
  #0: ffff8880a0baa090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018a32e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9556:
  #0: ffff8880a6ce8090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900019032e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9558:
  #0: ffff8880a3bc9090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018f32e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9559:
  #0: ffff8880949a6090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900019132e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9560:
  #0: ffff88809f429090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018e32e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9561:
  #0: ffff888096165090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018632e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by syz-executor.3/16730:
  #0: ffff8880a0baa090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffff8880aa5bc0a8 (&buf->lock){+.+.}, at:  
tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
2 locks held by getty/17086:
  #0: ffff8880a8418090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90002c9b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1115 Comm: khungtaskd Not tainted 5.4.0-syzkaller #0
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
CPU: 1 PID: 16730 Comm: syz-executor.3 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:lock_is_held_type+0x220/0x320 kernel/locking/lockdep.c:4523
Code: e0 03 3b 45 cc 41 0f 94 c4 65 48 8b 1c 25 c0 1e 02 00 48 8d bb 94 08  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 d3
RSP: 0018:ffffc90002b5f6a8 EFLAGS: 00000807
RAX: dffffc0000000000 RBX: ffff888057b10300 RCX: ffff888057b10b98
RDX: 1ffff1100af62172 RSI: ffff8880ae937398 RDI: ffff888057b10b94
RBP: ffffc90002b5f6f0 R08: 1ffff1100af62060 R09: ffffed100af62061
R10: ffffed100af62060 R11: ffff888057b10307 R12: 0000000000000001
R13: ffff888057b10be8 R14: ffff8880ae937398 R15: 0000000000000002
FS:  00007fd84687b700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c43a311010 CR3: 0000000094d79000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_is_held include/linux/lockdep.h:361 [inline]
  rq_clock_task kernel/sched/sched.h:1104 [inline]
  update_curr+0x296/0x8d0 kernel/sched/fair.c:835
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
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd84687ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000020000000 RSI: 000000000000541c RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd84687b6d4
R13: 00000000004c5962 R14: 00000000004dbb78 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
