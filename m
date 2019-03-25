Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B33C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0161320879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfCYDbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:31:06 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:44788 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbfCYDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:31:06 -0400
Received: by mail-it1-f197.google.com with SMTP id v193so1762819itv.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 20:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oQjXmVMaP/oyvUBqnjIWAYRirnW0VYKegubWsao+q50=;
        b=NruVCuL238YFJSe+QK78kq5k3RiBc1eIYcwfIIZK2VNNXm+sxn4TcCWIZql9cNkxGi
         QB85QjNSDmlCorLcPGxXjU/CHrYR/QO3qw09sIYZ5mycqaRraA+NlwNy0ld3GYed9nkV
         4TQUPPsJPBnZEGCzlEEH037w7SdWmbH3eKKfNAtxIBwsFsmJRoOrFhUEPghnDdfEn+ap
         NyJSAHy//wxzBsC0wrO5u6/+7XRFZEzYnSjMFJaC85xKeQKa6keyfmsdbYmD6/ns5Dgc
         yMfcKcvrU12lZRZEXztbKMZkYpD/UdK5xIz1wYr4yOpJ3L/ajXNsKRXbGZL99yb5GA3g
         MhWg==
X-Gm-Message-State: APjAAAUCigzo4Na5DzMhwtRS77UZn+P9o6Zn+2R34weQclzeRw7FzTS2
        K9jQxYGd7a49IBsgIfIX5yat4/tTW24i7ct9IJqBfWrLDn/m
X-Google-Smtp-Source: APXvYqwHGyHNcj+AGYFy2PzPQaLu90/OFlcoN5SnxygMSOUqBD5IAeSbWdVXY1HOje7rAzD5DSVlRKh/I8QRiAuT0zVib8FQCbgU
MIME-Version: 1.0
X-Received: by 2002:a05:660c:985:: with SMTP id z5mr8884888itj.39.1553484664811;
 Sun, 24 Mar 2019 20:31:04 -0700 (PDT)
Date:   Sun, 24 Mar 2019 20:31:04 -0700
In-Reply-To: <0000000000003ba80905783e9189@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c39fb0584e2d532@google.com>
Subject: Re: KASAN: use-after-free Write in skb_release_data (2)
From:   syzbot <syzbot+580be3953ed99133804f@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, lirongqing@baidu.com,
        magnus.karlsson@intel.com, maximmi@mellanox.com,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, vincent.whitchurch@axis.com,
        willemb@google.com, yhs@fb.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    68cc2999 Merge branch 'devlink-small-spring-cleanup'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13737c07200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ab5bbbbf283c99a
dashboard link: https://syzkaller.appspot.com/bug?extid=580be3953ed99133804f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123a3d3b200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d34f93200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+580be3953ed99133804f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_sub_return  
include/asm-generic/atomic-instrumented.h:159 [inline]
BUG: KASAN: use-after-free in skb_release_data+0x11d/0x7a0  
net/core/skbuff.c:566
Write of size 4 at addr ffff88808dee74e0 by task syz-executor887/7877

CPU: 0 PID: 7877 Comm: syz-executor887 Not tainted 5.0.0+ #108
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_write+0x14/0x20 mm/kasan/common.c:108
  atomic_sub_return include/asm-generic/atomic-instrumented.h:159 [inline]
  skb_release_data+0x11d/0x7a0 net/core/skbuff.c:566
  skb_release_all+0x4d/0x60 net/core/skbuff.c:631
  __kfree_skb net/core/skbuff.c:645 [inline]
  kfree_skb net/core/skbuff.c:663 [inline]
  kfree_skb+0xe8/0x390 net/core/skbuff.c:657
  skb_queue_purge+0x19/0x40 net/core/skbuff.c:2906
  packet_release+0x8eb/0xbf0 net/packet/af_packet.c:3026
  __sock_release+0xd3/0x2b0 net/socket.c:599
  sock_close+0x1b/0x30 net/socket.c:1247
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x90a/0x2fa0 kernel/exit.c:876
  do_group_exit+0x135/0x370 kernel/exit.c:980
  get_signal+0x399/0x1d50 kernel/signal.c:2575
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4474d9
Code: 7a 6c 69 62 77 00 73 74 72 65 61 6d 2e 63 00 6f 70 65 6e 20 65 72 72  
6f 72 20 25 64 2c 20 66 69 6c 65 20 27 25 73 27 3a 20 25 <73> 0a 00 66 69  
6c 65 20 25 64 20 69 73 20 61 20 74 74 79 2d 74 79
RSP: 002b:00007f7ce163fdb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006ddc38 RCX: 00000000004474d9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006ddc38
RBP: 00000000006ddc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc3c
R13: 00007ffe04f36bbf R14: 00007f7ce16409c0 R15: 000000000000002d

Allocated by task 7876:
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
  sk_stream_alloc_skb+0x113/0xd10 net/ipv4/tcp.c:889
  tcp_connect+0xfd8/0x4280 net/ipv4/tcp_output.c:3521
  tcp_v4_connect+0x1514/0x1c40 net/ipv4/tcp_ipv4.c:315
  __inet_stream_connect+0x83f/0xea0 net/ipv4/af_inet.c:659
  tcp_sendmsg_fastopen net/ipv4/tcp.c:1158 [inline]
  tcp_sendmsg_locked+0x2314/0x34d0 net/ipv4/tcp.c:1200
  tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1434
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  __sys_sendto+0x262/0x380 net/socket.c:1932
  __do_sys_sendto net/socket.c:1944 [inline]
  __se_sys_sendto net/socket.c:1940 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1940
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7877:
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
  skb_queue_purge+0x19/0x40 net/core/skbuff.c:2906
  packet_release+0x8eb/0xbf0 net/packet/af_packet.c:3026
  __sock_release+0xd3/0x2b0 net/socket.c:599
  sock_close+0x1b/0x30 net/socket.c:1247
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x90a/0x2fa0 kernel/exit.c:876
  do_group_exit+0x135/0x370 kernel/exit.c:980
  get_signal+0x399/0x1d50 kernel/signal.c:2575
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808dee7200
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 736 bytes inside of
  1024-byte region [ffff88808dee7200, ffff88808dee7600)
The buggy address belongs to the page:
page:ffffea000237b980 count:1 mapcount:0 mapping:ffff88812c3f0ac0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea000224ba08 ffffea0002a63288 ffff88812c3f0ac0
raw: 0000000000000000 ffff88808dee6000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808dee7380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808dee7400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808dee7480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff88808dee7500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808dee7580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

