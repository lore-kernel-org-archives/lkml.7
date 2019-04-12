Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64090C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA5A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDLLgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:36:12 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56405 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:36:10 -0400
Received: by mail-io1-f69.google.com with SMTP id s184so7426805iod.23
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GfwWtpxZv1KFsNKObVJx10mGAy4qc7pgRbpgWUSqvHs=;
        b=aho7evkhMNLqiIlTsp7TOcFxHrx+aStrSjySZje7ulpgvp9iYy+a8lJoqQjf97kxuz
         cWJN+0q+qPSnCN99PFtXswauBpbBL9avxAan4SD6L4/D0bajmCRfnvOwWMB1hyNI/afx
         q8vhiQykGJ9Fe5hAUjbC+r4dTEpKBCoIdaLSv5lPjZzJ1I+ZNPUpYlBxpJA7XgvVBR9u
         NGgZWcgaj70p/rlT/pBDDHbtnA2fQIZXfIy53BOn4pVTtahIPhct1W0bwzAH6qFiuZYb
         ngCH+94j53f/4j7vhOCYrTq3ebL/g06/gMM8oYAslDqWZb09CXlTA2spS09DBLWCPms2
         6F1g==
X-Gm-Message-State: APjAAAVx2sq9Th4p6jbaNHq2XZVi/5cQDp2hAdRAAsqL8SBCZrqDzj6w
        njrBcSXQcBImB/J0j4asEi5kCTa5f4jZxP2/zK6HZx3WBdJN
X-Google-Smtp-Source: APXvYqxcslBAK0d3+Zl7E7AV3t0p1TAbDibqSqf/z2WrL1CTT/TSgolY0wIC5U2lvYqLMMfEVxUEzzbZMxtRCceb2KZEIQCRqjbb
MIME-Version: 1.0
X-Received: by 2002:a5e:8c1a:: with SMTP id n26mr2217188ioj.16.1555068969668;
 Fri, 12 Apr 2019 04:36:09 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:36:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089dace058653b58e@google.com>
Subject: WARNING in spi_register_controller
From:   syzbot <syzbot+c60ddb60b685777d9d59@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1128acd3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=c60ddb60b685777d9d59
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b274b200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108c0cd3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c60ddb60b685777d9d59@syzkaller.appspotmail.com

usb 3-1: config 0 has an invalid interface number: 104 but max is 0
usb 3-1: config 0 has no interface number 0
------------[ cut here ]------------
couldn't get idr
usb 3-1: New USB device found, idVendor=1df7, idProduct=2500,  
bcdDevice=a9.67
WARNING: CPU: 0 PID: 534 at drivers/spi/spi.c:2307  
spi_register_controller+0xf0b/0x1150 drivers/spi/spi.c:2307
usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 534 Comm: kworker/0:2 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
usb 5-1: New USB device found, idVendor=1df7, idProduct=2500,  
bcdDevice=a9.67
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  panic+0x29d/0x5f2 kernel/panic.c:214
usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 6-1: New USB device found, idVendor=1df7, idProduct=2500,  
bcdDevice=a9.67
usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 5-1: config 0 descriptor??
  __warn.cold+0x20/0x48 kernel/panic.c:571
usb 3-1: config 0 descriptor??
  report_bug+0x262/0x2a0 lib/bug.c:186
usb 6-1: config 0 descriptor??
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x130/0x1f0 arch/x86/kernel/traps.c:272
usb 1-1: config 0 descriptor??
  do_invalid_op+0x37/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:spi_register_controller+0xf0b/0x1150 drivers/spi/spi.c:2307
Code: ff ff e8 98 e5 00 fb e9 37 f2 ff ff 4c 89 ef e8 ab e5 00 fb e9 c3 f2  
ff ff e8 11 d5 c9 fa 48 c7 c7 c0 34 3b 8f e8 a5 d1 9b fa <0f> 0b bf e4 ff  
ff ff 44 89 e6 e8 66 d6 c9 fa 41 83 fc e4 b8 f0 ff
RSP: 0018:ffff88809f7b7258 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed1013ef6e3d
RBP: ffff888099200000 R08: ffff88809f510000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffe4
R13: ffff888099200428 R14: 1ffff11013ef6e50 R15: ffff888099200000
  msi2500_probe+0x78e/0xba1 drivers/media/usb/msi2500/msi2500.c:1257
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
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
