Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B5FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6A720857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfDPLQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:16:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52643 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfDPLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:16:07 -0400
Received: by mail-it1-f200.google.com with SMTP id 73so19058823itl.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8nuO6ldXJk2LHqGy3vCiV7UMltsyhJ7zqhsq6tdPLPM=;
        b=ccPa3FsqPUdac3pDx0BTduGI1RUHAZ4vtK/5B4CmhO6FmVOZEryehxh/86Kt09yKbt
         RaDtOPSnVz1BVLbuOnsX+EPoJ0Fb2iqGjUZJZMOOIEN+0rpk2dlrc4bFg1cKOyj9XlWh
         AaR0LnQjNxignJfdFoYd3f9Esae8OIsVB7domedyM+nTy5A0T4p+lZGYl+4VdyT2PPTN
         XUrKuchnsgB12nQMJO9SkPbSpC9YnPy30CCLyimx3rn+Y+4+dWWKbaV/FO681S+wV+OO
         eLZQA4mkHwUCExLzSrefvNm7Jut7PjiSdWlF/GHlnbqACcPJkIOkPVWWWW4zOX+C0086
         Jk4w==
X-Gm-Message-State: APjAAAVcjCfCX76FUSFIlBuJVsjJryeG+NkNShTJm82Kay2sJU7n2w28
        l5d1LASv7dpw3ejlrce4x7aEUrTityrVvFHMgJOYZ8gjfgBX
X-Google-Smtp-Source: APXvYqwDWdlk/AxkIdwYO2kbqZWF8p5WnPZhwwskesZzbpejC2AjdaYt7zT3CZ+/cQB7mARZ28bjHqqRUqoaMw9lYXsbNiYrkhfb
MIME-Version: 1.0
X-Received: by 2002:a24:9986:: with SMTP id a128mr6487193ite.21.1555413366340;
 Tue, 16 Apr 2019 04:16:06 -0700 (PDT)
Date:   Tue, 16 Apr 2019 04:16:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e03f40586a3e512@google.com>
Subject: KASAN: use-after-free Read in cpia2_usb_disconnect
From:   syzbot <syzbot+0c90fc937c84f97d0aa6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hverkuil-cisco@xs4all.nl,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1463a267200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=0c90fc937c84f97d0aa6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13af9c23200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0c90fc937c84f97d0aa6@syzkaller.appspotmail.com

cpia2: Control message failed, err val = -19
cpia2: Message: request = 0x1, start = 0xA9
cpia2: Message: count = 1, register[0] = 0x0
cpia2: Unexpected error: -19
==================================================================
BUG: KASAN: use-after-free in cpia2_usb_disconnect+0x1a9/0x1c0  
drivers/media/usb/cpia2/cpia2_usb.c:907
Read of size 8 at addr ffff8880a09f0a58 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  cpia2_usb_disconnect+0x1a9/0x1c0 drivers/media/usb/cpia2/cpia2_usb.c:907
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  cpia2_init_camera_struct+0x45/0x110  
drivers/media/usb/cpia2/cpia2_core.c:2185
  cpia2_usb_probe.cold+0x37/0x45a drivers/media/usb/cpia2/cpia2_usb.c:842
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

Freed by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  v4l2_device_release drivers/media/v4l2-core/v4l2-device.c:67 [inline]
  kref_put include/linux/kref.h:67 [inline]
  v4l2_device_put+0x7e/0xa0 drivers/media/v4l2-core/v4l2-device.c:72
  cpia2_usb_disconnect+0x7e/0x1c0 drivers/media/usb/cpia2/cpia2_usb.c:905
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880a09f0000
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2648 bytes inside of
  4096-byte region [ffff8880a09f0000, ffff8880a09f1000)
The buggy address belongs to the page:
page:ffffea0002827c00 count:1 mapcount:0 mapping:ffff88812c3f4600 index:0x0  
compound_mapcount: 0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000200 ffff88812c3f4600
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a09f0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a09f0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a09f0a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff8880a09f0a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a09f0b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
