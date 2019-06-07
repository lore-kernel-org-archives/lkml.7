Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C263C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6B212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfFGKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:33:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48687 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfFGKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:33:06 -0400
Received: by mail-io1-f72.google.com with SMTP id z19so1320356ioi.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 03:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ri4kh7VquzQYNilePfGGXnzZVizwUC0xdIzwwyPw8Jg=;
        b=jpS7VCrAvV89GHffjz0BRJSt94iDpuLU8sOoKi1i8RpgHjPwAPpjHIfCxrtKz6ER2t
         zHvn7ogrfk+5MIQ4uaK635BA8p22ZNdeOGVOK0G3ZdoaZ4e6m6DOJdN97O2cKcOeg3X9
         kG6JjDAYKpEc12Gq7w+zuolWB1q6nj3Yixu+crqNt53n2AJdtjodi4XpB67fmeP8wUek
         6LuNBWAqPAp5mvoSn12hKU0kHftlVRv7mIB1Sw2Jx7argoxTMSX9VQ8S2V7FYP2ObHJk
         pq+kj9lldMAWZk2GhNq70so0MTPTyOwY1SzUEqREKMBvkOV+zqSFBG3+T+bjdGV+PavI
         Bdtw==
X-Gm-Message-State: APjAAAX6aDnRr4233vi1H/BMuSw86PH2YQEZ6iIm/wU/6MYDaq7V0C+2
        JRmPA+FTEvwMxDSdxjItiOJ5XQj//QeHxlAQC6p9YVW/kkzg
X-Google-Smtp-Source: APXvYqz7hpzC/Wwk28PWg8lXyteCwaKt3jO1uHe0MugGYuLjvuUNM6Y2WZYY5/UVNtioKknfPPXueJwCtwNp0qFraRWi/sDpHdOW
MIME-Version: 1.0
X-Received: by 2002:a6b:b488:: with SMTP id d130mr27708772iof.58.1559903585612;
 Fri, 07 Jun 2019 03:33:05 -0700 (PDT)
Date:   Fri, 07 Jun 2019 03:33:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001abc1c058ab95b3e@google.com>
Subject: WARNING in aiptek_open/usb_submit_urb
From:   syzbot <syzbot+75cccf2b7da87fb6f84b@syzkaller.appspotmail.com>
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

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=140186c1a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
dashboard link: https://syzkaller.appspot.com/bug?extid=75cccf2b7da87fb6f84b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e01351a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16573351a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75cccf2b7da87fb6f84b@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 237 altsetting 0 bulk endpoint 0x83 has invalid  
maxpacket 255
usb 1-1: New USB device found, idVendor=08ca, idProduct=0022,  
bcdDevice=6d.4a
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
aiptek 1-1:0.237: Aiptek using 400 ms programming speed
input: Aiptek as  
/devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.237/input/input5
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 108 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 108 Comm: kworker/0:2 Not tainted 5.2.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:218
  __warn.cold+0x20/0x4b kernel/panic.c:575
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 b8 06 e9 fd 4c 89 f7 e8 c0 44 13 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 20 1c 1a 86 e8 03 db be fd <0f> 0b e9 20 f4  
ff ff e8 8c 06 e9 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d41bf020 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127e98d RDI: ffffed103a837df6
RBP: ffff8881d246dc80 R08: ffff8881d7b4e000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881d170ee10 R14: ffff8881d05b4d20 R15: ffff8881d42c4300
  aiptek_open+0xd5/0x130 drivers/input/tablet/aiptek.c:843
  input_open_device+0x170/0x280 drivers/input/input.c:611
  kbd_connect+0xfe/0x160 drivers/tty/vt/keyboard.c:1547
  input_attach_handler+0x194/0x200 drivers/input/input.c:1004
  input_register_device.cold+0xf5/0x246 drivers/input/input.c:2159
  aiptek_probe.cold+0x286/0x30d drivers/input/tablet/aiptek.c:1886
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
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
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
