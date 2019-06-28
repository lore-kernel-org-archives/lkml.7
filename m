Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA91C5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB26205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfF1S6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:58:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45777 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF1S6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:58:07 -0400
Received: by mail-io1-f69.google.com with SMTP id b197so7577377iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lxfC6EGeYeb8TyoHbxViK9FOlhG7U3RR+h20/aAzSOw=;
        b=HvlgHFyEzUulEJ+tejXiKHTAAdhriY4A3VFOdAFFMwX66IpQGzXxA/e2sTuKkw7NXT
         /QthyJvpeEDsb0iPwg561qfYvp9JAJYi1mEyP3pG4ac2plu/ff+AoAJa6a9/VG5U9sLl
         cHj51JNZi+nh5viO+GkmcNF4c3dWFaz2Lqm/jd/GNu97eEnU8T43KDHpb+IQEIDCn0xD
         hdaUtpK18QMZ20kz4lhJ7vWYnhigI9aVNy2wemuhJ7vzRfJUF5rOdzWkmHdkfbP5hdpD
         RYFoKeQCR2E/AL7kWeRA230SBIGBmdYk9ejzNOiMJHWqw24MOp0AgsVYY4HuQT0e4gt6
         CX8w==
X-Gm-Message-State: APjAAAXUObJ/xLfoF2IbVivzkJdNfZ0A+QiGyjsRquB5y2GsB856h6xb
        UsaZ3om/vjVKIgojpbHOnfJ+mFyOY+Jj8WE86nIhkmSA4ZCy
X-Google-Smtp-Source: APXvYqwc7log/iUXg/QLT3qEJTSTMHR8u4iieFx8/vmRhvqWkiHWs8Whzig14JT1cAh2YjRed/ThrT2JCbV/gBNPfPhTAeMxAD7o
MIME-Version: 1.0
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr12695642iok.75.1561748285904;
 Fri, 28 Jun 2019 11:58:05 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:58:05 -0700
In-Reply-To: <000000000000d981f1058a26e1a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf7459058c66dba6@google.com>
Subject: Re: memory leak in pppoe_sendmsg
From:   syzbot <syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        mostrows@earthlink.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c84afab0 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164241d9a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1db8bd6825f9661c
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdfd184eac7709e5cc9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c5f8da00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cdd4eba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.150s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.150s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.140s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.050s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.220s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.220s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.210s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.120s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.290s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.290s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.280s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.190s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.350s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.350s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.340s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.250s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.420s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.420s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.410s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.320s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.480s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.480s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.470s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.380s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.550s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.550s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.540s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.450s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115942b00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.610s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888113199800 (size 512):
   comm "syz-executor057", pid 7184, jiffies 4294955398 (age 32.610s)
   hex dump (first 32 bytes):
     00 00 aa aa aa aa aa 0a aa aa aa aa aa 0a 88 64  ...............d
     11 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000059b95d3a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000059b95d3a>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059b95d3a>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059b95d3a>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000fb30d91c>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000fb30d91c>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<0000000021df94db>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<000000003bd62b3e>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881130b9e00 (size 224):
   comm "syz-executor057", pid 7184, jiffies 4294955399 (age 32.600s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 08 58 13 81 88 ff ff  ..........X.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881131dcf00 (size 224):
   comm "syz-executor057", pid 7192, jiffies 4294955408 (age 32.510s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 20 2d 13 81 88 ff ff  ......... -.....
   backtrace:
     [<0000000025f85882>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000025f85882>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000025f85882>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000025f85882>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000005b601dc8>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<000000003813d44c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<000000003813d44c>] sock_wmalloc+0x4f/0x80 net/core/sock.c:2071
     [<000000003f8b1014>] pppoe_sendmsg+0xd0/0x250  
drivers/net/ppp/pppoe.c:866
     [<000000003841750c>] sock_sendmsg_nosec net/socket.c:646 [inline]
     [<000000003841750c>] sock_sendmsg+0x54/0x70 net/socket.c:665
     [<00000000f75dab14>] ___sys_sendmsg+0x194/0x3c0 net/socket.c:2286
     [<000000004ca9b6e5>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2381
     [<00000000e008d506>] __do_sys_sendmmsg net/socket.c:2410 [inline]
     [<00000000e008d506>] __se_sys_sendmmsg net/socket.c:2407 [inline]
     [<00000000e008d506>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2407
     [<00000000f738b123>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000081d80325>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


