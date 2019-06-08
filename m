Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB7CC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4319214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994930;
	bh=Anl24wVRwQz/64PnpnLUW8+rHvTzsBxXk1v9M9lAXgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bjtZYsS/TBnZvJHZHyTpmoATwFfs4vmcBz1P04CqklyEVba4veoQyl2Qn6ZIiNQNv
	 FpxWBoQdO1nb3e/6lXmqbqoTcTFyZXiCukbirAJxtFob3NirYBIQvDL2MC3HtyAaJ6
	 lB+vxvk0AWJWjYrD0ICMTC5gba9uVWcTlKpjEQ0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfFHLz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfFHLkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:40:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1AE214C6;
        Sat,  8 Jun 2019 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994002;
        bh=Anl24wVRwQz/64PnpnLUW8+rHvTzsBxXk1v9M9lAXgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyTqEfRTZJS8+Vy407O46uKdqO/Xl6xz2WPeM/XhiPSwRX6L/DQS3ciAtMFCpbbfI
         XiUbdhux9TJCTSWdVbs/ZC/VeohO0dIaHaQv8w8N2N0idNrqIeaOFefYw2B0gfVDiu
         PCHdLUtYlVVnUSGglJ5OnbuM42TBxwZjI52oDUOM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 09/70] netfilter: nf_tables: fix oops during rule dump
Date:   Sat,  8 Jun 2019 07:38:48 -0400
Message-Id: <20190608113950.8033-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2c82c7e724ff51cab78e1afd5c2aaa31994fe41e ]

We can oops in nf_tables_fill_rule_info().

Its not possible to fetch previous element in rcu-protected lists
when deletions are not prevented somehow: list_del_rcu poisons
the ->prev pointer value.

Before rcu-conversion this was safe as dump operations did hold
nfnetlink mutex.

Pass previous rule as argument, obtained by keeping a pointer to
the previous rule during traversal.

Fixes: d9adf22a291883 ("netfilter: nf_tables: use call_rcu in netlink dumps")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1606eaa5ae0d..041a81185c6a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2256,13 +2256,13 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 				    u32 flags, int family,
 				    const struct nft_table *table,
 				    const struct nft_chain *chain,
-				    const struct nft_rule *rule)
+				    const struct nft_rule *rule,
+				    const struct nft_rule *prule)
 {
 	struct nlmsghdr *nlh;
 	struct nfgenmsg *nfmsg;
 	const struct nft_expr *expr, *next;
 	struct nlattr *list;
-	const struct nft_rule *prule;
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
 	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
@@ -2282,8 +2282,7 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 			 NFTA_RULE_PAD))
 		goto nla_put_failure;
 
-	if ((event != NFT_MSG_DELRULE) && (rule->list.prev != &chain->rules)) {
-		prule = list_prev_entry(rule, list);
+	if (event != NFT_MSG_DELRULE && prule) {
 		if (nla_put_be64(skb, NFTA_RULE_POSITION,
 				 cpu_to_be64(prule->handle),
 				 NFTA_RULE_PAD))
@@ -2330,7 +2329,7 @@ static void nf_tables_rule_notify(const struct nft_ctx *ctx,
 
 	err = nf_tables_fill_rule_info(skb, ctx->net, ctx->portid, ctx->seq,
 				       event, 0, ctx->family, ctx->table,
-				       ctx->chain, rule);
+				       ctx->chain, rule, NULL);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto err;
@@ -2355,12 +2354,13 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 				  const struct nft_chain *chain)
 {
 	struct net *net = sock_net(skb->sk);
+	const struct nft_rule *rule, *prule;
 	unsigned int s_idx = cb->args[0];
-	const struct nft_rule *rule;
 
+	prule = NULL;
 	list_for_each_entry_rcu(rule, &chain->rules, list) {
 		if (!nft_is_active(net, rule))
-			goto cont;
+			goto cont_skip;
 		if (*idx < s_idx)
 			goto cont;
 		if (*idx > s_idx) {
@@ -2372,11 +2372,13 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 					NFT_MSG_NEWRULE,
 					NLM_F_MULTI | NLM_F_APPEND,
 					table->family,
-					table, chain, rule) < 0)
+					table, chain, rule, prule) < 0)
 			return 1;
 
 		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 cont:
+		prule = rule;
+cont_skip:
 		(*idx)++;
 	}
 	return 0;
@@ -2532,7 +2534,7 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 
 	err = nf_tables_fill_rule_info(skb2, net, NETLINK_CB(skb).portid,
 				       nlh->nlmsg_seq, NFT_MSG_NEWRULE, 0,
-				       family, table, chain, rule);
+				       family, table, chain, rule, NULL);
 	if (err < 0)
 		goto err;
 
-- 
2.20.1

