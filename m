Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D965CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0671206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfD0PYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33466 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbfD0PP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:26 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-0000zK-Sw; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004bL-MW; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Liping Zhang" <liping.zhang@spreadtrum.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.283493004@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 156/202] netfilter: nft_compat: fix crash when
 related match/target module is removed
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

From: Liping Zhang <liping.zhang@spreadtrum.com>

commit 4b512e1c1f8de6b9ceb796ecef8658e0a083cab7 upstream.

We "cache" the loaded match/target modules and reuse them, but when the
modules are removed, we still point to them. Then we may end up with
invalid memory references when using iptables-compat to add rules later.

Input the following commands will reproduce the kernel crash:
  # iptables-compat -A INPUT -j LOG
  # iptables-compat -D INPUT -j LOG
  # rmmod xt_LOG
  # iptables-compat -A INPUT -j LOG
  BUG: unable to handle kernel paging request at ffffffffa05a9010
  IP: [<ffffffff813f783e>] strcmp+0xe/0x30
  Call Trace:
  [<ffffffffa05acc43>] nft_target_select_ops+0x83/0x1f0 [nft_compat]
  [<ffffffffa058a177>] nf_tables_expr_parse+0x147/0x1f0 [nf_tables]
  [<ffffffffa058e541>] nf_tables_newrule+0x301/0x810 [nf_tables]
  [<ffffffff8141ca00>] ? nla_parse+0x20/0x100
  [<ffffffffa057fa8f>] nfnetlink_rcv+0x33f/0x53d [nfnetlink]
  [<ffffffffa057f94b>] ? nfnetlink_rcv+0x1fb/0x53d [nfnetlink]
  [<ffffffff817116b8>] netlink_unicast+0x178/0x220
  [<ffffffff81711a5b>] netlink_sendmsg+0x2fb/0x3a0
  [<ffffffff816b7fc8>] sock_sendmsg+0x38/0x50
  [<ffffffff816b8a7e>] ___sys_sendmsg+0x28e/0x2a0
  [<ffffffff816bcb7e>] ? release_sock+0x1e/0xb0
  [<ffffffff81804ac5>] ? _raw_spin_unlock_bh+0x35/0x40
  [<ffffffff816bcbe2>] ? release_sock+0x82/0xb0
  [<ffffffff816b93d4>] __sys_sendmsg+0x54/0x90
  [<ffffffff816b9422>] SyS_sendmsg+0x12/0x20
  [<ffffffff81805172>] entry_SYSCALL_64_fastpath+0x1a/0xa9

So when nobody use the related match/target module, there's no need to
"cache" it. And nft_[match|target]_release are useless anymore, remove
them.

Signed-off-by: Liping Zhang <liping.zhang@spreadtrum.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nft_compat.c | 43 ++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -22,6 +22,20 @@
 #include <asm/uaccess.h> /* for set_fs */
 #include <net/netfilter/nf_tables.h>
 
+struct nft_xt {
+	struct list_head	head;
+	struct nft_expr_ops	ops;
+	unsigned int		refcnt;
+};
+
+static void nft_xt_put(struct nft_xt *xt)
+{
+	if (--xt->refcnt == 0) {
+		list_del(&xt->head);
+		kfree(xt);
+	}
+}
+
 union nft_entry {
 	struct ipt_entry e4;
 	struct ip6t_entry e6;
@@ -208,6 +222,7 @@ nft_target_destroy(const struct nft_ctx
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 
+	nft_xt_put(container_of(expr->ops, struct nft_xt, ops));
 	module_put(target->me);
 }
 
@@ -408,6 +423,7 @@ nft_match_destroy(const struct nft_ctx *
 	if (par.match->destroy != NULL)
 		par.match->destroy(&par);
 
+	nft_xt_put(container_of(expr->ops, struct nft_xt, ops));
 	module_put(me);
 }
 
@@ -606,11 +622,6 @@ static const struct nfnetlink_subsystem
 
 static LIST_HEAD(nft_match_list);
 
-struct nft_xt {
-	struct list_head	head;
-	struct nft_expr_ops	ops;
-};
-
 static struct nft_expr_type nft_match_type;
 
 static bool nft_match_cmp(const struct xt_match *match,
@@ -646,6 +657,7 @@ nft_match_select_ops(const struct nft_ct
 			if (!try_module_get(match->me))
 				return ERR_PTR(-ENOENT);
 
+			nft_match->refcnt++;
 			return &nft_match->ops;
 		}
 	}
@@ -659,6 +671,7 @@ nft_match_select_ops(const struct nft_ct
 	if (nft_match == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	nft_match->refcnt = 1;
 	nft_match->ops.type = &nft_match_type;
 	nft_match->ops.size = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize) +
 					    nft_compat_match_offset(match));
@@ -674,14 +687,6 @@ nft_match_select_ops(const struct nft_ct
 	return &nft_match->ops;
 }
 
-static void nft_match_release(void)
-{
-	struct nft_xt *nft_match, *tmp;
-
-	list_for_each_entry_safe(nft_match, tmp, &nft_match_list, head)
-		kfree(nft_match);
-}
-
 static struct nft_expr_type nft_match_type __read_mostly = {
 	.name		= "match",
 	.select_ops	= nft_match_select_ops,
@@ -727,6 +732,7 @@ nft_target_select_ops(const struct nft_c
 			if (!try_module_get(target->me))
 				return ERR_PTR(-ENOENT);
 
+			nft_target->refcnt++;
 			return &nft_target->ops;
 		}
 	}
@@ -740,6 +746,7 @@ nft_target_select_ops(const struct nft_c
 	if (nft_target == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	nft_target->refcnt = 1;
 	nft_target->ops.type = &nft_target_type;
 	nft_target->ops.size = NFT_EXPR_SIZE(XT_ALIGN(target->targetsize) +
 					     nft_compat_target_offset(target));
@@ -755,14 +762,6 @@ nft_target_select_ops(const struct nft_c
 	return &nft_target->ops;
 }
 
-static void nft_target_release(void)
-{
-	struct nft_xt *nft_target, *tmp;
-
-	list_for_each_entry_safe(nft_target, tmp, &nft_target_list, head)
-		kfree(nft_target);
-}
-
 static struct nft_expr_type nft_target_type __read_mostly = {
 	.name		= "target",
 	.select_ops	= nft_target_select_ops,
@@ -805,8 +804,6 @@ static void __exit nft_compat_module_exi
 	nfnetlink_subsys_unregister(&nfnl_compat_subsys);
 	nft_unregister_expr(&nft_target_type);
 	nft_unregister_expr(&nft_match_type);
-	nft_match_release();
-	nft_target_release();
 }
 
 MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_NFT_COMPAT);

