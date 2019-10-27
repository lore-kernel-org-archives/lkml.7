Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F48DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E8A21726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211235;
	bh=7yoZoRGGFhcYeBasBZNTGWbaRNQSgC+J70ieIlJyhLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oc9OosOthKz+8gknkuZKPtswHydrNvE7CqSi5WZV24AFWKoKoI2OBSH8WMvyh0wDv
	 PWnYP7oGCThp8e9ZYE6LH11YQE7Qu7K7yXYxXp276A43CCjQAh8uBXSi8G2tDGE6Y+
	 nB+j2NycPD6Iy6kvIKMJdlCBc0ZsQSwK8GHyxBug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfJ0VUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbfJ0VUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:20:32 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13EAF21848;
        Sun, 27 Oct 2019 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211231;
        bh=7yoZoRGGFhcYeBasBZNTGWbaRNQSgC+J70ieIlJyhLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dr7lHKvKlrWMIj++XDinxDWPTOLFyhMM1uGlff0iddWW5++0zhZU3sAQb86ytYRDv
         E/FqblT0S37RPCs8IFfnYH1jFNwNFjA5th0/D6Lbua5fZ6kXE8PU0ksS1YOf4tiWqr
         CETl88b82aNgMsi1QS04viPiuQjegaBw6SOj0V/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biao Huang <biao.huang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 077/197] net: stmmac: disable/enable ptp_ref_clk in suspend/resume flow
Date:   Sun, 27 Oct 2019 21:59:55 +0100
Message-Id: <20191027203355.826603403@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4480,8 +4480,10 @@ int stmmac_suspend(struct device *dev)
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
 
@@ -4544,8 +4546,10 @@ int stmmac_resume(struct device *dev)
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


