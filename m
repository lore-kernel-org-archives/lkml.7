Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ABB2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCKGRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:17:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45777 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfCKGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:17:07 -0400
Received: by mail-io1-f71.google.com with SMTP id r21so2679059iod.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Eg2b6KeVnRA/TxzSC/PaWaijLIV4OGrMQxgr+m+p2t8=;
        b=Mm0fDD/bQlTvYC95RuHWbNJFhucok6iozff0XpHPFoo/EWxk0shIIJJsq0lhiD/m92
         xG9NRhUU7626n6JnjM62rSN0/xzIqdN5v7eGGAFOZuW7jf3xTbzOGPGriY8zAks4W2q2
         asDABbw5+Vch0OuZjfd5JgjjjPht/k367USALP/+hquq2DQHISUw7v9tJlLHSoAkbOrV
         qSuh4/TgQGYQFxCqMjVyUST5lVcr0mHflQ2+yjI8vLDPcz3eAI1B9nEYQLcMDZtSyhS6
         VXn6h9bZqb3F6MdBv6TSAvuL6Qqw51fSvNacQmMTsI5C/9hrmf6aAe27J2YQk8nr+6xR
         iqjA==
X-Gm-Message-State: APjAAAUH792v0lz78YzzrtW+8oVW8ECs3cM1s4r9nYEDJjhzNAalnZIb
        HTtwjjPSkkwF/wdAxPECfDv6myLotakQ/lImkKfXGHhQnvH1
X-Google-Smtp-Source: APXvYqxDnWDmC7kiiPPQ4totZTxUbj1vQVP3t68p0PgUxisqpL1aLriMruEQe2jBRj8CyFhoD3lXjVqJLj6B+e7sLyfXP40b37TJ
MIME-Version: 1.0
X-Received: by 2002:a5d:9b95:: with SMTP id r21mr18885314iom.38.1552285026430;
 Sun, 10 Mar 2019 23:17:06 -0700 (PDT)
Date:   Sun, 10 Mar 2019 23:17:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000973c550583cb8562@google.com>
Subject: general protection fault in xfrm_lookup_with_ifid
From:   syzbot <syzbot+2a7531cd068ddc9932f9@syzkaller.appspotmail.com>
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

HEAD commit:    d9862cfb Merge tag 'mips_5.1' of git://git.kernel.org/pub/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1160d5db200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=2a7531cd068ddc9932f9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a7531cd068ddc9932f9@syzkaller.appspotmail.com

netlink: 'syz-executor.3': attribute type 1 has an invalid length.
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor.5'.
netlink: 'syz-executor.3': attribute type 1 has an invalid length.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 13518 Comm: syz-executor.0 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:xfrm_lookup_with_ifid+0xf0/0x1cd0 net/xfrm/xfrm_policy.c:3027
Code: c1 e8 03 42 80 3c 28 00 0f 85 c3 19 00 00 48 8b 85 f0 fe ff ff 4c 8b  
68 08 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 01 0f 8e 93 15 00 00 41 0f b7 45 00 4d
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor.5'.
RSP: 0018:ffff8880ae906d10 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff8880429ecf00
RDX: 10c1072800000000 RSI: ffffffff85ff59da RDI: ffff8880a53d0040
RBP: ffff8880ae906e60 R08: 0000000000000006 R09: 0000000000000000
R10: ffffed1015d25bcf R11: 0000000000000000 R12: ffff8880429ecf00
R13: 8608394000000000 R14: ffff8880a11c769c R15: ffff8880ae906e38
FS:  00007f08dc344700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
kobject: 'loop4' (000000008af853b7): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop4' (000000008af853b7): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
CR2: 0000000000a5048d CR3: 000000009d7a7000 CR4: 00000000001406e0
Call Trace:
  <IRQ>
