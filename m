Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C0C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E884217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfK2VFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:05:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:50251 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:05:10 -0500
Received: by mail-il1-f199.google.com with SMTP id l63so25624779ili.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MOavzUREPQ8i/q84h2ZPB6MhiH5OTrZWV4yOEWUafz8=;
        b=P9NAUfh4JnqkcXZ5xnpJeU7V5F7S81ka8nLNY3/aXaoDOTJqQx+hUy+pa+D/l1L116
         2s5vf0oFMWf6FC39PhoYIEbg29LdQYfaPqIwJp3phLHnygQzUuJNpCvEJlVk8Yn/w1Vm
         7RtlPhyV91II/s3P3eanqy6ObNiljQgL8jkXlQC2bwJI/v5M/9M+lYDmuiq4hldS5uby
         SciWhfOFkFYqsAIWyv7Wn/f9viW8RSGy+qxv3EGA/FRpyLSuQMJOAYevXenw+lXmmI9y
         wQpadKAgV+4v6SX4fjvFWtxv81zg8z2HKHDzEXZG04iv2YIJkxbaO8/6niRZW9zCIbRQ
         IyhA==
X-Gm-Message-State: APjAAAXfl+YKV9CuG3KCrVT2G5WedCSi7+E/dQVAw3dA3e4eaWXChYZP
        2zTC4d7Iue7OW/BN9mCRzMzLRfDrguiSn4DVwSpV2xYYpIHv
X-Google-Smtp-Source: APXvYqxDioRseda04LZuKuLqGzexp22qflDTHv5gavNLGv+jJ3l2gJFBiSo/iUlMH8VsU9mxo2MW7TN7q89fwYa9bm3Df3h16Ocn
MIME-Version: 1.0
X-Received: by 2002:a02:a15d:: with SMTP id m29mr2667010jah.88.1575061508388;
 Fri, 29 Nov 2019 13:05:08 -0800 (PST)
Date:   Fri, 29 Nov 2019 13:05:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b50c8b05988295f0@google.com>
Subject: possible deadlock in i2c_transfer
From:   syzbot <syzbot+136e62496b7564bb81cf@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wsa@the-dreams.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    32b5e2b2 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=117c767ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d88612251f7691bd
dashboard link: https://syzkaller.appspot.com/bug?extid=136e62496b7564bb81cf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d808a6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1652d82ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+136e62496b7564bb81cf@syzkaller.appspotmail.com

usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
============================================
WARNING: possible recursive locking detected
5.4.0-syzkaller #0 Not tainted
--------------------------------------------
kworker/1:1/78 is trying to acquire lock:
ffff8881c5c58208 (i2c_register_adapter){+.+.}, at: i2c_lock_bus  
include/linux/i2c.h:755 [inline]
ffff8881c5c58208 (i2c_register_adapter){+.+.}, at: __i2c_lock_bus_helper  
drivers/i2c/i2c-core.h:44 [inline]
ffff8881c5c58208 (i2c_register_adapter){+.+.}, at: i2c_transfer+0x1d3/0x3b0  
drivers/i2c/i2c-core-base.c:2041

but task is already holding lock:
ffff8881d51925c0 (i2c_register_adapter){+.+.}, at: i2c_lock_bus  
include/linux/i2c.h:755 [inline]
ffff8881d51925c0 (i2c_register_adapter){+.+.}, at: __i2c_lock_bus_helper  
drivers/i2c/i2c-core.h:44 [inline]
ffff8881d51925c0 (i2c_register_adapter){+.+.}, at: i2c_transfer+0x1d3/0x3b0  
drivers/i2c/i2c-core-base.c:2041

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(i2c_register_adapter);
   lock(i2c_register_adapter);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

7 locks held by kworker/1:1/78:
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:615 [inline]
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
  #0: ffff8881d8836528 ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2235
  #1: ffff8881d8ec7dd0 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2239
  #2: ffff8881d51c7200 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1493 [inline]
  #2: ffff8881d51c7200 (&dev->mutex){....}, at: hub_event+0x1b2/0x3860  
drivers/usb/core/hub.c:5498
  #3: ffff8881cf9eb200 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1493 [inline]
  #3: ffff8881cf9eb200 (&dev->mutex){....}, at: __device_attach+0x7b/0x360  
