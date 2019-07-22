Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A0C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7FE218A0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfGVMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:38:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35885 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfGVMiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:38:08 -0400
Received: by mail-io1-f71.google.com with SMTP id k21so43367318ioj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 05:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XN7mQ/LbwS2GODYkDwnmvqmvNwPxxRZ0Psf5NFa9KBE=;
        b=sOxxWil9UJvKNuZPRp4J27mfcd8r/fjMjAb2IDolWORaUbbbRJazcvaMNjhCqddygP
         hEFXyrXyjzd81LuQVsJx4wgJ4KBGa7xTlGdWTZ8StxXkk49Ph6QiDnegiOjpFFeYJ4I8
         nrPaNt2qU0Nll2p0o/hFl/TIfrrqInNFry212sw6V0RYXQinTXc1ZXKMqAJh/Nx2Jhr2
         /JYk0NJ4muX/CG+bX+MJuZfSU76bhneqlkJVaGnje8s5GRgmWEzwdBt9+5lb5VF4UFkB
         fdVlogj7TMaCc4Cwixqq2e1RunzBeFTbWaip0TWYaPTmDdt0QOKe+CXtBWmbMRoEX+8H
         5agg==
X-Gm-Message-State: APjAAAVqgUbpYxaHnY1SwhlXNsmQcO5K/dZbanU4EX+Wx3+Jodu8kwCY
        UCt6Uv2+b4se6orK2QRhzfP/XTGTJOLZwhSs0YQPjr6YJfNm
X-Google-Smtp-Source: APXvYqzLgm7H+0s4vjrNik4iYDGcdItZNbvxNBMTEFEnQ3ka+wAyuLJOjfoii/Kln7+76lgFX66PYizRZuXfL4C3T/GD3RYvn5c2
MIME-Version: 1.0
X-Received: by 2002:a5d:9749:: with SMTP id c9mr67412596ioo.258.1563799086829;
 Mon, 22 Jul 2019 05:38:06 -0700 (PDT)
Date:   Mon, 22 Jul 2019 05:38:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000121ea5058e445936@google.com>
Subject: WARNING in shark_write_val/usb_submit_urb
From:   syzbot <syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=138da9d0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=1cb937c125adb93fad2d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159ab958600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177bd6afa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com

usb 1-1: string descriptor 0 read error: -22
usb 1-1: New USB device found, idVendor=077d, idProduct=627a, bcdDevice=  
0.01
usb 1-1: New USB device strings: Mfr=1, Product=64, SerialNumber=255
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 /drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #15
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
RSP: 0018:ffff8881d9efefe0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3dfdee
RBP: ffff8881d41e5e60 R08: ffff8881d9e36000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881cff4cbd0 R14: ffff8881d7b33c20 R15: ffff8881d41c9b00
  usb_start_wait_urb+0x108/0x2b0 /drivers/usb/core/message.c:57
  usb_bulk_msg+0x228/0x550 /drivers/usb/core/message.c:253
  shark_write_val+0x20b/0x310 /drivers/media/radio/radio-shark.c:94
  snd_tea575x_write+0x78/0x330 /drivers/media/radio/tea575x.c:88
  snd_tea575x_hw_init+0x8d/0x170 /drivers/media/radio/tea575x.c:506
  snd_tea575x_init+0x1f/0x6b8 /drivers/media/radio/tea575x.c:521
  usb_shark_probe+0x5e1/0x770 /drivers/media/radio/radio-shark.c:353
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
