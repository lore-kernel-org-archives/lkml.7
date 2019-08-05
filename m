Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A255C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8420880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfHEL6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:58:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47086 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfHEL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:58:07 -0400
Received: by mail-io1-f71.google.com with SMTP id s83so91939118iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oZaIinrUoyyCGIdo2KP19yTMYXmf+0RMjStN+yDNODo=;
        b=fsoGIBOHMLUDVpY8lybiFVGNQUotR9FtX/p2nbhywPZ7k8Ormt0kp3XLGrG5bMgR3S
         BIr3Q9W6S6lDVVLjFGSYFFxAjG76wCyx4xdVhEm/Us234GdqmEmOisDU1E6BWvAnz/Xy
         9hm99BJwzL+PxWi3hkOHXriV6ul3Mvpnsd8APHFSA2EMQ4OG63veqnL0LK32Z8xIMfP9
         mPr7Z5KNuFzQxTZZRGzNEYUL4yuTHfm+b3itXqamd0ZY1qd4eBqrBnWEXwfVdPR1BHzv
         TmyYgGpgx1A6p1D08nZFr88MaA8CFkiC38gPOrzWxzQN98bzOfwdXysNvQjrCV8ZvAN+
         Rwfg==
X-Gm-Message-State: APjAAAUXTAcSyQ2vpjXadVNhHybK+uM4cKXNV9TjNOvAJjQJ75MsE9Ks
        DKvtk1yyGbPaVYN+wdGJ3YDPAyO+TYXl99xsDC04VG9TUHP+
X-Google-Smtp-Source: APXvYqz1BTedFuXY9X6RDQIpGAUet8+GPfh2Qr6GbumzcUHO/o4mPbfOsJei92F+h8MXGKP5gFQ/dj41O13fn+OeIsMCL/rZxYS7
MIME-Version: 1.0
X-Received: by 2002:a02:1607:: with SMTP id a7mr149615132jaa.123.1565006286869;
 Mon, 05 Aug 2019 04:58:06 -0700 (PDT)
Date:   Mon, 05 Aug 2019 04:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cce142058f5d6be6@google.com>
Subject: possible deadlock in usb_deregister_dev
From:   syzbot <syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13b5bc8a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
dashboard link: https://syzkaller.appspot.com/bug?extid=a64a382964bf6c71a9c0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com

usb 4-1: USB disconnect, device number 85
======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc2+ #24 Not tainted
------------------------------------------------------
kworker/0:2/105 is trying to acquire lock:
000000003db0b025 (minor_rwsem){++++}, at: usb_deregister_dev  
drivers/usb/core/file.c:238 [inline]
000000003db0b025 (minor_rwsem){++++}, at: usb_deregister_dev+0x61/0x270  
drivers/usb/core/file.c:230

