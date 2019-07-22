Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9741C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18C321901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfGVOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:38:15 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35447 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfGVOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:38:12 -0400
Received: by mail-io1-f71.google.com with SMTP id w17so43701485iom.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 07:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gclH8SjlGVaXZ8MiEVnGVxaFR3oQRJMnGwfA2wtuZ6I=;
        b=na2Ag7Ch5KC9N8LWBjjSx2S81giHUmEqWdPpDQT+M4GII1Vu3Yh9ER8/HAqgu8Rrjz
         AamYz2WqB4HGzJ1QESL/a/z35l1Ja6xPJLqDJ+UEyCbXRpvmlyHPgpwASn4A3VwRA0Ia
         oU+JF+UpPet4QciV86+KIpQyxeiw048r3HazsKG/OivEppHGw6icSbujahOT70WuplqH
         2UZwlfYwmLJjnJXW5JQ9FvKIaGrpyQpj25MJtQqrJPY7aT2lh2KORGPnBBXvqGxLA0c8
         ljs0Ko4kb3kuWFryKNbd6zFPWjx5XAibiMmF5Y9fHm50mt1E5vAwAcGvXNL+jSdAj7Wp
         vmAw==
X-Gm-Message-State: APjAAAUoH+pzx22YnwRCJvrA0HpRxb5fEK51WKV8ZugRUDUB9DagwE6Y
        yJHO1Bj/pf+O2CfxhOxt6g1ogB9V01WHkJ+UurMnEQ7Auz5x
X-Google-Smtp-Source: APXvYqyUB1N5pY0EnPSlqgdjEtIpam0U8WlfKfXbcKl1pqLaLs4moHEgdqRSkU9gPkh6pVmW7vO3kzM9t/xL8F42XYm4xzxTvJFj
MIME-Version: 1.0
X-Received: by 2002:a5e:9319:: with SMTP id k25mr43633547iom.137.1563806291177;
 Mon, 22 Jul 2019 07:38:11 -0700 (PDT)
Date:   Mon, 22 Jul 2019 07:38:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bc3a0058e460627@google.com>
Subject: general protection fault in make_kuid
From:   syzbot <syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com>
To:     allison@lohutok.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jic23@kernel.org, knaack.h@gmx.de,
        kstewart@linuxfoundation.org, lars@metafoo.de,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        pmeerw@pmeerw.net, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d21a41b Add linux-next specific files for 20190718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15200158600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
dashboard link: https://syzkaller.appspot.com/bug?extid=7d6a57304857423318a5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1688da20600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16de4894600000

The bug was bisected to:

commit e786741ff1b52769b044b7f4407f39cd13ee5d2d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jul 11 22:36:02 2019 +0000

     Merge tag 'staging-5.3-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16610cf0600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15610cf0600000
console output: https://syzkaller.appspot.com/x/log.txt?x=11610cf0600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7d6a57304857423318a5@syzkaller.appspotmail.com
Fixes: e786741ff1b5 ("Merge tag 'staging-5.3-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9000 Comm: syz-executor213 Not tainted 5.2.0-next-20190718 #41
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:map_id_range_down+0x87/0x370 /kernel/user_namespace.c:293
Code: 6e 81 c7 00 f1 f1 f1 f1 c7 40 04 00 04 f3 f3 65 48 8b 04 25 28 00 00  
00 48 89 45 d0 31 c0 e8 c0 a5 03 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28  
84 c0 74 08 3c 03 0f 8e 9f 02 00 00 4c 8b ad 68 ff
RSP: 0018:ffff88809a567a30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88809a567aa8 RCX: ffffffff825b97b5
RDX: 0000000000000000 RSI: ffffffff816edf30 RDI: 0000000000000000
RBP: ffff88809a567ad0 R08: ffff88808e4d2600 R09: ffffed1014af1713
R10: ffffed1014af1712 R11: 0000000000000003 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555618880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000084 CR3: 000000008b2ec000 CR4: 00000000001406f0
Call Trace:
  map_id_down /kernel/user_namespace.c:312 [inline]
  make_kuid+0x23/0x30 /kernel/user_namespace.c:389
  fuse_parse_param+0x2cb/0x750 /fs/fuse/inode.c:523
  vfs_parse_fs_param+0x2ca/0x540 /fs/fs_context.c:145
  vfs_parse_fs_string+0x105/0x170 /fs/fs_context.c:188
  generic_parse_monolithic+0x181/0x200 /fs/fs_context.c:228
  parse_monolithic_mount_data+0x69/0x90 /fs/fs_context.c:708
  do_remount /fs/namespace.c:2520 [inline]
  do_mount+0x924/0x1c30 /fs/namespace.c:3102
  ksys_mount+0xdb/0x150 /fs/namespace.c:3320
  __do_sys_mount /fs/namespace.c:3334 [inline]
  __se_sys_mount /fs/namespace.c:3331 [inline]
  __x64_sys_mount+0xbe/0x150 /fs/namespace.c:3331
  do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4406e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdf71f73c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000007275 RCX: 00000000004406e9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 00000000006cb018 R08: 0000000020000300 R09: 65732f636f72702f
R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000401fd0
R13: 0000000000402060 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 4fbbc963024437d2 ]---
RIP: 0010:map_id_range_down+0x87/0x370 /kernel/user_namespace.c:293
Code: 6e 81 c7 00 f1 f1 f1 f1 c7 40 04 00 04 f3 f3 65 48 8b 04 25 28 00 00  
00 48 89 45 d0 31 c0 e8 c0 a5 03 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28  
84 c0 74 08 3c 03 0f 8e 9f 02 00 00 4c 8b ad 68 ff
RSP: 0018:ffff88809a567a30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88809a567aa8 RCX: ffffffff825b97b5
RDX: 0000000000000000 RSI: ffffffff816edf30 RDI: 0000000000000000
RBP: ffff88809a567ad0 R08: ffff88808e4d2600 R09: ffffed1014af1713
R10: ffffed1014af1712 R11: 0000000000000003 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555618880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000084 CR3: 000000008b2ec000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
