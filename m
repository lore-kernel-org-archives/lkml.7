Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A9C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 05:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867FD2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 05:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLVFZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 00:25:14 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:50248 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfLVFZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 00:25:14 -0500
Received: by mail-io1-f72.google.com with SMTP id e13so2763973iob.17
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 21:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AFm7Jz/eVFNWkb4n7J7yHxipQIM/+LkqpF/SP+ZddII=;
        b=orG8Qi4YmLAw8kPCER/D1YL6qKzq8WVV6wYhzXXgX8zDyrJTocqOme+tdiz0/ps8us
         Z7JEzaEO4zhZlCEwH14jcPWJtUSQvXt/vRKq/Xgfxi1Ir6EHbqo1co06kxy7IjEm1sFc
         3Ivy4rd+w7NyW1xIqL1eCDZFap1gDlgpcHg/tnDlJSvWpA9kuepSxJ7w0TNrIsvAhDs9
         wUQSQpsViyPE6+fNEGbV2EygOOEQcYDNc7W6L8BzxPDiBD99MFmxPGJRD1K+ZXzXM0dg
         uZYZbox6affSusmdCJYC6QSIZfYfZnDKqyyfTw2OWxXWzVE0ZDCODcIE8+aujjRtjhX0
         pXWQ==
X-Gm-Message-State: APjAAAUY+h2pcau/TxlCQCT5St35mFiPsnUhNA5knl/XNivICgxgUgeb
        F9cFQUs7/bN+skz7dbwB2Vi+YECqv1jTMAgekvAMfuBhUJ7I
X-Google-Smtp-Source: APXvYqz66jvT2VKHq/SJVnxGZwOM3fUg5K3mY5EL4Bxl7HRcKo4UK0W3SG8n3r9diDz6OgBmp0vQiIdIz+IYHrVeCQq8v+U5Ef0E
MIME-Version: 1.0
X-Received: by 2002:a5d:8b96:: with SMTP id p22mr15548721iol.93.1576992311685;
 Sat, 21 Dec 2019 21:25:11 -0800 (PST)
Date:   Sat, 21 Dec 2019 21:25:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d3aa7059a442293@google.com>
Subject: memory leak in genl_family_rcv_msg_attrs_parse
From:   syzbot <syzbot+4d763213368ad8d5a49f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jiri@mellanox.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, mkubecek@suse.cz,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f1fd1610 Merge tag 'devicetree-fixes-for-5.5-2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b51e71e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e6526c42b4ad7df
dashboard link: https://syzkaller.appspot.com/bug?extid=4d763213368ad8d5a49f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a224aee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4d763213368ad8d5a49f@syzkaller.appspotmail.com

2019/12/21 18:57:43 executed programs: 1
BUG: memory leak
unreferenced object 0xffff888122a69800 (size 2048):
   comm "syz-executor.0", pid 7220, jiffies 4295041795 (age 12.350s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000ea56780b>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000ea56780b>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000ea56780b>] slab_alloc mm/slab.c:3320 [inline]
     [<00000000ea56780b>] __do_kmalloc mm/slab.c:3654 [inline]
     [<00000000ea56780b>] __kmalloc+0x169/0x300 mm/slab.c:3665
     [<000000005867ad5d>] kmalloc_array include/linux/slab.h:598 [inline]
     [<000000005867ad5d>] genl_family_rcv_msg_attrs_parse+0x12a/0x160  
net/netlink/genetlink.c:490
     [<00000000b300803a>] genl_family_rcv_msg_dumpit  
net/netlink/genetlink.c:588 [inline]
     [<00000000b300803a>] genl_family_rcv_msg net/netlink/genetlink.c:714  
[inline]
     [<00000000b300803a>] genl_rcv_msg+0x356/0x580  
