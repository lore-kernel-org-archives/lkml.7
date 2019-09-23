Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCBC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9852E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439959AbfIWOb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:31:27 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46611 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439898AbfIWObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:31:10 -0400
Received: by mail-io1-f71.google.com with SMTP id t11so23863929ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 07:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SFhRwK/SitmqD+aaCPJ6RcAIGGBP5VF+84/JtJXz/tQ=;
        b=QIfiHkp4sk3RY8h01SneXDY3bSwwg+CUm/lBYPDLMWpEXuLquNa1S4XQDSY1cj4yDs
         Rfnev1a2ydIh2FQBOfawFBivKIpFW5FgoE1uQDeYYYSr/xG1jDfjWZI7Rpl+ab5dEBGO
         x0OKRIezCQ3HC8BYw3C0X/xNco6poWW8imUsNOI3XvNwfpV5fIgDFYR2p20FqopzU5TZ
         eQo/hYLHjrASYv/lYMKGQVbq1PXDVMoO5lHnvdxfgrRIs+NG8K00rw11yzglXJEoFztj
         ord5U02DwDpqg2t8ilM5Sy9/a7FcPzawcAc2KPA7XlbvSnGVzwbKuF0fPky1aFTsKN3u
         x4SQ==
X-Gm-Message-State: APjAAAXrKfEoYGKTyJP55j+NMHiSuVOS04xBV8Cdo+wUtPVXrra83WXk
        AdAj2znIKoFNf3+7yR5XTaVA1bv4Fjm8Qm9nUONqmFhTU1/q
X-Google-Smtp-Source: APXvYqxuoaIEJQC0zCD1Sc4icCLYNqnURPsMDMGmmbrBNePUkbh8vJ/FLVc5gOh5GMZvMGs99sQcRz1RlvwLGWQLLW1ZXP8QomJt
MIME-Version: 1.0
X-Received: by 2002:a02:2382:: with SMTP id u124mr38245219jau.7.1569249067969;
 Mon, 23 Sep 2019 07:31:07 -0700 (PDT)
Date:   Mon, 23 Sep 2019 07:31:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042d60805933945b5@google.com>
Subject: KASAN: use-after-free Read in appledisplay_bl_get_brightness
From:   syzbot <syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com>
To:     2pi@mok.nu, alex.theissen@me.com, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=13714ad9600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=495dab1f175edc9c2f13
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1653d945600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15176945600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in appledisplay_bl_get_brightness+0x1ac/0x1c0  
drivers/usb/misc/appledisplay.c:167
Read of size 8 at addr ffff8881cfc576a0 by task kworker/1:0/17

CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events appledisplay_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:618
  appledisplay_bl_get_brightness+0x1ac/0x1c0  
drivers/usb/misc/appledisplay.c:167
  appledisplay_work+0x36/0x160 drivers/usb/misc/appledisplay.c:187
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 83:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:493 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:466
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  appledisplay_probe+0x15a/0xb37 drivers/usb/misc/appledisplay.c:218
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 83:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:455
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  appledisplay_probe+0x772/0xb37 drivers/usb/misc/appledisplay.c:312
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881cfc57680
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 32 bytes inside of
  512-byte region [ffff8881cfc57680, ffff8881cfc57880)
The buggy address belongs to the page:
page:ffffea00073f1580 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da002500
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cfc57580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cfc57600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881cfc57680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8881cfc57700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cfc57780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
