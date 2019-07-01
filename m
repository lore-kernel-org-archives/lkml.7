Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A67C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8ED2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfGALiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:38:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44105 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfGALiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:38:06 -0400
Received: by mail-io1-f72.google.com with SMTP id i133so14845440ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2e1SntskR1wk3R8YDQNaXdZrPYNsv+rRW/w+w1Z7SRM=;
        b=uizxFkJUCRVCW0a5bSfmNnQcsha26/fYekiBl5YFFhL/VfFL5pT9Zzn0n/onEDZlix
         EtPtQRCuKJoyXrRou7Ty3+SV1WGKcelZh7kVS3OFD5hBeZsLBQI/3izsCYUSG4G2Zd5X
         J51TQmCEY+czUpcmqZDcak+TupyerZQW0/c06b61yFaBJ9T5nhfPhnZkULjz70l/S3A8
         FKcfgTABCJbD01v5PDIPCsy48RwLDwUoQD//3J8NallXZ87HnxOlzByjZUuiqL+gZTLR
         5Og0Y7SfAGR4qLaOH1VZ0USwW3JC1iggs3y110r0n/yYMzDp/G3+zRkgSXUe2molJYhJ
         j7hg==
X-Gm-Message-State: APjAAAWHWrJnqfWftzOkWzskjXx4o5pPl82z89edMFuj9xleB4YX5NZX
        wf/FgGWdwNoWNUe0sokOp4mNPxzls2ItAJ+s5p1JunOYkGgl
X-Google-Smtp-Source: APXvYqzb4b/7WqvWityk7fhaVl/oiH2xTFhn6YPl44xVi7nfsucuhRQW3JmnuwKx2YDBmqQOU/2rmVfWmlYWSlwLSD3eGgz2hWsP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:63a:: with SMTP id h26mr27782115jar.92.1561981085266;
 Mon, 01 Jul 2019 04:38:05 -0700 (PDT)
Date:   Mon, 01 Jul 2019 04:38:05 -0700
In-Reply-To: <000000000000cba2b6058ac09eeb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbbb3d058c9d0f6d@google.com>
Subject: Re: KMSAN: uninit-value in ax88178_bind
From:   syzbot <syzbot+abd25d675d47f23f188c@syzkaller.appspotmail.com>
To:     allison@lohutok.net, davem@davemloft.net, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, lynxis@fe80.eu,
        marcel.ziswiler@toradex.com, netdev@vger.kernel.org,
        opensource@jilayne.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, yang.wei9@zte.com.cn, zhang.run@zte.com.cn
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1577f4d5a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=abd25d675d47f23f188c
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ea8283a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a1f57ba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+abd25d675d47f23f188c@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=04bb, idProduct=0930,  
bcdDevice=d2.4a
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KMSAN: uninit-value in is_valid_ether_addr  
include/linux/etherdevice.h:195 [inline]
BUG: KMSAN: uninit-value in asix_set_netdev_dev_addr  
drivers/net/usb/asix_devices.c:61 [inline]
BUG: KMSAN: uninit-value in ax88178_bind+0x635/0xad0  
drivers/net/usb/asix_devices.c:1075
CPU: 1 PID: 30 Comm: kworker/1:1 Not tainted 5.2.0-rc4+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan.c:611
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:304
  is_valid_ether_addr include/linux/etherdevice.h:195 [inline]
  asix_set_netdev_dev_addr drivers/net/usb/asix_devices.c:61 [inline]
  ax88178_bind+0x635/0xad0 drivers/net/usb/asix_devices.c:1075
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

Local variable description: ----buf@ax88178_bind
Variable was created at:
  ax88178_bind+0x60/0xad0 drivers/net/usb/asix_devices.c:1064
  usbnet_probe+0x10d3/0x3950 drivers/net/usb/usbnet.c:1722
==================================================================

