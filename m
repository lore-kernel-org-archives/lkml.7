Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C907F20684
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbfJWHUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:20:10 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:53200 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732481AbfJWHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:20:10 -0400
Received: by mail-il1-f197.google.com with SMTP id h22so11779195ild.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 00:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CW1/ZENZVkmujzszXBL2Qc2HPyGtTn9ZTe23cOJtASo=;
        b=czUFYjV3UKmpgUNZgL1ZkxdYVr+AgePLJfnO5iFdxuRoZKcUw9XJM/hKNwOJy6pkcx
         8mwFtVNsjNHQl5EMXCVNAAK7UH1JpDXuQeGvpwfEf/K52u7Ym7nrzHuhReTdlN1cPdN0
         81J4hupC07CIKKnFbxW+f6sk5Pb8Xbe/Fy/sIH4uIzLwsEfFite2gj8CNNzFggxsF3+9
         ugplHJCxc+zNUlMs4aHw/K2SDfCe4yvd1x3HRW9jv0Rovb8g5CW71LyW+L8pU8AbHOJT
         IC8vsFBAPS2k4kA4S66EWgRb8lLKhOedX6527mv/CB8gtGya9/nqh7tKqNiEDAgsCOdC
         mEDw==
X-Gm-Message-State: APjAAAUp/f4g/iJ6fRKLHrkEtxpCFtQOCj3NIHb39CGx3pe5wWJAero1
        FqAWSQai8EY0+lU3gqChsItnEeOgSSI0tv1I0cyI8+UViCBH
X-Google-Smtp-Source: APXvYqzMJY+w78xkP5yBFfSJ+W9a5kjXNrLNIYN0Nzq55BKH/eM0z9HHro8QTstNUmM/VgBggko4NTAbiyq8xRrukOu2RD99+qrU
MIME-Version: 1.0
X-Received: by 2002:a02:3208:: with SMTP id j8mr7914697jaa.86.1571815207678;
 Wed, 23 Oct 2019 00:20:07 -0700 (PDT)
Date:   Wed, 23 Oct 2019 00:20:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b3b9f05958ebf2c@google.com>
Subject: INFO: task hung in acct_process
From:   syzbot <syzbot+bece7c62047c98a5aa90@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4f5cafb5 Linux 5.4-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e1d2a0e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de66e73d1c10cebb
dashboard link: https://syzkaller.appspot.com/bug?extid=bece7c62047c98a5aa90
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bece7c62047c98a5aa90@syzkaller.appspotmail.com

INFO: task syz-executor.5:19837 blocked for more than 143 seconds.
       Not tainted 5.4.0-rc3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D24680 19837      1 0x80004004
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x74b/0xb80 kernel/sched/core.c:4069
  schedule+0x131/0x1e0 kernel/sched/core.c:4136
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4195
  __mutex_lock_common+0x1411/0x2e20 kernel/locking/mutex.c:1033
  __mutex_lock kernel/locking/mutex.c:1103 [inline]
  mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
  acct_get kernel/acct.c:161 [inline]
  slow_acct_process kernel/acct.c:577 [inline]
  acct_process+0x3af/0x570 kernel/acct.c:605
  do_exit+0x573/0x2190 kernel/exit.c:807
  do_group_exit+0x15c/0x2b0 kernel/exit.c:921
  get_signal+0x4ac/0x1d60 kernel/signal.c:2734
  do_signal+0x37/0x640 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop arch/x86/entry/common.c:159 [inline]
  prepare_exit_to_usermode+0x303/0x580 arch/x86/entry/common.c:194
  syscall_return_slowpath+0x113/0x4a0 arch/x86/entry/common.c:274
  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4139ea
Code: 00 48 89 04 24 48 c7 44 24 08 21 00 00 00 e8 ed 7e 01 00 0f 0b 48 89  
1c 24 e8 b2 f9 03 00 48 8b 44 24 10 48 89 44 24 38 48 8b <4c> 24 08 48 89  
4c 24 40 e8 69 88 01 00 48 8d 05 f3 a4 4e 00 48 89
RSP: 002b:00007ffcbd566058 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 0000000000bfa940 RCX: 00000000004139ea
RDX: 0000000040000000 RSI: 00007ffcbd566090 RDI: ffffffffffffffff
RBP: 00000000000039b0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000011
R13: 00007ffcbd566090 R14: 0000000000bfa99b R15: 00007ffcbd5660a0

Showing all locks held in the system:
1 lock held by khungtaskd/1064:
  #0: ffffffff888d3f80 (rcu_read_lock){....}, at: rcu_lock_acquire+0x4/0x30  
include/linux/rcupdate.h:207
1 lock held by rsyslogd/7848:
  #0: ffff8880a2fecde0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x243/0x2e0  
fs/file.c:801
2 locks held by getty/7938:
  #0: ffff88809a98c090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005f012e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
2 locks held by getty/7939:
  #0: ffff8880a58d5090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005f152e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
2 locks held by getty/7940:
  #0: ffff8880a12f7090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005f092e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
2 locks held by getty/7941:
  #0: ffff8880a7a88090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005f1d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
2 locks held by getty/7942:
  #0: ffff8880a892b090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005f292e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
2 locks held by getty/7943:
  #0: ffff8880a7bb4090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005f252e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
2 locks held by getty/7944:
  #0: ffff8880993fd090 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: ffffc90005ef12e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x221/0x1b00 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.5/19837:
  #0: ffff8880a7dbb0f0 (&acct->lock#2){+.+.}, at: acct_get kernel/acct.c:161  
[inline]
  #0: ffff8880a7dbb0f0 (&acct->lock#2){+.+.}, at: slow_acct_process  
kernel/acct.c:577 [inline]
  #0: ffff8880a7dbb0f0 (&acct->lock#2){+.+.}, at: acct_process+0x3af/0x570  
kernel/acct.c:605
3 locks held by syz-executor.5/17136:
  #0: ffff8880a7dbb0f0 (&acct->lock#2){+.+.}, at: acct_get kernel/acct.c:161  
[inline]
  #0: ffff8880a7dbb0f0 (&acct->lock#2){+.+.}, at: slow_acct_process  
kernel/acct.c:577 [inline]
  #0: ffff8880a7dbb0f0 (&acct->lock#2){+.+.}, at: acct_process+0x3af/0x570  
kernel/acct.c:605
  #1: ffff88809b314420 (sb_writers#3){.+.+}, at: file_start_write_trylock  
include/linux/fs.h:2889 [inline]
  #1: ffff88809b314420 (sb_writers#3){.+.+}, at:  
do_acct_process+0xf0c/0x1370 kernel/acct.c:517
  #2: ffff888093bd4a48 (&sb->s_type->i_mutex_key#10){++++}, at:  
inode_trylock include/linux/fs.h:811 [inline]
  #2: ffff888093bd4a48 (&sb->s_type->i_mutex_key#10){++++}, at:  
ext4_file_write_iter+0x1a8/0x15b0 fs/ext4/file.c:234

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1064 Comm: khungtaskd Not tainted 5.4.0-rc3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  nmi_cpu_backtrace+0xaf/0x1a0 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x174/0x290 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace+0x17/0x20 include/linux/nmi.h:146
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xbb9/0xbd0 kernel/hung_task.c:289
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xe/0x10  
arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
