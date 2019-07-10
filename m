Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8D8C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB320651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfGJNsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:48:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45019 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGJNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:48:07 -0400
Received: by mail-io1-f70.google.com with SMTP id s9so2936125iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 06:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LT8iUgbAX2xL+AtAgDIDYxrRzDLm9I/6tbMydcV9JCo=;
        b=KTByEz8P/jKzZZ8hYLa829OhxxAA2zpOVerr64EHPX9X2RacmNHzd8zRVSBzjFiEf8
         3SOer9lAIwABCf7ekzahO++m2dXSbQDcoOol83plQoZqIyKdERRjzm1cj9FkGZKgp+q/
         Q6TP2gZL0AtLq6Kjfqgv1oIQz496Q3P5NZxPcoCoFVOQ9lSmUWO0c4pP+FjiZS2mLM/z
         X30nqQzx96+MUcgev9p+4hoCIx7kkdX37ZfLu/sMEFkWGWz5wZsb5g9y/QKSluY2nVRS
         JmZowuTLS16rkcwQ2EgObUAHpjKyxtvKuF45iy7GAdbNUQQNV8UgG6KE/bPJ0l7JMgJc
         jT8A==
X-Gm-Message-State: APjAAAWgvdikmTmpJwMr0pb1J2cAqEB74K8LyXEOfrIwsxSOn70hRdSX
        dm57B1F0XUMIMU+fpsfS1dEtogr7+uRFreSzQgAQ7czBGkDX
X-Google-Smtp-Source: APXvYqzB03A6/uFaA+aMcEDhb10J8uMiGMBsvBNzI5WiGYoN2Ne+iRnEIZCqpv9xpoRMpISrjbP0GK+lGYzcfeokleBUwej3rEbn
MIME-Version: 1.0
X-Received: by 2002:a02:bb05:: with SMTP id y5mr33900034jan.93.1562766485874;
 Wed, 10 Jul 2019 06:48:05 -0700 (PDT)
Date:   Wed, 10 Jul 2019 06:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041eeb7058d53ed4c@google.com>
Subject: KMSAN: uninit-value in friio_power_ctrl
From:   syzbot <syzbot+9e6bf7282557bd1fc80d@syzkaller.appspotmail.com>
To:     crope@iki.fi, glider@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4009f3cf kmsan: slub: fix a compilation warning by moving ..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=10b58730600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=9e6bf7282557bd1fc80d
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9e6bf7282557bd1fc80d@syzkaller.appspotmail.com

usb 6-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 6-1: config 0 descriptor??
usb 6-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
==================================================================
BUG: KMSAN: uninit-value in friio_reset  
drivers/media/usb/dvb-usb-v2/gl861.c:433 [inline]
BUG: KMSAN: uninit-value in friio_power_ctrl+0xb3e/0x1a70  
drivers/media/usb/dvb-usb-v2/gl861.c:482
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.2.0-rc4+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  friio_reset drivers/media/usb/dvb-usb-v2/gl861.c:433 [inline]
  friio_power_ctrl+0xb3e/0x1a70 drivers/media/usb/dvb-usb-v2/gl861.c:482
  dvb_usbv2_device_power_ctrl  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:540 [inline]
  dvb_usbv2_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:853 [inline]
  dvb_usbv2_probe+0xd3d/0x5dd0  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:980
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

Local variable description: ----rbuf.i@friio_power_ctrl
Variable was created at:
  friio_reset drivers/media/usb/dvb-usb-v2/gl861.c:400 [inline]
  friio_power_ctrl+0x92/0x1a70 drivers/media/usb/dvb-usb-v2/gl861.c:482
  dvb_usbv2_device_power_ctrl  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:540 [inline]
  dvb_usbv2_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:853 [inline]
  dvb_usbv2_probe+0xd3d/0x5dd0  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:980
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
