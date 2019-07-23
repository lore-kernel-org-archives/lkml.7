Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C276C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA912070B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbfGWR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:28:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46029 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732572AbfGWR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:28:06 -0400
Received: by mail-io1-f70.google.com with SMTP id e20so47636077ioe.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VS4Bt6gRUI0iCEjeclK/MehYBe9DRzG6KUlRpmzHu8M=;
        b=dRfHt7b/l1d4kRfF0mHPPJXTPx+htJHI5dcB7agz90vKJoMsxXVoXiyU/+IM65g+X0
         xtn1mjyPPfhClFHsWwfLM5hyZhLiMld8EanNVdK2ypqDglSoWijkDTQz3fafHh2Bzddy
         p1JU+hflxzh8weeCJU9dg9ir/ruUCWw/bD8vbcA6sccQwLeWPFFGck1HQF9jEzmq43k9
         NyFDhbWkZZBXhFu2FB2+3tA1z7JYXQmU15VIkLOzGJynhUycDKQ9LX81cxRAjP1sNSrG
         cjfSEKDxbE4inh3LE/OZcDG7KxDG0nyu83cVbipnGlNtJqsIjKgNa//sSXneScs3Z277
         jrwA==
X-Gm-Message-State: APjAAAXLgPc8pjMZMTC6MMMo3wVmVN/6R0YYw9U8aYfgCBqodlafvDbY
        Kh5fZ5dXVwfMxdg6duOPRM4KiVOqKeEEhRCCZ7DI1sEdeI2O
X-Google-Smtp-Source: APXvYqz3I7VwxAcfIyrDbyi76ZQCOvr6DAJmvT6nhYP5CjKnbmHNILNt8mQOIdlnbE0JpEUBmdlHYXZKJMZ54PRsIus0xGmXId/o
MIME-Version: 1.0
X-Received: by 2002:a6b:6505:: with SMTP id z5mr68888857iob.295.1563902885918;
 Tue, 23 Jul 2019 10:28:05 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa7ce2058e5c8318@google.com>
Subject: WARNING in kbtab_open/usb_submit_urb
From:   syzbot <syzbot+c7df50363aaff50aa363@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10334194600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=c7df50363aaff50aa363
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17309e94600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10929358600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c7df50363aaff50aa363@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 1732 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 /drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 1732 Comm: syz-executor835 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e /lib/dump_stack.c:113
  panic+0x292/0x6c9 /kernel/panic.c:219
  __warn.cold+0x20/0x4b /kernel/panic.c:576
  report_bug+0x262/0x2a0 /lib/bug.c:186
  fixup_bug /arch/x86/kernel/traps.c:179 [inline]
  fixup_bug /arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 /arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 /arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 /arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 /drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 f8 d3 f4 fd 4c 89 f7 e8 a0 51 1c ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 00 0e f7 85 e8 83 98 ca fd <0f> 0b e9 20 f4  
ff ff e8 cc d3 f4 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d06bf878 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103a0d7f01
RBP: ffff8881d0bf5500 R08: ffff8881d2678000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881d40b58a0 R14: ffff8881d0904d20 R15: ffff8881d3cd9900
  kbtab_open+0xd5/0x130 /drivers/input/tablet/kbtab.c:96
  input_open_device+0x170/0x280 /drivers/input/input.c:607
  evdev_open_device /drivers/input/evdev.c:433 [inline]
  evdev_open+0x3fe/0x510 /drivers/input/evdev.c:518
  chrdev_open+0x219/0x5c0 /fs/char_dev.c:413
  do_dentry_open+0x497/0x1040 /fs/open.c:778
  do_last /fs/namei.c:3416 [inline]
  path_openat+0x1430/0x3ff0 /fs/namei.c:3533
  do_filp_open+0x1a1/0x280 /fs/namei.c:3563
  do_sys_open+0x3c0/0x580 /fs/open.c:1070
  do_syscall_64+0xb7/0x560 /arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4010c0
Code: 01 f0 ff ff 0f 83 00 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d cd 4c 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 d4 0a 00 00 c3 48 83 ec 08 e8 3a 00 00 00
RSP: 002b:00007ffd69a61888 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004010c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd69a61890
RBP: 6666666666666667 R08: 000000000000000f R09: 000000000000000b
R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000402020
R13: 00000000004020b0 R14: 0000000000000000 R15: 0000000000000000
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
