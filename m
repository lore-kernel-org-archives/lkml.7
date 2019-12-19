Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9567DC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B0222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782527;
	bh=+IO7bBmFdYv0WZ7BaHdGbFpLUu0k8PARUHVTAujg88k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r46FkCMLNYinIGM57c9ul2/cWP2oy9UmRnr8oTpxTcEcP8CZ8lbkY4x7GTWzGYNki
	 aDZjlSspOxxGuAo+dM0TottBWrGRWSFOFF7TzEQkcJTSu+/+7OnBAKynwN1Mt3y4W4
	 Yyf/jPqT2b+DGFD1Opvy+Yxxn4kA8o76k9VzvG+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLSSlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbfLSSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:41:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE2324672;
        Thu, 19 Dec 2019 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780895;
        bh=+IO7bBmFdYv0WZ7BaHdGbFpLUu0k8PARUHVTAujg88k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hZO8ciieOMAikEK9NiWgP3v+z8kkVHYRoLNieB6+6xPNwA/y7MmP1GFZy1ocMwTX
         2YBu78CVN0icYsD0uyxh1shiB3SSS+Qn9I8Owd0d011XSFKkn/Yaspa7Zljxyz5M9B
         Z5MHAQToudHDwapZTnoYTi6WgpDUvVdrCnpNiD8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S. Miller" <davem@davemloft.net>, Aviraj CJ <acj@cisco.com>
Subject: [PATCH 4.4 162/162] net: stmmac: dont stop NAPI processing when dropping a packet
Date:   Thu, 19 Dec 2019 19:34:30 +0100
Message-Id: <20191219183217.626538726@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

commit 07b3975352374c3f5ebb4a42ef0b253fe370542d upstream.

Currently, if we drop a packet, we exit from NAPI loop before the budget
is consumed. In some situations this will make the RX processing stall
e.g. when flood pinging the system with oversized packets, as the
errorneous packets are not dropped efficiently.

If we drop a packet, we should just continue to the next one as long as
the budget allows.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[acj: backport v4.4 -stable
-adjust context]
Signed-off-by: Aviraj CJ <acj@cisco.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2176,8 +2176,7 @@ static inline void stmmac_rx_refill(stru
 static int stmmac_rx(struct stmmac_priv *priv, int limit)
 {
 	unsigned int rxsize = priv->dma_rx_size;
-	unsigned int entry = priv->cur_rx % rxsize;
-	unsigned int next_entry;
+	unsigned int next_entry = priv->cur_rx % rxsize;
 	unsigned int count = 0;
 	int coe = priv->hw->rx_csum;
 
@@ -2189,9 +2188,11 @@ static int stmmac_rx(struct stmmac_priv
 			stmmac_display_ring((void *)priv->dma_rx, rxsize, 0);
 	}
 	while (count < limit) {
-		int status;
+		int status, entry;
 		struct dma_desc *p;
 
+		entry = next_entry;
+
 		if (priv->extend_desc)
 			p = (struct dma_desc *)(priv->dma_erx + entry);
 		else
@@ -2239,7 +2240,7 @@ static int stmmac_rx(struct stmmac_priv
 			/*  check if frame_len fits the preallocated memory */
 			if (frame_len > priv->dma_buf_sz) {
 				priv->dev->stats.rx_length_errors++;
-				break;
+				continue;
 			}
 
 			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
@@ -2260,7 +2261,7 @@ static int stmmac_rx(struct stmmac_priv
 				pr_err("%s: Inconsistent Rx descriptor chain\n",
 				       priv->dev->name);
 				priv->dev->stats.rx_dropped++;
-				break;
+				continue;
 			}
 			prefetch(skb->data - NET_IP_ALIGN);
 			priv->rx_skbuff[entry] = NULL;
@@ -2291,7 +2292,6 @@ static int stmmac_rx(struct stmmac_priv
 			priv->dev->stats.rx_packets++;
 			priv->dev->stats.rx_bytes += frame_len;
 		}
-		entry = next_entry;
 	}
 
 	stmmac_rx_refill(priv);


