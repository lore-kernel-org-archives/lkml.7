Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2641C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53852070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfJGS7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:59:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47520 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfJGS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:59:13 -0400
Received: by mail-io1-f72.google.com with SMTP id k14so28264072iot.14
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=D1Rzqs57q4Yo8rGXxQE8fz7RbZ2OYbOlKi0YRILAdQ0=;
        b=UNy+4JRjsDi2N2vSMEuvGo99ZjvRqoMkixG+Q5xFsNn7JoaH3/WJj2Wdca+29Nf7xY
         zkV2G5C+WBy+Kp++HDjDyWKzktM18pkX9/q677GJQJyOdJ4o170+eFnjB2jDLuskn74W
         0OxhJaVhe3o8bN18q3ee8LMxxttK2CgJW2elnuOoi1+TkKV1GvbZ3+4HXEzzwvdLQ4lP
         lUjyGheFyqSjtOh0vp8/YE1PPpOgtO41xPaRsSZ3NfyD/aMpKTX3L5jJw+GhW/IL3l37
         sCAiBYnBcP9FaSJIr4kHDiJkjLGU36TyAMcv0StbaUPLT3NwTUjPMXmpAy4k7RPHZeLg
         Qe2g==
X-Gm-Message-State: APjAAAVU7r7Tg3riQf/Zf5QMmQiW9Uevub2nkkYnCzfBUuVBa+ygjfIl
        wXrgIG/VMrKzBdjtZMIQgouz+yN97evMJKf12Z14a0z7Syva
X-Google-Smtp-Source: APXvYqyBxWBZEb5lGFBokbhDsqR+DLYhL9ye6EpAn51e3WNudFfGKq+RFOZQoXzK7FYnkPWV78HNz6GqMYk39VsJbggqP9xb9hAt
MIME-Version: 1.0
X-Received: by 2002:a5e:da05:: with SMTP id x5mr11424319ioj.123.1570474752380;
 Mon, 07 Oct 2019 11:59:12 -0700 (PDT)
Date:   Mon, 07 Oct 2019 11:59:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be9b38059456a529@google.com>
Subject: KASAN: use-after-free Read in tipc_nl_publ_dump
From:   syzbot <syzbot+ff59dc711f2cff879a05@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=176f00dd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
dashboard link: https://syzkaller.appspot.com/bug?extid=ff59dc711f2cff879a05
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153b1e67600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1354f6c3600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ff59dc711f2cff879a05@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in nla_parse_nested_deprecated  
include/net/netlink.h:1166 [inline]
BUG: KASAN: use-after-free in tipc_nl_publ_dump+0xb5c/0xd60  
net/tipc/socket.c:3597
Read of size 2 at addr ffff888086ff7d54 by task syz-executor167/8888

CPU: 0 PID: 8888 Comm: syz-executor167 Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:130
  nla_parse_nested_deprecated include/net/netlink.h:1166 [inline]
  tipc_nl_publ_dump+0xb5c/0xd60 net/tipc/socket.c:3597
  genl_lock_dumpit+0x86/0xc0 net/netlink/genetlink.c:529
  netlink_dump+0x558/0xfb0 net/netlink/af_netlink.c:2244
  __netlink_dump_start+0x5b1/0x7d0 net/netlink/af_netlink.c:2352
  genl_family_rcv_msg_dumpit net/netlink/genetlink.c:614 [inline]
  genl_family_rcv_msg net/netlink/genetlink.c:710 [inline]
  genl_rcv_msg+0xc9b/0x1000 net/netlink/genetlink.c:730
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
RIP: 0033:0x445239
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffd09ea0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445239
RDX: 0000000000000000 RSI: 0000000020000680 RDI: 0000000000000003
RBP: 000000000000fc90 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004023d0
R13: 0000000000402460 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8889:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  __do_kmalloc_node mm/slab.c:3615 [inline]
  __kmalloc_node_track_caller+0x4e/0x70 mm/slab.c:3629
  __kmalloc_reserve.isra.0+0x40/0xf0 net/core/skbuff.c:141
  __alloc_skb+0x10b/0x5e0 net/core/skbuff.c:209
  alloc_skb include/linux/skbuff.h:1049 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1174 [inline]
  netlink_sendmsg+0x972/0xd60 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:657
  ___sys_sendmsg+0x803/0x920 net/socket.c:2311
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2356
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg net/socket.c:2363 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8889:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  skb_free_head+0x93/0xb0 net/core/skbuff.c:591
  skb_release_data+0x42d/0x7c0 net/core/skbuff.c:611
  skb_release_all+0x4d/0x60 net/core/skbuff.c:665
  __kfree_skb net/core/skbuff.c:679 [inline]
  consume_skb net/core/skbuff.c:838 [inline]
  consume_skb+0xfb/0x3b0 net/core/skbuff.c:832
  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
  netlink_unicast+0x539/0x710 net/netlink/af_netlink.c:1328
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

The buggy address belongs to the object at ffff888086ff7d40
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 20 bytes inside of
  512-byte region [ffff888086ff7d40, ffff888086ff7f40)
The buggy address belongs to the page:
page:ffffea00021bfdc0 refcount:1 mapcount:0 mapping:ffff8880aa400a80  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00029bfc48 ffffea00025f55c8 ffff8880aa400a80
raw: 0000000000000000 ffff888086ff70c0 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888086ff7c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888086ff7c80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> ffff888086ff7d00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff888086ff7d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888086ff7e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
