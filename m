Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC93CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E14A217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfKEEWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:22:13 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:41320 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfKEEWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:22:11 -0500
Received: by mail-io1-f70.google.com with SMTP id v5so8002276iot.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 20:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X9lW8ii3GGZ4Cig/UC9Hwb9iVEyqtiyLpsfWPVzv+AU=;
        b=h/8H8+M43ucMOB2FE562u4zca1FUkMj/97xnSEEAsXCN4BItokkQJPv5gAtgZqC2f3
         yUNdfZF7PpjLPYdAAirUGiKpv9jk7a/YmXxF7xIUl3pSKnPcoRE6i1j/gesa8AdD/TWm
         LkUhh71bFQfiLDgLRwdYpx4/b4FjlxfE9udOJVb7mNSRnwxvxM8yF2vyiBIGSD6f2E+8
         fc2HUl9l7k3NhKKpZfwaXDrXkOsmVRtI6tXKkOojx1BTl81ACrPri55ngZA/ovn+h068
         72GQ6SgBuhBlQMmNIi0ByltC+U+6g6bstetQy9ZHrWPEm0xLWjou7c/KqyNaNEuJsaap
         XCbA==
X-Gm-Message-State: APjAAAUNU9uLYhBd7FxywqAOkA5imVCjPQqpEGGrkZyuMmowjQX5ypmr
        bzjYHFImD/7sUYYsdkZY+fUVQHFGjDz+qqqqGrk3ciaDfY3o
X-Google-Smtp-Source: APXvYqxN5W1l5tyGdgaW+GmFjSDeL5UI9n+R9bdebBqjvYKj96bA0+NJN7OVDS7UtkpUkfqSJduFphaddA7Pm10TgnhgvBEJvIy3
MIME-Version: 1.0
X-Received: by 2002:a6b:38c5:: with SMTP id f188mr26602776ioa.235.1572927730568;
 Mon, 04 Nov 2019 20:22:10 -0800 (PST)
Date:   Mon, 04 Nov 2019 20:22:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a367e3059691c6b4@google.com>
Subject: general protection fault in j1939_sk_bind
From:   syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a99d8080 Linux 5.4-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6b844e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110a8b8ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8341 Comm: syz-executor.0 Not tainted 5.4.0-rc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x86/0x1be0 kernel/locking/lockdep.c:3828
Code: 8a 04 30 84 c0 0f 85 66 12 00 00 83 3d 92 24 66 07 00 0f 84 91 12 00  
00 83 3d 35 a6 34 07 00 74 34 48 8b 44 24 10 48 c1 e8 03 <80> 3c 30 00 74  
14 48 8b 7c 24 10 e8 fa 13 54 00 48 be 00 00 00 00
RSP: 0018:ffff88809865fb80 EFLAGS: 00010006
RAX: 0000000000000218 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00000000000010c0
RBP: ffff88809865fcd8 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff117cc5d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888098654700
FS:  00007f68f3c1c700(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000075c000 CR3: 00000000a96a2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x34/0x50 kernel/locking/spinlock.c:175
  spin_lock_bh include/linux/spinlock.h:343 [inline]
  j1939_jsk_del net/can/j1939/socket.c:90 [inline]
  j1939_sk_bind+0x387/0xac0 net/can/j1939/socket.c:421
  __sys_bind+0x2c2/0x3a0 net/socket.c:1647
  __do_sys_bind net/socket.c:1658 [inline]
  __se_sys_bind net/socket.c:1656 [inline]
  __x64_sys_bind+0x7a/0x90 net/socket.c:1656
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a219
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f68f3c1bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a219
RDX: 0000000000000018 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f68f3c1c6d4
R13: 00000000004c057e R14: 00000000004d2c50 R15: 00000000ffffffff
Modules linked in:
---[ end trace bc0dd162dace32c7 ]---
RIP: 0010:__lock_acquire+0x86/0x1be0 kernel/locking/lockdep.c:3828
Code: 8a 04 30 84 c0 0f 85 66 12 00 00 83 3d 92 24 66 07 00 0f 84 91 12 00  
00 83 3d 35 a6 34 07 00 74 34 48 8b 44 24 10 48 c1 e8 03 <80> 3c 30 00 74  
14 48 8b 7c 24 10 e8 fa 13 54 00 48 be 00 00 00 00
RSP: 0018:ffff88809865fb80 EFLAGS: 00010006
RAX: 0000000000000218 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00000000000010c0
RBP: ffff88809865fcd8 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff117cc5d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888098654700
FS:  00007f68f3c1c700(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000075c000 CR3: 00000000a96a2000 CR4: 00000000001406f0
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
