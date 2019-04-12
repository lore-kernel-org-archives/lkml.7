Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D6A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfDLLqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:46:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51803 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfDLLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:46:14 -0400
Received: by mail-io1-f72.google.com with SMTP id y18so7461169ior.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0j+5G7dPg/greaUurhDWLjbBlvZfWbXBvqNdnkHvllc=;
        b=LtHg1Al0tgucRumxXvHYDB1leZ/ZEwsRx2n+b8OPVesoWHn8hSskinRzRxXxEDYf/3
         0vLnlZ9iUX6A1VgskSCb9O/xk9frmEXRfJ44vjVP2i6f7ag/Eik+oiJSUBsMEgBs+m5I
         u/cSSPVjoYQw3BId+uPsdJaQR61bkOhakfkpRwHTu5ISdy3QusgVQpxxD4wCycJP2reQ
         iqQlnUFxaXlL0PKGfW+WxCGGni62GN665PEPWwbrs08V+60qpN2FXYNCvg7dRSzbsjyr
         I9BE6HvQmh2AGnRLpJEjVP/ZYOtALVFSp+amZNu3e00suQ95kq8ez2PYELWEyoaC1ijs
         sXiw==
X-Gm-Message-State: APjAAAWTghszfu4yai+gslycC/SmmyllYiAhl2m9B5Vy5zD/XijQUJNZ
        mNhCYskDjYzAGq//kQHZW/iD9068hkl8dbeJXT8QBfaOzlRu
X-Google-Smtp-Source: APXvYqwDbWF0OcFG+AtB4VK/IhXRF/iFvUW6DNp79QQZpccJo6ws4f9KgHHNAixoqX9glLpj0ArmG1cZvD0A2bv4yBv33F2MQxAv
MIME-Version: 1.0
X-Received: by 2002:a24:28d:: with SMTP id 135mr3743911itu.16.1555069573462;
 Fri, 12 Apr 2019 04:46:13 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:46:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008706a1058653d950@google.com>
Subject: WARNING: proc registration bug in snd_info_register
From:   syzbot <syzbot+4d729bd9da724d0282dd@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, andreyknvl@google.com,
        joe@perches.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1065d5bb200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=4d729bd9da724d0282dd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4d729bd9da724d0282dd@syzkaller.appspotmail.com

usb 3-1: config 0 descriptor??
snd_usb_toneport 1-1:0.0: Line 6 POD Studio UX2 now attached
usb 1-1: USB disconnect, device number 26
------------[ cut here ]------------
proc_dir_entry 'asound/card4' already registered
WARNING: CPU: 0 PID: 533 at fs/proc/generic.c:359 proc_register+0x3d9/0x550  
fs/proc/generic.c:359
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 533 Comm: kworker/0:2 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  panic+0x29d/0x5f2 kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x130/0x1f0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:proc_register+0x3d9/0x550 fs/proc/generic.c:359
Code: ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 61 01 00 00 48 8b 04 24  
48 c7 c7 e0 a0 79 8e 48 8b b0 d0 00 00 00 e8 a7 9e 71 ff <0f> 0b 48 c7 c7  
a0 90 91 91 e8 b9 10 34 0c 48 8b 4c 24 28 48 b8 00
RSP: 0018:ffff88809f59f018 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88821443f0c0 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815b1e42 RDI: ffffed1013eb3df5
RBP: ffff8880a7b65780 R08: ffff88809f51c980 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88808f034ab8 R15: 0000000000000005
  proc_mkdir_data+0x17b/0x230 fs/proc/generic.c:475
  __snd_info_register sound/core/info.c:814 [inline]
  snd_info_register+0x2f8/0x3e0 sound/core/info.c:854
  create_subdir+0x69/0xa0 sound/core/info.c:458
  snd_info_card_create+0xcf/0x230 sound/core/info.c:528
  snd_card_new+0x61d/0x920 sound/core/init.c:255
  snd_usb_audio_create sound/usb/card.c:475 [inline]
  usb_audio_probe+0x10d9/0x1fa0 sound/usb/card.c:621
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
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
