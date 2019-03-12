Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3765CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA84214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412160;
	bh=5Any1mhLvb7c+BFqZtPophl2lVeMZ8oRx/LxMcducJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UkjLCW1zGZrtFUluU3AG0Q0aN7E5A0fJUe7ZDQcMlBXf9irIbJHHCwjcBx0oXTI+l
	 ufdEw5pnF6sn6SbSD4tL/TuWRrP0OZ6Sez+g1jl0goXgGlm4ELTJtYl0f0sMG56HEq
	 mlnFm4VZEokVKL26I5Ml2PWa+cpLLSfsSsVNvvmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfCLRf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbfCLRQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:49 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0900D217D4;
        Tue, 12 Mar 2019 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411009;
        bh=5Any1mhLvb7c+BFqZtPophl2lVeMZ8oRx/LxMcducJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KC8cbKM3EFag8C+n9jid4QfYVJvIsDBVYfhjFLb5/lA1dV3HM64peOG5XVCGs5uJh
         i6EBMUofGpawphgOcaw4OoaynZD3zI0dWhHwvtlcVswWN467Dw1NfeLTh0Qes+Rifu
         Mg7fhs1bcCosGCPHb90rUTiOIBNmA1I7YQrKk9/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 096/135] net: stmmac: Fallback to Platform Data clock in Watchdog conversion
Date:   Tue, 12 Mar 2019 10:09:03 -0700
Message-Id: <20190312170350.046682370@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4ec5302fa906ec9d86597b236f62315bacdb9622 ]

If we don't have DT then stmmac_clk will not be available. Let's add a
new Platform Data field so that we can specify the refclk by this mean.

This way we can still use the coalesce command in PCI based setups.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 14 ++++++++++----
 include/linux/stmmac.h                             |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index c3c6335cbe9a..ecddd9948788 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -702,8 +702,11 @@ static u32 stmmac_usec2riwt(u32 usec, struct stmmac_priv *priv)
 {
 	unsigned long clk = clk_get_rate(priv->plat->stmmac_clk);
 
-	if (!clk)
-		return 0;
+	if (!clk) {
+		clk = priv->plat->clk_ref_rate;
+		if (!clk)
+			return 0;
+	}
 
 	return (usec * (clk / 1000000)) / 256;
 }
@@ -712,8 +715,11 @@ static u32 stmmac_riwt2usec(u32 riwt, struct stmmac_priv *priv)
 {
 	unsigned long clk = clk_get_rate(priv->plat->stmmac_clk);
 
-	if (!clk)
-		return 0;
+	if (!clk) {
+		clk = priv->plat->clk_ref_rate;
+		if (!clk)
+			return 0;
+	}
 
 	return (riwt * 256) / (clk / 1000000);
 }
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 32feac5bbd75..5844105a482b 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -183,6 +183,7 @@ struct plat_stmmacenet_data {
 	struct clk *pclk;
 	struct clk *clk_ptp_ref;
 	unsigned int clk_ptp_rate;
+	unsigned int clk_ref_rate;
 	struct reset_control *stmmac_rst;
 	struct stmmac_axi *axi;
 	int has_gmac4;
-- 
2.19.1



