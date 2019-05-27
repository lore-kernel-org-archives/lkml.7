Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF11C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465B620859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfE0TiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:38:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38843 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfE0TiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:38:06 -0400
Received: by mail-io1-f71.google.com with SMTP id w3so14314881iot.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=smJJwdpD5XqR7z9Nn9fIRuGNSRexHkI4IXg81KzawCk=;
        b=CwnzX0eOGnZHzr1lyUsjDn2nZLf4XvMGlmxfyE0h8ycOkC8z7a2Brge45bTle2TI8H
         eiSUGfhC3CAV0XeBNWeZd0yFbvuBhqInm/ec9/negSFZjXYEA0swtuGWl7dkPzHV14b2
         l8CxEmaQTTyCIYtITNaSpztPsUZUaCSEb3k7urqLx+DgHvuarwClALFeoC3g1Mc3d9xO
         V7hiaTkf1pQ/7ED/W3ceS+VuOmJL0I0BovhLkSbxmYnLSWu9iBm1YfzYJwJQiw/CzmtH
         iih09tYwmmSZDZ6YOFLE0Qc/3nhThg+EhFWcBM3cFyvbFasFr6hvadof9IpNctUYlQrI
         e4Og==
X-Gm-Message-State: APjAAAVdyjLcYVAXKUbmSvRVV6IRdM1eixtRhvAvxuyhS7xs2WaPbezQ
        EV3QCdKKEqYKzV2Xc5ADVEoqaJG9X1C5Fcs7XFMh9LaHIoIt
X-Google-Smtp-Source: APXvYqwky3sEAXZcN2OtVOufbqzljTqmeUSy62PV0hLZ7Rhq8KEalyl9az8EFovKdM3EaObVFltI2l9LfpoF6OyZCWlVVrNlQ8Rx
MIME-Version: 1.0
X-Received: by 2002:a5d:8357:: with SMTP id q23mr15131783ior.10.1558985885482;
 Mon, 27 May 2019 12:38:05 -0700 (PDT)
Date:   Mon, 27 May 2019 12:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea09dd0589e3af1a@google.com>
Subject: memory leak in hsr_create_self_node
From:   syzbot <syzbot+c6167ec3de7def23d1e8@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cd6c84d8 Linux 5.2-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169e2952a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=c6167ec3de7def23d1e8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138b0aa2a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c6167ec3de7def23d1e8@syzkaller.appspotmail.com

ave B (hsr_slave_1) is not up; please bring it up to get a fully working  
HSR network
BUG: memory leak
unreferenced object 0xffff88811ffca300 (size 128):
   comm "syz-executor.0", pid 7073, jiffies 4295038954 (age 112.640s)
   hex dump (first 32 bytes):
     f0 18 ec 12 81 88 ff ff f0 18 ec 12 81 88 ff ff  ................
     76 54 a9 82 3f 36 6e 79 03 07 32 da 00 00 00 00  vT..?6ny..2.....
   backtrace:
     [<0000000043ebf44e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000043ebf44e>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000043ebf44e>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000043ebf44e>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000090fd7552>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000090fd7552>] hsr_create_self_node+0x42/0x150  
net/hsr/hsr_framereg.c:84
     [<00000000b676ec58>] hsr_dev_finalize+0xa4/0x233  
net/hsr/hsr_device.c:441
     [<000000006f2c807a>] hsr_newlink+0xf3/0x140 net/hsr/hsr_netlink.c:69
     [<0000000089911cdb>] __rtnl_newlink+0x892/0xb30  
net/core/rtnetlink.c:3191
     [<000000001adebee5>] rtnl_newlink+0x4e/0x80 net/core/rtnetlink.c:3249
     [<000000002aa25337>] rtnetlink_rcv_msg+0x178/0x4b0  
