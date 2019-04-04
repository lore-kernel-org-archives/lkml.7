Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5E421872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368825;
	bh=HMNc2xFExbwXHSPs8UBqqANyYgeyBhw7Xr+1WDzumPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PVySgEVPJLw0YeBBPOxeumJC9s+C1B0yIpP/pKj4RvaFxHQWih6Yk4MH8EyeNc6uE
	 lFnLg9EclbkdplsQx3aLhK1NvU0Dz50wWYAc05WbE827lVNylFSilrAZ9dWl6C/C1F
	 EfEaeJ6SFnNOV+NuAKMdcR6ByFiCjs5O+PpLAmsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfDDJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732196AbfDDJHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565982177E;
        Thu,  4 Apr 2019 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368820;
        bh=HMNc2xFExbwXHSPs8UBqqANyYgeyBhw7Xr+1WDzumPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeioSg/L6kjDYdoByWStvL9OIyTGm/LZe/Xox7qYiL5RgVBmmcyTlpIMXLpgG7PMc
         h57lG2wZzIjsbxu52shHHHTAJt0+Ju88uomMh14DCE16m7lR6JXPNDBp8iwxPVkvng
         RXkzapHXE7lFhQ95MpRA+cum7AL+8mMKT6Ouj6rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 166/187] netfilter: physdev: relax br_netfilter dependency
Date:   Thu,  4 Apr 2019 10:48:23 +0200
Message-Id: <20190404084610.908904623@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 74af19c3a8f7..a4ba601b5d04 100644
--- a/include/net/netfilter/br_netfilter.h
+++ b/include/net/netfilter/br_netfilter.h
@@ -49,7 +49,6 @@ static inline struct rtable *bridge_parent_rtable(const struct net_device *dev)
 }
 
 struct net_device *setup_pre_routing(struct sk_buff *skb);
-void br_netfilter_enable(void);
 
 #if IS_ENABLED(CONFIG_IPV6)
 int br_validate_ipv6(struct net *net, struct sk_buff *skb);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index e07a7e62c705..3b0a03b92080 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -884,11 +884,6 @@ static const struct nf_br_ops br_ops = {
 	.br_dev_xmit_hook =	br_nf_dev_xmit,
 };
 
-void br_netfilter_enable(void)
-{
-}
-EXPORT_SYMBOL_GPL(br_netfilter_enable);
-
 /* For br_nf_post_routing, we need (prio = NF_BR_PRI_LAST), because
  * br_dev_queue_push_xmit is called afterwards */
 static const struct nf_hook_ops br_nf_ops[] = {
diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index 9d6d67b953ac..05f00fb20b04 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -96,8 +96,7 @@ match_outdev:
 static int physdev_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_physdev_info *info = par->matchinfo;
-
-	br_netfilter_enable();
+	static bool brnf_probed __read_mostly;
 
 	if (!(info->bitmask & XT_PHYSDEV_OP_MASK) ||
 	    info->bitmask & ~XT_PHYSDEV_OP_MASK)
@@ -111,6 +110,12 @@ static int physdev_mt_check(const struct xt_mtchk_param *par)
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



