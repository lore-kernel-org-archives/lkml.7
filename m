Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75518C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D120B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfGAWaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:30:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38132 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGAWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:30:06 -0400
Received: by mail-io1-f69.google.com with SMTP id h4so16721380iol.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 15:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=clBiwsCCGrK5dwRUv2m7KQ30Nhz5lEJNQNQp6qrTzcA=;
        b=OGY4H2mzwXHYN6G52zVRPMjXP8wFWAmASSGU7xxvWUuaAcSykTnzV5vC4vrc3pGmVD
         kv2sCui1e6ERBBvNFMDCagtwZZgvbJfXOzRdEi0HjYHkrH6XnwYtIMS0RcVJizjOECxH
         dBq7HePePfkNgsnlnQdGw/SHYMKmyEZf/+SgKEUArtV78jScnlrzPnnjQF9RueK9iuTT
         shVBpZz+d23EFZvREWPkqz0ldu6zQjp+893f5GYE3PGAC6M4pg6ZzfFf4E3OV0bV1fTZ
         xdi57ktHUpY7mwNfLyLOwZ5Ok3GKWB3WE1Cw/2gi2IL5fLtjQTjw6AOD5ktjmCixlbpS
         sO4A==
X-Gm-Message-State: APjAAAW+9+8dzzLp5fYTWkrVYuK7W2/UXKUysapf95xy5cWbvl6rZVQ1
        ax0qOa3nZL6gbZf35jvwKbpMvu/yXc5iG5p/dn7G22R38ETL
X-Google-Smtp-Source: APXvYqwxSABMm7zcV6yzfu4BbZDxiiQRMk4lUaJiZOy31bUmoLkScHudXWyIQdvvWBGnB12epPRzhQ4zweoUeArHx9qVtQ+N6nyB
MIME-Version: 1.0
X-Received: by 2002:a02:16c5:: with SMTP id a188mr32610753jaa.86.1562020205592;
 Mon, 01 Jul 2019 15:30:05 -0700 (PDT)
Date:   Mon, 01 Jul 2019 15:30:05 -0700
In-Reply-To: <0000000000003fc6ef058c2db557@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c8a56058ca62b34@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hdpvr_probe
From:   syzbot <syzbot+79d18aac4bf1770dd050@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andreyknvl@google.com,
        gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17242ab3a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=79d18aac4bf1770dd050
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14740905a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133fd90ba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+79d18aac4bf1770dd050@syzkaller.appspotmail.com

usb 1-1: config 0 interface 200 altsetting 0 bulk endpoint 0x84 has invalid  
maxpacket 0
usb 1-1: New USB device found, idVendor=2040, idProduct=4982,  
bcdDevice=f9.cf
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: slab-out-of-bounds in string_nocheck+0x1d2/0x200  
lib/vsprintf.c:605
Read of size 1 at addr ffff8881c65ea220 by task kworker/1:1/22

CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  string_nocheck+0x1d2/0x200 lib/vsprintf.c:605
  string+0xe5/0xf0 lib/vsprintf.c:668
  vsnprintf+0x7d3/0x14f0 lib/vsprintf.c:2503
  vscnprintf+0x29/0x80 lib/vsprintf.c:2606
  vprintk_store+0x40/0x4b0 kernel/printk/printk.c:1907
  vprintk_emit+0xc8/0x3e0 kernel/printk/printk.c:1968
  vprintk_func+0x75/0x113 kernel/printk/printk_safe.c:386
  printk+0xba/0xed kernel/printk/printk.c:2046
  device_authorization drivers/media/usb/hdpvr/hdpvr-core.c:140 [inline]
  hdpvr_device_init drivers/media/usb/hdpvr/hdpvr-core.c:201 [inline]
  hdpvr_probe.cold+0x194/0x1247 drivers/media/usb/hdpvr/hdpvr-core.c:342
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 22:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
  kmalloc include/linux/slab.h:547 [inline]
  hdpvr_probe+0x1ce/0xac0 drivers/media/usb/hdpvr/hdpvr-core.c:297
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8881c65ea1e0
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
  64-byte region [ffff8881c65ea1e0, ffff8881c65ea220)
The buggy address belongs to the page:
page:ffffea0007197a80 refcount:1 mapcount:0 mapping:ffff8881dac03600  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 dead000000000100 dead000000000200 ffff8881dac03600
raw: 0000000000000000 00000000802a002a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c65ea100: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
  ffff8881c65ea180: fb fb fb fb fb fb fb fb fc fc fc fc 00 00 00 00
> ffff8881c65ea200: 00 00 00 00 fc fc fc fc fb fb fb fb fb fb fb fb
                                ^
  ffff8881c65ea280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c65ea300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

