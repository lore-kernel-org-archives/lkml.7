Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB2B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfG3JiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:38:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55948 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbfG3JiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:38:08 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so70798195ioh.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1y9Fi4xd/WD1xRzMGaMmSdy9yFpNX7CU1Q7hZgZke/M=;
        b=M2ve8hIDxxmm0VDDhhYwxAgDYeBj3OTVPfWFKlPy0kJWpeAXGvWvznDlrwdxk2/3qi
         q6W+DzlPJ91zNsGZDliA+DelX8V0EYhyLsZo7/HtYOh2oJ/uCHAgFkP33gsV4O9dUvjR
         hXh5cdqC/dKYXbzWkZLaVx4P83eS3yinKl6Br4Rd9Rh6T5wUtongvjfBUykcEZ7nO+cv
         PKg4YTIKjU/6lhv5aW3bV/V1LTUPKPzmbZeSua6J8BOa2n7dtozyTfgaW75O6j+3rfUc
         Jd5jkXB+GB0zanlcfeAbXkpy+C21AVgnDBtUuzmVaC4403T2xn1AjIwR7k9ypxV/3+Zv
         usyQ==
X-Gm-Message-State: APjAAAUYEYXSr1e3iSOiAXk2v0Ee1sdjzmNJToWP498an0faJLVQ7/HZ
        6KnnYuRMmXr33N49dhWezThTH+eAGa2FtandryOW15Anjz6V
X-Google-Smtp-Source: APXvYqyzHgcUYFsyAT8BbaDMNAKgcUpGhf6T89n6/PeQHVk3Reb3roGrBjziZ5uCxYNJLmKhf2zKEqsNDJ1mJ2tDAaltdpf3gg9g
MIME-Version: 1.0
X-Received: by 2002:a5e:c30f:: with SMTP id a15mr62119065iok.246.1564479487433;
 Tue, 30 Jul 2019 02:38:07 -0700 (PDT)
Date:   Tue, 30 Jul 2019 02:38:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bb4c6058ee2c4cf@google.com>
Subject: KMSAN: kernel-usb-infoleak in ttusb_dec_send_command
From:   syzbot <syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f23a6010 kmsan: dropped process_future_ranges()
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=10b3dac7a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=0522702e9d67142379f1
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10abd677a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167addbba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com

usb 1-1: config 0 interface 70 altsetting 0 endpoint 0x3 has an invalid  
bInterval 0, changing to 10
usb 1-1: New USB device found, idVendor=0b48, idProduct=1008,  
bcdDevice=69.06
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50  
drivers/usb/core/urb.c:405
CPU: 1 PID: 3095 Comm: kworker/1:2 Not tainted 5.2.0-rc4+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  kmsan_internal_check_memory+0x974/0xa80 mm/kmsan/kmsan.c:573
  kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:617
  usb_submit_urb+0x7ef/0x1f50 drivers/usb/core/urb.c:405
  usb_start_wait_urb+0x143/0x410 drivers/usb/core/message.c:58
  usb_bulk_msg+0x811/0x920 drivers/usb/core/message.c:257
  ttusb_dec_send_command+0x47d/0xd50  
drivers/media/usb/ttusb-dec/ttusb_dec.c:345
  ttusb_dec_get_stb_state drivers/media/usb/ttusb-dec/ttusb_dec.c:393  
[inline]
  ttusb_dec_init_stb drivers/media/usb/ttusb-dec/ttusb_dec.c:1421 [inline]
  ttusb_dec_probe+0xe31/0x4df0 drivers/media/usb/ttusb-dec/ttusb_dec.c:1680
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

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:200 [inline]
  kmsan_internal_poison_shadow+0x53/0xa0 mm/kmsan/kmsan.c:159
  kmsan_kmalloc+0xa4/0x130 mm/kmsan/kmsan_hooks.c:178
  kmem_cache_alloc_trace+0x503/0xae0 mm/slub.c:2793
  kmalloc include/linux/slab.h:547 [inline]
  ttusb_dec_send_command+0x155/0xd50  
drivers/media/usb/ttusb-dec/ttusb_dec.c:322
  ttusb_dec_get_stb_state drivers/media/usb/ttusb-dec/ttusb_dec.c:393  
[inline]
  ttusb_dec_init_stb drivers/media/usb/ttusb-dec/ttusb_dec.c:1421 [inline]
  ttusb_dec_probe+0xe31/0x4df0 drivers/media/usb/ttusb-dec/ttusb_dec.c:1680
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

Bytes 4-63 of 64 are uninitialized
Memory access of size 64 starts at ffff8880ba4efac0
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
