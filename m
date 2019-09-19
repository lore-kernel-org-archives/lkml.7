Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BACC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A821928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfISSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:19:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46659 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbfISSTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:19:08 -0400
Received: by mail-io1-f72.google.com with SMTP id t11so6422765ioc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pSollyOTnab/V+qjxEqSKEmnzN3t6PT9Ky8AmzucgQM=;
        b=YgTW0sLXGWI+gXgTRzatlU8VDO6z69+/fCBNEscXJfyEW0Cv16nU4g6UsZZr/8wLKm
         NtRbG5EKJL/S7urfYbI8621x6IL70/Ta/ohpgXBCht5JRNBQmm2YakDIU6HnKArcY61m
         vUX+d/riEFFxg16CZfybo/BTv/ph1pEsWF6Ra6M0ZmyNS4F1BE9rxCQeuey4ZTRv5MGH
         aAa59JU7TrpI9XQaaaXiNHFPnoQxHKrNt5BwPB8sNmJWCqpd7Wo11xaC6Rbk3/murcDX
         niOx4kMMlv3lRxg5kj81aRNobo2luWLyHeRDBPrJVtHRzfePW2LXMmXlTf6cwXRDzQQ9
         6Vcg==
X-Gm-Message-State: APjAAAVwdXCjpmme47fiXSjClEpEHl5697fCODPvQo9i73cLisQ61NRU
        w2fbVyuN/rQdqbWtqIPYGB9TBknZ5+8O0S0635eyaY39GUOM
X-Google-Smtp-Source: APXvYqyKbsB+8VYSbgnUDO+rw6YWJTm43aKonQSiOYXT2/AnnyzCju2amGeJdsPMMJp1gI1ow/WFCTwWeoilq6eyeIf3yLHG7PdP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:681:: with SMTP id i1mr13911967jab.127.1568917147245;
 Thu, 19 Sep 2019 11:19:07 -0700 (PDT)
Date:   Thu, 19 Sep 2019 11:19:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e64aa0592ebfde1@google.com>
Subject: KMSAN: kernel-usb-infoleak in hid_submit_ctrl
From:   syzbot <syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com>
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

HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=123e42a5600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=7c2bb71996f95a82524c
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b0411a600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d1ee01600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com

microsoft 0003:045E:07DA.0002: unknown main item tag 0x0
microsoft 0003:045E:07DA.0002: unknown main item tag 0x0
==================================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50  
drivers/usb/core/urb.c:405
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  kmsan_internal_check_memory+0x7be/0x8d0 mm/kmsan/kmsan.c:553
  kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:621
  usb_submit_urb+0x7ef/0x1f50 drivers/usb/core/urb.c:405
  hid_submit_ctrl+0xb5f/0x1160 drivers/hid/usbhid/hid-core.c:416
  usbhid_restart_ctrl_queue+0x355/0x510 drivers/hid/usbhid/hid-core.c:258
  __usbhid_submit_report drivers/hid/usbhid/hid-core.c:601 [inline]
  usbhid_submit_report+0x924/0x1200 drivers/hid/usbhid/hid-core.c:638
  usbhid_request+0xc6/0xe0 drivers/hid/usbhid/hid-core.c:1253
  hid_hw_request include/linux/hid.h:1053 [inline]
  __hidinput_change_resolution_multipliers+0x132/0x6a0  
drivers/hid/hid-input.c:1566
  hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1604  
[inline]
  hidinput_connect+0x2b9a/0x4220 drivers/hid/hid-input.c:1914
  hid_connect+0x582/0x15c0 drivers/hid/hid-core.c:1877
  hid_hw_start+0x141/0x230 drivers/hid/hid-core.c:1981
  ms_probe+0x39b/0x8f0 drivers/hid/hid-microsoft.c:388
  hid_device_probe+0x490/0x820 drivers/hid/hid-core.c:2209
  really_probe+0xd08/0x1dc0 drivers/base/dd.c:548
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2165
  hid_add_device+0x132b/0x1470 drivers/hid/hid-core.c:2365
  usbhid_probe+0x152b/0x1880 drivers/hid/usbhid/hid-core.c:1386
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2165
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2165
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x189c/0x2460 kernel/workqueue.c:2417
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
  kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
  kmsan_slab_alloc+0xaa/0x120 mm/kmsan/kmsan_hooks.c:175
  slab_alloc_node mm/slub.c:2790 [inline]
  slab_alloc mm/slub.c:2799 [inline]
  __kmalloc+0x28e/0x430 mm/slub.c:3830
  kmalloc include/linux/slab.h:557 [inline]
  hcd_buffer_alloc+0x391/0x510 drivers/usb/core/buffer.c:132
  usb_alloc_coherent+0x11a/0x190 drivers/usb/core/usb.c:910
  hid_alloc_buffers drivers/hid/usbhid/hid-core.c:851 [inline]
  usbhid_start+0xf60/0x3970 drivers/hid/usbhid/hid-core.c:1075
  hid_hw_start+0x9a/0x230 drivers/hid/hid-core.c:1976
  ms_probe+0x39b/0x8f0 drivers/hid/hid-microsoft.c:388
  hid_device_probe+0x490/0x820 drivers/hid/hid-core.c:2209
  really_probe+0xd08/0x1dc0 drivers/base/dd.c:548
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2165
  hid_add_device+0x132b/0x1470 drivers/hid/hid-core.c:2365
  usbhid_probe+0x152b/0x1880 drivers/hid/usbhid/hid-core.c:1386
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2165
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2165
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x189c/0x2460 kernel/workqueue.c:2417
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Bytes 0-4095 of 4096 are uninitialized
Memory access of size 4096 starts at ffff888108f43000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
