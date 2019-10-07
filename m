Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55A2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4F6206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfJGS7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:59:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45125 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfJGS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:59:13 -0400
Received: by mail-io1-f70.google.com with SMTP id o11so28079337iop.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9qkx91fvrW7+nt2ig/5mXags+RS886ck9437k8F/HWE=;
        b=mCFFwp7hsV77P3b/yctV+9xQ8WhRCc8p2FdBnXYMdHx9K0IgHDJfl0JgDbfPMCI2Qm
         KeZZtfhA7/sR/YbEJa5Avdd1xkIUPe6JG4weiIfWOiQnOJMKXCcXf+bzfuWBOI2UxNKL
         FvM4Uy/jLByy3zPfL5/jOOdPtwS2FrpIhdvDlXXASwrKraUFjMe9cuUILPvif+o4erh2
         QQQhJ9BhvSRZiaeijcYpXp9DfbTsNa+FsLRho6LjZJLHQnfqQE3BPhkr7F0E7jefYBxC
         aEUIEwmamL1ynTPyGb3FhQQArGuixBCAyJ/Ff/XP39VzoL0zv678XqEkikHoqmrszZ+/
         oRuQ==
X-Gm-Message-State: APjAAAUngkVESmvhP9To4Y8qWF+LfpZVuXi4XQnQleE3RrtKKpQS7niq
        mqBnBO/3BeLakxP8KbLntaBDAT6IBTY3ngo4cGif66bnfYWV
X-Google-Smtp-Source: APXvYqxKBsocfs6hrztTJyzwRVq+k2fLKzQNmGj9TkM4del9xykAefATNE29N658+MNPYEJBxDNIDkYbH2rvXRuNfUNaQrIZEF0V
MIME-Version: 1.0
X-Received: by 2002:a92:cac4:: with SMTP id m4mr29671240ilq.244.1570474751165;
 Mon, 07 Oct 2019 11:59:11 -0700 (PDT)
Date:   Mon, 07 Oct 2019 11:59:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac10ee059456a5f2@google.com>
Subject: general protection fault in tipc_nl_publ_dump
From:   syzbot <syzbot+8d37c50ffb0f52941a5e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    056ddc38 Merge branch 'stmmac-next'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168bdd47600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
dashboard link: https://syzkaller.appspot.com/bug?extid=8d37c50ffb0f52941a5e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ad0d0b600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113f6d47600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8d37c50ffb0f52941a5e@syzkaller.appspotmail.com

netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor671'.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8721 Comm: syz-executor671 Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tipc_nl_publ_dump+0x1c3/0xd60 net/tipc/socket.c:3591
Code: 80 3c 02 00 0f 85 9d 09 00 00 48 8b 85 f0 fe ff ff 4c 8b 70 20 48 b8  
00 00 00 00 00 fc ff df 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 69 09 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff88808e2c6eb8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff870875af
RDX: 0000000000000002 RSI: ffffffff870875bd RDI: 0000000000000010
RBP: ffff88808e2c7040 R08: ffff888093c7a300 R09: ffffed1015d06b75
R10: ffffed1015d06b74 R11: ffff8880ae835ba3 R12: ffffffff89986140
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880a97b28c0
FS:  0000000002434880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e990 CR3: 0000000093db1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __tipc_nl_compat_dumpit.isra.0+0x274/0xa80 net/tipc/netlink_compat.c:215
  tipc_nl_compat_publ_dump net/tipc/netlink_compat.c:1013 [inline]
  tipc_nl_compat_sk_dump+0x54d/0x970 net/tipc/netlink_compat.c:1065
  __tipc_nl_compat_dumpit.isra.0+0x3fb/0xa80 net/tipc/netlink_compat.c:226
  tipc_nl_compat_dumpit+0x24c/0x510 net/tipc/netlink_compat.c:299
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1264 [inline]
  tipc_nl_compat_recv+0x5a0/0xae0 net/tipc/netlink_compat.c:1302
  genl_family_rcv_msg_doit net/netlink/genetlink.c:668 [inline]
  genl_family_rcv_msg net/netlink/genetlink.c:713 [inline]
  genl_rcv_msg+0x678/0x1000 net/netlink/genetlink.c:730
  netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:741
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x8a5/0xd60 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:657
  ___sys_sendmsg+0x803/0x920 net/socket.c:2311
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2356
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg net/socket.c:2363 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4441b9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd2b43b478 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004441b9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000001900 R11: 0000000000000246 R12: 0000000000401e60
R13: 0000000000401ef0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 854b542c9f3952ec ]---
RIP: 0010:tipc_nl_publ_dump+0x1c3/0xd60 net/tipc/socket.c:3591
Code: 80 3c 02 00 0f 85 9d 09 00 00 48 8b 85 f0 fe ff ff 4c 8b 70 20 48 b8  
00 00 00 00 00 fc ff df 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 69 09 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff88808e2c6eb8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff870875af
RDX: 0000000000000002 RSI: ffffffff870875bd RDI: 0000000000000010
RBP: ffff88808e2c7040 R08: ffff888093c7a300 R09: ffffed1015d06b75
R10: ffffed1015d06b74 R11: ffff8880ae835ba3 R12: ffffffff89986140
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880a97b28c0
FS:  0000000002434880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e990 CR3: 0000000093db1000 CR4: 00000000001406f0
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
