Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F57C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A925D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfDWQWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:22:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54678 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:22:09 -0400
Received: by mail-io1-f71.google.com with SMTP id c17so13403447iom.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YncEbg9ZhXb+5O+uJ7Ce4S6rOwaZKK+qKUv3Yy+tRLI=;
        b=drLaAEAS/A0Embw4aW3CKqZh5JTMgn9SLKJ7QbkkozS53PSK6utBBztqIJcMEzifIw
         B5ONlicUK9I3eN+NXjjln4BAHPf82JXLt6P7y2VqDfDAxTwBXwoGOdu2geKO5lP2IYMK
         TDOzGApOPqcO5SBcGq6ntrYGqDkAbR1VXFEKNqd56/zvsMeJCCwbxUCX/x4M0dzktOpk
         uZA6U41HBN1OWroM67BoDC7/Lyua/PU/DFyv6yURtHs/ZTx8hZb5VNxiRzLB9/G+uZhH
         mSVCd4UOhRF7pOeSWwEpAgQEvMi8u8bABYcHA8Jhk7iXoueJB0axH2qhGP0X8nQS1mh8
         8O0g==
X-Gm-Message-State: APjAAAVpLMOMZ9sswZ6iVQy2VLw1F9QMi+WRrpuqN2eo3XP7SQyTgotO
        gIjsMGPcro9LMHJsEit3UKhsXaapsJTirVjcd+RguEOAlfBQ
X-Google-Smtp-Source: APXvYqyo3pkQ09VVSg4igpwnfDZdO5VFlJqh9SJyoraK28mi0z7IRaJbdMnMg2gZjxUW85E38hAGuRSGPKrkR+zGRFSwXm8V8fdS
MIME-Version: 1.0
X-Received: by 2002:a5d:9152:: with SMTP id y18mr1742205ioq.165.1556036528324;
 Tue, 23 Apr 2019 09:22:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:22:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000876c89058734fc71@google.com>
Subject: KASAN: use-after-free Read in rfcomm_dlc_open (2)
From:   syzbot <syzbot+0b0fd24d40f358830891@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gustavo@embeddedor.com,
        johan.hedberg@gmail.com, keescook@chromium.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tiny.windzz@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    432bc230 Merge branch 'hsr-next'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169eb223200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f97fc6e35679794
dashboard link: https://syzkaller.appspot.com/bug?extid=0b0fd24d40f358830891
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b0fd24d40f358830891@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in rfcomm_dlc_get  
net/bluetooth/rfcomm/core.c:360 [inline]
BUG: KASAN: use-after-free in __rfcomm_dlc_open  
net/bluetooth/rfcomm/core.c:396 [inline]
BUG: KASAN: use-after-free in rfcomm_dlc_open+0xc85/0xd60  
net/bluetooth/rfcomm/core.c:431
Read of size 1 at addr ffff888096921444 by task syz-executor.1/12781

CPU: 1 PID: 12781 Comm: syz-executor.1 Not tainted 5.1.0-rc4+ #140
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:129
  rfcomm_dlc_get net/bluetooth/rfcomm/core.c:360 [inline]
  __rfcomm_dlc_open net/bluetooth/rfcomm/core.c:396 [inline]
  rfcomm_dlc_open+0xc85/0xd60 net/bluetooth/rfcomm/core.c:431
  rfcomm_sock_connect+0x38a/0x4b0 net/bluetooth/rfcomm/sock.c:416
  __sys_connect+0x266/0x330 net/socket.c:1808
  __do_sys_connect net/socket.c:1819 [inline]
  __se_sys_connect net/socket.c:1816 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1816
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f730c7eac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
RDX: 000000000000000e RSI: 0000000020000040 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f730c7eb6d4
R13: 00000000004beff7 R14: 00000000004d0098 R15: 00000000ffffffff

Allocated by task 12282:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc_node mm/slab.c:3688 [inline]
  __kmalloc_node_track_caller+0x4e/0x70 mm/slab.c:3702
  __kmalloc_reserve.isra.0+0x40/0xf0 net/core/skbuff.c:142
  __alloc_skb+0x10b/0x5e0 net/core/skbuff.c:210
  alloc_skb include/linux/skbuff.h:1056 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0x97b/0xd70 net/netlink/af_netlink.c:1900
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x3e2/0x930 net/socket.c:2260
  __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2355
  __do_sys_sendmmsg net/socket.c:2384 [inline]
  __se_sys_sendmmsg net/socket.c:2381 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2381
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 12282:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3500 [inline]
  kfree+0xcf/0x230 mm/slab.c:3823
  skb_free_head+0x93/0xb0 net/core/skbuff.c:559
  skb_release_data+0x576/0x7a0 net/core/skbuff.c:579
  skb_release_all+0x4d/0x60 net/core/skbuff.c:633
  __kfree_skb net/core/skbuff.c:647 [inline]
  consume_skb net/core/skbuff.c:707 [inline]
  consume_skb+0xe2/0x380 net/core/skbuff.c:701
  netlink_unicast_kernel net/netlink/af_netlink.c:1311 [inline]
  netlink_unicast+0x53e/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x3e2/0x930 net/socket.c:2260
  __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2355
  __do_sys_sendmmsg net/socket.c:2384 [inline]
  __se_sys_sendmmsg net/socket.c:2381 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2381
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888096921300
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 324 bytes inside of
  512-byte region [ffff888096921300, ffff888096921500)
The buggy address belongs to the page:
page:ffffea00025a4840 count:1 mapcount:0 mapping:ffff88812c3f0940  
index:0xffff888096921d00
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000285acc8 ffffea00021aaa88 ffff88812c3f0940
raw: ffff888096921d00 ffff888096921080 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888096921300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888096921380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888096921400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff888096921480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888096921500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
