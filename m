Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC4BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDZXHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:07:46 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:25218 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfDZXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 19:07:45 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 6274D36BD;
        Sat, 27 Apr 2019 01:07:43 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 96dda932;
        Sat, 27 Apr 2019 01:07:41 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 3/4] net: macb: Drop nvmem_get_mac_address usage
Date:   Sat, 27 Apr 2019 01:06:41 +0200
Message-Id: <1556320002-26213-4-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556320002-26213-1-git-send-email-ynezz@true.cz>
References: <1556320002-26213-1-git-send-email-ynezz@true.cz>
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
 drivers/net/ethernet/cadence/macb_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3da2795..1b98bc8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4172,16 +4172,10 @@ static int macb_probe(struct platform_device *pdev)
 		bp->rx_intr_mask |= MACB_BIT(RXUBR);
 
 	mac = of_get_mac_address(np);
-	if (mac) {
+	if (mac)
 		ether_addr_copy(bp->dev->dev_addr, mac);
-	} else {
-		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
-		if (err) {
-			if (err == -EPROBE_DEFER)
-				goto err_out_free_netdev;
-			macb_get_hwaddr(bp);
-		}
-	}
+	else
+		macb_get_hwaddr(bp);
 
 	err = of_get_phy_mode(np);
 	if (err < 0) {
-- 
1.9.1

