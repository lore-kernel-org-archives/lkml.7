Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919432;
	bh=JYkujlxxw32yNS0nlfdlOjicILURIxzUFUSHXFtYckM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ubAFjbdXh8gG4DenNA1IbapPz0DqaQnX+WptEY+BRrXWkpbL6Hr9YI52K7kplbm+h
	 bMBImOWDNIs1I4q8zGG416gIq3iLwV3D8yP+Sd/34qWRXYiVWd4nGyvNsWFwCVK89i
	 NTtZOLwgO6qjt72LSbEkozEubyjI8MBJ8Xni1ut4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbfEOLXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbfEOLXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A27920881;
        Wed, 15 May 2019 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919427;
        bh=JYkujlxxw32yNS0nlfdlOjicILURIxzUFUSHXFtYckM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8McB0ICo8WY4Vqj/V4K0h2XaeVw6MDv4MVwXL/Qo7zxkR7cS9rlxU3JuJfRB0Fn+
         3WyQ1KhaIUG2/8RmeUKQX5OyTxcF+tu6gpurxiabAHRoSMfUR0st5thXPvBCwN5QNt
         0tn+U6yIM6F2ngvn3CGI9qR82KtJLLHWu0rq3gKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.19 070/113] netfilter: nf_tables: use-after-free in dynamic operations
Date:   Wed, 15 May 2019 12:56:01 +0200
Message-Id: <20190515090658.842149354@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3f3a390dbd59d236f62cff8e8b20355ef7069e3d ]

Smatch reports:

       net/netfilter/nf_tables_api.c:2167 nf_tables_expr_destroy()
        error: dereferencing freed memory 'expr->ops'

net/netfilter/nf_tables_api.c
    2162 static void nf_tables_expr_destroy(const struct nft_ctx *ctx,
    2163                                   struct nft_expr *expr)
    2164 {
    2165        if (expr->ops->destroy)
    2166                expr->ops->destroy(ctx, expr);
                                                ^^^^
--> 2167        module_put(expr->ops->type->owner);
                           ^^^^^^^^^
    2168 }

Smatch says there are three functions which free expr->ops.

Fixes: b8e204006340 ("netfilter: nft_compat: use .release_ops and remove list of extension")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_tables_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f272f9538c44a..ef7ff13a7b992 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2113,9 +2113,11 @@ static int nf_tables_newexpr(const struct nft_ctx *ctx,
 static void nf_tables_expr_destroy(const struct nft_ctx *ctx,
 				   struct nft_expr *expr)
 {
+	const struct nft_expr_type *type = expr->ops->type;
+
 	if (expr->ops->destroy)
 		expr->ops->destroy(ctx, expr);
-	module_put(expr->ops->type->owner);
+	module_put(type->owner);
 }
 
 struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
-- 
2.20.1



