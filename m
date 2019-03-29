Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4B20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfC2SLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:11:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41290 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfC2SLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:11:06 -0400
Received: by mail-io1-f70.google.com with SMTP id e126so2356085ioa.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JYyK5lXFLFuS91oDUtkrKu7xWU95hCO6Z9/5Pk05uv4=;
        b=UXrEICrc3t+KoKbilaFP3RdFEote7x7CJBoC5SLFFDbd/EBMWwDBRJkM4a1joQ9s8P
         d2aFiJkbK7VO+dDDu2xRrFlqgD5YgiHLTdZER59fKlpeoX6EQ+Zk4afv8TozEWaFRWno
         t9cxZezLrOKkK9XELwQGjljE5y/NMylLrRFrpn7420rV8GwONdt333U5uPWLjmrg2iUq
         w5GGrGplO2+UZsg0GJW9Hq11GwyyszvU1iem2qV27BRwu/2FCQJxMESr3DHCplFw4U1P
         ul6GXFGt6552pOG4noJRnAsfFEnzEL7T0PFi4psb5ODFTWvej5D0xjV1s14hY+XJv66G
         0Hmg==
X-Gm-Message-State: APjAAAV1kahiAqO8GEsbZncqyvA58ZRMf1zFP53+MnXooD2g2j9DAbGr
        Mq/BY0bdnE/KJlA+lVSy0DwTsH3qlAZXc8oKfPw5R6XiscZI
X-Google-Smtp-Source: APXvYqwPDmvcpicGroWcZatWBBr/6oafw6fgA+puNfBOa5tk2r5tEnDH4hH48Db0IxGBqNbly/BMWUEGT8BpBQShymaLChq8/LWv
MIME-Version: 1.0
X-Received: by 2002:a5e:cb0d:: with SMTP id p13mr224200iom.17.1553883065345;
 Fri, 29 Mar 2019 11:11:05 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:11:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021ef3505853f988e@google.com>
Subject: KASAN: slab-out-of-bounds Read in fib6_rule_lookup (2)
From:   syzbot <syzbot+49f38f33f3c5d76cb19b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d29f5aa0 net: phy: don't clear BMCR in genphy_soft_reset
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=137c421f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=49f38f33f3c5d76cb19b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+49f38f33f3c5d76cb19b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in fib6_rule_lookup+0x4e2/0x560  
net/ipv6/fib6_rules.c:119
Read of size 2 at addr ffff888093537380 by task syz-executor.5/24048

CPU: 1 PID: 24048 Comm: syz-executor.5 Not tainted 5.0.0+ #138
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:130
  fib6_rule_lookup+0x4e2/0x560 net/ipv6/fib6_rules.c:119
  ip6_route_input_lookup+0xb7/0xd0 net/ipv6/route.c:1937
  ip6_route_input+0x5e2/0x9e0 net/ipv6/route.c:2072
  ip6_rcv_finish_core.isra.0+0x174/0x590 net/ipv6/ip6_input.c:63
  ip6_rcv_finish+0x17d/0x320 net/ipv6/ip6_input.c:74
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ipv6_rcv+0x10e/0x420 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  netif_receive_skb_internal+0x117/0x660 net/core/dev.c:5186
  napi_frags_finish net/core/dev.c:5753 [inline]
  napi_gro_frags+0xade/0xd10 net/core/dev.c:5827
  tun_get_user+0x2f24/0x3fb0 drivers/net/tun.c:1981
  tun_chr_write_iter+0xbd/0x156 drivers/net/tun.c:2027
  call_write_iter include/linux/fs.h:1863 [inline]
  do_iter_readv_writev+0x5e1/0x8e0 fs/read_write.c:680
  do_iter_write fs/read_write.c:956 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:937
  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1001
  do_writev+0xf6/0x290 fs/read_write.c:1036
  __do_sys_writev fs/read_write.c:1109 [inline]
  __se_sys_writev fs/read_write.c:1106 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1106
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4580c1
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 e4 b9 fb ff c3 48  
83 ec 08 e8 1a 2d 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 63 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fd134cfaba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000300b00 RCX: 00000000004580c1
RDX: 0000000000000001 RSI: 00007fd134cfac00 RDI: 00000000000000f0
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fd134cfb6d4
R13: 00000000004c6848 R14: 00000000004dbd70 R15: 00000000ffffffff

Allocated by task 7627:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:505
  slab_post_alloc_hook mm/slab.h:436 [inline]
  slab_alloc mm/slab.c:3392 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3554
  anon_vma_alloc mm/rmap.c:82 [inline]
  __anon_vma_prepare+0x1b1/0x3c0 mm/rmap.c:190
  anon_vma_prepare include/linux/rmap.h:153 [inline]
  do_anonymous_page mm/memory.c:2947 [inline]
  handle_pte_fault mm/memory.c:3807 [inline]
  __handle_mm_fault+0x34db/0x3ec0 mm/memory.c:3933
  handle_mm_fault+0x43f/0xb30 mm/memory.c:3970
  faultin_page mm/gup.c:538 [inline]
  __get_user_pages+0x7b6/0x1a40 mm/gup.c:741
  __get_user_pages_locked mm/gup.c:917 [inline]
  get_user_pages_remote+0x21d/0x440 mm/gup.c:1109
  get_arg_page fs/exec.c:216 [inline]
  copy_strings.isra.0+0x3dc/0x890 fs/exec.c:559
  copy_strings_kernel+0xa5/0x110 fs/exec.c:604
  __do_execve_file.isra.0+0x10ef/0x23f0 fs/exec.c:1803
  do_execveat_common fs/exec.c:1865 [inline]
  do_execve fs/exec.c:1882 [inline]
  __do_sys_execve fs/exec.c:1958 [inline]
  __se_sys_execve fs/exec.c:1953 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880935372b8
  which belongs to the cache anon_vma of size 168
The buggy address is located 32 bytes to the right of
  168-byte region [ffff8880935372b8, ffff888093537360)
The buggy address belongs to the page:
page:ffffea00024d4dc0 count:1 mapcount:0 mapping:ffff88812c294c00  
index:0xffff888093537fef
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffff88812c28f648 ffffea0002695b08 ffff88812c294c00
raw: ffff888093537fef ffff888093537000 0000000100000011 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888093537280: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
  ffff888093537300: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> ffff888093537380: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
                    ^
  ffff888093537400: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
  ffff888093537480: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
