Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1A4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB60E20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366844;
	bh=Zzdlv58zkJoQ2Qk+yyA75zOVj5zejISbneBuJwZwBbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fl8eWBLD02XxCcu+gGOOdLsa/14YrQO67xtorOnu0ZSX3RA58hy15ZFfxewwCN1sp
	 x9KsDLgF0OgdbtXCPu3SOiY7KA38JrjQq/z0FsLPMgA7w8eNMqDmuR7FjF6rycSRCL
	 /ZjqtM7KAsgX+eVW8sjpc3Q9el2j7d0ooDo/7kJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbfB1POC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388572AbfB1POA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C0B218D3;
        Thu, 28 Feb 2019 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366839;
        bh=Zzdlv58zkJoQ2Qk+yyA75zOVj5zejISbneBuJwZwBbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yu6X4cd5nSCgtaQpJtRVXaaCOX79ZK7JVEsLX+Wts0Fx69B7tH71nFqD60lWQ6ijz
         Laye3Gaoi8MnQMgA+WpphsmFT88eTEQnLvEY/ngxp9QEIbxZB0YncrMZkfvRDpmqS1
         QVpCyO6rf0FdGRnrQjKrkhAI2Pb5XBhlpIp3cZIM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/36] net: stmmac: Fallback to Platform Data clock in Watchdog conversion
Date:   Thu, 28 Feb 2019 10:13:13 -0500
Message-Id: <20190228151337.12176-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>

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
index c3c6335cbe9ae..ecddd9948788a 100644
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
index 32feac5bbd75b..5844105a482bc 100644
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

