Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66837C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F4B20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfGJOsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:48:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47411 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfGJOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:48:07 -0400
Received: by mail-io1-f69.google.com with SMTP id r27so3089861iob.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZA5aTkxuyJfzj3O1sG30bKBuT59BmRh1ls1Yctu+BdY=;
        b=c2lUebgZok/MRzyUPkN2bxC2WIh2KdFTWTtAOuG6oeHK9x42m7ZJicf1r0ZKmRTb15
         7ZPvrL3kisRW7w5tbTAUvtf63icqFO+hrHe/JO2WCDXf1jFtj7dYybFPjaoQ7dYkiTa0
         4JHERRNtZgTT8+gvvaEGhc4cvCpPuqGkWm+L5GKacQ9kwlwW9AHT8kiKw6JYu1ArlHhj
         16sAYkXnSr1/aUvpCROpE/CV9Ibxtecgs5BickGbovnv3xauKyOBZ4DjfxxZ7B2NoJEL
         Wv99PYcR6qvJ5waPoZwhNR4Bcc614u9svcUDHn7c6mtGvq+GBo3RUaNyOLZZqs6JASHC
         vz0g==
X-Gm-Message-State: APjAAAUshxbVyxwp6N4qPSmwIBlN46raLLLk4vvYkL45gmY6MxJTjnFF
        18aLTQcOIJEO5CxxRrfWTl1vlNqGTurlofQ225k8g73GU1bg
X-Google-Smtp-Source: APXvYqyOk/5D6/KMzRj2m4Cq7PNeRqX7+mwAOKrO+8DHoF4lPTgfFHf2bNjfx7aJ34YANJMszvcc1XjkVgy8wM1Bp7GbIHCV2wS8
MIME-Version: 1.0
X-Received: by 2002:a5e:9747:: with SMTP id h7mr25296075ioq.299.1562770086789;
 Wed, 10 Jul 2019 07:48:06 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:48:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e38991058d54c35f@google.com>
Subject: KMSAN: uninit-value in smsc95xx_read_eeprom (2)
From:   syzbot <syzbot+0dfe788c0e7be7c95931@syzkaller.appspotmail.com>
To:     UNGLinuxDriver@microchip.com, davem@davemloft.net,
        glider@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        steve.glendinning@shawell.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fe36eb20 kmsan: rework SLUB hooks
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1312be5ba00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=0dfe788c0e7be7c95931
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143976f7a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1218cfd8600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0dfe788c0e7be7c95931@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=0424, idProduct=9908,  
bcdDevice=6a.5e
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
smsc95xx v1.0.6
==================================================================
BUG: KMSAN: uninit-value in smsc95xx_eeprom_confirm_not_busy  
drivers/net/usb/smsc95xx.c:326 [inline]
BUG: KMSAN: uninit-value in smsc95xx_read_eeprom+0x203/0x920  
drivers/net/usb/smsc95xx.c:345
CPU: 1 PID: 695 Comm: kworker/1:2 Not tainted 5.2.0-rc4+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  smsc95xx_eeprom_confirm_not_busy drivers/net/usb/smsc95xx.c:326 [inline]
  smsc95xx_read_eeprom+0x203/0x920 drivers/net/usb/smsc95xx.c:345
  smsc95xx_init_mac_address drivers/net/usb/smsc95xx.c:914 [inline]
  smsc95xx_bind+0x467/0x1690 drivers/net/usb/smsc95xx.c:1286
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

Local variable description: ----buf.i.i86@smsc95xx_read_eeprom
Variable was created at:
  __smsc95xx_read_reg drivers/net/usb/smsc95xx.c:330 [inline]
  smsc95xx_read_reg drivers/net/usb/smsc95xx.c:144 [inline]
  smsc95xx_eeprom_confirm_not_busy drivers/net/usb/smsc95xx.c:320 [inline]
  smsc95xx_read_eeprom+0x109/0x920 drivers/net/usb/smsc95xx.c:345
  smsc95xx_init_mac_address drivers/net/usb/smsc95xx.c:914 [inline]
  smsc95xx_bind+0x467/0x1690 drivers/net/usb/smsc95xx.c:1286
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
