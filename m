Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589C6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EC221882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765766;
	bh=vB8PEykiLTpJVoylB+3/isI7qp+NEDMc4CvjjxdfpbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fojlhNygGAGuOiu4ju4dRNW9P8HfRxizDzTzPswIAAsWWrJB3kwa/rZqChhD0ES96
	 2OHhVsmz1CYSIserY3W49gak3hI62U1As2Ror4iR4iX/DXRbwJpLw5jLUmcl60UHem
	 TsBWaWEEQe0tKaDczMu67eZnLfRpXZoPcQRk+4dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfI2OCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfI2OCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:02:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36E52082F;
        Sun, 29 Sep 2019 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765761;
        bh=vB8PEykiLTpJVoylB+3/isI7qp+NEDMc4CvjjxdfpbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+FEns+uvSzJ3Pc+DP341+uhcgeg0XadkGt5XKlWYj4Sna3HXGHpAwL4gUyzkSef4
         uyEAa0bxPZbksuZTj3wlwIoi+U240hXA9TfQ4luyDAqRtGClUIRH5/3/3ILGt+3pcc
         ePpJLIfDJMm6cDgjm+N/NQly5E2U4xuI1PJaaBUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 42/45] netfilter: nft_socket: fix erroneous socket assignment
Date:   Sun, 29 Sep 2019 15:56:10 +0200
Message-Id: <20190929135033.655419389@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fernando Fernandez Mancera <ffmancera@riseup.net>

[ Upstream commit 039b1f4f24ecc8493b6bb9d70b4b78750d1b35c2 ]

The socket assignment is wrong, see skb_orphan():
When skb->destructor callback is not set, but skb->sk is set, this hits BUG().

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1651813
Fixes: 554ced0a6e29 ("netfilter: nf_tables: add support for native socket matching")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index d7f3776dfd719..637ce3e8c575c 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -47,9 +47,6 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		return;
 	}
 
-	/* So that subsequent socket matching not to require other lookups. */
-	skb->sk = sk;
-
 	switch(priv->key) {
 	case NFT_SOCKET_TRANSPARENT:
 		nft_reg_store8(dest, inet_sk_transparent(sk));
@@ -66,6 +63,9 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		WARN_ON(1);
 		regs->verdict.code = NFT_BREAK;
 	}
+
+	if (sk != skb->sk)
+		sock_gen_put(sk);
 }
 
 static const struct nla_policy nft_socket_policy[NFTA_SOCKET_MAX + 1] = {
-- 
2.20.1



