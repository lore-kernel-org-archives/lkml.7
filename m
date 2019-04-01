Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8564C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9814321929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138803;
	bh=+GtiF7JWjFsUBlrlxUIfnz9dmYyrrB3OGRmlEkiIl0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mybiFzuBV7KcpA5az93w9hDXCtcw8D+HJm8NeTAsB7JH8+PlFM7/SS6Hl6zVF+jFk
	 3CQ5uRbTizCl9Yu9A0X+WMdO2iLH4wlEiQO5+UvVCo3A5OR76/ow+club1H9T6YWOw
	 bZb0EC0d1Mwh8BIMH2QRwtXDHKfcS9SAgdpJe+Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfDARNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbfDARNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF4E21924;
        Mon,  1 Apr 2019 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138796;
        bh=+GtiF7JWjFsUBlrlxUIfnz9dmYyrrB3OGRmlEkiIl0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPTFkapBc9/VTkGsxhg1Czr9dGh0pRdKUmBjl2ccp+HSuz15dycIzBuAgYSZbRRSB
         e621ZFwgEUXSVl2STNpw81l1k0hy1TwH/jUsn3uPpopyhEYEuS1kmWG4Lx9078cl1F
         eEFo30P2ITwwKGPzDLIzbE/PAcT9D8ymwH3AHcHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 023/134] tipc: change to check tipc_own_id to return in tipc_net_stop
Date:   Mon,  1 Apr 2019 19:00:59 +0200
Message-Id: <20190401170046.737161533@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 9926cb5f8b0f0aea535735185600d74db7608550 ]

When running a syz script, a panic occurred:

[  156.088228] BUG: KASAN: use-after-free in tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.094315] Call Trace:
[  156.094844]  <IRQ>
[  156.095306]  dump_stack+0x7c/0xc0
[  156.097346]  print_address_description+0x65/0x22e
[  156.100445]  kasan_report.cold.3+0x37/0x7a
[  156.102402]  tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.106517]  call_timer_fn+0x19a/0x610
[  156.112749]  run_timer_softirq+0xb51/0x1090

It was caused by the netns freed without deleting the discoverer timer,
while later on the netns would be accessed in the timer handler.

The timer should have been deleted by tipc_net_stop() when cleaning up a
netns. However, tipc has been able to enable a bearer and start d->timer
without the local node_addr set since Commit 52dfae5c85a4 ("tipc: obtain
node identity from interface by default"), which caused the timer not to
be deleted in tipc_net_stop() then.

So fix it in tipc_net_stop() by changing to check local node_id instead
of local node_addr, as Jon suggested.

While at it, remove the calling of tipc_nametbl_withdraw() there, since
tipc_nametbl_stop() will take of the nametbl's freeing after.

Fixes: 52dfae5c85a4 ("tipc: obtain node identity from interface by default")
Reported-by: syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/net.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -163,12 +163,9 @@ void tipc_sched_net_finalize(struct net
 
 void tipc_net_stop(struct net *net)
 {
-	u32 self = tipc_own_addr(net);
-
-	if (!self)
+	if (!tipc_own_id(net))
 		return;
 
-	tipc_nametbl_withdraw(net, TIPC_CFG_SRV, self, self, self);
 	rtnl_lock();
 	tipc_bearer_stop(net);
 	tipc_node_stop(net);


