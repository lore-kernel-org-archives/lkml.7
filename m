Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D01CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EAF204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGJqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:46:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41843 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEGJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:46:07 -0400
Received: by mail-io1-f71.google.com with SMTP id e126so12495491ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bUKLka2BOSW/BgrBEF3A6hgNxIuhqDQ3ifedm4RG0c0=;
        b=B5fkExXz5tNou8LIf0waDBAIDaSfi/pVifSfZCP7pSqtdZ+NtHHXBfk+LKIm8O6+LG
         /iSWRedNmSkommZcGX+8GZ1Po/dH5OFwmbfAT/SehCMQmFMAGJQrvzIeuFVy1SLSvjLo
         CjBO4VX4IBrQPHrfiQzLSFtK1gveloEvE2Nu34dEFbsm8N0Pwjg3OyE3cnha4tKgN0d/
         spf0Oy3iA3xdbOP60Fa6bLVJSGmRqa13BEiywGg3WwJs4kdJM5VriavbJZvX35juwMYp
         jShlamQ5ypbgYWijfPZ8DYXI1Mi3XjEK4n3LUjDlwWksXox7iLuIoGWCtS3iYEfqxMp+
         ABxQ==
X-Gm-Message-State: APjAAAVHuTEVVOkXeV/rOQb3qhx/VEe20Dbc+dL7nxacRjyGtB/jXm0v
        k/aqOMCuL0BoT3dxFsXi9l8LrsgPCyWASkrvm3VtVIyoo4vj
X-Google-Smtp-Source: APXvYqz/7wP9zE2tgMx6eS1yS/DqKoUIWAwDn3VCJnoA9si+Rr/ThUmIG5zYmYeLGuOsBFgZsCzFQ5QYRJ4E5TlMcpLpeE6bs1S6
MIME-Version: 1.0
X-Received: by 2002:a6b:7417:: with SMTP id s23mr3601143iog.2.1557222366467;
 Tue, 07 May 2019 02:46:06 -0700 (PDT)
Date:   Tue, 07 May 2019 02:46:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd5e300588491545@google.com>
Subject: WARNING in kernfs_activate
From:   syzbot <syzbot+1202f8882e4f4881d814@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c163f4c Linux 5.0
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ddfe4f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89bae6a2a56d8292
dashboard link: https://syzkaller.appspot.com/bug?extid=1202f8882e4f4881d814
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1202f8882e4f4881d814@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 9395 at fs/kernfs/dir.c:1267  
kernfs_activate+0xee/0x1f0 fs/kernfs/dir.c:1267
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9395 Comm: syz-executor.0 Not tainted 5.0.0 #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:kernfs_activate+0xee/0x1f0 fs/kernfs/dir.c:1267
Code: 42 80 3c 28 00 0f 85 09 01 00 00 49 8b 7c 24 38 48 89 de 48 89 7d d0  
e8 10 92 9d ff 48 8b 7d d0 48 39 df 75 07 e8 e2 90 9d ff <0f> 0b e8 db 90  
9d ff 49 8d 5c 24 04 be 04 00 00 00 48 89 df e8 99
RSP: 0018:ffff88804ac97818 EFLAGS: 00010216
RAX: 0000000000040000 RBX: ffff8880a4d543b8 RCX: ffffc90005deb000
RDX: 00000000000019dc RSI: ffffffff81d24e3e RDI: ffff8880a4d543b8
RBP: ffff88804ac97848 R08: ffff88804cbb6680 R09: fffffbfff115121d
R10: ffff88804ac97808 R11: ffffffff88a890e7 R12: ffff8880a4d54380
R13: dffffc0000000000 R14: ffff8880a4d54410 R15: ffff8880a4d54380
  kernfs_add_one+0x377/0x4d0 fs/kernfs/dir.c:813
  kernfs_create_dir_ns+0xff/0x160 fs/kernfs/dir.c:1031
  sysfs_create_dir_ns+0x131/0x2a0 fs/sysfs/dir.c:59
  create_dir lib/kobject.c:88 [inline]
  kobject_add_internal lib/kobject.c:247 [inline]
  kobject_add_internal.cold+0xe5/0x5d4 lib/kobject.c:217
  kobject_add_varg lib/kobject.c:382 [inline]
  kobject_add+0x150/0x1c0 lib/kobject.c:426
  device_add+0x3d5/0x1870 drivers/base/core.c:1912
  hci_register_dev+0x304/0x880 net/bluetooth/hci_core.c:3261
  __vhci_create_device+0x2d0/0x5a0 drivers/bluetooth/hci_vhci.c:139
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2d0/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1863 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x613/0x8e0 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc7eed28c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc7eed296d4
R13: 00000000004c749c R14: 00000000004dd0e8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