kobject: 'loop1' (000000005d69384c): kobject_uevent_env
kobject: 'loop1' (000000005d69384c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  xfrm_lookup net/xfrm/xfrm_policy.c:3175 [inline]
  xfrm_lookup_route+0x3b/0x1f0 net/xfrm/xfrm_policy.c:3186
  ip6_dst_lookup_flow+0x189/0x220 net/ipv6/ip6_output.c:1098
  sctp_v6_get_dst+0x785/0x1d80 net/sctp/ipv6.c:293
kobject: 'loop3' (0000000061a5c8dc): kobject_uevent_env
kobject: 'loop3' (0000000061a5c8dc): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  sctp_transport_route+0x132/0x370 net/sctp/transport.c:312
  sctp_assoc_add_peer+0x53e/0xfc0 net/sctp/associola.c:678
  sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
  sctp_process_init+0x249f/0x2b20 net/sctp/sm_make_chunk.c:2361
kobject: 'loop4' (000000008af853b7): kobject_uevent_env
kobject: 'loop4' (000000008af853b7): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  sctp_sf_do_5_1B_init+0x8ba/0xe50 net/sctp/sm_statefuns.c:416
  sctp_do_sm+0x124/0x5390 net/sctp/sm_sideeffect.c:1188
kobject: 'loop2' (00000000daab3d23): kobject_uevent_env
kobject: 'loop2' (00000000daab3d23): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000023199259): kobject_uevent_env
kobject: 'loop5' (0000000023199259): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  sctp_endpoint_bh_rcv+0x451/0x950 net/sctp/endpointola.c:456
  sctp_inq_push+0x1ea/0x290 net/sctp/inqueue.c:95
  sctp_rcv+0x27d9/0x3550 net/sctp/input.c:271
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
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.0+0x11a/0x170 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x211/0x270 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:696 [inline]
  ip6_finish_output2+0xbcf/0x2550 net/ipv6/ip6_output.c:121
  ip6_finish_output+0x577/0xc30 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x235/0x7f0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip6_xmit+0xe41/0x20c0 net/ipv6/ip6_output.c:275
  sctp_v6_xmit+0x313/0x660 net/sctp/ipv6.c:232
  sctp_packet_transmit+0x1b8b/0x3660 net/sctp/output.c:641
  sctp_packet_singleton net/sctp/outqueue.c:787 [inline]
  sctp_outq_flush_ctrl.constprop.0+0x741/0xd40 net/sctp/outqueue.c:918
  sctp_outq_flush+0xe8/0x2790 net/sctp/outqueue.c:1200
  sctp_outq_uncork+0x6c/0x80 net/sctp/outqueue.c:772
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
  sctp_do_sm+0x513/0x5390 net/sctp/sm_sideeffect.c:1191
  sctp_primitive_ASSOCIATE+0x9d/0xd0 net/sctp/primitive.c:88
  __sctp_connect+0x8cd/0xce0 net/sctp/socket.c:1226
  __sctp_setsockopt_connectx+0x133/0x1a0 net/sctp/socket.c:1349
  sctp_setsockopt_connectx_old net/sctp/socket.c:1365 [inline]
  sctp_setsockopt net/sctp/socket.c:4617 [inline]
  sctp_setsockopt+0x22cc/0x68a0 net/sctp/socket.c:4581
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3120
  __sys_setsockopt+0x180/0x280 net/socket.c:1923
  __do_sys_setsockopt net/socket.c:1934 [inline]
  __se_sys_setsockopt net/socket.c:1931 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1931
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f08dc343c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457f29
RDX: 000000000000006b RSI: 0000000000000084 RDI: 0000000000000006
RBP: 000000000073bfa0 R08: 000000000000001c R09: 0000000000000000
R10: 000000002055bfe4 R11: 0000000000000246 R12: 00007f08dc3446d4
R13: 00000000004ccac8 R14: 00000000004da830 R15: 00000000ffffffff
Modules linked in:
---[ end trace 7de77d1b835299f5 ]---
RIP: 0010:xfrm_lookup_with_ifid+0xf0/0x1cd0 net/xfrm/xfrm_policy.c:3027
Code: c1 e8 03 42 80 3c 28 00 0f 85 c3 19 00 00 48 8b 85 f0 fe ff ff 4c 8b  
68 08 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 01 0f 8e 93 15 00 00 41 0f b7 45 00 4d
RSP: 0018:ffff8880ae906d10 EFLAGS: 00010a06
kobject: 'loop1' (000000005d69384c): kobject_uevent_env
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff8880429ecf00
RDX: 10c1072800000000 RSI: ffffffff85ff59da RDI: ffff8880a53d0040
RBP: ffff8880ae906e60 R08: 0000000000000006 R09: 0000000000000000
R10: ffffed1015d25bcf R11: 0000000000000000 R12: ffff8880429ecf00
kobject: 'loop1' (000000005d69384c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
R13: 8608394000000000 R14: ffff8880a11c769c R15: ffff8880ae906e38
FS:  00007f08dc344700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a5048d CR3: 000000009d7a7000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
