Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B85C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B782081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198859;
	bh=1CK8qFan8z6Zr74OcFy9ab2mZbacRXWWsv2U6G7wCD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ruO13zLAEPuEx4DUUFV05cso1lvByNSwXoAzjLlBEzYiebI0pe0Zez112nBskFJNp
	 EDfU+8C5GRQng4uWv66r5jvXZa4dnbm8gBHoWA+K0CILQHkZUfTQE7/KQ9kQEeISC1
	 swZNzUPUs3JFCvSHlSiM9upxXJBe6NpnwuE6dR/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfGONyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732183AbfGONyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:54:16 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A226A2086C;
        Mon, 15 Jul 2019 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198855;
        bh=1CK8qFan8z6Zr74OcFy9ab2mZbacRXWWsv2U6G7wCD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxb8Hm7BLGlEid2Xs8C1cgxmOOTbfQf2fPw9LDG/DJ4otO+diHXgoc0jEv6o1hedi
         hMARg/QDeVWKKR4S7wjhS2od8nDNqhf9b5V4Q5Zb5gF683yj6VSbZq6jFzgKRklkXi
         NF3DeMYx16wiDIgWCN/rxpSsvixr2PlsAjSktaso=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mitch Williams <mitch.a.williams@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 120/249] iavf: allow null RX descriptors
Date:   Mon, 15 Jul 2019 09:44:45 -0400
Message-Id: <20190715134655.4076-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Williams <mitch.a.williams@intel.com>

[ Upstream commit efa14c3985828da3163f5372137cb64d992b0f79 ]

In some circumstances, the hardware can hand us a null receive
descriptor, with no data attached but otherwise valid. Unfortunately,
the driver was ill-equipped to handle such an event, and would stop
processing packets at that point.

To fix this, use the Descriptor Done bit instead of the size to
determine whether or not a descriptor is ready to be processed. Add some
checks to allow for unused buffers.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 06d1509d57f7..c97b9ecf026a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1236,6 +1236,9 @@ static void iavf_add_rx_frag(struct iavf_ring *rx_ring,
 	unsigned int truesize = SKB_DATA_ALIGN(size + iavf_rx_offset(rx_ring));
 #endif
 
+	if (!size)
+		return;
+
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->page_offset, size, truesize);
 
@@ -1260,6 +1263,9 @@ static struct iavf_rx_buffer *iavf_get_rx_buffer(struct iavf_ring *rx_ring,
 {
 	struct iavf_rx_buffer *rx_buffer;
 
+	if (!size)
+		return NULL;
+
 	rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
 	prefetchw(rx_buffer->page);
 
@@ -1299,6 +1305,8 @@ static struct sk_buff *iavf_construct_skb(struct iavf_ring *rx_ring,
 	unsigned int headlen;
 	struct sk_buff *skb;
 
+	if (!rx_buffer)
+		return NULL;
 	/* prefetch first cache line of first page */
 	prefetch(va);
 #if L1_CACHE_BYTES < 128
@@ -1363,6 +1371,8 @@ static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
 #endif
 	struct sk_buff *skb;
 
+	if (!rx_buffer)
+		return NULL;
 	/* prefetch first cache line of first page */
 	prefetch(va);
 #if L1_CACHE_BYTES < 128
@@ -1398,6 +1408,9 @@ static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
 static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
 			       struct iavf_rx_buffer *rx_buffer)
 {
+	if (!rx_buffer)
+		return;
+
 	if (iavf_can_reuse_rx_page(rx_buffer)) {
 		/* hand second half of page back to the ring */
 		iavf_reuse_rx_page(rx_ring, rx_buffer);
@@ -1496,11 +1509,12 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 * verified the descriptor has been written back.
 		 */
 		dma_rmb();
+#define IAVF_RXD_DD BIT(IAVF_RX_DESC_STATUS_DD_SHIFT)
+		if (!iavf_test_staterr(rx_desc, IAVF_RXD_DD))
+			break;
 
 		size = (qword & IAVF_RXD_QW1_LENGTH_PBUF_MASK) >>
 		       IAVF_RXD_QW1_LENGTH_PBUF_SHIFT;
-		if (!size)
-			break;
 
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 		rx_buffer = iavf_get_rx_buffer(rx_ring, size);
@@ -1516,7 +1530,8 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_buff_failed++;
-			rx_buffer->pagecnt_bias++;
+			if (rx_buffer)
+				rx_buffer->pagecnt_bias++;
 			break;
 		}
 
-- 
2.20.1

