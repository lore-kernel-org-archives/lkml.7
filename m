Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC012183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfC1QOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:14:08 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:55305 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1QOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:07 -0400
Received: by mail-it1-f197.google.com with SMTP id g184so3645602ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oJqSZLXafLq5BV00CQW4oXNTARNayhkg1/SbbH10nMI=;
        b=F87PdXMgfCzmoLfX6n4vInI2z60df8A5OTAlncjeUEBGDCoy9h1BpkrxhH4HBJOpSg
         5U5LNo9O6jacGaB0V7lr9+DBFrYZ01yMIKzVSZmiXv/9amIxYQTP6aNzBt3y1x0oeFuP
         9FBODLv4HvFXr64oPsiO+kkhIUPgU8pElMPU+Ti8B4S0Ab3k0p+iK+qCavgYgTeJM+4D
         U7h38STX4A/yyQd0J7Uqoyuw7hNPGGC4cpmUnHd+PXjdmYQF1gimMQo94R4Wz8tRUdnK
         J+vIkYJ7S1ayVcUjnboQEbRUapwXRNifE3b4vnqGlWZtpq8y70PH/6rOtzBQ/jl9xxUK
         YhFw==
X-Gm-Message-State: APjAAAWj+vGmBxM7Pc3X/9rnHZDd2dC8gWxb6m+yMPkMvVHa/BMuFdPr
        RMY/3ObHuKXnpWW+u45o9lnhmEs2jKhvYCp5hVb9hBGmR2HI
X-Google-Smtp-Source: APXvYqzV8NLrDLC2VJda5WaSRpG7OxVvrCxJ2g4TxVTa+BdnOvJE/tyk4iC0rB7EV/1wkcAxKsF420slEom+/wVc9KpRiLNYtRDz
MIME-Version: 1.0
X-Received: by 2002:a24:78c:: with SMTP id f134mr222911itf.30.1553789646166;
 Thu, 28 Mar 2019 09:14:06 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:14:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea60e6058529d77b@google.com>
Subject: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
From:   syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1a9df9e2 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fed11f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f3f388440283da2965
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d05637200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1677e62f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com

binder: 7824:7824 DecRefs 0 refcount change on invalid ref 1 ret -22
------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:1141!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7824 Comm: syz-executor570 Not tainted 5.1.0-rc2+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 4f f4 23 fc 4c 89  
e6 4c 89 ef e8 64 f5 23 fc 4d 39 e5 76 07 e8 3a f4 23 fc <0f> 0b e8 33 f4  
23 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 41
RSP: 0018:ffff88808b497550 EFLAGS: 00010293
RAX: ffff88808620e540 RBX: 0000000020001000 RCX: ffffffff854c7d3c
RDX: 0000000000000000 RSI: ffffffff854c7d46 RDI: 0000000000000006
RBP: ffff88808b4975d0 R08: ffff88808620e540 R09: 0000000000000028
R10: ffffed1011692f01 R11: ffff88808b49780f R12: 0000000000000008
R13: 0000000000000028 R14: ffff888088a0cb10 R15: 0000000000000000
FS:  00000000006de940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c4d28 CR3: 0000000090d8e000 CR4: 00000000001406e0
Call Trace:
  binder_alloc_copy_from_buffer+0x37/0x42 drivers/android/binder_alloc.c:1187
  binder_get_object+0xc3/0x200 drivers/android/binder.c:2062
  binder_transaction+0x2b4a/0x6690 drivers/android/binder.c:3231
  binder_thread_write+0x87e/0x2820 drivers/android/binder.c:3781
  binder_ioctl_write_read drivers/android/binder.c:4825 [inline]
  binder_ioctl+0x1033/0x183b drivers/android/binder.c:5002
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445f19
Code: e8 7c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffeaa7b578 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000445f19
RDX: 0000000020000240 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000403010
R10: 00007fffeaa7b0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000403010 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 0f3d90ce4ca56ff6 ]---
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 4f f4 23 fc 4c 89  
e6 4c 89 ef e8 64 f5 23 fc 4d 39 e5 76 07 e8 3a f4 23 fc <0f> 0b e8 33 f4  
23 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 41
RSP: 0018:ffff88808b497550 EFLAGS: 00010293
RAX: ffff88808620e540 RBX: 0000000020001000 RCX: ffffffff854c7d3c
RDX: 0000000000000000 RSI: ffffffff854c7d46 RDI: 0000000000000006
RBP: ffff88808b4975d0 R08: ffff88808620e540 R09: 0000000000000028
R10: ffffed1011692f01 R11: ffff88808b49780f R12: 0000000000000008
R13: 0000000000000028 R14: ffff888088a0cb10 R15: 0000000000000000
FS:  00000000006de940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c4d28 CR3: 0000000090d8e000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
