Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBFFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7024A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfDWQZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:25:08 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:57913 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDWQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:25:06 -0400
Received: by mail-it1-f197.google.com with SMTP id p23so488090itc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MOLxJpCwh0AhhgXnQ3bGD+qLZTI7wH62AGIX27n8NBM=;
        b=elR/N2h1wNKrdEEeaxaKi2Cb5LNt8waIjZ+3krUSshq1fyvJhlumwCWXgmeyT94MWS
         qU9azU/pBcLv0JFNw2nViSGtsWFCaC6vUjeJBsBUjsi2np9gHsV2gvis7nq7h0SL4M+o
         fb05COIaAEh4qhqwpNw337KlPookNDrMydEATyDuFmVf9YfCmxEqzQI9UAOPtgTTLTOU
         p0OW+3cKBDBYAnnAIF9TT4bNkUvoS81RFRfIzCDSVZAtbMsPMCRfHtZyL+nNkjb3534g
         noQWz3H/pj4XOEJsNWKnEVZgeCtpfBrdtT53tiCOovUhKTVPiVMhR3uxyJI3QFBw0M1A
         gZmw==
X-Gm-Message-State: APjAAAWKEjbhez26/ukpGFiQn9d6yb4wnhDQ5uKOw7sytsWENervlqVe
        MCROjh+GqBhYn31JNN9bG/GGOG9whkmw+YAXJqscDS87sPVk
X-Google-Smtp-Source: APXvYqw4e/s8YbeRwAVPGNY7Ll95GV7hgVv+RDkdXwNYzfpC33wScJewiTfYCHkRmPn+WlMg75jU8siSfx3idkmDcehVyZ3OsgT4
MIME-Version: 1.0
X-Received: by 2002:a02:b819:: with SMTP id o25mr18713743jam.69.1556036705463;
 Tue, 23 Apr 2019 09:25:05 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:25:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001645670587350783@google.com>
Subject: KASAN: slab-out-of-bounds Read in fib6_rule_action
From:   syzbot <syzbot+3edc8b0bf48d614ae4ef@syzkaller.appspotmail.com>
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

HEAD commit:    73248801 Merge tag 'mlx5-fixes-2019-04-09' of git://git.ke..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10cb89d3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=3edc8b0bf48d614ae4ef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3edc8b0bf48d614ae4ef@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __fib6_rule_action  
net/ipv6/fib6_rules.c:241 [inline]
BUG: KASAN: slab-out-of-bounds in fib6_rule_action+0x922/0xaa0  
net/ipv6/fib6_rules.c:264
Read of size 2 at addr ffff888098e1af37 by task syz-executor.0/24393

CPU: 1 PID: 24393 Comm: syz-executor.0 Not tainted 5.1.0-rc4+ #167
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:130
  __fib6_rule_action net/ipv6/fib6_rules.c:241 [inline]
  fib6_rule_action+0x922/0xaa0 net/ipv6/fib6_rules.c:264
  fib_rules_lookup+0x351/0xa90 net/core/fib_rules.c:304
  fib6_rule_lookup+0x340/0x560 net/ipv6/fib6_rules.c:110
  ip6_route_output_flags+0x2c4/0x350 net/ipv6/route.c:2111
  ip6_route_output include/net/ip6_route.h:88 [inline]
  ip6_dst_lookup_tail+0xd10/0x1b30 net/ipv6/ip6_output.c:966
  ip6_dst_lookup_flow+0xa8/0x220 net/ipv6/ip6_output.c:1094
  sctp_v6_get_dst+0x785/0x1d80 net/sctp/ipv6.c:293
  sctp_transport_route+0x132/0x370 net/sctp/transport.c:312
  sctp_assoc_add_peer+0x53e/0xfc0 net/sctp/associola.c:678
  sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
  sctp_process_init+0x249f/0x2b20 net/sctp/sm_make_chunk.c:2361
  sctp_cmd_process_init net/sctp/sm_sideeffect.c:682 [inline]
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1410 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x398c/0x5770 net/sctp/sm_sideeffect.c:1191
  sctp_assoc_bh_rcv+0x343/0x660 net/sctp/associola.c:1074
  sctp_inq_push+0x1ea/0x290 net/sctp/inqueue.c:95
  sctp_backlog_rcv+0x196/0xbe0 net/sctp/input.c:354
  sk_backlog_rcv include/net/sock.h:943 [inline]
  __release_sock+0x12e/0x3a0 net/core/sock.c:2413
  release_sock+0x59/0x1c0 net/core/sock.c:2929
  sctp_wait_for_connect+0x316/0x540 net/sctp/socket.c:9048
  __sctp_connect+0xac2/0xce0 net/sctp/socket.c:1241
  __sctp_setsockopt_connectx+0x133/0x1a0 net/sctp/socket.c:1349
  sctp_setsockopt_connectx_old net/sctp/socket.c:1365 [inline]
  sctp_setsockopt net/sctp/socket.c:4656 [inline]
  sctp_setsockopt+0x15db/0x6fe0 net/sctp/socket.c:4620
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
  __sys_setsockopt+0x180/0x280 net/socket.c:2046
  __do_sys_setsockopt net/socket.c:2057 [inline]
  __se_sys_setsockopt net/socket.c:2054 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f79ac2dcc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458c29
