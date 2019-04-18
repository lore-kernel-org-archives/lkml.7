Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1710C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7277F20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611603;
	bh=Kozx6rVjCq0BWkqGI3kkDVJAJ546/GGS6RANrUEK358=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNznw+6KJiJVb5R6345oaSYbolKC3kJaqafOxWIQJWl+nXNot8iJ/4f/iU5cU1p+e
	 A07jOy1ib1j/+g8H2+k6YeZ8iax3vy6c2vK2vTzIj+PpbQP32eJG5P2rUP9uLX15Vd
	 L3NhgrxK+dqBbLfilSeGIgRsW3omWLAAGJoFfc2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391878AbfDRSUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391827AbfDRSJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7910B218EA;
        Thu, 18 Apr 2019 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610944;
        bh=Kozx6rVjCq0BWkqGI3kkDVJAJ546/GGS6RANrUEK358=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tmsve2yfYgy+venFNXb95aYMSeFWxWV0r5R+JoHTdr9QVMShNmAe+/XWa8EvvPid
         p1YiNl2C2WSBpwR3OrMEtkcDmDEyhzaNvIZ7InYbrjqiP+rSLzNHEyVxqSCoFB1Mss
         KkPqCHR9F/WahyNf4Hdp90OlyLjb0r3V8pxNbhUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "peppe.cavallaro@st.com, alexandre.torgue@st.com, joabreu@synopsys.com,
        Lars Persson" <larper@axis.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Lars Persson <larper@axis.com>
Subject: [PATCH 4.9 50/50] net: stmmac: Set dma ring length before enabling the DMA
Date:   Thu, 18 Apr 2019 19:58:01 +0200
Message-Id: <20190418160428.349970571@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
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
Cc: stable@vger.kernel.org # 4.9.x
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1747,11 +1747,6 @@ static int stmmac_hw_setup(struct net_de
 	if (ret < 0)
 		pr_warn("%s: failed debugFS registration\n", __func__);
 #endif
-	/* Start the ball rolling... */
-	pr_debug("%s: DMA RX/TX processes started...\n", dev->name);
-	priv->hw->dma->start_tx(priv->ioaddr);
-	priv->hw->dma->start_rx(priv->ioaddr);
-
 	/* Dump DMA/MAC registers */
 	if (netif_msg_hw(priv)) {
 		priv->hw->mac->dump_regs(priv->hw);
@@ -1779,6 +1774,11 @@ static int stmmac_hw_setup(struct net_de
 	if (priv->tso)
 		priv->hw->dma->enable_tso(priv->ioaddr, 1, STMMAC_CHAN0);
 
+	/* Start the ball rolling... */
+	pr_debug("%s: DMA RX/TX processes started...\n", dev->name);
+	priv->hw->dma->start_tx(priv->ioaddr);
+	priv->hw->dma->start_rx(priv->ioaddr);
+
 	return 0;
 }
 


