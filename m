Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F57BC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfDWQXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:23:10 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:54361 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:23:10 -0400
Received: by mail-it1-f197.google.com with SMTP id w1so499635itk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QO+eLIBhxCR9r8X65WBSMftvotF2gbjPGPAwkQ3k9Fg=;
        b=n3hWrkAO/k2JAxY6cwP7vn/4QiueqRVwiKAgDo9jVnF6muob9TINmRA/7S8EbKniYK
         g1hZIaZ/6bAQ54WR9EtokwVksEcnimqkI/gg2Ci6Yqs8ypG8QUDpKlTwNmmO29tOLwEj
         PwgpsRvRrBB3pWbF62biMLf3oaGsx6sV/FicbXAk9dEyK3ttvj9C5nuDZBNDudvXFMms
         VLfC5/wyurFAQxsxg2nEb6gpKMRyY+IYZayV1Zu1Jyt6ar8QCl7ZtU+0FKR6nCZp0IL/
         fnNd9Nchuet87r04xbFOZqylWL3VXuC2ZwzbATqwHf8xi8G+/EH38LGTiJ6upXC3HAXr
         wlZA==
X-Gm-Message-State: APjAAAXXlDvBZg/Gn6xmyJemqRzuez1zqNNDK5tqrm4MaCV44g2niopO
        FxotBYNtcF76iWD6495FoZImzPk3v02QE3yh5dx5d84p5rdo
X-Google-Smtp-Source: APXvYqwsGTK0+jjTiTtftQ3p2ZxhM3EaN+yHWXWTsYCUfgolrhf/gRfsMAwZet1b60z3xqB5rmz28KMzX5G8LtECZVFJvd5H5wpP
MIME-Version: 1.0
X-Received: by 2002:a02:c90a:: with SMTP id t10mr15997024jao.68.1556036589197;
 Tue, 23 Apr 2019 09:23:09 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:23:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000282a870587350077@google.com>
Subject: KASAN: use-after-free Read in xfrm_sk_policy_lookup (2)
From:   syzbot <syzbot+edb62c973ff9f07e408d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f9221a7a Add linux-next specific files for 20190415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105982cb200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5593069f14799e67
dashboard link: https://syzkaller.appspot.com/bug?extid=edb62c973ff9f07e408d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+edb62c973ff9f07e408d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in xfrm_sk_policy_lookup+0x4aa/0x510  
net/xfrm/xfrm_policy.c:2162
Read of size 2 at addr ffff888097eb6b5e by task syz-executor.3/8005

CPU: 0 PID: 8005 Comm: syz-executor.3 Not tainted 5.1.0-rc4-next-20190415  
#25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  __kasan_report.cold+0x1b/0x40 mm/kasan/report.c:316
  kasan_report+0x12/0x20 mm/kasan/common.c:623
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:130
  xfrm_sk_policy_lookup+0x4aa/0x510 net/xfrm/xfrm_policy.c:2162
  xfrm_lookup_with_ifid+0x1de/0x1ce0 net/xfrm/xfrm_policy.c:3046
  xfrm_lookup net/xfrm/xfrm_policy.c:3183 [inline]
  xfrm_lookup_route+0x3b/0x1f0 net/xfrm/xfrm_policy.c:3194
  ip6_dst_lookup_flow+0x189/0x220 net/ipv6/ip6_output.c:1100
  inet6_csk_route_socket+0x85d/0xf40 net/ipv6/inet6_connection_sock.c:110
  inet6_csk_xmit+0x110/0x5d0 net/ipv6/inet6_connection_sock.c:125
  l2tp_xmit_core net/l2tp/l2tp_core.c:1033 [inline]
  l2tp_xmit_skb+0x1114/0x13e0 net/l2tp/l2tp_core.c:1135
  pppol2tp_sendmsg+0x4a2/0x6b0 net/l2tp/l2tp_ppp.c:329
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x3e2/0x930 net/socket.c:2260
  __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2355
  __do_sys_sendmmsg net/socket.c:2384 [inline]
  __se_sys_sendmmsg net/socket.c:2381 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2381
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f948c242c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458c29
RDX: 0800000000000059 RSI: 0000000020005fc0 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f948c2436d4
R13: 00000000004c5e19 R14: 00000000004da5e0 R15: 00000000ffffffff

Allocated by task 8005:
  save_stack+0x45/0xd0 mm/kasan/common.c:76
  set_track mm/kasan/common.c:88 [inline]
  __kasan_kmalloc mm/kasan/common.c:498 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:471
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:512
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3621
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  xfrm_policy_alloc+0x88/0x420 net/xfrm/xfrm_policy.c:383
  xfrm_compile_policy+0x254/0x430 net/xfrm/xfrm_user.c:3000
  xfrm_user_policy+0x28e/0x820 net/xfrm/xfrm_state.c:2079
  do_ipv6_setsockopt.isra.0+0x3b0c/0x49e0 net/ipv6/ipv6_sockglue.c:834
  ipv6_setsockopt+0xfc/0x170 net/ipv6/ipv6_sockglue.c:946
  udpv6_setsockopt+0x68/0xb0 net/ipv6/udp.c:1570
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
  __sys_setsockopt+0x180/0x280 net/socket.c:2046
  __do_sys_setsockopt net/socket.c:2057 [inline]
  __se_sys_setsockopt net/socket.c:2054 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8023:
  save_stack+0x45/0xd0 mm/kasan/common.c:76
  set_track mm/kasan/common.c:88 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:460
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:468
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3821
  xfrm_policy_destroy_rcu+0x48/0x60 net/xfrm/xfrm_policy.c:407
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2092 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2310 [inline]
  rcu_core+0xbac/0x1510 kernel/rcu/tree.c:2291
  __do_softirq+0x266/0x95a kernel/softirq.c:293

The buggy address belongs to the object at ffff888097eb6940
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 542 bytes inside of
  1024-byte region [ffff888097eb6940, ffff888097eb6d40)
The buggy address belongs to the page:
page:ffffea00025fad80 count:1 mapcount:0 mapping:ffff88812c3f0ac0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea000244fb08 ffffea0002643a88 ffff88812c3f0ac0
raw: 0000000000000000 ffff888097eb6040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888097eb6a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888097eb6a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888097eb6b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff888097eb6b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888097eb6c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
