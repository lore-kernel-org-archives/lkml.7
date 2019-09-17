Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44AC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2623021881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q/Lr9BOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfIQKCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:02:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42222 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfIQKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:02:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so1567344wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JugQhyARoBEh6axn1GkenUD1F8NS4zAnUz5g+2UjW9Y=;
        b=q/Lr9BOq/L69g4WCoKZCQ9TczATMdKu2UawnxeFAE+hhNHZC76GVOZJCaSxtRLRMi4
         hkww4gqPUO130c9uk0yzzLEpRWXquoI4YYvL1Z8XV4HfAgn45Zjk2Yb+ogUj2fbaj4js
         BtYrJMb6vHZyh/cZTduvyN8X2er9+XHOVcfOg+z/VJMtfts6WzKUdX5FPAvNW3OATEFU
         Yt5ad+VCWxlEuhQRRKjESvaqIOFBGf1TI1VfoMA9PBmo9Q6INw9uFPjKAv98Gclwv0IB
         Q6G3JXvEiT8BaNzZBYDDifwAndqQ4Fz7SMDkuA+DbQ2glFx7Aag70O2VNnVHdkA1ib+6
         RmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JugQhyARoBEh6axn1GkenUD1F8NS4zAnUz5g+2UjW9Y=;
        b=qFlP8clDH+eKfm276vdYy1aE4sPCRNJHA36H8kT628Z6O8WbmKW7C7NRsvIMzpZP27
         Rjvu4cfFrTut1DY5NZQQ0dCgdUngRRyQmwlwbNYNcorsmSil4WZ4EUei+OGOdMHPR0+Q
         muGV/KVKlsFoNzYcSAsfC7Fv2o1ZjNaIJIwtHI8ByAfNkroSlvH2OJVjEb4XOY1aA2Ie
         coXmzWoDyY3pIMBaK0cHp6OzDOu+3kwBawJoJ5YI19MT7+dumewwQ4LRT2QImUZF++Zi
         cTzGWuT4jvnHGcioGya+1OD5L03RTg7q5O3viORChu6BIk4MwxrCl4yenYgbISWT5RiU
         55rg==
X-Gm-Message-State: APjAAAXZGxbtQjlpynlgZIZlRnGwxh2zSkws3QLW/AlC8PszrETYAgfG
        o4R2zXkXd1emcZrVnOGBDdICNg==
X-Google-Smtp-Source: APXvYqzvMSwZS6tqlEUY4Ih4eSot5R1sNRe66bMyvpYWdYsCrq4qlgih6+Z/KU8adcjHmpU7LoqqgQ==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr2232769wrw.208.1568714567756;
        Tue, 17 Sep 2019 03:02:47 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x129sm1606696wmg.8.2019.09.17.03.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 03:02:46 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Fix ASSERT_RTNL() warning on suspend/resume
Date:   Tue, 17 Sep 2019 12:02:36 +0200
Message-Id: <1568714556-25024-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtnl_lock needs to be taken before calling phylink_start/stop to lock the
network stack.
Fix ASSERT_RTNL() warnings by protecting such calls with lock/unlock.

Fixes: 74371272f97f ("net: stmmac: Convert to phylink and remove phylib logic")
Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fd54c7c87485..485f33f57b43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4451,7 +4451,9 @@ int stmmac_suspend(struct device *dev)
 	if (!ndev || !netif_running(ndev))
 		return 0;
 
+	rtnl_lock();
 	phylink_stop(priv->phylink);
+	rtnl_unlock();
 
 	mutex_lock(&priv->lock);
 
@@ -4560,7 +4562,9 @@ int stmmac_resume(struct device *dev)
 
 	mutex_unlock(&priv->lock);
 
+	rtnl_lock();
 	phylink_start(priv->phylink);
+	rtnl_unlock();
 
 	return 0;
 }
-- 
2.7.4

