Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9AF20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfCZJGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:06:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:38510 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbfCZJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:06:06 -0400
Received: by mail-it1-f198.google.com with SMTP id r136so10916447ith.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mGKG4QfPT7IjmAQFdxvsJwaL1pOyrak6ITCgbXt955s=;
        b=cC8Wi/+Cp2HiP64Kas3Sz4n3rPgIqX1/diPwCxjlLGc0y+0e/o9Nu5VfxXw3ZenVjb
         JjtzUyDqqHhf4xN57bW2HZyjS63vm2dQcbnzF/mdpMfTBeFbH9vTgyPaL3gJBDJbdhVG
         xffOpbVVCf04Zccuow404H6gGMsFnuv/a6GnmPuSACOSp8pTjeqs6gRfVMro3yTFhCar
         lwvBo/MLx/nRDvS/G23+kSt6xTf/S8H0nPPoOTT/wm+0Lut4O33DaeWRVYZua/cGbK45
         nyGmHHGinECJHRpI82IvazcT7otIPOcDuwG7W/jf7W1+gF3q5lkfnJfhyfCqDWwu8TzA
         9cjQ==
X-Gm-Message-State: APjAAAXTMJIpQBzkI2czHnP++xECl9JyFN+rWBzfUgl7g1fMdimgrA99
        4nbvBWsjGBLoTaZ8IAaF2/+PqWgIcYp1qF3jOBiFzMzIOmZw
X-Google-Smtp-Source: APXvYqxTyYN5Bz/AyAXmosIK6xK3x1RqkqykvgHSK9UEcasP41EOqKPs2PT4Mtfae9cLguanlKTueQEuCP69Sse1XHeblkSc7P+s
MIME-Version: 1.0
X-Received: by 2002:a24:6fce:: with SMTP id x197mr15142177itb.108.1553591165566;
 Tue, 26 Mar 2019 02:06:05 -0700 (PDT)
