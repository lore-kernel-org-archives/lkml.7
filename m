Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA0C04AA9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2EE2086A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556965562;
	bh=udYxDx6SkG0QLH+YfKbGRDFSV+aYbjGLyoqFuM+tUMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AD9FDGyN4j29q8nYD8InbHZ9QJ4QOln5FkuPsGWvNz1x8UE0rm7UYD2PVEogmiF/q
	 BeIyD8LjLKkD1Edvh85zQ8y8J/iW4eVluXW7fbcrmQBykPk1Rz3pmpWreHI1+0c4s7
	 uWj+WVpta4/L6wDUNptAPjJsf8JeZhteXWYSyx5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEDK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfEDKZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:25:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360A52086A;
        Sat,  4 May 2019 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965558;
        bh=udYxDx6SkG0QLH+YfKbGRDFSV+aYbjGLyoqFuM+tUMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fplRfNNLInmLat2ssGB8t+GJOo7w6vrqnR+que1JGeAVredLoWUrO65GHljvXEXIQ
         JIonTCsMBPPV33Ncdt3BqLK2m5Uc9ZQdW89ZReC/27lnF0W9YiWHXZ9VZEccEBtXeg
         CKPj0ZPDgLeQcmhzbOFLlxJi8ATSVobese4Kbpq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tong <seantong114@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 18/32] udp: fix GRO reception in case of length mismatch
Date:   Sat,  4 May 2019 12:25:03 +0200
Message-Id: <20190504102453.076769592@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
References: <20190504102452.523724210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 21f1b8a6636c4dbde4aa1ec0343f42eaf653ffcc ]

Currently, the UDP GRO code path does bad things on some edge
conditions - Aggregation can happen even on packet with different
lengths.

Fix the above by rewriting the 'complete' condition for GRO
packets. While at it, note explicitly that we allow merging the
first packet per burst below gso_size.

Reported-by: Sean Tong <seantong114@gmail.com>
Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp_offload.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -377,13 +377,14 @@ static struct sk_buff *udp_gro_receive_s
 
 		/* Terminate the flow on len mismatch or if it grow "too much".
 		 * Under small packet flood GRO count could elsewhere grow a lot
-		 * leading to execessive truesize values
+		 * leading to execessive truesize values.
+		 * On len mismatch merge the first packet shorter than gso_size,
+		 * otherwise complete the GRO packet.
 		 */
-		if (!skb_gro_receive(p, skb) &&
+		if (uh->len > uh2->len || skb_gro_receive(p, skb) ||
+		    uh->len != uh2->len ||
 		    NAPI_GRO_CB(p)->count >= UDP_GRO_CNT_MAX)
 			pp = p;
-		else if (uh->len != uh2->len)
-			pp = p;
 
 		return pp;
 	}


