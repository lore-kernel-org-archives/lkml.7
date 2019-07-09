Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E18C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A2214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfGIM1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:27:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35695 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfGIM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:27:09 -0400
Received: by mail-io1-f69.google.com with SMTP id w17so22880601iom.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wGE+pCqM9U0ThSNlShzZqZmZ/rkFAVz8zcYOE/85xRI=;
        b=SiRycQaynYDh55Qas4oHuf1n/rDy+zoBGjPTROMYXjIVcawId/XyxPGe+Ciwd3g1CL
         QpVtCaLN/LLkJJVw8V0ZWyQaO0d29A6yT25O2xnboAkwDMeL0AZkk/Us53VBtr+K/7us
         WUCKyDW0WqPPsDYfRa9ce47iOc5zk1fUfIs07p2UeYp/8nsfTaAY7tjVtYrav5+pE7yR
         wqRizYt8JwwpWF85lx+zYUSzlTSYT6DfsUCCw3SuGX1h1Oz/ATZBg3OnBEsoUj0PBFPM
         VUwe4ZzCz8JxRRBJyjdLS+cwbewqVZ1HielGXABUYN3Z5Djz+DzrWCaz/lZuzWKqLgaR
         ve4w==
X-Gm-Message-State: APjAAAW8M2OBFwRgXdK+q4ilWvN0wTpk0qjEcXtnz8754gVksXlenf/l
        N8SSaUBs8883WKMB5/7SEPa/w0zprs3reGyGhhp1AOzSqfQ4
X-Google-Smtp-Source: APXvYqyJduRQ0pZSIv4d/Cm75e5pIKiDdbVdx0Z+vvh/sHEoBoIiKAz5RHZbmnGKqpg5iiPceGBd55nVJrN/8kZ2+tL6lAyx6i2Q
MIME-Version: 1.0
X-Received: by 2002:a5e:881a:: with SMTP id l26mr7422864ioj.185.1562675228577;
 Tue, 09 Jul 2019 05:27:08 -0700 (PDT)
Date:   Tue, 09 Jul 2019 05:27:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e617ad058d3eade5@google.com>
Subject: WARNING in vmk80xx_write_packet/usb_submit_urb
From:   syzbot <syzbot+5205eb2f17de3e01946e@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=160f6aaba00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=5205eb2f17de3e01946e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b8dc15a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d8cbb3a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5205eb2f17de3e01946e@syzkaller.appspotmail.com

usb 1-1: config 0 interface 104 altsetting 0 bulk endpoint 0x2 has invalid  
maxpacket 1
usb 1-1: New USB device found, idVendor=10cf, idProduct=5502,  
bcdDevice=32.ff
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 22 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
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
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 78 db e8 fd 4c 89 f7 e8 a0 36 13 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 80 23 1a 86 e8 03 a0 be fd <0f> 0b e9 20 f4  
ff ff e8 4c db e8 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d9f8eff8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3f1df1
RBP: ffff8881d9ae5a50 R08: ffff8881d9e63000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881d3801e88 R14: ffff8881cf0391a0 R15: ffff8881d9ae5800
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_bulk_msg+0x228/0x550 drivers/usb/core/message.c:253
  vmk80xx_write_packet+0x1df/0x260  
drivers/staging/comedi/drivers/vmk80xx.c:213
  vmk80xx_reset_device drivers/staging/comedi/drivers/vmk80xx.c:226 [inline]
  vmk80xx_auto_attach+0x13b1/0x17c0  
drivers/staging/comedi/drivers/vmk80xx.c:814
  comedi_auto_config+0x16e/0x250 drivers/staging/comedi/drivers.c:1067
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
