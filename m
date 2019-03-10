Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7706C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 14:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928BB20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 14:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCJO4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 10:56:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:53187 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfCJO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 10:56:06 -0400
Received: by mail-it1-f197.google.com with SMTP id z131so2739829itb.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 07:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hNWWAVDPLpAUdrwcvgKvVdbfR4j2gQ5/r/uNV7cboXc=;
        b=g6peDdv9BV3VT2vaSwlC0gwqUIRxwHVmE2ivsTRL5yISGKwG9Kteh5LN50X8svK/Ub
         SMD5/RIIFG2x0zNQoSDgp2+ZtSDbJsn9tjw9bP4A8cf0H1+aGC8PF4mqnpnw3amTJbQ4
         SO4y5p5bfazb25gVL3t2x9qEo8eVrCEsHtL9JIuitxzgeIISfXkC8IpxXe36IGMZzQMA
         /K8LMtm8Sm+qHHrtPRdCGX81vfbVKvKuX3uFkUMHVDdlP4BNM3/FKFmKeOUxSd1m545g
         dlXWrxxJ5VEVxF5LRV2XWjVLIGHabEf6evV5t1YxdQfIDMVNm9N4xJZDnmq0Z/x1RoCO
         ARJQ==
X-Gm-Message-State: APjAAAVuTnAQl6/EzCKPv/RRIQ2EhlaLQ3dBZ5AU6x9LVrFXo22NGJI4
        2ajWJrQ/37BqJxqbLvlsL9u/awyy7/vaJqqdiFOlmJMPNtmU
X-Google-Smtp-Source: APXvYqwsrbaFsmcB9mK7qg3nwkqSrnXJF7r3E2zR2LApv+2TE6A9ChdzOm81Otpc30xIY23kyUdEsNFSTnDELHTZBw5ZiFuCW3cc
MIME-Version: 1.0
X-Received: by 2002:a24:6f55:: with SMTP id x82mr18591653itb.13.1552229765197;
 Sun, 10 Mar 2019 07:56:05 -0700 (PDT)
Date:   Sun, 10 Mar 2019 07:56:05 -0700
In-Reply-To: <000000000000cdc755057e2da575@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3ba940583bea717@google.com>
Subject: Re: KASAN: use-after-free Read in x25_device_event
From:   syzbot <syzbot+04babcefcd396fabec37@syzkaller.appspotmail.com>
To:     -O-request@vger.kernel.org, andrew.hendry@gmail.com,
        davem@davemloft.net, dvlasenk@redhat.com, edumazet@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d9862cfb Merge tag 'mips_5.1' of git://git.kernel.org/pub/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1531cf23200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=04babcefcd396fabec37
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100ffdad200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c2599d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+04babcefcd396fabec37@syzkaller.appspotmail.com

device ifb0 entered promiscuous mode
device ifb0 left promiscuous mode
device ifb0 entered promiscuous mode
device ifb0 left promiscuous mode
==================================================================
BUG: KASAN: use-after-free in x25_kill_by_device net/x25/af_x25.c:217  
[inline]
BUG: KASAN: use-after-free in x25_device_event+0x296/0x2b0  
net/x25/af_x25.c:252
Read of size 8 at addr ffff8880a030edd0 by task syz-executor003/7854

CPU: 0 PID: 7854 Comm: syz-executor003 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  x25_kill_by_device net/x25/af_x25.c:217 [inline]
  x25_device_event+0x296/0x2b0 net/x25/af_x25.c:252
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x1e9/0x2c0 net/core/dev.c:7607
  dev_change_flags+0x10d/0x170 net/core/dev.c:7643
  dev_ifsioc+0x2b0/0x940 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b8/0xc70 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1bd/0x300 net/socket.c:995
  sock_ioctl+0x32b/0x610 net/socket.c:1096
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4467c9
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdbea222d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 00000000004467c9
RDX: 0000000020000340 RSI: 0000000000008914 RDI: 0000000000000003
RBP: 00000000006dbc50 R08: 00007fdbea223700 R09: 0000000000000000
R10: 00007fdbea223700 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 6000030030626669 R14: 0000000000000000 R15: 0000000030626669

Allocated by task 7843:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:495 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:468
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:509
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3615
  kmalloc include/linux/slab.h:545 [inline]
  x25_link_device_up+0x46/0x3f0 net/x25/x25_link.c:249
  x25_device_event+0x116/0x2b0 net/x25/af_x25.c:242
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x121/0x2c0 net/core/dev.c:7605
  dev_change_flags+0x10d/0x170 net/core/dev.c:7643
  dev_ifsioc+0x2b0/0x940 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b8/0xc70 net/core/dev_ioctl.c:488
  sock_do_ioctl+0x1bd/0x300 net/socket.c:995
  sock_ioctl+0x32b/0x610 net/socket.c:1096
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7865:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:457
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:465
  __cache_free mm/slab.c:3494 [inline]
  kfree+0xcf/0x230 mm/slab.c:3811
  x25_neigh_put include/net/x25.h:253 [inline]
  x25_connect+0x8d8/0xde0 net/x25/af_x25.c:824
  __sys_connect+0x266/0x330 net/socket.c:1685
  __do_sys_connect net/socket.c:1696 [inline]
  __se_sys_connect net/socket.c:1693 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1693
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a030edc0
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 16 bytes inside of
  256-byte region [ffff8880a030edc0, ffff8880a030eec0)
The buggy address belongs to the page:
page:ffffea000280c380 count:1 mapcount:0 mapping:ffff88812c3f07c0 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002806788 ffffea00027f0188 ffff88812c3f07c0
raw: 0000000000000000 ffff8880a030e000 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a030ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a030ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a030ed80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff8880a030ee00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a030ee80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

