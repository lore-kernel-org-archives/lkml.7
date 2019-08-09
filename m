Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D565C32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EB22171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407053AbfHINSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:18:10 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:33951 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406970AbfHINSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:18:09 -0400
Received: by mail-ot1-f71.google.com with SMTP id 20so25263200oty.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Kvv51GsZ8BLyp4CiiiYwop4a0Hzx8ieVcMFPRG1pYMA=;
        b=Vok3n3I22N0aFZ8fBh3gJDuds4rEAWldN+gmV6olh18RjqpvdBnUnVj0WZig2qucQ/
         0mZSaUb24f1p3CrnivumWpB9TpNooxaY5ul0q+k3y/fHKbAkowxXVNtj554am9L8sn+z
         72ODe5tZED/eZp+fqc6zAHfLW2S1hs8HyPW56sy8WafUB+Z497UTKl8m1q2rafez8MKC
         LHN94w08XjGPvqan895HxICXbpXpwI1RGNYeVtXtXYYYEs1/NOLMeR9X99B4g0CofsB2
         kxVZtF/gTD7xaRZnW6PM8IVJW+yPmWhfQaG01D6g/HOLPnpbzmvJErUlvhO8eg3sDhfx
         oZhw==
X-Gm-Message-State: APjAAAVoHdmR/n/vEi1tzAEu66drSSskL1qunmH8vrx2CMZf3y8vBYTX
        VfndWFigOpISzhbzps0jEEQe118UMd1h2O595FTkSHXjXFEd
X-Google-Smtp-Source: APXvYqzWbwc1QZIZxwLs/zp7o1Dkn8P3FmJxHSQmOJ77vx3/BPpTj6o3+BHv6HDea9AUA9LWrwH/e5VHVPE6/ROau0SKGPvc4VJX
MIME-Version: 1.0
X-Received: by 2002:a02:5a02:: with SMTP id v2mr21783557jaa.124.1565356687627;
 Fri, 09 Aug 2019 06:18:07 -0700 (PDT)
Date:   Fri, 09 Aug 2019 06:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000502536058faf0113@google.com>
Subject: KASAN: use-after-free Read in prepare_to_wait_event
From:   syzbot <syzbot+332cbcbd8be3e03c62eb@syzkaller.appspotmail.com>
To:     alexandre.belloni@bootlin.com, andreyknvl@google.com,
        enric.balletbo@collabora.com, gregkh@linuxfoundation.org,
        kirr@nexedi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux@roeck-us.net, logang@deltatee.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10fbde8c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=332cbcbd8be3e03c62eb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127dd636600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171de9ce600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+332cbcbd8be3e03c62eb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x302a/0x3b50  
kernel/locking/lockdep.c:3753
Read of size 8 at addr ffff8881d2a83238 by task syz-executor771/2979

CPU: 0 PID: 2979 Comm: syz-executor771 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  __lock_acquire+0x302a/0x3b50 kernel/locking/lockdep.c:3753
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
  prepare_to_wait_event+0x5b/0x650 kernel/sched/wait.c:263
  ld_usb_read+0x619/0x780 drivers/usb/misc/ldusb.c:480
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x1e8/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448859
Code: e8 ac e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9b31740ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000006dec48 RCX: 0000000000448859
RDX: 0000000000000049 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00000000006dec40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dec4c
R13: 00007ffd58e161df R14: 00007f9b317419c0 R15: 00000000006dec4c

Allocated by task 2705:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  ld_usb_probe+0x6e/0xa65 drivers/usb/misc/ldusb.c:661
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

Freed by task 2705:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1470 [inline]
  slab_free mm/slub.c:3012 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3953
  ld_usb_probe+0x728/0xa65 drivers/usb/misc/ldusb.c:744
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

The buggy address belongs to the object at ffff8881d2a83180
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 184 bytes inside of
  512-byte region [ffff8881d2a83180, ffff8881d2a83380)
The buggy address belongs to the page:
page:ffffea00074aa080 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da002500
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d2a83100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d2a83180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d2a83200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                         ^
  ffff8881d2a83280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d2a83300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
