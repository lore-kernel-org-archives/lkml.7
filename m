Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9EC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5FB20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005554;
	bh=ibTZwRKS6VoVkzjX7po10SasPNuQ7+a9R/Nk96beczE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QztrM8PzHqeZK64R3uhei5WKoKUXAmaCoi2ltSpljTF0ppsIa3yc2BZH9DOmMOAt/
	 urcG2yjyc2+ISiZYEkh/wHsMKzo2v3te+GzkZx3MPjUM3YcN0Np48xoodAyL8+OMuj
	 RX64Gx0ev6xEIFEeZ8LxuUs8mAiN3kxxK9Nb+9WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgABWWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgABWWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:22:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EE4222C3;
        Thu,  2 Jan 2020 22:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003759;
        bh=ibTZwRKS6VoVkzjX7po10SasPNuQ7+a9R/Nk96beczE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szDIJgyA2O6KAVWEG43/9EJGNtCCBYufGqAcu4BaDol0WWjk1kznZscTVMaJ4ULD+
         k3PFEDZx9r9h96wf+9hHn++uw+FcBpDl/0dwM77URS8YgoFSqxQvzSG0UBvPcZKfco
         6jCSgybZw1gPAVVEHz8U/sqMm8bXFaFyq/ipwLVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Oliverio <marco.oliverio@tanaza.com>,
        Rocco Folino <rocco.folino@tanaza.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/114] netfilter: nf_queue: enqueue skbs with NULL dst
Date:   Thu,  2 Jan 2020 23:07:28 +0100
Message-Id: <20200102220036.754351976@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Oliverio <marco.oliverio@tanaza.com>

[ Upstream commit 0b9173f4688dfa7c5d723426be1d979c24ce3d51 ]

Bridge packets that are forwarded have skb->dst == NULL and get
dropped by the check introduced by
b60a77386b1d4868f72f6353d35dabe5fbe981f2 (net: make skb_dst_force
return true when dst is refcounted).

To fix this we check skb_dst() before skb_dst_force(), so we don't
drop skb packet with dst == NULL. This holds also for skb at the
PRE_ROUTING hook so we remove the second check.

Fixes: b60a77386b1d ("net: make skb_dst_force return true when dst is refcounted")
Signed-off-by: Marco Oliverio <marco.oliverio@tanaza.com>
Signed-off-by: Rocco Folino <rocco.folino@tanaza.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index a96a8c16baf9..ee6d98355081 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -174,7 +174,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		goto err;
 	}
 
-	if (!skb_dst_force(skb) && state->hook != NF_INET_PRE_ROUTING) {
+	if (skb_dst(skb) && !skb_dst_force(skb)) {
 		status = -ENETDOWN;
 		goto err;
 	}
-- 
2.20.1



