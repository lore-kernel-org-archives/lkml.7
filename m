Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69C206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEGJrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:47:13 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:39162 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEGJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:47:08 -0400
Received: by mail-it1-f200.google.com with SMTP id z125so14161731itf.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3oIQ/axrwaPl/lQ6Bw4C9U12ijTMz2r5vR/r27S1hVI=;
        b=UGL+iIutB6+Ton/h2iKyQHWC5+sAeVLWMETvhoZ7wjlC8Q7ZiEuYv7/83jHBM82AFI
         CrW031zRTTfPdt39D3wwaS+Ckyx0+ugk9lBzmod7G7ZaYZrszfeZmmq8aiw5O4Ks+llr
         BgY6ep/zcufCCe+j26d6Db4QPupzneOJd5K58deJLZNdZgVoULDGlzVl91Ww4dwnhxrk
         geBhg6cjpfcHzbeWEpv+m+dW1qYth1VI/cc3sO7XC7Bbu+q0XK2jPQdKdao/D/SS6h8m
         rZnG+uGbytwYj/O2BG8+s7lzGuDqdz6K++LJLpsWZ3xy4wQOqPcgoRS1+nIT+d9HZOS0
         y5bg==
X-Gm-Message-State: APjAAAV9n/2wCqLZaoCgYnEmrtjDNRuDot+qOEDZ8h3W2jrQ81JDK9J5
        yyiOC0EbI9NAxMjtMJ8EgrLGsWXcYs0t79vel8ABiUjN2JX5
X-Google-Smtp-Source: APXvYqynaCrllFXrpp1849mgB2TbZ4GJFpRB0hRhSDplz6oKeuFXJK5LMjhEjVn6h7AArynXyEBMKUgEIVL7hMl+7Gw5ZvxClu/T
MIME-Version: 1.0
X-Received: by 2002:a24:fc46:: with SMTP id b67mr21307311ith.4.1557222426279;
 Tue, 07 May 2019 02:47:06 -0700 (PDT)
Date:   Tue, 07 May 2019 02:47:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e076b0588491997@google.com>
Subject: KASAN: use-after-free Read in page_get_anon_vma
From:   syzbot <syzbot+6a309df008e9bd6f5075@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, borntraeger@de.ibm.com,
        hughd@google.com, jglisse@redhat.com,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    771acc7e Bluetooth: btusb: request wake pin with NOAUTOEN
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac0abf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=6a309df008e9bd6f5075
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a309df008e9bd6f5075@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in atomic_fetch_add_unless  
include/linux/atomic-fallback.h:1086 [inline]
BUG: KASAN: use-after-free in atomic_add_unless  
include/linux/atomic-fallback.h:1111 [inline]
BUG: KASAN: use-after-free in atomic_inc_not_zero  
include/linux/atomic-fallback.h:1127 [inline]
BUG: KASAN: use-after-free in page_get_anon_vma+0x24b/0x4b0 mm/rmap.c:477
Read of size 4 at addr ffff88809f2398f0 by task kswapd0/1553

CPU: 0 PID: 1553 Comm: kswapd0 Not tainted 5.1.0-rc4+ #61
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
  kswapd+0x615/0x1010 mm/vmscan.c:3895
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 11425:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:505
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc mm/slab.c:3394 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3556
  kmem_cache_zalloc include/linux/slab.h:732 [inline]
  __alloc_file+0x27/0x300 fs/file_table.c:100
  alloc_empty_file+0x72/0x170 fs/file_table.c:150
  path_openat+0xef/0x46e0 fs/namei.c:3522
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1069
  __do_sys_open fs/open.c:1087 [inline]
  __se_sys_open fs/open.c:1082 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1082
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11435:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3500 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3766
  file_free_rcu+0x98/0xe0 fs/file_table.c:49
  __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
  rcu_do_batch kernel/rcu/tree.c:2475 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
  rcu_core+0x928/0x1390 kernel/rcu/tree.c:2769
  __do_softirq+0x266/0x95a kernel/softirq.c:293

The buggy address belongs to the object at ffff88809f2397c0
  which belongs to the cache filp of size 456
The buggy address is located 304 bytes inside of
  456-byte region [ffff88809f2397c0, ffff88809f239988)
The buggy address belongs to the page:
page:ffffea00027c8e40 count:1 mapcount:0 mapping:ffff88821bc45380 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00025571c8 ffffea000235d288 ffff88821bc45380
raw: 0000000000000000 ffff88809f239040 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809f239780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff88809f239800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809f239880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff88809f239900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809f239980: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
