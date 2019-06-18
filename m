Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1883C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B540C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfFRKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:47:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46589 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfFRKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:47:12 -0400
Received: by mail-io1-f72.google.com with SMTP id s83so15700189iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gHzykhLyURoFKT1pq/w3sNIfGq6/+4DcJMWUYaCquEY=;
        b=Q73sZsbmSUKmmd+qUBAEm45Y1n63Me5JHTrTscBsmZFyw2mhQTCU77w0X0pfeF4bGf
         O9CdDW0owsaKvkA3AtjCq3oPnaC1J4V9npTvfrVIj6q8DG1pwNE1ctI7jYDIVtQxWTJn
         /pEQK9a8U0/M4N3lHbBySLnxuMflt2WXGu6xA0nxf4PhKeKKYrEf2NISXMX5AAinoojq
         tLjlzWvfdrh9q/PJeZ/RJ7o1qWgdYrA5xDVGL6oKgXZiDiwQxf8kzvk5+mdFxhZP1RJG
         Bm8TOHme5KF0R2ch2tfb9wTFHH5VkoJre4CYYZLwuYHB4ZHTxxqGoLkkYZ48p2K/D9Iz
         iKMg==
X-Gm-Message-State: APjAAAVvpZLdc3u/QNMGiKVbZOsPdY5xYP9ZCptkKs9Tn7DMUZeGtayK
        EqFe3va8yHTtYCq3JvQrzfaW+aPjUt5CCapuXTz5uDoMIras
X-Google-Smtp-Source: APXvYqxc2KOzp09IzjMJdteVZFwTlHKZGi30ar+Yo7vYWWu+3gc+SAZu47Fgd/o2HljMB+Ra6c3A2NzJeehtvN6lgwlAK5ljFyrz
MIME-Version: 1.0
X-Received: by 2002:a02:3b62:: with SMTP id i34mr3028908jaf.91.1560854830426;
 Tue, 18 Jun 2019 03:47:10 -0700 (PDT)
Date:   Tue, 18 Jun 2019 03:47:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6b25b058b96d5c3@google.com>
Subject: kernel BUG at drivers/android/binder_alloc.c:LINE! (4)
From:   syzbot <syzbot+3ae18325f96190606754@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e0babf2 Linux 5.2-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159e6121a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16883d6c7f0d717
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae18325f96190606754
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1119e431a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f028c9a00000

The bug was bisected to:

commit bde4a19fc04f5f46298c86b1acb7a4af1d5f138d
Author: Todd Kjos <tkjos@android.com>
Date:   Fri Feb 8 18:35:20 2019 +0000

     binder: use userspace pointer as base of buffer space

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177250c9a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14f250c9a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f250c9a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ae18325f96190606754@syzkaller.appspotmail.com
Fixes: bde4a19fc04f ("binder: use userspace pointer as base of buffer  
space")

------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:1130!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8920 Comm: syz-executor933 Not tainted 5.2.0-rc5 #54
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1130
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 bf 9d 1c fc 4c 89  
e6 4c 89 ef e8 d4 9e 1c fc 4d 39 e5 76 07 e8 aa 9d 1c fc <0f> 0b e8 a3 9d  
1c fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 b1
RSP: 0018:ffff88808b91f4e0 EFLAGS: 00010293
RAX: ffff88809296c200 RBX: 0000000020001000 RCX: ffffffff855423cf
RDX: 0000000000000000 RSI: ffffffff855423b6 RDI: 0000000000000006
RBP: ffff88808b91f560 R08: ffff88809296c200 R09: 0000000000000008
R10: ffffed1011723f15 R11: ffff88808b91f8af R12: 0000000000000078
R13: 0000000000000008 R14: 00000000000000e8 R15: 0000000000000000
FS:  00005555556e5940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000008bd57000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  binder_alloc_copy_from_buffer+0x37/0x42 drivers/android/binder_alloc.c:1176
  binder_validate_ptr+0xcc/0x1d0 drivers/android/binder.c:2124
  binder_transaction+0x2c9c/0x6620 drivers/android/binder.c:3308
  binder_thread_write+0x64a/0x2820 drivers/android/binder.c:3794
  binder_ioctl_write_read drivers/android/binder.c:4827 [inline]
  binder_ioctl+0x102f/0x1833 drivers/android/binder.c:5004
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444a29
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcbcd0fc28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcbcd0fc30 RCX: 0000000000444a29
RDX: 0000000020000440 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000401310
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402730
R13: 00000000004027c0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 3626e6aef2ad2274 ]---
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1130
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 bf 9d 1c fc 4c 89  
e6 4c 89 ef e8 d4 9e 1c fc 4d 39 e5 76 07 e8 aa 9d 1c fc <0f> 0b e8 a3 9d  
1c fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 b1
RSP: 0018:ffff88808b91f4e0 EFLAGS: 00010293
RAX: ffff88809296c200 RBX: 0000000020001000 RCX: ffffffff855423cf
RDX: 0000000000000000 RSI: ffffffff855423b6 RDI: 0000000000000006
RBP: ffff88808b91f560 R08: ffff88809296c200 R09: 0000000000000008
R10: ffffed1011723f15 R11: ffff88808b91f8af R12: 0000000000000078
R13: 0000000000000008 R14: 00000000000000e8 R15: 0000000000000000
FS:  00005555556e5940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000008bd57000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
