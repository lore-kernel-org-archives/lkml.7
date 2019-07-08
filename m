Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C11EC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9C2204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599957;
	bh=D5ayUhAsF0VdP8RdtN5yXJViL+YPdWibDMqRp+evdtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgmANj5ay6IZD6/cNwu0YYp5NdekosJsOBkyESwsaRgO45euXhv8up6Zh8k1bes1D
	 TygMdHAjO6oScRLWNcWjDF2yIfzr4BTFG/JBaRzf0RThuMhnHJAA+h5QLa0iRKt4Jl
	 SujV3jqx+4ucfKnttXzvldB0w0KsuXVjpEW/TF08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbfGHPcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390155AbfGHPcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:32:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFF421537;
        Mon,  8 Jul 2019 15:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599951;
        bh=D5ayUhAsF0VdP8RdtN5yXJViL+YPdWibDMqRp+evdtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBjKuOz0z6/Ke0La32FU4rqvt3pwVQknVbagzl0ueq81YZUiEB8Fwh9nTmxGgo/KA
         c2H/dDPj+gNK1OOSuLubRGg2BnOzuPcTqvnH+hT/2uvF4VQt0sIW7RllMVoaScwNcU
         XCC/ib1CQJEasA0biw0ICQBYa/TSSEWw1fmSTGas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.1 05/96] netfilter: nft_flow_offload: dont offload when sequence numbers need adjustment
Date:   Mon,  8 Jul 2019 17:12:37 +0200
Message-Id: <20190708150526.576908482@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 91a9048f238063dde7feea752b9dd386f7e3808b upstream.

We can't deal with tcp sequence number rewrite in flow_offload.
While at it, simplify helper check, we only need to know if the extension
is present, we don't need the helper data.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_flow_offload.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -12,7 +12,6 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <net/netfilter/nf_flow_table.h>
-#include <net/netfilter/nf_conntrack_helper.h>
 
 struct nft_flow_offload {
 	struct nft_flowtable	*flowtable;
@@ -67,7 +66,6 @@ static void nft_flow_offload_eval(const
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
-	const struct nf_conn_help *help;
 	enum ip_conntrack_info ctinfo;
 	struct nf_flow_route route;
 	struct flow_offload *flow;
@@ -93,8 +91,8 @@ static void nft_flow_offload_eval(const
 		goto out;
 	}
 
-	help = nfct_help(ct);
-	if (help)
+	if (nf_ct_ext_exist(ct, NF_CT_EXT_HELPER) ||
+	    ct->status & IPS_SEQ_ADJUST)
 		goto out;
 
 	if (ctinfo == IP_CT_NEW ||


