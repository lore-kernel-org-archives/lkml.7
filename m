Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19312C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27D020823
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbfGWMsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:48:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36113 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389889AbfGWMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:48:09 -0400
Received: by mail-io1-f72.google.com with SMTP id k21so47080768ioj.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kqXTj+6f49PDfJPlB8PBCd63qCEOjYJY7TBdn4RTdjI=;
        b=ccWyVzsB6t0Ae02MVZIflakgh7fuy2q0xUIUCz+AIZ60vL7ytWcpgNZyydi4/eaDNJ
         NxAJxOWt0pB+89oszTtIn0BIDEiJaAcXnrGUZ1OphzCzsngA5uf7NRTauWEvVKpT8eLF
         TMPKvyf4nxgHhOoguBeaAxTwQUDatGeA/e66TyrkonUceHP3fJLt5EHwibkhEx9cbaBx
         iJzA3RaMjGR+P+GwRX49T5jfj3ZbKkzuys8ueogWtrq/4fAf7YTiQbwAsq5MYHN8JT0n
         YYz5Rdp/0C8HFRq+tjZFoLtmM2lPEVBo5lLqEqBNzecSSQmzr09nWvU0y4uD8cZR2/64
         QzYQ==
X-Gm-Message-State: APjAAAVg/RgimxGrpw2Hd7CCsXakTuycKdv1spBMtts4X0VWCx8X0VI+
        NBYX2QX9vMTApHh2Ot+08i9aqBy19fJG8dg9yKfXVpyPAAbb
X-Google-Smtp-Source: APXvYqwXulfXVoWbR0TwgY7cZzLIIqOnxttGO4gAD/ey+Uxgl+XQVHYDed48gYLzajdmhNHWmsFJOVf1lfzW8n4GV0U7wGQKoNvZ
MIME-Version: 1.0
X-Received: by 2002:a6b:901:: with SMTP id t1mr61652689ioi.42.1563886088334;
 Tue, 23 Jul 2019 05:48:08 -0700 (PDT)
Date:   Tue, 23 Jul 2019 05:48:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3b67c058e589ada@google.com>
Subject: WARNING in usbvision_write_reg/usb_submit_urb
From:   syzbot <syzbot+1fe821ea9f66c0df9cbf@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17daca64600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=1fe821ea9f66c0df9cbf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113dda44600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174d46f4600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1fe821ea9f66c0df9cbf@syzkaller.appspotmail.com

usb 1-1: config 0 interface 237 altsetting 0 endpoint 0x83 has an invalid  
bInterval 0, changing to 7
usb 1-1: New USB device found, idVendor=0573, idProduct=4d21,  
bcdDevice=83.91
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usbvision_probe: Hauppauge WinTV USB Pro (PAL B/G) found
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 2 != type 1
WARNING: CPU: 0 PID: 12 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 /drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
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
RSP: 0018:ffff8881d9e0f030 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3c1df8
RBP: ffff8881d946d900 R08: ffff8881d9df9800 R09: ffffed103b645d30
R10: ffffed103b645d2f R11: ffff8881db22e97f R12: 0000000000000002
R13: ffff8881ce015c90 R14: ffff8881d08bd5a0 R15: ffff8881d946d700
  usb_start_wait_urb+0x108/0x2b0 /drivers/usb/core/message.c:57
  usb_internal_control_msg /drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 /drivers/usb/core/message.c:152
  usbvision_write_reg+0x175/0x1f0  
/drivers/media/usb/usbvision/usbvision-core.c:1383
  usbvision_audio_off+0x1e/0xc0  
/drivers/media/usb/usbvision/usbvision-core.c:2183
  usbvision_configure_video  
/drivers/media/usb/usbvision/usbvision-video.c:1393 [inline]
  usbvision_probe.cold+0x120d/0x1d69  
/drivers/media/usb/usbvision/usbvision-video.c:1527
  usb_probe_interface+0x305/0x7a0 /drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 /drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
  __device_attach+0x217/0x360 /drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
  device_add+0xae6/0x16f0 /drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 /drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 /drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 /drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 /drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
  __device_attach+0x217/0x360 /drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
  device_add+0xae6/0x16f0 /drivers/base/core.c:2111
  usb_new_device.cold+0x6a4/0xe61 /drivers/usb/core/hub.c:2536
  hub_port_connect /drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
  port_event /drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1abd/0x3550 /drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
  kthread+0x30b/0x410 /kernel/kthread.c:255
  ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
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
