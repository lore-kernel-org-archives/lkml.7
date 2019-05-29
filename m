Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75076C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D9A2413A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE2USG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:18:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51387 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2USG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:18:06 -0400
Received: by mail-io1-f70.google.com with SMTP id i20so2767309ioo.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LKEz7XTZ4qr1/XdWlgCrAy6dfMnUYHHEKllZWvUwqVI=;
        b=LbNK4gyC8h9a3ORYuau691nG2e6FjHiFCvyguY34/tWKVGOq+rVo21NnT/aeIP6SUz
         anvD1Hb9lEHC67+j5yLQPa5FyYS3N4nE7Dv5rcPWa3pmSASMm3nU4Dzk874gjkNYJwRY
         vytku5nOpuQCthS3uHLdCRgqrXBin9qatxdUB7mUAIvhOUuIedcZuLZL8ZAW2QEqry9U
         Hwl5Xh6Fwv7l1ZuwU4VIxoOyGGORfbomEhKHpII6Nr0B9JCCpOaVq9gCDXlcrm2S1CIq
         1UdSZZHyw/9ZsNWweLftqurEQ5E5ih0CvqZkkIW8nmqGDK0vTJuaO12FpNXPZ59CPA4R
         tOZg==
X-Gm-Message-State: APjAAAUOUnT1e5unXtzp7BebPQcYdoPrb6+jSh9z6PTm3ZUVZ3exltdx
        vAy3L7JDwoSTEQfp0hv9jB2Iil5RXsXsUGa/zGF7FVL2boxx
X-Google-Smtp-Source: APXvYqzvVxVAHNou2Z0JaDILwh5XC9INnPe18/MwMxlAaS+3+d7wuVTTgJmnuK++bU6CaL5R1gRXPm2uk+odi2PdKTc0W8tsRp4A
MIME-Version: 1.0
X-Received: by 2002:a02:1a45:: with SMTP id 66mr80221047jai.124.1559161085617;
 Wed, 29 May 2019 13:18:05 -0700 (PDT)
Date:   Wed, 29 May 2019 13:18:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7f012058a0c7a65@google.com>
Subject: memory leak in nr_loopback_queue
From:   syzbot <syzbot+470d1a4a7b7a7c225881@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9fb67d64 Merge tag 'pinctrl-v5.2-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15956d52a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=470d1a4a7b7a7c225881
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bc96a2a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+470d1a4a7b7a7c225881@syzkaller.appspotmail.com

2019/05/29 16:46:11 executed programs: 584
2019/05/29 16:46:19 executed programs: 614
2019/05/29 16:46:26 executed programs: 624
2019/05/29 16:46:33 executed programs: 640
2019/05/29 16:46:41 executed programs: 654
BUG: memory leak
unreferenced object 0xffff888117e5ba00 (size 224):
   comm "syz-executor.2", pid 10957, jiffies 4294999655 (age 10.170s)
   hex dump (first 32 bytes):
     d0 50 cc 17 81 88 ff ff d0 50 cc 17 81 88 ff ff  .P.......P......
     00 00 00 00 00 00 00 00 00 10 b2 08 81 88 ff ff  ................
   backtrace:
     [<00000000af44a575>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000af44a575>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000af44a575>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000af44a575>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<000000007d2ff911>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<00000000f697bd2b>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<00000000f697bd2b>] nr_loopback_queue+0x26/0xc0  
net/netrom/nr_loopback.c:37
     [<00000000eb3a969d>] nr_route_frame+0x2d1/0x340  
net/netrom/nr_route.c:775
     [<000000002dad2e7e>] nr_transmit_buffer+0x86/0xc0  
net/netrom/nr_out.c:212
     [<000000006d8f7662>] nr_write_internal+0x133/0x2e0  
net/netrom/nr_subr.c:208
     [<0000000004553967>] nr_establish_data_link+0x2d/0x60  
net/netrom/nr_out.c:230
     [<000000000382326a>] nr_connect+0x13b/0x490 net/netrom/af_netrom.c:716
     [<00000000a27cdfc2>] __sys_connect+0x11d/0x170 net/socket.c:1840
     [<0000000074ede9c3>] __do_sys_connect net/socket.c:1851 [inline]
     [<0000000074ede9c3>] __se_sys_connect net/socket.c:1848 [inline]
     [<0000000074ede9c3>] __x64_sys_connect+0x1e/0x30 net/socket.c:1848
     [<000000000940d4eb>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000307bfe5c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
