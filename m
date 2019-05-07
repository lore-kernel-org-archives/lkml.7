Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A7DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE41204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfEGJrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:47:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48375 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEGJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:47:08 -0400
Received: by mail-io1-f70.google.com with SMTP id l6so4785037ioc.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l0D8gQvxKh7Z3h8wbBtEpumYKF//fhR75fm+NzGuohs=;
        b=gF30690oyAz5v5+KFA2LtbmQ6AqHdXTU10QJcWB0wxetX6niNsKPtHSSqwPXCVpd7Q
         qUK78l94GyfPDR0N0+kwriRyQvJdgZS7/+oqqLFCk7PkG3iYk7Zje+zjXr7KqDUDHQBz
         gb+P7IhuzMus6bpvYO4bppi3J8Rl8HrjgHb/Rit1BWRavv/15SoGLMP8fZk0BOJ7Rukp
         JLRX5cPO/EQ5WTq6sJB1nkjh5+vytywnKihjACG24YU1UZkefzW4YlxyXw7g/m/+xJ0u
         WsJs2V+E0oxGXtBg47dBgXoBHtaicTPEEuh9Bvcc71G5P7ypXbz3QzF7RtYh0HP7t8NB
         Ms0A==
X-Gm-Message-State: APjAAAUfKgwAFhVyB4MJu15tkv/LCHp/VgaUB/svuOX62N3zt6cWGVU5
        IrKQtgXKDZSaxIp6ymUb229KiN1Q4eoLSp6Jl3+KXYaa9z3X
X-Google-Smtp-Source: APXvYqx/lUtNcp9NDktcPEFhaOuhXF0e5SMHREQ0TaJWZp505PDe7VQcaZfbq39jhv9QWKJgCWKQSY/qGEh6zQdNHkFJwlwAkEsq
MIME-Version: 1.0
X-Received: by 2002:a24:c242:: with SMTP id i63mr1145675itg.89.1557222426056;
 Tue, 07 May 2019 02:47:06 -0700 (PDT)
Date:   Tue, 07 May 2019 02:47:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008aa0e4058849190e@google.com>
Subject: KASAN: slab-out-of-bounds Read in page_get_anon_vma
From:   syzbot <syzbot+ed3e5c9a6a1e30a1bd2a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, borntraeger@de.ibm.com,
        hughd@google.com, jglisse@redhat.com,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    444fe991 Merge tag 'riscv-for-linus-5.1-rc6' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15771dd3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=ed3e5c9a6a1e30a1bd2a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ed3e5c9a6a1e30a1bd2a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_fetch_add_unless  
include/linux/atomic-fallback.h:1086 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_add_unless  
include/linux/atomic-fallback.h:1111 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_inc_not_zero  
include/linux/atomic-fallback.h:1127 [inline]
BUG: KASAN: slab-out-of-bounds in page_get_anon_vma+0x24b/0x4b0  
mm/rmap.c:477
Read of size 4 at addr ffff8880a06d0f08 by task kswapd0/1552

CPU: 1 PID: 1552 Comm: kswapd0 Not tainted 5.1.0-rc5+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:102
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  atomic_fetch_add_unless include/linux/atomic-fallback.h:1086 [inline]
  atomic_add_unless include/linux/atomic-fallback.h:1111 [inline]
  atomic_inc_not_zero include/linux/atomic-fallback.h:1127 [inline]
  page_get_anon_vma+0x24b/0x4b0 mm/rmap.c:477
  split_huge_page_to_list+0x58a/0x2de0 mm/huge_memory.c:2675
  split_huge_page include/linux/huge_mm.h:148 [inline]
  deferred_split_scan+0x64b/0xa60 mm/huge_memory.c:2853
  do_shrink_slab+0x400/0xa80 mm/vmscan.c:551
  shrink_slab mm/vmscan.c:700 [inline]
  shrink_slab+0x4be/0x5e0 mm/vmscan.c:680
  shrink_node+0x552/0x1570 mm/vmscan.c:2724
  kswapd_shrink_node mm/vmscan.c:3482 [inline]
  balance_pgdat+0x56c/0xe80 mm/vmscan.c:3640
  kswapd+0x5f4/0xfd0 mm/vmscan.c:3895
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 988:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc_node mm/slab.c:3688 [inline]
  __kmalloc_node_track_caller+0x4e/0x70 mm/slab.c:3702
  __kmalloc_reserve.isra.0+0x40/0xf0 net/core/skbuff.c:140
  __alloc_skb+0x10b/0x5e0 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1058 [inline]
  alloc_skb_with_frags+0x93/0x580 net/core/skbuff.c:5287
  sock_alloc_send_pskb+0x72d/0x8a0 net/core/sock.c:2220
  sock_alloc_send_skb+0x32/0x40 net/core/sock.c:2237
  __ip6_append_data.isra.0+0x2144/0x3600 net/ipv6/ip6_output.c:1451
  ip6_make_skb+0x32f/0x570 net/ipv6/ip6_output.c:1814
  udpv6_sendmsg+0x2191/0x28d0 net/ipv6/udp.c:1470
  inet_sendmsg+0x147/0x5d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x3e2/0x930 net/socket.c:2260
  __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2355
  __do_sys_sendmmsg net/socket.c:2384 [inline]
  __se_sys_sendmmsg net/socket.c:2381 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2381
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 988:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3500 [inline]
  kfree+0xcf/0x230 mm/slab.c:3823
  skb_free_head+0x93/0xb0 net/core/skbuff.c:557
  skb_release_data+0x576/0x7a0 net/core/skbuff.c:577
  skb_release_all+0x4d/0x60 net/core/skbuff.c:631
  __kfree_skb net/core/skbuff.c:645 [inline]
  kfree_skb net/core/skbuff.c:663 [inline]
  kfree_skb+0xe8/0x390 net/core/skbuff.c:657
  __udpv6_queue_rcv_skb net/ipv6/udp.c:598 [inline]
  udpv6_queue_rcv_one_skb+0x1002/0x1440 net/ipv6/udp.c:684
  udpv6_queue_rcv_skb+0x128/0x730 net/ipv6/udp.c:701
  udp6_unicast_rcv_skb.isra.0+0x151/0x2f0 net/ipv6/udp.c:845
  __udp6_lib_rcv+0x9a6/0x2cc0 net/ipv6/udp.c:926
  udplitev6_rcv+0x22/0x30 net/ipv6/udplite.c:20
  ip6_protocol_deliver_rcu+0x303/0x16c0 net/ipv6/ip6_input.c:394
  ip6_input_finish+0x84/0x170 net/ipv6/ip6_input.c:434
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip6_input+0xe4/0x3f0 net/ipv6/ip6_input.c:443
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x1e7/0x320 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ipv6_rcv+0x10e/0x420 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5085
  process_backlog+0x206/0x750 net/core/dev.c:5925
  napi_poll net/core/dev.c:6348 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6414
  __do_softirq+0x266/0x95a kernel/softirq.c:293

The buggy address belongs to the object at ffff8880a06d0cc0
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 72 bytes to the right of
  512-byte region [ffff8880a06d0cc0, ffff8880a06d0ec0)
The buggy address belongs to the page:
page:ffffea000281b400 count:1 mapcount:0 mapping:ffff88812c3f0940  
index:0xffff8880a06d0a40
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0000ec7b88 ffffea00015bb688 ffff88812c3f0940
raw: ffff8880a06d0a40 ffff8880a06d0040 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a06d0e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a06d0e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8880a06d0f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
  ffff8880a06d0f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a06d1000: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
