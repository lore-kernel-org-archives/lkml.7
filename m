Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA40C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6D020665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfHAP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:28:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33468 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:28:08 -0400
Received: by mail-io1-f70.google.com with SMTP id 132so79564558iou.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gCTathP9+deOMTOkoLx5X6Fu8vQedW+V+zFsPJztVaA=;
        b=Ad1pFhPe4HgijXUq5W00AXSKYRkAt3MYEFUUo4JvXasATK0Fzy5Hy7dfLwiSALJnkr
         H6J7nVbbJ/tY/ypzgF8uG2ZeRKOR+pn4eu/kHo/OY3G8WUdkloyw0yAfIzKcCfeD6UQx
         kTxEd5EeZn/rwu5x751EoK61OASYIXEbeO8I6B3r+xh2OkktUcnSWE0nDRMb1kT8j4Yw
         +u5UTEelcPE2QTbkawMS4u64GsawMQM2UlnAnvl8Yw0rpUfvM+LHGSyOWOpvceDMVJiw
         c+TXVRHg4ZYw/TKzngAdYszLkeEYD8MMMtZcbu7aOj3Qvi8Iys4B7wSoK5lkugJ3yCRF
         BESg==
X-Gm-Message-State: APjAAAUFjjDlO9L+MyS3Y1u5J4ILW9kapdowo1Wr7fW5KZjiFpfYXriI
        8hgg3COP40Xnq8RMvLWTMGbvcmtrgAE1JoU8yZpw5+c66lGj
X-Google-Smtp-Source: APXvYqywJxXSx2iBozgpyM03zIqWMN2l1OM3lh1SDKPHzzsQakmbjN/DVYMTJK1ABDjT6KPYQLiFJ3Y2OkyaZAZOxSIOeewZsPfa
MIME-Version: 1.0
X-Received: by 2002:a02:9f07:: with SMTP id z7mr13121827jal.29.1564673287515;
 Thu, 01 Aug 2019 08:28:07 -0700 (PDT)
Date:   Thu, 01 Aug 2019 08:28:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007df502058f0fe3df@google.com>
Subject: WARNING in sysfs_create_file_ns
From:   syzbot <syzbot+5b9bba68c833c84a1135@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12119440600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=5b9bba68c833c84a1135
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1486787fa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa97d8600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5b9bba68c833c84a1135@syzkaller.appspotmail.com

usbvision_audio_off: can't write reg
usb 1-1: usbvision_write_reg: failed: error -2
usb 1-1: usbvision_write_reg: failed: error -2
usb 1-1: usbvision_write_reg: failed: error -2
usb 1-1: usbvision_write_reg: failed: error -2
usb 1-1: usbvision_write_reg: failed: error -2
usbvision_i2c_register: can't write reg
videodev: could not get a free minor
usb 1-1: USBVision[129]: video_register_device() failed
WARNING: CPU: 1 PID: 22 at fs/sysfs/file.c:327  
sysfs_create_file_ns+0x13c/0x1c0 fs/sysfs/file.c:327
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
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
RIP: 0010:sysfs_create_file_ns+0x13c/0x1c0 fs/sysfs/file.c:327
Code: 85 82 00 00 00 41 55 48 8b 7b 30 31 d2 48 89 ee 44 8b 4c 24 50 44 8b  
44 24 40 e8 af f9 ff ff 41 89 c5 58 eb 0d e8 54 85 b6 ff <0f> 0b 41 bd ea  
ff ff ff e8 47 85 b6 ff 44 89 e8 48 ba 00 00 00 00
RSP: 0018:ffff8881d9f97130 EFLAGS: 00010293
RAX: ffff8881d9f88000 RBX: ffff8881cbb0a490 RCX: ffffffff8266f244
RDX: 0000000000000000 RSI: ffffffff8186565c RDI: ffff8881cbb0a490
RBP: ffffffff8779e1a0 R08: ffff8881d9f88000 R09: ffffed103b665d30
R10: ffffed103b665d2f R11: ffff8881db32e97f R12: 1ffff1103b3f2e27
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8881cbb0a4c0
  sysfs_create_file include/linux/sysfs.h:513 [inline]
  device_create_file+0xe6/0x1d0 drivers/base/core.c:1559
  usbvision_create_sysfs drivers/media/usb/usbvision/usbvision-video.c:252  
[inline]
  usbvision_probe.cold+0x1a73/0x1d69  
drivers/media/usb/usbvision/usbvision-video.c:1530
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
