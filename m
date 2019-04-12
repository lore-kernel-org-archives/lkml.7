Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225B92171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDLLqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:46:44 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40230 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfDLLqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:46:13 -0400
Received: by mail-io1-f69.google.com with SMTP id e72so7500854iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F4iqygl6G6Nxp1bDqFTZfsmZR6M7+MdVWV26GQdWnTE=;
        b=C7oiQw3tFfnweCCVrA29IxL0fU7OV2NxjSlbyk0T12/Ox2iiBKq67xgyT8mTzUdDj7
         iU6Zs5whhmX6azYSBQ8N71L0M6+jLsITN+vMS0gTYklTavoddnU6sD7O/EGyibK1IKRr
         1vw9R/dOWoOZT3O8k6M9z/Yas6MuuS1UOkShjveMD6iZ8O0MURCpTjYqyhdqB5TARQOg
         JNeqOyTPQXKeiFeLTDQ23MK0v7pK+9UYG/fZQp0as5BGPcGUyPc4Wrz54M3plJ1OY+MN
         eVCj0tlPCZ/hCDei8nXtOSG2qGADLBhJLMXBlCBJwHcPORP4iA2+t+ibi/LUTkrN95Kx
         Ljiw==
X-Gm-Message-State: APjAAAUNnTj+c/iC2qzzXGAlFr1s7RrZEviVpMFcogB5jttQv/9NdlQW
        t0Xikv2o0mE3erAgol9LoW1dhCzglz0Ms3SH8dFbldHo0VNs
X-Google-Smtp-Source: APXvYqyAvRkBRmaceBPizwqMkR+jIKZk5mIU6GXJYCs0DqyiS2sh0R8CK9cglr4A60LHV+/OhjKq4BJbbh3BPpGnTa4ZhUy6pviZ
MIME-Version: 1.0
X-Received: by 2002:a24:33cc:: with SMTP id k195mr2429234itk.36.1555069572727;
 Fri, 12 Apr 2019 04:46:12 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:46:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bd948058653d9a5@google.com>
Subject: KASAN: stack-out-of-bounds Read in string
From:   syzbot <syzbot+b75b85111c10b8d680f1@syzkaller.appspotmail.com>
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

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=116f9cd3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=b75b85111c10b8d680f1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161ebce3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fd974b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b75b85111c10b8d680f1@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=0424, idProduct=012c,  
bcdDevice=1a.78
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: stack-out-of-bounds in string+0x1f6/0x220 lib/vsprintf.c:606
Read of size 1 at addr ffff88809ee2f260 by task kworker/0:2/539

CPU: 0 PID: 539 Comm: kworker/0:2 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  string+0x1f6/0x220 lib/vsprintf.c:606
  vsnprintf+0xa14/0x16b0 lib/vsprintf.c:2396
  pointer+0x60b/0x910 lib/vsprintf.c:2038
  vsnprintf+0x5a0/0x16b0 lib/vsprintf.c:2400
  vscnprintf+0x29/0x80 lib/vsprintf.c:2499
  vprintk_store+0x45/0x4a0 kernel/printk/printk.c:1900
  vprintk_emit+0x210/0x5a0 kernel/printk/printk.c:1957
  dev_vprintk_emit+0x50e/0x553 drivers/base/core.c:3185
  dev_printk_emit+0xbf/0xf6 drivers/base/core.c:3196
  __dev_printk+0x1ed/0x215 drivers/base/core.c:3208
  _dev_info+0xdc/0x10e drivers/base/core.c:3254
  vub300_probe+0x25e/0xd80 drivers/mmc/host/vub300.c:2109
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

The buggy address belongs to the page:
page:ffffea00027b8bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfff00000000000()
raw: 00fff00000000000 ffffea00027b8bc8 ffffea00027b8bc8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809ee2f100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88809ee2f180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88809ee2f200: 00 00 f1 f1 f1 f1 f1 f1 00 00 00 00 f2 f2 f2 f2
                                                        ^
  ffff88809ee2f280: 00 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 f3 f3
  ffff88809ee2f300: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
