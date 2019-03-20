Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83115218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCTVWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:22:15 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:52651 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfCTVWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:22:07 -0400
Received: by mail-it1-f197.google.com with SMTP id z131so648462itb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Efy7e3i5bPtxOHLTbjdGrad9yd7UmVsp2KLVm2vdE34=;
        b=c6ktRtga4eNd6cpUKYz0v8g28d51otTbR6P/QHcdX138h+d7zk9PLWL9KtJtpuzbWB
         IxHwyihB5rUu6XLXbu1Vy10s6sQGsrty6FTF9xaPutM4FsaQXeo45fQ6LWgrdU7MImCW
         AiqYBr1WCX6Xl8g3xd7wdlwJqptSfR08PqdIDvLwI3OwmpNxsH8PHoOYe35XwrMYIoLs
         eS0HewbQB4xrIJt2ngL1Hi+a2uVZEOWaQrk2K2tQ9leGGmpRjm8oGY/RmiWVhafJTGo3
         iSgguOknx5Sse9rX1Vio14MNUCkS57BlnfGwUlfFqLxd3pUSZaAR/7Xj+jqHI6FnFWNW
         AZig==
X-Gm-Message-State: APjAAAX5MdBn/812C0lS9LqlgLUM7TJR/rP8gjurehUCCv7byQ8Hy5Ti
        jwM99Jhf3ShBzBbcdAomV77wyQcg8iLtf/4XeW/Wcc8VfBaf
X-Google-Smtp-Source: APXvYqxwkXzfDJ4xzcRn7QGgl7L45dvKSbWVs+3dtRC2t6HlzyFZ4p8dhoMFtEY7ub7q7SodovHxloeWbwDTftYPcmz1j0fE7GBK
MIME-Version: 1.0
X-Received: by 2002:a24:3a4a:: with SMTP id m71mr5965334itm.12.1553116925881;
 Wed, 20 Mar 2019 14:22:05 -0700 (PDT)
Date:   Wed, 20 Mar 2019 14:22:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9993005848d36e2@google.com>
Subject: general protection fault in tipc_mcast_filter_msg
From:   syzbot <syzbot+be4bdf2cc3e85e952c50@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hoang.h.le@dektech.com.au,
        jon.maloy@ericsson.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a0cfa79f ibmveth: Make array ibmveth_stats static
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ec3ea3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=be4bdf2cc3e85e952c50
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146929f7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c05c6d200000

The bug was bisected to:

commit c55c8edafa91139419ed011f7d036274ce96be0b
Author: Hoang Le <hoang.h.le@dektech.com.au>
Date:   Tue Mar 19 11:49:50 2019 +0000

     tipc: smooth change between replicast and broadcast

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173929f7200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b929f7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b929f7200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be4bdf2cc3e85e952c50@syzkaller.appspotmail.com
Fixes: c55c8eda ("tipc: smooth change between replicast and broadcast")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7820 Comm: syz-executor418 Not tainted 5.0.0+ #61
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tipc_mcast_filter_msg+0x21b/0x13d0 net/tipc/bcast.c:782
Code: 45 c0 0f 84 39 06 00 00 48 89 5d 98 e8 ce ab a5 fa 49 8d bc 24 c8 00  
00 00 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f  
85 9a 0e 00 00 49 8b 9c 24 c8 00 00 00 48 be 00 00
RSP: 0018:ffff8880959defc8 EFLAGS: 00010202
RAX: 0000000000000019 RBX: ffff888081258a48 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff86cab862 RDI: 00000000000000c8
RBP: ffff8880959df030 R08: ffff8880813d0200 R09: ffffed1015d05bc8
R10: ffffed1015d05bc7 R11: ffff8880ae82de3b R12: 0000000000000000
R13: 000000000000002c R14: 0000000000000000 R15: ffff888081258a48
FS:  000000000106a880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001cc0 CR3: 0000000094a20000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tipc_sk_filter_rcv+0x182d/0x34f0 net/tipc/socket.c:2168
  tipc_sk_enqueue net/tipc/socket.c:2254 [inline]
  tipc_sk_rcv+0xc45/0x25a0 net/tipc/socket.c:2305
  tipc_sk_mcast_rcv+0x724/0x1020 net/tipc/socket.c:1209
  tipc_mcast_xmit+0x7fe/0x1200 net/tipc/bcast.c:410
  tipc_sendmcast+0xb36/0xfc0 net/tipc/socket.c:820
  __tipc_sendmsg+0x10df/0x18d0 net/tipc/socket.c:1358
  tipc_sendmsg+0x53/0x80 net/tipc/socket.c:1291
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x806/0x930 net/socket.c:2260
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2298
  __do_sys_sendmsg net/socket.c:2307 [inline]
  __se_sys_sendmsg net/socket.c:2305 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2305
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401c9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd887fa9d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401c9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a50
R13: 0000000000401ae0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace ba79875754e1708f ]---
RIP: 0010:tipc_mcast_filter_msg+0x21b/0x13d0 net/tipc/bcast.c:782
Code: 45 c0 0f 84 39 06 00 00 48 89 5d 98 e8 ce ab a5 fa 49 8d bc 24 c8 00  
00 00 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f  
85 9a 0e 00 00 49 8b 9c 24 c8 00 00 00 48 be 00 00
RSP: 0018:ffff8880959defc8 EFLAGS: 00010202
RAX: 0000000000000019 RBX: ffff888081258a48 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff86cab862 RDI: 00000000000000c8
RBP: ffff8880959df030 R08: ffff8880813d0200 R09: ffffed1015d05bc8
R10: ffffed1015d05bc7 R11: ffff8880ae82de3b R12: 0000000000000000
R13: 000000000000002c R14: 0000000000000000 R15: ffff888081258a48
FS:  000000000106a880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001cc0 CR3: 0000000094a20000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
