Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50BFC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E31B216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QGInobq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfFZNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:48:30 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:51164 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbfFZNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:47:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBA81C0C4E;
        Wed, 26 Jun 2019 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561556874; bh=JVvFITpjGYpDHG8U/UHiIfY5kTHOaB3xNVv8qbGY97g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=QGInobq+UySksjj2/+Aq0/hqiVLV2yzJOB03d7bfUfbbBkqHhflOc/p51PH4zcwwf
         XoG9l9Mfb8+p5yUymRU0JQWMgGXxIGx+kkZyTM/zv/2x7d/HRiV3xLPj1EQPbIPFpu
         27ZckSweV4vOEtifsYqLUz84UPXyGSIYotsVQermo58Mmge161Jc2hgcze+GWfSiyl
         +GPoPG2HiAax0HuxmDhg2Fmrbf93oHj9M5m4DRepi8mtLa0WVsBpPpDGa5c50/FQIe
         Mm0Nez71OaCciRYdc5Q3bluYMdgsH4rDNeYmReDPnztJTsJrmCVB1WZsApGlPvVzKP
         ixZTTFo/Lsf2g==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id EBD3FA0067;
        Wed, 26 Jun 2019 13:47:51 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id A79223B55A;
        Wed, 26 Jun 2019 15:47:51 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 01/10] net: stmmac: dwxgmac: Enable EDMA by default
Date:   Wed, 26 Jun 2019 15:47:35 +0200
Message-Id: <6df599b8c2d57db9d82e42861ce897d7cf003424.1561556555.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561556555.git.joabreu@synopsys.com>
References: <cover.1561556555.git.joabreu@synopsys.com>
In-Reply-To: <cover.1561556555.git.joabreu@synopsys.com>
References: <cover.1561556555.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the EDMA feature by default which gives higher performance.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index b8296eb41011..50b41ecb0325 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -177,6 +177,8 @@
 #define XGMAC_BLEN8			BIT(2)
 #define XGMAC_BLEN4			BIT(1)
 #define XGMAC_UNDEF			BIT(0)
+#define XGMAC_TX_EDMA_CTRL		0x00003040
+#define XGMAC_RX_EDMA_CTRL		0x00003044
 #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
 #define XGMAC_PBLx8			BIT(16)
 #define XGMAC_DMA_CH_TX_CONTROL(x)	(0x00003104 + (0x80 * (x)))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7861a938420a..a1ad49680c07 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -122,6 +122,8 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	}
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+	writel(GENMASK(29, 0), ioaddr + XGMAC_TX_EDMA_CTRL);
+	writel(GENMASK(29, 0), ioaddr + XGMAC_RX_EDMA_CTRL);
 }
 
 static void dwxgmac2_dma_rx_mode(void __iomem *ioaddr, int mode,
-- 
2.7.4

