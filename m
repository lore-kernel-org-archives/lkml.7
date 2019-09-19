Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF221929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930882;
	bh=5Gw7uWbkjG4eU9AQngmmoe93HSJtU1VEZC9Nxv8XPAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y6dkB0w+TwCqeDiERMo2JVG2wNbN4aZqHplGfQkk42rYbZADMeD0YDLPkRrpdRep1
	 G6d9W14ycP/sHjBkJqt5RDhFkezNbSPw6qr1nPWD8JrXK9MidWX9iARktmOdRThgg/
	 0Y3U3Xh5fV6dfL5R7mIbPjF03w4AEfJKNT8cwK4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393324AbfISWIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393310AbfISWH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:07:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2060821929;
        Thu, 19 Sep 2019 22:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930878;
        bh=5Gw7uWbkjG4eU9AQngmmoe93HSJtU1VEZC9Nxv8XPAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nG/K5VTPj5WxmGGvWHvgLkzT2ebWVam3iORFOLiEoALCSXjkOaMp2Degep585xHM6
         Y/vKxLKNYyqQTB2+tUzcH4wPphvbnBRXlXPPIY/64mEkiwGak+agemAAB9r9DJwtZg
         VR7iF83hgifAgxcuvyta/kc0L6tu60+n2A9KPi+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 048/124] netfilter: nft_flow_offload: missing netlink attribute policy
Date:   Fri, 20 Sep 2019 00:02:16 +0200
Message-Id: <20190919214820.749911965@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 14c415862c0630e01712a4eeaf6159a2b1b6d2a4 ]

The netlink attribute policy for NFTA_FLOW_TABLE_NAME is missing.

Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_flow_offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 060a4ed46d5e6..01705ad74a9aa 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -149,6 +149,11 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
 }
 
+static const struct nla_policy nft_flow_offload_policy[NFTA_FLOW_MAX + 1] = {
+	[NFTA_FLOW_TABLE_NAME]	= { .type = NLA_STRING,
+				    .len = NFT_NAME_MAXLEN - 1 },
+};
+
 static int nft_flow_offload_init(const struct nft_ctx *ctx,
 				 const struct nft_expr *expr,
 				 const struct nlattr * const tb[])
@@ -207,6 +212,7 @@ static const struct nft_expr_ops nft_flow_offload_ops = {
 static struct nft_expr_type nft_flow_offload_type __read_mostly = {
 	.name		= "flow_offload",
 	.ops		= &nft_flow_offload_ops,
+	.policy		= nft_flow_offload_policy,
 	.maxattr	= NFTA_FLOW_MAX,
 	.owner		= THIS_MODULE,
 };
-- 
2.20.1



