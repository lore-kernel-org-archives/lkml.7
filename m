Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF682C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B594B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDBWoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:44:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:38025 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:44:07 -0400
Received: by mail-it1-f197.google.com with SMTP id 79so4356233itz.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 15:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xmy3gyFH9xvfaYYrOW4SvvnXS55oNN0QmuupKIMjt3w=;
        b=C5HKpFOsg91gQDepz7EBC7wbOkEIRWnNgEVZ6qg401oD12bSC6WlsBL+da+zHLeZkq
         PeNuVxd55PvO+GkOm2c5ll4wFk3YFgsiOwH96iO/vigxyL/emJLguAe2quxQXokarXOq
         YHX+m+wKMoZi+ox9vDz/9GHFGbvGiPoLIPtNocOLUP3YJ8oY9KKfKBzR9Jh/Nw0A5dDk
         6okXVooqgNyizYgs9OmvTFul134z+GcJOr5wGhFgswq/WpVDAAmhsJsbEXo0wDomV5gE
         FYaYjdH4XQHRC6EVXPtKnPlOWvFjGH3L5pKt5OOS7aoCPaot/6vPpeM8ou9bxJo/nUb7
         krHA==
X-Gm-Message-State: APjAAAVRSvKFRM1+PUVuKpzmCd5mjEmrYTmfHNg2EdrtIeT80RnGaO5y
        g2s9S9oy7PmS/3DGyOdPW0hS41dNfPVBV3QsQRvCJWHdepmz
X-Google-Smtp-Source: APXvYqztGMucNJV1TbzA1fp7Pnp97Cm2bL0wyphgWGh6csQKL2auRoQkfhZoqXUrShbjFxvfgvYeHhgaTBzoRAIuBGazCZ6viFtS
MIME-Version: 1.0
X-Received: by 2002:a24:390b:: with SMTP id l11mr8820804ita.20.1554245046246;
 Tue, 02 Apr 2019 15:44:06 -0700 (PDT)
Date:   Tue, 02 Apr 2019 15:44:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e02450058593df62@google.com>
Subject: BUG: using __this_cpu_read() in preemptible code in ip6_finish_output
From:   syzbot <syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e1427237 macsec: add noinline tag to avoid a frame size wa..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15594553200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e9bc94c16d346a6
dashboard link: https://syzkaller.appspot.com/bug?extid=51471b4aae195285a4a3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ffb07200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14412673200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com

BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor222/7596
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is ip6_skb_dst_mtu include/net/ip6_route.h:245 [inline]
caller is ip6_finish_output+0x335/0xdc0 net/ipv6/ip6_output.c:149
CPU: 1 PID: 7596 Comm: syz-executor222 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  ip6_skb_dst_mtu include/net/ip6_route.h:245 [inline]
  ip6_finish_output+0x335/0xdc0 net/ipv6/ip6_output.c:149
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x235/0x7f0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:433 [inline]
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip6_xmit+0xe41/0x20c0 net/ipv6/ip6_output.c:275
  inet6_csk_xmit+0x2fb/0x5d0 net/ipv6/inet6_connection_sock.c:139
  __tcp_transmit_skb+0x1a32/0x3750 net/ipv4/tcp_output.c:1155
  tcp_transmit_skb net/ipv4/tcp_output.c:1171 [inline]
  tcp_send_syn_data net/ipv4/tcp_output.c:3494 [inline]
  tcp_connect+0x1e47/0x4280 net/ipv4/tcp_output.c:3533
  tcp_v6_connect+0x150b/0x20a0 net/ipv6/tcp_ipv6.c:331
  __inet_stream_connect+0x83f/0xea0 net/ipv4/af_inet.c:659
  tcp_sendmsg_fastopen net/ipv4/tcp.c:1155 [inline]
  tcp_sendmsg_locked+0x231f/0x37f0 net/ipv4/tcp.c:1197
  tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1431
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  __sys_sendto+0x262/0x380 net/socket.c:1932
  __do_sys_sendto net/socket.c:1944 [inline]
  __se_sys_sendto net/socket.c:1940 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1940
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440189
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffed7abd1a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440189
RDX: 0000000000000000 RSI: 0000000000000000 RD


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
