Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679A121783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfJVOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:54:08 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:36977 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbfJVOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:54:08 -0400
Received: by mail-il1-f197.google.com with SMTP id u68so2093261ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=plByC+6g5iPb6f9BPFsEwsdEKhqDehc3aoDUXyxKK+c=;
        b=Z/vpRZFLXfiz4eEeA1hhRtkIjJaGFmc0Zu5I33nvqnQkcQ2HlfIshvYDyJ1RplMTmr
         MRxxHagHnVuhzZAjS4XPdS2/L/+y19hoAvK/C8IFgsHxXcTlQehxsNt1FYSNxN0xJu3t
         a+WzojHPnur2LTn4kBuKWAT35kcQEr2g8XgvYJDdiEer5fiuzAKy7xY0BvYn2WgmbNBT
         XpibOdxey3TYVvmk7nx2lIlPbBDF/99hVMsZSEAcjwkGU1IY2tAONsBhg2r5eeEx1+tx
         1JAyoOptGxJMG2hKNl7bUPewSGMYSqZQrj/wLvjXfi6VWpqr8RvihJhYrwf7vOj8dnfD
         V6Mw==
X-Gm-Message-State: APjAAAXEF3rBB9UqTufodbG+yQGdWf8fKiPYoqzFszjSlxMQJ/CkWEv0
        A7A3r+PGIovGWu9lux33LLGp2BnVeq6fnGR2JBRHA4TZBmhu
X-Google-Smtp-Source: APXvYqw6hcbFUndiysg6MmN/Z7A1PL1uXYrRDYDtweQGR+9+vK5bpAAhPWbmaZzLZQ8uCGKYdjCBvfHw4ltNkelljto9jGCLiTm2
MIME-Version: 1.0
X-Received: by 2002:a92:5b16:: with SMTP id p22mr32761324ilb.201.1571756046981;
 Tue, 22 Oct 2019 07:54:06 -0700 (PDT)
Date:   Tue, 22 Oct 2019 07:54:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daa63d059580f872@google.com>
Subject: INFO: task hung in ld_usb_write
From:   syzbot <syzbot+a4fbb3bb76cda0ea4e58@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mans@mansr.com, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1346948d600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=a4fbb3bb76cda0ea4e58
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12721965600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1274b9b5600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4fbb3bb76cda0ea4e58@syzkaller.appspotmail.com

INFO: task syz-executor952:1721 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc7+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor952 D28344  1721   1719 0x00000000
Call Trace:
  schedule+0xca/0x250 kernel/sched/core.c:3947
  schedule_timeout+0x440/0xb20 kernel/time/timer.c:1807
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion_timeout+0x282/0x3e0 kernel/sched/completion.c:155
  usb_start_wait_urb+0x14b/0x2b0 drivers/usb/core/message.c:62
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  ld_usb_write+0x856/0xa10 drivers/usb/misc/ldusb.c:577
  __vfs_write+0x76/0x100 fs/read_write.c:494
  vfs_write+0x262/0x5c0 fs/read_write.c:558
  ksys_write+0x1e8/0x250 fs/read_write.c:611
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440779
Code: Bad RIP value.
RSP: 002b:00007ffd90a29748 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440779
RDX: 0000000000000092 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00000000006cb018 R08: 000000000000000f R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402000
R13: 0000000000402090 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/23:
  #0: 000000002f4ecff1 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:5254
1 lock held by rsyslogd/1601:
  #0: 0000000072e2a5e4 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe3/0x100  
fs/file.c:801
2 locks held by getty/1691:
  #0: 00000000f9586bc9 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000005e9760e3 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1692:
  #0: 00000000a3c38810 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000069017299 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1693:
  #0: 000000002afc8512 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000ea2b3359 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1694:
  #0: 00000000b24afe2a (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000ae0d5444 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1695:
  #0: 000000005e2d099e (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000029e8b2e6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1696:
  #0: 0000000015792bef (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000d9742d8e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1697:
  #0: 00000000cbd4d76e (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000017b60d7a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
1 lock held by syz-executor952/1721:
  #0: 000000009a204c0d (&dev->mutex#3){+.+.}, at: ld_usb_write+0x111/0xa10  
drivers/usb/misc/ldusb.c:539

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 23 Comm: khungtaskd Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x55/0x96 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b0/0x1c7 lib/nmi_backtrace.c:62
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0x9a4/0xe50 kernel/hung_task.c:289
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt  
arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt  
arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0x28/0x2e0  
arch/x86/kernel/process.c:580


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
