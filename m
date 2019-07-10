Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA60C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D104920665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGJLHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:07:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33584 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfGJLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:07:09 -0400
Received: by mail-io1-f72.google.com with SMTP id 132so2489993iou.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 04:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1MZwEpypxQO+6zRNPb9qlpdItDM+J+AtMhEGHFtFWHo=;
        b=eBUzzSg8HVX9oaDnLs+feRe9VnUeD6twUu8iNeUBUag0tfn+77+zmJg9rigRi3PL2k
         cSqgEMLEGoGknqWsAS7texWR7BJs+SrQVH2ncLfhCPrOmXM4FbN/V3ye0+zJUhGEH11+
         ABcubbf5hAkKzp7EwAFfEPEzP33npi5adYSfeqWgKS3L8N8ZB7cNPUwJTMFXAo8Lq+4c
         8zJukszdpxwv2y7F6cWAwqAYKx9ZkPfiTKxF13B7+4jWddx2y59IuHvYfZCJrNk50UxZ
         QialrWkJkY+gHt6z2RwW46tF63f7qhN70SgXrLD+HpM7C8ifBZdCFnBxcder+lD3Zzoy
         KCxA==
X-Gm-Message-State: APjAAAVi+SMaKaeq17ErOBviLCad0jX4lon1RAW8Lc7WmREhG4L0SVx9
        qT9Nynn3IZOBQlFOrMI74kt6oK69FJabjpQjZ9LtVk5yVY6H
X-Google-Smtp-Source: APXvYqyPeqU+29B36BoWRNMAb1fARNBlBZK/g/natA4JnNo0RMnzmZQKisMK/JthoaTWYN65SJcdMH8gGMeNUWbHemmq6DYtlBaz
MIME-Version: 1.0
X-Received: by 2002:a6b:bf01:: with SMTP id p1mr902038iof.181.1562756828063;
 Wed, 10 Jul 2019 04:07:08 -0700 (PDT)
Date:   Wed, 10 Jul 2019 04:07:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b6e7f058d51adba@google.com>
Subject: WARNING in i2400mu_bus_bm_wait_for_ack/usb_submit_urb
From:   syzbot <syzbot+7886801de1cc3958a0d1@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1590cba0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=7886801de1cc3958a0d1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e19490600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c2667ba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7886801de1cc3958a0d1@syzkaller.appspotmail.com

i2400m_usb 1-1:64.149: W: __i2400mu_send_barker: cannot send URB: -8
i2400m_usb 1-1:64.149: W: __i2400mu_send_barker: cannot send URB: -8
i2400m_usb 1-1:64.149: E: __i2400mu_send_barker: maximum errors in URB  
exceeded; resetting device
i2400m_usb 1-1:64.149: warm reset failed (-8); trying USB reset
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
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
RSP: 0018:ffff8881d9e0ebb0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3c1d68
RBP: ffff8881d0498dd0 R08: ffff8881d9df9800 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881cde9db10 R14: ffff8881d07122a0 R15: ffff8881d9e0ed30
  i2400mu_notif_submit drivers/net/wimax/i2400m/usb-fw.c:259 [inline]
  i2400mu_bus_bm_wait_for_ack+0x4bf/0xb45  
drivers/net/wimax/i2400m/usb-fw.c:303
  i2400m_bm_cmd+0x346/0x7f0 drivers/net/wimax/i2400m/fw.c:611
  i2400m_bootrom_init+0x319/0x1060 drivers/net/wimax/i2400m/fw.c:909
  i2400m_setup+0x29c/0x990 drivers/net/wimax/i2400m/driver.c:871
  i2400mu_probe+0x6bf/0xdf0 drivers/net/wimax/i2400m/usb.c:532
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
