Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EDA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260353;
	bh=zs5nH9pHmEqwZbYC0nCLUZmWVDEtjahXTbB0BjCzUCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KAzaUFiXmo9I9dk/TyjCatcirfEm6fuNBswYXbaCM3VkYlUNxwhelIPRFVA1khC5A
	 jtU3UiIrXJnYnugJ3LkF0CR94kqW+iuQZ7fygUkIBvVBhA9vS+k1nUTQ4OLlQNvUXL
	 05w05Dkugtj1SAmAZoNEhSr508OeBOrbKxrOEius=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfCVNMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbfCVLbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA67321916;
        Fri, 22 Mar 2019 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254297;
        bh=zs5nH9pHmEqwZbYC0nCLUZmWVDEtjahXTbB0BjCzUCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIvKcoD5VThjvKy4EU9USepksEh6Lz4aFQ7V+gN5WJnjYut2+0Fp0V0rkTJMjJt9v
         HSG2qfx+GlwaFR6UMO9iH7Qe8eryQRIxpjV0SOvHoV84d8H24AWg1krTHfpj7Hs4Py
         3U3jX6LIw4z7b/Fz6UnLyDANgUqa2MejdYHj09BA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 092/230] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date:   Fri, 22 Mar 2019 12:13:50 +0100
Message-Id: <20190322111243.074044478@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c69c29a1a0a8f68cd87e98ba4a5a79fb8ef2a58c ]

If phy_power_on() fails in rk_gmac_powerup(), clocks are left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 0cd3ecff768b..398b08e07149 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -535,8 +535,10 @@ static int rk_gmac_init(struct platform_device *pdev, void *priv)
 	int ret;
 
 	ret = phy_power_on(bsp_priv, true);
-	if (ret)
+	if (ret) {
+		gmac_clk_enable(bsp_priv, false);
 		return ret;
+	}
 
 	ret = gmac_clk_enable(bsp_priv, true);
 	if (ret)
-- 
2.19.1



