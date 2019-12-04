Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E394C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D428020675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482744;
	bh=zCX38j0ApMKwif385tSeV5oiDGYMeI09N9Vdg67Tctw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OVlsJxaJeQrfiJw2zRVxCVOiYm0T5P6perTqoSjQeAu1o1nLd73xoDRnjoNkaI1va
	 A63IT/zExPiMiHPdZy/s2hkTbzNVCjSJJReCXZp44AVkBYGTCBKEcTDKlBy3jALuuO
	 b7Y2dKsQMqMZ4mSZHM4317jsqYeDjmWHXujcO0GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfLDSFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbfLDSFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:36 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340B120659;
        Wed,  4 Dec 2019 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482735;
        bh=zCX38j0ApMKwif385tSeV5oiDGYMeI09N9Vdg67Tctw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkEbyTgDMGQY8idu+NSBVZhWAtHpJ4BbX3n2H3cIr/IJo3bDYFdFWvLPyf338F+c6
         cStL7iButhWRtgX8vCcI6wahniuLW/VeL9NQPQ4eaRQyHbodcTqiKeyzoXL2AIZ7O5
         vbNncn69ZavbUK1MV4gQ5Y1Ek2RmuuGbn4gPytR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 114/209] net: stmicro: fix a missing check of clk_prepare
Date:   Wed,  4 Dec 2019 18:55:26 +0100
Message-Id: <20191204175330.939505750@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit f86a3b83833e7cfe558ca4d70b64ebc48903efec ]

clk_prepare() could fail, so let's check its status, and if it fails,
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index d07520fb969e6..62ccbd47c1db2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -59,7 +59,9 @@ static int sun7i_gmac_init(struct platform_device *pdev, void *priv)
 		gmac->clk_enabled = 1;
 	} else {
 		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_MII_RATE);
-		clk_prepare(gmac->tx_clk);
+		ret = clk_prepare(gmac->tx_clk);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.20.1



