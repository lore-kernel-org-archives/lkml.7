Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7775FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4879020880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141803;
	bh=ofLYgo2g1HPJlw4IigGPZi62VPq4brPNNhSZbPjqlBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ctn41v9elobGYM1KEU+N/V+X/P2Y0msxGHq9P3Kr5Y203SuWCNsynl1hzgh5nZi4
	 FX5HO4VpbxE+dUdAVhxrVe168Pc7qn9vdjFiqfZrAAzsFtNHAihkIngcsCxD6xhScV
	 xKuTk6GaKnGSoDS9hoGaya2SfH/vqFqRnbvN9JW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfDAROI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbfDAROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D999E2171F;
        Mon,  1 Apr 2019 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138247;
        bh=ofLYgo2g1HPJlw4IigGPZi62VPq4brPNNhSZbPjqlBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTF3Z4gBqvFsptPnjWbJwL9zRwCQhqdyAEFefle+z3eXqJKLElun00qbnPw8jwRYk
         1DOp6y/rsNxGm1gqA2m3OsTrq7bTGPhVblCTgvPxywHZ54LI+CnkEGtTrOhGzN5JGo
         2xLj4s7/Ij38K8nQiyapkRVRkXtSDLh6H0EVWmkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 003/146] netfilter: nf_tables: fix set double-free in abort path
Date:   Mon,  1 Apr 2019 19:00:15 +0200
Message-Id: <20190401170048.726418947@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 40ba1d9b4d19796afc9b7ece872f5f3e8f5e2c13 ]

The abort path can cause a double-free of an anonymous set.
Added-and-to-be-aborted rule looks like this:

udp dport { 137, 138 } drop

The to-be-aborted transaction list looks like this:

newset
newsetelem
newsetelem
rule

This gets walked in reverse order, so first pass disables the rule, the
set elements, then the set.

After synchronize_rcu(), we then destroy those in same order: rule, set
element, set element, newset.

Problem is that the anonymous set has already been bound to the rule, so
the rule (lookup expression destructor) already frees the set, when then
cause use-after-free when trying to delete the elements from this set,
then try to free the set again when handling the newset expression.

Rule releases the bound set in first place from the abort path, this
causes the use-after-free on set element removal when undoing the new
element transactions. To handle this, skip new element transaction if
set is bound from the abort path.

This is still causes the use-after-free on set element removal.  To
handle this, remove transaction from the list when the set is already
bound.

Joint work with Florian Westphal.

Fixes: f6ac85858976 ("netfilter: nf_tables: unbind set in rule from commit path")
Bugzilla: https://bugzilla.netfilter.org/show_bug.cgi?id=1325
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |    6 ++----
 net/netfilter/nf_tables_api.c     |   17 +++++++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -416,7 +416,8 @@ struct nft_set {
 	unsigned char			*udata;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
-	u16				flags:14,
+	u16				flags:13,
+					bound:1,
 					genmask:2;
 	u8				klen;
 	u8				dlen;
@@ -1329,15 +1330,12 @@ struct nft_trans_rule {
 struct nft_trans_set {
 	struct nft_set			*set;
 	u32				set_id;
-	bool				bound;
 };
 
 #define nft_trans_set(trans)	\
 	(((struct nft_trans_set *)trans->data)->set)
 #define nft_trans_set_id(trans)	\
 	(((struct nft_trans_set *)trans->data)->set_id)
-#define nft_trans_set_bound(trans)	\
-	(((struct nft_trans_set *)trans->data)->bound)
 
 struct nft_trans_chain {
 	bool				update;
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -127,7 +127,7 @@ static void nft_set_trans_bind(const str
 	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
 		if (trans->msg_type == NFT_MSG_NEWSET &&
 		    nft_trans_set(trans) == set) {
-			nft_trans_set_bound(trans) = true;
+			set->bound = true;
 			break;
 		}
 	}
@@ -6617,8 +6617,7 @@ static void nf_tables_abort_release(stru
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_NEWSET:
-		if (!nft_trans_set_bound(trans))
-			nft_set_destroy(nft_trans_set(trans));
+		nft_set_destroy(nft_trans_set(trans));
 		break;
 	case NFT_MSG_NEWSETELEM:
 		nft_set_elem_destroy(nft_trans_elem_set(trans),
@@ -6691,8 +6690,11 @@ static int __nf_tables_abort(struct net
 			break;
 		case NFT_MSG_NEWSET:
 			trans->ctx.table->use--;
-			if (!nft_trans_set_bound(trans))
-				list_del_rcu(&nft_trans_set(trans)->list);
+			if (nft_trans_set(trans)->bound) {
+				nft_trans_destroy(trans);
+				break;
+			}
+			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
 			trans->ctx.table->use++;
@@ -6700,8 +6702,11 @@ static int __nf_tables_abort(struct net
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
+			if (nft_trans_elem_set(trans)->bound) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			te = (struct nft_trans_elem *)trans->data;
-
 			te->set->ops->remove(net, te->set, &te->elem);
 			atomic_dec(&te->set->nelems);
 			break;


