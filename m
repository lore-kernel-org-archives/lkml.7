Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115AE20693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfFFNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:52:12 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39518 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:52:11 -0400
Received: by mail-it1-f199.google.com with SMTP id a62so11922itd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o0RJU0d7tS36/GBK6WaDEPEeObqvBB53uJC4wjI9+rE=;
        b=jgCLlwcI9wpRqXKxpdqDFvyFtY8g9el+12QX/BD7+uYcJM4apIJ0zZiRw3+P844eqm
         vNN9tFLUEoJTmzzihINfcSOzp5SAiS5L2x7YLP0SxYDGofhZhPd9q9RgvUqdW/NB189C
         PjHyYNhjldCi6gUVtjHVAEwEi2d3Y9Om0CVbFtj5+s0/ZH1wwq36iFUtM6C0LLYLc07G
         YpKE7jWVotkEZusHGs9ovbc6zH2okSERoMaBXKjT3kqH8BPlii5dSsDW2/aJ74WMnDoM
         qMsAPmwAkBe3XUA0YF3x8FFmd3XGf8Jx3CC9uJ9CFT4njuzA4x2FPy+/Wfy1Z9OQs+si
         4B3Q==
X-Gm-Message-State: APjAAAWAbxDNOFuloQWpiVHU6uWHaJX6+EVNQIhrzawQ7YqMeJPAbQOT
        wTOL6fWDf9CCVKDmwZDNdpi/eA/7nV0v79VJGsm90ZAlhQC3
X-Google-Smtp-Source: APXvYqxVwo54TufnpHAFfpFhBdeK3HzxTn+CVRm0HOfD5CVWXOzrEYA63Z6H1/aHl1GJqijhZAHB6MUIXBwjrIrIgGXeaNOQNSkS
MIME-Version: 1.0
X-Received: by 2002:a02:c90d:: with SMTP id t13mr11180876jao.62.1559829130866;
 Thu, 06 Jun 2019 06:52:10 -0700 (PDT)
Date:   Thu, 06 Jun 2019 06:52:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000417702058aa80506@google.com>
Subject: KMSAN: uninit-value in r871xu_drv_init
From:   syzbot <syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        florian.c.schilhabel@googlemail.com, glider@google.com,
        gregkh@linuxfoundation.org, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f75e4cfe kmsan: use kmsan_handle_urb() in urb.c
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=153453dea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=602468164ccdc30a
dashboard link: https://syzkaller.appspot.com/bug?extid=6f5ecd144854c0d8580b
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161892c1a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b20986a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=050d, idProduct=945a,  
bcdDevice=f1.a1
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
r8712u: register rtl8712_netdev_ops to netdev_ops
usb 1-1: r8712u: USB_SPEED_LOW with 0 endpoints
usb 1-1: r8712u: Boot from EFUSE: Autoload Failed
==================================================================
BUG: KMSAN: uninit-value in r871xu_drv_init+0x17c6/0x2ad0  
drivers/staging/rtl8712/usb_intf.c:409
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.1.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:622
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:310
  r871xu_drv_init+0x17c6/0x2ad0 drivers/staging/rtl8712/usb_intf.c:409
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

Local variable description: ----data@usb_read8
Variable was created at:
  usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
  r8712_read8+0xaa/0xd0 drivers/staging/rtl8712/rtl8712_io.c:29
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
