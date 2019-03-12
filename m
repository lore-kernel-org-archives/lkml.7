Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D592087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413141;
	bh=SBYDqvp/+5zPSEAsX65Pps3hN2TtdTxl392G1KRISWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMODLRLrHxkRTIktdp2RDQAog7VD9EMQPNCXXh32d2rHshZeXdmVwOrW0LU3xeC5X
	 ws36QkkBGoHgs58Cclaq/iiwNpu6OX6cQdBlO0fbaQDqLUVCE8Uex4z4z5OCQIGTYu
	 cOtNhAJsgfHU/PBlf5HqLlyogT5jEbmBH5NJHuiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfCLRO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfCLRNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:45 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F0B217D8;
        Tue, 12 Mar 2019 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410823;
        bh=SBYDqvp/+5zPSEAsX65Pps3hN2TtdTxl392G1KRISWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIhEmOPB/TyebSZXB7rv98VGLRc0UW9c0uc+GIGOoPjSaQVaNmkKBL5VmpWExJEkI
         Qcs3lfhZrk29NWtGCXetTu5yVzGIouKxL1DDR1c/Lgsf4zLY1Hv041+jU5gC2o3idw
         sXVuAen6f3kQlhOMBY/+Z/KOByLlFIl1gOT1jyzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 148/171] netfilter: nft_compat: dont use refcount_inc on newly allocated entry
Date:   Tue, 12 Mar 2019 10:08:48 -0700
Message-Id: <20190312170400.315480327@linuxfoundation.org>
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

[ Upstream commit 947e492c0fc2132ae5fca081a9c2952ccaab0404 ]

When I moved the refcount to refcount_t type I missed the fact that
refcount_inc() will result in use-after-free warning with
CONFIG_REFCOUNT_FULL=y builds.

The correct fix would be to init the reference count to 1 at allocation
time, but, unfortunately we cannot do this, as we can't undo that
in case something else fails later in the batch.

So only solution I see is to special-case the 'new entry' condition
and replace refcount_inc() with a "delayed" refcount_set(1) in this case,
as done here.

The .activate callback can be removed to simplify things, we only
need to make sure that deactivate() decrements/unlinks the entry
from the list at end of transaction phase (commit or abort).

Fixes: 12c44aba6618 ("netfilter: nft_compat: use refcnt_t type for nft_xt reference count")
Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_compat.c | 62 ++++++++++++++------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 5fd94f7fdb94..0a4bad55a8aa 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -61,6 +61,21 @@ static struct nft_compat_net *nft_compat_pernet(struct net *net)
 	return net_generic(net, nft_compat_net_id);
 }
 
+static void nft_xt_get(struct nft_xt *xt)
+{
+	/* refcount_inc() warns on 0 -> 1 transition, but we can't
+	 * init the reference count to 1 in .select_ops -- we can't
+	 * undo such an increase when another expression inside the same
+	 * rule fails afterwards.
+	 */
+	if (xt->listcnt == 0)
+		refcount_set(&xt->refcnt, 1);
+	else
+		refcount_inc(&xt->refcnt);
+
+	xt->listcnt++;
+}
+
 static bool nft_xt_put(struct nft_xt *xt)
 {
 	if (refcount_dec_and_test(&xt->refcnt)) {
@@ -291,7 +306,7 @@ nft_target_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 
 	nft_xt = container_of(expr->ops, struct nft_xt, ops);
-	refcount_inc(&nft_xt->refcnt);
+	nft_xt_get(nft_xt);
 	return 0;
 }
 
@@ -505,7 +520,7 @@ __nft_match_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return ret;
 
 	nft_xt = container_of(expr->ops, struct nft_xt, ops);
-	refcount_inc(&nft_xt->refcnt);
+	nft_xt_get(nft_xt);
 	return 0;
 }
 
@@ -559,45 +574,16 @@ nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 	__nft_match_destroy(ctx, expr, nft_expr_priv(expr));
 }
 
-static void nft_compat_activate(const struct nft_ctx *ctx,
-				const struct nft_expr *expr,
-				struct list_head *h)
-{
-	struct nft_xt *xt = container_of(expr->ops, struct nft_xt, ops);
-
-	if (xt->listcnt == 0)
-		list_add(&xt->head, h);
-
-	xt->listcnt++;
-}
-
-static void nft_compat_activate_mt(const struct nft_ctx *ctx,
-				   const struct nft_expr *expr)
-{
-	struct nft_compat_net *cn = nft_compat_pernet(ctx->net);
-
-	nft_compat_activate(ctx, expr, &cn->nft_match_list);
-}
-
-static void nft_compat_activate_tg(const struct nft_ctx *ctx,
-				   const struct nft_expr *expr)
-{
-	struct nft_compat_net *cn = nft_compat_pernet(ctx->net);
-
-	nft_compat_activate(ctx, expr, &cn->nft_target_list);
-}
-
 static void nft_compat_deactivate(const struct nft_ctx *ctx,
 				  const struct nft_expr *expr,
 				  enum nft_trans_phase phase)
 {
 	struct nft_xt *xt = container_of(expr->ops, struct nft_xt, ops);
 
-	if (phase == NFT_TRANS_COMMIT)
-		return;
-
-	if (--xt->listcnt == 0)
-		list_del_init(&xt->head);
+	if (phase == NFT_TRANS_ABORT || phase == NFT_TRANS_COMMIT) {
+		if (--xt->listcnt == 0)
+			list_del_init(&xt->head);
+	}
 }
 
 static void
@@ -853,7 +839,6 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	nft_match->ops.eval = nft_match_eval;
 	nft_match->ops.init = nft_match_init;
 	nft_match->ops.destroy = nft_match_destroy;
-	nft_match->ops.activate = nft_compat_activate_mt;
 	nft_match->ops.deactivate = nft_compat_deactivate;
 	nft_match->ops.dump = nft_match_dump;
 	nft_match->ops.validate = nft_match_validate;
@@ -871,7 +856,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 
 	nft_match->ops.size = matchsize;
 
-	nft_match->listcnt = 1;
+	nft_match->listcnt = 0;
 	list_add(&nft_match->head, &cn->nft_match_list);
 
 	return &nft_match->ops;
@@ -958,7 +943,6 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	nft_target->ops.size = NFT_EXPR_SIZE(XT_ALIGN(target->targetsize));
 	nft_target->ops.init = nft_target_init;
 	nft_target->ops.destroy = nft_target_destroy;
-	nft_target->ops.activate = nft_compat_activate_tg;
 	nft_target->ops.deactivate = nft_compat_deactivate;
 	nft_target->ops.dump = nft_target_dump;
 	nft_target->ops.validate = nft_target_validate;
@@ -969,7 +953,7 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	else
 		nft_target->ops.eval = nft_target_eval_xt;
 
-	nft_target->listcnt = 1;
+	nft_target->listcnt = 0;
 	list_add(&nft_target->head, &cn->nft_target_list);
 
 	return &nft_target->ops;
-- 
2.19.1



