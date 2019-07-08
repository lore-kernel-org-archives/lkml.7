Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED7FC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25E21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600418;
	bh=H0IXspXxI/zpi03RBWqNoqskzumzNpuQhM1IWR1zcxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/u2M+xB2h6JH8zq/xrGnhqSl9srCtdHARq676VuqYCIydCq1cZYot2+07xvLKunF
	 T8OaElVsgR2LD9ZAhfmImYFvHsEL9elo+OfOVSnOXnRHfsGlz0PZy6fR7CI75u166u
	 ehfRtIBzNTShL7JZP3QGKvKVyA4vTXyvEpCJzUZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390845AbfGHPkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731881AbfGHP2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:28:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1A520645;
        Mon,  8 Jul 2019 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599685;
        bh=H0IXspXxI/zpi03RBWqNoqskzumzNpuQhM1IWR1zcxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nivxegxz233IrVNIReUtPO1iP7nXVKeV06Qh/pL6tgru4OHfnnmhO6+nl1ALfHwjA
         /33Lke+/2t9Qi3xUbJ0jYbftcP5AyCWszse2YNtkD4usDvcrNnHRZcjhvRqEXKTbQV
         5vSG+SzQDrLQjB3oW9bcgMVX9aoTiTlTJnGUmGak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 07/90] netfilter: nft_flow_offload: IPCB is only valid for ipv4 family
Date:   Mon,  8 Jul 2019 17:12:34 +0200
Message-Id: <20190708150522.821819621@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 69aeb538587e087bfc81dd1f465eab3558ff3158 upstream.

Guard this with a check vs. ipv4, IPCB isn't valid in ipv6 case.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_flow_offload.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -48,15 +48,20 @@ static int nft_flow_route(const struct n
 	return 0;
 }
 
-static bool nft_flow_offload_skip(struct sk_buff *skb)
+static bool nft_flow_offload_skip(struct sk_buff *skb, int family)
 {
-	struct ip_options *opt  = &(IPCB(skb)->opt);
-
-	if (unlikely(opt->optlen))
-		return true;
 	if (skb_sec_path(skb))
 		return true;
 
+	if (family == NFPROTO_IPV4) {
+		const struct ip_options *opt;
+
+		opt = &(IPCB(skb)->opt);
+
+		if (unlikely(opt->optlen))
+			return true;
+	}
+
 	return false;
 }
 
@@ -74,7 +79,7 @@ static void nft_flow_offload_eval(const
 	struct nf_conn *ct;
 	int ret;
 
-	if (nft_flow_offload_skip(pkt->skb))
+	if (nft_flow_offload_skip(pkt->skb, nft_pf(pkt)))
 		goto out;
 
 	ct = nf_ct_get(pkt->skb, &ctinfo);


