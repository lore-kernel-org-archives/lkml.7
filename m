Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD436C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92280214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfHLMSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:18:10 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:44399 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfHLMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:18:08 -0400
Received: by mail-ot1-f70.google.com with SMTP id q16so84038485otn.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zcJrkqi/MhIjVYLLjDCMSQ2kHaiJbV8Q6REnt6nFkWs=;
        b=f5Jn21YN/JrwZEb1E4NyXmJFtpsZByOezO6hAg8UP/TwkQ0P03aQa+K+1PBjmyb6SQ
         cRt5gTZDL1tNY2CZzsJ05A4SjYmghGhj2vm7khV3fEpnLto0ICBBsxH7OFnRr9RXWJfC
         H0cORAs/4eBLs0u0ezr2XjCvg59PLIt2OAnIjEsdL1b08LdAsxNkwbLS24KkYjfztgHl
         3rk24hDEetXDGSqUxk37or6HgT7SfWwf7DlCWMvywZV2CZBcCSJhJeltVeRp586Kjkeg
         vggxAS4VQhMnIdkvjm2BqUVlpuRhDFIAzemzryVixyF7w+DUQNPZcUs/xpmzd8MgVC2a
         OWpg==
X-Gm-Message-State: APjAAAXO6TEeUjVBhqkZh4JQcF+pNtMPRNeVtoWeAWyCLH4lNwwT37cM
        mfvqU6cerZvO3fJxhsS/zHcdaxs8mBKgzN2v+jaB/LKTzz6D
X-Google-Smtp-Source: APXvYqyMJphGe5GK//5PMW/z4eRodr23Y/nTeZ0+T1eHHP7fYgzfwm99TcbB/BZ6k3wTOsb3DnjxQqlqP90l2qYDXiXRHW0E9Eyn
MIME-Version: 1.0
X-Received: by 2002:a6b:f607:: with SMTP id n7mr19954569ioh.263.1565612286608;
 Mon, 12 Aug 2019 05:18:06 -0700 (PDT)
Date:   Mon, 12 Aug 2019 05:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003313f0058fea8435@google.com>
Subject: INFO: task hung in wdm_flush
From:   syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, baijiaju1990@gmail.com,
        bigeasy@linutronix.de, colin.king@canonical.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1046c6ee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1299132c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176e6d8c600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com

INFO: task syz-executor121:1726 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc2+ #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor121 D28520  1726   1724 0x80004006
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
  filp_close+0xb4/0x160 fs/open.c:1166
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d8/0x2e0 fs/file.c:413
  exit_files+0x7e/0xa0 fs/file.c:445
  do_exit+0x8bc/0x2c50 kernel/exit.c:873
  do_group_exit+0x125/0x340 kernel/exit.c:982
  get_signal+0x466/0x23d0 kernel/signal.c:2728
  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x401520
Code: 6e 65 54 61 62 6c 65 00 67 65 74 63 6f 6e 00 5f 69 6e 69 74 00 69 73  
5f 73 65 6c 69 6e 75 78 5f 65 6e 61 62 6c 65 64 00 73 65 <63> 75 72 69 74  
79 5f 67 65 74 65 6e 66 6f 72 63 65 00 67 65 74 5f
RSP: 002b:00007ffd59c75df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: 0000000000000004 RBX: 0000000000000000 RCX: 0000000000401520
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffd59c75e10
RBP: 00000000006cc018 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000402540
R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor121:1731 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc2+ #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor121 D28520  1731   1730 0x80004006
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
  filp_close+0xb4/0x160 fs/open.c:1166
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d8/0x2e0 fs/file.c:413
  exit_files+0x7e/0xa0 fs/file.c:445
  do_exit+0x8bc/0x2c50 kernel/exit.c:873
  do_group_exit+0x125/0x340 kernel/exit.c:982
  get_signal+0x466/0x23d0 kernel/signal.c:2728
  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4417e9
Code: 65 64 2e 0a 44 69 64 20 79 6f 75 20 64 6f 20 61 20 22 6d 61 6b 65 20  
69 6e 73 74 61 6c 6c 22 3f 0a 53 75 67 67 65 73 74 65 64 <20> 61 63 74 69  
6f 6e 3a 20 72 75 6e 20 72 73 79 73 6c 6f 67 64 20
RSP: 002b:00007ffd59c75ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00000000004417e9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006cc018 R08: 000000000000000f R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402540
R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor121:1732 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc2+ #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor121 D28520  1732   1728 0x80004006
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
  filp_close+0xb4/0x160 fs/open.c:1166
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d8/0x2e0 fs/file.c:413
  exit_files+0x7e/0xa0 fs/file.c:445
  do_exit+0x8bc/0x2c50 kernel/exit.c:873
  do_group_exit+0x125/0x340 kernel/exit.c:982
  get_signal+0x466/0x23d0 kernel/signal.c:2728
  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x401520
