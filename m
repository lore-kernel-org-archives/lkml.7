Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162B420815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0LiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:38:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:57077 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfE0LiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:38:07 -0400
Received: by mail-it1-f198.google.com with SMTP id l124so10610102itg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 04:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EvVlLBGL0bMbZSXnS0Gdmap9SOaSaRB3to/I0YZeZYM=;
        b=JIXrIaexzbCR0DCnpzjJVZ+mbJ4D5U7GqGfsW3FQGEnewBXIpb6qUGD0Wz5NLGXCJN
         6LaFlATDL3ZykI09J5wptqBImvnl7jwh8ZpZvFb1zyaVLbqHYIz9JT/x0bwfCG+br+Wo
         YcLBZPoy1n5/Wsn14ZVCrTYAqkthZpWHZwylk8uGOgH0jWWyEPaq46Hp9gab31C4GO4y
         tBPOQfY4d1SbhhjST3o3GzrQDVNbuKbVX9iyg5GV8ZJxHcM0ofhaaxL35RVRaeszUFvM
         GOl0utlmnSvFijT0E9awoMhY5JSEuRYkLsjfOSwvd46/uI4+PsdLcDtvgva2qjAvblTf
         SIMQ==
X-Gm-Message-State: APjAAAWPVWarDqkGCiWus6gYXXYAwobUc+GeOQ5/QocvhcI4+rFT8T78
        Kma2LCEIig6TrlI1gEAeMUUzqZMUf4al0D4V8i9nKaIEC8hu
X-Google-Smtp-Source: APXvYqw/eeDZQun7I1CmQXRbxyLVKcB6Jf3epBqJ0cS4pB78gs07wdj63cO49WXjDImlFDN0BdrV+pHBsS8KPUysPrHHURkA9uS+
MIME-Version: 1.0
X-Received: by 2002:a6b:7a42:: with SMTP id k2mr1902229iop.214.1558957085973;
 Mon, 27 May 2019 04:38:05 -0700 (PDT)
Date:   Mon, 27 May 2019 04:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005463aa0589dcfb85@google.com>
Subject: INFO: trying to register non-static key in usbtouch_reset_resume
From:   syzbot <syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=14a2b45ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95aff7278e7ff25e
dashboard link: https://syzkaller.appspot.com/bug?extid=933daad9be4e67ba91a9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1776669aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com

usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
hub 1-1:0.189: ignoring external hub
input: USB Touchscreen 08f2:007f as  
/devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.189/input/input6
usb 1-1: reset high-speed USB device number 3 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc3+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:786 [inline]
  register_lock_class+0x11ae/0x1240 kernel/locking/lockdep.c:1095
  __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
  lock_acquire+0x100/0x2b0 kernel/locking/lockdep.c:4211
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xf9/0x12b0 kernel/locking/mutex.c:1072
  usbtouch_reset_resume+0xb3/0x170  
drivers/input/touchscreen/usbtouchscreen.c:1624
  usb_resume_interface drivers/usb/core/driver.c:1242 [inline]
  usb_resume_interface.isra.0+0x187/0x3a0 drivers/usb/core/driver.c:1210
  usb_resume_both+0x23d/0x780 drivers/usb/core/driver.c:1412
  __rpm_callback+0x287/0x3c0 drivers/base/power/runtime.c:357
  rpm_callback+0x18f/0x230 drivers/base/power/runtime.c:487
  rpm_resume+0x10c2/0x1840 drivers/base/power/runtime.c:851
  __pm_runtime_resume+0x103/0x180 drivers/base/power/runtime.c:1078
  pm_runtime_get_sync include/linux/pm_runtime.h:227 [inline]
  usb_autoresume_device+0x1e/0x60 drivers/usb/core/driver.c:1599
  usb_remote_wakeup+0x7b/0xb0 drivers/usb/core/hub.c:3600
  hub_port_connect_change drivers/usb/core/hub.c:5190 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x23c9/0x35a0 drivers/usb/core/hub.c:5432
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x30e/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
usb 1-1: USB disconnect, device number 3
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: new high-speed USB device number 4 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: config 0 has an invalid interface number: 189 but max is 0
usb 1-1: config 0 has an invalid descriptor of length 0, skipping remainder  
of the config
usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 189 altsetting 0 endpoint 0x82 has an invalid  
bInterval 0, changing to 7
usb 1-1: New USB device found, idVendor=08f2, idProduct=007f,  
bcdDevice=97.17
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
hub 1-1:0.189: ignoring external hub
input: USB Touchscreen 08f2:007f as  
/devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.189/input/input7
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: reset high-speed USB device number 4 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: Using ep0 maxpacket: 8
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
usb 1-1: USB disconnect, device number 6
usb usb1: dummy_bus_suspend
usb usb1: dummy_bus_resume
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: new high-speed USB device number 7 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: config 0 has an invalid interface number: 189 but max is 0
usb 1-1: config 0 has an invalid descriptor of length 0, skipping remainder  
of the config
usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 189 altsetting 0 endpoint 0x82 has an invalid  
bInterval 0, changing to 7
usb 1-1: New USB device found, idVendor=08f2, idProduct=007f,  
bcdDevice=97.17
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
hub 1-1:0.189: ignoring external hub
input: USB Touchscreen 08f2:007f as  
/devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.189/input/input10
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: reset high-speed USB device number 7 using dummy_hcd
dummy_hcd dummy_hcd.0: port status 0x00100503 has changes
usb 1-1: Using ep0 maxpacket: 8
usb usb1: dummy_bus_suspend


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
