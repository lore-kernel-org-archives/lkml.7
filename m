Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD9C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065CD20848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDNT4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:56:23 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53436 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDNT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:56:06 -0400
Received: by mail-io1-f72.google.com with SMTP id w11so12563799iom.20
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 12:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=U2tPvtbFi8gH/NJ70CtiTDqglAZX32uDg8WawLuOVpk=;
        b=H9/XCGhvdzLlMAWp9qdT0u9U7hzZ6IXNblkiSyfKl7T4RvFWGs+m0Z1Ap/fd/mj0HB
         p7HyZaKecOH3CRLD5jHz2G2rKztC6vt3GxL+paZX3KN7a5/R1jhcj5YnktEY40Gp8mBe
         +qMBlvdUq/dTCky32fbfSygUYsw9RenPzcDG56ER+FfPR8YlIjwc5SGtv343AIb4yHV5
         krZRzTouG+lvl1ObFWmecVK6vhr1CzQWrFYVG6/oUJ7swgk14TIAGgZw4l+996Dmta9J
         W5mcjjQZFb8LF4yVGR6v/upNlIH4v+oDa8pZeQVjUZDGKkNrfDc21vlWpfbkWNimfVaX
         T3kw==
X-Gm-Message-State: APjAAAUKOv06XH+3HE3Lzx0w80tBeN9KuKC5r58xe7wNz03hMifx9gl4
        kZ6fk4yb9vuVTgg+sx1TsB4t3qrNTBw4l39lC5vKhKi6QT6r
X-Google-Smtp-Source: APXvYqxoZPS0HA1Br6PxZwvKME0V9mIzINVhaFLzqLaexNWjely+BkGIyPUV9Yaw3LOhrXmtoPceNFB5dea2bBUVwDrBl4BdrMTh
MIME-Version: 1.0
X-Received: by 2002:a24:56cf:: with SMTP id o198mr6037053itb.12.1555271765852;
 Sun, 14 Apr 2019 12:56:05 -0700 (PDT)
Date:   Sun, 14 Apr 2019 12:56:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000220d72058682edb2@google.com>
Subject: INFO: trying to register non-static key in ni6501_detach
From:   syzbot <syzbot+cf4f2b6c24aff0a3edf6@syzkaller.appspotmail.com>
To:     abbotti@mev.co.uk, andreyknvl@google.com,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10e2e69f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=cf4f2b6c24aff0a3edf6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1093c6bf200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df67c3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cf4f2b6c24aff0a3edf6@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
comedi comedi0: Wrong number of endpoints
ni6501 1-1:0.233: driver 'ni6501' failed to auto-configure device.
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 585 Comm: kworker/0:3 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:786 [inline]
  register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
  __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
  lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xfe/0x12b0 kernel/locking/mutex.c:1072
  ni6501_detach+0x5b/0x110 drivers/staging/comedi/drivers/ni_usb6501.c:567
  comedi_device_detach+0xed/0x800 drivers/staging/comedi/drivers.c:204
  comedi_device_cleanup.part.0+0x68/0x140  
drivers/staging/comedi/comedi_fops.c:156
  comedi_device_cleanup drivers/staging/comedi/comedi_fops.c:187 [inline]
  comedi_free_board_dev.part.0+0x16/0x90  
drivers/staging/comedi/comedi_fops.c:190
  comedi_free_board_dev drivers/staging/comedi/comedi_fops.c:189 [inline]
  comedi_release_hardware_device+0x111/0x140  
drivers/staging/comedi/comedi_fops.c:2880
  comedi_auto_config.cold+0x124/0x1b0 drivers/staging/comedi/drivers.c:1068
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
