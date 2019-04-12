Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857E32186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfDLLqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:46:38 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52051 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfDLLqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:46:13 -0400
Received: by mail-it1-f200.google.com with SMTP id y127so8894114itb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Fcgnn308KWXqWGCTLLJkSiki90KP8eZcglNT1uKkWZc=;
        b=fHg+FMeLn1uTkIdcIRC7pUH1qAZemqGVgFGhdCyZR8S+j/dlijmQrb9HpH4/cyfmbJ
         OBgPVuzsiopn4HSCOvsYTPhjdVBOEL9w1wKeO6bg4CRRq8UfiEWcsx35C0unQGjb3xSd
         Hnkk9+qZ31AFf945ChvX8iW+qNJNhNDtwP4ex2UYzsLxzWWEAspi9ABctjnDQ5FDQbuq
         +0QaksgyGQ4TctTpvw3EkxE7Bs8PQpiVxoCq+gsyG8x3o+ct3W10sC4yneT6ieezbdXU
         5N37F5eovrMv/Krmobb5GIfXzd2yvUeCBGW/42CQtEZg6uO5Oew6DfAlJegowMiLr0d0
         Kg9A==
X-Gm-Message-State: APjAAAXnEU4sagXFwwEKb4HwPcB6Qj26WRiD8uv7q/NwTKcykayonlry
        z+3CMHkzsxttMKzYJqSYuM6ttAlria2PYBw/J9Ake4suzro9
X-Google-Smtp-Source: APXvYqx6GEMGWDCyJAwN/J4RJNrD+6ylC47NDpE0mLZeKQHIvf2dEWnfoDwZPId6BroJYC807k4uMua5CkwODw8vYRMBsgPTd/KI
MIME-Version: 1.0
X-Received: by 2002:a5d:954c:: with SMTP id a12mr2527338ios.31.1555069572964;
 Fri, 12 Apr 2019 04:46:12 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:46:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f693a058653d90c@google.com>
Subject: WARNING: proc registration bug in snd_info_card_register
From:   syzbot <syzbot+2e782bf6a60d0fcb932d@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1738acd3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=2e782bf6a60d0fcb932d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140ef0f3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102c7c2d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e782bf6a60d0fcb932d@syzkaller.appspotmail.com

usb 1-1: send failed (error -71)
usb 6-1: send failed (error -71)
usb 5-1: USB disconnect, device number 3
------------[ cut here ]------------
proc_dir_entry 'asound/PODStudioUX2' already registered
WARNING: CPU: 1 PID: 534 at fs/proc/generic.c:359 proc_register+0x3d9/0x550  
fs/proc/generic.c:359
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 534 Comm: kworker/1:2 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
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
RSP: 0018:ffff88809fb9f000 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88809d2df840 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed1013f73df2
RBP: ffff888096382a00 R08: ffff88809f9cc980 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff8880a594cd38 R15: 000000000000000c
  proc_symlink+0x147/0x1c0 fs/proc/generic.c:451
  snd_info_card_register+0x14b/0x1e0 sound/core/info.c:558
  snd_card_register sound/core/init.c:772 [inline]
  snd_card_register+0x432/0x5f0 sound/core/init.c:736
  toneport_init sound/usb/line6/toneport.c:457 [inline]
  toneport_init+0x256/0x63c sound/usb/line6/toneport.c:412
  line6_probe+0xb01/0x1150 sound/usb/line6/driver.c:784
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
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
