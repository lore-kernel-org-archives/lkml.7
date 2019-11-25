Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B372120740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKYKDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:03:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfKYKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:03:07 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iZBCw-0004HV-Ku; Mon, 25 Nov 2019 11:03:02 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iZBCu-0001QT-NZ; Mon, 25 Nov 2019 11:03:00 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     mkl@pengutronix.de, Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@protonic.nl
Subject: [PATCH v1 1/2] net: dsa: sja1105: print info about probet chip only after every thing was done.
Date:   Mon, 25 Nov 2019 11:02:58 +0100
Message-Id: <20191125100259.5147-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we will get "Probed switch chip" notification multiple times
if first probe filed by some reason. To avoid this confusing notifications move
dev_info to the end of probe.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 7687ddcae159..1238fd68b2cd 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2191,8 +2191,6 @@ static int sja1105_probe(struct spi_device *spi)
 		return rc;
 	}
 
-	dev_info(dev, "Probed switch chip: %s\n", priv->info->name);
-
 	ds = dsa_switch_alloc(dev, SJA1105_NUM_PORTS);
 	if (!ds)
 		return -ENOMEM;
@@ -2218,7 +2216,13 @@ static int sja1105_probe(struct spi_device *spi)
 
 	sja1105_tas_setup(ds);
 
-	return dsa_register_switch(priv->ds);
+	rc = dsa_register_switch(priv->ds);
+	if (rc)
+		return rc;
+
+	dev_info(dev, "Probed switch chip: %s\n", priv->info->name);
+
+	return 0;
 }
 
 static int sja1105_remove(struct spi_device *spi)
-- 
2.24.0

