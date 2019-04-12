Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56867C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191572171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDLLgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:36:13 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:54110 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:36:11 -0400
Received: by mail-it1-f198.google.com with SMTP id o197so8850104ito.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UiCWQQNTwSWDgZkpoo6T7faKwPtAOCeWWd9TxlPGM54=;
        b=WJffbssTRvq+KpCDBwihwYj6rguOr0jEP0jw+U6yenSYOBOu1FEWNtLej1q7Q75q5g
         DPQKndBfeOD4fiSF+LQz2K9wVtJk7VGgNkZ7CAldsTakW58NhovvXRodK1VQKhxgwwoT
         lB30diSuMRjXKGsAiwFShjMSpVCWE9wTpcdgQJA/KfB+okeuE3ANl5R4qhpVbvsNPxBw
         06m13rq4KlFAiFBUbGhlOe9E2U1826VmRi7sqVIojJsTgB+tiAj4M4ELw542Pi0FviQH
         PqMQqaZ3GvdtSpwZaSeAeNGvPTZEmb+dVC0hRBdKW3kUwwIB0mv/RmxvLA7TfjgvXccs
         0b/w==
X-Gm-Message-State: APjAAAXQ8l5NqcTJKKNO6FHHyIM/Fzy5a5/9JzUltzJZyNOjjUMDiaBP
        jJthd3Gs6qLpRYLZSQNjm86RDL83DE2v1/Bqnt6QEAV3hUbo
X-Google-Smtp-Source: APXvYqyzmyxTijk5ZME7ahSMwlO2RnQ4WpZHGVKV4ohLUekIiOLKwhh0xxxqvnTMfr9Dw/zCGE+kZRce6qyAYt5X3oEJxrOmxd6S
MIME-Version: 1.0
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr3523699itl.20.1555068969879;
 Fri, 12 Apr 2019 04:36:09 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:36:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d15ee058653b53e@google.com>
Subject: KASAN: invalid-free in disconnect_rio
From:   syzbot <syzbot+35f04d136fc975a70da4@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        miquel@df.uba.ar, rio500-users@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=174ce2e3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=35f04d136fc975a70da4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138150f3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290c22d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35f04d136fc975a70da4@syzkaller.appspotmail.com

usb 6-1: USB disconnect, device number 2
rio500 3-1:0.110: USB Rio disconnected.
usb 4-1: USB disconnect, device number 2
==================================================================
usb 1-1: USB disconnect, device number 2
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3003 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xce/0x290 mm/slub.c:3958
usb 2-1: USB disconnect, device number 2

CPU: 0 PID: 5152 Comm: kworker/0:4 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report_invalid_free+0x66/0xa0 mm/kasan/report.c:278
usb 5-1: USB disconnect, device number 2
  __kasan_slab_free+0x162/0x180 mm/kasan/common.c:438
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  disconnect_rio+0x13b/0x200 drivers/usb/misc/rio500.c:506
  usb_unbind_interface+0x1c9/0x980 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1082 [inline]
  device_release_driver_internal+0x436/0x4f0 drivers/base/dd.c:1113
  bus_remove_device+0x302/0x5c0 drivers/base/bus.c:556
  device_del+0x467/0xb90 drivers/base/core.c:2269
  usb_disable_device+0x242/0x790 drivers/usb/core/message.c:1235
  usb_disconnect+0x298/0x870 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0xcd2/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 5152:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  kmalloc include/linux/slab.h:547 [inline]
  probe_rio+0x188/0x268 drivers/usb/misc/rio500.c:471
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

Freed by task 585:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  disconnect_rio+0x13b/0x200 drivers/usb/misc/rio500.c:506
  usb_unbind_interface+0x1c9/0x980 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1082 [inline]
  device_release_driver_internal+0x436/0x4f0 drivers/base/dd.c:1113
  bus_remove_device+0x302/0x5c0 drivers/base/bus.c:556
  device_del+0x467/0xb90 drivers/base/core.c:2269
  usb_disable_device+0x242/0x790 drivers/usb/core/message.c:1235
  usb_disconnect+0x298/0x870 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0xcd2/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88808863a200
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
  4096-byte region [ffff88808863a200, ffff88808863b200)
usb 3-1: new high-speed USB device number 3 using dummy_hcd
The buggy address belongs to the page:
page:ffffea0002218e00 count:1 mapcount:0 mapping:ffff88812c3f4600 index:0x0  
compound_mapcount: 0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 0000000000000000 0000000600000001 ffff88812c3f4600
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808863a100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808863a180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88808863a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff88808863a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808863a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
