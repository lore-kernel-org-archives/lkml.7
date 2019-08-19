Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC45C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6A321773
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfHSBiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:38:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53575 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfHSBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:38:07 -0400
Received: by mail-io1-f71.google.com with SMTP id h3so2444449iob.20
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 18:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W/SfHvQsi/O7hExDLyePq7I/o/3HakjIf/4ara3zjQw=;
        b=shRGIE/wAJBxDuASGcxhy376CwxI5gPMkn7lqbxFk5IIOTxeW3aMTHxRTtqMBTQjBO
         cmhUtVvSjxfytBP2/JvughpDxlvKrgTzfRIdPQMBaCTHZUGrtB88qd8OAJAIHwzrbBvT
         qtM22lv7mS+5wD8gcOx57PO/A3IQkONa/jWIIC8SXl90Tdwi3sYHxwkgZXquCKr3r+gd
         HyA0CpC2g/Pfx6ZyFfMvfacqV9oAAXrMWgBVTKHWwdeZtMZzvBewMoZF/HrCjyhYjENZ
         oA/b5keSkGn7nywNq4YE1I1JlfWxPqarXhqiOH1uMaCyl4RZetUqs15h7YjFb8ETtPU6
         89nw==
X-Gm-Message-State: APjAAAVDsbxXA/NE72zsfC52hGpbf8SC17YIA/BovqZLtAN1/ZUBxGZy
        FZ1MZYf75Aiz8nsZj32TjE9Xk4oiWAcSaZUN44usJxJRmC8t
X-Google-Smtp-Source: APXvYqzD7e1kKK+nzpNwI9S8lEk1UasqDfdZU3S5YckHlOrgtQa88Z70x4JEKTPuCjFjwbTwk6enGO1oMArvVhZCzDljZJeMssXH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr16650712ioe.86.1566178686389;
 Sun, 18 Aug 2019 18:38:06 -0700 (PDT)
Date:   Sun, 18 Aug 2019 18:38:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041d63f05906e6486@google.com>
Subject: KMSAN: uninit-value in gp8psk_power_ctrl
From:   syzbot <syzbot+fa2759b292234f21d29f@syzkaller.appspotmail.com>
To:     corbet@lwn.net, glider@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f75e4cfe kmsan: use kmsan_handle_urb() in urb.c
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=158867eea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=602468164ccdc30a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa2759b292234f21d29f
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13688dbaa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10595a5aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fa2759b292234f21d29f@syzkaller.appspotmail.com

usb 1-1: config 0 has an invalid interface number: 130 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=09c0, idProduct=0206,  
bcdDevice=ce.c9
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
dvb-usb: found a 'Genpix SkyWalker-2 DVB-S receiver' in warm state.
gp8psk: usb in 128 operation failed.
==================================================================
BUG: KMSAN: uninit-value in gp8psk_power_ctrl+0x33e/0xca0  
drivers/media/usb/dvb-usb/gp8psk.c:193
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:622
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:310
  gp8psk_power_ctrl+0x33e/0xca0 drivers/media/usb/dvb-usb/gp8psk.c:193
  dvb_usb_device_power_ctrl drivers/media/usb/dvb-usb/dvb-usb-init.c:226  
[inline]
  dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:160 [inline]
  dvb_usb_device_init+0x15ad/0x2cc0  
drivers/media/usb/dvb-usb/dvb-usb-init.c:277
  gp8psk_usb_probe+0xa2/0x190 drivers/media/usb/dvb-usb/gp8psk.c:307
  usb_probe_interface+0xd66/0x1320 drivers/usb/core/driver.c:361
  really_probe+0xdae/0x1d80 drivers/base/dd.c:513
  driver_probe_device+0x1b3/0x4f0 drivers/base/dd.c:671
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:778
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x454/0x730 drivers/base/dd.c:844
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:891
  bus_probe_device+0x137/0x390 drivers/base/bus.c:514
  device_add+0x288d/0x30e0 drivers/base/core.c:2106
  usb_set_configuration+0x30dc/0x3750 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x14c/0x200 drivers/usb/core/driver.c:266
  really_probe+0xdae/0x1d80 drivers/base/dd.c:513
  driver_probe_device+0x1b3/0x4f0 drivers/base/dd.c:671
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:778
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x454/0x730 drivers/base/dd.c:844
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:891
  bus_probe_device+0x137/0x390 drivers/base/bus.c:514
  device_add+0x288d/0x30e0 drivers/base/core.c:2106
  usb_new_device+0x23e5/0x2ff0 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x48d1/0x7290 drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:254
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----status@gp8psk_power_ctrl
Variable was created at:
  gp8psk_power_ctrl+0x63/0xca0 drivers/media/usb/dvb-usb/gp8psk.c:188
  dvb_usb_device_power_ctrl drivers/media/usb/dvb-usb/dvb-usb-init.c:226  
[inline]
  dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:160 [inline]
  dvb_usb_device_init+0x15ad/0x2cc0  
drivers/media/usb/dvb-usb/dvb-usb-init.c:277
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
