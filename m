Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6719C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DC52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDPDkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:40:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42506 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDPDkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:40:06 -0400
Received: by mail-io1-f69.google.com with SMTP id i1so15877349ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Q9wv88OS+DdvAHoIILxuX/ZsQl07XyJ/O7uWHnelOqY=;
        b=WEaHi4siCpM91oEGjL8vItZVH2Kf4D2XyWDzSFB1k7KMhrUvi9ic2l1iCGCt666+KE
         +B28oK42z7FipVlu+ipE7LhGB6vR9/w0KemG66lPzJyuNjUtZ8dOA8Gb6dySFlWoyRj9
         msogJe3MlaUQkEIT7UfVWtLVPyh1J+DTDeeR5ibF7joqO8OLHXloLR4mMucqOYC+sUTM
         rC/nD8+e7KW1byHEHbOvBYhfy80jKwVwYdGto4J5oFgWnvVju+t4nfUPMnqcg2VWpKuX
         h++p2SZsENxPqW6TVrpg932FEwzLszbS64DPtCZWkRRUvog1iER67JgyFn6pxoAt+IYJ
         K6yg==
X-Gm-Message-State: APjAAAWXX3mgzacz0aLsh/XpSCMlEpEW+gzx8adZbp6m3oNZR9OBBmhG
        JjkcGoFzreUetO4lDdh/6owUn4RTt8KWYZOEHIHI+qDtzL1N
X-Google-Smtp-Source: APXvYqwr6xsk2Bui892A7XAvPKqz0KJJ4sTfpUvYOg46fPJuIn116/w8PN2o10a9cXiYis1rQU/ntWNNlkMtMQTLYTBkM01ONKRH
MIME-Version: 1.0
X-Received: by 2002:a5d:8345:: with SMTP id q5mr841830ior.12.1555386005672;
 Mon, 15 Apr 2019 20:40:05 -0700 (PDT)
Date:   Mon, 15 Apr 2019 20:40:05 -0700
In-Reply-To: <00000000000086f7f20586929239@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b588f05869d86d1@google.com>
Subject: Re: KASAN: use-after-free Read in v4l2_release
From:   syzbot <syzbot+a4387f5b6b799f6becbf@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, brian.warner@samsung.com,
        ezequiel@collabora.com, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        niklas.soderlund+renesas@ragnatech.se,
        niklas.soderlund@ragnatech.se, sakari.ailus@linux.intel.com,
        sque@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1364598f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=a4387f5b6b799f6becbf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1165b9b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b224cb200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4387f5b6b799f6becbf@syzkaller.appspotmail.com

radio-raremono 3-1:0.210: Thanko's Raremono disconnected
radio-raremono 6-1:0.210: Thanko's Raremono disconnected
radio-raremono 2-1:0.210: Thanko's Raremono disconnected
usb 5-1: new high-speed USB device number 92 using dummy_hcd
==================================================================
BUG: KASAN: use-after-free in v4l2_release+0x322/0x390  
drivers/media/v4l2-core/v4l2-dev.c:453
Read of size 8 at addr ffff888098dca3e0 by task v4l_id/7099

CPU: 0 PID: 7099 Comm: v4l_id Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  v4l2_release+0x322/0x390 drivers/media/v4l2-core/v4l2-dev.c:453
  __fput+0x2df/0x8c0 fs/file_table.c:278
  task_work_run+0x149/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x243/0x270 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x40c/0x4f0 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fa9f8fc12b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffd121e3378 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fa9f8fc12b0
RDX: 00007fa9f9277df0 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fa9f9277df0 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffd121e34d0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5386:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc_node mm/slub.c:2756 [inline]
  __kmalloc_node_track_caller+0xf3/0x320 mm/slub.c:4372
  alloc_dr drivers/base/devres.c:103 [inline]
  devm_kmalloc+0x8c/0x190 drivers/base/devres.c:793
  devm_kzalloc include/linux/device.h:679 [inline]
  usb_raremono_probe+0x34/0x235 drivers/media/radio/radio-raremono.c:298
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

Freed by task 5386:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  release_nodes+0x4ac/0x920 drivers/base/devres.c:508
  devres_release_all+0x79/0xc8 drivers/base/devres.c:529
  __device_release_driver drivers/base/dd.c:1086 [inline]
  device_release_driver_internal+0x23a/0x4f0 drivers/base/dd.c:1113
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

The buggy address belongs to the object at ffff888098dca200
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 480 bytes inside of
  4096-byte region [ffff888098dca200, ffff888098dcb200)
The buggy address belongs to the page:
page:ffffea0002637200 count:1 mapcount:0 mapping:ffff88812c3f4600  
index:0xffff888098dcb300 compound_mapcount: 0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea0002638008 ffffea0002477808 ffff88812c3f4600
raw: ffff888098dcb300 0000000000070006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888098dca280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888098dca300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888098dca380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff888098dca400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888098dca480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

