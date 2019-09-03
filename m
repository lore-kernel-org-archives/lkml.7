Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880842077B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfICTUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:20:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:42782 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfICTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:20:02 -0400
Received: by mail-io1-f72.google.com with SMTP id x9so24297573ior.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vpkDtDmNg/M0eu9z3wrnes2hEdcuwz7rwGrlhBNzL1Q=;
        b=aSoM/z3v+kyKm7ZVHTW2kAnu49Hk4Nmpn8y6piezmODBuwTtdcdI+qobXcqD5nltVG
         eBE+GB2mqB4B0wLa8aDTY3g36SQuCfneMmbXIMkHN1Y8o3V4f8j3ULx7pKnqmL5Fcs5N
         tJsd7ZBMqJrJ27js603KWIlnRq5aFqGKzGBMxHN4AdQxQZn3mu4EquLiZ4PwKdM0bfh/
         E2EH9g1QB/VCDX1bkyhDeeSyBfqwCl5hVYrYsC9J8AOchD42bgb/YeWPIbD+qA8pCNnd
         2Bk9+g+yfOcgFTnh8UA4jTVEmKBkkDGAviK1CfHunAnpGpUeSY1p1ajBBWYI8nYlwukz
         3noA==
X-Gm-Message-State: APjAAAWs3g6bU1A5jv5v9AVRZP5Vub5YVDbBAr/FriXPsRFHZu5SuufF
        zE0+ifJZU/ICh8AqsMEOokIn4GWKz4pYS+dn4QqC2oXMNXH2
X-Google-Smtp-Source: APXvYqwM8X7mOSYawgUeRtJeBO5M8ttrlD44mQZye8vt3bgrQeXRyVxFM7d/W2atJc+Xnu67S3sbNwM8wAiMqApUMAsbIxEZh+u7
MIME-Version: 1.0
X-Received: by 2002:a02:600c:: with SMTP id i12mr40314598jac.84.1567538401149;
 Tue, 03 Sep 2019 12:20:01 -0700 (PDT)
Date:   Tue, 03 Sep 2019 12:20:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909031501550.1859-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009290140591aaf9e7@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
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

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device

usb 4-1: Old BOS 00000000ffd70172  Len 0xa8
usb 4-1: New BOS 00000000b6d58371  Len 0xa8
==================================================================
BUG: KASAN: slab-out-of-bounds in memcmp+0xa6/0xb0 lib/string.c:904
Read of size 1 at addr ffff8881cd95d876 by task kworker/0:4/2841

CPU: 0 PID: 2841 Comm: kworker/0:4 Not tainted 5.3.0-rc5+ #0
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
  usb_reset_and_verify_device+0x5a8/0x1350 drivers/usb/core/hub.c:5736
  usb_reset_device+0x4c1/0x920 drivers/usb/core/hub.c:5905
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

Allocated by task 2841:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:557 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  usb_get_bos_descriptor+0x1fd/0x8f2 drivers/usb/core/config.c:955
  hub_port_init+0x169a/0x2d30 drivers/usb/core/hub.c:4837
  usb_reset_and_verify_device+0x3aa/0x1350 drivers/usb/core/hub.c:5720
  usb_reset_device+0x4c1/0x920 drivers/usb/core/hub.c:5905
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

Freed by task 1862:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  call_usermodehelper_freeinfo kernel/umh.c:47 [inline]
  call_usermodehelper_exec+0x235/0x4d0 kernel/umh.c:598
  call_modprobe kernel/kmod.c:99 [inline]
  __request_module+0x459/0xb20 kernel/kmod.c:171
  dev_load+0x1e8/0x200 net/core/dev_ioctl.c:354
  dev_ioctl+0x29c/0xc68 drivers/usb/gadget/legacy/inode.c:2050
  sock_do_ioctl+0x1b7/0x2f0 net/socket.c:1061
  sock_ioctl+0x3ed/0x790 net/socket.c:1189
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cd95d840
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 54 bytes inside of
  64-byte region [ffff8881cd95d840, ffff8881cd95d880)
The buggy address belongs to the page:
page:ffffea0007365740 refcount:1 mapcount:0 mapping:ffff8881da003180  
index:0xffff8881cd95df00
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea000734e3c0 0000000800000008 ffff8881da003180
raw: ffff8881cd95df00 00000000802a0026 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cd95d700: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
  ffff8881cd95d780: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
> ffff8881cd95d800: fb fb fb fb fc fc fc fc 00 00 00 00 00 00 06 fc
                                                              ^
  ffff8881cd95d880: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
  ffff8881cd95d900: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
==================================================================


Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10b38c76600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=35f4d916c623118d576e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dba871600000

