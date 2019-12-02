Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC45C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C29A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfLBGfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:35:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:38793 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfLBGfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:35:08 -0500
Received: by mail-il1-f198.google.com with SMTP id o18so26650923ilb.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 22:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8ReAb1Jx3MYvvwEcmPSKSznDWtDi/FnA+jmMVAEqRhg=;
        b=ELlA6RsewAub6S+alXK9yepwiq3HcPZUjwXAllq7wspj+14p6jY/ZTbNvX+/2Xgt6C
         /8ZLsnjyDh0ZHEr2hcZ7FAwlx/3BhtE+XdqOnTy87rveo+ogAqTIirok4Y2vSYeZOhdk
         Wu30MJPmoqRyae1H8opq7IR71SYS8EroZhZ9gcQiLEnDpgoa6ydv8KvcdIsguHcOUfO/
         YaDCga8iI6Gcid3z+V7gq1K4aJP3QlkhUr+Y7YaZsQtQhYDE2CADNg5RXnLhfpp/BaXw
         WS+JBn98jflZQHp806lBwaznEVzqHc3UqeU5yuPxZG28UYS2utWUgydUCuZMQ9S5d6VW
         1sfA==
X-Gm-Message-State: APjAAAXt3nRyzwpz8+0dL9kGZA0dFpbuL9vZL4UoJAI7he4GJkP19qXu
        5vxytrb+I/MrbpG1/NYvNVceB00AioHbp/UmCPjIRoRP+rG/
X-Google-Smtp-Source: APXvYqx2LlddU0MrGHMtTu7I/2eykXIkLezxTM8GPVvLIohuzQHH5EFO7hwk+glvLrE+QX76wG02wBw/pEeeqViQXaX/JHf3xmLQ
MIME-Version: 1.0
X-Received: by 2002:a6b:5a02:: with SMTP id o2mr9770534iob.86.1575268508110;
 Sun, 01 Dec 2019 22:35:08 -0800 (PST)
Date:   Sun, 01 Dec 2019 22:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da160a0598b2c704@google.com>
Subject: general protection fault in override_creds
From:   syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>
To:     Anna.Schumaker@Netapp.com, casey@schaufler-ca.com,
        dhowells@redhat.com, jannh@google.com, keescook@chromium.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        neilb@suse.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f9ffcee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9217 Comm: io_uring-sq Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:creds_are_invalid kernel/cred.c:792 [inline]
RIP: 0010:__validate_creds include/linux/cred.h:187 [inline]
RIP: 0010:override_creds+0x9f/0x170 kernel/cred.c:550
Code: ac 25 00 81 fb 64 65 73 43 0f 85 a3 37 00 00 e8 17 ab 25 00 49 8d 7c  
24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 96 00 00 00 41 8b 5c 24 10 bf
RSP: 0018:ffff88809c45fda0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000043736564 RCX: ffffffff814f3318
RDX: 0000000000000002 RSI: ffffffff814f3329 RDI: 0000000000000010
RBP: ffff88809c45fdb8 R08: ffff8880a3aac240 R09: ffffed1014755849
R10: ffffed1014755848 R11: ffff8880a3aac247 R12: 0000000000000000
R13: ffff888098ab1600 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd51c40664 CR3: 0000000092641000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  io_sq_thread+0x1c7/0xa20 fs/io_uring.c:3274
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace f2e1a4307fbe2245 ]---
RIP: 0010:creds_are_invalid kernel/cred.c:792 [inline]
RIP: 0010:__validate_creds include/linux/cred.h:187 [inline]
RIP: 0010:override_creds+0x9f/0x170 kernel/cred.c:550
Code: ac 25 00 81 fb 64 65 73 43 0f 85 a3 37 00 00 e8 17 ab 25 00 49 8d 7c  
24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 96 00 00 00 41 8b 5c 24 10 bf
RSP: 0018:ffff88809c45fda0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000043736564 RCX: ffffffff814f3318
RDX: 0000000000000002 RSI: ffffffff814f3329 RDI: 0000000000000010
RBP: ffff88809c45fdb8 R08: ffff8880a3aac240 R09: ffffed1014755849
R10: ffffed1014755848 R11: ffff8880a3aac247 R12: 0000000000000000
R13: ffff888098ab1600 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd51c40664 CR3: 0000000092641000 CR4: 00000000001406f0
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
