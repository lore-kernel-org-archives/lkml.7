Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB9FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D46218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395041AbfJQBmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:42:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44245 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391867AbfJQBmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:11 -0400
Received: by mail-io1-f70.google.com with SMTP id y2so951596ioj.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jiTyUQmHmfXgOJr09FD51IRkXks2IeagzT2fb+X1QIk=;
        b=EKnqEvVx+5VWlwoZZUXSAFdL7+iZlA58dtkdzrN/H11GW4Je/9yWMVoYQHdKWwBHC/
         ilVl+ad4peIXFUA9QzzcMlZ0CLO1SS1eR/Uf5x3wTLP3A+hJefzk7Gbn21MIRQE9hTes
         mn+UyFkOigM1TIILoueKCuXm2xRx3Ke425D63pE7jqyaV6rLhbAF+DJrNdG66XanKS1R
         jm7cDMGZ75JW+v6StrRxSScf4sazmYgCudf1oODIRXQX+9XMxcs9sOOJxA4bImXo8giv
         CFkn/gvEpEO1tcU7gXkKy7TDP7XnEC5hLrZSsa3d8HeXFJZ5/l72cDMM/zrl63R4u0y1
         aYnA==
X-Gm-Message-State: APjAAAXnDeHjm7NVl1wR3P7toRfUdPyYjkdpyxYVimHdS4DmwQAUWWpz
        PetaJ1hN7Lvq2MAOUMEQ5cq/gxoYpKGLtlm2JbV+/CLCpTxO
X-Google-Smtp-Source: APXvYqwsHmPMzRhEnyf0WaydnP38vmtAvfQzabXemisnJK22p8N2/OjCrMW03Q17k6X/ZhB0r6QOsAo87iZVea+kasU3KqSQZ0jk
MIME-Version: 1.0
X-Received: by 2002:a92:5f4c:: with SMTP id t73mr995711ilb.220.1571276531062;
 Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:42:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a638805951153c5@google.com>
Subject: KMSAN: kernel-usb-infoleak in pcan_usb_wait_rsp
From:   syzbot <syzbot+863724e7128e14b26732@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c2453450 kmsan: kcov: prettify the code unpoisoning area->..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11934730e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3684f3c73f43899a
dashboard link: https://syzkaller.appspot.com/bug?extid=863724e7128e14b26732
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12431287600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1743306b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+863724e7128e14b26732@syzkaller.appspotmail.com

usb 1-1: config 0 interface 210 altsetting 0 endpoint 0x1 has an invalid  
bInterval 0, changing to 7
usb 1-1: New USB device found, idVendor=0c72, idProduct=000c,  
bcdDevice=7c.aa
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
hub 1-1:0.210: ignoring external hub
=====================================================
BUG: KMSAN: kernel-usb-infoleak in kmsan_handle_urb+0x28/0x40  
mm/kmsan/kmsan_hooks.c:381
CPU: 0 PID: 2900 Comm: kworker/0:2 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x14a/0x2f0 mm/kmsan/kmsan_report.c:109
  kmsan_internal_check_memory+0x3bb/0x4e0 mm/kmsan/kmsan.c:469
  kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:381
  usb_submit_urb+0x7ef/0x1f50 drivers/usb/core/urb.c:405
  usb_start_wait_urb+0x143/0x410 drivers/usb/core/message.c:58
  usb_bulk_msg+0x811/0x920 drivers/usb/core/message.c:257
  pcan_usb_send_cmd drivers/net/can/usb/peak_usb/pcan_usb.c:127 [inline]
  pcan_usb_wait_rsp+0x25c/0x6e0 drivers/net/can/usb/peak_usb/pcan_usb.c:151
  pcan_usb_get_serial drivers/net/can/usb/peak_usb/pcan_usb.c:310 [inline]
  pcan_usb_init+0xcc/0x450 drivers/net/can/usb/peak_usb/pcan_usb.c:801
  peak_usb_create_dev drivers/net/can/usb/peak_usb/pcan_usb_core.c:809  
[inline]
  peak_usb_probe+0x1416/0x1b20  
drivers/net/can/usb/peak_usb/pcan_usb_core.c:907
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:150 [inline]
  kmsan_internal_poison_shadow+0x60/0x110 mm/kmsan/kmsan.c:133
  kmsan_slab_alloc+0xaa/0x130 mm/kmsan/kmsan_hooks.c:101
  slab_alloc_node mm/slub.c:2792 [inline]
  slab_alloc mm/slub.c:2801 [inline]
  kmem_cache_alloc_trace+0x8c5/0xd20 mm/slub.c:2818
  kmalloc include/linux/slab.h:556 [inline]
  peak_usb_create_dev drivers/net/can/usb/peak_usb/pcan_usb_core.c:753  
[inline]
  peak_usb_probe+0x544/0x1b20  
drivers/net/can/usb/peak_usb/pcan_usb_core.c:907
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Bytes 2-15 of 16 are uninitialized
Memory access of size 16 starts at ffff88810fa82fa0
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
