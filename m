Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3CDC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9C1217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="klG2q3nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbfKFPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:03:52 -0500
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:43130 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731948AbfKFPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:03:13 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 24C9EC0F50;
        Wed,  6 Nov 2019 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573052592; bh=ntn5h+EtiIr26cxuzm1ZrBPes0SSBYvLTZygjleUGzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=klG2q3nFG65HPrpY5Kdxt47P3pYI7LWxN8yFGTQ9ytOchwkVULKnj/kfj2fmz6kTp
         bo20ZV4qA+5zBEgV7eTtSmoeeeacKbJDbClj9VXmp8JJvXZaN9SkhmT3P8zofep/7X
         PMZVqBY98iJsPwys1f4y7hFtQ5cDX3kexvDKl2lCE47/Qg201fXq6MEld9SVV6wRmE
         zjKK19Yks6TWJQZvrG8ts6NovA5/rhw6Md7qHK/+vnkfg744b7YYg6MoceD6wUTgyn
         Zt8uzjiz/4/aSmexQJo5bLNv+eY57D88JRDvkvkiQrJWNXXYjwTodHU8VJ2gA+4e52
         cuseJ31+kCE0Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id DE67CA007D;
        Wed,  6 Nov 2019 15:03:10 +0000 (UTC)
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
Subject: [PATCH net 08/11] net: stmmac: xgmac: Disable MMC interrupts by default
Date:   Wed,  6 Nov 2019 16:03:02 +0100
Message-Id: <d89d225566d012d499eec5c8ab30b5e441f5c509.1573052379.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1573052378.git.Jose.Abreu@synopsys.com>
References: <cover.1573052378.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1573052378.git.Jose.Abreu@synopsys.com>
References: <cover.1573052378.git.Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMC interrupts were being enabled, which is not what we want because it
will lead to a storm of interrupts that are not handled at all. Fix it
by disabling all MMC interrupts for XGMAC.

Fixes: b6cdf09f51c2 ("net: stmmac: xgmac: Implement MMC counters")
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
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index a223584f5f9a..252cf48c5816 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -176,6 +176,7 @@
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
 #define MMC_XGMAC_RX_FPE_FRAG		0x234
+#define MMC_XGMAC_RX_IPC_INTR_MASK	0x25c
 
 static void dwmac_mmc_ctrl(void __iomem *mmcaddr, unsigned int mode)
 {
@@ -333,8 +334,9 @@ static void dwxgmac_mmc_ctrl(void __iomem *mmcaddr, unsigned int mode)
 
 static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
-	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_RX_INTR_MASK);
-	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_TX_INTR_MASK);
+	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
+	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
 static void dwxgmac_read_mmc_reg(void __iomem *addr, u32 reg, u32 *dest)
-- 
2.7.4

