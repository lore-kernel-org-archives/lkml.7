Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4370C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A85820843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfD1MyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:54:01 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:45774 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfD1Mxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 08:53:49 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 7DB83453C;
        Sun, 28 Apr 2019 14:53:46 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 4540dc20;
        Sun, 28 Apr 2019 14:53:45 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 4/4] net: davinci_emac: Drop nvmem_get_mac_address usage
Date:   Sun, 28 Apr 2019 14:53:22 +0200
Message-Id: <1556456002-13430-5-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556456002-13430-1-git-send-email-ynezz@true.cz>
References: <1556456002-13430-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_mac_address now uses NVMEM under the hood, so it's not necessary
to call it manually anymore.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 drivers/net/ethernet/ti/davinci_emac.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 57450b1..c1a5526 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1912,15 +1912,11 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
 
 	if (!is_valid_ether_addr(priv->mac_addr)) {
-		/* Try nvmem if MAC wasn't passed over pdata or DT. */
-		rc = nvmem_get_mac_address(&pdev->dev, priv->mac_addr);
-		if (rc) {
-			/* Use random MAC if still none obtained. */
-			eth_hw_addr_random(ndev);
-			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
-			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
-				 priv->mac_addr);
-		}
+		/* Use random MAC if still none obtained. */
+		eth_hw_addr_random(ndev);
+		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
+		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
+			 priv->mac_addr);
 	}
 
 	ndev->netdev_ops = &emac_netdev_ops;
-- 
1.9.1

