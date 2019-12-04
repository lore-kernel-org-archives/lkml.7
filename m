Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E10C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B71D20637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfLDIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:25:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56584 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:25:10 -0500
Received: by mail-il1-f197.google.com with SMTP id e5so5193137ile.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2cEbeBD4AwlS2HZ8HF8Ggnp8dQCTypz93AZ8GB5LeME=;
        b=Fbi7dxNAHxAI9rNVVs66kh6DCGUolDe5QRBS+i0z+aCYDkG8C9rMB8QS1O+OkH+gCU
         pzOCM/s1aTZirdHa2gcGrrDovBIqJwF2dRtUZ2+FqazvQXGKlrQYLspaaxrCVltuey3B
         rjwwSofbR43H/PYIdy9J0kvQbWKOcHwfWiC6idU/dVTxCvBTILhQqK99q0a94rfpOJPj
         +vU/OCywuup+BYLpB1Ro1Cr+FxxRWMOGQFQv1tDncxspFjnF0QVDl3LhXADxhJJm8oCK
         zcFNTfgwW9DkUILrWsepCmoq9ueb+XLXD8i4+9o40U7+bAE3KJK0cSkH+jYFmG20CKJk
         Jhcg==
X-Gm-Message-State: APjAAAWAaU2/oBLQWXA5ftJGUK9rKX81yxZUQC/duoAE1LntyPtxRT16
        WaIt2p095QJwhW3qMqrqXhHnxhuTBO7T3cakwY5hJUd94xpZ
X-Google-Smtp-Source: APXvYqylfg0AJYJdMW9vDSIGwHGUqOCGx5SNZx078ScZ9SSlf2BYyPIPN73Cp4ENjFxpb2qpVM0/9fdZBhJXrF8PgqLTMLADYub/
MIME-Version: 1.0
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr2505342ilg.137.1575447909525;
 Wed, 04 Dec 2019 00:25:09 -0800 (PST)
Date:   Wed, 04 Dec 2019 00:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000027a850598dc8df1@google.com>
Subject: general protection fault in do_con_write
From:   syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de,
        tomli@tomli.me
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1535d196e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=017265e8553724e514e8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a2bb7ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c20cdee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+017265e8553724e514e8@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9613 Comm: syz-executor287 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_con_write.part.0+0xa01/0x1ef0 drivers/tty/vt/vt.c:2760
Code: 7e fe ff ff 45 01 ef e8 8d cc 95 fd 48 8b 85 c8 fe ff ff 80 38 00 0f  
85 71 12 00 00 49 8b 9e a0 03 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 14 20  
48 89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffffc90001d776e8 EFLAGS: 00010203
RAX: 0000000020000001 RBX: 000000010000000e RCX: ffffffff83df2da0
RDX: 0000000000000000 RSI: ffffffff83df2df3 RDI: 0000000000000003
RBP: ffffc90001d77878 R08: ffff88809a546580 R09: ffff88809a546e10
R10: fffffbfff14b0ab0 R11: ffffffff8a585587 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88809b2b9000 R15: 00000000000007fe
FS:  0000000001678880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9ea7b34000 CR3: 00000000985d9000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_con_write drivers/tty/vt/vt.c:3146 [inline]
  con_put_char+0xfa/0x110 drivers/tty/vt/vt.c:3145
  tty_put_char+0xc5/0x160 drivers/tty/tty_io.c:3031
  __process_echoes+0x37c/0xa40 drivers/tty/n_tty.c:708
  flush_echoes drivers/tty/n_tty.c:829 [inline]
  __receive_buf drivers/tty/n_tty.c:1648 [inline]
  n_tty_receive_buf_common+0xc77/0x2b70 drivers/tty/n_tty.c:1742
  n_tty_receive_buf+0x31/0x40 drivers/tty/n_tty.c:1771
  tiocsti drivers/tty/tty_io.c:2198 [inline]
  tty_ioctl+0x949/0x14f0 drivers/tty/tty_io.c:2574
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444099
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffde6924f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444099
RDX: 0000000020000040 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000401da0
R13: 0000000000401e30 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 7e8070a124b9d12d ]---
RIP: 0010:do_con_write.part.0+0xa01/0x1ef0 drivers/tty/vt/vt.c:2760
Code: 7e fe ff ff 45 01 ef e8 8d cc 95 fd 48 8b 85 c8 fe ff ff 80 38 00 0f  
85 71 12 00 00 49 8b 9e a0 03 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 14 20  
48 89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffffc90001d776e8 EFLAGS: 00010203
RAX: 0000000020000001 RBX: 000000010000000e RCX: ffffffff83df2da0
RDX: 0000000000000000 RSI: ffffffff83df2df3 RDI: 0000000000000003
RBP: ffffc90001d77878 R08: ffff88809a546580 R09: ffff88809a546e10
R10: fffffbfff14b0ab0 R11: ffffffff8a585587 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88809b2b9000 R15: 00000000000007fe
FS:  0000000001678880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9ea7b34000 CR3: 00000000985d9000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
