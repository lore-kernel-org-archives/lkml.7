Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB48CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D9A206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096536;
	bh=QydTQveAUcVFB9D7kkvvLv20OZW4pvDeTAn9K6URMQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOuq2vHnf79c1HEKPF3E+GA/w1FER4dpv6xgJoA8CxQue+MEpkDT/XQNBfH0BIN4e
	 irjzlEJtYFtYqGs42nDk1Q744pxTdeq8GCq+kKKMwh3e+88yeL38X4kfUZ+sv3Y1qH
	 SAu5LEVOAJ/PjC3AuQTtMqIiDmwAYQlXXAArt5C4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfJZN2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfJZNUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76FF6214DA;
        Sat, 26 Oct 2019 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096050;
        bh=QydTQveAUcVFB9D7kkvvLv20OZW4pvDeTAn9K6URMQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch0UNItAD0LU8lw+FhLq8Nek4Hsriej9IBsSK9d4ZqguaWV0fk17s2YWImbOXgD7J
         YFRcThU0HH5DY8ZetgXKib4ZChnSa06oPpwyixIGFlPdItcqVOG9+4ipd8yJ6m+uAK
         SjIJYT09vZDJmpxsH4cDIwFEfXYPLn9jUgdmcMYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biao Huang <biao.huang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 51/59] net: stmmac: disable/enable ptp_ref_clk in suspend/resume flow
Date:   Sat, 26 Oct 2019 09:19:02 -0400
Message-Id: <20191026131910.3435-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>

[ Upstream commit e497c20e203680aba9ccf7bb475959595908ca7e ]

disable ptp_ref_clk in suspend flow, and enable it in resume flow.

Fixes: f573c0b9c4e0 ("stmmac: move stmmac_clk, pclk, clk_ptp_ref and stmmac_rst to platform structure")
Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0101ebaecf028..014fe93ed2d82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4522,8 +4522,10 @@ int stmmac_suspend(struct device *dev)
 		stmmac_mac_set(priv, priv->ioaddr, false);
 		pinctrl_pm_select_sleep_state(priv->device);
 		/* Disable clock in case of PWM is off */
-		clk_disable(priv->plat->pclk);
-		clk_disable(priv->plat->stmmac_clk);
+		if (priv->plat->clk_ptp_ref)
+			clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		clk_disable_unprepare(priv->plat->pclk);
+		clk_disable_unprepare(priv->plat->stmmac_clk);
 	}
 	mutex_unlock(&priv->lock);
 
@@ -4588,8 +4590,10 @@ int stmmac_resume(struct device *dev)
 	} else {
 		pinctrl_pm_select_default_state(priv->device);
 		/* enable the clk previously disabled */
-		clk_enable(priv->plat->stmmac_clk);
-		clk_enable(priv->plat->pclk);
+		clk_prepare_enable(priv->plat->stmmac_clk);
+		clk_prepare_enable(priv->plat->pclk);
+		if (priv->plat->clk_ptp_ref)
+			clk_prepare_enable(priv->plat->clk_ptp_ref);
 		/* reset the phy so that it's ready */
 		if (priv->mii)
 			stmmac_mdio_reset(priv->mii);
-- 
2.20.1

