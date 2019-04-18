Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B61C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B021850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbfDRMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:06:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47222 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbfDRMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:06:05 -0400
Received: by mail-io1-f69.google.com with SMTP id z7so351453iom.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pHHuI0Fl17MZy+KxmjhlNEhzsGLmuNye/r1aZZrWAEY=;
        b=ct0AKJy1ZLXyAPP5PoiShq6nHXCNVtpZ1yFASCsUT5RC/MnqUwdb7rAsmOVfLC/aOM
         AkgtbWBLUuho4y6qUeGCDz390/J1boykcBn1u+fij2O3LlErxoVnvuyoQw6VNP4o1Dkd
         UXquQTwNzuhKJ3SG9+LFdGjvSJq2yVGhMsI1tdSpxcGBXsKC+LEAZ5B+7pkfmmhcnzg5
         zGzE6o3GufRwMOlj4qAA7Z3VWYTzge98viWTZkIaGyOazzM5Kjugw15+qII58VAurHRH
         yud2172SCR0+l+tn4QhuXQmW7/kXG5CT7Lo+okOTX6099EPApea6MrgfJ0LlhUnv9rjq
         8+zw==
X-Gm-Message-State: APjAAAXk/e5y+ZaxFis4hW2e7ctvSIT2AkKuTSGIbQBsgtZeCzsGyLJo
        cyRSyQyt0gzjQci12vPyOWpLIgZ7LZwnTOfEi84Ulu8bRT8G
X-Google-Smtp-Source: APXvYqxLo5lwcEJvl3VlKaguDqhorqYSWEpsTjrRwvvlzF3lGBdcMLdq4Mh62JRphoJChl7FgOjxKeN+76ujAQ00yyiyEHXnPvnj
MIME-Version: 1.0
X-Received: by 2002:a02:5144:: with SMTP id s65mr8175189jaa.27.1555589164269;
 Thu, 18 Apr 2019 05:06:04 -0700 (PDT)
Date:   Thu, 18 Apr 2019 05:06:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d89900586ccd37b@google.com>
Subject: general protection fault in smsusb_init_device
From:   syzbot <syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com,
        wen.yang99@zte.com.cn
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=128ec3fd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
dashboard link: https://syzkaller.appspot.com/bug?extid=53f029db71c19a47325a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16138e67200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128dddbf200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com

usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
smsusb:smsusb_probe: board id=18, interface number 0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.1.0-rc5-319617-gd34f951 #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:smsusb_init_device+0x366/0x937  
drivers/media/usb/siano/smsusb.c:429
Code: 48 c1 ea 03 80 3c 02 00 74 05 e8 24 1e 66 f7 4d 8b b6 f0 04 00 00 b8  
ff ff 37 00 48 c1 e0 2a 49 8d 7e 04 48 89 fa 48 c1 ea 03 <8a> 14 02 48 89  
f8 83 e0 07 ff c0 38 d0 7c 09 84 d2 74 05 e8 b1 1d
RSP: 0018:ffff8880a86570d0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: ffff88809a81b300 RCX: ffffffff8a42b5b3
RDX: 0000000000000000 RSI: ffffffff8a42b6a3 RDI: 0000000000000004
RBP: ffff88808ca70000 R08: ffff8880a8503100 R09: ffff8880a8657130
R10: ffffed10150cae34 R11: ffff8880a86571a7 R12: ffff88809a81be54
R13: ffff88809a81be5c R14: 0000000000000000 R15: ffff88808ca70000
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ad259d000 CR3: 000000009a3aa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  smsusb_probe+0xd64/0xe08 drivers/media/usb/siano/smsusb.c:570
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
  hub_event+0x1398/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 6175778b99b10882 ]---
RIP: 0010:smsusb_init_device+0x366/0x937  
drivers/media/usb/siano/smsusb.c:429
Code: 48 c1 ea 03 80 3c 02 00 74 05 e8 24 1e 66 f7 4d 8b b6 f0 04 00 00 b8  
ff ff 37 00 48 c1 e0 2a 49 8d 7e 04 48 89 fa 48 c1 ea 03 <8a> 14 02 48 89  
f8 83 e0 07 ff c0 38 d0 7c 09 84 d2 74 05 e8 b1 1d
RSP: 0018:ffff8880a86570d0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: ffff88809a81b300 RCX: ffffffff8a42b5b3
RDX: 0000000000000000 RSI: ffffffff8a42b6a3 RDI: 0000000000000004
RBP: ffff88808ca70000 R08: ffff8880a8503100 R09: ffff8880a8657130
R10: ffffed10150cae34 R11: ffff8880a86571a7 R12: ffff88809a81be54
R13: ffff88809a81be5c R14: 0000000000000000 R15: ffff88808ca70000
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ad259d000 CR3: 000000009a3aa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
