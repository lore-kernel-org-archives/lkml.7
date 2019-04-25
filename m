Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F00C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6824206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfDYWQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:16:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56594 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfDYWQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:16:06 -0400
Received: by mail-io1-f72.google.com with SMTP id s184so1147369iod.23
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 15:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=R+ggdNsXuoQ3Cj3CcJ/qJ96u8p1Y9O8+GCH7BMvWhmM=;
        b=UxlxKdY4/443FLIb1btmP/IJ+h7SaQxt7raSkfVcM7WI6xH8nNdw2q3WBrj8aZSTtK
         usBRWB/J4whuiMv+faN71k2X4gmUxWhrn8XN8fKNgQhu4MHq2jGLB2w1031oCnhqcZRj
         LJ0uHxV6XwGBzfrmxkjvvAGM61hjNeW8sRHPSfKh4OLOHFdgBfFnp+5IXWY7Y6KjkR4h
         eaEbXe2SAMapFUg+0EwKPTQDusF2EZikhAL6nBYjBLHDChZZlUntgB2AQTayM8xUHmot
         aj3URNYsN/82JFX+U0WvTEIpBihIxei8n81IaZQDJZPkWkU3J/p/A1KSbsyK1KuPuolz
         0bjw==
X-Gm-Message-State: APjAAAVOSlHf9EqQ0HZgIz2B1s5yhjN6/w6p9HcowWf3mpoEqEYSmFrT
        0aCKqy5wdWaTvZF/e86J+B/ZKVFAKYqV/9BKYNf0r9nyiG7C
X-Google-Smtp-Source: APXvYqwMGR0J0P88P5qPypdcoJb2sS7tVqxKlPieXVz44f2R12afyrcMP9AAOuzRKQAGtV85ea16zYzT6cB09Gn3YdyEfjrUPaQi
MIME-Version: 1.0
X-Received: by 2002:a02:52c4:: with SMTP id d187mr4042952jab.98.1556230564804;
 Thu, 25 Apr 2019 15:16:04 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:16:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000101b30587622a69@google.com>
Subject: BUG: unable to handle page fault for address = ADDR
From:   syzbot <syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com,
        gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, peter@hurleysoftware.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        vegard.nossum@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c392798a Add linux-next specific files for 20190424
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14772c42a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37a4076eb047eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=45474c076a4927533d2e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1369c242a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ee2e88a00000

The bug was bisected to:

commit bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Wed Apr 25 11:12:31 2018 +0000

     tty: Use __GFP_NOFAIL for tty_ldisc_get()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157d9014a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=177d9014a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=137d9014a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com
Fixes: bcdd0ca8cb87 ("tty: Use __GFP_NOFAIL for tty_ldisc_get()")

  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441149
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffd8ae1c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441149
RDX: 0000000020000140 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007fffd8ae1c50 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
BUG: unable to handle page fault for address = fffffffffffffff4
#PF: supervisor-privileged read access from kernel code
#PF: error_code(0x0000) - not-present page
PGD 8870067 P4D 8870067 PUD 8872067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7949 Comm: syz-executor714 Not tainted 5.1.0-rc6-next-20190424  
#30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:slhc_free+0x31/0xb0 drivers/net/slip/slhc.c:159
Code: 54 49 89 fc e8 c0 b3 15 fd 4d 85 e4 74 77 e8 b6 b3 15 fd 4c 89 e2 48  
b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 6d <4d> 8b 2c 24 4d  
85 ed 74 0d e8 91 b3 15 fd 4c 89 ef e8 09 5b 4e fd
RSP: 0018:ffff8880a3e7f9f0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 1ffff1101426e1c6
RDX: 1ffffffffffffffe RSI: ffffffff845b7bea RDI: fffffffffffffff4
RBP: ffff8880a3e7fa00 R08: ffff8880a1370540 R09: ffff8880a1370e30
R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffffffff4
R13: ffff88809f531040 R14: 00000000ffffff97 R15: ffff8880a3dff2c0
FS:  0000555556f4d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 000000008b56d000 CR4: 00000000001406e0
Call Trace:
  sl_alloc_bufs drivers/net/slip/slip.c:196 [inline]
  slip_open+0xe16/0x1138 drivers/net/slip/slip.c:821
  tty_ldisc_open.isra.0+0x8b/0xe0 drivers/tty/tty_ldisc.c:469
  tty_set_ldisc+0x2d7/0x690 drivers/tty/tty_ldisc.c:596
  tiocsetd drivers/tty/tty_io.c:2332 [inline]
  tty_ioctl+0x5dc/0x15c0 drivers/tty/tty_io.c:2592
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441149
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffd8ae1c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441149
RDX: 0000000020000140 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007fffd8ae1c50 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: fffffffffffffff4
---[ end trace c314d2d667c67584 ]---
RIP: 0010:slhc_free+0x31/0xb0 drivers/net/slip/slhc.c:159
Code: 54 49 89 fc e8 c0 b3 15 fd 4d 85 e4 74 77 e8 b6 b3 15 fd 4c 89 e2 48  
b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 6d <4d> 8b 2c 24 4d  
85 ed 74 0d e8 91 b3 15 fd 4c 89 ef e8 09 5b 4e fd
RSP: 0018:ffff8880a3e7f9f0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 1ffff1101426e1c6
RDX: 1ffffffffffffffe RSI: ffffffff845b7bea RDI: fffffffffffffff4
RBP: ffff8880a3e7fa00 R08: ffff8880a1370540 R09: ffff8880a1370e30
R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffffffff4
R13: ffff88809f531040 R14: 00000000ffffff97 R15: ffff8880a3dff2c0
FS:  0000555556f4d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 000000008b56d000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
