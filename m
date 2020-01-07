Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F0C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13F920880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430924;
	bh=LVHlhaH2JHDjFAV5ozkwZF1smnOnCg8syukcjsnWf4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/yTmfcSiTSTxUQUmWkSj1QqeCn0axv9va3m6iooevLuN+s6VHXbslVkAjl6keSDj
	 SSOKIVqLxJWvFINcs9M70RN3gBgTNQV496UTS90MY7iLmrXhPpymWPPAwbp4sxNNRl
	 8ZaslweLQiqZy0Vgzmda1It2wPACsz7X2p21NNIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgAGVCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgAGVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:01:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1828020880;
        Tue,  7 Jan 2020 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430918;
        bh=LVHlhaH2JHDjFAV5ozkwZF1smnOnCg8syukcjsnWf4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuZnSHae5aeDLNhnLNxBYNnJ9YG715zWgbd/9kORr21mA2NGXkN6LZlEuHCh5y2mL
         Q+gvqy2y5wGRmtbP++Pee+B4V7nJvqnr+RWXtSf5xquv5eSu65ZIGJjzaOZjHz5B3a
         mxqJ6UfpOzamWFY9PdaPbLAPLOZXPrMlHLVPeMgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Oliverio <marco.oliverio@tanaza.com>,
        Rocco Folino <rocco.folino@tanaza.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 150/191] netfilter: nf_queue: enqueue skbs with NULL dst
Date:   Tue,  7 Jan 2020 21:54:30 +0100
Message-Id: <20200107205340.996503436@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Oliverio <marco.oliverio@tanaza.com>

commit 0b9173f4688dfa7c5d723426be1d979c24ce3d51 upstream.

Bridge packets that are forwarded have skb->dst == NULL and get
dropped by the check introduced by
b60a77386b1d4868f72f6353d35dabe5fbe981f2 (net: make skb_dst_force
return true when dst is refcounted).

To fix this we check skb_dst() before skb_dst_force(), so we don't
drop skb packet with dst == NULL. This holds also for skb at the
PRE_ROUTING hook so we remove the second check.

Fixes: b60a77386b1d ("net: make skb_dst_force return true when dst is refcounted")
Signed-off-by: Marco Oliverio <marco.oliverio@tanaza.com>
Signed-off-by: Rocco Folino <rocco.folino@tanaza.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -189,7 +189,7 @@ static int __nf_queue(struct sk_buff *sk
 		goto err;
 	}
 
-	if (!skb_dst_force(skb) && state->hook != NF_INET_PRE_ROUTING) {
+	if (skb_dst(skb) && !skb_dst_force(skb)) {
 		status = -ENETDOWN;
 		goto err;
 	}


