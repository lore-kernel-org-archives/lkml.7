Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C805CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9521773
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfHAP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:28:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44174 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfHAP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:28:09 -0400
Received: by mail-io1-f70.google.com with SMTP id s9so79585721iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9OrhS1Md+Rq3EX4l7WvmGe2LPfPlaYOCG4y1gNpyFsE=;
        b=ooXJYyvf1SHyertX0SchhLnNrslTDSV6R3X9HU6eEtfE37APKl73tLaowy4MDXQCN1
         xuyrRb1+f4QXvFcC3kJvWkDfMWkxzsNopC0rHnyK3s4ao7C+YPAJSWMAKHsDB5HDSuOA
         DMAesZSHsy6nukcxAdt8Uy6oyL30nvvTNqy9xeD24fS/567p0Vsmpx5AmDMM2L9jrxrP
         ki3uZsElgkeUkdsIoHNwMBy2EghopfxID0oVY0smSmJKcwHF3VaNOpgPB7nxg6ZxqkvK
         hjneGgHUoaIzYjFI/NB2tTdhpda9Y8/ohs51CXubBADIG9ewNW3GBYZ9X24FxqFBOCgZ
         YNuw==
X-Gm-Message-State: APjAAAXUQ9+cSt+j53T1uu5Wp+NxPHl8CtfwgOzuKJIRrub3CrQY2oEx
        25oSq1diRiGtToMAfqQLjIdQWDLIzD1VNrLlb1u6zPTXGocG
X-Google-Smtp-Source: APXvYqz5ueeQC/nNSWcHxnEpiw5OKXizQ69CiJaIkmmb7xQGSfCUqd3Y5/vdkpuevtrmaG+egopyy2ut1xMS8kBfohtJA2FgsF/K
MIME-Version: 1.0
X-Received: by 2002:a02:a581:: with SMTP id b1mr10126571jam.84.1564673288556;
 Thu, 01 Aug 2019 08:28:08 -0700 (PDT)
Date:   Thu, 01 Aug 2019 08:28:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dd940058f0fe36a@google.com>
Subject: KMSAN: kernel-usb-infoleak in usbnet_write_cmd
From:   syzbot <syzbot+b33fff3d3de984c82064@syzkaller.appspotmail.com>
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

HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=13a0b07da00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=b33fff3d3de984c82064
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b33fff3d3de984c82064@syzkaller.appspotmail.com

ax88179_178a 3-1:0.239 (unnamed net_device) (uninitialized): Failed to  
write reg index 0x001f: -71
ax88179_178a 3-1:0.239 (unnamed net_device) (uninitialized): Failed to  
write reg index 0x001e: -71
ax88179_178a 3-1:0.239 (unnamed net_device) (uninitialized): Failed to read  
reg index 0x001a: -71
ax88179_178a 3-1:0.239 (unnamed net_device) (uninitialized): Failed to read  
reg index 0x001c: -71
==================================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50  
drivers/usb/core/urb.c:405
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc4+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan.c:611
  kmsan_internal_check_memory+0x974/0xa80 mm/kmsan/kmsan.c:705
  kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:617
  usb_submit_urb+0x7ef/0x1f50 drivers/usb/core/urb.c:405
  usb_start_wait_urb+0x143/0x410 drivers/usb/core/message.c:58
  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
  usb_control_msg+0x49f/0x7f0 drivers/usb/core/message.c:156
  __usbnet_write_cmd drivers/net/usb/usbnet.c:2020 [inline]
  usbnet_write_cmd+0x386/0x430 drivers/net/usb/usbnet.c:2058
  __ax88179_write_cmd drivers/net/usb/ax88179_178a.c:223 [inline]
  ax88179_write_cmd drivers/net/usb/ax88179_178a.c:323 [inline]
  ax88179_led_setting+0x1c76/0x2be0 drivers/net/usb/ax88179_178a.c:1184
  ax88179_bind+0xe01/0x1a10 drivers/net/usb/ax88179_178a.c:1305
  usbnet_probe+0x10d3/0x3950 drivers/net/usb/usbnet.c:1722
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x5853/0x7320 drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:201 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:213 [inline]
  kmsan_internal_chain_origin+0xcc/0x150 mm/kmsan/kmsan.c:414
  kmsan_memcpy_memmove_metadata+0x9f9/0xe00 mm/kmsan/kmsan.c:297
  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:317
  __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:139
  kmemdup+0x107/0x140 mm/util.c:121
  __usbnet_write_cmd drivers/net/usb/usbnet.c:2009 [inline]
  usbnet_write_cmd+0x168/0x430 drivers/net/usb/usbnet.c:2058
  __ax88179_write_cmd drivers/net/usb/ax88179_178a.c:223 [inline]
  ax88179_write_cmd drivers/net/usb/ax88179_178a.c:323 [inline]
  ax88179_led_setting+0x1c76/0x2be0 drivers/net/usb/ax88179_178a.c:1184
  ax88179_bind+0xe01/0x1a10 drivers/net/usb/ax88179_178a.c:1305
  usbnet_probe+0x10d3/0x3950 drivers/net/usb/usbnet.c:1722
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x5853/0x7320 drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:201 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:213 [inline]
  kmsan_internal_chain_origin+0xcc/0x150 mm/kmsan/kmsan.c:414
  __msan_chain_origin+0x6b/0xe0 mm/kmsan/kmsan_instr.c:200
  ax88179_write_cmd drivers/net/usb/ax88179_178a.c:321 [inline]
  ax88179_led_setting+0x20d3/0x2be0 drivers/net/usb/ax88179_178a.c:1184
  ax88179_bind+0xe01/0x1a10 drivers/net/usb/ax88179_178a.c:1305
  usbnet_probe+0x10d3/0x3950 drivers/net/usb/usbnet.c:1722
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x5853/0x7320 drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----buf.i129@ax88179_led_setting
Variable was created at:
  __ax88179_read_cmd drivers/net/usb/ax88179_178a.c:226 [inline]
  ax88179_read_cmd drivers/net/usb/ax88179_178a.c:299 [inline]
  ax88179_led_setting+0x18ef/0x2be0 drivers/net/usb/ax88179_178a.c:1138
  ax88179_bind+0xe01/0x1a10 drivers/net/usb/ax88179_178a.c:1305

Bytes 0-1 of 2 are uninitialized
Memory access of size 2 starts at ffff888039cbbad0
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
