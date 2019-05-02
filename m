Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D19F216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810853;
	bh=RRgN9Lf5DDheKg/JkIe2PH7ydiExxtI+NN1+Ry/U9Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wij8mdCBYjoDsJG8LqfaWuJrBOTCLOVJvLS0ItZbCw0ifpNYk/pHnwfBWZF+0Mykf
	 /H66Mm13PDOBoB5KtbYuseBxH9e+iEnWHFGefFWPkRKB/qkljJD+UFn+PgM6eqqoNE
	 aSPCZRwnBWjhVWWHSCP5YlvKnpkXAF8u2gVf97cA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfEBP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEBP1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:27:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E653921743;
        Thu,  2 May 2019 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810849;
        bh=RRgN9Lf5DDheKg/JkIe2PH7ydiExxtI+NN1+Ry/U9Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4bjRadtv0RMnkcXbcAG9IUdasWMpACG9oRPmlh97oAI9O7sTyQomSGdWY8q9aUjF
         U7TdOgMA9dujpFT0icwkl7iBn0si4flDziAC/wFU3+mMYQzQJ9tJJb+fHpLMmslyG7
         fiTGsgrrZi2ADn3cYMT3EP5uTIP8HBu2YvQ1f0b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?V=C3=A1clav=20Zindulka?= <vaclav.zindulka@tlapnet.cz>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 16/72] netfilter: nft_set_rbtree: check for inactive element after flag mismatch
Date:   Thu,  2 May 2019 17:20:38 +0200
Message-Id: <20190502143334.618978604@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 05b7639da55f5555b9866a1f4b7e8995232a6323 ]

Otherwise, we hit bogus ENOENT when removing elements.

Fixes: e701001e7cbe ("netfilter: nft_rbtree: allow adjacent intervals with dynamic updates")
Reported-by: Václav Zindulka <vaclav.zindulka@tlapnet.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 net/netfilter/nft_set_rbtree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 0e5ec126f6ad..b3e75f9cb686 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -302,10 +302,6 @@ static void *nft_rbtree_deactivate(const struct net *net,
 		else if (d > 0)
 			parent = parent->rb_right;
 		else {
-			if (!nft_set_elem_active(&rbe->ext, genmask)) {
-				parent = parent->rb_left;
-				continue;
-			}
 			if (nft_rbtree_interval_end(rbe) &&
 			    !nft_rbtree_interval_end(this)) {
 				parent = parent->rb_left;
@@ -314,6 +310,9 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
+			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
+				parent = parent->rb_left;
+				continue;
 			}
 			nft_rbtree_flush(net, set, rbe);
 			return rbe;
-- 
2.19.1



