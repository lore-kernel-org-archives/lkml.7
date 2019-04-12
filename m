Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5055C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D142186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfDLLqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:46:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43732 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfDLLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:46:14 -0400
Received: by mail-io1-f71.google.com with SMTP id n23so7525832ioj.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=daElYsJolZnOy5KuYjuTPYeF39jQUM+ooVFS23wD6NI=;
        b=gZ2fQZjVkSnMf75zfzFwOjYsY+hSQ5V6pdUUZT/M9bqj2Hy5Zq4eP2BvKwGxJmEdT9
         mP6KtpZBhYrsIfuQojVdjd3Ec6zYTp11Vu/hl8izwwPN8LNoYPTbPuLot7/ZR0ISYC7v
         EpSaddYcG9UP5MwZeILf4eROlh3cCOyIRjbsXf13CAl3Hb9eVrLz8c+n5Kpv8tXknn2V
         x2jKtEcaOhfbdG0K7FgWzGdU4qiGnHOIE8dHbeblRgTit0LMaY/x2UiM65T+7cIs3WRN
         uOOpoG0J1bpMyWcl99kfRApdGbQL0U5/p8+YBxPJre8F33mfa5HmFqzZ/7HNSY3b2CDI
         QM5Q==
X-Gm-Message-State: APjAAAUo6Fz0l+k+rOmR6O0x7cbkvGAlTcSsdJa04rO5fY+Js6DEc2bQ
        oYHtiYwtTbXaqypM44/h1RGw0BlBiNZpHLk5AZSIZ8YxHNs+
X-Google-Smtp-Source: APXvYqwyIArcZOdv1Ub2eKz8K+/84RHhZTA8N8eRD2uryTG6N2arSDCecDrQuITsLLY3x8B91ESJFImrJ80pq1TY5Z2VZGsC/L7g
MIME-Version: 1.0
X-Received: by 2002:a24:4e86:: with SMTP id r128mr3606662ita.27.1555069573251;
 Fri, 12 Apr 2019 04:46:13 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:46:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083d0ba058653d9c2@google.com>
Subject: BUG: corrupted list in snd_info_free_entry
From:   syzbot <syzbot+90cf07b4a2473213d16b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14edefa7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=90cf07b4a2473213d16b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15aba2b7200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90cf07b4a2473213d16b@syzkaller.appspotmail.com

snd_usb_toneport: probe of 6-1:0.0 failed with error -71
snd_usb_toneport 2-1:0.0: Line 6 POD Studio UX2 now disconnected
usb 5-1: USB disconnect, device number 5
list_del corruption. prev->next should be ffff8880a725e9a8, but was  
ffff8880a725e228
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:51!
invalid opcode: 0000 [#1] SMP KASAN PTI
usb 6-1: USB disconnect, device number 5
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_del_entry_valid.cold+0xf/0x55 lib/list_debug.c:51
Code: e8 69 e7 e9 fd 0f 0b 48 89 f1 48 c7 c7 00 94 b3 8e 4c 89 e6 e8 55 e7  
e9 fd 0f 0b 48 89 ee 48 c7 c7 a0 95 b3 8e e8 44 e7 e9 fd <0f> 0b 4c 89 ea  
48 89 ee 48 c7 c7 e0 94 b3 8e e8 30 e7 e9 fd 0f 0b
RSP: 0018:ffff8880a84b7118 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8880a725e8b0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed1015096e15
RBP: ffff8880a725e9a8 R08: 0000000000000054 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88809cb90868
R13: ffff8880a7068e98 R14: ffff8880a725e8b0 R15: ffff8880a725e998
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff9de9dfc8 CR3: 00000000963ea000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
usb 1-1: new high-speed USB device number 6 using dummy_hcd
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
usb 6-1: new high-speed USB device number 6 using dummy_hcd
usb 5-1: new high-speed USB device number 6 using dummy_hcd
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
---[ end trace 8111524f564d7b8a ]---
RIP: 0010:__list_del_entry_valid.cold+0xf/0x55 lib/list_debug.c:51
Code: e8 69 e7 e9 fd 0f 0b 48 89 f1 48 c7 c7 00 94 b3 8e 4c 89 e6 e8 55 e7  
e9 fd 0f 0b 48 89 ee 48 c7 c7 a0 95 b3 8e e8 44 e7 e9 fd <0f> 0b 4c 89 ea  
48 89 ee 48 c7 c7 e0 94 b3 8e e8 30 e7 e9 fd 0f 0b
RSP: 0018:ffff8880a84b7118 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8880a725e8b0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed1015096e15
RBP: ffff8880a725e9a8 R08: 0000000000000054 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88809cb90868
R13: ffff8880a7068e98 R14: ffff8880a725e8b0 R15: ffff8880a725e998
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff9de9dfc8 CR3: 00000000963ea000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
