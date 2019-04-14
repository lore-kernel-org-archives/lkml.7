Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C861C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFA820850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDNUGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:06:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54268 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfDNUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:06:08 -0400
Received: by mail-io1-f69.google.com with SMTP id w11so12579327iom.20
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=keJ2/Mz1gh9H23BopXwP2tyCXHMxOdaZ1lEEDEkn2bE=;
        b=dDf0u8tuHXL4hfKxZoSaIkfdtIrkcjLm/TLwzqXJEZXYE+XYlvxrAwJQ+O83qDEp/+
         +XpK/d0vpBprEQXT4Iaoo1mb9S+oH4sTIdeK65L9OKEnVd1JCxx4pqAxpy/tftgjTgPj
         i9896KDTo29AO8LOahB5sxuV0nV1ms6l9Z0Ay3IiEhCl3TXZzZDgT2MKINs4zxST1ub4
         rzUouQwWYRx2rHkFHNZws2dUwFpwd0FNqUN3kPpJ1S1qZKtoKIsenjWeV3n2IfQz2kVB
         gv8mr3KNl7Vn1S9GJ5fi9OOxFcebbh2y2iD0pNmAAWbNsujvTTqNuqho0liXfZX1w8+i
         /bSg==
X-Gm-Message-State: APjAAAWfaJ2En8mf4ludNCHVhOgvIh2NbXJovI4WEKlt6lYcR1Mev+Jb
        4SK3EUUr2PhLjsCbP4i8LcTMAoDoepMQHRBfOK4D8BCzzXW1
X-Google-Smtp-Source: APXvYqzjwd12Jau7iSqCrBfrD6VvsJGsjxdRBM9Q+1ZCQWjkXHupx2t16TExAQVmZU7r7VlHUCdXlJIjEzNd7w21vx7Ysx9HR8wt
MIME-Version: 1.0
X-Received: by 2002:a24:9084:: with SMTP id x126mr5058266itd.32.1555272367199;
 Sun, 14 Apr 2019 13:06:07 -0700 (PDT)
Date:   Sun, 14 Apr 2019 13:06:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9dea00586831084@google.com>
Subject: KASAN: use-after-free Read in snd_info_free_entry
From:   syzbot <syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, andreyknvl@google.com,
        joe@perches.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=14153823200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=48df349490c36f9f54ab
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12642f97200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a8f5af200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com

snd_usb_toneport: probe of 1-1:0.0 failed with error -71
snd_usb_toneport: probe of 5-1:0.0 failed with error -71
usb 1-1: USB disconnect, device number 72
snd_usb_toneport: probe of 4-1:0.0 failed with error -71
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xe0/0xef  
lib/list_debug.c:51
Read of size 8 at addr ffff88809b8339a8 by task kworker/0:4/5492

CPU: 0 PID: 5492 Comm: kworker/0:4 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  __list_del_entry_valid+0xe0/0xef lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  snd_info_free_entry+0x137/0x340 sound/core/info.c:795
  snd_info_card_free+0x43/0x90 sound/core/info.c:606
  snd_card_do_free sound/core/init.c:469 [inline]
  release_card_device+0x8b/0x100 sound/core/init.c:156
  device_release+0x7d/0x210 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put+0x1df/0x4f0 lib/kobject.c:708
  put_device+0x21/0x30 drivers/base/core.c:2205
  snd_card_free_when_closed+0x3a/0x50 sound/core/init.c:493
  line6_disconnect.cold+0xa3/0xbc sound/usb/line6/driver.c:833
  line6_probe+0xb23/0x1150 sound/usb/line6/driver.c:799
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 5:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  snd_info_create_entry+0x56/0x400 sound/core/info.c:701
  snd_info_create_module_entry sound/core/info.c:737 [inline]
  create_subdir+0x27/0xa0 sound/core/info.c:454
  snd_info_card_create+0xcf/0x230 sound/core/info.c:528
  snd_card_new+0x61d/0x920 sound/core/init.c:255
  line6_probe+0x135/0x1150 sound/usb/line6/driver.c:736
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 5:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  snd_info_free_entry+0x29a/0x340 sound/core/info.c:799
  snd_info_card_free+0x43/0x90 sound/core/info.c:606
  snd_card_do_free sound/core/init.c:469 [inline]
  release_card_device+0x8b/0x100 sound/core/init.c:156
  device_release+0x7d/0x210 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put+0x1df/0x4f0 lib/kobject.c:708
  put_device+0x21/0x30 drivers/base/core.c:2205
  snd_card_free_when_closed+0x3a/0x50 sound/core/init.c:493
  line6_disconnect.cold+0xa3/0xbc sound/usb/line6/driver.c:833
  line6_probe+0xb23/0x1150 sound/usb/line6/driver.c:799
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88809b8338c0
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 232 bytes inside of
  256-byte region [ffff88809b8338c0, ffff88809b8339c0)
The buggy address belongs to the page:
page:ffffea00026e0cc0 count:1 mapcount:0 mapping:ffff88812c3f4e00 index:0x0
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 dead000000000100 dead000000000200 ffff88812c3f4e00
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809b833880: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff88809b833900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809b833980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                   ^
  ffff88809b833a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b833a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
