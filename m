Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6003A214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901388;
	bh=IcvEfG1L9zVWGoj6isHMZ/6Odi7eh83pxn1KdxrPdkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pTnVybQWHbhPIsB8k/H+gNY/l+ABsk09Tfr3DZwDk+B9v+9v6NJm+gAVlL6TksR8t
	 4z/enHy6S3WXN//dx7ymE4VDtEOfr3RDLyaQOzr/NTNmjNNkiFis4pYd5wHzntl+lW
	 5lqQjLc2SxRtJzuZjIkK1nJf3gypZcQ/wmslctYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfCRJ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfCRJ3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:29:42 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA209214D8;
        Mon, 18 Mar 2019 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901381;
        bh=IcvEfG1L9zVWGoj6isHMZ/6Odi7eh83pxn1KdxrPdkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ywfqw2WtFDK99EQRv9FtUlTHwyOr4aFxukHVKjAa/wYIEvT+3MAZnS9NoqL3mqfr9
         nB0W0shibbVHqSsSPvh3liaZbvSuAdNcruARa+8E+oVQe+mANj0WcTZ26YDcCeU+pw
         hCDwJEMkfPf7wc5zIiOtY2RAc6nsFHubwhYxiEWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andrey Vagin <avagin@openvz.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 27/52] tcp: repaired skbs must init their tso_segs
Date:   Mon, 18 Mar 2019 10:25:14 +0100
Message-Id: <20190318083846.667586536@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit bf50b606cfd85ac8d3d0adb711f3e22204059848 ]

syzbot reported a WARN_ON(!tcp_skb_pcount(skb))
in tcp_send_loss_probe() [1]

This was caused by TCP_REPAIR sent skbs that inadvertenly
were missing a call to tcp_init_tso_segs()

[1]
WARNING: CPU: 1 PID: 0 at net/ipv4/tcp_output.c:2534 tcp_send_loss_probe+0x771/0x8a0 net/ipv4/tcp_output.c:2534
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.0.0-rc7+ #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 panic+0x2cb/0x65c kernel/panic.c:214
 __warn.cold+0x20/0x45 kernel/panic.c:571
 report_bug+0x263/0x2b0 lib/bug.c:186
 fixup_bug arch/x86/kernel/traps.c:178 [inline]
 fixup_bug arch/x86/kernel/traps.c:173 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:tcp_send_loss_probe+0x771/0x8a0 net/ipv4/tcp_output.c:2534
Code: 88 fc ff ff 4c 89 ef e8 ed 75 c8 fb e9 c8 fc ff ff e8 43 76 c8 fb e9 63 fd ff ff e8 d9 75 c8 fb e9 94 f9 ff ff e8 bf 03 91 fb <0f> 0b e9 7d fa ff ff e8 b3 03 91 fb 0f b6 1d 37 43 7a 03 31 ff 89
RSP: 0018:ffff8880ae907c60 EFLAGS: 00010206
RAX: ffff8880a989c340 RBX: 0000000000000000 RCX: ffffffff85dedbdb
RDX: 0000000000000100 RSI: ffffffff85dee0b1 RDI: 0000000000000005
RBP: ffff8880ae907c90 R08: ffff8880a989c340 R09: ffffed10147d1ae1
R10: ffffed10147d1ae0 R11: ffff8880a3e8d703 R12: ffff888091b90040
R13: ffff8880a3e8d540 R14: 0000000000008000 R15: ffff888091b90860
 tcp_write_timer_handler+0x5c0/0x8a0 net/ipv4/tcp_timer.c:583
 tcp_write_timer+0x10e/0x1d0 net/ipv4/tcp_timer.c:607
 call_timer_fn+0x190/0x720 kernel/time/timer.c:1325
 expire_timers kernel/time/timer.c:1362 [inline]
 __run_timers kernel/time/timer.c:1681 [inline]
 __run_timers kernel/time/timer.c:1649 [inline]
 run_timer_softirq+0x652/0x1700 kernel/time/timer.c:1694
 __do_softirq+0x266/0x95a kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x180/0x1d0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
 </IRQ>
RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
Code: ff ff ff 48 89 c7 48 89 45 d8 e8 59 0c a1 fa 48 8b 45 d8 e9 ce fe ff ff 48 89 df e8 48 0c a1 fa eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
RSP: 0018:ffff8880a98afd78 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1125061 RBX: ffff8880a989c340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffff8880a989cbbc
RBP: ffff8880a98afda8 R08: ffff8880a989c340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff889282f8 R14: 0000000000000001 R15: 0000000000000000
 arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
 default_idle_call+0x36/0x90 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x386/0x570 kernel/sched/idle.c:262
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
 start_secondary+0x404/0x5c0 arch/x86/kernel/smpboot.c:271
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Kernel Offset: disabled
Rebooting in 86400 seconds..

Fixes: 79861919b889 ("tcp: fix TCP_REPAIR xmit queue setup")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2341,6 +2341,7 @@ static bool tcp_write_xmit(struct sock *
 			/* "skb_mstamp_ns" is used as a start point for the retransmit timer */
 			skb->skb_mstamp_ns = tp->tcp_wstamp_ns = tp->tcp_clock_cache;
 			list_move_tail(&skb->tcp_tsorted_anchor, &tp->tsorted_sent_queue);
+			tcp_init_tso_segs(skb, mss_now);
 			goto repair; /* Skip network transmission */
 		}
 


