Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B6C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AE42632C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEaDsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:48:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49532 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfEaDsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:48:07 -0400
Received: by mail-io1-f70.google.com with SMTP id l9so6524126iok.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZY4THjifAaJLkq6CzGKGde3Hd+0/DlckHGeMC1I6vds=;
        b=VLuRboytiYdFiNS151JFNmA9u7vMEPhr55h8fivhaS2htqM1CxLuCKbc52icVWAl4V
         t4rADL38TKiYFXLzD7aHl2jTyOtXvQQcayyQ3T03Z+7O0tOWljkBB3pdLpcgwWaYwOeh
         +68q0rFvMmNYpdbSvIm672tGB8l6NMGhTp5S4VPr2RJ0jl/AIoeLQh+1YFtjzkEyfyE+
         0gaidJUNMlJDHeHozy3GGzKbQQSiGyX7YOThsKmSD1hjnczkBcP0nYyFpROROLnvVVjh
         ZqhHjU+r9Cf2Ip4tFi9sa8cvOmXwvUyDw9fTJHPbpYdCqxNEuMkwTKPnPomu5NQj6j7N
         +W8Q==
X-Gm-Message-State: APjAAAWsbtnGhr99I+EcxSxTJiVHYu7VcrhWXV4Y4JzsQOb2qWAcKg58
        Lievjbv4Fl0qxpveOPKOotOptgGgCmRwVSlSby2OUpQuZOO8
X-Google-Smtp-Source: APXvYqy2RJM11TMJKMIz/mjDJvs2BGYyQRp6rybjPaBIeC20R+SxjQ69BUzoYugrqVtyhkj2ZPXtT8BbUMqSCTwLb+mN7v7/lLkU
MIME-Version: 1.0
X-Received: by 2002:a5e:d70c:: with SMTP id v12mr4694981iom.12.1559274486069;
 Thu, 30 May 2019 20:48:06 -0700 (PDT)
Date:   Thu, 30 May 2019 20:48:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d981f1058a26e1a8@google.com>
Subject: memory leak in pppoe_sendmsg
From:   syzbot <syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        mostrows@earthlink.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bec7550c Merge tag 'docs-5.2-fixes2' of git://git.lwn.net/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1280ecbaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdfd184eac7709e5cc9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17112572a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com

2019/05/30 11:35:26 executed programs: 9
2019/05/30 11:35:32 executed programs: 11
2019/05/30 11:35:38 executed programs: 13
2019/05/30 11:35:44 executed programs: 15
2019/05/30 11:35:50 executed programs: 17
BUG: memory leak
unreferenced object 0xffff888124199500 (size 224):
   comm "syz-executor.0", pid 7122, jiffies 4295041954 (age 13.860s)
   hex dump (first 32 bytes):
     00 96 19 24 81 88 ff ff d0 20 0e 2a 81 88 ff ff  ...$..... .*....
     00 00 00 00 00 00 00 00 00 20 0e 2a 81 88 ff ff  ......... .*....
   backtrace:
     [<00000000688f689a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000688f689a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000688f689a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000688f689a>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<00000000e781c880>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<000000004ce3be0b>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<000000004ce3be0b>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2077
     [<000000008110994c>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:871
     [<00000000c1e51321>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000c1e51321>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000008012ebfd>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2292
     [<0000000087b8ef6f>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2387
     [<000000002b3700b1>] __do_sys_sendmmsg net/socket.c:2416 [inline]
     [<000000002b3700b1>] __se_sys_sendmmsg net/socket.c:2413 [inline]
     [<000000002b3700b1>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2413
     [<0000000028e31f9f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000004279bc05>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115706600 (size 512):
   comm "syz-executor.0", pid 7122, jiffies 4295041954 (age 13.860s)
   hex dump (first 32 bytes):
     23 32 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  #2.............d
     11 00 04 00 00 00 70 72 6f 66 69 6c 65 3d 30 20  ......profile=0
   backtrace:
     [<00000000c07b4ae3>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c07b4ae3>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c07b4ae3>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000c07b4ae3>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000e84718bb>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000e84718bb>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<000000008692fea3>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:142
     [<00000000da312aad>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:210
     [<000000004ce3be0b>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<000000004ce3be0b>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2077
     [<000000008110994c>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:871
     [<00000000c1e51321>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000c1e51321>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000008012ebfd>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2292
     [<0000000087b8ef6f>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2387
     [<000000002b3700b1>] __do_sys_sendmmsg net/socket.c:2416 [inline]
     [<000000002b3700b1>] __se_sys_sendmmsg net/socket.c:2413 [inline]
     [<000000002b3700b1>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2413
     [<0000000028e31f9f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000004279bc05>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888124199600 (size 224):
   comm "syz-executor.0", pid 7122, jiffies 4295041954 (age 13.860s)
   hex dump (first 32 bytes):
     00 97 19 24 81 88 ff ff 00 95 19 24 81 88 ff ff  ...$.......$....
     00 00 00 00 00 00 00 00 00 20 0e 2a 81 88 ff ff  ......... .*....
   backtrace:
     [<00000000688f689a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000688f689a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000688f689a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000688f689a>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<00000000e781c880>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<000000004ce3be0b>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<000000004ce3be0b>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2077
     [<000000008110994c>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:871
     [<00000000c1e51321>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000c1e51321>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000008012ebfd>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2292
     [<0000000087b8ef6f>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2387
     [<000000002b3700b1>] __do_sys_sendmmsg net/socket.c:2416 [inline]
     [<000000002b3700b1>] __se_sys_sendmmsg net/socket.c:2413 [inline]
     [<000000002b3700b1>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2413
     [<0000000028e31f9f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000004279bc05>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811a0b2600 (size 512):
   comm "syz-executor.0", pid 7122, jiffies 4295041954 (age 13.860s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000c07b4ae3>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c07b4ae3>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c07b4ae3>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000c07b4ae3>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000e84718bb>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000e84718bb>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<000000008692fea3>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:142
     [<00000000da312aad>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:210
     [<000000004ce3be0b>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<000000004ce3be0b>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2077
     [<000000008110994c>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:871
     [<00000000c1e51321>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000c1e51321>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000008012ebfd>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2292
     [<0000000087b8ef6f>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2387
     [<000000002b3700b1>] __do_sys_sendmmsg net/socket.c:2416 [inline]
     [<000000002b3700b1>] __se_sys_sendmmsg net/socket.c:2413 [inline]
     [<000000002b3700b1>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2413
     [<0000000028e31f9f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000004279bc05>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
