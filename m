Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF6AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C3F208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfD0PP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33332 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbfD0PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:25 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-0000zB-To; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004bT-NU; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Taehee Yoo" <ap420073@gmail.com>,
        "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.639893397@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 157/202] netfilter: nf_tables: nft_compat: fix
 refcount leak on xt module
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b8e9dc1c75714ceb53615743e1036f76e00f5a17 upstream.

Taehee Yoo reported following bug:
    iptables-compat -I OUTPUT -m cpu --cpu 0
    iptables-compat -F
    lsmod |grep xt_cpu
    xt_cpu                 16384  1

Quote:
"When above command is given, a netlink message has two expressions that
are the cpu compat and the nft_counter.
The nft_expr_type_get() in the nf_tables_expr_parse() successes
first expression then, calls select_ops callback.
(allocates memory and holds module)
But, second nft_expr_type_get() in the nf_tables_expr_parse()
returns -EAGAIN because of request_module().
In that point, by the 'goto err1',
the 'module_put(info[i].ops->type->owner)' is called.
There is no release routine."

The core problem is that unlike all other expression,
nft_compat select_ops has side effects.

1. it allocates dynamic memory which holds an nft ops struct.
   In all other expressions, ops has static storage duration.
2. It grabs references to the xt module that it is supposed to
   invoke.

Depending on where things go wrong, error unwinding doesn't
always do the right thing.

In the above scenario, a new nft_compat_expr is created and
xt_cpu module gets loaded with a refcount of 1.

Due to to -EAGAIN, the netlink messages get re-parsed.
When that happens, nft_compat finds that xt_cpu is already present
and increments module refcount again.

This fixes the problem by making select_ops to have no visible
side effects and removes all extra module_get/put.

When select_ops creates a new nft_compat expression, the new
expression has a refcount of 0, and the xt module gets its refcount
incremented.

When error happens, the next call finds existing entry, but will no
longer increase the reference count -- the presence of existing
nft_xt means we already hold a module reference.

Because nft_xt_put is only called from nft_compat destroy hook,
it will never see the initial zero reference count.
->destroy can only be called after ->init(), and that will increase the
refcount.

