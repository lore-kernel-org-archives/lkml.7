Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF54EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8420656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfD2MGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:06:10 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:58347 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfD2MGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:06:08 -0400
Received: by mail-it1-f200.google.com with SMTP id p23so9269287itc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ix8Z2fJNevZWPbRskDnIfWSeRE9F40gNE1x92GS3NQU=;
        b=AsBkFwiVWlbyJ3Byw8eHIdWdwkwMfS8H9WutdT+VxYEO2kEwNAp6n51ZNV717cmvm8
         Ukjh3pgpEYXiHiGFG6WeMEM0CcxROkApp0ITtHtbK7nCtN0tIoUP5sO3tHkigg+wUy+u
         ZtSGwHoweYACfIH5S+q2NQAuWdp4WKNeEU7zKSpWCCCF3KeTOPAQSUTQAp07c+sZwKmx
         DgtaJNpFulgUk+YT+DZSkXsGzsttKziz3vvZm4bCCAaDVTCrRFCD4QQt8cKNjWN8X7Fu
         EasHxihzT01WBqs3n1Y4Oo00SPWT0rVqFTzppwBD3zOMJdjelr6KvIbIRUePCCagoiAK
         7Mtw==
X-Gm-Message-State: APjAAAUhoP2/aS+A5gblEVDcJB9bl0x8l/Hm2uGbmQc4brX0E1/kgTfy
        xrXTt/q+901Wh5L0F4atdKA2j0kIVUESt16Dr5VtU8rNrBa1
X-Google-Smtp-Source: APXvYqx58A78aDt3/FKed31uAKsQdMgHqWMGUnCuKaYO/lx6Vm1J9Xq9jm8eLW1n94f6qwrb0UpGQyuxBXAAY+9ykdPNpyKkZ5tH
MIME-Version: 1.0
X-Received: by 2002:a6b:410e:: with SMTP id n14mr35885266ioa.141.1556539566887;
 Mon, 29 Apr 2019 05:06:06 -0700 (PDT)
Date:   Mon, 29 Apr 2019 05:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f69c3b0587aa1bc5@google.com>
Subject: KASAN: slab-out-of-bounds Read in hex_string
From:   syzbot <syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com>
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

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=139ac37f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
dashboard link: https://syzkaller.appspot.com/bug?extid=a9fefd18c7b240f19c54
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f3b338a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in hex_string+0x418/0x4b0 lib/vsprintf.c:975
Read of size 1 at addr ffff88821a41bd38 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc3-319004-g43151d6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  hex_string+0x418/0x4b0 lib/vsprintf.c:975
  pointer+0x460/0x910 lib/vsprintf.c:1985
  vsnprintf+0x5a0/0x16b0 lib/vsprintf.c:2400
  pointer+0x60b/0x910 lib/vsprintf.c:2038
  vsnprintf+0x5a0/0x16b0 lib/vsprintf.c:2400
  vscnprintf+0x29/0x80 lib/vsprintf.c:2499
  vprintk_store+0x45/0x4b0 kernel/printk/printk.c:1900
  vprintk_emit+0x210/0x5a0 kernel/printk/printk.c:1957
  dev_vprintk_emit+0x50e/0x553 drivers/base/core.c:3185
  dev_printk_emit+0xbf/0xf6 drivers/base/core.c:3196
  __dev_printk+0x1ed/0x215 drivers/base/core.c:3208
  _dev_info+0xdc/0x10e drivers/base/core.c:3254
  dlfb_parse_vendor_descriptor drivers/video/fbdev/udlfb.c:1532 [inline]
  dlfb_usb_probe.cold+0xb96/0x1701 drivers/video/fbdev/udlfb.c:1615
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2023
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

Allocated by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  kmalloc include/linux/slab.h:552 [inline]
  usb_get_configuration+0x313/0x32b0 drivers/usb/core/config.c:857
  usb_enumerate_device drivers/usb/core/hub.c:2367 [inline]
  usb_new_device+0x2fe/0x450 drivers/usb/core/hub.c:2503
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 1464:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  single_release+0x91/0xb0 fs/seq_file.c:597
  __fput+0x2df/0x8c0 fs/file_table.c:278
  task_work_run+0x149/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x243/0x270 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x40c/0x4f0 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88821a41bd20
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
  32-byte region [ffff88821a41bd20, ffff88821a41bd40)
The buggy address belongs to the page:
page:ffffea00086906c0 count:1 mapcount:0 mapping:ffff88812c3f5800 index:0x0
flags: 0x57ff00000000200(slab)
raw: 057ff00000000200 dead000000000100 dead000000000200 ffff88812c3f5800
raw: 0000000000000000 0000000000550055 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88821a41bc00: 00 00 00 fc fc fc 00 00 00 00 fc fc 00 00 00 00
  ffff88821a41bc80: fc fc 00 00 00 00 fc fc fb fb fb fb fc fc fb fb
> ffff88821a41bd00: fb fb fc fc 00 00 00 fc fc fc fb fb fb fb fc fc
                                         ^
  ffff88821a41bd80: 00 00 00 fc fc fc 00 00 00 fc fc fc fb fb fb fb
  ffff88821a41be00: fc fc fb fb fb fb fc fc fb fb fb fb fc fc 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
