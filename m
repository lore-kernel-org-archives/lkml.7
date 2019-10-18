Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE097CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E9E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634207AbfJROxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:53:09 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:43102 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394114AbfJROxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:53:08 -0400
Received: by mail-il1-f198.google.com with SMTP id g18so1945229ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=31JpFUUMI0833veX6/3Xc4Ad9JSME0v2pnvL2+iC+c4=;
        b=mzKZdRA1X3BCl3zSw5hc62W4FNJgzU2GDAbyCNacI8v1djECgqEl0MtmMljSy1f+Kr
         dnaSXDBbVqa/Km16QyzgQhDermYiemFaj20qrGYpAMucpQ/pDy0Qq3Ws6NsNZmZAPeJO
         mwZTYE9Mno8LugKockLedDkh0y4W4ewUlrhNCzShtVSL9MxTnaa1C28p1AUGHNFASLgo
         +LqkSBF+mYgV8FMETbIxuN6sCEE5xPJ+xASjBmylTEMpIYmh4HXPk+Y5rkj++vkbUNfU
         JhftQSRiQ1qxkxt2CKdL9rVv9V9b/ludSy/Q8jc/Xg8N6/gZZ9s/9hpAA0Xp8WEGnGe0
         TnmQ==
X-Gm-Message-State: APjAAAUZadDAW28pr5LqRH+mckUyODEF3Pn2/OwmYkKOc8a7Zt6FUH9G
        5m4fa0FCk+Z9JWsOrvfr53wSDjImvaVadOulfM2VpsdanCn/
X-Google-Smtp-Source: APXvYqxGQTNch575ai9m61k+pTwl8d6bwf490DFw6FEpqQGZLepdk8vXWI8VRroFbzwisUElwi3WxNHFDB8UZZCXkXNLIOVslF6s
MIME-Version: 1.0
X-Received: by 2002:a92:88cf:: with SMTP id m76mr10823165ilh.40.1571410387414;
 Fri, 18 Oct 2019 07:53:07 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:53:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f036110595307db3@google.com>
Subject: KMSAN: uninit-value in ld_usb_read (2)
From:   syzbot <syzbot+fd49690bb45caaacf578@syzkaller.appspotmail.com>
To:     enric.balletbo@collabora.com, glider@google.com,
        gregkh@linuxfoundation.org, johan@kernel.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lkundrak@v3.sk, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c2453450 kmsan: kcov: prettify the code unpoisoning area->..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12d6dc5f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3684f3c73f43899a
dashboard link: https://syzkaller.appspot.com/bug?extid=fd49690bb45caaacf578
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c63d7600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1180adab600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fd49690bb45caaacf578@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ld_usb_read+0x870/0xc50  
drivers/usb/misc/ldusb.c:487
CPU: 1 PID: 12745 Comm: syz-executor511 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x14a/0x2f0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x73/0xf0 mm/kmsan/kmsan_instr.c:245
  ld_usb_read+0x870/0xc50 drivers/usb/misc/ldusb.c:487
  __vfs_read+0x1a9/0xc90 fs/read_write.c:425
  vfs_read+0x359/0x6f0 fs/read_write.c:461
  ksys_read+0x265/0x430 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read+0x92/0xb0 fs/read_write.c:595
  __x64_sys_read+0x4a/0x70 fs/read_write.c:595
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4418a9
Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd63549848 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004418a9
RDX: 0000000000000002 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00000000006cc018 R08: 000000000000000f R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402600
R13: 0000000000402690 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags+0x3f/0x90 mm/kmsan/kmsan.c:150
  kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:364 [inline]
  kmsan_alloc_page+0x153/0x370 mm/kmsan/kmsan_shadow.c:393
  __alloc_pages_nodemask+0x149d/0x60c0 mm/page_alloc.c:4794
  alloc_pages_current+0x68d/0x9a0 mm/mempolicy.c:2188
  alloc_pages include/linux/gfp.h:511 [inline]
  kmalloc_order mm/slab_common.c:1303 [inline]
  kmalloc_order_trace+0x94/0x3f0 mm/slab_common.c:1319
  kmalloc_large include/linux/slab.h:485 [inline]
  __kmalloc+0x2e6/0x430 mm/slub.c:3825
  kmalloc_array+0x86/0x110 include/linux/slab.h:618
  ld_usb_probe+0x64f/0x1460 drivers/usb/misc/ldusb.c:697
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
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
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
