Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808FE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W3aA2C88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfDQHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:43:51 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:46338 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727447AbfDQHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:43:50 -0400
Received: from mailhost1.synopsys.com (us02-dmz-cl-eth-s1p4c0.internal.synopsys.com [10.12.241.126])
        by smtprelay-out1.synopsys.com (Postfix) with ESMTP id 907F8C0B14;
        Wed, 17 Apr 2019 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555486394; bh=fg7z+hdIYKWaMyHO2cSI1s6q90ANqnyzXocHfWI4dKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=W3aA2C88qhWd6xAHpCUa8o3MnjR2F9VT/knoDG1+IQNu5wkuzs2Cco5YmauphtkNT
         ZCC2/+mX0GqLY1tBzHPKpC8xLZRNRF1kOxCjn7bK1hENTXYYFZymKmUP8ehXq2Nixo
         uip2u/MD2cT17vo+2pzbdbDUPJTVvUI/1cGZl2rNO61YQWE+vuKiqgbd9mFLjUmL6k
         bPiwIm5mijcllx7y/0+J4GzNUc8UpIx8Cj/8739fwech/Z5kyLyXzjcFv2ekNjJoaT
         TQ9MgFoUoNObNtWfAbd6NdjjEWhB/0Fn9j3XqOpvkt3fNpa2+rDgF/RziOfsXxBhXi
         9NeTRMj7Xx5PQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 44495501C;
        Wed, 17 Apr 2019 00:33:13 -0700 (PDT)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 1/2] net: stmmac: dwxgmac: Finish the Flow Control implementation
Date:   Wed, 17 Apr 2019 09:33:04 +0200
Message-Id: <6025da4fc4390316adf2abb32f4afcea2b4aef35.1555486210.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555486210.git.joabreu@synopsys.com>
References: <cover.1555486210.git.joabreu@synopsys.com>
In-Reply-To: <cover.1555486210.git.joabreu@synopsys.com>
References: <cover.1555486210.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finish the implementation of Flow Control feature. In order for it to
work correctly we need to set EHFC bit and the correct threshold values
for activating and deactivating it.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  5 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 46 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 37d5e6fe7473..085b700a4994 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -143,6 +143,11 @@
 #define XGMAC_RSF			BIT(5)
 #define XGMAC_RTC			GENMASK(1, 0)
 #define XGMAC_RTC_SHIFT			0
+#define XGMAC_MTL_RXQ_FLOW_CONTROL(x)	(0x00001150 + (0x80 * (x)))
+#define XGMAC_RFD			GENMASK(31, 17)
+#define XGMAC_RFD_SHIFT			17
+#define XGMAC_RFA			GENMASK(15, 1)
+#define XGMAC_RFA_SHIFT			1
 #define XGMAC_MTL_QINTEN(x)		(0x00001170 + (0x80 * (x)))
 #define XGMAC_RXOIE			BIT(16)
 #define XGMAC_MTL_QINT_STATUS(x)	(0x00001174 + (0x80 * (x)))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 2ba712b48a89..e79037f511e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -147,6 +147,52 @@ static void dwxgmac2_dma_rx_mode(void __iomem *ioaddr, int mode,
 	value &= ~XGMAC_RQS;
 	value |= (rqs << XGMAC_RQS_SHIFT) & XGMAC_RQS;
 
+	if ((fifosz >= 4096) && (qmode != MTL_QUEUE_AVB)) {
+		u32 flow = readl(ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
+		unsigned int rfd, rfa;
+
+		value |= XGMAC_EHFC;
+
+		/* Set Threshold for Activating Flow Control to min 2 frames,
+		 * i.e. 1500 * 2 = 3000 bytes.
+		 *
+		 * Set Threshold for Deactivating Flow Control to min 1 frame,
+		 * i.e. 1500 bytes.
+		 */
+		switch (fifosz) {
+		case 4096:
+			/* This violates the above formula because of FIFO size
+			 * limit therefore overflow may occur in spite of this.
+			 */
+			rfd = 0x03; /* Full-2.5K */
+			rfa = 0x01; /* Full-1.5K */
+			break;
+
+		case 8192:
+			rfd = 0x06; /* Full-4K */
+			rfa = 0x0a; /* Full-6K */
+			break;
+
+		case 16384:
+			rfd = 0x06; /* Full-4K */
+			rfa = 0x12; /* Full-10K */
+			break;
+
+		default:
+			rfd = 0x06; /* Full-4K */
+			rfa = 0x1e; /* Full-16K */
+			break;
+		}
+
+		flow &= ~XGMAC_RFD;
+		flow |= rfd << XGMAC_RFD_SHIFT;
+
+		flow &= ~XGMAC_RFA;
+		flow |= rfa << XGMAC_RFA_SHIFT;
+
+		writel(flow, ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
+	}
+
 	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
 
 	/* Enable MTL RX overflow */
-- 
2.7.4

