Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B47BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E599420C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfG3JiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:38:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43271 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731723AbfG3JiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:38:08 -0400
Received: by mail-io1-f69.google.com with SMTP id q26so70731010ioi.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=53Hrz/OtELPUG0hNdhRNwCkhNoRtmCPZGt+EMugSqG8=;
        b=isq931SRccL+LyqhaBEteSiMyDY/ZDdBi8OmJzFc+bEFBGmFKqeqTCzIm4sQ/XA6xO
         J227FCDHn4cHLeUrDSRtkNkGTHVx/eYrLeE9uTjPefAxnyMX/lkP5adgPLd/gK6zzhe7
         mmnsswly9zEbKjBTlYncYC0cUkHCmf9nMi0sM4XXUshg6z+uLYXjRqUkqE+H8FKsY08C
         /6KDIwFfoGoDhCynw3d+9jJGjgNNvgAABNbKy67uqup7bpzIWF8Gwuo8D6KxuT8KyrEB
         CIDRXo4sooyOx7BrZWcukn6ZYqjEIfqbdWHN9cSQ5Si3yN8qHdak1bMexsHw+umTWwVi
         d9OA==
X-Gm-Message-State: APjAAAWlOk2/rPiW6VXtYz4u3iUuCn9ne1/L6Tglp3GOYG0lDrOPhzI7
        zG+nHq0jisu8NrduK5WUDgDczboc7AJ9G7RvJlGli7+Dy7Xb
X-Google-Smtp-Source: APXvYqwuvRmNTcwg9iQrCqkPcRPhluRcxAGGDpgoxP3/OXI+M295spndYhrY+LO9Q1wSG+rOzm/EP5J1nr5yv+7A+XKKLpg76Hch
MIME-Version: 1.0
X-Received: by 2002:a6b:901:: with SMTP id t1mr32385385ioi.42.1564479487254;
 Tue, 30 Jul 2019 02:38:07 -0700 (PDT)
Date:   Tue, 30 Jul 2019 02:38:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018abb4058ee2c401@google.com>
Subject: KMSAN: kernel-usb-infoleak in pcan_usb_pro_init
From:   syzbot <syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    beaab8a3 fix KASAN build
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=12ddda44600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4db781fe35a84ef5
dashboard link: https://syzkaller.appspot.com/bug?extid=d6a5a1a3657b596ef132
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e3625c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115e7264600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=0c72, idProduct=000d,  
bcdDevice=da.d3
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50  
/drivers/usb/core/urb.c:405
CPU: 1 PID: 3814 Comm: kworker/1:2 Not tainted 5.2.0+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 /lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 /mm/kmsan/kmsan_report.c:109
  kmsan_internal_check_memory+0x974/0xa80 /mm/kmsan/kmsan.c:551
  kmsan_handle_urb+0x28/0x40 /mm/kmsan/kmsan_hooks.c:621
  usb_submit_urb+0x7ef/0x1f50 /drivers/usb/core/urb.c:405
  usb_start_wait_urb+0x143/0x410 /drivers/usb/core/message.c:58
  usb_internal_control_msg /drivers/usb/core/message.c:102 [inline]
  usb_control_msg+0x49f/0x7f0 /drivers/usb/core/message.c:156
  pcan_usb_pro_send_req /drivers/net/can/usb/peak_usb/pcan_usb_pro.c:336  
[inline]
  pcan_usb_pro_drv_loaded /drivers/net/can/usb/peak_usb/pcan_usb_pro.c:504  
[inline]
  pcan_usb_pro_init+0x1319/0x1720  
/drivers/net/can/usb/peak_usb/pcan_usb_pro.c:894
  peak_usb_create_dev /drivers/net/can/usb/peak_usb/pcan_usb_core.c:809  
[inline]
  peak_usb_probe+0x1416/0x1b20  
/drivers/net/can/usb/peak_usb/pcan_usb_core.c:907
  usb_probe_interface+0xd19/0x1310 /drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 /drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 /drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 /drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 /drivers/base/bus.c:454
  __device_attach+0x489/0x750 /drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 /drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 /drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 /drivers/base/core.c:2111
  usb_set_configuration+0x309f/0x3710 /drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 /drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 /drivers/usb/core/driver.c:266
  really_probe+0x1344/0x1d90 /drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 /drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 /drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 /drivers/base/bus.c:454
  __device_attach+0x489/0x750 /drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 /drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 /drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 /drivers/base/core.c:2111
  usb_new_device+0x23e5/0x2fb0 /drivers/usb/core/hub.c:2534
  hub_port_connect /drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change /drivers/usb/core/hub.c:5204 [inline]
  port_event /drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x5853/0x7320 /drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 /kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 /kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 /kernel/kthread.c:256
  ret_from_fork+0x35/0x40 /arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags /mm/kmsan/kmsan.c:187 [inline]
  kmsan_internal_poison_shadow+0x53/0xa0 /mm/kmsan/kmsan.c:146
  kmsan_slab_alloc+0xaa/0x120 /mm/kmsan/kmsan_hooks.c:175
  slab_alloc_node /mm/slub.c:2771 [inline]
  slab_alloc /mm/slub.c:2780 [inline]
  kmem_cache_alloc_trace+0x873/0xa50 /mm/slub.c:2797
  kmalloc /./include/linux/slab.h:547 [inline]
  pcan_usb_pro_drv_loaded /drivers/net/can/usb/peak_usb/pcan_usb_pro.c:497  
[inline]
  pcan_usb_pro_init+0xe96/0x1720  
/drivers/net/can/usb/peak_usb/pcan_usb_pro.c:894
  peak_usb_create_dev /drivers/net/can/usb/peak_usb/pcan_usb_core.c:809  
[inline]
  peak_usb_probe+0x1416/0x1b20  
/drivers/net/can/usb/peak_usb/pcan_usb_core.c:907
  usb_probe_interface+0xd19/0x1310 /drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 /drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 /drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 /drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 /drivers/base/bus.c:454
  __device_attach+0x489/0x750 /drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 /drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 /drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 /drivers/base/core.c:2111
  usb_set_configuration+0x309f/0x3710 /drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 /drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 /drivers/usb/core/driver.c:266
  really_probe+0x1344/0x1d90 /drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 /drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 /drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 /drivers/base/bus.c:454
  __device_attach+0x489/0x750 /drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 /drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 /drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 /drivers/base/core.c:2111
  usb_new_device+0x23e5/0x2fb0 /drivers/usb/core/hub.c:2534
  hub_port_connect /drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change /drivers/usb/core/hub.c:5204 [inline]
  port_event /drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x5853/0x7320 /drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 /kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 /kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 /kernel/kthread.c:256
  ret_from_fork+0x35/0x40 /arch/x86/entry/entry_64.S:355

Bytes 2-15 of 16 are uninitialized
Memory access of size 16 starts at ffff8881030286e0
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
