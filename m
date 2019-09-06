Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C95C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3A206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="drvZ1NVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392575AbfIFHla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:41:30 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:33308 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730293AbfIFHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:41:29 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 50F4AC0E3E;
        Fri,  6 Sep 2019 07:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567755688; bh=5PThB8CbPp7CzMhqALHU7PGlPrATo2NWaeXFnvxIVn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=drvZ1NVfjP8S07HTglCD14IF98r7nF21bZy9Q7+7ipGQcVBY5gubVAMjK0yGX330n
         3JXnT4RfjyfzDpBZ6o4X9wUF0q68w/W3dm1fVeMomjRC26jkU893lHRk9iYcpJ2ZzX
         o8j22eZNVJ5Xv8Lq3UPedq0dczXiYjtqhRUD7kybd+D8/CoHbYji9MO73O1zrDdvbq
         nSezPLPbgExNnMomZlzp5HSInq9ivBA5AVu1Jawa7lT93AVLWBp+KsNJrEZrbbVgGH
         XdRWC/Z/DRw50fbXtY3vvaWuupikLWfsVVbLdejC1AgWAr1EiretupAuPe6hSptzxH
         ukgdeVJtn5IbA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id CDB44A0066;
        Fri,  6 Sep 2019 07:41:26 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: stmmac: dwmac4: Enable RX Jumbo frame support
Date:   Fri,  6 Sep 2019 09:41:15 +0200
Message-Id: <1eb3adcf838e92cffd2c4a6ef405fed0f3ac2b1e.1567755423.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567755423.git.joabreu@synopsys.com>
References: <cover.1567755423.git.joabreu@synopsys.com>
In-Reply-To: <cover.1567755423.git.joabreu@synopsys.com>
References: <cover.1567755423.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are already doing it by default in the TX path so we can also enable
Jumbo Frame support in the RX path independently of MTU value.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 2ed11a581d80..03301ffc0391 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -352,7 +352,8 @@ enum power_event {
 
 /* Default operating mode of the MAC */
 #define GMAC_CORE_INIT (GMAC_CONFIG_JD | GMAC_CONFIG_PS | \
-			GMAC_CONFIG_BE | GMAC_CONFIG_DCRS)
+			GMAC_CONFIG_BE | GMAC_CONFIG_DCRS | \
+			GMAC_CONFIG_JE)
 
 /* To dump the core regs excluding  the Address Registers */
 #define	GMAC_REG_NUM	132
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index fc9954e4a772..596311a80d1c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -25,15 +25,9 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
-	int mtu = dev->mtu;
 
 	value |= GMAC_CORE_INIT;
 
-	if (mtu > 1500)
-		value |= GMAC_CONFIG_2K;
-	if (mtu > 2000)
-		value |= GMAC_CONFIG_JE;
-
 	if (hw->ps) {
 		value |= GMAC_CONFIG_TE;
 
-- 
2.7.4

