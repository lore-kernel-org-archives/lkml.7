Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F3C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF1D2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfGJLHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:07:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38465 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:07:08 -0400
Received: by mail-io1-f72.google.com with SMTP id h4so2489511iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 04:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n8LNEsjVXxbjW5fYWdUyzUs5NPEzIPbYKIU6uQp1vPA=;
        b=QuI5NxfXxBlbX/g3M4qHiTXyUofdMK0wfGs2YKLRLvYvpoWSSlmfw3HGzYaonjY5dM
         gB5UVA5Atc3g42Rspo5mRaZrH37GIJUP5YP/wKrquH0PwSEgf71PkzBFg3kvlgnCEyQ7
         jcwFEBrWRgSxZcTLtWt1Zk82dAsuLRq/ow59wiI+N8ft05ygm415IAz2mOULaDkU9tVv
         Dzh3KO9CD0CC8ETYNY21K/L9JCVulFERLsu1j8sWBDAZ2LgIEMwMqSB+oyMjdBEvpfwh
         9U5Dc4CdEmen91uRJT8CSk84wsDftBpAh1R1Q+rzXgWRC9cyd291UFKkwasG5PwstvbJ
         RI5w==
X-Gm-Message-State: APjAAAXbDWgjb3mNALMTyEUSII9GLX4sUudEGXNHvMGmzy9qNKB1I9GO
        iIpEcx4dQq8YcONmO9SdL2M06nwKLafI7QLrUe740Xe8Oicm
X-Google-Smtp-Source: APXvYqw8plI2Mv7zrPUDPPCMJfilnLxBInKMTqghr5y+g2gHl5RdNDD4jmFH2VMbrxRTWl7mA8LtFsInv1mWkFNvxy0bv+ALOGz1
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr3323342ioo.95.1562756827776;
 Wed, 10 Jul 2019 04:07:07 -0700 (PDT)
Date:   Wed, 10 Jul 2019 04:07:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000971061058d51ad15@google.com>
Subject: WARNING in port100_send_cmd_async/usb_submit_urb
From:   syzbot <syzbot+711468aa5c3a1eabf863@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1652b15fa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=711468aa5c3a1eabf863
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166af1c4600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a1627a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+711468aa5c3a1eabf863@syzkaller.appspotmail.com

usb 1-1: config 0 interface 206 altsetting 0 bulk endpoint 0x8F has invalid  
maxpacket 0
usb 1-1: New USB device found, idVendor=054c, idProduct=06c3,  
bcdDevice=9c.72
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
URB 0000000007e26c9b submitted while active
WARNING: CPU: 0 PID: 107 at drivers/usb/core/urb.c:362  
usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 107 Comm: kworker/0:2 Not tainted 5.2.0-rc6+ #13
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
RSP: 0018:ffff8881d422f090 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103a845e04
RBP: ffff8881d14dea20 R08: ffff8881d4220000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881d4163f00
R13: 00000000fffffff0 R14: ffff8881d0d0a7c8 R15: ffff8881d4163e00
  port100_send_frame_async drivers/nfc/port100.c:780 [inline]
  port100_send_cmd_async+0x801/0xb80 drivers/nfc/port100.c:876
  port100_send_cmd_sync+0xaa/0x130 drivers/nfc/port100.c:916
  port100_set_command_type drivers/nfc/port100.c:987 [inline]
  port100_probe+0xa12/0xea0 drivers/nfc/port100.c:1567
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
