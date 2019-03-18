Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC42C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A2214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901250;
	bh=MZJT+BqMCk+xUgSlG6ecV5ROVtc5ZPTb1QTgutH7FIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qLJq2q5p4L1+ej/1XMQjX4gZwuCRByNlxOJcDITPxd0fCfGdgM1QKOSfIbGlDhwpX
	 vs0Z8Gb/GtFoihsmzg1gg0kMqxur8vujTkimjdIpeqLEK/+kbxHMJZTUwsWJzU4q1o
	 7mg1OsSA6bOSeP+ti2PMAUrsGc/za6WAqfgLYpKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfCRJ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfCRJ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:27 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B0421741;
        Mon, 18 Mar 2019 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901246;
        bh=MZJT+BqMCk+xUgSlG6ecV5ROVtc5ZPTb1QTgutH7FIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=06WW5f8TR7s4y2GxTlPuX5a+/XbiS3mFvr2jQIJIwuJFRlCsTu37lhQ8XCiUbIUUV
         HYx+PeWCmHpzXS3EeoXdsLznk/oQBT8FCxt090PYHSHuzJ/u87wryVXTCK+RbiWJNB
         GV/Y05PzRhjbmLVhPsbs8of0zF1bOcv3v/1Gy8rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 03/43] gro_cells: make sure device is up in gro_cells_receive()
Date:   Mon, 18 Mar 2019 10:23:55 +0100
Message-Id: <20190318083715.977711479@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2a5ff07a0eb945f291e361aa6f6becca8340ba46 ]

We keep receiving syzbot reports [1] that show that tunnels do not play
the rcu/IFF_UP rules properly.

At device dismantle phase, gro_cells_destroy() will be called
only after a full rcu grace period is observed after IFF_UP
has been cleared.

This means that IFF_UP needs to be tested before queueing packets
into netif_rx() or gro_cells.

This patch implements the test in gro_cells_receive() because
too many callers do not seem to bother enough.

[1]
BUG: unable to handle kernel paging request at fffff4ca0b9ffffe
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 21 Comm: kworker/u4:1 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__skb_unlink include/linux/skbuff.h:1929 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:1945 [inline]
RIP: 0010:__skb_queue_purge include/linux/skbuff.h:2656 [inline]
RIP: 0010:gro_cells_destroy net/core/gro_cells.c:89 [inline]
RIP: 0010:gro_cells_destroy+0x19d/0x360 net/core/gro_cells.c:78
Code: 03 42 80 3c 20 00 0f 85 53 01 00 00 48 8d 7a 08 49 8b 47 08 49 c7 07 00 00 00 00 48 89 f9 49 c7 47 08 00 00 00 00 48 c1 e9 03 <42> 80 3c 21 00 0f 85 10 01 00 00 48 89 c1 48 89 42 08 48 c1 e9 03
RSP: 0018:ffff8880aa3f79a8 EFLAGS: 00010a02
RAX: 00ffffffffffffe8 RBX: ffffe8ffffc64b70 RCX: 1ffff8ca0b9ffffe
RDX: ffffc6505cffffe8 RSI: ffffffff858410ca RDI: ffffc6505cfffff0
RBP: ffff8880aa3f7a08 R08: ffff8880aa3e8580 R09: fffffbfff1263645
R10: fffffbfff1263644 R11: ffffffff8931b223 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffe8ffffc64b80 R15: ffffe8ffffc64b75
kobject: 'loop2' (000000004bd7d84a): kobject_uevent_env
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff4ca0b9ffffe CR3: 0000000094941000 CR4: 00000000001406f0
Call Trace:
kobject: 'loop2' (000000004bd7d84a): fill_kobj_path: path = '/devices/virtual/block/loop2'
 ip_tunnel_dev_free+0x19/0x60 net/ipv4/ip_tunnel.c:1010
 netdev_run_todo+0x51c/0x7d0 net/core/dev.c:8970
 rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:116
 ip_tunnel_delete_nets+0x423/0x5f0 net/ipv4/ip_tunnel.c:1124
 vti_exit_batch_net+0x23/0x30 net/ipv4/ip_vti.c:495
 ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
 cleanup_net+0x3fb/0x960 net/core/net_namespace.c:551
 process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
 worker_thread+0x98/0xe40 kernel/workqueue.c:2319
 kthread+0x357/0x430 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: fffff4ca0b9ffffe
   [ end trace 513fc9c1338d1cb3 ]
RIP: 0010:__skb_unlink include/linux/skbuff.h:1929 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:1945 [inline]
RIP: 0010:__skb_queue_purge include/linux/skbuff.h:2656 [inline]
RIP: 0010:gro_cells_destroy net/core/gro_cells.c:89 [inline]
RIP: 0010:gro_cells_destroy+0x19d/0x360 net/core/gro_cells.c:78
Code: 03 42 80 3c 20 00 0f 85 53 01 00 00 48 8d 7a 08 49 8b 47 08 49 c7 07 00 00 00 00 48 89 f9 49 c7 47 08 00 00 00 00 48 c1 e9 03 <42> 80 3c 21 00 0f 85 10 01 00 00 48 89 c1 48 89 42 08 48 c1 e9 03
RSP: 0018:ffff8880aa3f79a8 EFLAGS: 00010a02
RAX: 00ffffffffffffe8 RBX: ffffe8ffffc64b70 RCX: 1ffff8ca0b9ffffe
RDX: ffffc6505cffffe8 RSI: ffffffff858410ca RDI: ffffc6505cfffff0
RBP: ffff8880aa3f7a08 R08: ffff8880aa3e8580 R09: fffffbfff1263645
R10: fffffbfff1263644 R11: ffffffff8931b223 R12: dffffc0000000000
kobject: 'loop3' (00000000e4ee57a6): kobject_uevent_env
R13: 0000000000000000 R14: ffffe8ffffc64b80 R15: ffffe8ffffc64b75
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff4ca0b9ffffe CR3: 0000000094941000 CR4: 00000000001406f0

Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/gro_cells.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -13,22 +13,36 @@ int gro_cells_receive(struct gro_cells *
 {
 	struct net_device *dev = skb->dev;
 	struct gro_cell *cell;
+	int res;
 
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev))
-		return netif_rx(skb);
+	rcu_read_lock();
+	if (unlikely(!(dev->flags & IFF_UP)))
+		goto drop;
+
+	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+		res = netif_rx(skb);
+		goto unlock;
+	}
 
 	cell = this_cpu_ptr(gcells->cells);
 
 	if (skb_queue_len(&cell->napi_skbs) > netdev_max_backlog) {
+drop:
 		atomic_long_inc(&dev->rx_dropped);
 		kfree_skb(skb);
-		return NET_RX_DROP;
+		res = NET_RX_DROP;
+		goto unlock;
 	}
 
 	__skb_queue_tail(&cell->napi_skbs, skb);
 	if (skb_queue_len(&cell->napi_skbs) == 1)
 		napi_schedule(&cell->napi);
-	return NET_RX_SUCCESS;
+
+	res = NET_RX_SUCCESS;
+
+unlock:
+	rcu_read_unlock();
+	return res;
 }
 EXPORT_SYMBOL(gro_cells_receive);
 


