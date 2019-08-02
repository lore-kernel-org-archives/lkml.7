Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8518C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29F621726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738883;
	bh=4Ry8K8H4qf2fv5PifWxooMohERMXh9MUkiHHEwcDOvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mfe1a6qIGunXhpF1ZrCwLuUurdWOUgUqOcvRaGezTDN+3aZM7ZxbJJ/cVdkB2N6Ek
	 +FhvbN7/VI55Cn/O4FcF9GlK5t9RqYABbSRUGIXbNJg9xabsyBrl3txkP0mcrH+qXI
	 ao+PvPX59Y6L+Er6a2+V1ghBFXk7kuhlNtwvEDzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404541AbfHBJlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391820AbfHBJlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:41:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC69520880;
        Fri,  2 Aug 2019 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738879;
        bh=4Ry8K8H4qf2fv5PifWxooMohERMXh9MUkiHHEwcDOvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3zi/xRB8C22n0vuIkvCVy8L30oPOJkUpOi4vVZKMz3nezbOgSd23xf4bc2tYRTSL
         PwEeu6zc9dC8ItZ2Ud/CNNDIHoUo4aXLE60/eWOAeDX1QwWgEMaY5RgVmTCrrCz/pg
         MiEb1WFrkxko4ElKciX8tD828qvemYZu1WKPjOcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 016/223] net: stmmac: dwmac4/5: Clear unused address entries
Date:   Fri,  2 Aug 2019 11:34:01 +0200
Message-Id: <20190802092240.060441829@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0620ec6c62a5a07625b65f699adc5d1b90394ee6 ]

In case we don't use a given address entry we need to clear it because
it could contain previous values that are no longer valid.

Found out while running stmmac selftests.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 51019b794be5..f46f2bfc2cc0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -173,14 +173,20 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 		 * are required
 		 */
 		value |= GMAC_PACKET_FILTER_PR;
-	} else if (!netdev_uc_empty(dev)) {
-		int reg = 1;
+	} else {
 		struct netdev_hw_addr *ha;
+		int reg = 1;
 
 		netdev_for_each_uc_addr(ha, dev) {
 			dwmac4_set_umac_addr(hw, ha->addr, reg);
 			reg++;
 		}
+
+		while (reg <= GMAC_MAX_PERFECT_ADDRESSES) {
+			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
+			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
+			reg++;
+		}
 	}
 
 	writel(value, ioaddr + GMAC_PACKET_FILTER);
-- 
2.20.1



