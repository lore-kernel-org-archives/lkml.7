Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10063C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6F0233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495560;
	bh=Gj847P+qXm8y51Qcuet4CDKDoDTyJYgVLrmfPsIq1Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/Sb8+LmI1Lh0w0tf5xswJ3Bhj6vHnGY3hMEDFf/CYTJ55YN8dr0ppEHKdLlctRuv
	 DAoPZBQxtCSQ+1wGCCo3r8t4AsdeVif4br/+/WseznsqOfcV66aGV9HNljayfVFUfM
	 RTsT7imdu/bhKW3+LnI68967aFWzHcaXUsyxu6qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405014AbfHVRjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404150AbfHVRYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:17 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387532341A;
        Thu, 22 Aug 2019 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494657;
        bh=Gj847P+qXm8y51Qcuet4CDKDoDTyJYgVLrmfPsIq1Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSglY2Tzrp/Itco/wHdefO07WBBCRoGr2fML8MPxJkyAxtZl0NbnPjrdIhVWuQFqU
         zDFLe0CvQBYi9n4YXeWoYq7wp2SKIbdAaMsUD3yLORPTWXlmK9NJWJG3cZDv4QAYDM
         M1htoYRGygbvNdJbJxgXeqJHWvND0s1fI1zAfsZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 099/103] xen/netback: Reset nr_frags before freeing skb
Date:   Thu, 22 Aug 2019 10:19:27 -0700
Message-Id: <20190822171733.150515695@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 3a0233ddec554b886298de2428edb5c50a20e694 ]

At this point nr_frags has been incremented but the frag does not yet
have a page assigned so freeing the skb results in a crash. Reset
nr_frags before freeing the skb to prevent this.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netback/netback.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -927,6 +927,7 @@ static void xenvif_tx_build_gops(struct
 			skb_shinfo(skb)->nr_frags = MAX_SKB_FRAGS;
 			nskb = xenvif_alloc_skb(0);
 			if (unlikely(nskb == NULL)) {
+				skb_shinfo(skb)->nr_frags = 0;
 				kfree_skb(skb);
 				xenvif_tx_err(queue, &txreq, extra_count, idx);
 				if (net_ratelimit())
@@ -942,6 +943,7 @@ static void xenvif_tx_build_gops(struct
 
 			if (xenvif_set_skb_gso(queue->vif, skb, gso)) {
 				/* Failure in xenvif_set_skb_gso is fatal. */
+				skb_shinfo(skb)->nr_frags = 0;
 				kfree_skb(skb);
 				kfree_skb(nskb);
 				break;


