Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A650C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EC62084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfKEUCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:02:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56908 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfKEUCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:02:10 -0500
Received: by mail-il1-f200.google.com with SMTP id e5so7026494ile.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 12:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TdSzHXGgVA9kXlyEU0WEr+ODdg0GlutO9e8rE8Pas8w=;
        b=nyvaYwWFiUU+m6DWoWBJ8GnwPsnCIA8QX+WQ99y4V+5Z49YH37kMtkL3LrAlr3hkbG
         KPNHfcxuosE5/xM6bayCqMVbVlM61BQMcv9/Zi2mpuTJCfBesSYelS4/wT0wD6dWTkmE
         VjgrWpcKgsJQZcAC9fQUYBpSaiVjrNTTnOjJcRVtXPK598XQiYRpJW1yjboPuOvJAfDY
         BSAvY9F4V6zJMFvVwLsBgvFEfMbGvwWTLN0MFBaS1V26vrxzlYX1qMdw7MfIFgEh9Lku
         iT7ZLtK5pB1qwqduETwEd6h1uP8wBOYHtAtCiQJFtFjgh8kC0NnzHgDt4c9yHGXWiLrW
         nsAw==
X-Gm-Message-State: APjAAAVEiypFfurx7FXc+cozenpaLim6o4xDl6z5xY7rB8pafmxb/Kku
        gdmD53cf1/HqYhrnSdrN0oXgJPpGyZkTije4alluK2yOO8n7
X-Google-Smtp-Source: APXvYqz80KNhqpP/JjkJZhvm5W4MbcXjcpifOeqyjRVGCWYce+IUreSV3MpyaMXXiC2/0elketb7K0rseKiIO0bXZiWXxRSLU87n
MIME-Version: 1.0
X-Received: by 2002:a02:840a:: with SMTP id k10mr1650134jah.26.1572984129539;
 Tue, 05 Nov 2019 12:02:09 -0800 (PST)
Date:   Tue, 05 Nov 2019 12:02:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047580205969ee89b@google.com>
Subject: general protection fault in j1939_sk_sendmsg
From:   syzbot <syzbot+7044ea77452b6f92b4fd@syzkaller.appspotmail.com>
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

HEAD commit:    3d1e5039 dccp: do not leak jiffies on the wire
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1667443ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbed3e8d4eb64bf
dashboard link: https://syzkaller.appspot.com/bug?extid=7044ea77452b6f92b4fd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1063f1c8e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7044ea77452b6f92b4fd@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9129 Comm: syz-executor.0 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:j1939_sk_send_loop net/can/j1939/socket.c:983 [inline]
RIP: 0010:j1939_sk_sendmsg+0x6d6/0x1450 net/can/j1939/socket.c:1100
Code: e8 9f 16 f4 fa 48 8b 8d 50 ff ff ff b8 f9 06 00 00 48 81 f9 f9 06 00  
00 48 0f 46 c1 48 89 85 60 ff ff ff 48 8b 85 20 ff ff ff <80> 38 00 0f 85  
fa 0a 00 00 48 8b 85 40 ff ff ff 48 8b 58 48 48 8b
RSP: 0018:ffff88808189fa28 EFLAGS: 00010206
RAX: dffffc0000000009 RBX: 0000000006fffff9 RCX: 0000000006fffff9
RDX: 0000000000000000 RSI: ffffffff867f0c31 RDI: 0000000000000007
RBP: ffff88808189fb40 R08: ffff888091482400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88809195b510 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fb51830c700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb51832cdb8 CR3: 00000000a845c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:657
  ___sys_sendmsg+0x803/0x920 net/socket.c:2311
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2356
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg net/socket.c:2363 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a219
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb51830bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a219
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 000000000075c118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb51830c6d4
R13: 00000000004c804e R14: 00000000004de4d0 R15: 00000000ffffffff
Modules linked in:
---[ end trace b093e29acd07b362 ]---
RIP: 0010:j1939_sk_send_loop net/can/j1939/socket.c:983 [inline]
RIP: 0010:j1939_sk_sendmsg+0x6d6/0x1450 net/can/j1939/socket.c:1100
Code: e8 9f 16 f4 fa 48 8b 8d 50 ff ff ff b8 f9 06 00 00 48 81 f9 f9 06 00  
00 48 0f 46 c1 48 89 85 60 ff ff ff 48 8b 85 20 ff ff ff <80> 38 00 0f 85  
fa 0a 00 00 48 8b 85 40 ff ff ff 48 8b 58 48 48 8b
RSP: 0018:ffff88808189fa28 EFLAGS: 00010206
RAX: dffffc0000000009 RBX: 0000000006fffff9 RCX: 0000000006fffff9
RDX: 0000000000000000 RSI: ffffffff867f0c31 RDI: 0000000000000007
RBP: ffff88808189fb40 R08: ffff888091482400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88809195b510 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fb51830c700(000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
