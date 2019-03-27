Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB25AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE502075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711979;
	bh=9YRjuhdtB1PxUyqwoabw9ijXRUckDqwaR+G7mVZR54A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zFG6vyog9/k1TbpZ6toL+C0s61yD4Xz3mNVUWre0TtuuzvSkufs0Da9qbMACz9LMx
	 tqghb8VEdApvZ1VL6F7DC8K1lyfbSJMu6avBU4Jp1QVA15zkVAc+mmZ7iI8TkwM+8h
	 Ta/v4MVvAJEWNL6dT0AO2oIltwEBriSqbqqGj+lA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392061AbfC0Sji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391233AbfC0SXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E69620449;
        Wed, 27 Mar 2019 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710983;
        bh=9YRjuhdtB1PxUyqwoabw9ijXRUckDqwaR+G7mVZR54A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIm6ppeJxO9ZtSSGknoD/DiiFfbXpHFDYXkI89J0QiMp5QTB//SzQNrVET4d+a0aU
         V2jqV1GYvkvYp7dJWDL1JZ7eISeHbQ9JCmy2+Hu5E0rBidBc86Nq3yJM+2ej9VG0Ck
         ipMDynQudQNqzrmu0YgM7SCR5k38HvfY6lZv/Cl4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 77/87] netfilter: physdev: relax br_netfilter dependency
Date:   Wed, 27 Mar 2019 14:20:30 -0400
Message-Id: <20190327182040.17444-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 8e2f311a68494a6677c1724bdcb10bada21af37c ]

Following command:
  iptables -D FORWARD -m physdev ...
causes connectivity loss in some setups.

Reason is that iptables userspace will probe kernel for the module revision
of the physdev patch, and physdev has an artificial dependency on
br_netfilter (xt_physdev use makes no sense unless a br_netfilter module
is loaded).

This causes the "phydev" module to be loaded, which in turn enables the
"call-iptables" infrastructure.

bridged packets might then get dropped by the iptables ruleset.

The better fix would be to change the "call-iptables" defaults to 0 and
enforce explicit setting to 1, but that breaks backwards compatibility.

This does the next best thing: add a request_module call to checkentry.
This was a stray '-D ... -m physdev' won't activate br_netfilter
anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/br_netfilter.h | 1 -
 net/bridge/br_netfilter_hooks.c      | 5 -----
 net/netfilter/xt_physdev.c           | 9 +++++++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/netfilter/br_netfilter.h b/include/net/netfilter/br_netfilter.h
index 0b0c35c37125..238d1b83a45a 100644
--- a/include/net/netfilter/br_netfilter.h
+++ b/include/net/netfilter/br_netfilter.h
@@ -48,7 +48,6 @@ static inline struct rtable *bridge_parent_rtable(const struct net_device *dev)
 }
 
 struct net_device *setup_pre_routing(struct sk_buff *skb);
-void br_netfilter_enable(void);
 
 #if IS_ENABLED(CONFIG_IPV6)
 int br_validate_ipv6(struct net *net, struct sk_buff *skb);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 7e42c0d1f55b..38865deab3ac 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -878,11 +878,6 @@ static const struct nf_br_ops br_ops = {
 	.br_dev_xmit_hook =	br_nf_dev_xmit,
 };
 
-void br_netfilter_enable(void)
-{
-}
-EXPORT_SYMBOL_GPL(br_netfilter_enable);
-
 /* For br_nf_post_routing, we need (prio = NF_BR_PRI_LAST), because
  * br_dev_queue_push_xmit is called afterwards */
 static struct nf_hook_ops br_nf_ops[] __read_mostly = {
diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index bb33598e4530..ec247d8370e8 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -96,8 +96,7 @@ physdev_mt(const struct sk_buff *skb, struct xt_action_param *par)
 static int physdev_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_physdev_info *info = par->matchinfo;
-
-	br_netfilter_enable();
+	static bool brnf_probed __read_mostly;
 
 	if (!(info->bitmask & XT_PHYSDEV_OP_MASK) ||
 	    info->bitmask & ~XT_PHYSDEV_OP_MASK)
@@ -113,6 +112,12 @@ static int physdev_mt_check(const struct xt_mtchk_param *par)
 		if (par->hook_mask & (1 << NF_INET_LOCAL_OUT))
 			return -EINVAL;
 	}
+
+	if (!brnf_probed) {
+		brnf_probed = true;
+		request_module("br_netfilter");
+	}
+
 	return 0;
 }
 
-- 
2.19.1

