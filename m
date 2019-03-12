Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E13FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD63217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410721;
	bh=CarXhbgeLHduO68N4wDfNraTupo6tim4dSVo9KnLgGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IqrZxatZ+5S5WhbnUhsbq1gpuuFyouKlvUifU4T7RpxXASi5LRL/7xZf90/VzbBaW
	 S3sT0WtBoKUyzeMrG4MdnQkuUVRxvkjjnHwgMatJXRn016uZpfrvOLIYZUwFwVmrY3
	 kJUO8kkQFOxqb2Rek4cA3Y2mSRZ7MLLObek5o8Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCLRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfCLRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:48 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8122171F;
        Tue, 12 Mar 2019 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410707;
        bh=CarXhbgeLHduO68N4wDfNraTupo6tim4dSVo9KnLgGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLbAq7RJR1e/tRmhEgtxQCRXNyo+xos4X7rmV1EPcaE8JcEDRuQ9Ync54pVn64xKR
         D5qX77rT8bfo92vq7nDmZxU+KZObIdHYSfSdhEojpmvLLLiNnJUMwsjpG3lJJVKu9M
         oO8sOtGAJ0mBAdBioL0nfViSz3LmWJfU/UF5NhuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 006/171] netfilter: nft_compat: destroy function must not have side effects
Date:   Tue, 12 Mar 2019 10:06:26 -0700
Message-Id: <20190312170348.408448086@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b2e3d68d1251a051a620f9086e18f7ffa6833b5b ]

The nft_compat destroy function deletes the nft_xt object from a list.
This isn't allowed anymore. Destroy functions are called asynchronously,
i.e. next batch can find the object that has a pending ->destroy()
invocation:

cpu0                       cpu1
 worker
   ->destroy               for_each_entry()
	                     if (x == ...
			        return x->ops;
     list_del(x)
     kfree_rcu(x)
                           expr->ops->... // ops was free'd

To resolve this, the list_del needs to occur before the transaction
mutex gets released.  nf_tables has a 'deactivate' hook for this
purpose, so use that to unlink the object from the list.

Fixes: 0935d5588400 ("netfilter: nf_tables: asynchronous release")
Reported-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_compat.c | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index d3412138e000..a354e9771697 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -29,6 +29,9 @@ struct nft_xt {
 	struct nft_expr_ops	ops;
 	refcount_t		refcnt;
 
+	/* used only when transaction mutex is locked */
+	unsigned int		listcnt;
+
 	/* Unlike other expressions, ops doesn't have static storage duration.
 	 * nft core assumes they do.  We use kfree_rcu so that nft core can
 	 * can check expr->ops->size even after nft_compat->destroy() frees
@@ -61,7 +64,7 @@ static struct nft_compat_net *nft_compat_pernet(struct net *net)
 static bool nft_xt_put(struct nft_xt *xt)
 {
 	if (refcount_dec_and_test(&xt->refcnt)) {
-		list_del(&xt->head);
+		WARN_ON_ONCE(!list_empty(&xt->head));
 		kfree_rcu(xt, rcu_head);
 		return true;
 	}
@@ -556,6 +559,43 @@ nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 	__nft_match_destroy(ctx, expr, nft_expr_priv(expr));
 }
 
+static void nft_compat_activate(const struct nft_ctx *ctx,
+				const struct nft_expr *expr,
+				struct list_head *h)
+{
+	struct nft_xt *xt = container_of(expr->ops, struct nft_xt, ops);
+
+	if (xt->listcnt == 0)
+		list_add(&xt->head, h);
+
+	xt->listcnt++;
+}
+
+static void nft_compat_activate_mt(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	struct nft_compat_net *cn = nft_compat_pernet(ctx->net);
+
+	nft_compat_activate(ctx, expr, &cn->nft_match_list);
+}
+
+static void nft_compat_activate_tg(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	struct nft_compat_net *cn = nft_compat_pernet(ctx->net);
+
+	nft_compat_activate(ctx, expr, &cn->nft_target_list);
+}
+
+static void nft_compat_deactivate(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr)
+{
+	struct nft_xt *xt = container_of(expr->ops, struct nft_xt, ops);
+
+	if (--xt->listcnt == 0)
+		list_del_init(&xt->head);
+}
+
 static void
 nft_match_large_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -809,6 +849,8 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	nft_match->ops.eval = nft_match_eval;
 	nft_match->ops.init = nft_match_init;
 	nft_match->ops.destroy = nft_match_destroy;
+	nft_match->ops.activate = nft_compat_activate_mt;
+	nft_match->ops.deactivate = nft_compat_deactivate;
 	nft_match->ops.dump = nft_match_dump;
 	nft_match->ops.validate = nft_match_validate;
 	nft_match->ops.data = match;
@@ -825,6 +867,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 
 	nft_match->ops.size = matchsize;
 
+	nft_match->listcnt = 1;
 	list_add(&nft_match->head, &cn->nft_match_list);
 
 	return &nft_match->ops;
@@ -911,6 +954,8 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	nft_target->ops.size = NFT_EXPR_SIZE(XT_ALIGN(target->targetsize));
 	nft_target->ops.init = nft_target_init;
 	nft_target->ops.destroy = nft_target_destroy;
+	nft_target->ops.activate = nft_compat_activate_tg;
+	nft_target->ops.deactivate = nft_compat_deactivate;
 	nft_target->ops.dump = nft_target_dump;
 	nft_target->ops.validate = nft_target_validate;
 	nft_target->ops.data = target;
@@ -920,6 +965,7 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	else
 		nft_target->ops.eval = nft_target_eval_xt;
 
+	nft_target->listcnt = 1;
 	list_add(&nft_target->head, &cn->nft_target_list);
 
 	return &nft_target->ops;
-- 
2.19.1



