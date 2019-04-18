Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2BC21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbfDRMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:36:08 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:42817 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfDRMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:36:06 -0400
Received: by mail-it1-f200.google.com with SMTP id r186so2064369ita.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i+tomZsCMzsnHr3874poPaxJCpmgaqjJEfGN6uwmJv0=;
        b=rRFWM1ilSGrNzx6PEdWeHPw/a+1P+gqhiUSgD+bwxqbrOT/aBwPBaFpkLoGuYi2YBq
         10mDCrPkb8H7tA003Tyq7q4JHONHZ+2x5Y+R3br3oOnPV0rHlMnEnu+vHxtIAfaLfux9
         x7fdTjs2XziVOBp/hyXxs5jwchAqj9eVkBokjkg1Ot1xPXkZjErvY+wpMWtbqwKjc//+
         UlL6MUAcdMMjo7/WeYVaBP8h30qjSRGg+zELLiOK1hJ5UtS+OW/AbqNqNfKbO1hx7Ht/
         N5QxuByeAD3GDQme6PilZa3reumxuqe6wvTUOAx/E8GmicYcRa/cyMw5+7VWNpyZlLIF
         iAHg==
X-Gm-Message-State: APjAAAXe+C5rTp5fax8rOY14inbF6diKojt5xFaJGMkpGRZH9SbPrwa1
        vL2ORBf0iVlogTy5tpjO7ev8YfLLFVsecP5PRzaduk08mM3E
X-Google-Smtp-Source: APXvYqxNc5aU67epG4FuCxsatGM/4m1OETB/YtPcWPEF5e6Rzc4NdVhbYtgiItDICqxkcrTJ3kkGle02EMYEDf7nNg9b3juDh6xn
MIME-Version: 1.0
X-Received: by 2002:a6b:7108:: with SMTP id q8mr3957038iog.85.1555590965482;
 Thu, 18 Apr 2019 05:36:05 -0700 (PDT)
Date:   Thu, 18 Apr 2019 05:36:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9e1990586cd3e40@google.com>
Subject: BUG: unable to handle kernel paging request in osq_lock
From:   syzbot <syzbot+e5c9afc3e1eed1dfc2b0@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, brad@nextdimension.cc,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1338d3e3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
dashboard link: https://syzkaller.appspot.com/bug?extid=e5c9afc3e1eed1dfc2b0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e5c9afc3e1eed1dfc2b0@syzkaller.appspotmail.com

au0828: recv_control_msg() Failed receiving control message, error -71.
au8522_writereg: writereg error (reg == 0x106, val == 0x0001, ret == -5)
usb 1-1: selecting invalid altsetting 5
au0828: Failure setting usb interface0 to as5
au0828: au0828_usb_probe() au0828_analog_register failed to register on V4L2
BUG: unable to handle kernel paging request at fffffffc45040758
#PF error: [normal kernel read fault]
PGD 1167e067 P4D 1167e067 PUD 0
Oops: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.1.0-rc5-319617-gd34f951 #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:decode_cpu kernel/locking/osq_lock.c:34 [inline]
RIP: 0010:osq_lock+0xfd/0x5a0 kernel/locking/osq_lock.c:111
Code: 48 63 e8 48 b8 00 00 00 00 00 fc ff df 48 8d 3c ed 60 c0 39 91 48 89  
f9 48 c1 e9 03 80 3c 01 00 0f 85 2c 04 00 00 48 8d 53 08 <4c> 03 2c ed 60  
c0 39 91 48 b8 00 00 00 00 00 fc ff df 48 89 d6 48
RSP: 0018:ffff8880a846f0e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880ad02dfc0 RCX: 1fffffff88a080eb
RDX: ffff8880ad02dfc8 RSI: 0000000000000004 RDI: fffffffc45040758
RBP: ffffffff967948df R08: 0000000000000000 R09: ffffed1012299b1e
R10: ffffed1012299b1d R11: ffff8880914cd8eb R12: ffff8880ad02dfd0
R13: 000000000002dfc0 R14: ffff8880a8443100 R15: ffff8880914cd8e8
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffc45040758 CR3: 000000009f4ac000 CR4: 00000000001406f0
Call Trace:
  mutex_optimistic_spin kernel/locking/mutex.c:630 [inline]
  __mutex_lock_common kernel/locking/mutex.c:928 [inline]
  __mutex_lock+0x27d/0x12b0 kernel/locking/mutex.c:1072
  au0828_usb_disconnect+0xa3/0x130 drivers/media/usb/au0828/au0828-core.c:194
  au0828_usb_probe.cold+0x121/0x7d8  
drivers/media/usb/au0828/au0828-core.c:661
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: fffffffc45040758
---[ end trace 41843cb8c360ab9e ]---
RIP: 0010:decode_cpu kernel/locking/osq_lock.c:34 [inline]
RIP: 0010:osq_lock+0xfd/0x5a0 kernel/locking/osq_lock.c:111
Code: 48 63 e8 48 b8 00 00 00 00 00 fc ff df 48 8d 3c ed 60 c0 39 91 48 89  
f9 48 c1 e9 03 80 3c 01 00 0f 85 2c 04 00 00 48 8d 53 08 <4c> 03 2c ed 60  
c0 39 91 48 b8 00 00 00 00 00 fc ff df 48 89 d6 48
RSP: 0018:ffff8880a846f0e8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880ad02dfc0 RCX: 1fffffff88a080eb
RDX: ffff8880ad02dfc8 RSI: 0000000000000004 RDI: fffffffc45040758
RBP: ffffffff967948df R08: 0000000000000000 R09: ffffed1012299b1e
R10: ffffed1012299b1d R11: ffff8880914cd8eb R12: ffff8880ad02dfd0
R13: 000000000002dfc0 R14: ffff8880a8443100 R15: ffff8880914cd8e8
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffc45040758 CR3: 000000009f4ac000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
