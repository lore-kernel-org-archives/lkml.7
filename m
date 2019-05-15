Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE2C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEOMhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:37:09 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:45043 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:37:06 -0400
Received: by mail-it1-f197.google.com with SMTP id o83so2119686itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Um6hw8hBGXgCPx6XZYqYlQRzMuNmq+VPUEg+UyeKdOU=;
        b=OTyx4BoK/IveTxOKSU4EY8L5eFYtyWNIC6peHY9wjoSv/NrZO4QBf4REE0Rvb+gWlx
         aS1UerdVwGAsJ1yex/QEZt7i6n06JycuLpc3LUjC5VemIdo9YprgsBzvDc1fiDmlAEqb
         dGjtU/LL85YL84CaPabMd31jNcjpu08iQgeRxbR/mjHApBD7/sJAGVIguYQe1DqDq1M+
         3pzOm20Q1YCoAMq27GXbFIpEhmp9E59KOtyyU3/BKF7Vbwyi7UIrtskM0niJ0+TO11Yr
         IQvKGrJ/dWHn7HiW4UWb0c7mrJKhvE4Z+37V+shH+w42raVo6EW27Ne6fZuZ30A092Kr
         w8kw==
X-Gm-Message-State: APjAAAVr6RXV76OwaGmYazPfqoqEGkGbJ8AV8WSTNsIwSNHHNRYgNt71
        QenjepGcWk0xNt5s+MtqvHD1nkXSvdjOoS2Fu+drpq8ZKFbt
X-Google-Smtp-Source: APXvYqz02U66bDiemG1ALu+P9t2rwzcqeJwB/+UZKK1UHE1ABE5xEINQrWGur2jbunz6h7tcj5uaFqfYtcN3Jfkc6EMk4TH7q3D/
MIME-Version: 1.0
X-Received: by 2002:a24:e10c:: with SMTP id n12mr7435870ith.89.1557923825542;
 Wed, 15 May 2019 05:37:05 -0700 (PDT)
Date:   Wed, 15 May 2019 05:37:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003587e80588ec68bf@google.com>
Subject: WARNING in snd_info_free_entry
From:   syzbot <syzbot+131dee8780c719bc6afb@syzkaller.appspotmail.com>
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

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=16ae9974a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95aff7278e7ff25e
dashboard link: https://syzkaller.appspot.com/bug?extid=131dee8780c719bc6afb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173f3574a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+131dee8780c719bc6afb@syzkaller.appspotmail.com

snd_usb_toneport 6-1:0.0: set_interface failed
snd_usb_toneport 6-1:0.0: Line 6 POD Studio UX2 now disconnected
------------[ cut here ]------------
list_del corruption. prev->next should be ffff8881d13fa728, but was  
ffff8881d82ebd68
WARNING: CPU: 1 PID: 1477 at lib/list_debug.c:51  
__list_del_entry_valid+0x101/0x170 lib/list_debug.c:51
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1477 Comm: kworker/1:2 Not tainted 5.1.0-rc3+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x5e1 kernel/panic.c:214
  __warn.cold+0x20/0x53 kernel/panic.c:571
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__list_del_entry_valid+0x101/0x170 lib/list_debug.c:51
Code: c4 08 31 c0 41 5c 41 5d c3 4c 89 e2 48 c7 c7 20 f7 d8 85 e8 1c 2a 35  
ff 0f 0b 31 c0 eb c6 48 c7 c7 80 f7 d8 85 e8 0a 2a 35 ff <0f> 0b 31 c0 eb  
b4 48 c7 c7 e0 f7 d8 85 e8 f8 29 35 ff 0f 0b 31 c0
RSP: 0018:ffff8881d7a1f078 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881d13fa630 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127bbcd RDI: ffffed103af43e01
RBP: ffff8881d13fa640 R08: ffff8881d7a10000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881d13fad68
R13: ffff8881d7f1d858 R14: ffff8881d13fa630 R15: ffff8881d13fa718
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  snd_info_free_entry+0x132/0x340 sound/core/info.c:795
  snd_info_card_free+0x3e/0x80 sound/core/info.c:606
  snd_card_do_free sound/core/init.c:469 [inline]
  release_card_device+0x63/0xd0 sound/core/init.c:156
  device_release+0x78/0x210 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put+0x17d/0x270 lib/kobject.c:708
  put_device+0x1c/0x30 drivers/base/core.c:2205
  snd_card_free_when_closed+0x35/0x50 sound/core/init.c:493
  line6_disconnect.cold+0xa3/0xbc sound/usb/line6/driver.c:833
  line6_probe+0xb1e/0x1140 sound/usb/line6/driver.c:799
  usb_probe_interface+0x30d/0x7b0 drivers/usb/core/driver.c:361
  really_probe+0x296/0x680 drivers/base/dd.c:509
  driver_probe_device+0xf9/0x200 drivers/base/dd.c:671
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:778
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x21e/0x360 drivers/base/dd.c:844
  bus_probe_device+0x1ec/0x2a0 drivers/base/bus.c:514
  device_add+0xaf4/0x1700 drivers/base/core.c:2106
  usb_set_configuration+0xdf2/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xa8/0x110 drivers/usb/core/driver.c:266
  really_probe+0x296/0x680 drivers/base/dd.c:509
  driver_probe_device+0xf9/0x200 drivers/base/dd.c:671
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:778
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x21e/0x360 drivers/base/dd.c:844
  bus_probe_device+0x1ec/0x2a0 drivers/base/bus.c:514
  device_add+0xaf4/0x1700 drivers/base/core.c:2106
  usb_new_device.cold+0x8b8/0x1030 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ac9/0x35a0 drivers/usb/core/hub.c:5432
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x30e/0x420 kernel/kthread.c:253
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
