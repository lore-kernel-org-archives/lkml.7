Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44328C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109B22075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902144;
	bh=5fYn1dsJRCI8f1R8ZZ9ksM5ksv+0xOCJLYy8ZlOwqdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ikZoXwpIxKs07uqSSCUhL3utrZiYr6VWlkW6hJ05bvvfkCcnbhxiAix1E1ubERACG
	 oMXd1f9SNP3Txo0VSPClw2aDHH7noHZLV7e6xxg6++H98UqYU01ctTuLG+RUwqi4QI
	 EsJupQKfG/wpWwOFchth4+UBPw+/hl5a+1U+IoJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfCRJdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbfCRJdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:06 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A24A2083D;
        Mon, 18 Mar 2019 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901584;
        bh=5fYn1dsJRCI8f1R8ZZ9ksM5ksv+0xOCJLYy8ZlOwqdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrfCNLnoA+WBa2MZDvWtBq+wSdVDSFKqGJG4J9P6p0GQZNCsiD2Z0vqw9ATUjM2V1
         btwDojQhKdJoeyOfcAklOROu1yESxiLOOVtSSwhhtRF7srha5J/6aMb2YQ4EE/ztQn
         llb6Q1rn1IEwRIYM6dYxGZp9p2WQrQryomSeEcoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 05/52] lan743x: Fix RX Kernel Panic
Date:   Mon, 18 Mar 2019 10:25:02 +0100
Message-Id: <20190318084014.181465141@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit dd9d9f5907bb475f8b1796c47d4ecc7fb9b72136 ]

It has been noticed that running the speed test at
www.speedtest.net occasionally causes a kernel panic.

Investigation revealed that under this test RX buffer allocation
sometimes fails and returns NULL. But the lan743x driver did
not handle this case.

This patch fixes this issue by attempting to allocate a buffer
before sending the new rx packet to the OS. If the allocation
fails then the new rx packet is dropped and the existing buffer
is reused in the DMA ring.

Updates for v2:
    Additional 2 locations where allocation was not checked,
        has been changed to reuse existing buffer.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |   46 ++++++++++++++++++--------
 1 file changed, 32 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1905,7 +1905,17 @@ static int lan743x_rx_next_index(struct
 	return ((++index) % rx->ring_size);
 }
 
-static int lan743x_rx_allocate_ring_element(struct lan743x_rx *rx, int index)
+static struct sk_buff *lan743x_rx_allocate_skb(struct lan743x_rx *rx)
+{
+	int length = 0;
+
+	length = (LAN743X_MAX_FRAME_SIZE + ETH_HLEN + 4 + RX_HEAD_PADDING);
+	return __netdev_alloc_skb(rx->adapter->netdev,
+				  length, GFP_ATOMIC | GFP_DMA);
+}
+
+static int lan743x_rx_init_ring_element(struct lan743x_rx *rx, int index,
+					struct sk_buff *skb)
 {
 	struct lan743x_rx_buffer_info *buffer_info;
 	struct lan743x_rx_descriptor *descriptor;
@@ -1914,9 +1924,7 @@ static int lan743x_rx_allocate_ring_elem
 	length = (LAN743X_MAX_FRAME_SIZE + ETH_HLEN + 4 + RX_HEAD_PADDING);
 	descriptor = &rx->ring_cpu_ptr[index];
 	buffer_info = &rx->buffer_info[index];
-	buffer_info->skb = __netdev_alloc_skb(rx->adapter->netdev,
-					      length,
-					      GFP_ATOMIC | GFP_DMA);
+	buffer_info->skb = skb;
 	if (!(buffer_info->skb))
 		return -ENOMEM;
 	buffer_info->dma_ptr = dma_map_single(&rx->adapter->pdev->dev,
@@ -2063,8 +2071,19 @@ static int lan743x_rx_process_packet(str
 		/* packet is available */
 		if (first_index == last_index) {
 			/* single buffer packet */
+			struct sk_buff *new_skb = NULL;
 			int packet_length;
 
+			new_skb = lan743x_rx_allocate_skb(rx);
+			if (!new_skb) {
+				/* failed to allocate next skb.
+				 * Memory is very low.
+				 * Drop this packet and reuse buffer.
+				 */
+				lan743x_rx_reuse_ring_element(rx, first_index);
+				goto process_extension;
+			}
+
 			buffer_info = &rx->buffer_info[first_index];
 			skb = buffer_info->skb;
 			descriptor = &rx->ring_cpu_ptr[first_index];
@@ -2084,7 +2103,7 @@ static int lan743x_rx_process_packet(str
 			skb_put(skb, packet_length - 4);
 			skb->protocol = eth_type_trans(skb,
 						       rx->adapter->netdev);
-			lan743x_rx_allocate_ring_element(rx, first_index);
+			lan743x_rx_init_ring_element(rx, first_index, new_skb);
 		} else {
 			int index = first_index;
 
@@ -2097,26 +2116,23 @@ static int lan743x_rx_process_packet(str
 			if (first_index <= last_index) {
 				while ((index >= first_index) &&
 				       (index <= last_index)) {
-					lan743x_rx_release_ring_element(rx,
-									index);
-					lan743x_rx_allocate_ring_element(rx,
-									 index);
+					lan743x_rx_reuse_ring_element(rx,
+								      index);
 					index = lan743x_rx_next_index(rx,
 								      index);
 				}
 			} else {
 				while ((index >= first_index) ||
 				       (index <= last_index)) {
-					lan743x_rx_release_ring_element(rx,
-									index);
-					lan743x_rx_allocate_ring_element(rx,
-									 index);
+					lan743x_rx_reuse_ring_element(rx,
+								      index);
 					index = lan743x_rx_next_index(rx,
 								      index);
 				}
 			}
 		}
 
+process_extension:
 		if (extension_index >= 0) {
 			descriptor = &rx->ring_cpu_ptr[extension_index];
 			buffer_info = &rx->buffer_info[extension_index];
@@ -2293,7 +2309,9 @@ static int lan743x_rx_ring_init(struct l
 
 	rx->last_head = 0;
 	for (index = 0; index < rx->ring_size; index++) {
-		ret = lan743x_rx_allocate_ring_element(rx, index);
+		struct sk_buff *new_skb = lan743x_rx_allocate_skb(rx);
+
+		ret = lan743x_rx_init_ring_element(rx, index, new_skb);
 		if (ret)
 			goto cleanup;
 	}


