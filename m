Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0142C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9917F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413041;
	bh=7zrQopYsAjpQGFuizJnYBrzQ35Ei667hGwOQK8zhQJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iqo36mK5bXZoTsU+AGr8woTBeIJm0HUURz2rsM/xyRV/Fr2EXAxeF6i5jDcxSnjXX
	 XM1ThfCnqL58sDkgWjuFV0tuz80KYEp+V43FQ6/JGyNo7hwBK0lF6DFk8O4pEYQIMe
	 DYLRUda/TO5BCxeXl1hqgLUTj/VxjtPiilc6cR6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfCLRuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfCLROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:42 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0812B2173C;
        Tue, 12 Mar 2019 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410882;
        bh=7zrQopYsAjpQGFuizJnYBrzQ35Ei667hGwOQK8zhQJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1kcQrUHAzHbLHRiuN87A+G/1oZ5uymyUs35BDgOp8NTjsJbVznBwAHnBbF+h1E33
         hEtFmqp/HWUu4g8VHHU6ziftN5KhmR62WZPpogxei56jQFCt8TNPRsoYM7BAyzdS11
         uU5ohu9i+Cn9T8OrjykO3kSPYFlauQParoVfLwYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/149] net: stmmac: Fallback to Platform Data clock in Watchdog conversion
Date:   Tue, 12 Mar 2019 10:08:26 -0700
Message-Id: <20190312170357.090351325@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 9caf79ba5ef1..4d5fb4b51cc4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -719,8 +719,11 @@ static u32 stmmac_usec2riwt(u32 usec, struct stmmac_priv *priv)
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
@@ -729,8 +732,11 @@ static u32 stmmac_riwt2usec(u32 riwt, struct stmmac_priv *priv)
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
index 7ddfc65586b0..4335bd771ce5 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -184,6 +184,7 @@ struct plat_stmmacenet_data {
 	struct clk *pclk;
 	struct clk *clk_ptp_ref;
 	unsigned int clk_ptp_rate;
+	unsigned int clk_ref_rate;
 	struct reset_control *stmmac_rst;
 	struct stmmac_axi *axi;
 	int has_gmac4;
-- 
2.19.1



