Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02553C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2D20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611771;
	bh=55436PmpXulMWysgzlhXbljNOD0VRzgU4WIiEyTMves=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b8jsQf4QpRBK2vOTMFue9eFCSmOmLU6CsTZNjiVxHTZgSDHyNCqolD/2TdaU+Q2Ms
	 t25AuEwTELR5/kCgXD7eV1Ey3P5hSTb7DOQOyC05MSzmY1ND4PZAZBYezct2Yf8UzP
	 mvfjipBIHBqR4jMzFwf0P+i4aajInoW65NyWmqj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbfDRSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391529AbfDRSGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4DB206B6;
        Thu, 18 Apr 2019 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610808;
        bh=55436PmpXulMWysgzlhXbljNOD0VRzgU4WIiEyTMves=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBGZCEZE9a7UPiNMBCtCaTg1VqX625sHToroO9WzZg7v9p4IwCIPlMsi34jnADbR9
         7PR2xHWayAG2Nk3aVa54yeV++W1Mtflxo2zW4xRGl1XrXbEv8k/ZMHyRDhERGTrHHY
         4nBLDJgomAZZ4JpS1CBnIcwC9UZKBpP366Q1PWN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "peppe.cavallaro@st.com, alexandre.torgue@st.com, joabreu@synopsys.com,
        Lars Persson" <larper@axis.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Lars Persson <larper@axis.com>
Subject: [PATCH 4.14 91/92] net: stmmac: Set dma ring length before enabling the DMA
Date:   Thu, 18 Apr 2019 19:57:49 +0200
Message-Id: <20190418160438.418093402@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Persson <lars.persson@axis.com>

This was fixed in upstream by commit 7d9e6c5afab6 ("net: stmmac: Integrate
XGMAC into main driver flow") that is a new feature commit.

We found a race condition in the DMA init sequence that hits if the
PHY already has link up during stmmac_hw_setup. Since the ring length
was programmed after enabling the RX path, we might receive a packet
before the correct ring length is programmed. When that happened we
could not get reliable interrupts for DMA RX and the MTL complained
about RX FIFO overrun.

Signed-off-by: Lars Persson <larper@axis.com>
Cc: stable@vger.kernel.org # 4.14.x
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2536,9 +2536,6 @@ static int stmmac_hw_setup(struct net_de
 		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
 			    __func__);
 #endif
-	/* Start the ball rolling... */
-	stmmac_start_all_dma(priv);
-
 	priv->tx_lpi_timer = STMMAC_DEFAULT_TWT_LS;
 
 	if ((priv->use_riwt) && (priv->hw->dma->rx_watchdog)) {
@@ -2558,6 +2555,9 @@ static int stmmac_hw_setup(struct net_de
 			priv->hw->dma->enable_tso(priv->ioaddr, 1, chan);
 	}
 
+	/* Start the ball rolling... */
+	stmmac_start_all_dma(priv);
+
 	return 0;
 }
 