Code: 00 00 3d 02 00 00 46 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 10  
01 00 00 2f 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00  
00 00 00 00 00 00 00 00 00 00 00 20 01 00 00 00 00
RSP: 002b:00007ffd59c75df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: 0000000000000004 RBX: 0000000000000000 RCX: 0000000000401520
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffd59c75e10
RBP: 00000000006cc018 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000402540
R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor121:1733 blocked for more than 144 seconds.
       Not tainted 5.3.0-rc2+ #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor121 D28376  1733   1725 0x80000002
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
  filp_close+0xb4/0x160 fs/open.c:1166
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d8/0x2e0 fs/file.c:413
  exit_files+0x7e/0xa0 fs/file.c:445
  do_exit+0x8bc/0x2c50 kernel/exit.c:873
  do_group_exit+0x125/0x340 kernel/exit.c:982
  __do_sys_exit_group kernel/exit.c:993 [inline]
  __se_sys_exit_group kernel/exit.c:991 [inline]
  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:991
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440438
Code: 61 74 68 3e 5d 0a 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 5b  
2d 75 3c 6e 75 6d 62 65 72 3e 5d 0a 54 6f 20 72 75 6e 20 <72> 73 79 73 6c  
6f 67 64 20 69 6e 20 6e 61 74 69 76 65 20 6d 6f 64
RSP: 002b:00007ffd59c75e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440438
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bff70 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor121:1734 blocked for more than 144 seconds.
       Not tainted 5.3.0-rc2+ #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor121 D28248  1734   1729 0x80004006
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
  filp_close+0xb4/0x160 fs/open.c:1166
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d8/0x2e0 fs/file.c:413
  exit_files+0x7e/0xa0 fs/file.c:445
  do_exit+0x8bc/0x2c50 kernel/exit.c:873
  do_group_exit+0x125/0x340 kernel/exit.c:982
  get_signal+0x466/0x23d0 kernel/signal.c:2728
  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4417e9
Code: 65 64 2e 0a 44 69 64 20 79 6f 75 20 64 6f 20 61 20 22 6d 61 6b 65 20  
69 6e 73 74 61 6c 6c 22 3f 0a 53 75 67 67 65 73 74 65 64 <20> 61 63 74 69  
6f 6e 3a 20 72 75 6e 20 72 73 79 73 6c 6f 67 64 20
RSP: 002b:00007ffd59c75ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00000000004417e9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006cc018 R08: 000000000000000f R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402540
R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor121:1736 blocked for more than 144 seconds.
       Not tainted 5.3.0-rc2+ #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor121 D28520  1736   1727 0x80004006
Call Trace:
  schedule+0x9a/0x250 kernel/sched/core.c:3944
  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
  filp_close+0xb4/0x160 fs/open.c:1166
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d8/0x2e0 fs/file.c:413
  exit_files+0x7e/0xa0 fs/file.c:445
  do_exit+0x8bc/0x2c50 kernel/exit.c:873
  do_group_exit+0x125/0x340 kernel/exit.c:982
  get_signal+0x466/0x23d0 kernel/signal.c:2728
  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4417e9
Code: 65 64 2e 0a 44 69 64 20 79 6f 75 20 64 6f 20 61 20 22 6d 61 6b 65 20  
69 6e 73 74 61 6c 6c 22 3f 0a 53 75 67 67 65 73 74 65 64 <20> 61 63 74 69  
6f 6e 3a 20 72 75 6e 20 72 73 79 73 6c 6f 67 64 20
RSP: 002b:00007ffd59c75ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00000000004417e9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006cc018 R08: 000000000000000f R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402540
R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/23:
  #0: 00000000743497a3 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:5254
1 lock held by rsyslogd/1602:
  #0: 00000000988125b0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe3/0x100  
fs/file.c:801
2 locks held by getty/1693:
  #0: 0000000047c29258 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000527dfb3a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1694:
  #0: 000000003a351c46 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000d8d75c5b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1695:
  #0: 00000000e15b15bf (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000004d294c18 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1696:
  #0: 0000000051d028a3 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 0000000038c23150 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1697:
  #0: 000000001b33f7ab (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000f5955915 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1698:
  #0: 000000007ef217e0 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 00000000bc876517 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156
2 locks held by getty/1699:
  #0: 000000000ee3efd4 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:272
  #1: 000000006bc64f89 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x223/0x1ae0 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.3.0-rc2+ #25
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt  
arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt  
arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0x28/0x2e0  
arch/x86/kernel/process.c:580


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