but task is already holding lock:
000000000afbf30c (iowarrior_open_disc_lock){+.+.}, at:  
iowarrior_disconnect+0x45/0x2c0 drivers/usb/misc/iowarrior.c:867

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (iowarrior_open_disc_lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:930 [inline]
        __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
        iowarrior_open+0x8a/0x2a0 drivers/usb/misc/iowarrior.c:600
        usb_open+0x1df/0x270 drivers/usb/core/file.c:48
        chrdev_open+0x219/0x5c0 fs/char_dev.c:414
        do_dentry_open+0x494/0x1120 fs/open.c:797
        do_last fs/namei.c:3416 [inline]
        path_openat+0x1430/0x3f50 fs/namei.c:3533
        do_filp_open+0x1a1/0x280 fs/namei.c:3563
        do_sys_open+0x3c0/0x580 fs/open.c:1089
        do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (iowarrior_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:930 [inline]
        __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
        iowarrior_open+0x23/0x2a0 drivers/usb/misc/iowarrior.c:589
        usb_open+0x1df/0x270 drivers/usb/core/file.c:48
        chrdev_open+0x219/0x5c0 fs/char_dev.c:414
        do_dentry_open+0x494/0x1120 fs/open.c:797
        do_last fs/namei.c:3416 [inline]
        path_openat+0x1430/0x3f50 fs/namei.c:3533
        do_filp_open+0x1a1/0x280 fs/namei.c:3563
        do_sys_open+0x3c0/0x580 fs/open.c:1089
        do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (minor_rwsem){++++}:
        check_prev_add kernel/locking/lockdep.c:2405 [inline]
        check_prevs_add kernel/locking/lockdep.c:2507 [inline]
        validate_chain kernel/locking/lockdep.c:2897 [inline]
        __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
        lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
        down_write+0x92/0x150 kernel/locking/rwsem.c:1500
        usb_deregister_dev drivers/usb/core/file.c:238 [inline]
        usb_deregister_dev+0x61/0x270 drivers/usb/core/file.c:230
        iowarrior_disconnect+0xa8/0x2c0 drivers/usb/misc/iowarrior.c:873
        usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
        __device_release_driver drivers/base/dd.c:1120 [inline]
        device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1151
        bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
        device_del+0x420/0xb10 drivers/base/core.c:2288
        usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
        usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
        hub_port_connect drivers/usb/core/hub.c:4949 [inline]
        hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
        port_event drivers/usb/core/hub.c:5359 [inline]
        hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
        process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
        worker_thread+0x96/0xe20 kernel/workqueue.c:2415
        kthread+0x318/0x420 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

other info that might help us debug this:

Chain exists of:
   minor_rwsem --> iowarrior_mutex --> iowarrior_open_disc_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(iowarrior_open_disc_lock);
                                lock(iowarrior_mutex);
                                lock(iowarrior_open_disc_lock);
   lock(minor_rwsem);

  *** DEADLOCK ***

6 locks held by kworker/0:2/105:
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: 00000000aba84ede ((wq_completion)usb_hub_wq){+.+.}, at:  
process_one_work+0x827/0x1530 kernel/workqueue.c:2240
  #1: 0000000058d65fe1 ((work_completion)(&hub->events)){+.+.}, at:  
process_one_work+0x85b/0x1530 kernel/workqueue.c:2244
  #2: 000000006a2f7a8f (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1220 [inline]
  #2: 000000006a2f7a8f (&dev->mutex){....}, at: hub_event+0x17c/0x3640  
drivers/usb/core/hub.c:5387
  #3: 00000000eddd5fcd (&dev->mutex){....}, at: device_lock  
include/linux/device.h:1220 [inline]
  #3: 00000000eddd5fcd (&dev->mutex){....}, at: usb_disconnect+0x91/0x8d0  
drivers/usb/core/hub.c:2190
  #4: 000000009478eeb7 (&dev->mutex){....}, at:  
device_release_driver_internal+0x23/0x4c0 drivers/base/dd.c:1148
  #5: 000000000afbf30c (iowarrior_open_disc_lock){+.+.}, at:  
iowarrior_disconnect+0x45/0x2c0 drivers/usb/misc/iowarrior.c:867

stack backtrace:
CPU: 0 PID: 105 Comm: kworker/0:2 Not tainted 5.3.0-rc2+ #24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  check_noncircular+0x345/0x3e0 kernel/locking/lockdep.c:1741
  check_prev_add kernel/locking/lockdep.c:2405 [inline]
  check_prevs_add kernel/locking/lockdep.c:2507 [inline]
  validate_chain kernel/locking/lockdep.c:2897 [inline]
  __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  down_write+0x92/0x150 kernel/locking/rwsem.c:1500
  usb_deregister_dev drivers/usb/core/file.c:238 [inline]
  usb_deregister_dev+0x61/0x270 drivers/usb/core/file.c:230
  iowarrior_disconnect+0xa8/0x2c0 drivers/usb/misc/iowarrior.c:873
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1120 [inline]
  device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1151
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x420/0xb10 drivers/base/core.c:2288
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
iowarrior 4-1:0.236: I/O-Warror #0 now disconnected
usb 4-1: new high-speed USB device number 86 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 8
usb 4-1: config 0 has an invalid interface number: 171 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: New USB device found, idVendor=14f7, idProduct=0500,  
bcdDevice=ac.d6
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??
technisat-usb2: could not set alternate setting to 0
technisat-usb2: firmware version: 251.126
dvb-usb: found a 'Technisat SkyStar USB HD (DVB-S/S2)' in warm state.
dvb-usb: will pass the complete MPEG2 transport stream to the software  
demuxer.
dvbdev: DVB: registering new adapter (Technisat SkyStar USB HD (DVB-S/S2))
usb 4-1: media controller created
technisat-usb2: i2c-error: out failed 53 = -22
dvb-usb: MAC address reading failed.
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
technisat-usb2: i2c-error: out failed 68 = -22
dvb-usb: no frontend was attached by 'Technisat SkyStar USB HD (DVB-S/S2)'
Registered IR keymap rc-technisat-usb2
rc_core: Loaded IR protocol module ir-rc5-decoder, but protocol rc-5 still  
not available
rc rc0: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0
input: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0/input262
dvb-usb: schedule remote query interval to 100 msecs.
dvb-usb: Technisat SkyStar USB HD (DVB-S/S2) successfully initialized and  
connected.
usb 4-1: USB disconnect, device number 86
dvb-usb: Technisat SkyStar USB HD (DVB-S/S2) successfully deinitialized and  
disconnected.
usb 5-1: USB disconnect, device number 48
usb 2-1: USB disconnect, device number 98
metro-usb ttyUSB0: Metrologic USB to Serial converter now disconnected from  
ttyUSB0
metro_usb 2-1:0.123: device disconnected
usb 2-1: new low-speed USB device number 99 using dummy_hcd
usb 2-1: config index 0 descriptor too short (expected 63259, got 46)
usb 2-1: config 0 has an invalid interface number: 123 but max is 0
usb 2-1: config 0 has an invalid descriptor of length 0, skipping remainder  
of the config
usb 2-1: config 0 has no interface number 0
usb 2-1: config 0 interface 123 altsetting 0 endpoint 0x81 is Bulk;  
changing to Interrupt
usb 2-1: New USB device found, idVendor=0c2e, idProduct=0720,  
bcdDevice=43.fe
usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: config 0 descriptor??
metro_usb 2-1:0.123: Metrologic USB to Serial converter detected
usb 2-1: Metrologic USB to Serial converter now attached to ttyUSB0
usb 4-1: new high-speed USB device number 89 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 8
usb 4-1: config 0 has an invalid interface number: 171 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: New USB device found, idVendor=14f7, idProduct=0500,  
bcdDevice=ac.d6
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??
technisat-usb2: could not set alternate setting to 0
technisat-usb2: firmware version: 25.147
dvb-usb: found a 'Technisat SkyStar USB HD (DVB-S/S2)' in warm state.
dvb-usb: will pass the complete MPEG2 transport stream to the software  
demuxer.
dvbdev: DVB: registering new adapter (Technisat SkyStar USB HD (DVB-S/S2))
usb 4-1: media controller created
technisat-usb2: i2c-error: out failed 53 = -22
dvb-usb: MAC address reading failed.
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
technisat-usb2: i2c-error: out failed 68 = -22
dvb-usb: no frontend was attached by 'Technisat SkyStar USB HD (DVB-S/S2)'
Registered IR keymap rc-technisat-usb2
rc_core: Loaded IR protocol module ir-rc5-decoder, but protocol rc-5 still  
not available
rc rc0: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0
input: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0/input265
dvb-usb: schedule remote query interval to 100 msecs.
dvb-usb: Technisat SkyStar USB HD (DVB-S/S2) successfully initialized and  
connected.
usb 4-1: USB disconnect, device number 89
dvb-usb: Technisat SkyStar USB HD (DVB-S/S2) successfully deinitialized and  
disconnected.
usb 4-1: new high-speed USB device number 90 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 8
usb 4-1: config 0 has an invalid interface number: 171 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: New USB device found, idVendor=14f7, idProduct=0500,  
bcdDevice=ac.d6
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??
technisat-usb2: could not set alternate setting to 0
technisat-usb2: firmware version: 39.225
dvb-usb: found a 'Technisat SkyStar USB HD (DVB-S/S2)' in warm state.
dvb-usb: will pass the complete MPEG2 transport stream to the software  
demuxer.
dvbdev: DVB: registering new adapter (Technisat SkyStar USB HD (DVB-S/S2))
usb 4-1: media controller created
technisat-usb2: i2c-error: out failed 53 = -22
dvb-usb: MAC address reading failed.
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
technisat-usb2: i2c-error: out failed 68 = -22
dvb-usb: no frontend was attached by 'Technisat SkyStar USB HD (DVB-S/S2)'
Registered IR keymap rc-technisat-usb2
rc_core: Loaded IR protocol module ir-rc5-decoder, but protocol rc-5 still  
not available
rc rc0: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0
input: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.3/usb4/4-1/rc/rc0/input266
dvb-usb: schedule remote query interval to 100 msecs.
dvb-usb: Technisat SkyStar USB HD (DVB-S/S2) successfully initialized and  
connected.
usb 4-1: USB disconnect, device number 90
dvb-usb: Technisat SkyStar USB HD (DVB-S/S2) successfully deinitialized and  
disconnected.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
