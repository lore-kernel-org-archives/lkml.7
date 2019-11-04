Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C34DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2382053B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfKDMWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:22:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39226 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbfKDMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:22:10 -0500
Received: by mail-il1-f198.google.com with SMTP id o11so15429290ilc.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 04:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4gDe12v8y5sZzl5bRVDx0hn51S+qvhn/IcmB4GnqhKU=;
        b=V/FvMM9cugwnipQtqI5pYGhs1joeYk1x0JxBHtbf5Z5M9I9mNr5saRehdU7I/uZxLI
         Rz1JnC8IJ9EESK/TWAPeI4WCilMo20K6RaV+bHVLS5msMKyc3Nd0CDJtB35bPQuKX21F
         xbE2UMxORRYVEDg9lRyTiBEE3A5nzcxV0dTQUIIsO4Fw7J62RToBQNXcUqfFEAqlgZV6
         y2WWfY3weOQL3rrzd9xqAUmQKOoQmScCzwmnqwRdIweODY6zZNexu8Sc9wEz9yt1EEt0
         Owe5SCzPgCLu8HsqkLL8E/2ZujQONVhFEMl3wNtBVWpvkt7obpdPb7cAIhZbp9DcpHSk
         3m9g==
X-Gm-Message-State: APjAAAUhexDA5aq43nfZ7s6vHju8I+OeCPPNbG/6DUy5HLPz5doPnMcM
        zF5t3OOcWQ6jraOClH09dk9u+KGtMdGyx40hqGInoooavcAv
X-Google-Smtp-Source: APXvYqxo8wV+Pmk6OTFVxo57aJyjbL56rwg6QcbRvN8tHLWBHNCdrib+vjm2JVt8sCXRc223gTiLZVJzBRVlLzHBVpajaT4eoEoV
MIME-Version: 1.0
X-Received: by 2002:a92:700f:: with SMTP id l15mr27884571ilc.121.1572870129234;
 Mon, 04 Nov 2019 04:22:09 -0800 (PST)
Date:   Mon, 04 Nov 2019 04:22:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054c2430596845dbc@google.com>
Subject: KASAN: use-after-free Read in usbhid_close (2)
From:   syzbot <syzbot+d5be9c871914696d00dc@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ff6409a6 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11295858e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3230c37d442895b7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5be9c871914696d00dc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d5be9c871914696d00dc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in usb_kill_urb+0x297/0x2c0  
drivers/usb/core/urb.c:690
Read of size 8 at addr ffff8881d0756c40 by task syz-executor.3/6221

CPU: 1 PID: 6221 Comm: syz-executor.3 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:634
  usb_kill_urb+0x297/0x2c0 drivers/usb/core/urb.c:690
  usbhid_close+0x15c/0x210 drivers/hid/usbhid/hid-core.c:750
  hid_hw_close+0xa8/0xd0 drivers/hid/hid-core.c:2046
  wacom_close+0x66/0x80 drivers/hid/wacom_sys.c:192
  input_close_device+0x110/0x1a0 drivers/input/input.c:682
  evdev_close_device drivers/input/evdev.c:428 [inline]
  evdev_release+0x188/0x1c0 drivers/input/evdev.c:466
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413ce1
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fa7dca607a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffea RBX: 6666666666666667 RCX: 0000000000413ce1
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 00007fa7dca60850
RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fa7dca616d4
R13: 00000000004c9a00 R14: 00000000004e1728 R15: 00000000ffffffff

Allocated by task 22:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:483
  kmalloc include/linux/slab.h:561 [inline]
  usb_alloc_urb+0x65/0xb0 drivers/usb/core/urb.c:73
  usbhid_start+0xb26/0x22f0 drivers/hid/usbhid/hid-core.c:1121
  hid_hw_start+0x5d/0x130 drivers/hid/hid-core.c:1976
  wacom_parse_and_register+0x28a0/0x51e0 drivers/hid/wacom_sys.c:2365
  wacom_probe+0x94d/0xba0 drivers/hid/wacom_sys.c:2748
  hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2209
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2202
  hid_add_device drivers/hid/hid-core.c:2365 [inline]
  hid_add_device+0x33c/0x9a0 drivers/hid/hid-core.c:2314
  usbhid_probe+0xa81/0xfa0 drivers/hid/usbhid/hid-core.c:1386
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2202
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2202
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x1df8/0x3800 drivers/usb/core/hub.c:5552
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 2758:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:471
  slab_free_hook mm/slub.c:1424 [inline]
  slab_free_freelist_hook mm/slub.c:1475 [inline]
  slab_free mm/slub.c:3025 [inline]
  kfree+0xe4/0x320 mm/slub.c:3977
  urb_destroy drivers/usb/core/urb.c:26 [inline]
  kref_put include/linux/kref.h:65 [inline]
  usb_free_urb.part.0+0x7a/0xc0 drivers/usb/core/urb.c:95
  usb_free_urb+0x1b/0x30 drivers/usb/core/urb.c:94
  usbhid_stop+0x1d4/0x460 drivers/hid/usbhid/hid-core.c:1217
  wacom_remove+0x88/0x3b0 drivers/hid/wacom_sys.c:2772
  hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2242
  __device_release_driver drivers/base/dd.c:1132 [inline]
  device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:532
  device_del+0x420/0xb20 drivers/base/core.c:2376
  hid_remove_device drivers/hid/hid-core.c:2413 [inline]
  hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2432
  usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1413
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1134 [inline]
  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:532
  device_del+0x420/0xb20 drivers/base/core.c:2376
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2200
  hub_port_connect drivers/usb/core/hub.c:5035 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x16f2/0x3800 drivers/usb/core/hub.c:5552
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d0756c00
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 64 bytes inside of
  192-byte region [ffff8881d0756c00, ffff8881d0756cc0)
The buggy address belongs to the page:
page:ffffea000741d580 refcount:1 mapcount:0 mapping:ffff8881da002a00  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 0000000000000000 0000000f00000001 ffff8881da002a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d0756b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d0756b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881d0756c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8881d0756c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881d0756d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
