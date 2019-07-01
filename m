Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C80C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE74F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGATrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:47:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55292 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGATrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:47:07 -0400
Received: by mail-io1-f69.google.com with SMTP id n8so16173659ioo.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+vi2rGwfqicYHQDVv3C9HNJQo0eHOsAZ/tePHAmZZBI=;
        b=BbD7Zrx0fjl0kWygop9D1oA78Gw1YGEOpOT9NEylTOQ7M7okB7TT6a1kxA68W72S6C
         8XddHm3GAC1k8ofJsPHX3VT3f+4U0xDaKqb6/8gKoGwSF6//Kxed8eo80aU5wF79Q/SY
         QWgnp+D82gZTxPNYjSMU7ZZuJmTXZb7Li/dX3kCgitEuXUwFU8tPe0/fQ1wX5joQWtpW
         7kSMwbKZsGRR41bbTFz1x5yCxIlI6etlg4gk7yvx2dYftL6qfZmzWhWqndyLwinSOL6w
         QO4w9e/V4cbLuukATlmDHmwbYMHC5Y+r5/eY6BwQXzGwVBqiUxBLNiGpKq4MpyfuWz9G
         YX2g==
X-Gm-Message-State: APjAAAVUgc2R0w7QkJRptXIW/P6PQLo3tSA1mUO1s1blTpEb9DMuuqVR
        cLpm6wZ3L/WI9HY2M9qhBOrKx+XBm199RYH9ZdDSrF27IDOv
X-Google-Smtp-Source: APXvYqzMKirGFgF5PI99Li2mGxrqVMDGtUfLj7YkV1jy21295JJ/yIF2q2FrPttBLrDxi6wmrzevDOwzbMUfxmuMb9IVkWNc4AAH
MIME-Version: 1.0
X-Received: by 2002:a5d:9957:: with SMTP id v23mr2558842ios.117.1562010426478;
 Mon, 01 Jul 2019 12:47:06 -0700 (PDT)
Date:   Mon, 01 Jul 2019 12:47:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b1944058ca3e4a8@google.com>
Subject: WARNING: refcount bug in kobject_add_internal
From:   syzbot <syzbot+32259bb9bc1a487ad206@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6fbc7275 Linux 5.2-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120e0fc5a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bff6583efcfaed3f
dashboard link: https://syzkaller.appspot.com/bug?extid=32259bb9bc1a487ad206
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115bad39a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1241bdd5a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+32259bb9bc1a487ad206@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 8294 at lib/refcount.c:156  
refcount_inc_checked+0x4b/0x50 lib/refcount.c:156
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8294 Comm: syz-executor086 Not tainted 5.2.0-rc7 #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x28a/0x7c9 kernel/panic.c:219
  __warn+0x216/0x220 kernel/panic.c:576
  report_bug+0x190/0x290 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x450 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:refcount_inc_checked+0x4b/0x50 lib/refcount.c:156
Code: 3d a7 68 7a 05 01 75 08 e8 42 47 16 fe 5b 5d c3 e8 3a 47 16 fe c6 05  
91 68 7a 05 01 48 c7 c7 c1 4d 66 88 31 c0 e8 25 19 e8 fd <0f> 0b eb df 90  
55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0
RSP: 0018:ffff88809fa9f7f0 EFLAGS: 00010246
RAX: 5c3359f64ee59e00 RBX: ffff88821ae62bf8 RCX: ffff88808682c6c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88809fa9f7f8 R08: ffffffff815e87d4 R09: ffffed1015d66063
R10: ffffed1015d66063 R11: 1ffff11015d66062 R12: ffff88809ec74480
R13: 1ffff11013d8e890 R14: dffffc0000000000 R15: ffff88821ae62bf8
  kref_get include/linux/kref.h:45 [inline]
  kobject_get lib/kobject.c:642 [inline]
  kset_get include/linux/kobject.h:214 [inline]
  kobj_kset_join lib/kobject.c:194 [inline]
  kobject_add_internal+0x8c4/0xd50 lib/kobject.c:246
  kobject_add_varg lib/kobject.c:390 [inline]
  kobject_add+0x138/0x200 lib/kobject.c:442
  class_dir_create_and_add drivers/base/core.c:1732 [inline]
  get_device_parent+0x48b/0x4e0 drivers/base/core.c:1787
  device_add+0x3d6/0x1570 drivers/base/core.c:2048
  hci_register_dev+0x331/0x6c0 net/bluetooth/hci_core.c:3305
  __vhci_create_device drivers/bluetooth/hci_vhci.c:124 [inline]
  vhci_create_device+0x2d1/0x510 drivers/bluetooth/hci_vhci.c:148
  vhci_get_user drivers/bluetooth/hci_vhci.c:204 [inline]
  vhci_write+0x3ac/0x440 drivers/bluetooth/hci_vhci.c:284
  call_write_iter include/linux/fs.h:1872 [inline]
  new_sync_write fs/read_write.c:483 [inline]
  __vfs_write+0x617/0x7d0 fs/read_write.c:496
  vfs_write+0x227/0x510 fs/read_write.c:558
  ksys_write+0x16b/0x2a0 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x7b/0x90 fs/read_write.c:620
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441289
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe62540878 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441289
RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000000e96e R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000402000
R13: 0000000000402090 R14: 0000000000000000 R15: 0000000000000000
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
