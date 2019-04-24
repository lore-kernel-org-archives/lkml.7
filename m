Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73601C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421422077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127007;
	bh=+F/BbzuBmR1v7ppB8BUxnaFz6xDiKW54DvSd2xe6KLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5PBcs4GW7z2ewawq3p3DM7IxZdEXcwDh9wHBO9mUzNze2VwK1woT7D5wYV4OIs20
	 QNS26URXQvtiXlV+gRqmCU0hJ64JqUh6Em+DyVdzCRUYceiJ2JINwwu5GroD57cvTv
	 GwMTE5omw5j8h0qbhqXqXoQywija38SQiMfc13Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390921AbfDXRaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390909AbfDXRaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:02 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3072077C;
        Wed, 24 Apr 2019 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127002;
        bh=+F/BbzuBmR1v7ppB8BUxnaFz6xDiKW54DvSd2xe6KLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1owhfYEQ7PR0H3b5A1TXb2Fsy8cTkqwsHBLFTJERwARhY7PiX2AU4ovhkRhbToJOV
         Y2o7ZV65c0wexXI1axFM8Wg1i4cqH3mnNv7KI9Uu12HPVJjsqrhosVOY2gUbClaYuG
         y/XwKAzU7+0lJasBuzewjflu1A8DYoYi2LH9T1YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 4.19 24/96] sch_cake: Simplify logic in cake_select_tin()
Date:   Wed, 24 Apr 2019 19:09:29 +0200
Message-Id: <20190424170921.479638552@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 4976e3c683f328bc6f2edef555a4ffee6524486f ]

The logic in cake_select_tin() was getting a bit hairy, and it turns out we
can simplify it quite a bit. This also allows us to get rid of one of the
two diffserv parsing functions, which has the added benefit that
already-zeroed DSCP fields won't get re-written.

Suggested-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cake.c |   44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1508,20 +1508,6 @@ static unsigned int cake_drop(struct Qdi
 	return idx + (tin << 16);
 }
 
-static void cake_wash_diffserv(struct sk_buff *skb)
-{
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		ipv4_change_dsfield(ip_hdr(skb), INET_ECN_MASK, 0);
-		break;
-	case htons(ETH_P_IPV6):
-		ipv6_change_dsfield(ipv6_hdr(skb), INET_ECN_MASK, 0);
-		break;
-	default:
-		break;
-	}
-}
-
 static u8 cake_handle_diffserv(struct sk_buff *skb, u16 wash)
 {
 	int wlen = skb_network_offset(skb);
@@ -1564,25 +1550,27 @@ static struct cake_tin_data *cake_select
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 tin;
+	u8 dscp;
+
+	/* Tin selection: Default to diffserv-based selection, allow overriding
+	 * using firewall marks or skb->priority.
+	 */
+	dscp = cake_handle_diffserv(skb,
+				    q->rate_flags & CAKE_FLAG_WASH);
+
+	if (q->tin_mode == CAKE_DIFFSERV_BESTEFFORT)
+		tin = 0;
 
-	if (TC_H_MAJ(skb->priority) == sch->handle &&
-	    TC_H_MIN(skb->priority) > 0 &&
-	    TC_H_MIN(skb->priority) <= q->tin_cnt) {
+	else if (TC_H_MAJ(skb->priority) == sch->handle &&
+		 TC_H_MIN(skb->priority) > 0 &&
+		 TC_H_MIN(skb->priority) <= q->tin_cnt)
 		tin = q->tin_order[TC_H_MIN(skb->priority) - 1];
 
-		if (q->rate_flags & CAKE_FLAG_WASH)
-			cake_wash_diffserv(skb);
-	} else if (q->tin_mode != CAKE_DIFFSERV_BESTEFFORT) {
-		/* extract the Diffserv Precedence field, if it exists */
-		/* and clear DSCP bits if washing */
-		tin = q->tin_index[cake_handle_diffserv(skb,
-				q->rate_flags & CAKE_FLAG_WASH)];
+	else {
+		tin = q->tin_index[dscp];
+
 		if (unlikely(tin >= q->tin_cnt))
 			tin = 0;
-	} else {
-		tin = 0;
-		if (q->rate_flags & CAKE_FLAG_WASH)
-			cake_wash_diffserv(skb);
 	}
 
 	return &q->tins[tin];


