Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F8C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7571208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgAGOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:14:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:45295 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:14:10 -0500
Received: by mail-il1-f198.google.com with SMTP id w6so45069065ill.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JXRYv9+UcfxN9G9rRDARlLgJ3UdPoCZZf5aUdAOiYv0=;
        b=ISDyA8RCYrRjhsE+owk0S0ss/U7Xt1Rjf6Yv74NolZFTrcoxksCNK7Q1Ngnnzb4VaV
         7Ftts1xi7AIRk3OhQ5LjlXZiaXHNqer1ndiProjWkFFFgU6NGL5sULnXgpUdpf9/hHPV
         kTXStW36fycN9ke5hjSHxBqslNO+/h7ubQvU0bJNmpJIE1G0kC3p6NBN2jrI8CRUPu32
         urKpw/mamFeVjxr48QsKsZYcwKbRuXm6wy0rguqDwtmioFPpiI4RzaWvvrG4H1a/0INc
         Q07B2iU5dnkVD0tuHIbjaGX9CsAkWvJ7nGMafbFBo5Gf7urJ/L19WzT7jpUxMftR91fy
         kB4g==
X-Gm-Message-State: APjAAAWDqpLIwj0X10mlHGpXHfdylqRFdwP4DEFDiFJ31OOvSsuOzVWo
        VkMNJxyEq9uwmcr5G+h/05wQihPbKUt/E/VyTOjTyJxvFY1K
X-Google-Smtp-Source: APXvYqxKkhdPR0xm9EcRZmWKEtDhE8VQWFimXadzllxS5Y/O9MeNoWuwVrfMpDBrpfdQ68XDHY/NiobQs4BMJmmD1Fk86J0JwM12
MIME-Version: 1.0
X-Received: by 2002:a92:168d:: with SMTP id 13mr82513972ilw.253.1578406450072;
 Tue, 07 Jan 2020 06:14:10 -0800 (PST)
Date:   Tue, 07 Jan 2020 06:14:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4972d059b8d6305@google.com>
Subject: WARNING in port100_send_cmd_async/usb_submit_urb (2)
From:   syzbot <syzbot+e7687d3c762f267e48f7@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ecdf2214 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1727e059e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
dashboard link: https://syzkaller.appspot.com/bug?extid=e7687d3c762f267e48f7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e6d885e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178b549ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e7687d3c762f267e48f7@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
URB 000000007bfb3747 submitted while active
WARNING: CPU: 1 PID: 22 at drivers/usb/core/urb.c:363  
usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:363
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  panic+0x2aa/0x6e1 kernel/panic.c:221
  __warn.cold+0x2f/0x30 kernel/panic.c:582
  report_bug+0x27b/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:363
Code: 89 de e8 72 92 e7 fd 84 db 0f 85 42 f6 ff ff e8 35 91 e7 fd 4c 89 fe  
48 c7 c7 00 59 15 86 c6 05 20 c3 4e 04 01 e8 e7 ad bc fd <0f> 0b e9 20 f6  
ff ff c7 44 24 14 01 00 00 00 e9 d7 f6 ff ff 41 bd
RSP: 0018:ffff8881d8c370e0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81295dad RDI: ffffed103b186e0e
RBP: ffff8881d32c5f80 R08: ffff8881da24e200 R09: ffffed103b66439f
R10: ffffed103b66439e R11: ffff8881db321cf3 R12: ffff8881d5aabb00
R13: 00000000fffffff0 R14: ffff8881d2037448 R15: ffff8881d5aab800
  port100_send_frame_async drivers/nfc/port100.c:780 [inline]
  port100_send_cmd_async+0x801/0xb80 drivers/nfc/port100.c:876
  port100_send_cmd_sync+0xaa/0x130 drivers/nfc/port100.c:916
  port100_set_command_type drivers/nfc/port100.c:987 [inline]
  port100_probe+0xa12/0xea0 drivers/nfc/port100.c:1567
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  usb_set_configuration+0xe67/0x1740 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x1e59/0x3860 drivers/usb/core/hub.c:5552
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2264
  worker_thread+0x96/0xe20 kernel/workqueue.c:2410
  kthread+0x318/0x420 kernel/kthread.c:255
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
