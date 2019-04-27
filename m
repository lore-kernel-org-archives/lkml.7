Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667EDC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB79206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfD0PYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33434 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbfD0PP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:26 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2w-0000zP-6s; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004ag-Gu; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marek Lindner" <mareklindner@neomailbox.ch>,
        "Antonio Quartulli" <a@unstable.cc>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Simon Wunderlich" <sw@simonwunderlich.de>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.74182513@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 149/202] batman-adv: fix uninit-value in
 batadv_interface_tx()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 4ffcbfac60642f63ae3d80891f573ba7e94a265c upstream.

KMSAN reported batadv_interface_tx() was possibly using a
garbage value [1]

batadv_get_vid() does have a pskb_may_pull() call
but batadv_interface_tx() does not actually make sure
this did not fail.

[1]
BUG: KMSAN: uninit-value in batadv_interface_tx+0x908/0x1e40 net/batman-adv/soft-interface.c:231
CPU: 0 PID: 10006 Comm: syz-executor469 Not tainted 4.20.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
 __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
 batadv_interface_tx+0x908/0x1e40 net/batman-adv/soft-interface.c:231
 __netdev_start_xmit include/linux/netdevice.h:4356 [inline]
 netdev_start_xmit include/linux/netdevice.h:4365 [inline]
 xmit_one net/core/dev.c:3257 [inline]
 dev_hard_start_xmit+0x607/0xc40 net/core/dev.c:3273
 __dev_queue_xmit+0x2e42/0x3bc0 net/core/dev.c:3843
 dev_queue_xmit+0x4b/0x60 net/core/dev.c:3876
 packet_snd net/packet/af_packet.c:2928 [inline]
 packet_sendmsg+0x8306/0x8f30 net/packet/af_packet.c:2953
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 __sys_sendto+0x8c4/0xac0 net/socket.c:1788
 __do_sys_sendto net/socket.c:1800 [inline]
 __se_sys_sendto+0x107/0x130 net/socket.c:1796
 __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441889
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdda6fd468 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000441889
RDX: 000000000000000e RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 00007ffdda6fd4c0
R13: 00007ffdda6fd4b0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
 kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:158
 kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
 kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
 slab_post_alloc_hook mm/slab.h:446 [inline]
 slab_alloc_node mm/slub.c:2759 [inline]
 __kmalloc_node_track_caller+0xe18/0x1030 mm/slub.c:4383
 __kmalloc_reserve net/core/skbuff.c:137 [inline]
 __alloc_skb+0x309/0xa20 net/core/skbuff.c:205
 alloc_skb include/linux/skbuff.h:998 [inline]
 alloc_skb_with_frags+0x1c7/0xac0 net/core/skbuff.c:5220
 sock_alloc_send_pskb+0xafd/0x10e0 net/core/sock.c:2083
 packet_alloc_skb net/packet/af_packet.c:2781 [inline]
 packet_snd net/packet/af_packet.c:2872 [inline]
 packet_sendmsg+0x661a/0x8f30 net/packet/af_packet.c:2953
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 __sys_sendto+0x8c4/0xac0 net/socket.c:1788
 __do_sys_sendto net/socket.c:1800 [inline]
 __se_sys_sendto+0x107/0x130 net/socket.c:1796
 __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc:	Marek Lindner <mareklindner@neomailbox.ch>
Cc:	Simon Wunderlich <sw@simonwunderlich.de>
Cc:	Antonio Quartulli <a@unstable.cc>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/soft-interface.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -186,6 +186,8 @@ static int batadv_interface_tx(struct sk
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
+		if (!pskb_may_pull(skb, sizeof(*vhdr)))
+			goto dropped;
 		vhdr = vlan_eth_hdr(skb);
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype) {