RDX: 000000000000006b RSI: 0000000000000084 RDI: 0000000000000007
RBP: 000000000073bf00 R08: 000000000000001c R09: 0000000000000000
R10: 000000002055bfe4 R11: 0000000000000246 R12: 00007f79ac2dd6d4
R13: 00000000004ce088 R14: 00000000004dc200 R15: 00000000ffffffff

Allocated by task 10072:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:505
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc mm/slab.c:3394 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3556
  dst_alloc+0x10e/0x200 net/core/dst.c:109
  ip6_dst_alloc+0x34/0xa0 net/ipv6/route.c:355
  ip6_rt_pcpu_alloc net/ipv6/route.c:1225 [inline]
  rt6_make_pcpu_route net/ipv6/route.c:1255 [inline]
  ip6_pol_route+0x743/0x1040 net/ipv6/route.c:1909
  ip6_pol_route_output+0x54/0x70 net/ipv6/route.c:2082
  fib6_rule_lookup+0x128/0x560 net/ipv6/fib6_rules.c:118
  ip6_route_output_flags+0x2c4/0x350 net/ipv6/route.c:2111
  ip6_route_output include/net/ip6_route.h:88 [inline]
  ip6_dst_lookup_tail+0xd10/0x1b30 net/ipv6/ip6_output.c:966
  ip6_dst_lookup_flow+0xa8/0x220 net/ipv6/ip6_output.c:1094
  sctp_v6_get_dst+0x785/0x1d80 net/sctp/ipv6.c:293
  sctp_transport_route+0x132/0x370 net/sctp/transport.c:312
  sctp_assoc_add_peer+0x53e/0xfc0 net/sctp/associola.c:678
  sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
  sctp_process_init+0x249f/0x2b20 net/sctp/sm_make_chunk.c:2361
  sctp_sf_do_5_1B_init+0x8ba/0xe50 net/sctp/sm_statefuns.c:416
  sctp_do_sm+0x12c/0x5770 net/sctp/sm_sideeffect.c:1188
  sctp_endpoint_bh_rcv+0x451/0x950 net/sctp/endpointola.c:458
  sctp_inq_push+0x1ea/0x290 net/sctp/inqueue.c:95
  sctp_rcv+0x2850/0x3600 net/sctp/input.c:271
  sctp6_rcv+0x17/0x30 net/sctp/ipv6.c:1063
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
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4987
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5099
  process_backlog+0x206/0x750 net/core/dev.c:5939
  napi_poll net/core/dev.c:6362 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6428
  __do_softirq+0x266/0x95a kernel/softirq.c:293

Freed by task 16:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3500 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3766
  dst_destroy+0x2a0/0x3c0 net/core/dst.c:145
  dst_destroy_rcu+0x16/0x19 net/core/dst.c:158
  __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
  rcu_do_batch kernel/rcu/tree.c:2475 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
  rcu_core+0x928/0x1390 kernel/rcu/tree.c:2769
  __do_softirq+0x266/0x95a kernel/softirq.c:293

The buggy address belongs to the object at ffff888098e1ae40
  which belongs to the cache ip6_dst_cache of size 224
The buggy address is located 23 bytes to the right of
  224-byte region [ffff888098e1ae40, ffff888098e1af20)
The buggy address belongs to the page:
page:ffffea0002638680 count:1 mapcount:0 mapping:ffff888216454240 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00023e8808 ffffea000266c808 ffff888216454240
raw: 0000000000000000 ffff888098e1a080 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888098e1ae00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
  ffff888098e1ae80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888098e1af00: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
                                      ^
  ffff888098e1af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888098e1b000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
