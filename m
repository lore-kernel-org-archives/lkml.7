Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B764C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C3320449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049736;
	bh=LoAZ2Xfc/uQbIksSyvrHpgx8mmQ5QcuzH+LavBopCzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jT4XeqEOENsnxqtibCopEaG/aAww4LLzcqmYEY0hjWZ47K65UiKSpo4sfYeoSLzoU
	 jN879oVrVEIdPGfxgmEg02cEWISMR1k3RooFGouuxSa+K+02Al/RMQ5GwOE7L5c7qj
	 dfhYLTrrAR3+wiXXc7bQtLjb3zIjaxmn23oA4Ow4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCHMzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfCHMzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE3592087C;
        Fri,  8 Mar 2019 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049730;
        bh=LoAZ2Xfc/uQbIksSyvrHpgx8mmQ5QcuzH+LavBopCzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKp7jFevXz9oCLgrJiD+EfJHB/OF4SNd11BVzb3VfNKFp+jeoDPEZuehPQSv8uALC
         BodiJp5cAgvYK97ZlmO1eqoy93cDirtmjJeo0RKaMmAa3pM5kHBZ/1JqncoUvfow1L
         wuI++2UbR007nu/4ORyzebntJSh2VY+bpH5/I7nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Durrant <paul.durrant@citrix.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 47/76] xen-netback: fix occasional leak of grant ref mappings under memory pressure
Date:   Fri,  8 Mar 2019 13:49:59 +0100
Message-Id: <20190308124916.480311868@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


