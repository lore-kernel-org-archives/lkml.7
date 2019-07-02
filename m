Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE0C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240121721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBP1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:27:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35785 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGBP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:27:07 -0400
Received: by mail-io1-f70.google.com with SMTP id w17so19237568iom.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0X3TCO1su/kGqXMIRUoaNL5vt0ixUM5T6mGPngF8Nvc=;
        b=Wb5elxey4WS5z6BKQ94FzDPskeEytIsqWy9tZmBCB1oXzZoAyknAMyJoI8pLni/Qbv
         8anh//GYbyH17F2YXrfnkz+qXPdpAoI/5bskUpowv7AoB/XXwi7BXvOeeJge7otnyG38
         nywtqEuN6/RKfCc2eZ/EyNOC6nEuWfiTLrYbiTLy9ynVqVdXcNLeTC/kk548psqlGXxv
         PJLxq5+iUmhy6ekWZGQrjpRQ269Ci8O1urYWR3iaLpwPxRzvMkuq0wgQw85Ts91Br/pw
         xpCq3G8asw15y/EbgZXLkmdIseRYspqt65TXADMTwgeLTPf/uRmrHEU2PeJ2ubYSgyWB
         FR3A==
X-Gm-Message-State: APjAAAURa0ZRHG3Zc+gD53x9KsXIxNc0pg6AOn3FJpB72DL/FZkrM4cS
        ArfHJkUHE583u+t1KwQ846FRqYKEAvVzLnZFxYgtk93CL6iu
X-Google-Smtp-Source: APXvYqxcRzXZZ5aOvB/tQXfy8kQwcP/ODUzWbM5JT8tLzIyegjNyREyloqqVxALzNn2X0WSa56IC0ckTkRcyKO+05HQ7on/CzRFc
MIME-Version: 1.0
X-Received: by 2002:a5d:8447:: with SMTP id w7mr34696184ior.197.1562081226696;
 Tue, 02 Jul 2019 08:27:06 -0700 (PDT)
Date:   Tue, 02 Jul 2019 08:27:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0b1df058cb460c8@google.com>
Subject: WARNING in sisusb_send_bulk_msg/usb_submit_urb
From:   syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>
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

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4cb55a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123963d9a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com

usb 6-1: USB2VGA dongle found at address 2
usb 6-1: Allocated 8 output buffers
------------[ cut here ]------------
usb 6-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 12 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:219
  __warn.cold+0x20/0x4b kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 78 db e8 fd 4c 89 f7 e8 a0 36 13 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 80 23 1a 86 e8 03 a0 be fd <0f> 0b e9 20 f4  
ff ff e8 4c db e8 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d9e0ed28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3c1d97
RBP: ffff8881d0662f00 R08: ffff8881d9df9800 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff8881d3c5ebe8 R14: ffff8881c70d11a0 R15: ffff8881d0670700
  sisusb_bulkout_msg drivers/usb/misc/sisusbvga/sisusb.c:238 [inline]
  sisusb_send_bulk_msg.constprop.0+0x88a/0x1030  
drivers/usb/misc/sisusbvga/sisusb.c:393
  sisusb_send_bridge_packet.constprop.0+0x11c/0x240  
drivers/usb/misc/sisusbvga/sisusb.c:581
  sisusb_do_init_gfxdevice+0x8a/0x450  
drivers/usb/misc/sisusbvga/sisusb.c:2137
  sisusb_init_gfxdevice+0xe0/0x18d0 drivers/usb/misc/sisusbvga/sisusb.c:2237
  sisusb_probe+0x924/0xbcb drivers/usb/misc/sisusbvga/sisusb.c:3122
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
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
