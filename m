Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B62C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B272246F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U04QP/b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfKMPM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:12:59 -0500
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:51262 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbfKMPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:12:22 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 14940C0E8E;
        Wed, 13 Nov 2019 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573657941; bh=OLfO2cSvqUwRYq7olBQ/mmQCkf/PJmu4vZLyw90R8iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=U04QP/b8q4807WPbPB6XcuBN4j0386WFyi/TWHif0MlN1B+UTPAFcaeyP+J627dzB
         RTkhQwrSsbWoZY2T9uc41x3ABMzOGDw8ZByJOAw09kPMDPJIQ7+K1H+bPVl7GVMylO
         11enBj8MouEA+7MGR4uiLB3fJ7NHvBTa/rX/5KP3S+/dQqhc9l7ADz56C199vHTLmi
         JobUsa6aML3jTRGJPgm6fVmzgCzKrwGwg7iDdQf7jPsL8PrpeQfnVE3RROMfHZW0cd
         aPkn9L57xhIwF0obytxe4wOHnQ7Z9jVhZbmnSRv94SBLYIS/gIxqUqHKIsIGssJ6I/
         DLIBYLttMyZfw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 87BFBA0087;
        Wed, 13 Nov 2019 15:12:19 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: stmmac: gmac4+: Enable the TBU Interrupt
Date:   Wed, 13 Nov 2019 16:12:04 +0100
Message-Id: <dbe803beb524da8ac751e8019c798915c0f7eb2f.1573657592.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1573657592.git.Jose.Abreu@synopsys.com>
References: <cover.1573657592.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1573657592.git.Jose.Abreu@synopsys.com>
References: <cover.1573657592.git.Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables Transmit Buffer Unavailable interrupt so that any coalesced
packet is not missed on transmission.

Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 589931795847..1be1df5f65de 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -161,6 +161,7 @@
 
 #define DMA_CHAN_INTR_NORMAL		(DMA_CHAN_INTR_ENA_NIE | \
 					 DMA_CHAN_INTR_ENA_RIE | \
+					 DMA_CHAN_INTR_ENA_TBUE | \
 					 DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
@@ -171,6 +172,7 @@
 
 #define DMA_CHAN_INTR_NORMAL_4_10	(DMA_CHAN_INTR_ENA_NIE_4_10 | \
 					 DMA_CHAN_INTR_ENA_RIE | \
+					 DMA_CHAN_INTR_ENA_TBUE | \
 					 DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
-- 
2.7.4

