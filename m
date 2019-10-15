Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C775EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF6B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfJOFKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:10:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54077 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJOFKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:10:09 -0400
Received: by mail-io1-f70.google.com with SMTP id w8so30177198iol.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 22:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Di2Q67T+/CrkwFj9lDxi2hVVNtqJXlZbpgqqosecwaA=;
        b=Z0dmZSdcLT34vkPcMKeCPmfJBhL6AHJHYxeADuUR65IiV0nRivBlunPVNrV4OwIFbh
         OVY/uOFfAPz939tu7JhZImRTiHWvimLFYB0Fl8c7uol/TSWEzW8Uj0Cd1q17r6j5UpCL
         Mhm3vfEZi0rVoiPcaNbL7qjCKvsXU4703l2l/bFsNrSk0NufJ7Uanm9uCkRjz+aVkagU
         mjWGR1mCNejeTjVKlDeuFWKE2E3M0+Toha1cvByHxCMIRclnPh/LXo9aJ1ozk5/Swk18
         zkrDUZBsAemK48C97s1so0EgWAR6fFPtxUa2o/ZQOHqP91IDi1tlBDVnFzEl5cpyov9V
         5efA==
X-Gm-Message-State: APjAAAXj6S5yCIiWSPSvSKNIWuxn/EvJ+WcnEI64YWdgO/iYJ4lYtRxl
        Rbt5qLMd1D1fY1VsZB5yZXX/HRjR4g6CD07oOA3WQKMV88iR
X-Google-Smtp-Source: APXvYqzyPDt9faiiv2qV2U6ERLO3DmiafAdhgc5sBTVB8RpWCCi2zAfkLNaD8IkqGnZ9yz228tOMapfKBPC7N50+vWqd95lLqd5/
MIME-Version: 1.0
X-Received: by 2002:a6b:f111:: with SMTP id e17mr2346554iog.65.1571116206542;
 Mon, 14 Oct 2019 22:10:06 -0700 (PDT)
Date:   Mon, 14 Oct 2019 22:10:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064555d0594ebff2f@google.com>
Subject: KMSAN: uninit-value in ax88172a_bind
From:   syzbot <syzbot+a8d4acdad35e6bbca308@syzkaller.appspotmail.com>
To:     allison@lohutok.net, davem@davemloft.net, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        opensource@jilayne.com, swinslow@gmail.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fa169025 kmsan: get rid of unused static functions in kmsa..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1432a653600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49548798e87d32d7
dashboard link: https://syzkaller.appspot.com/bug?extid=a8d4acdad35e6bbca308
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14743a6f600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125bdbc7600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a8d4acdad35e6bbca308@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=0b95, idProduct=172a,  
bcdDevice=9b.e9
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
=====================================================
BUG: KMSAN: uninit-value in ax88172a_bind+0x76d/0xf80  
drivers/net/usb/ax88172a.c:217
CPU: 1 PID: 3632 Comm: kworker/1:2 Not tainted 5.4.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x14e/0x2c0 mm/kmsan/kmsan_report.c:110
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
  ax88172a_bind+0x76d/0xf80 drivers/net/usb/ax88172a.c:217
  usbnet_probe+0x10d3/0x39d0 drivers/net/usb/usbnet.c:1730
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

Local variable description: ----buf@ax88172a_bind
Variable was created at:
  ax88172a_bind+0x66/0xf80 drivers/net/usb/ax88172a.c:186
  ax88172a_bind+0x66/0xf80 drivers/net/usb/ax88172a.c:186
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
