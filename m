Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FBC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA88216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHEL6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:58:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47722 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfHEL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:58:08 -0400
Received: by mail-io1-f70.google.com with SMTP id r27so91968929iob.14
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kGLdZ5MTvlXp3lX7BC9u5mWxWMWN85aY1aGKSJocuqQ=;
        b=a65u/4iNK2xtU+c1CouobdAlwsjI5W5zzvUpBwHtYCi3/gvJ0yyxPoxi81JMmZOCLp
         tcTZ5GqLh8FyJej74ZPIwC3AWPKdyovrVJac5MXDOhTZH8vwVMU5n8+v5RQHXAdXULbi
         LI/CWoJdOEcwsgVwV3SMCXeJI2V66IOwF5qp8TOnuv+MUU9qG9lyBUwy1424IZMc50Kh
         LrMVDdqs+YfzArxMK5fKq6yyG0h4cAIKZwc6Z7OPlbX2DKYLvTowvzMKnwbNMWhwHejl
         a+KcIQ43w290Jg+dTex6qM3EVVLg3KMSIRkN7JjqcAnM6igNJrM2Nnzax7EGonlPX+Cu
         AJXg==
X-Gm-Message-State: APjAAAUbr2Nvyrd5N3CyMhWdrZd50nDkdhr/xRa4jtl9vuMQPyXKN99S
        HbUkyit9fummsRdHRsyTPMdL2QboXiWI/8FDWjoo2hqJFLis
X-Google-Smtp-Source: APXvYqyuxZx8sjtCctIzhAXVre+T79RB1MtrHAZsjVvQFBskNrxNPYPhjljuY7NqNu6FglFjJ+lZi1vxhJo2sWSH85WsnGqPKoO8
MIME-Version: 1.0
X-Received: by 2002:a02:a409:: with SMTP id c9mr13582882jal.74.1565006287151;
 Mon, 05 Aug 2019 04:58:07 -0700 (PDT)
Date:   Mon, 05 Aug 2019 04:58:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d12d24058f5d6b65@google.com>
Subject: KASAN: use-after-free Read in adu_disconnect
From:   syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dmg@turingmachine.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=148af1b2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com

usb 4-1: USB disconnect, device number 59
==================================================================
BUG: KASAN: use-after-free in atomic64_read  
include/asm-generic/atomic-instrumented.h:836 [inline]
BUG: KASAN: use-after-free in atomic_long_read  
include/asm-generic/atomic-long.h:28 [inline]
BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0x96/0x670  
kernel/locking/mutex.c:1211
Read of size 8 at addr ffff8881d67b0c80 by task kworker/1:1/22

CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
  atomic64_read include/asm-generic/atomic-instrumented.h:836 [inline]
  atomic_long_read include/asm-generic/atomic-long.h:28 [inline]
  __mutex_unlock_slowpath+0x96/0x670 kernel/locking/mutex.c:1211
  adu_disconnect+0x83/0x150 drivers/usb/misc/adutux.c:768
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1120 [inline]
  device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1151
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x420/0xb10 drivers/base/core.c:2288
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 2764:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  adu_probe+0x7d/0x6e0 drivers/usb/misc/adutux.c:660
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 11056:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1470 [inline]
  slab_free mm/slub.c:3012 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3953
  adu_release+0x3cc/0x590 drivers/usb/misc/adutux.c:332
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d67b0c80
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
  512-byte region [ffff8881d67b0c80, ffff8881d67b0e80)
The buggy address belongs to the page:
page:ffffea000759ec00 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea00074eca80 0000000200000002 ffff8881da002500
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d67b0b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d67b0c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881d67b0c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8881d67b0d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d67b0d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
