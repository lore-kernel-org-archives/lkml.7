Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950E220652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369021;
	bh=1aocFFN7czNLmJgbsmMdpuvADc09IZYWEvWl5xCWgio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pUg/+0WhWUNFP9vwNgqVjSIZpUfsV7JfgyNzD86j/0HH30KCVZITOwg5bRX/Li5+G
	 lvKUp5PG1M4Ip0XX6EqeCtgpYhf9+yO6L9FcJY/o4Ux08aRiO1L3RhwL8yod52sAxA
	 KBrAOocl0umh8A6Tfk48lVuPYCpFDH/b60/0O4cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfDDJKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732982AbfDDJKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A772075E;
        Thu,  4 Apr 2019 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369014;
        bh=1aocFFN7czNLmJgbsmMdpuvADc09IZYWEvWl5xCWgio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dv3b4Lh1r1eoIPR2SGgSRQyBk1GekOLqugnxZlqJJ4nT7NIGViOzsh20Quww9rBvS
         ghwnP1rztIi35J71U729Vq9SR1v9WtFkm7XNH3IklWuAyafpuRufvceIC5cU76vJwe
         RuR8cie6oNj0bRX48bLAtgI1h9UBNdpTjdHUeLG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Zhang Yu <zhangyu31@baidu.com>,
        Li RongQing <lirongqing@baidu.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 049/246] netfilter: nf_tables: check the result of dereferencing base_chain->stats
Date:   Thu,  4 Apr 2019 10:45:49 +0200
Message-Id: <20190404084620.737945312@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit a9f5e78c403d2d62ade4f4c85040efc85f4049b8 ]

Check the result of dereferencing base_chain->stats, instead of result
of this_cpu_ptr with NULL.

base_chain->stats maybe be changed to NULL when a chain is updated and a
new NULL counter can be attached.

And we do not need to check returning of this_cpu_ptr since
base_chain->stats is from percpu allocator if it is non-NULL,
this_cpu_ptr returns a valid value.

And fix two sparse error by replacing rcu_access_pointer and
rcu_dereference with READ_ONCE under rcu_read_lock.

Thanks for Eric's help to finish this patch.

Fixes: 009240940e84c1 ("netfilter: nf_tables: don't assume chain stats are set when jumplabel is set")
Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index a50500232b0a..7e8dae82ca52 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -98,21 +98,23 @@ static noinline void nft_update_chain_stats(const struct nft_chain *chain,
 					    const struct nft_pktinfo *pkt)
 {
 	struct nft_base_chain *base_chain;
+	struct nft_stats __percpu *pstats;
 	struct nft_stats *stats;
 
 	base_chain = nft_base_chain(chain);
-	if (!rcu_access_pointer(base_chain->stats))
-		return;
 
-	local_bh_disable();
-	stats = this_cpu_ptr(rcu_dereference(base_chain->stats));
-	if (stats) {
+	rcu_read_lock();
+	pstats = READ_ONCE(base_chain->stats);
+	if (pstats) {
+		local_bh_disable();
+		stats = this_cpu_ptr(pstats);
 		u64_stats_update_begin(&stats->syncp);
 		stats->pkts++;
 		stats->bytes += pkt->skb->len;
 		u64_stats_update_end(&stats->syncp);
+		local_bh_enable();
 	}
-	local_bh_enable();
+	rcu_read_unlock();
 }
 
 struct nft_jumpstack {
-- 
2.19.1



