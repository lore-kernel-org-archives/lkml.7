Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC22FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA8E21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfKHNYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:24:14 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35767 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfKHNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:24:12 -0500
Received: by mail-il1-f198.google.com with SMTP id w69so6900285ilk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xg4K1fggR6L/WmEQF2suk0G83y8UDvhYyhUB0WEbMPM=;
        b=eZP4pZXNEaGjATgWpzxcD4j5QA43+x15cZ9rc7LHzgDel1WPhaaoFX12jEtjtRui8m
         TTowoQGRr+HZJdnTqzM60pL0GtOg1NWJrLPxo6ahxIFAqG6ZXISNMY0J2alqEz7xUtSr
         Yup18EGVdsom0CEG96yLb4cloCiGV6GocmeM4R610FadXEm0G9jnfP405PJs007q2iM2
         pDbi6kD9wF4px0ZPQrz9uFfF20/Wta6nGOmOtKFSNLLsy1mi1pY7ZUz1p6yyl2OLBjSb
         jE3Obct718tmTO/cxNt7k2IJTtui8r4B2l/upU076cEXfRCEJ3z78ZensU8YecLWrrr2
         2O0w==
X-Gm-Message-State: APjAAAXgpVpWwVM6NZdjlMEdx0fTh3Tg1LBTZdhjWwxTFuljpYdWv9eW
        iWmlSX/xaXy8dbPt0uZ35i9FBttxbW6WLxD41bl1rg3R81w0
X-Google-Smtp-Source: APXvYqxO2xCEf+l7hDzqfk7SCYQdh0U1Uriu0QZt06kn7nP8HyXlB+3TdIPsVXvaOWFxMjA1aa5R49ho0adFVsmRkyPsv/+wmY/G
MIME-Version: 1.0
X-Received: by 2002:a5d:9b0f:: with SMTP id y15mr9661634ion.35.1573219450030;
 Fri, 08 Nov 2019 05:24:10 -0800 (PST)
Date:   Fri, 08 Nov 2019 05:24:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079154e0596d5b299@google.com>
Subject: KMSAN: uninit-value in dvb_usb_adapter_dvb_init
From:   syzbot <syzbot+ec869945d3dde5f33b43@syzkaller.appspotmail.com>
To:     glider@google.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mail@maciej.szmigiero.name, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6f88939b kmsan: don't unpoison memory in do_read_cache_pag..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101311a2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e324dfe9c7b0360
dashboard link: https://syzkaller.appspot.com/bug?extid=ec869945d3dde5f33b43
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ec869945d3dde5f33b43@syzkaller.appspotmail.com

vp7045: USB control message 'out' went wrong.
vp7045: USB control message 'out' went wrong.
vp7045: USB control message 'out' went wrong.
vp7045: USB control message 'out' went wrong.
=====================================================
BUG: KMSAN: uninit-value in mac_address_string+0xcd5/0x1000  
lib/vsprintf.c:604
CPU: 0 PID: 13542 Comm: kworker/0:7 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
  mac_address_string+0xcd5/0x1000 lib/vsprintf.c:604
  pointer+0x56d/0x1d10 lib/vsprintf.c:2148
  vsnprintf+0x1c0c/0x3210 lib/vsprintf.c:2514
  vscnprintf+0xc2/0x180 lib/vsprintf.c:2613
  vprintk_store+0xef/0x11e0 kernel/printk/printk.c:1922
  vprintk_emit+0x2c6/0x860 kernel/printk/printk.c:1984
  vprintk_default+0x90/0xa0 kernel/printk/printk.c:2029
  vprintk_func+0x635/0x810 kernel/printk/printk_safe.c:386
  printk+0x180/0x1c3 kernel/printk/printk.c:2062
  dvb_usb_adapter_dvb_init+0x90e/0x13f0  
drivers/media/usb/dvb-usb/dvb-usb-dvb.c:166
  dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:83 [inline]
  dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:173 [inline]
  dvb_usb_device_init+0x22fe/0x2e10  
drivers/media/usb/dvb-usb/dvb-usb-init.c:287
  vp7045_usb_probe+0x73/0x80 drivers/media/usb/dvb-usb/vp7045.c:164
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2202
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
  device_add+0x25b5/0x2df0 drivers/base/core.c:2202
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
  __msan_chain_origin+0x6b/0xd0 mm/kmsan/kmsan_instr.c:179
  vp7045_read_eeprom drivers/media/usb/dvb-usb/vp7045.c:123 [inline]
  vp7045_read_mac_addr+0x62e/0xbe0 drivers/media/usb/dvb-usb/vp7045.c:132
  dvb_usb_adapter_dvb_init+0x890/0x13f0  
drivers/media/usb/dvb-usb/dvb-usb-dvb.c:165
  dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:83 [inline]
  dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:173 [inline]
  dvb_usb_device_init+0x22fe/0x2e10  
drivers/media/usb/dvb-usb/dvb-usb-init.c:287
  vp7045_usb_probe+0x73/0x80 drivers/media/usb/dvb-usb/vp7045.c:164
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2202
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
  device_add+0x25b5/0x2df0 drivers/base/core.c:2202
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----br.i@vp7045_read_mac_addr
Variable was created at:
  vp7045_read_eeprom drivers/media/usb/dvb-usb/vp7045.c:119 [inline]
  vp7045_read_mac_addr+0x7b/0xbe0 drivers/media/usb/dvb-usb/vp7045.c:132
  vp7045_read_eeprom drivers/media/usb/dvb-usb/vp7045.c:119 [inline]
  vp7045_read_mac_addr+0x7b/0xbe0 drivers/media/usb/dvb-usb/vp7045.c:132
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
