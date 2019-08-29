Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D30C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF362339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567048660;
	bh=u98FcVu0HBkillng09TqWFlGgpgWVWpnghz9szhnReI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DQkbdFO2CkpNapZTNOPeHvnLgI9Z/LiR1a7WrgkwiAKNexNODdzdoxgwICadPOOlI
	 Ra528itjhbdqLXgESiQMJyT78kIiBuN+qb1kYjoyiT0JH8lQVidskU2zY8XEo0j4W9
	 q+poe399eraHMsp5DYtOWLzQ0D8+BIyiJWYKw+/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfH2DRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfH2DRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:17:39 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9DB22CF8;
        Thu, 29 Aug 2019 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567048658;
        bh=u98FcVu0HBkillng09TqWFlGgpgWVWpnghz9szhnReI=;
        h=From:To:Cc:Subject:Date:From;
        b=HAD4xrCfip0e9CQw3xO5Qsd40IdOaU7J/AldbwBXqtbzk8rjpl8hI756VTkNodh/u
         TBVn9ukdcGLCetH0FJeWue86+GoA3/LG0UkyCNfplVPqTMn8dzCqF1PTy5FJwAL/4s
         TIBsO4qGmnx83Y6eLXMQ9gHQfu+oUhFvlJ2Qz6jQ=
Received: by wens.tw (Postfix, from userid 1000)
        id BA06A5FCC3; Thu, 29 Aug 2019 11:17:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH netdev] net: stmmac: dwmac-rk: Don't fail if phy regulator is absent
Date:   Thu, 29 Aug 2019 11:17:24 +0800
Message-Id: <20190829031724.20865-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The devicetree binding lists the phy phy as optional. As such, the
driver should not bail out if it can't find a regulator. Instead it
should just skip the remaining regulator related code and continue
on normally.

Skip the remainder of phy_power_on() if a regulator supply isn't
available. This also gets rid of the bogus return code.

Fixes: 2e12f536635f ("net: stmmac: dwmac-rk: Use standard devicetree property for phy regulator")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

On a separate note, maybe we should add this file to the Rockchip
entry in MAINTAINERS?

---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 4644b2aeeba1..e2e469c37a4d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1194,10 +1194,8 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo) {
-		dev_err(dev, "no regulator found\n");
-		return -1;
-	}
+	if (!ldo)
+		return 0;
 
 	if (enable) {
 		ret = regulator_enable(ldo);
-- 
2.20.1

