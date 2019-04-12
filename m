Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A9220643
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDLLQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:16:12 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51399 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLLQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:16:11 -0400
Received: by mail-io1-f71.google.com with SMTP id y18so7409239ior.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sKZJUBZRB9qTKwgDkvpmWjiCEui4WVdCtbcfIn8VM0A=;
        b=bM+6FMbVYL1Rt3jUydkgYpakPnfnk3RK8UuJbY57an0v6+J6k+N6OFseDaLqlKir5L
         ndD+DJZ27FNYgbSQlAqwZZ7ai9nAmIjGnIj9q+hh8PFBH+k37Xct+WbNnh7Bg+RTGcqX
         zBZdfP118T+BvnhoVv1s2dziXp/p6rS74qB/U2ROb28191V8CbQRrOABYITDavqnuY27
         FtAKnSdnMxzEIAhRd26xmyo2evo7UeAXD9tG1Uypc6d1rZijajV9ISyn89prtQmxMB+Y
         xZfzicogjieaq7CnX1O62mJ8XRdNw6jLYvaLnlyCdfG08b8OmC5Q5IkfE/RA1j6oPFm4
         c/wg==
X-Gm-Message-State: APjAAAUcHukGSwabnZuE4B3vKQKLbT8o5AxYsko6cyFrOQ7Dcj6aElv1
        2w7WlCXJBjbVKGea2Y1vT2Xdv81Z2gIp9YiADPON9jKgnDOX
X-Google-Smtp-Source: APXvYqxZjzxQOwDuHp7o3KZW3YsiJOmEnjXjMcWjx3VKMprIfhtW1jTXF33pnc7ap2owfg532SOnOXAWD7AvZ9maH8d78nTLzrN3
MIME-Version: 1.0
X-Received: by 2002:a24:8091:: with SMTP id g139mr3880400itd.3.1555067770565;
 Fri, 12 Apr 2019 04:16:10 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:16:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010fe260586536e86@google.com>
Subject: general protection fault in flexcop_usb_probe
From:   syzbot <syzbot+d93dff37e6a89431c158@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=15adefa7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=d93dff37e6a89431c158
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175c0cd3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1186469f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d93dff37e6a89431c158@syzkaller.appspotmail.com

b2c2-flexcop: found 'LG Electronics LGDT3303 VSB/QAM Frontend' .
usb 1-1: DVB: registering adapter 0 frontend 0 (LG Electronics LGDT3303  
VSB/QAM Frontend)...
b2c2-flexcop: initialization of 'Air2PC/AirStar 2 ATSC 3rd generation  
(HD5000)' at the 'USB' bus controlled by a 'FlexCopIII' complete
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:flexcop_usb_transfer_init  
drivers/media/usb/b2c2/flexcop-usb.c:429 [inline]
RIP: 0010:flexcop_usb_probe.cold+0x1cb/0x7bd  
drivers/media/usb/b2c2/flexcop-usb.c:574
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 74 05 e8 dc d2 65 f7 48 8b 5b 18 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 c1
RSP: 0018:ffff8880a862f2e0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8a430240
RDX: 0000000000000000 RSI: ffffffff8a430300 RDI: 0000000000000004
RBP: ffff88809d3b9108 R08: ffff8880a84d4980 R09: ffffed1015a24fc9
R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffff88809d3b9148
R13: 0000000000000000 R14: ffff88809d3b9100 R15: ffff88809575c000
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd361552000 CR3: 0000000095f74000 CR4: 00000000001406e0
Call Trace:
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
Modules linked in:
---[ end trace 8800fc602d77e417 ]---
RIP: 0010:flexcop_usb_transfer_init  
drivers/media/usb/b2c2/flexcop-usb.c:429 [inline]
RIP: 0010:flexcop_usb_probe.cold+0x1cb/0x7bd  
drivers/media/usb/b2c2/flexcop-usb.c:574
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 74 05 e8 dc d2 65 f7 48 8b 5b 18 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 c1
RSP: 0018:ffff8880a862f2e0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8a430240
RDX: 0000000000000000 RSI: ffffffff8a430300 RDI: 0000000000000004
RBP: ffff88809d3b9108 R08: ffff8880a84d4980 R09: ffffed1015a24fc9
R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffff88809d3b9148
R13: 0000000000000000 R14: ffff88809d3b9100 R15: ffff88809575c000
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd361552000 CR3: 0000000095f74000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
