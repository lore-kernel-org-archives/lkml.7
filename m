Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED872070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfHFFXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:23:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:49548 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbfHFFXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:23:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x765NT8l016523;
        Tue, 6 Aug 2019 00:23:30 -0500
Message-ID: <992921b294b8080f2512dd2b80f6b4ba2dc127c4.camel@kernel.crashing.org>
Subject: Re: WARNING in kernfs_new_node
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     syzbot <syzbot+499aea72daa2cea73cb7@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
Date:   Tue, 06 Aug 2019 15:23:29 +1000
In-Reply-To: <000000000000e15ee0058f5dfa81@google.com>
References: <000000000000e15ee0058f5dfa81@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 05:38 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:

A fix for that was submitted recently by Muchun Song <smuchun@gmail.com
> and should be queued up by Greg.

Cheers,
Ben.

> HEAD commit:    1e78030e Merge tag 'mmc-v5.3-rc1' of
> git://git.kernel.org/..
> git tree:       upstream
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=12aab5cc600000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=e397351d2615e10
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=499aea72daa2cea73cb7
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=111d80fc600000
> C reproducer:   
> https://syzkaller.appspot.com/x/repro.c?x=14d9060c600000
> 
> The bug was bisected to:
> 
> commit 726e41097920a73e4c7c33385dcc0debb1281e18
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Jul 10 00:29:10 2018 +0000
> 
>      drivers: core: Remove glue dirs from sysfs earlier
> 
> bisection log:  
> https://syzkaller.appspot.com/x/bisect.txt?x=138b41ec600000
> final crash:    
> https://syzkaller.appspot.com/x/report.txt?x=104b41ec600000
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=178b41ec600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the
> commit:
> Reported-by: syzbot+499aea72daa2cea73cb7@syzkaller.appspotmail.com
> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs
> earlier")
> 
> debugfs: Directory 'hci3' with parent 'bluetooth' already present!
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9903 at fs/kernfs/dir.c:493 kernfs_get  
> fs/kernfs/dir.c:493 [inline]
> WARNING: CPU: 0 PID: 9903 at fs/kernfs/dir.c:493  
> kernfs_new_node+0x155/0x180 fs/kernfs/dir.c:700
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 9903 Comm: syz-executor126 Not tainted 5.3.0-rc2+ #59
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
>   panic+0x29b/0x7d9 kernel/panic.c:219
>   __warn+0x22f/0x230 kernel/panic.c:576
>   report_bug+0x190/0x290 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
> RIP: 0010:kernfs_get fs/kernfs/dir.c:493 [inline]
> RIP: 0010:kernfs_new_node+0x155/0x180 fs/kernfs/dir.c:700
> Code: d2 ff 4c 89 23 4c 89 f0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3  
> e8 69 47 98 ff 48 c7 c7 6d b9 7a 88 31 c0 e8 9e a6 80 ff <0f> 0b eb
> 8e 44  
> 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 67 ff ff ff 4c
> RSP: 0018:ffff88808d96f6f0 EFLAGS: 00010246
> RAX: 0000000000000024 RBX: 0000000000000000 RCX: d31929014df6e300
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffff88808d96f728 R08: ffffffff816068e4 R09: fffffbfff11fbdfd
> R10: fffffbfff11fbdfd R11: 0000000000000000 R12: ffff88809377b620
> R13: ffff8880982858c0 R14: ffff888095d39460 R15: ffff88821b70d150
>   kernfs_create_dir_ns+0x44/0x130 fs/kernfs/dir.c:1022
>   sysfs_create_dir_ns+0x161/0x310 fs/sysfs/dir.c:59
>   create_dir lib/kobject.c:89 [inline]
>   kobject_add_internal+0x459/0xd50 lib/kobject.c:255
>   kobject_add_varg lib/kobject.c:390 [inline]
>   kobject_add+0x138/0x200 lib/kobject.c:442
>   device_add+0x508/0x1570 drivers/base/core.c:2065
>   hci_register_dev+0x331/0x720 net/bluetooth/hci_core.c:3307
>   __vhci_create_device drivers/bluetooth/hci_vhci.c:124 [inline]
>   vhci_create_device+0x2f3/0x530 drivers/bluetooth/hci_vhci.c:148
>   vhci_get_user drivers/bluetooth/hci_vhci.c:204 [inline]
>   vhci_write+0x3ac/0x440 drivers/bluetooth/hci_vhci.c:284
>   call_write_iter include/linux/fs.h:1870 [inline]
>   new_sync_write fs/read_write.c:483 [inline]
>   __vfs_write+0x617/0x7d0 fs/read_write.c:496
>   vfs_write+0x275/0x590 fs/read_write.c:558
>   ksys_write+0x16b/0x2a0 fs/read_write.c:611
>   __do_sys_write fs/read_write.c:623 [inline]
>   __se_sys_write fs/read_write.c:620 [inline]
>   __x64_sys_write+0x7b/0x90 fs/read_write.c:620
>   do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x441d39
> Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff  
> ff 0f 83 db 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd7e3026c8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441d39
> RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007ffdbb1414ac R09: 00007ffdbb1414ac
> R10: 00007ffdbb1414ac R11: 0000000000000246 R12: 0000000000014cb3
> R13: 0000000000402a30 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

