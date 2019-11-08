Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FF7FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C732084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfKHNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:14:09 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40729 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfKHNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:14:09 -0500
Received: by mail-io1-f71.google.com with SMTP id 125so5254769iou.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5qPg7AUaFPT0P/f6N1mT2Nun0O6dZE92eys1pDsyui8=;
        b=KseRMT28RyE7kb0ap5ZqHxVGs2Gpqw2xAzXiBsCTq5qftvNQTCd9Icz1wTlJWyIOi7
         EQDVAfPGdwAoXqrddhj3CfWZ1E6PeETrRFqvWDBNkyFYfEQWr32Po4ViOSxAQMyd0o75
         wTKmNzUmM5XILNV8upw5PIXAuHFEjPth7g4DPziFLXEQA1jUC2hKlcIaTGXx14ZEV2R/
         B9C6lvz8HPLnEwPiViUsTOqL84uhcr69r7QdJwxuM7YTPBFiuBY6b0PjbOOdZLfczlzL
         g3o+ATxRSj7Ba21m1x1CHQtcbqB3l4jpymAUARD5ETkmgpbemzWL/pbBlRcQmvxWKEQD
         s7WQ==
X-Gm-Message-State: APjAAAVlpec8YagrIIYbruJqO71XC5yQtmJW27CMj3SyRVPCl/WlnGYh
        +sy03XwuX7L9TBfqVm6W/A9qxTeJynbfWuI078rUaUYhRXBJ
X-Google-Smtp-Source: APXvYqyOtMzgIQGGhqDCHsWzroal3Q1MOG/G0ooE8crNYN2lzzLJtOJb7VYGlgr5j37yiq8FWs3qCJAS9KpCZbzp3+PUj4YIKbxj
MIME-Version: 1.0
X-Received: by 2002:a05:6602:228e:: with SMTP id d14mr9666368iod.122.1573218848352;
 Fri, 08 Nov 2019 05:14:08 -0800 (PST)
Date:   Fri, 08 Nov 2019 05:14:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c36650596d58e21@google.com>
Subject: KMSAN: uninit-value in _mix_pool_bytes
From:   syzbot <syzbot+8a8d1324f5b614ad3c8c@syzkaller.appspotmail.com>
To:     arnd@arndb.de, glider@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16446805a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=8a8d1324f5b614ad3c8c
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14517405a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c0d805a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a8d1324f5b614ad3c8c@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=0bda, idProduct=8150,  
bcdDevice=31.ce
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KMSAN: uninit-value in _mix_pool_bytes+0x7de/0x960  
drivers/char/random.c:621
CPU: 1 PID: 3089 Comm: kworker/1:2 Not tainted 5.2.0-rc4+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan.c:611
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:304
  _mix_pool_bytes+0x7de/0x960 drivers/char/random.c:621
  add_device_randomness+0x776/0xfa0 drivers/char/random.c:1189
  register_netdevice+0x1eab/0x2690 net/core/dev.c:8724
  register_netdev+0x93/0xd0 net/core/dev.c:8823
  rtl8150_probe+0x11f8/0x1550 drivers/net/usb/rtl8150.c:920
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
  set_ethernet_addr drivers/net/usb/rtl8150.c:285 [inline]
  rtl8150_probe+0x114c/0x1550 drivers/net/usb/rtl8150.c:916
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

Local variable description: ----node_id.i@rtl8150_probe
Variable was created at:
  get_registers drivers/net/usb/rtl8150.c:915 [inline]
  set_ethernet_addr drivers/net/usb/rtl8150.c:284 [inline]
  rtl8150_probe+0xdce/0x1550 drivers/net/usb/rtl8150.c:916
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
