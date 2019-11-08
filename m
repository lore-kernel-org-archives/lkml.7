Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A04FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A020673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240098;
	bh=s8a3PHtKvm5UcDZ/xqQFIvDL3A5gyQWQm3dc3/nTjMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GCvqmHUVRPrqQhtVjay3GFveYluHZaRryP5mI8lIMPPuq2siij1puERE70pYk2hU/
	 nIcFAWnlcSfXkyEKPJLK3VE0sj9rEERbAW00wE8SDNZO1PISM9uzCSAJmiAsbHL4Ce
	 mnA946FkChtkE8sxnY/a7ZZ6BcfjNlV6RBxPoHkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391594AbfKHTIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:08:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbfKHTIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:08:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7078020673;
        Fri,  8 Nov 2019 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240092;
        bh=s8a3PHtKvm5UcDZ/xqQFIvDL3A5gyQWQm3dc3/nTjMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6wvqjJeadD22jgU8g69E75jenW0IORfcD2VA0lTCF8ATm+FkAzli+diGHdV1ZmhH
         Gse0VhM2tVFzHzqK7zOYrXEGpBGm6W/kHcozf2MpirXtU6wFNj7PrK3MAT1TREMs0O
         Kn5tGcDrw51IrQd33oQ6jetmyYDa6NeVp/pVx12w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 087/140] net: ethernet: ftgmac100: Fix DMA coherency issue with SW checksum
Date:   Fri,  8 Nov 2019 19:50:15 +0100
Message-Id: <20191108174910.581446743@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ Upstream commit 88824e3bf29a2fcacfd9ebbfe03063649f0f3254 ]

We are calling the checksum helper after the dma_map_single()
call to map the packet. This is incorrect as the checksumming
code will touch the packet from the CPU. This means the cache
won't be properly flushes (or the bounce buffering will leave
us with the unmodified packet to DMA).

This moves the calculation of the checksum & vlan tags to
before the DMA mapping.

This also has the side effect of fixing another bug: If the
checksum helper fails, we goto "drop" to drop the packet, which
will not unmap the DMA mapping.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 05690d633f30 ("ftgmac100: Upgrade to NETIF_F_HW_CSUM")
Reviewed-by: Vijay Khemka <vijaykhemka@fb.com>
Tested-by: Vijay Khemka <vijaykhemka@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/faraday/ftgmac100.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -726,6 +726,18 @@ static netdev_tx_t ftgmac100_hard_start_
 	 */
 	nfrags = skb_shinfo(skb)->nr_frags;
 
+	/* Setup HW checksumming */
+	csum_vlan = 0;
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    !ftgmac100_prep_tx_csum(skb, &csum_vlan))
+		goto drop;
+
+	/* Add VLAN tag */
+	if (skb_vlan_tag_present(skb)) {
+		csum_vlan |= FTGMAC100_TXDES1_INS_VLANTAG;
+		csum_vlan |= skb_vlan_tag_get(skb) & 0xffff;
+	}
+
 	/* Get header len */
 	len = skb_headlen(skb);
 
@@ -752,19 +764,6 @@ static netdev_tx_t ftgmac100_hard_start_
 	if (nfrags == 0)
 		f_ctl_stat |= FTGMAC100_TXDES0_LTS;
 	txdes->txdes3 = cpu_to_le32(map);
-
-	/* Setup HW checksumming */
-	csum_vlan = 0;
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    !ftgmac100_prep_tx_csum(skb, &csum_vlan))
-		goto drop;
-
-	/* Add VLAN tag */
-	if (skb_vlan_tag_present(skb)) {
-		csum_vlan |= FTGMAC100_TXDES1_INS_VLANTAG;
-		csum_vlan |= skb_vlan_tag_get(skb) & 0xffff;
-	}
-
 	txdes->txdes1 = cpu_to_le32(csum_vlan);
 
 	/* Next descriptor */


