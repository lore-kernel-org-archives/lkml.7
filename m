Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF02C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D902820879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfCYHmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:42:07 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:56104 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfCYHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:42:07 -0400
Received: by mail-it1-f199.google.com with SMTP id y6so8346473itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 00:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J1bg7V3tT4vzizIIuHpcVh+etP4TuQAon6TicJ/+KKY=;
        b=JWnzxKg5+pvam9lNxOF+oV7xNhqc8D/x9pAsMvO5/FXL/tExcc+CdtWODa3UNsZy/2
         8TuTAqbB1rTZU6t2ImSZ03Uh2ei2q3aFBkO54ctVL2O/bZMBm04V3f9xo+wapu9W15wy
         JBHR5szyO4kQwFKW3Letwe7qPyvjLa9EFP1n526vhQRS2LiCloMbQB5aeUAScBB7sU2H
         ZUkZuPZhlzRcqo0FIb+U1jKh+MUGBBxEqCZb4PaN73HMi/0xA78f4Vez1ZrfMNe6/sGN
         0Ekqet22+L5PYeIzBD3QOSYYqkSzEpFPODQHeZYykgvoxf6SYNxDJ2tMx/KKiMxAnlJM
         KxNg==
X-Gm-Message-State: APjAAAXscZCSgOlNaWR9Y4WOQVSk4A8AlN1QoQqnvxc71bJ+/RCJuY2g
        Yqdk9O56BRctU0U67feouLcazyEmlcSH159dE3mzzqfiacPl
X-Google-Smtp-Source: APXvYqxSAwWOdgDkKpTsxMhmUuydpncQwv46x6cF+4WEVvsKtjcIbGlNUaGTOFz0uCQDS+k4VxAis+/oJdVX+fg6Tw18iTW0kkdx
MIME-Version: 1.0
X-Received: by 2002:a02:499c:: with SMTP id p28mr16593855jad.118.1553499725905;
 Mon, 25 Mar 2019 00:42:05 -0700 (PDT)
Date:   Mon, 25 Mar 2019 00:42:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000524ca80584e657d8@google.com>
Subject: BUG: corrupted list in rhashtable_walk_enter
From:   syzbot <syzbot+dae72a112334aa65a159@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        keescook@chromium.org, ktkhai@virtuozzo.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com,
        tom@herbertland.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a5ed1e96 Merge tag 'powerpc-5.1-3' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1788d34d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=dae72a112334aa65a159
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d40c07200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dae72a112334aa65a159@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffff888091d3aa60), but was  
0000000000000002. (next=ffff8880984df5f0).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:23!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11985 Comm: syz-executor.4 Not tainted 5.1.0-rc1+ #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid.cold+0xf/0x3c lib/list_debug.c:23
Code: 77 fe eb d5 4c 89 e7 e8 ba 6a 77 fe eb a3 4c 89 f7 e8 b0 6a 77 fe e9  
56 ff ff ff 4c 89 e1 48 c7 c7 00 d5 a1 87 e8 f0 ce 29 fe <0f> 0b 48 89 f2  
4c 89 e1 4c 89 ee 48 c7 c7 40 d6 a1 87 e8 d9 ce 29
RSP: 0018:ffff888085b3f4b0 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff888085b3f5d8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ae266 RDI: ffffed1010b67e88
RBP: ffff888085b3f4c8 R08: 0000000000000075 R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffff8880984df5f0
R13: ffff888085b3f5f0 R14: ffff888091d3aa40 R15: ffff888091d3aa60
FS:  00007f7a35de9700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000a61fa000 CR4: 00000000001406f0
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add include/linux/list.h:79 [inline]
  rhashtable_walk_enter+0x1b0/0x390 lib/rhashtable.c:676
  ila_xlat_nl_cmd_flush+0x244/0x1090 net/ipv6/ila/ila_xlat.c:388
  genl_family_rcv_msg+0x6e1/0xd90 net/netlink/genetlink.c:601
  genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:632
  ___sys_sendmsg+0x806/0x930 net/socket.c:2137
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2175
  __do_sys_sendmsg net/socket.c:2184 [inline]
  __se_sys_sendmsg net/socket.c:2182 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2182
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7a35de8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458209
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a35de96d4
R13: 00000000004c57c8 R14: 00000000004d96b8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 25c5a70a6fa97765 ]---
RIP: 0010:__list_add_valid.cold+0xf/0x3c lib/list_debug.c:23
Code: 77 fe eb d5 4c 89 e7 e8 ba 6a 77 fe eb a3 4c 89 f7 e8 b0 6a 77 fe e9  
56 ff ff ff 4c 89 e1 48 c7 c7 00 d5 a1 87 e8 f0 ce 29 fe <0f> 0b 48 89 f2  
4c 89 e1 4c 89 ee 48 c7 c7 40 d6 a1 87 e8 d9 ce 29
RSP: 0018:ffff888085b3f4b0 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff888085b3f5d8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ae266 RDI: ffffed1010b67e88
RBP: ffff888085b3f4c8 R08: 0000000000000075 R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffff8880984df5f0
R13: ffff888085b3f5f0 R14: ffff888091d3aa40 R15: ffff888091d3aa60
FS:  00007f7a35de9700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000a61fa000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
