Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E964C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35D22075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfDPL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:26:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:44086 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDPL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:26:07 -0400
Received: by mail-it1-f197.google.com with SMTP id v193so18504187itv.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rWAII6ry7LnmqzA/JDIGhgBWz9zXn7xNNlI7irJaTAE=;
        b=UD+WwfrrJwblKlxcmsrjWmEsZci36Sf9hYwULeHTOmXioDEUnvNuUgigBaZ/GXGhrd
         YmNHGILSQZYNH6413doMWOxHtmw5vtLjTC8yVG8HDZJkwSQW/pCPPVdvDq6wu9Sg3Nsh
         JnYV/vgcJ8JDVCr8m8wb8GaSR8j994FLW4OaH1m1TAlBis8nBQ7zgFbsRzT2mu4Gl990
         yFUxsf0RHDuuGwuFb7Ug8qq1sAZ2W8NVdlDokKVNeWgoXIuYjBPXNrM1OS/S2qEIad42
         xzTGEbXe2FyUpc205aniGpVzVX6t3UNxUxuuo0NkWQKIKAZC1L4SnALMLcPH23cIST5B
         lfjw==
X-Gm-Message-State: APjAAAXqzsydBLxLfM//Leo1pMNQsFcd5Mo02vYIrWHSu+Dt0BeBef5H
        5jLxOBPQlw901c7PJ9hQcGclOxRK46yUkx2zADRZjENgxVaY
X-Google-Smtp-Source: APXvYqwblYTmVIF5MJKShnPZV46uiqNS0mMi33DXoZXEOBaH0ZN8wTKAzgtQKNapGh9BKxWGl44yxOTaBhL4Ve0RgS6yvyXdIV8K
MIME-Version: 1.0
X-Received: by 2002:a5e:8a07:: with SMTP id d7mr857676iok.7.1555413966153;
 Tue, 16 Apr 2019 04:26:06 -0700 (PDT)
Date:   Tue, 16 Apr 2019 04:26:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee717d0586a40863@google.com>
Subject: BUG: corrupted list in snd_info_create_entry
From:   syzbot <syzbot+8016c844427ade041774@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15c1a387200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=8016c844427ade041774
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179a01b7200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8016c844427ade041774@syzkaller.appspotmail.com

usb 2-1: USB disconnect, device number 16
list_add corruption. prev->next should be next (ffff8880a8672358), but was  
ffff8880a4cde0e8. (prev=ffff8880a4cde868).
snd_usb_toneport 4-1:0.0: Line 6 POD Studio UX2 found
------------[ cut here ]------------
usb 6-1: USB disconnect, device number 16
kernel BUG at lib/list_debug.c:26!
invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_add_valid.cold+0x3a/0x3c lib/list_debug.c:26
Code: 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 80 94 b3 8e e8 69 e7 e9 fd 0f  
0b 48 89 f1 48 c7 c7 00 94 b3 8e 4c 89 e6 e8 55 e7 e9 fd <0f> 0b 48 89 ee  
48 c7 c7 a0 95 b3 8e e8 44 e7 e9 fd 0f 0b 4c 89 ea
RSP: 0018:ffff8880a846f110 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff8880a8672280 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed101508de14
RBP: ffff8880a52679a8 R08: 0000000000000075 R09: ffffed1015a04fc9
R10: ffffed1015a04fc8 R11: ffff8880ad027e47 R12: ffff8880a8672358
R13: ffff8880a4cde868 R14: ffff8880a52679b0 R15: ffff8880a8672358
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000958dc000 CR4: 00000000001406f0
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  snd_info_create_entry+0x25f/0x400 sound/core/info.c:717
  snd_info_create_module_entry sound/core/info.c:737 [inline]
  create_subdir+0x27/0xa0 sound/core/info.c:454
  snd_info_card_create+0xcf/0x230 sound/core/info.c:528
  snd_card_new+0x61d/0x920 sound/core/init.c:255
snd_usb_toneport 3-1:0.0: set_interface failed
  line6_probe+0x135/0x1150 sound/usb/line6/driver.c:736
snd_usb_toneport 3-1:0.0: Line 6 POD Studio UX2 now disconnected
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
snd_usb_toneport: probe of 3-1:0.0 failed with error -71
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
snd_usb_toneport 4-1:0.0: set_interface failed
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
snd_usb_toneport 4-1:0.0: Line 6 POD Studio UX2 now disconnected
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
snd_usb_toneport: probe of 4-1:0.0 failed with error -71
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
usb 3-1: USB disconnect, device number 16
usb 4-1: USB disconnect, device number 16
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
usb 2-1: new high-speed USB device number 17 using dummy_hcd
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
usb 6-1: new high-speed USB device number 17 using dummy_hcd
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 152fc83c1caf10d9 ]---
RIP: 0010:__list_add_valid.cold+0x3a/0x3c lib/list_debug.c:26
Code: 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 80 94 b3 8e e8 69 e7 e9 fd 0f  
0b 48 89 f1 48 c7 c7 00 94 b3 8e 4c 89 e6 e8 55 e7 e9 fd <0f> 0b 48 89 ee  
48 c7 c7 a0 95 b3 8e e8 44 e7 e9 fd 0f 0b 4c 89 ea
RSP: 0018:ffff8880a846f110 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff8880a8672280 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b1e42 RDI: ffffed101508de14
RBP: ffff8880a52679a8 R08: 0000000000000075 R09: ffffed1015a04fc9
R10: ffffed1015a04fc8 R11: ffff8880ad027e47 R12: ffff8880a8672358
R13: ffff8880a4cde868 R14: ffff8880a52679b0 R15: ffff8880a8672358
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000958dc000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
