Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5910C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD6A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439939AbfIWObS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:31:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41253 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439904AbfIWObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:31:10 -0400
Received: by mail-io1-f70.google.com with SMTP id q18so1403821ios.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 07:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TCANX9Z4wqakA7+UgGz6KKJIG/CHv0FeIjT+3p5HhKI=;
        b=Uew230xVh+JwXx1N5j7RcadV4nALTRpHhwmEUJw4GHoU2wTbquoHD/WGFvUJ+ZyP7A
         sjACABXcQRIE4oRiZG+lEKOhitYhSJznLzZ3ssQQYNbnFESUupY1gYaIu4mImSeXj16J
         35NOAiNNDYX9RDnOjTVeCfux72iMUdemNrmwGVOggsJ/BszlL4CIL1DtkWeUSoWh/iFo
         DBxULSFVxe+Da74wyC/S9BNsj27SyIoPRrwdaEKEfEHQPlLJIIB8tUx8d6xmlElk3yVq
         xub2lrG8UT9L/26i6wM5LJpR9h1jtH2GAAU9iHwmt4af+IjlNS1u4gyAqkNdUVL+6eF9
         jtJA==
X-Gm-Message-State: APjAAAU/Dq5r/+x9qy1dSXs5bFoNL86QXhkI+ZoMkKhonmrKwFsZfsqG
        uzfimOa5H2z/giRtrsdaeHw/kAttGDW2m5Xu1ojwS8K9FOTp
X-Google-Smtp-Source: APXvYqxJB3A4CIAcZ0gXoycjwMtanAhME82UMq8Vx+DjKRi8rmsg74ML/WkN4zLN0J3r++Yn9e7IcQH1GwWFupByGTS0xoGX9nxw
MIME-Version: 1.0
X-Received: by 2002:a6b:254:: with SMTP id 81mr19072860ioc.17.1569249068351;
 Mon, 23 Sep 2019 07:31:08 -0700 (PDT)
Date:   Mon, 23 Sep 2019 07:31:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000488dd305933945d2@google.com>
Subject: WARNING in _chaoskey_fill/usb_submit_urb
From:   syzbot <syzbot+f5349b421c6213d34ce2@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1452c6a1600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=f5349b421c6213d34ce2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16342d45600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166769b1600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f5349b421c6213d34ce2@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 00000000052bee21 submitted while active
WARNING: CPU: 1 PID: 1794 at drivers/usb/core/urb.c:362  
usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1794 Comm: syz-executor305 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2a3/0x6da kernel/panic.c:219
  __warn.cold+0x20/0x4a kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
Code: 89 de e8 92 5b ee fd 84 db 0f 85 42 f6 ff ff e8 55 5a ee fd 4c 89 fe  
48 c7 c7 00 c2 18 86 c6 05 f3 cf 38 04 01 e8 f4 e5 c3 fd <0f> 0b e9 20 f6  
ff ff c7 44 24 14 01 00 00 00 e9 d7 f6 ff ff 41 bd
RSP: 0018:ffff8881d0427b68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128d9ad RDI: ffffed103a084f5f
RBP: ffff8881d070b180 R08: ffff8881d4934800 R09: ffffed103b663ee7
R10: ffffed103b663ee6 R11: ffff8881db31f737 R12: ffff8881d070b180
R13: 00000000fffffff0 R14: 0000000000000000 R15: ffff8881d5c22400
  _chaoskey_fill.part.0+0xe0/0x470 drivers/usb/misc/chaoskey.c:367
  _chaoskey_fill+0x1ad/0x230 drivers/usb/misc/chaoskey.c:361
  chaoskey_read+0x2c2/0x4c0 drivers/usb/misc/chaoskey.c:434
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x127/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4419c9
Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc317ed1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004419c9
RDX: 0000000000000009 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 000000000000e12e R08: 000000000000000f R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402720
R13: 00000000004027b0 R14: 0000000000000000 R15: 0000000000000000
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
