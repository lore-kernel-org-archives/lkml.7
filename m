Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCE2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71921906
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962477;
	bh=CYetINXkXLURru+HbfaiqOOZSP9crg7LYgPV+HgtEvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMTZo//IIMhhR2uEG/3DGKnxy1up1xFVq6eTIXQFgZDe1johMdK/gRaYx76U8wcGc
	 M93HBUU6Q0phrF9rRi03Cpmx89oBGtV/Q/QDIaLU51o1x1871T4gMKI9hVLb+anVW6
	 eXbYewZPYdnbhkgFUhAYu7DkIBVviLGujLnGrhck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfDVTr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbfDVTry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634EE218B0;
        Mon, 22 Apr 2019 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962473;
        bh=CYetINXkXLURru+HbfaiqOOZSP9crg7LYgPV+HgtEvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkqfPcOaREyEj80D7QV4065JSHvyl5i9UIl0VdMkzOil9OHyI0b7MMz6BT+lrYARa
         E1JAk9avJS4AOtY44GF2XCEDk0SXHCEbmnC4Rlp3wbl+S2YnJVGjtGAdaOZu8/UrsH
         EUJW5ZMwN4vo0ULjuPbxk0AjKO/xoRX2eXmoY38Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Frank Pavlic <f.pavlic@kunbus.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/43] net: ks8851: Dequeue RX packets explicitly
Date:   Mon, 22 Apr 2019 15:46:58 -0400
Message-Id: <20190422194727.12495-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 536d3680fd2dab5c39857d62a3e084198fc74ff9 ]

The ks8851 driver lets the chip auto-dequeue received packets once they
have been read in full. It achieves that by setting the ADRFE flag in
the RXQCR register ("Auto-Dequeue RXQ Frame Enable").

However if allocation of a packet's socket buffer or retrieval of the
packet over the SPI bus fails, the packet will not have been read in
full and is not auto-dequeued. Such partial retrieval of a packet
confuses the chip's RX queue management:  On the next RX interrupt,
the first packet read from the queue will be the one left there
previously and this one can be retrieved without issues. But for any
newly received packets, the frame header status and byte count registers
(RXFHSR and RXFHBCR) contain bogus values, preventing their retrieval.

The chip allows explicitly dequeueing a packet from the RX queue by
setting the RRXEF flag in the RXQCR register ("Release RX Error Frame").
This could be used to dequeue the packet in case of an error, but if
that error is a failed SPI transfer, it is unknown if the packet was
transferred in full and was auto-dequeued or if it was only transferred
in part and requires an explicit dequeue. The safest approach is thus
to always dequeue packets explicitly and forgo auto-dequeueing.

Without this change, I've witnessed packet retrieval break completely
when an SPI DMA transfer fails, requiring a chip reset. Explicit
dequeueing magically fixes this and makes packet retrieval absolutely
robust for me.

The chip's documentation suggests auto-dequeuing and uses the RRXEF
flag only to dequeue error frames which the driver doesn't want to
retrieve. But that seems to be a fair-weather approach.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8851.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index 2fe96f1f3fe5..556666b0d756 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -526,9 +526,8 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 		/* set dma read address */
 		ks8851_wrreg16(ks, KS_RXFDPR, RXFDPR_RXFPAI | 0x00);
 
-		/* start the packet dma process, and set auto-dequeue rx */
-		ks8851_wrreg16(ks, KS_RXQCR,
-			       ks->rc_rxqcr | RXQCR_SDA | RXQCR_ADRFE);
+		/* start DMA access */
+		ks8851_wrreg16(ks, KS_RXQCR, ks->rc_rxqcr | RXQCR_SDA);
 
 		if (rxlen > 4) {
 			unsigned int rxalign;
@@ -559,7 +558,8 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 			}
 		}
 
-		ks8851_wrreg16(ks, KS_RXQCR, ks->rc_rxqcr);
+		/* end DMA access and dequeue packet */
+		ks8851_wrreg16(ks, KS_RXQCR, ks->rc_rxqcr | RXQCR_RRXEF);
 	}
 }
 
-- 
2.19.1

