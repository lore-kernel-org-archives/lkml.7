Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC616C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717492183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254475;
	bh=JNhDEjgloo9yriyYL6qY7FDpUkwlmL4YfBYA89rdgE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLh+VhFh+dIHLCWp60B5oPlqGiyC9Ou0d1F4guB1ob1SITa9+I2GayScPoFHzZsMY
	 Pi3b42/zAjavXcvJfPkrWXFdp0eYjvNlqmerJfxknmwzKvlzT1df6CzggAGU+f13la
	 fzeXibgp43EDpsn8rSSyFRRMwJyIWM83UO1MYapE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfCVLed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbfCVLe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA0D2183E;
        Fri, 22 Mar 2019 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254468;
        bh=JNhDEjgloo9yriyYL6qY7FDpUkwlmL4YfBYA89rdgE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecJ6ObYgrWLwjz89B0pS0RktHShzKl+NCJIV6dzFC0071RazPP5hR4AvC9pNViIIN
         /MP6pNHBHMXorlxdiZwQTAPvT9XVxzBrMEqxbxSD8UnM0ic5AT97b7gZHKhWB0mI5q
         Eb26r6z4zoYrJb6ALcoU2aSboB53k7CLzMYt1KGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Shankara Pailoor <sp3485@columbia.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Guillaume Nault <gnault@redhat.com>
Subject: [PATCH 4.4 145/230] tcp/dccp: remove reqsk_put() from inet_child_forget()
Date:   Fri, 22 Mar 2019 12:14:43 +0100
Message-Id: <20190322111246.821855595@linuxfoundation.org>
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

commit da8ab57863ed7e912d10b179b6bdc652f635bd19 upstream.

Back in linux-4.4, I inadvertently put a call to reqsk_put() in
inet_child_forget(), forgetting it could be called from two different
points.

In the case it is called from inet_csk_reqsk_queue_add(), we want to
keep the reference on the request socket, since it is released later by
the caller (tcp_v{4|6}_rcv())

This bug never showed up because atomic_dec_and_test() was not signaling
the underflow, and SLAB_DESTROY_BY RCU semantic for request sockets
prevented the request to be put in quarantine.

Recent conversion of socket refcount from atomic_t to refcount_t finally
exposed the bug.

So move the reqsk_put() to inet_csk_listen_stop() to fix this.

Thanks to Shankara Pailoor for using syzkaller and providing
a nice set of .config and C repro.

WARNING: CPU: 2 PID: 4277 at lib/refcount.c:186
refcount_sub_and_test+0x167/0x1b0 lib/refcount.c:186
Kernel panic - not syncing: panic_on_warn set ...

CPU: 2 PID: 4277 Comm: syz-executor0 Not tainted 4.13.0-rc7 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0xf7/0x1aa lib/dump_stack.c:52
 panic+0x1ae/0x3a7 kernel/panic.c:180
 __warn+0x1c4/0x1d9 kernel/panic.c:541
 report_bug+0x211/0x2d0 lib/bug.c:183
 fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:190
 do_trap_no_signal arch/x86/kernel/traps.c:224 [inline]
 do_trap+0x260/0x390 arch/x86/kernel/traps.c:273
 do_error_trap+0x118/0x340 arch/x86/kernel/traps.c:310
 do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:323
 invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:846