Date:   Tue, 26 Mar 2019 02:06:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cc65f0584fba1c4@google.com>
Subject: BUG: unable to handle kernel paging request in dst_release (2)
From:   syzbot <syzbot+f7b46bf869b6ace2ea45@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, posk@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526949e8 rxrpc: avoid clang -Wuninitialized warning
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13768ff7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=f7b46bf869b6ace2ea45
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f7b46bf869b6ace2ea45@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffffffffff94f8
#PF error: [WRITE]
PGD 8874067 P4D 8874067 PUD 8876067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 28652 Comm: syz-executor.1 Not tainted 5.0.0+ #136
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:167 [inline]
RIP: 0010:arch_atomic_sub_return arch/x86/include/asm/atomic.h:179 [inline]
RIP: 0010:atomic_sub_return include/asm-generic/atomic-instrumented.h:160  
[inline]
RIP: 0010:atomic_dec_return include/linux/atomic-fallback.h:455 [inline]
RIP: 0010:dst_release net/core/dst.c:190 [inline]
RIP: 0010:dst_release+0x2f/0xb0 net/core/dst.c:185
Code: 55 41 54 49 89 fc 53 e8 1f b6 f3 fb 4d 85 e4 74 47 e8 15 b6 f3 fb 49  
8d 7c 24 40 be 04 00 00 00 e8 d6 8b 2b fc be ff ff ff ff <f0> 41 0f c1 74  
24 40 44 8d 6e ff 31 ff 44 89 ee e8 6c b7 f3 fb 45
RSP: 0018:ffff8880ae906f28 EFLAGS: 00010246
RAX: fffffbfffffff2a0 RBX: 0000000000000001 RCX: ffffffff857cae2a
RDX: 0000000000000001 RSI: 00000000ffffffff RDI: ffffffffffff94f8
RBP: ffff8880ae906f40 R08: 1ffffffffffff29f R09: fffffbfffffff2a0
R10: fffffbfffffff29f R11: ffffffffffff94fb R12: ffffffffffff94b8
R13: dffffc0000000000 R14: ffff888066d0ac80 R15: 0000000000000000
FS:  00007f7ae094d700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffff94f8 CR3: 0000000086472000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  sctp_v6_get_dst+0x12a9/0x1d80 net/sctp/ipv6.c:325
  sctp_transport_route+0x132/0x370 net/sctp/transport.c:312
  sctp_assoc_add_peer+0x53e/0xfc0 net/sctp/associola.c:678
  sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
  sctp_process_init+0x249f/0x2b20 net/sctp/sm_make_chunk.c:2361
  sctp_sf_do_5_1B_init+0x8ba/0xe50 net/sctp/sm_statefuns.c:416
  sctp_do_sm+0x124/0x53e0 net/sctp/sm_sideeffect.c:1188
  sctp_endpoint_bh_rcv+0x451/0x950 net/sctp/endpointola.c:458
  sctp_inq_push+0x1ea/0x290 net/sctp/inqueue.c:95
  sctp_rcv+0x2818/0x3570 net/sctp/input.c:271
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
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6412
  __do_softirq+0x266/0x95a kernel/softirq.c:293
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.0+0x11a/0x170 kernel/softirq.c:338
  do_softirq kernel/softirq.c:330 [inline]
  __local_bh_enable_ip+0x211/0x270 kernel/softirq.c:190
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:684 [inline]
  ip6_finish_output2+0xbcf/0x2550 net/ipv6/ip6_output.c:121
  ip6_finish_output+0x577/0xc30 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x235/0x7f0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip6_xmit+0xe41/0x20c0 net/ipv6/ip6_output.c:275
  sctp_v6_xmit+0x313/0x660 net/sctp/ipv6.c:232
  sctp_packet_transmit+0x1bc4/0x36f0 net/sctp/output.c:641
  sctp_packet_singleton net/sctp/outqueue.c:787 [inline]
  sctp_outq_flush_ctrl.constprop.0+0x6d4/0xd50 net/sctp/outqueue.c:918
  sctp_outq_flush+0xe8/0x2780 net/sctp/outqueue.c:1200
  sctp_outq_uncork+0x6c/0x80 net/sctp/outqueue.c:772
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x559/0x53e0 net/sctp/sm_sideeffect.c:1191
  sctp_primitive_ASSOCIATE+0x9d/0xd0 net/sctp/primitive.c:88
  __sctp_connect+0x8cd/0xce0 net/sctp/socket.c:1226
  __sctp_setsockopt_connectx+0x133/0x1a0 net/sctp/socket.c:1349
  sctp_setsockopt_connectx_old net/sctp/socket.c:1365 [inline]
  sctp_setsockopt net/sctp/socket.c:4656 [inline]
  sctp_setsockopt+0x22cc/0x6d20 net/sctp/socket.c:4620
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
  __sys_setsockopt+0x180/0x280 net/socket.c:2046
  __do_sys_setsockopt net/socket.c:2057 [inline]
  __se_sys_setsockopt net/socket.c:2054 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2054
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7ae094cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458209
RDX: 000000000000006b RSI: 0000000000000084 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 000000000000001c R09: 0000000000000000
R10: 000000002055bfe4 R11: 0000000000000246 R12: 00007f7ae094d6d4
R13: 00000000004ccd38 R14: 00000000004daae0 R15: 00000000ffffffff
Modules linked in:
CR2: ffffffffffff94f8
---[ end trace 7497212cb89709a4 ]---
RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:167 [inline]
RIP: 0010:arch_atomic_sub_return arch/x86/include/asm/atomic.h:179 [inline]
RIP: 0010:atomic_sub_return include/asm-generic/atomic-instrumented.h:160  
[inline]
RIP: 0010:atomic_dec_return include/linux/atomic-fallback.h:455 [inline]
RIP: 0010:dst_release net/core/dst.c:190 [inline]
RIP: 0010:dst_release+0x2f/0xb0 net/core/dst.c:185
Code: 55 41 54 49 89 fc 53 e8 1f b6 f3 fb 4d 85 e4 74 47 e8 15 b6 f3 fb 49  
8d 7c 24 40 be 04 00 00 00 e8 d6 8b 2b fc be ff ff ff ff <f0> 41 0f c1 74  
24 40 44 8d 6e ff 31 ff 44 89 ee e8 6c b7 f3 fb 45
RSP: 0018:ffff8880ae906f28 EFLAGS: 00010246
RAX: fffffbfffffff2a0 RBX: 0000000000000001 RCX: ffffffff857cae2a
RDX: 0000000000000001 RSI: 00000000ffffffff RDI: ffffffffffff94f8
RBP: ffff8880ae906f40 R08: 1ffffffffffff29f R09: fffffbfffffff2a0
R10: fffffbfffffff29f R11: ffffffffffff94fb R12: ffffffffffff94b8
R13: dffffc0000000000 R14: ffff888066d0ac80 R15: 0000000000000000
FS:  00007f7ae094d700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffff94f8 CR3: 0000000086472000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
