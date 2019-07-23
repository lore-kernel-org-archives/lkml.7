Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C18C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E5921903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbfGWMsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:48:40 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34129 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389720AbfGWMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:48:08 -0400
Received: by mail-io1-f69.google.com with SMTP id u84so47187997iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PPTlSfVf47u6ouVSdoOPjxM9QHmmrq+36NqQqM5yMq0=;
        b=oWuT4L3nB6xNuHAJ8HF5rC8OIaFf4dCxYZzvFWr+PYTAWmVwQatM2aSQMMzpovg1PF
         A4LQmZSm4hFsGKfbImqsTWePyp95d0JH2wr3693nBhLZkbbcGnKcpnvBsz3FgdXHyCXU
         tSmm7JBiKiOPBFnYIoGOCa8P22RWZxf0KWvTUjyuHdE7x2yI6Q+9gvRGaONNeX7rzIiu
         ZB5Bv9S/iH8AlSYLA1zAwbAR06cg1X92KaDio3jY8t5/RZt/46e71sEJZzdAkdo9HOj8
         RPvxa3EvSFwUXBv/5aCUnBKs6A21NPBHvR0JTMQ6pdkLi75DQ+lIGVWGEXNhtjXHuNQx
         Mm+A==
X-Gm-Message-State: APjAAAVZLnTNaThg+ayNLBzgLuwu0+w5n0EMwil7xcvK2q7CCu0MXvC+
        Lne3BDx+JCs922tVugYRRTBfJx0NVpwEc+xXFwTbt2ci5FCD
X-Google-Smtp-Source: APXvYqzJrrVV8vtr6nkWlSgee5VRWcFw8foAgy5usx6TAt8XjkPNeni/VVmGIGjiZSXc8z0K1XRqF9Ar1NOTELsG18X5xQ8HFxKt
MIME-Version: 1.0
X-Received: by 2002:a5d:8252:: with SMTP id n18mr2456697ioo.230.1563886087780;
 Tue, 23 Jul 2019 05:48:07 -0700 (PDT)
Date:   Tue, 23 Jul 2019 05:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb4247058e589a20@google.com>
Subject: KASAN: use-after-free Read in usbhid_power
From:   syzbot <syzbot+ef5de9c4f99c4edb4e49@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11b13e78600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=ef5de9c4f99c4edb4e49
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15482210600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1139b07c600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef5de9c4f99c4edb4e49@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in usbhid_power+0xca/0xe0  
/drivers/hid/usbhid/hid-core.c:1234
Read of size 8 at addr ffff8881ce8a4008 by task syz-executor373/1763

CPU: 0 PID: 1763 Comm: syz-executor373 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e /lib/dump_stack.c:113
  print_address_description+0x67/0x231 /mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 /mm/kasan/report.c:317
  kasan_report+0xe/0x20 /mm/kasan/common.c:614
  usbhid_power+0xca/0xe0 /drivers/hid/usbhid/hid-core.c:1234
  hid_hw_power /./include/linux/hid.h:1038 [inline]
  hidraw_open+0x20d/0x740 /drivers/hid/hidraw.c:282
  chrdev_open+0x219/0x5c0 /fs/char_dev.c:413
  do_dentry_open+0x497/0x1040 /fs/open.c:778
  do_last /fs/namei.c:3416 [inline]
  path_openat+0x1430/0x3ff0 /fs/namei.c:3533
  do_filp_open+0x1a1/0x280 /fs/namei.c:3563
  do_sys_open+0x3c0/0x580 /fs/open.c:1070
  do_syscall_64+0xb7/0x560 /arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x401ad0
Code: 01 f0 ff ff 0f 83 c0 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d fd 5b 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 94 0b 00 00 c3 48 83 ec 08 e8 fa 00 00 00
RSP: 002b:00007ffff378ac48 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000401ad0
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00007ffff378ac50
RBP: 6666666666666667 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402af0
R13: 0000000000402b80 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 21:
  save_stack+0x1b/0x80 /mm/kasan/common.c:71
  set_track /mm/kasan/common.c:79 [inline]
  __kasan_kmalloc /mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 /mm/kasan/common.c:462
  slab_post_alloc_hook /mm/slab.h:437 [inline]
  slab_alloc_node /mm/slub.c:2748 [inline]
  __kmalloc_node_track_caller+0xee/0x370 /mm/slub.c:4363
  __kmalloc_reserve.isra.0+0x39/0xe0 /net/core/skbuff.c:138
  __alloc_skb+0xef/0x5a0 /net/core/skbuff.c:206
  alloc_skb /./include/linux/skbuff.h:1054 [inline]
  alloc_uevent_skb+0x7b/0x210 /lib/kobject_uevent.c:289
  uevent_net_broadcast_untagged /lib/kobject_uevent.c:325 [inline]
  kobject_uevent_net_broadcast /lib/kobject_uevent.c:408 [inline]
  kobject_uevent_env+0x8ee/0x1150 /lib/kobject_uevent.c:592
  device_add+0xade/0x16f0 /drivers/base/core.c:2110
  usb_set_configuration+0xdf6/0x1670 /drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 /drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 /drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 /drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
  __device_attach+0x217/0x360 /drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
  device_add+0xae6/0x16f0 /drivers/base/core.c:2111
  usb_new_device.cold+0x6a4/0xe61 /drivers/usb/core/hub.c:2536
  hub_port_connect /drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
  port_event /drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1abd/0x3550 /drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
  process_scheduled_works /kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 /kernel/workqueue.c:2417
  kthread+0x30b/0x410 /kernel/kthread.c:255
  ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352

Freed by task 243:
  save_stack+0x1b/0x80 /mm/kasan/common.c:71
  set_track /mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x130/0x180 /mm/kasan/common.c:451
  slab_free_hook /mm/slub.c:1421 [inline]
  slab_free_freelist_hook /mm/slub.c:1448 [inline]
  slab_free /mm/slub.c:2994 [inline]
  kfree+0xd7/0x280 /mm/slub.c:3949
  skb_free_head+0x8b/0xa0 /net/core/skbuff.c:588
  skb_release_data+0x41f/0x7c0 /net/core/skbuff.c:608
  skb_release_all+0x46/0x60 /net/core/skbuff.c:662
  __kfree_skb /net/core/skbuff.c:676 [inline]
  consume_skb /net/core/skbuff.c:736 [inline]
  consume_skb+0xc0/0x2f0 /net/core/skbuff.c:730
  skb_free_datagram+0x16/0xf0 /net/core/datagram.c:328
  netlink_recvmsg+0x65e/0xea0 /net/netlink/af_netlink.c:2001
  sock_recvmsg_nosec /net/socket.c:877 [inline]
  sock_recvmsg /net/socket.c:894 [inline]
  sock_recvmsg+0xca/0x110 /net/socket.c:890
  ___sys_recvmsg+0x271/0x5a0 /net/socket.c:2448
  __sys_recvmsg+0xe9/0x1b0 /net/socket.c:2497
  do_syscall_64+0xb7/0x560 /arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881ce8a4000
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
  1024-byte region [ffff8881ce8a4000, ffff8881ce8a4400)
The buggy address belongs to the page:
page:ffffea00073a2900 refcount:1 mapcount:0 mapping:ffff8881dac02a00  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000200 ffff8881dac02a00
raw: 0000000000000000 00000000800e000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ce8a3f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881ce8a3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881ce8a4000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8881ce8a4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881ce8a4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
