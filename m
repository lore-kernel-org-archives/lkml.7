Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC9C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82891222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003993;
	bh=Axm9hXdZ97HQ91q0zUCS0GRR7u5ItH7c2RXBxanXijs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEo7aqHUZqKOnZQzl5Jhvt9htbWm7LFrLau8hQgjwpjMlE/nTzUfYCLQjCMYraoW1
	 fcdkxJ2BWOIONkdVTnYqL9FHq2g8exF3h+TRQ1Tn91lJO17tOCzFxuQxdB8u58Kz3M
	 C4gMHQt5M0va/PHWrhwIIsJPQHfaOw6ehyBeJvZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgABW0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbgABW02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B752222525;
        Thu,  2 Jan 2020 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003988;
        bh=Axm9hXdZ97HQ91q0zUCS0GRR7u5ItH7c2RXBxanXijs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D30CqjnZep3Do/DJs2ktYgrlOaJnDffqAvCAUNNmpZBULt4rwUXUbsdhDvriLZrrk
         Yj4uA6Y5Z+e+AZ0tMEG4aacx4s/+ZnZGuXv5AxJ0ec0EubgvdQmYICmz12d2/5MqW9
         fHqHk9whDyRcpIuaFJihFCu7fTap2iaiF3W9SKZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Oliverio <marco.oliverio@tanaza.com>,
        Rocco Folino <rocco.folino@tanaza.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 57/91] netfilter: nf_queue: enqueue skbs with NULL dst
Date:   Thu,  2 Jan 2020 23:07:39 +0100
Message-Id: <20200102220439.473724376@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
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
index 37efcc1c8887..b06ef4c62522 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -138,7 +138,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		goto err;
 	}
 
-	if (!skb_dst_force(skb) && state->hook != NF_INET_PRE_ROUTING) {
+	if (skb_dst(skb) && !skb_dst_force(skb)) {
 		status = -ENETDOWN;
 		goto err;
 	}
-- 
2.20.1



