Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8099FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5770A208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfICMI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:08:56 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43102 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfICMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:11 -0400
Received: by mail-io1-f72.google.com with SMTP id q26so22774025ioi.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=illcZo61Q1+8epPO+mzOIeMYTA84TMifeBqGWFjIaZw=;
        b=AXyS16yyiELfoLrrD/ZXl2wmRwmnzupQ5vwKIleeYZD9GDSAo25eywzLTTUU8sHw9c
         acVcDOY4+KjShLjP55AY7PaugiNigItDWEPDJLwYL5eiGaeZlG4HSSVvxgVfdrcUnCnX
         9ph6g8rCKr3bKCw6/mrlxZ/dv/42NkfInNbncpM7YAmSYJlMg1md1ClxynqjvR7AVanZ
         gN/2ceyLo7tRF3J1v5VcmX9/H5VRMd9y6E2Si4vNogVf/rTE3fAiUVnOAKaQirnr7oY8
         Brql+8mlG6SBFCb5qUJOE3wcpiUVem0rUqZ0uybbKQjp614tEKK/QvpKflDVtJ7HMKcY
         yCDA==
X-Gm-Message-State: APjAAAWWoqhcJ89fmbcwiNAmzGQ7zi5D7eCt9Ly9Zc2nhhF56ohoUoLv
        NesY45Xg0VSEO0a4FVhAr4Z/slAP+mnpKQ0xEOZfj7UWEOm2
X-Google-Smtp-Source: APXvYqym4Cl4Jq7zG29PM5QkkZo0/PQb43sg9q5HuSNpksX+YsoCbEJZvAjpjL/wdEqNT0kWBUKv13CzSnmV7+d2UfWKac8tWCdn
MIME-Version: 1.0
X-Received: by 2002:a5d:84c8:: with SMTP id z8mr21657375ior.214.1567512490771;
 Tue, 03 Sep 2019 05:08:10 -0700 (PDT)
Date:   Tue, 03 Sep 2019 05:08:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000318cba0591a4f143@google.com>
Subject: KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
From:   syzbot <syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, andreyknvl@google.com,
        dianders@chromium.org, gregkh@linuxfoundation.org,
        jflat@chromium.org, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        malat@debian.org, mathias.nyman@linux.intel.com,
        nsaenzjulienne@suse.de, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=174761b6600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=35f4d916c623118d576e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1706275a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcmp+0xa6/0xb0 lib/string.c:904
Read of size 1 at addr ffff8881d175bed6 by task kworker/0:3/2746

CPU: 0 PID: 2746 Comm: kworker/0:3 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  memcmp+0xa6/0xb0 lib/string.c:904
  memcmp include/linux/string.h:400 [inline]
  descriptors_changed drivers/usb/core/hub.c:5579 [inline]
  usb_reset_and_verify_device+0x564/0x1300 drivers/usb/core/hub.c:5729
  usb_reset_device+0x4c1/0x920 drivers/usb/core/hub.c:5898
  rt2x00usb_probe+0x53/0x7af  
drivers/net/wireless/ralink/rt2x00/rt2x00usb.c:806
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 2746:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:557 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  usb_get_bos_descriptor+0x1fd/0x8f2 drivers/usb/core/config.c:955
  hub_port_init+0x169a/0x2d30 drivers/usb/core/hub.c:4837
  usb_reset_and_verify_device+0x3aa/0x1300 drivers/usb/core/hub.c:5720
  usb_reset_device+0x4c1/0x920 drivers/usb/core/hub.c:5898
  rt2x00usb_probe+0x53/0x7af  
drivers/net/wireless/ralink/rt2x00/rt2x00usb.c:806
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 1751:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  __vunmap+0x6d5/0x930 mm/vmalloc.c:2258
  __vfree+0x3c/0xd0 mm/vmalloc.c:2299
  vfree+0x5a/0x90 mm/vmalloc.c:2329
  copy_entries_to_user net/ipv4/netfilter/ip_tables.c:867 [inline]
  get_entries net/ipv4/netfilter/ip_tables.c:1024 [inline]
  do_ipt_get_ctl+0x6a0/0x890 net/ipv4/netfilter/ip_tables.c:1700
  nf_sockopt net/netfilter/nf_sockopt.c:104 [inline]
  nf_getsockopt+0x72/0xd0 net/netfilter/nf_sockopt.c:122
  ip_getsockopt net/ipv4/ip_sockglue.c:1576 [inline]
  ip_getsockopt+0x165/0x1c0 net/ipv4/ip_sockglue.c:1556
  tcp_getsockopt net/ipv4/tcp.c:3662 [inline]
  tcp_getsockopt+0x86/0xd0 net/ipv4/tcp.c:3656
  __sys_getsockopt+0x135/0x210 net/socket.c:2129
  __do_sys_getsockopt net/socket.c:2144 [inline]
  __se_sys_getsockopt net/socket.c:2141 [inline]
  __x64_sys_getsockopt+0xba/0x150 net/socket.c:2141
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d175bea0
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 54 bytes inside of
  64-byte region [ffff8881d175bea0, ffff8881d175bee0)
The buggy address belongs to the page:
page:ffffea000745d6c0 refcount:1 mapcount:0 mapping:ffff8881da003180  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea00075eda00 0000000300000003 ffff8881da003180
raw: 0000000000000000 00000000802a002a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d175bd80: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
  ffff8881d175be00: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8881d175be80: fc fc fc fc 00 00 00 00 00 00 06 fc fc fc fc fc
                                                  ^
  ffff8881d175bf00: 00 00 00 00 00 00 fc fc fc fc fc fc fb fb fb fb
  ffff8881d175bf80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
