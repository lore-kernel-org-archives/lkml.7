Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA53218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfCTVWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:22:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:50916 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:22:06 -0400
Received: by mail-it1-f200.google.com with SMTP id i63so659209itb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sOdPf80vOSMkUMWceEuQ0LAPOFOLqVpNp3d6ZZTmzbE=;
        b=ErTSjPU3RhNoW/TAoQkHgaqTI1+UIhIornS+7f3m7tX+P3iQhwAeXrrOq3lGXUURuk
         I6UofCWASkZtU1z4DEjs7CNhi8hfkGeB0AzzS/fx1jzLajfRaXDtcl5hL9uibLdhFs77
         5e5qRMpOTmVgXYwoUojBnmXk86+YQmR9BjoBeVI8gSd42ZqYIXZ8hwkVzBQ0hrpkHWii
         zKyFkaUeI5ld+ezG1E1j72fDZj7mC7WkPcauqY7MwJ03ReU67xLpl8qxdw/fr13fX+g6
         WNPNxkf6DslTEj/N1aeJgTdNZE2ZxkT7i3KOGR2fwa7OxB2fK4XtAG8yfxKIN478BG7s
         AG1Q==
X-Gm-Message-State: APjAAAXmojkCdOQBiyS1K6NkbBhcJhhAO4X+WcpM4ZSLf1Tw9Zw9Sgi+
        604+JGgqdZpSoGqP+CsNsbctXfnLI3cCKkPuj4rDpXng0zBu
X-Google-Smtp-Source: APXvYqwWH/jt+nNbiZ367OPAs/CMyBJ5J4qW51bx+wjLAP++8zfe01JDVmco2X+2Q6kI1+toD1KALWDsQ1foTyqHgtKxARBfN6tN
MIME-Version: 1.0
X-Received: by 2002:a5e:8a07:: with SMTP id d7mr54861iok.7.1553116925624; Wed,
 20 Mar 2019 14:22:05 -0700 (PDT)
Date:   Wed, 20 Mar 2019 14:22:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a58e5905848d362d@google.com>
Subject: KASAN: use-after-free Read in tipc_sk_filter_rcv
From:   syzbot <syzbot+e863893591cc7a622e40@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hoang.h.le@dektech.com.au,
        jon.maloy@ericsson.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a0cfa79f ibmveth: Make array ibmveth_stats static
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=154bec17200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=e863893591cc7a622e40
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160f4c17200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c2ea6d200000

The bug was bisected to:

commit c55c8edafa91139419ed011f7d036274ce96be0b
Author: Hoang Le <hoang.h.le@dektech.com.au>
Date:   Tue Mar 19 11:49:50 2019 +0000

     tipc: smooth change between replicast and broadcast

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128c2007200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=118c2007200000
console output: https://syzkaller.appspot.com/x/log.txt?x=168c2007200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e863893591cc7a622e40@syzkaller.appspotmail.com
Fixes: c55c8eda ("tipc: smooth change between replicast and broadcast")

==================================================================
BUG: KASAN: use-after-free in tipc_sk_filter_rcv+0x2166/0x34f0  
net/tipc/socket.c:2167
Read of size 4 at addr ffff88808ea58534 by task kworker/u4:0/7

CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.0.0+ #61
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: tipc_send tipc_conn_send_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
  tipc_sk_filter_rcv+0x2166/0x34f0 net/tipc/socket.c:2167
  tipc_sk_enqueue net/tipc/socket.c:2254 [inline]
  tipc_sk_rcv+0xc45/0x25a0 net/tipc/socket.c:2305
  tipc_topsrv_kern_evt+0x3b7/0x580 net/tipc/topsrv.c:610
  tipc_conn_send_to_sock+0x43e/0x5f0 net/tipc/topsrv.c:283
  tipc_conn_send_work+0x65/0x80 net/tipc/topsrv.c:303
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 7:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc_node mm/slab.c:3686 [inline]
  __kmalloc_node_track_caller+0x4e/0x70 mm/slab.c:3700
  __kmalloc_reserve.isra.0+0x40/0xf0 net/core/skbuff.c:140
  __alloc_skb+0x10b/0x5e0 net/core/skbuff.c:208
  alloc_skb_fclone include/linux/skbuff.h:1107 [inline]
  tipc_buf_acquire+0x2f/0x100 net/tipc/msg.c:66
  tipc_msg_create+0x38/0x270 net/tipc/msg.c:98
  tipc_topsrv_kern_evt+0x2a7/0x580 net/tipc/topsrv.c:602
  tipc_conn_send_to_sock+0x43e/0x5f0 net/tipc/topsrv.c:283
  tipc_conn_send_work+0x65/0x80 net/tipc/topsrv.c:303
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 7:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3821
  skb_free_head+0x93/0xb0 net/core/skbuff.c:557
  skb_release_data+0x576/0x7a0 net/core/skbuff.c:577
  skb_release_all+0x4d/0x60 net/core/skbuff.c:631
  __kfree_skb net/core/skbuff.c:645 [inline]
  kfree_skb net/core/skbuff.c:663 [inline]
  kfree_skb+0xe8/0x390 net/core/skbuff.c:657
  tipc_sk_proto_rcv net/tipc/socket.c:2009 [inline]
  tipc_sk_filter_rcv+0x1e6a/0x34f0 net/tipc/socket.c:2162
  tipc_sk_enqueue net/tipc/socket.c:2254 [inline]
  tipc_sk_rcv+0xc45/0x25a0 net/tipc/socket.c:2305
  tipc_topsrv_kern_evt+0x3b7/0x580 net/tipc/topsrv.c:610
  tipc_conn_send_to_sock+0x43e/0x5f0 net/tipc/topsrv.c:283
  tipc_conn_send_work+0x65/0x80 net/tipc/topsrv.c:303
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88808ea58480
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 180 bytes inside of
  1024-byte region [ffff88808ea58480, ffff88808ea58880)
The buggy address belongs to the page:
page:ffffea00023a9600 count:1 mapcount:0 mapping:ffff88812c3f0ac0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00021bbd88 ffffea00023db488 ffff88812c3f0ac0
raw: 0000000000000000 ffff88808ea58000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808ea58400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808ea58480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808ea58500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff88808ea58580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808ea58600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