net/netlink/genetlink.c:734
     [<000000007aa7803c>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<00000000cf0291ee>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:745
     [<00000000d9eda8cf>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000d9eda8cf>] netlink_unicast+0x223/0x310  
net/netlink/af_netlink.c:1328
     [<00000000d87050ed>] netlink_sendmsg+0x2c0/0x570  
net/netlink/af_netlink.c:1917
     [<0000000073d32856>] sock_sendmsg_nosec net/socket.c:639 [inline]
     [<0000000073d32856>] sock_sendmsg+0x54/0x70 net/socket.c:659
     [<00000000c88230c3>] ____sys_sendmsg+0x2d0/0x300 net/socket.c:2330
     [<00000000119fa4e9>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2384
     [<00000000196367bc>] __sys_sendmsg+0x80/0xf0 net/socket.c:2417
     [<0000000022242f1e>] __do_sys_sendmsg net/socket.c:2426 [inline]
     [<0000000022242f1e>] __se_sys_sendmsg net/socket.c:2424 [inline]
     [<0000000022242f1e>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2424
     [<000000007b63ee83>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<00000000447890a9>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811cf4a1c0 (size 32):
   comm "syz-executor.0", pid 7220, jiffies 4295041795 (age 12.350s)
   hex dump (first 32 bytes):
     c0 a7 16 84 ff ff ff ff 30 0c b2 83 ff ff ff ff  ........0.......
     00 98 a6 22 81 88 ff ff 00 00 00 00 00 00 00 00  ..."............
   backtrace:
     [<00000000e670bd2f>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000e670bd2f>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000e670bd2f>] slab_alloc mm/slab.c:3320 [inline]
     [<00000000e670bd2f>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3549
     [<000000000f637ea3>] kmalloc include/linux/slab.h:556 [inline]
     [<000000000f637ea3>] genl_dumpit_info_alloc net/netlink/genetlink.c:463  
[inline]
     [<000000000f637ea3>] genl_family_rcv_msg_dumpit  
net/netlink/genetlink.c:597 [inline]
     [<000000000f637ea3>] genl_family_rcv_msg net/netlink/genetlink.c:714  
[inline]
     [<000000000f637ea3>] genl_rcv_msg+0x385/0x580  
net/netlink/genetlink.c:734
     [<000000007aa7803c>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<00000000cf0291ee>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:745
     [<00000000d9eda8cf>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000d9eda8cf>] netlink_unicast+0x223/0x310  
net/netlink/af_netlink.c:1328
     [<00000000d87050ed>] netlink_sendmsg+0x2c0/0x570  
net/netlink/af_netlink.c:1917
     [<0000000073d32856>] sock_sendmsg_nosec net/socket.c:639 [inline]
     [<0000000073d32856>] sock_sendmsg+0x54/0x70 net/socket.c:659
     [<00000000c88230c3>] ____sys_sendmsg+0x2d0/0x300 net/socket.c:2330
     [<00000000119fa4e9>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2384
     [<00000000196367bc>] __sys_sendmsg+0x80/0xf0 net/socket.c:2417
     [<0000000022242f1e>] __do_sys_sendmsg net/socket.c:2426 [inline]
     [<0000000022242f1e>] __se_sys_sendmsg net/socket.c:2424 [inline]
     [<0000000022242f1e>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2424
     [<000000007b63ee83>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<00000000447890a9>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811cc193c0 (size 32):
   comm "syz-executor.0", pid 7225, jiffies 4295042308 (age 7.220s)
   hex dump (first 32 bytes):
     c0 a7 16 84 ff ff ff ff 30 0c b2 83 ff ff ff ff  ........0.......
     00 30 fc 0e 81 88 ff ff 00 00 00 00 00 00 00 00  .0..............
   backtrace:
     [<00000000e670bd2f>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000e670bd2f>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000e670bd2f>] slab_alloc mm/slab.c:3320 [inline]
     [<00000000e670bd2f>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3549
     [<000000000f637ea3>] kmalloc include/linux/slab.h:556 [inline]
     [<000000000f637ea3>] genl_dumpit_info_alloc net/netlink/genetlink.c:463  
[inline]
     [<000000000f637ea3>] genl_family_rcv_msg_dumpit  
net/netlink/genetlink.c:597 [inline]
     [<000000000f637ea3>] genl_family_rcv_msg net/netlink/genetlink.c:714  
[inline]
     [<000000000f637ea3>] genl_rcv_msg+0x385/0x580  
net/netlink/genetlink.c:734
     [<000000007aa7803c>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<00000000cf0291ee>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:745
     [<00000000d9eda8cf>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000d9eda8cf>] netlink_unicast+0x223/0x310  
net/netlink/af_netlink.c:1328
     [<00000000d87050ed>] netlink_sendmsg+0x2c0/0x570  
net/netlink/af_netlink.c:1917
     [<0000000073d32856>] sock_sendmsg_nosec net/socket.c:639 [inline]
     [<0000000073d32856>] sock_sendmsg+0x54/0x70 net/socket.c:659
     [<00000000c88230c3>] ____sys_sendmsg+0x2d0/0x300 net/socket.c:2330
     [<00000000119fa4e9>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2384
     [<00000000196367bc>] __sys_sendmsg+0x80/0xf0 net/socket.c:2417
     [<0000000022242f1e>] __do_sys_sendmsg net/socket.c:2426 [inline]
     [<0000000022242f1e>] __se_sys_sendmsg net/socket.c:2424 [inline]
     [<0000000022242f1e>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2424
     [<000000007b63ee83>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<00000000447890a9>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812a2966e0 (size 32):
   comm "syz-executor.0", pid 7229, jiffies 4295042309 (age 7.210s)
   hex dump (first 32 bytes):
     c0 a7 16 84 ff ff ff ff 30 0c b2 83 ff ff ff ff  ........0.......
     00 40 2d 22 81 88 ff ff 00 00 00 00 00 00 00 00  .@-"............
   backtrace:
     [<00000000e670bd2f>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000e670bd2f>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000e670bd2f>] slab_alloc mm/slab.c:3320 [inline]
     [<00000000e670bd2f>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3549
     [<000000000f637ea3>] kmalloc include/linux/slab.h:556 [inline]
     [<000000000f637ea3>] genl_dumpit_info_alloc net/netlink/genetlink.c:463  
[inline]
     [<000000000f637ea3>] genl_family_rcv_msg_dumpit  
net/netlink/genetlink.c:597 [inline]
     [<000000000f637ea3>] genl_family_rcv_msg net/netlink/genetlink.c:714  
[inline]
     [<000000000f637ea3>] genl_rcv_msg+0x385/0x580  
net/netlink/genetlink.c:734
     [<000000007aa7803c>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<00000000cf0291ee>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:745
     [<00000000d9eda8cf>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000d9eda8cf>] netlink_unicast+0x223/0x310  
net/netlink/af_netlink.c:1328
     [<00000000d87050ed>] netlink_sendmsg+0x2c0/0x570  
net/netlink/af_netlink.c:1917
     [<0000000073d32856>] sock_sendmsg_nosec net/socket.c:639 [inline]
     [<0000000073d32856>] sock_sendmsg+0x54/0x70 net/socket.c:659
     [<00000000c88230c3>] ____sys_sendmsg+0x2d0/0x300 net/socket.c:2330
     [<00000000119fa4e9>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2384
     [<00000000196367bc>] __sys_sendmsg+0x80/0xf0 net/socket.c:2417
     [<0000000022242f1e>] __do_sys_sendmsg net/socket.c:2426 [inline]
     [<0000000022242f1e>] __se_sys_sendmsg net/socket.c:2424 [inline]
     [<0000000022242f1e>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2424
     [<000000007b63ee83>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<00000000447890a9>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