net/core/rtnetlink.c:5218
     [<000000005a15ce29>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2486
     [<000000009d5f6d12>] rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5236
     [<00000000d359aece>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1311 [inline]
     [<00000000d359aece>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1337
     [<00000000520aeaa0>] netlink_sendmsg+0x26a/0x480  
net/netlink/af_netlink.c:1926
     [<00000000b4fd9df3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b4fd9df3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000005d72c299>] __sys_sendto+0x148/0x1f0 net/socket.c:1964
     [<0000000019b507bd>] __do_sys_sendto net/socket.c:1976 [inline]
     [<0000000019b507bd>] __se_sys_sendto net/socket.c:1972 [inline]
     [<0000000019b507bd>] __x64_sys_sendto+0x2a/0x30 net/socket.c:1972
     [<00000000ae8ddd19>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000003c7f1886>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811bd6e500 (size 64):
   comm "syz-executor.0", pid 7073, jiffies 4295038954 (age 112.640s)
   hex dump (first 32 bytes):
     40 ef d6 1b 81 88 ff ff 00 02 00 00 00 00 ad de  @...............
     00 10 ec 12 81 88 ff ff c0 18 ec 12 81 88 ff ff  ................
   backtrace:
     [<0000000043ebf44e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000043ebf44e>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000043ebf44e>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000043ebf44e>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000009232eb2b>] kmalloc include/linux/slab.h:547 [inline]
     [<000000009232eb2b>] kzalloc include/linux/slab.h:742 [inline]
     [<000000009232eb2b>] hsr_add_port+0xe7/0x220 net/hsr/hsr_slave.c:142
     [<0000000062ddb58d>] hsr_dev_finalize+0x14f/0x233  
net/hsr/hsr_device.c:472
     [<000000006f2c807a>] hsr_newlink+0xf3/0x140 net/hsr/hsr_netlink.c:69
     [<0000000089911cdb>] __rtnl_newlink+0x892/0xb30  
net/core/rtnetlink.c:3191
     [<000000001adebee5>] rtnl_newlink+0x4e/0x80 net/core/rtnetlink.c:3249
     [<000000002aa25337>] rtnetlink_rcv_msg+0x178/0x4b0  
net/core/rtnetlink.c:5218
     [<000000005a15ce29>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2486
     [<000000009d5f6d12>] rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5236
     [<00000000d359aece>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1311 [inline]
     [<00000000d359aece>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1337
     [<00000000520aeaa0>] netlink_sendmsg+0x26a/0x480  
net/netlink/af_netlink.c:1926
     [<00000000b4fd9df3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b4fd9df3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000005d72c299>] __sys_sendto+0x148/0x1f0 net/socket.c:1964
     [<0000000019b507bd>] __do_sys_sendto net/socket.c:1976 [inline]
     [<0000000019b507bd>] __se_sys_sendto net/socket.c:1972 [inline]
     [<0000000019b507bd>] __x64_sys_sendto+0x2a/0x30 net/socket.c:1972
     [<00000000ae8ddd19>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000003c7f1886>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811bd6ef40 (size 64):
   comm "syz-executor.0", pid 7073, jiffies 4295038960 (age 112.580s)
   hex dump (first 32 bytes):
     d0 18 ec 12 81 88 ff ff 00 02 00 00 00 00 ad de  ................
     00 a0 27 21 81 88 ff ff c0 18 ec 12 81 88 ff ff  ..'!............
   backtrace:
     [<0000000043ebf44e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000043ebf44e>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000043ebf44e>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000043ebf44e>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000009232eb2b>] kmalloc include/linux/slab.h:547 [inline]
     [<000000009232eb2b>] kzalloc include/linux/slab.h:742 [inline]
     [<000000009232eb2b>] hsr_add_port+0xe7/0x220 net/hsr/hsr_slave.c:142
     [<0000000013dde593>] hsr_dev_finalize+0x1d1/0x233  
net/hsr/hsr_device.c:480
     [<000000006f2c807a>] hsr_newlink+0xf3/0x140 net/hsr/hsr_netlink.c:69
     [<0000000089911cdb>] __rtnl_newlink+0x892/0xb30  
net/core/rtnetlink.c:3191
     [<000000001adebee5>] rtnl_newlink+0x4e/0x80 net/core/rtnetlink.c:3249
     [<000000002aa25337>] rtnetlink_rcv_msg+0x178/0x4b0  
net/core/rtnetlink.c:5218
     [<000000005a15ce29>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2486
     [<000000009d5f6d12>] rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5236
     [<00000000d359aece>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1311 [inline]
     [<00000000d359aece>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1337
     [<00000000520aeaa0>] netlink_sendmsg+0x26a/0x480  
net/netlink/af_netlink.c:1926
     [<00000000b4fd9df3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b4fd9df3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000005d72c299>] __sys_sendto+0x148/0x1f0 net/socket.c:1964
     [<0000000019b507bd>] __do_sys_sendto net/socket.c:1976 [inline]
     [<0000000019b507bd>] __se_sys_sendto net/socket.c:1972 [inline]
     [<0000000019b507bd>] __x64_sys_sendto+0x2a/0x30 net/socket.c:1972
     [<00000000ae8ddd19>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000003c7f1886>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
