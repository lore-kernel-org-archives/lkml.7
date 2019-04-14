Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08EAC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F8A20848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfDNT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:56:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43206 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:56:06 -0400
Received: by mail-io1-f71.google.com with SMTP id n23so12572949ioj.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 12:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JJk1ISI5HmD3aTUiZDHKLZINh41Fl9C7dn4cVG2mDmU=;
        b=ALrz99m/4oCrbmo1B+Iv+8jhMQ13iiWnZn0VkbpRzjiyMkon+ZhT9IYTXKp/HIdzHJ
         +JDpxxtc87vuS2i7unV5qon+kTISjy3lkklIXQCw+oy4/O++v2G/KsgshHol3F8u+EIh
         vdIeMsMuGkESAyFI0LsLTK012kEZ6oLNKOINzaFrZ1RkA6J/d8CvAHWBZA+/18VwsZ2H
         OFfVSKQAUJqgPIz7WBA3u2k4IKfdtIwmdfuzCmfYznvkvfrLT4cJBkx8pRr4D7i4qv10
         gmkaN+6ggrdGsVeDW+z+6c6ISjMXDboNJmd5lrsSFMLWneYyW2BMyswZGFYUk9hEx8e7
         ih/g==
X-Gm-Message-State: APjAAAU0ELMC/rQZHP5hBhJOArxNyTHiL4aoiIYGYHVuJcWJVl7IEgWz
        GwQo7+ONlB3xA42K6tp2o6YftL5mJPQ4P+CiM9SYLlo7LR77
X-Google-Smtp-Source: APXvYqyiZGgShE1dNbinHI9S0ECWytlREVmnQcPY+2LzFXnBoa/ffIkRcsHuH+kuvyj6rVvzRXFVsVeU7R+TwVQKfzTdSK40725y
MIME-Version: 1.0
X-Received: by 2002:a6b:ea14:: with SMTP id m20mr3297993ioc.33.1555271765630;
 Sun, 14 Apr 2019 12:56:05 -0700 (PDT)
Date:   Sun, 14 Apr 2019 12:56:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ea4d5058682ed7c@google.com>
Subject: WARNING in __flush_work (3)
From:   syzbot <syzbot+2e1ef9188251d9cc7944@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17f389af200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=2e1ef9188251d9cc7944
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dd0fc3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e77a5b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e1ef9188251d9cc7944@syzkaller.appspotmail.com

usb 1-1: config 0 has an invalid interface number: 246 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=06f8, idProduct=300c,  
bcdDevice=68.91
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
WARNING: CPU: 0 PID: 12 at kernel/workqueue.c:3030 __flush_work+0x728/0x820  
kernel/workqueue.c:3030
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  panic+0x29d/0x5f2 kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x130/0x1f0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__flush_work+0x728/0x820 kernel/workqueue.c:3030
Code: ff e8 3c 37 27 00 0f 0b 45 31 e4 e9 7e fd ff ff e8 2d 37 27 00 4c 89  
ef 45 31 e4 e8 f2 a6 bb 0c e9 69 fd ff ff e8 18 37 27 00 <0f> 0b 45 31 e4  
e9 5a fd ff ff e8 b9 47 5e 00 e9 78 fc ff ff e8 cf
RSP: 0018:ffff8880a84b6e48 EFLAGS: 00010293
RAX: ffff8880a84a3100 RBX: ffff888091a6fcb0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff814a8e58 RDI: 0000000000000001
RBP: ffff8880a84b6fb0 R08: ffff8880a84a3100 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000200 R15: ffff888091a6fcc8
  __cancel_work_timer+0x326/0x450 kernel/workqueue.c:3126
  uvc_ctrl_cleanup_device+0x27/0x488 drivers/media/usb/uvc/uvc_ctrl.c:2353
  uvc_delete+0x2e/0x2f0 drivers/media/usb/uvc/uvc_driver.c:1871
  kref_put include/linux/kref.h:67 [inline]
  uvc_probe+0xfa5/0x6588 drivers/media/usb/uvc/uvc_driver.c:2228
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
