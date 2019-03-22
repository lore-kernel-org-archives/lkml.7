Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA8121925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254405;
	bh=mbGYhULpNWRoW185bR5yvtxQN28xqT21cZsWVvuAnQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWVKHaBL47OX17G+5FU/AYDpPpetslo8ZTdtebV1VnN+FMdmnw9S769eHDYwqPmY6
	 jFivtNg6ppw8YfKseYRvDF/dTfb+DtdjrGbfgtSp1GcuOR/6yX++9oS4c6sVd1lx7A
	 ZFjAXT7weGH0V13FXLyo/XT3RB4VNfVOTG/OZLmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfCVLdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbfCVLdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9255B218B0;
        Fri, 22 Mar 2019 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254401;
        bh=mbGYhULpNWRoW185bR5yvtxQN28xqT21cZsWVvuAnQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sucxP9BpJcKeBZxh0OqwswR2WzbWgsLlLvpLDAJysCU9NQInjBbSFbrPlB109tODQ
         3+naohwwKEFji9ght8u7GPvy+nqu23Ga4R01teBKutcYDGoSF07DYYKcdfHtfl7du/
         v6UnPBPCIkV/yQ/EQaPybDEQKf/eNWfgQINU5IVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 125/230] l2tp: fix infoleak in l2tp_ip6_recvmsg()
Date:   Fri, 22 Mar 2019 12:14:23 +0100
Message-Id: <20190322111245.432918825@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 163d1c3d6f17556ed3c340d3789ea93be95d6c28 ]

Back in 2013 Hannes took care of most of such leaks in commit
bceaa90240b6 ("inet: prevent leakage of uninitialized memory to user in recv syscalls")

But the bug in l2tp_ip6_recvmsg() has not been fixed.

syzbot report :

BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
CPU: 1 PID: 10996 Comm: syz-executor362 Not tainted 5.0.0+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
 kmsan_internal_check_memory+0x9f4/0xb10 mm/kmsan/kmsan.c:694
 kmsan_copy_to_user+0xab/0xc0 mm/kmsan/kmsan_hooks.c:601
 _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
 copy_to_user include/linux/uaccess.h:174 [inline]
 move_addr_to_user+0x311/0x570 net/socket.c:227
 ___sys_recvmsg+0xb65/0x1310 net/socket.c:2283
 do_recvmmsg+0x646/0x10c0 net/socket.c:2390
 __sys_recvmmsg net/socket.c:2469 [inline]
 __do_sys_recvmmsg net/socket.c:2492 [inline]
 __se_sys_recvmmsg+0x1d1/0x350 net/socket.c:2485
 __x64_sys_recvmmsg+0x62/0x80 net/socket.c:2485
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x445819
Code: e8 6c b6 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f64453eddb8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000445819
RDX: 0000000000000005 RSI: 0000000020002f80 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac2c
R13: 00007ffeba8f87af R14: 00007f64453ee9c0 R15: 20c49ba5e353f7cf

Local variable description: ----addr@___sys_recvmsg
Variable was created at:
 ___sys_recvmsg+0xf6/0x1310 net/socket.c:2244
 do_recvmmsg+0x646/0x10c0 net/socket.c:2390

Bytes 0-31 of 32 are uninitialized
Memory access of size 32 starts at ffff8880ae62fbb0
Data copied to user address 0000000020000000

Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for IPv6")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ip6.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -666,9 +666,6 @@ static int l2tp_ip6_recvmsg(struct sock
 	if (flags & MSG_OOB)
 		goto out;
 
-	if (addr_len)
-		*addr_len = sizeof(*lsa);
-
 	if (flags & MSG_ERRQUEUE)
 		return ipv6_recv_error(sk, msg, len, addr_len);
 
@@ -698,6 +695,7 @@ static int l2tp_ip6_recvmsg(struct sock
 		lsa->l2tp_conn_id = 0;
 		if (ipv6_addr_type(&lsa->l2tp_addr) & IPV6_ADDR_LINKLOCAL)
 			lsa->l2tp_scope_id = inet6_iif(skb);
+		*addr_len = sizeof(*lsa);
 	}
 
 	if (np->rxopt.all)


