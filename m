Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2543C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914D421670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625668;
	bh=17cVRuU6W8q7VjDf23UMfIcNffAFqd8hJoMrPf6lOa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zv0IqJIY7jarXNjuEwuxda0rtjEU9J1yzqTd2K0M4Wuy7HbQ18/HXLSCCNy+jDshR
	 DtmA3Q/q/KKo2CopITEFVpmefx4scuzcqgSgIzUOqQaOryQmSLtDDBU9XmYEG+YJwN
	 bkq4KjBhzRGghzMiKR3E6AczKft1/iljUrizG6Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfD3MBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfD3LpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:45:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F85E21707;
        Tue, 30 Apr 2019 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624718;
        bh=17cVRuU6W8q7VjDf23UMfIcNffAFqd8hJoMrPf6lOa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p6fUMvwQ32LEvWjSiG74XgcybN4jWrfDYC97bKjCQhMLQEO/AvraO7Zy3SfbGjWkK
         n46R5U9ZOMJ2cXwC7PM4NksJmh50Esfws0kIHM5RlBw8vc6dIKaLVzxCqnOKJhl4S3
         EkziAM5O4aGxR83kOZCi2+479P4FqomoH36KNhd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Garcia <nevola@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/100] netfilter: nf_tables: bogus EBUSY in helper removal from transaction
Date:   Tue, 30 Apr 2019 13:37:40 +0200
Message-Id: <20190430113609.146837257@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8ffcd32f64633926163cdd07a7d295c500a947d1 ]

Proper use counter updates when activating and deactivating the object,
otherwise, this hits bogus EBUSY error.

Fixes: cd5125d8f518 ("netfilter: nf_tables: split set destruction in deactivate and destroy phase")
Reported-by: Laura Garcia <nevola@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_objref.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index d8737c115257..bf92a40dd1b2 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -64,21 +64,34 @@ nla_put_failure:
 	return -1;
 }
 
-static void nft_objref_destroy(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr)
+static void nft_objref_deactivate(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr,
+				  enum nft_trans_phase phase)
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
+	if (phase == NFT_TRANS_COMMIT)
+		return;
+
 	obj->use--;
 }
 
+static void nft_objref_activate(const struct nft_ctx *ctx,
+				const struct nft_expr *expr)
+{
+	struct nft_object *obj = nft_objref_priv(expr);
+
+	obj->use++;
+}
+
 static struct nft_expr_type nft_objref_type;
 static const struct nft_expr_ops nft_objref_ops = {
 	.type		= &nft_objref_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_object *)),
 	.eval		= nft_objref_eval,
 	.init		= nft_objref_init,
-	.destroy	= nft_objref_destroy,
+	.activate	= nft_objref_activate,
+	.deactivate	= nft_objref_deactivate,
 	.dump		= nft_objref_dump,
 };
 
-- 
2.19.1



