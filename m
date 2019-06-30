Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3425C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69D4208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF3FlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50564 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3FlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:07 -0400
Received: by mail-io1-f69.google.com with SMTP id m26so11550694ioh.17
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 22:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZK+EGFyyaLs8zHzX8Fucqyg/8P+TjO5T0KN14v7SrV0=;
        b=mz1+USoqCGIlAmes8IvNkI6tiiSl7FHvtqjPMmh+Ykyd2Tp9rObiCGjzMq6Q+httO8
         nL4cDh0RcrwXjjOf4pJaQBQPPv6WR9gXhFwxe/ok93i6ShcHAR43jimFUDaDn5rmbjXY
         8jJ0Z5iTjagCiXnp7xB/iFk/KM0jiXZl/cEMae9M1OWNMHMSl+v/7gym38pJabuGfj7L
         gOObw8DNUnMAoy8gBIH89XcWXlfKVeo391qsDoZXo7Xx8RrIf/tEpA/g6HEaM905YU5v
         j2hdPlwZuZUxi/MLyqB/QKBWCnZsF5sXyYexPSvmEqHHPtQ0FHqhI1RBKChnYp6HPss+
         L8nQ==
X-Gm-Message-State: APjAAAXURVscluTBdrcuxy8ASx/oJm9yQ4wmWFVhcU4+UiXrHj1cGZOG
        uIM64ZNrbAz3+8Kq0+ZCxYIPCiO35m2AXCbqYXxzdIUVm27t
X-Google-Smtp-Source: APXvYqxiQ4vYpOMhwHBxxNdpHPkgyYdl+AQbIEF53NJQ4KR+MVk0M/x23iMe3Li6dlj1inPDWcF+h6nMCu1SgQ2W0onuUZPkwQA9
MIME-Version: 1.0
X-Received: by 2002:a5e:da47:: with SMTP id o7mr20036663iop.83.1561873266488;
 Sat, 29 Jun 2019 22:41:06 -0700 (PDT)
Date:   Sat, 29 Jun 2019 22:41:06 -0700
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bbf1b058c83f55a@google.com>
Subject: Re: WARNING in kernfs_create_dir_ns
From:   syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104d6755a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 8613 at fs/kernfs/dir.c:493 kernfs_get  
fs/kernfs/dir.c:493 [inline]
WARNING: CPU: 0 PID: 8613 at fs/kernfs/dir.c:493 kernfs_new_node  
fs/kernfs/dir.c:700 [inline]
WARNING: CPU: 0 PID: 8613 at fs/kernfs/dir.c:493  
kernfs_create_dir_ns+0x205/0x230 fs/kernfs/dir.c:1022
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8613 Comm: syz-executor696 Not tainted 5.2.0-rc6+ #11
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
RIP: 0010:kernfs_get fs/kernfs/dir.c:493 [inline]
RIP: 0010:kernfs_new_node fs/kernfs/dir.c:700 [inline]
RIP: 0010:kernfs_create_dir_ns+0x205/0x230 fs/kernfs/dir.c:1022
Code: ff 4c 89 ff e8 7c cd ff ff 4c 63 fb eb 05 e8 22 27 9a ff 4c 89 f8 48  
83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 0b 27 9a ff <0f> 0b e9 e9 fe  
ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c be fe ff
RSP: 0018:ffff88808d26f730 EFLAGS: 00010293
RAX: ffffffff81db8a95 RBX: ffff88809e5252a0 RCX: ffff88808a4aa000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88808d26f768 R08: ffffffff81db8977 R09: ffffed1013ca4a55
R10: ffffed1013ca4a55 R11: 1ffff11013ca4a54 R12: ffff888098a8a200
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880a339e620
  sysfs_create_dir_ns+0x161/0x300 fs/sysfs/dir.c:59
  create_dir lib/kobject.c:89 [inline]
  kobject_add_internal+0x459/0xd50 lib/kobject.c:255
  kobject_add_varg lib/kobject.c:390 [inline]
  kobject_add+0x138/0x200 lib/kobject.c:442
  device_add+0x508/0x1570 drivers/base/core.c:2062
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
RIP: 0033:0x441279
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffa3738588 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441279
RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000000ef5c R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401ff0
R13: 0000000000402080 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

