Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D964BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ED0214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKHNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:54:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36625 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKHNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:54:10 -0500
Received: by mail-il1-f199.google.com with SMTP id m16so184700ilh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9njApmrwBTyGtT2rIls1ibfEyGXQv7MJRF4nex5faGk=;
        b=Cfzm2394adf+7XUmEccp9qZVN8nWGPGTwkI216vl5dNtEYedls03OZLhXp6Oesfk0M
         My2tX8YYPvBV1do/Eq0wdf5XmAK+ZN6hNw0Ibj2ipdZld5wch6s2JsvH9Of22N4XDAAA
         dgNyB7sRZOg+05/hQmyH+AqX31+aPwaBq/nRz9XHtZVd30gS8YcnGiKcCf0ec4AXMnAL
         czAgjCH8RItX/PLH8PUOHJ1s0esBbtxWI+ppDm5bgpB9Y8K1GrmIOf2UqrgFbmy1hGR9
         0TtWWvP9azdub17jHkZIhfo1jW5fe4EuWNHda2bwiOCkse25yD6EvIz3L194bHgZGQ2Q
         8imA==
X-Gm-Message-State: APjAAAU9R7LrEr9kQ7fNrRjyJFKbz0oHpbiZHYjIqzVdfNJqZfo07ggY
        A2ugul57Z8A8SWjNxxKqvBIGUihiF1tj5X8kqBuHjs81WfqR
X-Google-Smtp-Source: APXvYqycgefMdj0hGu446AltJ4RBPS/dLbn2ZzGFB36mPnHIinSpfjR94NhDkoQ6fYZAwULXQr1preCiY24Kd4PVHM+xtStz9wON
MIME-Version: 1.0
X-Received: by 2002:a92:3651:: with SMTP id d17mr12787422ilf.268.1573221248158;
 Fri, 08 Nov 2019 05:54:08 -0800 (PST)
Date:   Fri, 08 Nov 2019 05:54:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a654800596d61d1d@google.com>
Subject: WARNING in bcm5974_start_traffic/usb_submit_urb
From:   syzbot <syzbot+348331f63b034f89b622@syzkaller.appspotmail.com>
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

HEAD commit:    d60bbfea usb: raw: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1645164ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
dashboard link: https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687e4aae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1508a272e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 5-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 1758 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 1758 Comm: syz-executor078 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2aa/0x6e1 kernel/panic.c:221
  __warn.cold+0x2f/0x33 kernel/panic.c:582
  report_bug+0x27b/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 b8 21 ef fd 4c 89 f7 e8 40 34 1f ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 40 77 14 86 e8 cd bc c4 fd <0f> 0b e9 20 f4  
ff ff e8 8c 21 ef fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881ced9f850 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128c9cd RDI: ffffed1039db3efc
RBP: ffff8881d03f4800 R08: ffff8881cfa80000 R09: fffffbfff11ab3b5
R10: fffffbfff11ab3b4 R11: ffffffff88d59da7 R12: 0000000000000001
R13: ffff8881caa9c990 R14: ffff8881cfe990a0 R15: ffff8881d52d5900
  bcm5974_start_traffic drivers/input/mouse/bcm5974.c:799 [inline]
  bcm5974_start_traffic+0xbd/0x170 drivers/input/mouse/bcm5974.c:783
  bcm5974_open+0x9f/0x160 drivers/input/mouse/bcm5974.c:839
  input_open_device+0x16c/0x2c0 drivers/input/input.c:623
  evdev_open_device drivers/input/evdev.c:414 [inline]
  evdev_open+0x3fe/0x510 drivers/input/evdev.c:499
  chrdev_open+0x219/0x5c0 fs/char_dev.c:414
  do_dentry_open+0x494/0x1120 fs/open.c:797
  do_last fs/namei.c:3408 [inline]
  path_openat+0x1430/0x3ff0 fs/namei.c:3525
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_sys_open+0x3c0/0x580 fs/open.c:1097
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x406781
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 18 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fac82b3e820 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000406781
RDX: 0000000000000000 RSI: 0000000000000300 RDI: 00007fac82b3e8d0
RBP: 00000000006dcc40 R08: 00007fac82b3e830 R09: 00000000006dcc40
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000006dcc4c
R13: 00007ffea0a0004f R14: 00007fac82b3f9c0 R15: 00000000006dcc40
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
