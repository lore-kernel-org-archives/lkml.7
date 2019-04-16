Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B51C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD042075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfDPA3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:29:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34598 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDPA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:29:07 -0400
Received: by mail-io1-f72.google.com with SMTP id y13so15477147iol.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9ZxXJHwe044IAowPjqhY/RPcUi7CWqBlYtybxMQDKlw=;
        b=HkJ3DoFuQh6elrEsfC+Oi6Pn/Yp3fDNaOo4Tlhb9q+D/BSyH29tkIKXrHM3Nq+GUMD
         iDmQbE92EiwgjZ1QN7ZhPvlIjcxNlwqM9JsrasW8ACRmwQPez4mgZciVmYeWsnH23fz6
         OxvOlZS8g2sHaKrCgopf0vnEqKPof/B1777fyRh7Iq3gNDJCh8X3fTgYzT8YjKPS8jPG
         IrKGAJI9ROTG+zAsS9O5Vev5WuJBklm/lbrvEyDG/1lSSn+SIPCnjvKIpKCcluXpf/r5
         Ne5LWj65BE0IEIrMROqtr4Yj7wT07azc/rIz6phw+2e7LFrXYYIm5NW9doNgMlGFxCrI
         MlyQ==
X-Gm-Message-State: APjAAAVZtGroKG9AsmgldYqzcdp/Gy1lwJrBLHj+i/p+RHCwRQZGyCr/
        L0PjiDRgriMpJWjUosyWuNgF5nS0fUrr78JRRwS6KEDlj2ih
X-Google-Smtp-Source: APXvYqwXJtAM8ixbzEiZBvdz1kE0wd/yRxF/GXV0sOp4t8NIV0mbt6h429AQNjmegPrKkFhfnmM1DWIWAqesxs13C3SPxVd8skWE
MIME-Version: 1.0
X-Received: by 2002:a6b:e30e:: with SMTP id u14mr1611016ioc.13.1555374546178;
 Mon, 15 Apr 2019 17:29:06 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:29:06 -0700
In-Reply-To: <00000000000083d0ba058653d9c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000515bbf05869adb3f@google.com>
Subject: Re: BUG: corrupted list in snd_info_free_entry
From:   syzbot <syzbot+90cf07b4a2473213d16b@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        andreyknvl@google.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=111b89d3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=90cf07b4a2473213d16b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1611baf3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1665618f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90cf07b4a2473213d16b@syzkaller.appspotmail.com

snd_usb_toneport 5-1:0.0: set_interface failed
list_del corruption. prev->next should be ffff8880a78a4868, but was  
ffff88821b198ea8
snd_usb_toneport 4-1:0.0: Line 6 POD Studio UX2 now disconnected
------------[ cut here ]------------
snd_usb_toneport 5-1:0.0: Line 6 POD Studio UX2 now disconnected
kernel BUG at lib/list_debug.c:51!
invalid opcode: 0000 [#1] SMP KASAN PTI
snd_usb_toneport: probe of 5-1:0.0 failed with error -71
CPU: 1 PID: 537 Comm: kworker/1:3 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
snd_usb_toneport: probe of 4-1:0.0 failed with error -71
RIP: 0010:__list_del_entry_valid.cold+0xf/0x55 lib/list_debug.c:51
Code: e8 69 e7 e9 fd 0f 0b 48 89 f1 48 c7 c7 00 94 b3 8e 4c 89 e6 e8 55 e7  
e9 fd 0f 0b 48 89 ee 48 c7 c7 a0 95 b3 8e e8 44 e7 e9 fd <0f> 0b 4c 89 ea  
48 89 ee 48 c7 c7 e0 94 b3 8e e8 30 e7 e9 fd 0f 0b
RSP: 0018:ffff88809eddf118 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8880a78a4770 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed1013dbbe15
RBP: ffff8880a78a4868 R08: 0000000000000054 R09: ffffed1015a24fc9
R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffff88809cafbea8
usb 5-1: USB disconnect, device number 41
R13: ffff8880a74abc18 R14: ffff8880a78a4770 R15: ffff8880a78a4858
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4fcd865000 CR3: 00000000945aa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
usb 4-1: USB disconnect, device number 41
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  snd_info_free_entry+0x137/0x340 sound/core/info.c:795
  snd_info_card_free+0x43/0x90 sound/core/info.c:606
  snd_card_do_free sound/core/init.c:469 [inline]
  release_card_device+0x8b/0x100 sound/core/init.c:156
  device_release+0x7d/0x210 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put+0x1df/0x4f0 lib/kobject.c:708
  put_device+0x21/0x30 drivers/base/core.c:2205
  snd_card_free_when_closed+0x3a/0x50 sound/core/init.c:493
  line6_disconnect.cold+0xa3/0xbc sound/usb/line6/driver.c:833
  line6_probe+0xb23/0x1150 sound/usb/line6/driver.c:799
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
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace f69ca8f71496c60d ]---
RIP: 0010:__list_del_entry_valid.cold+0xf/0x55 lib/list_debug.c:51
snd_usb_toneport 1-1:0.0: set_interface failed
Code: e8 69 e7 e9 fd 0f 0b 48 89 f1 48 c7 c7 00 94 b3 8e 4c 89 e6 e8 55 e7  
e9 fd 0f 0b 48 89 ee 48 c7 c7 a0 95 b3 8e e8 44 e7 e9 fd <0f> 0b 4c 89 ea  
48 89 ee 48 c7 c7 e0 94 b3 8e e8 30 e7 e9 fd 0f 0b
RSP: 0018:ffff88809eddf118 EFLAGS: 00010282
snd_usb_toneport 1-1:0.0: Line 6 POD Studio UX2 now disconnected
RAX: 0000000000000054 RBX: ffff8880a78a4770 RCX: 0000000000000000
snd_usb_toneport: probe of 1-1:0.0 failed with error -71
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed1013dbbe15
RBP: ffff8880a78a4868 R08: 0000000000000054 R09: ffffed1015a24fc9
R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffff88809cafbea8
R13: ffff8880a74abc18 R14: ffff8880a78a4770 R15: ffff8880a78a4858
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
usb 1-1: USB disconnect, device number 42
CR2: 00007f4fcd865000 CR3: 000000001167a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

