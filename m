Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E90A20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413180;
	bh=/vaTvR14aracHKWxFI1nwBvHEUr4TWkn1zIqaBp2qOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXcuarjodYLBgWJAY5Uj9gHWJgGL4HrSkWPr3wHHWnDg1hxSvuMUoRAOietIE20NN
	 IzXtjWGxVKU08fgrysQBJcd7MzDyqvdqpn+PvdWcXDNlIEF/mmB/j0Oft/8lS6z+jc
	 J9RtaoMEY+jC4zfPY7jQByGSdSfMIl+VeTSzZBuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfLCWqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbfLCWqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:46:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA02A20656;
        Tue,  3 Dec 2019 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413170;
        bh=/vaTvR14aracHKWxFI1nwBvHEUr4TWkn1zIqaBp2qOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlTLm3wEFf37C6x/tO3OuDXzI+vye9ugJpII41KmkzI0DOS/Y/y0O1c/FaJsfuGxF
         4eH2LjNLlH0XTGV/H6Drbztb/KjXyHSapLao8j+o0RSm7OQJ/7kv38L3pTUe78QDf3
         1Q0UyOTUawILFsn9whpvYlok5SIdmUxqGgQo8U+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/321] bridge: ebtables: dont crash when using dnat target in output chains
Date:   Tue,  3 Dec 2019 23:31:31 +0100
Message-Id: <20191203223428.428836835@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit b23c0742c2ce7e33ed79d10e451f70fdb5ca85d1 ]

xt_in() returns NULL in the output hook, skip the pkt_type change for
that case, redirection only makes sense in broute/prerouting hooks.

Reported-by: Tom Yan <tom.ty89@gmail.com>
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
Fixes: cf3cb246e277d ("bridge: ebtables: fix reception of frames DNAT-ed to bridge device/port")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebt_dnat.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/ebt_dnat.c b/net/bridge/netfilter/ebt_dnat.c
index dfc86a0199dab..1d8c834d90189 100644
--- a/net/bridge/netfilter/ebt_dnat.c
+++ b/net/bridge/netfilter/ebt_dnat.c
@@ -19,7 +19,6 @@ static unsigned int
 ebt_dnat_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ebt_nat_info *info = par->targinfo;
-	struct net_device *dev;
 
 	if (!skb_make_writable(skb, 0))
 		return EBT_DROP;
@@ -32,10 +31,22 @@ ebt_dnat_tg(struct sk_buff *skb, const struct xt_action_param *par)
 		else
 			skb->pkt_type = PACKET_MULTICAST;
 	} else {
-		if (xt_hooknum(par) != NF_BR_BROUTING)
-			dev = br_port_get_rcu(xt_in(par))->br->dev;
-		else
+		const struct net_device *dev;
+
+		switch (xt_hooknum(par)) {
+		case NF_BR_BROUTING:
 			dev = xt_in(par);
+			break;
+		case NF_BR_PRE_ROUTING:
+			dev = br_port_get_rcu(xt_in(par))->br->dev;
+			break;
+		default:
+			dev = NULL;
+			break;
+		}
+
+		if (!dev) /* NF_BR_LOCAL_OUT */
+			return info->target;
 
 		if (ether_addr_equal(info->mac, dev->dev_addr))
 			skb->pkt_type = PACKET_HOST;
-- 
2.20.1



