Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BF8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413922;
	bh=SVmJFjC2VeraPGqAJHZpCcOs2fhRTm/d8UN3HDmlTjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBvHlDVAdMeLaLqZkeAl3COxanIwMS6aFn94U8ifnFbyHw/BlEnjMm0hacYEPRiIx
	 iKqJ1/yiK6J5REdYVbuHrDkmnabMC4DRQoa3k0cq+K7GcXd4jmv14BoEHM3cWqkXr7
	 Zqj9omfldkXGWyRakBHheLK7nfcIF9Ip+DfEemq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfCLRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbfCLRMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:21 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4677E217F4;
        Tue, 12 Mar 2019 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410740;
        bh=SVmJFjC2VeraPGqAJHZpCcOs2fhRTm/d8UN3HDmlTjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qK369J+DGCmfy7lN33FJfsP2dVPZRUVQ0LzoW+otBAS+Cbz01MK4GcSYfMbzPSj0l
         5WAe+sdPDd9A2Z8VV7cFm7Mpp0xStVgVvt03q9QmIukwYcBrFy5wY7osW7d3bDhFPI
         DE/sUEXI7WUZS+cqNkNWu65CHU0CDkHO2zjYSMzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 044/171] qed: Fix system crash in ll2 xmit
Date:   Tue, 12 Mar 2019 10:07:04 -0700
Message-Id: <20190312170351.924954259@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

[ Upstream commit 7c81626a3c37e4ac320b8ad785694ba498f24794 ]

Cache number of fragments in the skb locally as in case
of linear skb (with zero fragments), tx completion
(or freeing of skb) may happen before driver tries
to get number of frgaments from the skb which could
lead to stale access to an already freed skb.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 9e728ec82c21..25f67c0d5c57 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2441,19 +2441,24 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 {
 	struct qed_ll2_tx_pkt_info pkt;
 	const skb_frag_t *frag;
+	u8 flags = 0, nr_frags;
 	int rc = -EINVAL, i;
 	dma_addr_t mapping;
 	u16 vlan = 0;
-	u8 flags = 0;
 
 	if (unlikely(skb->ip_summed != CHECKSUM_NONE)) {
 		DP_INFO(cdev, "Cannot transmit a checksummed packet\n");
 		return -EINVAL;
 	}
 
-	if (1 + skb_shinfo(skb)->nr_frags > CORE_LL2_TX_MAX_BDS_PER_PACKET) {
+	/* Cache number of fragments from SKB since SKB may be freed by
+	 * the completion routine after calling qed_ll2_prepare_tx_packet()
+	 */
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
+	if (1 + nr_frags > CORE_LL2_TX_MAX_BDS_PER_PACKET) {
 		DP_ERR(cdev, "Cannot transmit a packet with %d fragments\n",
-		       1 + skb_shinfo(skb)->nr_frags);
+		       1 + nr_frags);
 		return -EINVAL;
 	}
 
@@ -2475,7 +2480,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 	}
 
 	memset(&pkt, 0, sizeof(pkt));
-	pkt.num_of_bds = 1 + skb_shinfo(skb)->nr_frags;
+	pkt.num_of_bds = 1 + nr_frags;
 	pkt.vlan = vlan;
 	pkt.bd_flags = flags;
 	pkt.tx_dest = QED_LL2_TX_DEST_NW;
@@ -2486,12 +2491,17 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 	    test_bit(QED_LL2_XMIT_FLAGS_FIP_DISCOVERY, &xmit_flags))
 		pkt.remove_stag = true;
 
+	/* qed_ll2_prepare_tx_packet() may actually send the packet if
+	 * there are no fragments in the skb and subsequently the completion
+	 * routine may run and free the SKB, so no dereferencing the SKB
+	 * beyond this point unless skb has any fragments.
+	 */
 	rc = qed_ll2_prepare_tx_packet(&cdev->hwfns[0], cdev->ll2->handle,
 				       &pkt, 1);
 	if (rc)
 		goto err;
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+	for (i = 0; i < nr_frags; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
 
 		mapping = skb_frag_dma_map(&cdev->pdev->dev, frag, 0,
-- 
2.19.1



