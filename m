Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C92DC004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4949520665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfGJLHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:07:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54418 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJLHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:07:10 -0400
Received: by mail-io1-f72.google.com with SMTP id n8so2431513ioo.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 04:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hv0vy7ZJWnUYzBFo0bloao/Xl9soIKCPd2v/8FZXHxc=;
        b=OYZ20rJPKJsq/4FgEXXldRp2wLmyoqk3i28t+Wcs6EiW8rohpLdPf+aDyxECxnuIrj
         f5z32FUBZiTF0Cyu2/ePjBs8sGT1yttnXO3jVduXWxod+iFlItyWS/7nwe+bL3EZ3qt1
         iommWOPzUlicXdncdCbTiGif16e2S5BuaHstbewcbPzU8HFbdtww86rKNLsQpNxklyfV
         vZYUUu8DqVlXRJZ5D3LEfF0AFvRpVYgF4OVhePW1m6lfO8eNzFrzD1grgjJOIaCqRfey
         Urss1unmlfY68x7R3gJuDrIka68EAICAFBPMS/MmrQAQHjlB8dJzxy2GoEfILrCzWZLo
         kjRw==
X-Gm-Message-State: APjAAAWVRjb+fx/FtrudsASb9Jj/8UWTG3tIQbNI7zkySVxLzrYneS1I
        83AAlMJTYPgYZ62GpEvhOp/yvGj5TC722lFVayczTYIjNM8A
X-Google-Smtp-Source: APXvYqxEEGS/ghj/1vE7ea05Uht+o+rbVNxtrazAxFRZpWclqstSRdP+wA0klStRB8FjeBzTQnxuUoHvqJ74LwHD6lvYE/I45Zuk
MIME-Version: 1.0
X-Received: by 2002:a6b:6001:: with SMTP id r1mr6903652iog.229.1562756828714;
 Wed, 10 Jul 2019 04:07:08 -0700 (PDT)
Date:   Wed, 10 Jul 2019 04:07:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a55d7d058d51ad4f@google.com>
Subject: WARNING in gpio_to_desc
From:   syzbot <syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=136a97d8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=cf35b76f35e068a1107f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15660838600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ff38cfa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com

usb 1-1: config 0 interface 60 altsetting 0 bulk endpoint 0x2 has invalid  
maxpacket 0
usb 1-1: New USB device found, idVendor=1286, idProduct=2046,  
bcdDevice=33.1a
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: NFC: intf 000000003523355a id 0000000011a20f39
nfcmrvl 1-1:0.60: NFC: failed to request reset_n io
------------[ cut here ]------------
invalid GPIO -22
WARNING: CPU: 1 PID: 21 at drivers/gpio/gpiolib.c:124 gpio_to_desc  
drivers/gpio/gpiolib.c:124 [inline]
WARNING: CPU: 1 PID: 21 at drivers/gpio/gpiolib.c:124  
gpio_to_desc+0x152/0x1f0 drivers/gpio/gpiolib.c:106
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
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
RIP: 0010:gpio_to_desc drivers/gpio/gpiolib.c:124 [inline]
RIP: 0010:gpio_to_desc+0x152/0x1f0 drivers/gpio/gpiolib.c:106
Code: 00 00 77 13 e8 cf e0 57 ff 4c 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3  
e8 bc e0 57 ff 89 ee 48 c7 c7 80 24 db 85 e8 59 a5 2d ff <0f> 0b eb d6 e8  
a5 e0 57 ff 48 c7 c7 80 d6 08 87 4c 89 f6 e8 f6 23
RSP: 0018:ffff8881d9eff138 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881d1605180 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3dfe19
RBP: 00000000ffffffea R08: ffff8881d9e36000 R09: ffffed103b663ed7
R10: ffffed103b663ed6 R11: ffff8881db31f6b7 R12: ffff8881d1605180
R13: 0000000000000000 R14: 0000000000000293 R15: 0000000000000000
  __gpio_set_value include/asm-generic/gpio.h:104 [inline]
  gpio_set_value include/linux/gpio.h:71 [inline]
  nfcmrvl_chip_halt+0x4e/0x70 drivers/nfc/nfcmrvl/main.c:259
  nfcmrvl_nci_register_dev+0x2d4/0x378 drivers/nfc/nfcmrvl/main.c:176
  nfcmrvl_probe+0x4e9/0x5e0 drivers/nfc/nfcmrvl/usb.c:344
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
