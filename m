Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D483BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24CD2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDMHIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:08:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52527 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfDMHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:08:09 -0400
Received: by mail-io1-f71.google.com with SMTP id p143so9763711iod.19
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 00:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wgy1m5VcgQGXtWKggy9ce0o1BeEi7R2JNRtZwDLowfg=;
        b=sZcSBEyFzlUc//ZTN/md+r2jyZJ6zYez1NIgzKhlpV3LEGBgX87/SNxloWSj945UmQ
         PFALskjOuMct4gE1vzG1TW2qNXZS7HXRmY3pL/mqQMf2akF54XdJ6DlN5tjI1QckYMtI
         EXJWFk/Y/N0kkiIZbY5a8z+5Zqu6l+UIx8KuBKUCZhS8JwokbXcB+zA1m5XO/hn+gVLv
         r+jh3NDUFXdwmnhnqAdAKgSZc2AFLfBQqdnQMVsfhAdUIOqYKuTt9gigwvy9YK/zl3gd
         zvgKT7MYGiaVL/L188c9ERJeI+jyGNouUbKK60onpuCEXzzmHpowdRD9BPhH52zAe7yD
         kLsg==
X-Gm-Message-State: APjAAAWw+3MowTgqKLMXdUr065i+vM8LzPHMR2wXMkN0tjuh3SkFQzhD
        mzJdWqDI7rhWkIR+AB65hgXplc14OXUfFKM7f5Ikvj9vpmMe
X-Google-Smtp-Source: APXvYqyOFO8FHvDkTPqrTnjgTeDz9yxe/k773oDUocLzi6jeX3/mIv1oOhl7MxcuSJfkDWhCOhkTSCSu/+b6KNeXB2ff3h65cVkv
MIME-Version: 1.0
X-Received: by 2002:a02:5ec9:: with SMTP id h192mr11071140jab.2.1555139288638;
 Sat, 13 Apr 2019 00:08:08 -0700 (PDT)
Date:   Sat, 13 Apr 2019 00:08:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e02bf505866414ae@google.com>
Subject: INFO: task hung in do_exit
From:   syzbot <syzbot+9880e421ec82313d6527@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, avagin@gmail.com, dbueso@suse.de,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        oleg@redhat.com, prsood@codeaurora.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ee15f32 Merge tag 'dma-mapping-5.1-1' of git://git.infrad..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a512d3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=9880e421ec82313d6527
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b89af200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9880e421ec82313d6527@syzkaller.appspotmail.com

INFO: task syz-executor.4:13600 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #65
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D28384 13600   8046 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:285 [inline]
  rwsem_down_read_failed+0x213/0x420 kernel/locking/rwsem-xadd.c:302
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0x49/0x90 kernel/locking/rwsem.c:26
  exit_mm kernel/exit.c:512 [inline]
  do_exit+0x443/0x2fa0 kernel/exit.c:863
  do_group_exit+0x135/0x370 kernel/exit.c:980
  __do_sys_exit_group kernel/exit.c:991 [inline]
  __se_sys_exit_group kernel/exit.c:989 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:989
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: Bad RIP value.
RSP: 002b:00007ffffcf8a138 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000458c29
RDX: 00000000004129e1 RSI: fffffffffffffff7 RDI: 0000000000000000
RBP: 0000000000000000 R08: 000000000009a64e R09: 00007ffffcf8a190
R10: 000000000009a64e R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffffcf8a190 R14: 0000000000000000 R15: 00007ffffcf8a1a0
INFO: task syz-executor.4:13603 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #65
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D28200 13603   8046 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:285 [inline]
  rwsem_down_read_failed+0x213/0x420 kernel/locking/rwsem-xadd.c:302
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0x49/0x90 kernel/locking/rwsem.c:26
  exit_mm kernel/exit.c:512 [inline]
  do_exit+0x443/0x2fa0 kernel/exit.c:863
  do_group_exit+0x135/0x370 kernel/exit.c:980
  get_signal+0x399/0x1d50 kernel/signal.c:2577
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: Bad RIP value.
RSP: 002b:00007f55040dbcf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000073bf08 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000073bf08
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000073bf0c
R13: 00007ffffcf89f3f R14: 00007f55040dc9c0 R15: 000000000073bf0c

Showing all locks held in the system:
1 lock held by khungtaskd/1042:
  #0: 00000000e7920387 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5061
1 lock held by rsyslogd/7885:
  #0: 00000000746102cf (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/7997:
  #0: 0000000084730aa3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000095194d1b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7998:
  #0: 00000000f2a2e523 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000c8e15d18 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7999:
  #0: 0000000070592706 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000a567a5f4 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8000:
  #0: 0000000088e68b88 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000150e7fab (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8001:
  #0: 000000001f261fc9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000090482210 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8002:
  #0: 00000000003fc912 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000a81ef369 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8003:
  #0: 00000000620d61b3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000002d752e92 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.4/13600:
  #0: 0000000016ce688c (&mm->mmap_sem){++++}, at: exit_mm kernel/exit.c:512  
[inline]
  #0: 0000000016ce688c (&mm->mmap_sem){++++}, at: do_exit+0x443/0x2fa0  
kernel/exit.c:863
1 lock held by syz-executor.4/13603:
  #0: 0000000016ce688c (&mm->mmap_sem){++++}, at: exit_mm kernel/exit.c:512  
[inline]
  #0: 0000000016ce688c (&mm->mmap_sem){++++}, at: do_exit+0x443/0x2fa0  
kernel/exit.c:863
1 lock held by syz-executor.4/13611:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1042 Comm: khungtaskd Not tainted 5.1.0-rc4+ #65
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0x9b7/0xec0 kernel/hung_task.c:288
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
