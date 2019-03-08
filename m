Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B539C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6632133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050055;
	bh=Khce1pU30hEsZ2REZ9D2V4qsQ0V9OVppO/gDTVneOMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7iHEao9np309H+Maq8YsLRw2I5t97KY/DuUTXkZWDMI/gmLYFcCSk2ShHciWwMEV
	 GSara5sSyA+TFXwCkf3x2CmVe5k2AI5Kqh3OypH6eexsrWi8fo9GVdeUEyGfJD2iN3
	 BP3wYu6hYlGXsxHsc7OcOHjkNe+r1kiToNEe2IbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfCHNAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfCHNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C6D20811;
        Fri,  8 Mar 2019 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050048;
        bh=Khce1pU30hEsZ2REZ9D2V4qsQ0V9OVppO/gDTVneOMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kw5qWeF6Q2Go1Xa6ouCRQo6dCV6fZL/nrIpon43SSzVs9YxMqtSyI885+R3cN/Sfp
         2Ruca1W4c+y8Vhrnw5EbuC1X7sdcA7wHmU2zGWCVTRKciKI0REGIYU6NCMpPHehYYy
         c/VGa5zIIpOGb5U5uIi51okxULj8FJ+8Us6gF3mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Durrant <paul.durrant@citrix.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 40/68] xen-netback: fix occasional leak of grant ref mappings under memory pressure
Date:   Fri,  8 Mar 2019 13:50:10 +0100
Message-Id: <20190308124912.688213501@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Igor Druzhinin <igor.druzhinin@citrix.com>

[ Upstream commit 99e87f56b48f490fb16b6e0f74691c1e664dea95 ]

Zero-copy callback flag is not yet set on frag list skb at the moment
xenvif_handle_frag_list() returns -ENOMEM. This eventually results in
leaking grant ref mappings since xenvif_zerocopy_callback() is never
called for these fragments. Those eventually build up and cause Xen
to kill Dom0 as the slots get reused for new mappings:

"d0v0 Attempt to implicitly unmap a granted PTE c010000329fce005"

That behavior is observed under certain workloads where sudden spikes
of page cache writes coexist with active atomic skb allocations from
network traffic. Additionally, rework the logic to deal with frag_list
deallocation in a single place.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Acked-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netback/netback.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1072,11 +1072,6 @@ static int xenvif_handle_frag_list(struc
 		skb_frag_size_set(&frags[i], len);
 	}
 
-	/* Copied all the bits from the frag list -- free it. */
-	skb_frag_list_init(skb);
-	xenvif_skb_zerocopy_prepare(queue, nskb);
-	kfree_skb(nskb);
-
 	/* Release all the original (foreign) frags. */
 	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
 		skb_frag_unref(skb, f);
@@ -1145,6 +1140,8 @@ static int xenvif_tx_submit(struct xenvi
 		xenvif_fill_frags(queue, skb);
 
 		if (unlikely(skb_has_frag_list(skb))) {
+			struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
+			xenvif_skb_zerocopy_prepare(queue, nskb);
 			if (xenvif_handle_frag_list(queue, skb)) {
 				if (net_ratelimit())
 					netdev_err(queue->vif->dev,
@@ -1153,6 +1150,9 @@ static int xenvif_tx_submit(struct xenvi
 				kfree_skb(skb);
 				continue;
 			}
+			/* Copied all the bits from the frag list -- free it. */
+			skb_frag_list_init(skb);
+			kfree_skb(nskb);
 		}
 
 		skb->dev      = queue->vif->dev;


