Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56077C4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327A220652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfFYBhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:37:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33946 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfFYBhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:37:06 -0400
Received: by mail-io1-f70.google.com with SMTP id m1so24404558iop.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 18:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TnVrQ4YvO4oISiWml6A505UMpY7/fxx8brPHktMRArU=;
        b=WDmNMcUnVpHVA7rECYG/t6Mbgg9c9FjDdf6+1/W5zcZPzb6G/+QEQE8oqpY5AePXw1
         HlNSf4EgwUJEDk8LdlBnIwVpzvNKIW32kbbDgeMjlYt9b6BbcePmtfazRTpZrR6T2cvW
         7ZzvxZYThlBeE2KpwcK7PBTR6RvKKQqwf4F7CNXOWr0viKzHu9xIeZ9i2lF5rMQ8Mv6Y
         c+gN5s5qKztxF0X8R6Fa8+CeBZm5fNBgQmcUwc4NG3V0FrG3USldRNrIWpKBcFpqQG9b
         AHonYWG9xqm+OfCOpxovs+bAuggI7DnUQ565c5Bwp3BisPGBVnq365s5ZLrEgHwn7yJG
         3R+g==
X-Gm-Message-State: APjAAAV89wYZqvmhGdnaEZIKHhkr6h3tuaBxk+d5ypRkrw6QYTrMReOy
        S28wXrH/8Z9tdTODPU97Ddc/AQ5yIoImjWPPIFexGfwrZS/k
X-Google-Smtp-Source: APXvYqzqqGVQFb8EOPVD6tBKgkxVc7zKJp9LF6hrmn+7GV/S1Uzp1HcJUGAMahXLCinJ8tX02RANiG8TEcxYuvBraxBqqm138WEl
MIME-Version: 1.0
X-Received: by 2002:a6b:c886:: with SMTP id y128mr2446813iof.100.1561426625488;
 Mon, 24 Jun 2019 18:37:05 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:37:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005aedf1058c1bf7e8@google.com>
Subject: WARNING in mark_lock
From:   syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dc636f5d Add linux-next specific files for 20190620
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99c104b0092a557b
dashboard link: https://syzkaller.appspot.com/bug?extid=a861f52659ae2596492b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b24f6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167 hlock_class  
kernel/locking/lockdep.c:167 [inline]
WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167 hlock_class  
kernel/locking/lockdep.c:156 [inline]
WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167  
mark_lock+0x22b/0x11e0 kernel/locking/lockdep.c:3594
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9968 Comm: syz-executor.2 Not tainted 5.2.0-rc5-next-20190620  
#19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:156 [inline]
RIP: 0010:mark_lock+0x22b/0x11e0 kernel/locking/lockdep.c:3594
Code: d0 7c 08 84 d2 0f 85 33 0f 00 00 44 8b 15 4d 14 4a 08 45 85 d2 75 b6  
48 c7 c6 c0 a6 8b 87 48 c7 c7 00 a7 8b 87 e8 ad e6 eb ff <0f> 0b 31 db e9  
a8 fe ff ff 48 c7 c7 80 71 86 8a e8 f0 95 53 00 e9
RSP: 0018:ffff8880ae809ad0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000f1d RCX: 0000000000000000
RDX: 0000000000010000 RSI: ffffffff815b37e6 RDI: ffffed1015d0134c
RBP: ffff8880ae809b20 R08: ffff88808662e0c0 R09: fffffbfff11b3285
R10: fffffbfff11b3284 R11: ffffffff88d99423 R12: 0000000000000000
R13: ffff88808662e9c8 R14: 000000000000004f R15: 00000000000c4f1d
  mark_usage kernel/locking/lockdep.c:3485 [inline]
  __lock_acquire+0x1e1a/0x4680 kernel/locking/lockdep.c:3839
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4418
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
  try_to_wake_up+0x90/0x1430 kernel/sched/core.c:2000
  wake_up_process+0x10/0x20 kernel/sched/core.c:2114
  hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1636
  __run_hrtimer kernel/time/hrtimer.c:1388 [inline]
  __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1450
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1508
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
  smp_apic_timer_interrupt+0x12a/0x5b0 arch/x86/kernel/apic/apic.c:1066
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
