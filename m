Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2F3C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF37A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428349;
	bh=n/wL2MZU1O/szMaSqv8soXoXlI+OSfvc8wjNJMYDpg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2fxk1z/OFd4eQ+uaAzrXz8eyBfK4eYBgYVD2e1TMkdc8PmY3aGuDND4I0RwdR2iYI
	 3adnpM+ghiwg4fdY362JuiBKr4mensDR5PRyEazlDFrEm2XRCU7PqmSfZ0tvPTsaCu
	 QaDmh8c3cX/lVkdsHpOu/gySmJzKZhWIxzbn4R8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfG2TZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfG2TZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:25:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2357521655;
        Mon, 29 Jul 2019 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428345;
        bh=n/wL2MZU1O/szMaSqv8soXoXlI+OSfvc8wjNJMYDpg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+CO5HmPCSHwTCHT0PpGy4rmmIJJJTXAMUNq/Uyji0kSV98KJ4kW6k9W1z+lHiBSH
         VmFTOFaPT+4rutPdRDtqllRxwbAZw39lhcPhszpQiBoVrg10Bg36JwkwmaaLfa5v/V
         0oNveHCgaP1qMjc9EvUxA2Xsx7U3toHUOWPj8kII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 019/293] net: stmmac: dwmac4/5: Clear unused address entries
Date:   Mon, 29 Jul 2019 21:18:30 +0200
Message-Id: <20190729190822.178985692@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
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
index 55ae14a6bb8c..ed5fcd4994f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -443,14 +443,20 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
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



