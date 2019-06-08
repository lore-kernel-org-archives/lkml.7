Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63431C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31408208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfFHTNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:13:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:42842 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfFHTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:13:07 -0400
Received: by mail-io1-f72.google.com with SMTP id f22so4373926ioj.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 12:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/CiUQxhmX/wrK/zGQ3q1oXcnS8swEmLJnbMQU92h+Ss=;
        b=eCrMFQNgta43fI5WRrSIfoUj75CVZXuuoTeOVidNUqAurhd5Bpjmj0xaXgywyBTlGm
         CUHQKBc2zVkasb/1TNimsDTipNndxsRcXkKl056I3vnVzM7WaTr4IkXAcUi9HpZYZlJ/
         To+3nt4itosbY3J1K4E4Xj26t0/5mq4SAqbQTro+dKiKz5A0bVSmNdjT8pUBZHkqF47A
         OaG8eD/5pt1mDIgGACxhkReqod1PMGji3sUufacOOX/ZCyNrpWa3Urf4CDjO4pCQD9Mx
         oa762vUh/XaO1TWGDoRlHRithonZVvSTqR/5lLMJZ0iPFw6d+ChSWml6uDHWeYjlF9tP
         GEZA==
X-Gm-Message-State: APjAAAWt7/zrcyr1dDZZEiDTynF5kW4cj2iU3pe96q5vjrPpj9LU0xfd
        VD2UlftzapkgvICESX57bOQ983wlRgbwFiP4LwKN1+DJe6cC
X-Google-Smtp-Source: APXvYqyqTZMuLhnsb2l6Rm+NJ0m2Qh9j/TIK4FNt1CYvVuNZonQYR1LuUV8blWqV4teukuA54DZba62RIMTsYYp0dk5LyQHV6xG/
MIME-Version: 1.0
X-Received: by 2002:a24:cd82:: with SMTP id l124mr8833864itg.169.1560021186123;
 Sat, 08 Jun 2019 12:13:06 -0700 (PDT)
Date:   Sat, 08 Jun 2019 12:13:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a420af058ad4bca2@google.com>
Subject: memory leak in create_ctx
From:   syzbot <syzbot+06537213db7ba2745c4a@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    79c3ba32 Merge tag 'drm-fixes-2019-06-07-1' of git://anong..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170e0bfea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d5c73825cbdc7326
dashboard link: https://syzkaller.appspot.com/bug?extid=06537213db7ba2745c4a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aa806aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+06537213db7ba2745c4a@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
2019/06/08 14:55:51 executed programs: 15
2019/06/08 14:55:56 executed programs: 31
2019/06/08 14:56:02 executed programs: 51
BUG: memory leak
unreferenced object 0xffff888117ceae00 (size 512):
   comm "syz-executor.3", pid 7233, jiffies 4294949016 (age 13.640s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000e6550967>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000e6550967>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000e6550967>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000e6550967>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000014132182>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000014132182>] kzalloc include/linux/slab.h:742 [inline]
     [<0000000014132182>] create_ctx+0x25/0x70 net/tls/tls_main.c:601
     [<00000000e08e1a44>] tls_init net/tls/tls_main.c:787 [inline]
     [<00000000e08e1a44>] tls_init+0x97/0x1e0 net/tls/tls_main.c:769
     [<0000000037b0c43c>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<0000000037b0c43c>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<000000007a284277>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2784
     [<00000000f35f3415>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3098
     [<00000000c840962c>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3124
     [<0000000006b0801f>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000a6309f52>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000a6309f52>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000a6309f52>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fa555bbc>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000a06d7d1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810965dc00 (size 512):
   comm "syz-executor.2", pid 7235, jiffies 4294949016 (age 13.640s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000e6550967>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000e6550967>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000e6550967>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000e6550967>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000014132182>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000014132182>] kzalloc include/linux/slab.h:742 [inline]
     [<0000000014132182>] create_ctx+0x25/0x70 net/tls/tls_main.c:601
     [<00000000e08e1a44>] tls_init net/tls/tls_main.c:787 [inline]
     [<00000000e08e1a44>] tls_init+0x97/0x1e0 net/tls/tls_main.c:769
     [<0000000037b0c43c>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<0000000037b0c43c>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<000000007a284277>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2784
     [<00000000f35f3415>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3098
     [<00000000c840962c>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3124
     [<0000000006b0801f>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000a6309f52>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000a6309f52>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000a6309f52>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fa555bbc>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000a06d7d1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881207d7600 (size 512):
   comm "syz-executor.5", pid 7244, jiffies 4294949019 (age 13.610s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000e6550967>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000e6550967>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000e6550967>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000e6550967>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000014132182>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000014132182>] kzalloc include/linux/slab.h:742 [inline]
     [<0000000014132182>] create_ctx+0x25/0x70 net/tls/tls_main.c:601
     [<00000000e08e1a44>] tls_init net/tls/tls_main.c:787 [inline]
     [<00000000e08e1a44>] tls_init+0x97/0x1e0 net/tls/tls_main.c:769
     [<0000000037b0c43c>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<0000000037b0c43c>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<000000007a284277>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2784
     [<00000000f35f3415>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3098
     [<00000000c840962c>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3124
     [<0000000006b0801f>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000a6309f52>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000a6309f52>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000a6309f52>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fa555bbc>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000a06d7d1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