Lastly, we now free nft_xt struct with kfree_rcu.
Else, we get use-after free in nf_tables_rule_destroy:

  while (expr != nft_expr_last(rule) && expr->ops) {
    nf_tables_expr_destroy(ctx, expr);
    expr = nft_expr_next(expr); // here

nft_expr_next() dereferences expr->ops. This is safe
for all users, as ops have static storage duration.
In nft_compat case however, its ->destroy callback can
free the memory that hold the ops structure.

Tested-by: Taehee Yoo <ap420073@gmail.com>
Reported-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nft_compat.c | 92 ++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 34 deletions(-)

--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -26,14 +26,24 @@ struct nft_xt {
 	struct list_head	head;
 	struct nft_expr_ops	ops;
 	unsigned int		refcnt;
+
+	/* Unlike other expressions, ops doesn't have static storage duration.
+	 * nft core assumes they do.  We use kfree_rcu so that nft core can
+	 * can check expr->ops->size even after nft_compat->destroy() frees
+	 * the nft_xt struct that holds the ops structure.
+	 */
+	struct rcu_head		rcu_head;
 };
 
-static void nft_xt_put(struct nft_xt *xt)
+static bool nft_xt_put(struct nft_xt *xt)
 {
 	if (--xt->refcnt == 0) {
 		list_del(&xt->head);
-		kfree(xt);
+		kfree_rcu(xt, rcu_head);
+		return true;
 	}
+
+	return false;
 }
 
 union nft_entry {
@@ -177,6 +187,7 @@ nft_target_init(const struct nft_ctx *ct
 	struct xt_target *target = expr->ops->data;
 	struct xt_tgchk_param par;
 	size_t size = XT_ALIGN(nla_len(tb[NFTA_TARGET_INFO]));
+	struct nft_xt *nft_xt;
 	u8 proto = 0;
 	bool inv = false;
 	union nft_entry e = {};
@@ -187,25 +198,22 @@ nft_target_init(const struct nft_ctx *ct
 	if (ctx->nla[NFTA_RULE_COMPAT]) {
 		ret = nft_parse_compat(ctx->nla[NFTA_RULE_COMPAT], &proto, &inv);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
 	nft_target_set_tgchk_param(&par, ctx, target, info, &e, proto, inv);
 
 	ret = xt_check_target(&par, size, proto, inv);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	/* The standard target cannot be used */
-	if (target->target == NULL) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (!target->target)
+		return -EINVAL;
 
+	nft_xt = container_of(expr->ops, struct nft_xt, ops);
+	nft_xt->refcnt++;
 	return 0;
-err:
-	module_put(target->me);
-	return ret;
 }
 
 static void
@@ -222,8 +230,8 @@ nft_target_destroy(const struct nft_ctx
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 
-	nft_xt_put(container_of(expr->ops, struct nft_xt, ops));
-	module_put(target->me);
+	if (nft_xt_put(container_of(expr->ops, struct nft_xt, ops)))
+		module_put(target->me);
 }
 
 static int
@@ -383,6 +391,7 @@ nft_match_init(const struct nft_ctx *ctx
 	struct xt_match *match = expr->ops->data;
 	struct xt_mtchk_param par;
 	size_t size = XT_ALIGN(nla_len(tb[NFTA_MATCH_INFO]));
+	struct nft_xt *nft_xt;
 	u8 proto = 0;
 	bool inv = false;
 	union nft_entry e = {};
@@ -393,19 +402,18 @@ nft_match_init(const struct nft_ctx *ctx
 	if (ctx->nla[NFTA_RULE_COMPAT]) {
 		ret = nft_parse_compat(ctx->nla[NFTA_RULE_COMPAT], &proto, &inv);
 		if (ret < 0)
-			goto err;
+			return ret;
 	}
 
 	nft_match_set_mtchk_param(&par, ctx, match, info, &e, proto, inv);
 
 	ret = xt_check_match(&par, size, proto, inv);
 	if (ret < 0)
-		goto err;
+		return ret;
 
+	nft_xt = container_of(expr->ops, struct nft_xt, ops);
+	nft_xt->refcnt++;
 	return 0;
-err:
-	module_put(match->me);
-	return ret;
 }
 
 static void
@@ -423,8 +431,8 @@ nft_match_destroy(const struct nft_ctx *
 	if (par.match->destroy != NULL)
 		par.match->destroy(&par);
 
-	nft_xt_put(container_of(expr->ops, struct nft_xt, ops));
-	module_put(me);
+	if (nft_xt_put(container_of(expr->ops, struct nft_xt, ops)))
+		module_put(me);
 }
 
 static int
@@ -653,13 +661,8 @@ nft_match_select_ops(const struct nft_ct
 	list_for_each_entry(nft_match, &nft_match_list, head) {
 		struct xt_match *match = nft_match->ops.data;
 
-		if (nft_match_cmp(match, mt_name, rev, family)) {
-			if (!try_module_get(match->me))
-				return ERR_PTR(-ENOENT);
-
-			nft_match->refcnt++;
+		if (nft_match_cmp(match, mt_name, rev, family))
 			return &nft_match->ops;
-		}
 	}
 
 	match = xt_request_find_match(family, mt_name, rev);
@@ -671,7 +674,7 @@ nft_match_select_ops(const struct nft_ct
 	if (nft_match == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	nft_match->refcnt = 1;
+	nft_match->refcnt = 0;
 	nft_match->ops.type = &nft_match_type;
 	nft_match->ops.size = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize) +
 					    nft_compat_match_offset(match));
@@ -728,13 +731,8 @@ nft_target_select_ops(const struct nft_c
 	list_for_each_entry(nft_target, &nft_target_list, head) {
 		struct xt_target *target = nft_target->ops.data;
 
-		if (nft_target_cmp(target, tg_name, rev, family)) {
-			if (!try_module_get(target->me))
-				return ERR_PTR(-ENOENT);
-
-			nft_target->refcnt++;
+		if (nft_target_cmp(target, tg_name, rev, family))
 			return &nft_target->ops;
-		}
 	}
 
 	target = xt_request_find_target(family, tg_name, rev);
@@ -746,7 +744,7 @@ nft_target_select_ops(const struct nft_c
 	if (nft_target == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	nft_target->refcnt = 1;
+	nft_target->refcnt = 0;
 	nft_target->ops.type = &nft_target_type;
 	nft_target->ops.size = NFT_EXPR_SIZE(XT_ALIGN(target->targetsize) +
 					     nft_compat_target_offset(target));
@@ -801,6 +799,32 @@ err_match:
 
 static void __exit nft_compat_module_exit(void)
 {
+	struct nft_xt *xt, *next;
+
+	/* list should be empty here, it can be non-empty only in case there
+	 * was an error that caused nft_xt expr to not be initialized fully
+	 * and noone else requested the same expression later.
+	 *
+	 * In this case, the lists contain 0-refcount entries that still
+	 * hold module reference.
+	 */
+	list_for_each_entry_safe(xt, next, &nft_target_list, head) {
+		struct xt_target *target = xt->ops.data;
+
+		if (WARN_ON_ONCE(xt->refcnt))
+			continue;
+		module_put(target->me);
+		kfree(xt);
+	}
+
+	list_for_each_entry_safe(xt, next, &nft_match_list, head) {
+		struct xt_match *match = xt->ops.data;
+
+		if (WARN_ON_ONCE(xt->refcnt))
+			continue;
+		module_put(match->me);
+		kfree(xt);
+	}
 	nfnetlink_subsys_unregister(&nfnl_compat_subsys);
 	nft_unregister_expr(&nft_target_type);
 	nft_unregister_expr(&nft_match_type);