RIP: 0010:refcount_sub_and_test+0x167/0x1b0 lib/refcount.c:186
RSP: 0018:ffff88006e006b60 EFLAGS: 00010286
RAX: 0000000000000026 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000026 RSI: 1ffff1000dc00d2c RDI: ffffed000dc00d60
RBP: ffff88006e006bf0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1000dc00d6d
R13: 00000000ffffffff R14: 0000000000000001 R15: ffff88006ce9d340
 refcount_dec_and_test+0x1a/0x20 lib/refcount.c:211
 reqsk_put+0x71/0x2b0 include/net/request_sock.h:123
 tcp_v4_rcv+0x259e/0x2e20 net/ipv4/tcp_ipv4.c:1729
 ip_local_deliver_finish+0x2e2/0xba0 net/ipv4/ip_input.c:216
 NF_HOOK include/linux/netfilter.h:248 [inline]
 ip_local_deliver+0x1ce/0x6d0 net/ipv4/ip_input.c:257
 dst_input include/net/dst.h:477 [inline]
 ip_rcv_finish+0x8db/0x19c0 net/ipv4/ip_input.c:397
 NF_HOOK include/linux/netfilter.h:248 [inline]
 ip_rcv+0xc3f/0x17d0 net/ipv4/ip_input.c:488
 __netif_receive_skb_core+0x1fb7/0x31f0 net/core/dev.c:4298
 __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4336
 process_backlog+0x1c5/0x6d0 net/core/dev.c:5102
 napi_poll net/core/dev.c:5499 [inline]
 net_rx_action+0x6d3/0x14a0 net/core/dev.c:5565
 __do_softirq+0x2cb/0xb2d kernel/softirq.c:284
 do_softirq_own_stack+0x1c/0x30 arch/x86/entry/entry_64.S:898
 </IRQ>
 do_softirq.part.16+0x63/0x80 kernel/softirq.c:328
 do_softirq kernel/softirq.c:176 [inline]
 __local_bh_enable_ip+0x84/0x90 kernel/softirq.c:181
 local_bh_enable include/linux/bottom_half.h:31 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:705 [inline]
 ip_finish_output2+0x8ad/0x1360 net/ipv4/ip_output.c:231
 ip_finish_output+0x74e/0xb80 net/ipv4/ip_output.c:317
 NF_HOOK_COND include/linux/netfilter.h:237 [inline]
 ip_output+0x1cc/0x850 net/ipv4/ip_output.c:405
 dst_output include/net/dst.h:471 [inline]
 ip_local_out+0x95/0x160 net/ipv4/ip_output.c:124
 ip_queue_xmit+0x8c6/0x1810 net/ipv4/ip_output.c:504
 tcp_transmit_skb+0x1963/0x3320 net/ipv4/tcp_output.c:1123
 tcp_send_ack.part.35+0x38c/0x620 net/ipv4/tcp_output.c:3575
 tcp_send_ack+0x49/0x60 net/ipv4/tcp_output.c:3545
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:5795 [inline]
 tcp_rcv_state_process+0x4876/0x4b60 net/ipv4/tcp_input.c:5930
 tcp_v4_do_rcv+0x58a/0x820 net/ipv4/tcp_ipv4.c:1483
 sk_backlog_rcv include/net/sock.h:907 [inline]
 __release_sock+0x124/0x360 net/core/sock.c:2223
 release_sock+0xa4/0x2a0 net/core/sock.c:2715
 inet_wait_for_connect net/ipv4/af_inet.c:557 [inline]
 __inet_stream_connect+0x671/0xf00 net/ipv4/af_inet.c:643
 inet_stream_connect+0x58/0xa0 net/ipv4/af_inet.c:682
 SYSC_connect+0x204/0x470 net/socket.c:1628
 SyS_connect+0x24/0x30 net/socket.c:1609
 entry_SYSCALL_64_fastpath+0x18/0xad
RIP: 0033:0x451e59
RSP: 002b:00007f474843fc08 EFLAGS: 00000216 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000718000 RCX: 0000000000451e59
RDX: 0000000000000010 RSI: 0000000020002000 RDI: 0000000000000007
RBP: 0000000000000046 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000000000
R13: 00007ffc040a0f8f R14: 00007f47484409c0 R15: 0000000000000000

Fixes: ebb516af60e1 ("tcp/dccp: fix race at listener dismantle phase")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Shankara Pailoor <sp3485@columbia.edu>
Tested-by: Shankara Pailoor <sp3485@columbia.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/inet_connection_sock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -787,7 +787,6 @@ static void inet_child_forget(struct soc
 		tcp_sk(child)->fastopen_rsk = NULL;
 	}
 	inet_csk_destroy_sock(child);
-	reqsk_put(req);
 }
 
 struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
@@ -858,6 +857,7 @@ void inet_csk_listen_stop(struct sock *s
 		sock_hold(child);
 
 		inet_child_forget(sk, req, child);
+		reqsk_put(req);
 		bh_unlock_sock(child);
 		local_bh_enable();
 		sock_put(child);


