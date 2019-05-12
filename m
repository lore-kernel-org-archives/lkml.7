Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282DC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42E42133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfELJSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 05:18:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:38356 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfELJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:18:06 -0400
Received: by mail-it1-f198.google.com with SMTP id m20so4009501itn.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 02:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mqrdbMSQFi7W3aeSrTnSvNJE0HD4QWimkJ088nB5tww=;
        b=LUgYdw9P7+zFf1WrtPvkaRO4lIJ5p/d5nJWij4LmjXmQhrgmVgL2rb8eiJIhItL5Yh
         fv5FJeAA2PuPVCVFjPtprWZ5/erd5pf5qopJr44vtt8RwAN/OoMe3mFx5gE1TcV8TO+T
         cxukmo3px77foePvoYN4NRStfUkFvBb6aPAZbQdp7fnkDCASGKonyGKcXWKWbxvzzPqD
         v9pOVVDJJ9lCDzAGBf6trW2TCi4kL7cyCc0bkvjZnnKWrDxdWxJovuE1O2vM84rGTbnU
         eODvRVcSmpaK2O8QQiN5gM2qgUc2ruE2CY0cVDsN5xkpiiug/87KyPLywXmz6uKtRr7Q
         cjcQ==
X-Gm-Message-State: APjAAAXxdfCjfKcybnWuCQ9iD3ism/TnyBdSHJrnJuceHGXLTZ4+o7FP
        l4uz/I7WPYqug/Jtt8qCNy+qJBVv2hDQrvBfKr6kKOl3I6Xz
X-Google-Smtp-Source: APXvYqyBd1DJynayVg/cjXVcdTxDG/CH2Zjaz4vQSMLJQUY6MEtd1dK4RG0FWoP4QSRW6UbJY1gpYOUE+bs5KAQD2DSY4iARXXtL
MIME-Version: 1.0
X-Received: by 2002:a24:7b0a:: with SMTP id q10mr13805666itc.81.1557652685593;
 Sun, 12 May 2019 02:18:05 -0700 (PDT)
Date:   Sun, 12 May 2019 02:18:05 -0700
In-Reply-To: <0000000000003c6794058871e40a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000228020588ad47a1@google.com>
Subject: Re: general protection fault in sisusb_probe
From:   syzbot <syzbot+a0cbdbd6d169020c8959@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1222d274a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
dashboard link: https://syzkaller.appspot.com/bug?extid=a0cbdbd6d169020c8959
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1382e600a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174783f0a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a0cbdbd6d169020c8959@syzkaller.appspotmail.com

  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.1.0-rc3-319004-g43151d6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:dev_name include/linux/device.h:1087 [inline]
RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
Code: 89 f5 53 e8 8e 53 1c fc 48 85 ed 0f 84 c9 01 00 00 e8 80 53 1c fc 48  
8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74  
05 e8 41 68 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 53
RSP: 0018:ffff8880a84ff1c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffed101509fe40 RCX: ffffffff8980f1cb
RDX: 000000000000001e RSI: ffffffff855576f0 RDI: 00000000000000f0
RBP: 00000000000000a0 R08: ffff8880a84db100 R09: 0000000000000006
R10: ffff8880a84dba08 R11: ffff8880a84db100 R12: ffffffff8f031080
R13: ffff8880a84ff220 R14: ffff888090615500 R15: ffff88808c860000
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faa07b90000 CR3: 00000000a0896000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  _dev_err+0xdc/0x10e drivers/base/core.c:3251
  sisusb_probe+0x1c8/0xbd6 drivers/usb/misc/sisusbvga/sisusb.c:3035
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2023
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
Modules linked in:
---[ end trace 3af8db6f82d76f53 ]---
RIP: 0010:dev_name include/linux/device.h:1087 [inline]
RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
Code: 89 f5 53 e8 8e 53 1c fc 48 85 ed 0f 84 c9 01 00 00 e8 80 53 1c fc 48  
8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74  
05 e8 41 68 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 53
RSP: 0018:ffff8880a84ff1c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffed101509fe40 RCX: ffffffff8980f1cb
RDX: 000000000000001e RSI: ffffffff855576f0 RDI: 00000000000000f0
RBP: 00000000000000a0 R08: ffff8880a84db100 R09: 0000000000000006
R10: ffff8880a84dba08 R11: ffff8880a84db100 R12: ffffffff8f031080
R13: ffff8880a84ff220 R14: ffff888090615500 R15: ffff88808c860000
FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faa07b90000 CR3: 00000000a0896000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

