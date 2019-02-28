Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58522214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfB1CDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:03:12 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:57987 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1CDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:03:12 -0500
X-IronPort-AV: E=Sophos;i="5.58,421,1544486400"; 
   d="scan'208";a="79285347"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <davem@davemloft.net>, Igor Druzhinin <igor.druzhinin@citrix.com>
Subject: [PATCH] xen-netback: fix occasional leak of grant ref mappings under memory pressure
Date:   Thu, 28 Feb 2019 02:03:02 +0000
Message-ID: <1551319382-32595-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-copy callback flag is not yet set on frag list skb at the moment
xenvif_handle_frag_list() returns -ENOMEM. This eventually results in
leaking grant ref mappings since xenvif_zerocopy_callback() is never
called for these fragments. Those eventually build up and cause Xen
to kill Dom0 as the slots get reused for new mappings.

That behavior is observed under certain workloads where sudden spikes
of page cache usage for writes coexist with active atomic skb allocations.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 drivers/net/xen-netback/netback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 80aae3a..2023317 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1146,9 +1146,12 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
 
 		if (unlikely(skb_has_frag_list(skb))) {
 			if (xenvif_handle_frag_list(queue, skb)) {
+				struct sk_buff *nskb =
+						skb_shinfo(skb)->frag_list;
 				if (net_ratelimit())
 					netdev_err(queue->vif->dev,
 						   "Not enough memory to consolidate frag_list!\n");
+				xenvif_skb_zerocopy_prepare(queue, nskb);
 				xenvif_skb_zerocopy_prepare(queue, skb);
 				kfree_skb(skb);
 				continue;
-- 
2.7.4

