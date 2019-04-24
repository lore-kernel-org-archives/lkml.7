Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F570C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF80D205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126776;
	bh=lt+snKshb9Jln6QefOUQal74CGDvjvDaWx4UxgY92S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=goOvb1NK4pjSRWmFDjNd60S5WbzuO+hqmiX7LLcrjkRa/1y6OqTF6zS1oVkJQH5ts
	 kdPy2IPRqAwsYMevVHLNMfLPRRucuVJTyyuMRov3Hp/N0oVmqxP/20+ZLsH9DruSQp
	 ri3uPQzQEG4UBChhVVLRLwTIepnbss2ysxcVNJ8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbfDXR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389798AbfDXR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:26:10 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404D821903;
        Wed, 24 Apr 2019 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126768;
        bh=lt+snKshb9Jln6QefOUQal74CGDvjvDaWx4UxgY92S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNz2MoD8GIA5/WpIZGS9a5c99720bXFJSZ6qa2VXIhHooT3wDhcbBbCWs3K3QyuXi
         BqjDPmy+W1YYdbMlrOUssuoPLjrk9dEXGPJe9LEtuIdQsIjkha7bkhsdYDoYg/JNYA
         JI/R6QOk2gCfEi3T2gbSv1NBFEZWJKbKmkSXwNFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/70] ipv4: ensure rcu_read_lock() in ipv4_link_failure()
Date:   Wed, 24 Apr 2019 19:09:30 +0200
Message-Id: <20190424170908.738998286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c543cb4a5f07e09237ec0fc2c60c9f131b2c79ad ]

fib_compute_spec_dst() needs to be called under rcu protection.

syzbot reported :

WARNING: suspicious RCU usage
5.1.0-rc4+ #165 Not tainted
include/linux/inetdevice.h:220 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by swapper/0/0:
 #0: 0000000051b67925 ((&n->timer)){+.-.}, at: lockdep_copy_map include/linux/lockdep.h:170 [inline]
 #0: 0000000051b67925 ((&n->timer)){+.-.}, at: call_timer_fn+0xda/0x720 kernel/time/timer.c:1315

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0-rc4+ #165
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5162
 __in_dev_get_rcu include/linux/inetdevice.h:220 [inline]
 fib_compute_spec_dst+0xbbd/0x1030 net/ipv4/fib_frontend.c:294
 spec_dst_fill net/ipv4/ip_options.c:245 [inline]
 __ip_options_compile+0x15a7/0x1a10 net/ipv4/ip_options.c:343
 ipv4_link_failure+0x172/0x400 net/ipv4/route.c:1195
 dst_link_failure include/net/dst.h:427 [inline]
 arp_error_report+0xd1/0x1c0 net/ipv4/arp.c:297
 neigh_invalidate+0x24b/0x570 net/core/neighbour.c:995
 neigh_timer_handler+0xc35/0xf30 net/core/neighbour.c:1081
 call_timer_fn+0x190/0x720 kernel/time/timer.c:1325
 expire_timers kernel/time/timer.c:1362 [inline]
 __run_timers kernel/time/timer.c:1681 [inline]
 __run_timers kernel/time/timer.c:1649 [inline]
 run_timer_softirq+0x652/0x1700 kernel/time/timer.c:1694
 __do_softirq+0x266/0x95a kernel/softirq.c:293
 invoke_softirq kernel/softirq.c:374 [inline]
 irq_exit+0x180/0x1d0 kernel/softirq.c:414
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807

Fixes: ed0de45a1008 ("ipv4: recompile ip options in ipv4_link_failure")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1194,14 +1194,20 @@ static struct dst_entry *ipv4_dst_check(
 
 static void ipv4_link_failure(struct sk_buff *skb)
 {
-	struct rtable *rt;
 	struct ip_options opt;
+	struct rtable *rt;
+	int res;
 
 	/* Recompile ip options since IPCB may not be valid anymore.
 	 */
 	memset(&opt, 0, sizeof(opt));
 	opt.optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
-	if (__ip_options_compile(dev_net(skb->dev), &opt, skb, NULL))
+
+	rcu_read_lock();
+	res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+	rcu_read_unlock();
+
+	if (res)
 		return;
 
 	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &opt);


