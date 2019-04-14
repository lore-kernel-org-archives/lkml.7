Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15525C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9020850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDNUGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:06:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40077 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfDNUGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:06:07 -0400
Received: by mail-io1-f69.google.com with SMTP id e72so12532586iof.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pG8X90FvGf2fjplmvbLtMTBmdPNswK6If5gFdTwKTvw=;
        b=CVSVD35ql8RuSj8kxxM3QGECU3LWs0Hqu7x8IM4pM1JYmx/dHR3Ljg4Yi+MzRA1vgU
         ygb8XQ+7hyzjEsX/5XQZ40VIi2iFDI9JxaNY8bpWiJYOdLoPEaNi9KCZe6fPzeMHGrE+
         F+39bpe6U8cUf15iXG6+BkLzjg23LmRjDbjNopriSpbQEyQbgkAlwDuFFK+R6Ipe0Ovu
         WEK1aIqud87XuVEAtsZQaKX0gNaZyh0dddXw4L2xs/IdRiIt/iJN9WtJTPAsv3xYDjiX
         Grf8/ldozHIVCk/6665khc6yDKYeQmza4uJbux4u3/AWN7d9fXRI4Txe4xBeSs/7QBZu
         IobA==
X-Gm-Message-State: APjAAAXBXx3+x3+UDkP9OJFdqwhouIH9AIHl6+95enCmISI4dIJw40dJ
        IhZB8jstMjifkjRnhIpEDRW3oSSxcOFUxbEqiYJCx0yvCJeD
X-Google-Smtp-Source: APXvYqyxqVaJ4b3Vg2hyOK/Rmb3LNq2KY/kmQvLjpRf1ijUubg9W3mpaa6VBm2x5Ij7esICf7qeTeXH/962aigqQ/POJkiIrMjQ8
MIME-Version: 1.0
X-Received: by 2002:a24:6243:: with SMTP id d64mr5877150itc.0.1555272366728;
 Sun, 14 Apr 2019 13:06:06 -0700 (PDT)
Date:   Sun, 14 Apr 2019 13:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2b23d05868310f9@google.com>
Subject: KASAN: stack-out-of-bounds Read in hfcsusb_probe
From:   syzbot <syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bigeasy@linutronix.de, davem@davemloft.net,
        gustavo@embeddedor.com, isdn@linux-pingi.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, pakki001@umn.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=171744f3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=8750abbc3a46ef47d509
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ca062d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154a87bb200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com

usb 1-1: config 0 interface 170 has no altsetting 0
usb 1-1: New USB device found, idVendor=0742, idProduct=200a,  
bcdDevice=c2.97
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: stack-out-of-bounds in hfcsusb_probe.cold+0x1a43/0x267f  
drivers/isdn/hardware/mISDN/hfcsusb.c:1976
Read of size 4 at addr ffff8880a84c72f0 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  hfcsusb_probe.cold+0x1a43/0x267f drivers/isdn/hardware/mISDN/hfcsusb.c:1976
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

The buggy address belongs to the page:
page:ffffea0002a131c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfff00000000000()
raw: 00fff00000000000 ffffea0002a131c8 ffffea0002a131c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a84c7180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8880a84c7200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
> ffff8880a84c7280: f1 f1 f1 f1 01 f2 00 00 00 00 00 00 00 00 f3 f3
                                                              ^
  ffff8880a84c7300: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8880a84c7380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
