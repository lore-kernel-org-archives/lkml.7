Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CCAC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2993F216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGIM1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:27:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55100 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfGIM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:27:08 -0400
Received: by mail-io1-f71.google.com with SMTP id n8so22824303ioo.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hGo8EbEA3ZKfqUVxyvabXM+z4gyY4A3JpCgTFSwOIxY=;
        b=NjJjiGZlWXgcNUmDOhLUEZBWSsWkPxo/M3nwKnDkBbluGSc5/Kj1WTCyfF4WwK6zjJ
         dMiC0szWPKAF+67QClr+c6HXCJy0BKN4x8R3cskIXstOqNXS1xBwm5b55cNeuihlgWEw
         TaiitxTYabpgoA2qpxraAwa2g5OqmOJOMBb7RmqbxwqHGfADwHiINaXhDswNYxd/JYV6
         9uBc5z19KWA2sBeStmGe0hJ+2ernq7+MqTw367Q8OLs06UtzQf0m7ARsj+wccvhQu6uH
         yGSZdSF0t/5/Z9Ac5qdc2RL2Ti52huiu6Ew+SzQSydfr2FmoWjAK2RhSFvlbyDtvgcb/
         2+Lg==
X-Gm-Message-State: APjAAAW518U8Lsrxm6ZLi0VFmMwinZNsHrt9FHSjRWsu9R1auAxuOeq+
        feENol9/gydRQeOfa5ICuTCpj8xyrKuIRXFfDBTdX046fx8u
X-Google-Smtp-Source: APXvYqxfFL7rbB9NNuNdYve/wnQ+LnO/p1FfoKru10JjwRiTTBhM1RedITaDY+N8Dre9ohQuLEBEKe+9QOz+lFWoQJQqCKLl4a+D
MIME-Version: 1.0
X-Received: by 2002:a02:2245:: with SMTP id o66mr28683555jao.53.1562675227511;
 Tue, 09 Jul 2019 05:27:07 -0700 (PDT)
Date:   Tue, 09 Jul 2019 05:27:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5d567058d3eadcf@google.com>
Subject: general protection fault in vmk80xx_write_packet
From:   syzbot <syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com>
To:     abbotti@mev.co.uk, andreyknvl@google.com,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=126dd493a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=009f546aa1370056b1c2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1684570ba00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132c91f5a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com

usb 1-1: config 0 interface 160 has no altsetting 0
usb 1-1: New USB device found, idVendor=10cf, idProduct=5501,  
bcdDevice=eb.5b
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:vmk80xx_write_packet+0x75/0x260  
drivers/staging/comedi/drivers/vmk80xx.c:204
Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 d3 01 00 00 48 b8  
00 00 00 00 00 fc ff df 4c 8b 6b 68 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 4c  
89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 01 00 00
RSP: 0018:ffff8881d9eff1b0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8881d4f596c0 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff847cda93 RDI: ffff8881d4f59728
RBP: ffff8881cfc79900 R08: ffff8881d9e36000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881c5d84c80
R13: 0000000000000010 R14: 0000000000000000 R15: ffff8881d2690128
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c904c4000 CR3: 00000001d2b52000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vmk80xx_reset_device drivers/staging/comedi/drivers/vmk80xx.c:226 [inline]
  vmk80xx_auto_attach+0x13b1/0x17c0  
drivers/staging/comedi/drivers/vmk80xx.c:814
  comedi_auto_config+0x16e/0x250 drivers/staging/comedi/drivers.c:1067
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 8425c817ce1da187 ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