drivers/base/dd.c:871
  #4: ffff8881cf9ec190 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1493 [inline]
  #4: ffff8881cf9ec190 (&dev->mutex){....}, at: __device_attach+0x7b/0x360  
drivers/base/dd.c:871
  #5: ffff8881d5123180 (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1493 [inline]
  #5: ffff8881d5123180 (&dev->mutex){....}, at: __device_attach+0x7b/0x360  
drivers/base/dd.c:871
  #6: ffff8881d51925c0 (i2c_register_adapter){+.+.}, at: i2c_lock_bus  
include/linux/i2c.h:755 [inline]
  #6: ffff8881d51925c0 (i2c_register_adapter){+.+.}, at:  
__i2c_lock_bus_helper drivers/i2c/i2c-core.h:44 [inline]
  #6: ffff8881d51925c0 (i2c_register_adapter){+.+.}, at:  
i2c_transfer+0x1d3/0x3b0 drivers/i2c/i2c-core-base.c:2041

stack backtrace:
CPU: 1 PID: 78 Comm: kworker/1:1 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  print_deadlock_bug kernel/locking/lockdep.c:2371 [inline]
  check_deadlock kernel/locking/lockdep.c:2412 [inline]
  validate_chain kernel/locking/lockdep.c:2955 [inline]
  __lock_acquire.cold+0x114/0x288 kernel/locking/lockdep.c:3955
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4485
  __rt_mutex_lock kernel/locking/rtmutex.c:1471 [inline]
  rt_mutex_lock_nested+0x3e/0x60 kernel/locking/rtmutex.c:1484
  i2c_lock_bus include/linux/i2c.h:755 [inline]
  __i2c_lock_bus_helper drivers/i2c/i2c-core.h:44 [inline]
  i2c_transfer+0x1d3/0x3b0 drivers/i2c/i2c-core-base.c:2041
  tc90522_master_xfer.part.0+0x65c/0xbf0  
drivers/media/dvb-frontends/tc90522.c:708
  tc90522_master_xfer+0x35/0x4e drivers/media/dvb-frontends/tc90522.c:643
  __i2c_transfer drivers/i2c/i2c-core-base.c:1984 [inline]
  __i2c_transfer+0x49d/0x1620 drivers/i2c/i2c-core-base.c:1949
  i2c_transfer drivers/i2c/i2c-core-base.c:2045 [inline]
  i2c_transfer+0x1e6/0x3b0 drivers/i2c/i2c-core-base.c:2016
  dvb_pll_attach+0x228/0x850 drivers/media/dvb-frontends/dvb-pll.c:816
  dvb_pll_probe+0xfe/0x174 drivers/media/dvb-frontends/dvb-pll.c:884
  i2c_device_probe+0x74e/0xa40 drivers/i2c/i2c-core-base.c:389
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  i2c_new_client_device+0x57f/0x9b0 drivers/i2c/i2c-core-base.c:777
  i2c_new_device+0x19/0x50 drivers/i2c/i2c-core-base.c:820
  dvb_module_probe+0xf9/0x220 drivers/media/dvb-core/dvbdev.c:986
  friio_tuner_attach+0x12b/0x1d0 drivers/media/usb/dvb-usb-v2/gl861.c:457
  dvb_usbv2_adapter_frontend_init  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:676 [inline]
  dvb_usbv2_adapter_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:805  
[inline]
  dvb_usbv2_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:866 [inline]
  dvb_usbv2_probe.cold+0x2550/0x25d7  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:981
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  usb_set_configuration+0xe67/0x1740 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1480/0x1c20 drivers/base/core.c:2487
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x1e59/0x3860 drivers/usb/core/hub.c:5552
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2264
  worker_thread+0x96/0xe20 kernel/workqueue.c:2410
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 2
usb 1-1: new high-speed USB device number 3 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 3
usb 1-1: new high-speed USB device number 4 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 4
usb 1-1: new high-speed USB device number 5 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 5
usb 1-1: new high-speed USB device number 6 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 6
usb 1-1: new high-speed USB device number 7 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 7
usb 1-1: new high-speed USB device number 8 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 8
usb 1-1: new high-speed USB device number 9 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 9
usb 1-1: new high-speed USB device number 10 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
dvb_pll: probe of 1-0060 failed with error -12
usb 1-1: USB disconnect, device number 10


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
