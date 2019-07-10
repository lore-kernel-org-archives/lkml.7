Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E680DC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F5F20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfGJLHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:07:23 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50522 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfGJLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:07:09 -0400
Received: by mail-io1-f70.google.com with SMTP id m26so2447482ioh.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 04:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ogn6J9wBnNd+qiyGp5MPo0aVOG3dSwUiE1ddTm3jyXw=;
        b=Wb0D84NHSXFi2m0TueCZskdgBjHqTFD2t/BYOjBkIEAUgY96CmgeWvHWlAF+KCcImp
         5nv6eX4xy84lKHDnDCCjELFMT1ES/XCbRJYhZbvwOkEKkGR6trYWe+ZXrN8/zx2dcqIW
         0iEuqWTj1ko4fNrb/uqm2agEOC3ookVAINAaDwUwEyTgiBy9JE269q7qmAqrLy4TCq5/
         3fh3pZYgjnQFWJkQuOkO42Nyx9Nmc19zTirGpfXUv8LQAkf34WNnUgzZZMAsR7Mt5i+D
         wSP5Ha2dD/Fczr1Ir7CBbOuITcs8Mf4ihg8/Ks6xyxM0eFDMqO11S7HkiNyrN6cFgmGv
         lkag==
X-Gm-Message-State: APjAAAWhLWk+7p3d55rJW4S43MsRolYQB8ZRKkCBV7bRlWlOFY6D5A2I
        K87uwNW0gFFGy1aTmLvH68Kt2e2wY0jvlvCMKRLXS6Uo3Zb9
X-Google-Smtp-Source: APXvYqxDN4HBNpz8tVe81MedwIcb26MRg6Xs059pfF4x67YZXT2usgGsomZf9MGHLhmGqe0qBo7wTuNGfSX9RV7NI0BLFO0tJL1D
MIME-Version: 1.0
X-Received: by 2002:a6b:b7d5:: with SMTP id h204mr30444814iof.188.1562756828952;
 Wed, 10 Jul 2019 04:07:08 -0700 (PDT)
Date:   Wed, 10 Jul 2019 04:07:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a901ed058d51adc3@google.com>
Subject: WARNING in iforce_get_id_packet/usb_submit_urb
From:   syzbot <syzbot+9584b712baf1965b590c@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6b3f8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=9584b712baf1965b590c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d09e28600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1410e1f7a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9584b712baf1965b590c@syzkaller.appspotmail.com

usb 1-1: config 0 interface 47 altsetting 0 bulk endpoint 0x8A has invalid  
maxpacket 0
usb 1-1: New USB device found, idVendor=061c, idProduct=c0a4,  
bcdDevice=4e.a0
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
URB 0000000044363614 submitted while active
WARNING: CPU: 0 PID: 12 at drivers/usb/core/urb.c:362  
usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
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
RIP: 0010:usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
Code: 89 de e8 72 dd e8 fd 84 db 0f 85 42 f6 ff ff e8 35 dc e8 fd 4c 89 fe  
48 c7 c7 00 23 1a 86 c6 05 4b 78 57 04 01 e8 ca a0 be fd <0f> 0b e9 20 f6  
ff ff c7 44 24 14 01 00 00 00 e9 d7 f6 ff ff 41 bd
RSP: 0018:ffff8881d9e0f010 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3c1df4
RBP: ffff8881d4b67d00 R08: ffff8881d9df9800 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881cf2c9980
R13: 00000000fffffff0 R14: ffffffff862df820 R15: ffff8881d4b67d00
  iforce_get_id_packet+0x19c/0x52c  
drivers/input/joystick/iforce/iforce-packets.c:238
  iforce_init_device+0x391/0x138d  
drivers/input/joystick/iforce/iforce-main.c:293
  iforce_usb_probe+0x97c/0xd90 drivers/input/joystick/iforce/iforce-usb.c:163
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
