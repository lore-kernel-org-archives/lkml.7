Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C22B217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411025;
	bh=gVNcN8tg/KN3C9r9vsB4HItNehwF9hlPkjzC4MmQQiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIdQMZNeuPswvr+uE4MKGHtaT/tRBbdqVR2jKm9wWaVO9XF1aw9xP/j/slBCErtS4
	 okW0M0IVYopo8hx+AmO4g3MvqgFfqR5ZZ5aJ2xOFTgKYVX6s4t6aw0UNnJqtUsa6lQ
	 79t4aovlTA7eoBe/Rq8oTeaZCCT3HN40f181KU2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfCLRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbfCLRP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:56 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF4DC2171F;
        Tue, 12 Mar 2019 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410955;
        bh=gVNcN8tg/KN3C9r9vsB4HItNehwF9hlPkjzC4MmQQiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqU9oHbQ9Y2k7gWenph08ixw8jBC9H+9TxM9YI6monyKvX2JmLrsFR40GndMshgQ+
         u0aG7K1OuhoVPWtdl3u9TqcszNurW3wB1JJKKkZ3lkvJYLIaKbNPF64Kkb+9sBgJdo
         //9A+JiRf5Dd1E81NG+3bU0gTEvnw7v3S7Yp8bss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Durrant <paul.durrant@citrix.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 025/135] xen-netback: fix occasional leak of grant ref mappings under memory pressure
Date:   Tue, 12 Mar 2019 10:07:52 -0700
Message-Id: <20190312170343.458765087@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1074,11 +1074,6 @@ static int xenvif_handle_frag_list(struc
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
@@ -1147,6 +1142,8 @@ static int xenvif_tx_submit(struct xenvi
 		xenvif_fill_frags(queue, skb);
 
 		if (unlikely(skb_has_frag_list(skb))) {
+			struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
+			xenvif_skb_zerocopy_prepare(queue, nskb);
 			if (xenvif_handle_frag_list(queue, skb)) {
 				if (net_ratelimit())
 					netdev_err(queue->vif->dev,
@@ -1155,6 +1152,9 @@ static int xenvif_tx_submit(struct xenvi
 				kfree_skb(skb);
 				continue;
 			}
+			/* Copied all the bits from the frag list -- free it. */
+			skb_frag_list_init(skb);
+			kfree_skb(nskb);
 		}
 
 		skb->dev      = queue->vif->dev;


