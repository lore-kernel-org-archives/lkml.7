Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29591C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E92218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfB1TQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:16:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:56325 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1TQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:16:05 -0500
Received: by mail-it1-f199.google.com with SMTP id j18so8813220itl.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mNcDgpafEKweOehhQ5ck4WarbducdKgGYg5OtKgepN4=;
        b=SVhw9+A4lxZQ2eToRpBIvCOEDjeG1+0HS3xs3FnJkZY/JlObn8MQZY6Ga43dh3YjuU
         Ku/HZiiJLhgXmsVQa0/HOjlBF4DEoblHJid+f3jnnL118Sj7c4F4ay4iLoeQTVndEzKB
         yd1+CGZYS4Ype83JCzuFKiNnjSqYcvYQnUDDtVL0sLRu7HrOQtVtW0R/NM7AAVqYSBhy
         YjSgJT8WdZIhGKq2XY5nl1q0+mjbYFJi5zExdUe0LWRk7XUZqmG/2F/qPRYOUppHKTg/
         RYkT/5sRL+vix5BnRN06AowZUNLwJFuASFdfeI8jF6fL2M/76PEuI4akxDFA7+F1sS7l
         r2zQ==
X-Gm-Message-State: APjAAAU0syInf6taFaCUTpj8AoQio9M/dsNJ+qh4IclODrMUyqoVNWHw
        z6ViyInMuAqan441XPW7NE2f2oqxMhrS6UQ3Ik/Zn2Fr+pJw
X-Google-Smtp-Source: APXvYqy8yx+92q/Bdo4/IDFxatoFrmQyUBaPlHKcJ90QHBpB8OMP0hk8p0/jwfzaWcKta32QWKccNh3u7djFqrEsYoCdLyeOOZLG
MIME-Version: 1.0
X-Received: by 2002:a24:6cd3:: with SMTP id w202mr860471itb.10.1551381363754;
 Thu, 28 Feb 2019 11:16:03 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:16:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001913600582f91f5b@google.com>
Subject: INFO: trying to register non-static key in hci_uart_send_frame
From:   syzbot <syzbot+a8587ba69fc78395d947@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d762d69145a afs: Fix manually set volume location server ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b9f9e0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b76ec970784287c
dashboard link: https://syzkaller.appspot.com/bug?extid=a8587ba69fc78395d947
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a8587ba69fc78395d947@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 12776 Comm: kworker/u5:1 Not tainted 5.0.0-rc8+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci2 hci_cmd_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:731 [inline]
  register_lock_class+0x1bdc/0x1bf0 kernel/locking/lockdep.c:757
  __lock_acquire+0x11f/0x4700 kernel/locking/lockdep.c:3224
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  hci_uart_send_frame+0x85/0x470 drivers/bluetooth/hci_ldisc.c:287
  hci_send_frame+0x1b8/0x2d0 net/bluetooth/hci_core.c:3538
  hci_cmd_work+0x137/0x270 net/bluetooth/hci_core.c:4451
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16657 Comm: syz-executor.0 Not tainted 5.0.0-rc8+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0xdf/0x620 kernel/sched/wait.c:85
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 69 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 12 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff88803a8ef768 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88808f9da138 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffffffff12b957f RDI: 0000000000000000
RBP: ffff88803a8ef7c0 R08: ffffffffffffffe8 R09: ffff88803a8ef818
R10: ffffed100751dee6 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fd6620ec700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 0000000087882000 CR4: 00000000001406e0
DR0: 000000000000b8c4 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_common_lock+0xe9/0x190 kernel/sched/wait.c:121
  __wake_up+0xe/0x10 kernel/sched/wait.c:145
  rcu_sync_enter+0x193/0x310 kernel/rcu/sync.c:132
  percpu_down_write+0x61/0x440 kernel/locking/percpu-rwsem.c:143
  hci_uart_tty_close+0x13a/0x260 drivers/bluetooth/hci_ldisc.c:531
  tty_ldisc_close.isra.0+0x100/0x180 drivers/tty/tty_ldisc.c:485
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:633
  tty_ldisc_release+0xc6/0x280 drivers/tty/tty_ldisc.c:805
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1610
  tty_release+0xbce/0xe90 drivers/tty/tty_io.c:1783
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  get_signal+0x1961/0x1d50 kernel/signal.c:2388
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd6620ebc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000000000000 RSI: 00000000400455c8 RDI: 0000000000000005
RBP: 000000000073c0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd6620ec6d4
R13: 00000000004c06b8 R14: 00000000004d23f0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 2aab5be233fff365 ]---
RIP: 0010:__wake_up_common+0xdf/0x620 kernel/sched/wait.c:85
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 69 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 12 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff88803a8ef768 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88808f9da138 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffffffff12b957f RDI: 0000000000000000
RBP: ffff88803a8ef7c0 R08: ffffffffffffffe8 R09: ffff88803a8ef818
R10: ffffed100751dee6 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fd6620ec700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 0000000087882000 CR4: 00000000001406e0
DR0: 000000000000b8c4 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
