Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9229EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175F21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfLLWfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:35:12 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:33977 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbfLLWfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:11 -0500
Received: by mail-io1-f71.google.com with SMTP id n26so345730ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 14:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4LjkmQ6DB8Gu/cmDAz1toqyUvhUuHAtOb1x1erpuJh0=;
        b=Yf+0XGGB4GM9n9YwUGvoQZ2DUe3WmWtcRUGL0Xpi102HI5pvdMfg9r6hEbUJFZtBwg
         DwAbs+wTGa9Az5et+YhHqUdZ9B0CB05xxWoBRfhnFgd7izteI3+iNxl5KwvHlCKsYetk
         rB3IfQ04MJQwlK7I5NRR5ozziAv4CqNOEA7mC7lRfeYcofjhocgqLT93XMzriW5PGdef
         71kz9p+9gOsHWaXxgqhDS/z9LL2ruvUwWP+I5h/FIypw1uo+66WHmrOQoFG+vT1291v3
         Bqj30xVDKzgZiYNpKLFtqvo1/w2snawx9dkBE2K/wGX4J5NMKedZWM/5LeFqOoBRga5S
         XxiA==
X-Gm-Message-State: APjAAAVvmAWo2GjTZ0iHfUGowbvFmusG8zj092zQktk3jB5zK6wp5R1m
        irXcFl6/2lmJ2Orz74UFqbwyiNj//3yXrXz4VVi7L2ai1EVC
X-Google-Smtp-Source: APXvYqxoLDTgNq51mJ4THYEf56vzfVXbpUR8IgVgRRZBkNR+yDkNauZlFvG0wCm+jHJAoyTqvEcFsZMhzTpWBAvzjw9OHKf9e4Z/
MIME-Version: 1.0
X-Received: by 2002:a5e:8345:: with SMTP id y5mr4832115iom.122.1576190110802;
 Thu, 12 Dec 2019 14:35:10 -0800 (PST)
Date:   Thu, 12 Dec 2019 14:35:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a730300599895b48@google.com>
Subject: INFO: rcu detected stall in chrdev_open (2)
From:   syzbot <syzbot+29784f46793e49c37812@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    687dec9b Merge tag 'erofs-for-5.5-rc2-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bf5deae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=29784f46793e49c37812
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165eba1ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c7ae61e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29784f46793e49c37812@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=10502 jiffies, g=8389, q=39)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4295039703-4295029200), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor062 R  running task    26152  9337   9045 0x00004000
Call Trace:
  <IRQ>
  sched_show_task kernel/sched/core.c:5954 [inline]
  sched_show_task.cold+0x2ee/0x35d kernel/sched/core.c:5929
  print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
  rcu_pending kernel/rcu/tree.c:2827 [inline]
  rcu_sched_clock_irq.cold+0xaf4/0xc02 kernel/rcu/tree.c:2271
  update_process_times+0x2d/0x70 kernel/time/timer.c:1726
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
  tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1310
  __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
  __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1579
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1641
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752  
[inline]
RIP: 0010:kfree+0x239/0x2c0 mm/slab.c:3758
Code: 4f 7e 0f 85 20 fe ff ff e8 45 ee 4d ff e9 16 fe ff ff e8 8a 46 c8 ff  
48 83 3d fa bb e0 07 00 0f 84 85 00 00 00 48 89 df 57 9d <0f> 1f 44 00 00  
5b 41 5c 41 5d 41 5e 5d c3 e8 64 46 c8 ff 48 83 3d
RSP: 0018:ffffc900023e77f8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: 0000000000000286 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000286
RBP: ffffc900023e7818 R08: ffff88809eebc300 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888095f8ebc0
R13: ffff8880aa4001c0 R14: ffffffff83daaa1a R15: dffffc0000000000
  tty_free_file drivers/tty/tty_io.c:222 [inline]
  tty_open+0x59a/0xbb0 drivers/tty/tty_io.c:2038
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3420 [inline]
  path_openat+0x10df/0x4500 fs/namei.c:3537
  do_filp_open+0x1a1/0x280 fs/namei.c:3567
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_openat fs/open.c:1124 [inline]
  __se_sys_openat fs/open.c:1118 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1118
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4468f9
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f505dd44db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 0000000000000000 RSI: 0000000020000380 RDI: ffffffffffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe574a581f R14: 00007f505dd459c0 R15: 000000000000002d
rcu: rcu_preempt kthread starved for 10546 jiffies! g8389 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29272    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x486/0xc50 kernel/time/timer.c:1895
  rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
  rcu_gp_kthread+0x9b2/0x18d0 kernel/rcu/tree.c:1821
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
