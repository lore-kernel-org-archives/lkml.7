Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45029C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B5820848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDNL3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:29:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56224 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfDNL3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 07:29:05 -0400
Received: by mail-io1-f71.google.com with SMTP id z19so11737484ioc.22
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 04:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8FmG59vyk1AuyVAdyHhu7qqIp2vnqAtjpaWeZTBXlHo=;
        b=BDCGnR7v4IR7YFt/WnBHh8acgLdbXsOWPB3bBogxV/65M+u0sYFUI6q4ZMRP2SVwJ9
         zRxcnwhuOUhOK/x9NNaW/20qEWKxDvCZYkuXo66O0bHxZmYb4Q3q4wRS7Q1og6KHCtU3
         eJTx4BLkMfi7deNX4kmQQ51M62LJaeOVOmNTWaJDn3pRDWREZ9xkv2fBHMNTgM5BwmV8
         1ARuuMhOHoJKkMtKNPh3VI/PF83c+rr53+aHfXbnhwnZztq/8rJKgxrbEN70DuGH7tt7
         BO4zzQyhC5BHtqyWaOwReIDcq5WNROukgkuPPgSvUmOQNDN7/hQ0PGhIIimWEO0S7Aq6
         xnKQ==
X-Gm-Message-State: APjAAAVbrLjXzWzZSApqMDINQoEduhCKT+dUcE+egYh2xRLL0HEVf3IK
        ao0NICSY5Ea/STrlZneYARuyOHXLfNaxXo3W9pnlph0HHAxO
X-Google-Smtp-Source: APXvYqzoAvU9ZOmCASjSwiyybt8FcG2BlSJAgjKiwScVQYRMLQzZCBF1WUDYtPE78kL3sy6WjvYJqt7tsn1fQYdQG7tIDkX3BaMk
MIME-Version: 1.0
X-Received: by 2002:a6b:bc06:: with SMTP id m6mr1508942iof.18.1555241345009;
 Sun, 14 Apr 2019 04:29:05 -0700 (PDT)
Date:   Sun, 14 Apr 2019 04:29:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8cf3805867bd715@google.com>
Subject: WARNING: locking bug in lock_sock_nested
From:   syzbot <syzbot+605a69fff339d9cc221e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2d06b235 Merge tag 'for-5.1-rc4-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1521ba9f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=605a69fff339d9cc221e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+605a69fff339d9cc221e@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 24536 at kernel/locking/lockdep.c:746  
arch_local_save_flags arch/x86/include/asm/paravirt.h:762 [inline]
WARNING: CPU: 1 PID: 24536 at kernel/locking/lockdep.c:746  
arch_local_save_flags arch/x86/include/asm/paravirt.h:760 [inline]
WARNING: CPU: 1 PID: 24536 at kernel/locking/lockdep.c:746  
look_up_lock_class kernel/locking/lockdep.c:737 [inline]
WARNING: CPU: 1 PID: 24536 at kernel/locking/lockdep.c:746  
register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1090
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 24536 Comm: syz-executor.5 Not tainted 5.1.0-rc4+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:746 [inline]
RIP: 0010:register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1090
Code: 00 48 89 da 4d 8b 76 c0 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80  
3c 02 00 0f 85 23 07 00 00 4c 89 33 e9 e3 f4 ff ff 0f 0b <0f> 0b e9 ea f3  
ff ff 44 89 e0 4c 8b 95 50 ff ff ff 83 c0 01 4c 8b
RSP: 0018:ffff88808a40f5e0 EFLAGS: 00010083
RAX: dffffc0000000000 RBX: ffff8880908061e0 RCX: 0000000000000000
RDX: 1ffff11012100c3f RSI: 0000000000000000 RDI: ffff8880908061f8
RBP: ffff88808a40f6a8 R08: 1ffff11011481ec4 R09: ffffffff8a5c8a20
R10: ffffffff8a0afe30 R11: 0000000000000000 R12: ffffffff8a11dec0
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff87fb8da0
  __lock_acquire+0xf9/0x3fb0 kernel/locking/lockdep.c:3582
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2912
  lock_sock include/net/sock.h:1513 [inline]
  do_ipv6_setsockopt.isra.0+0x27e/0x49e0 net/ipv6/ipv6_sockglue.c:167
  ipv6_setsockopt+0xfc/0x170 net/ipv6/ipv6_sockglue.c:946
  udpv6_setsockopt+0x68/0xb0 net/ipv6/udp.c:1570
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
  __sys_setsockopt+0x180/0x280 net/socket.c:2046
  __do_sys_setsockopt net/socket.c:2057 [inline]
  __se_sys_setsockopt net/socket.c:2054 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe15476fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458c29
RDX: 0000000000000023 RSI: 0000000000000029 RDI: 0000000000000006
RBP: 000000000073bfa0 R08: 00000000000000e8 R09: 0000000000000000
R10: 00000000200001c0 R11: 0000000000000246 R12: 00007fe1547706d4
R13: 00000000004cd398 R14: 00000000004db3f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
