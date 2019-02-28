Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37507C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AB120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfB1VOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:14:50 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53181 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfB1VOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:14:49 -0500
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr [86.201.231.99])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1A5E5100007;
        Thu, 28 Feb 2019 21:14:42 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com
Subject: [PATCH net] net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X
Date:   Thu, 28 Feb 2019 22:14:33 +0100
Message-Id: <20190228211433.14211-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon setting the cmode on 6390 and 6390X, the associated serdes
interfaces must be powered off/on.

Both 6390X and 6390 share code to do so, but it currently uses the 6390
specific helper mv88e6390_serdes_power() to disable and enable the
serdes interface.

This call will fail silently on 6390X when trying so set a 10G interface
such as XAUI or RXAUI, since mv88e6390_serdes_power() internally grabs
the lane number based on modes supported by the 6390, and returns 0 when
getting -ENODEV as a lane number.

Using mv88e6390x_serdes_power() should be safe here, since we explicitly
rule-out all ports but the 9 and 10, and because modes supported by 6390
ports 9 and 10 are a subset of those supported on 6390X.

This was tested on 6390X using RXAUI mode.

Fixes: 364e9d7776a3 ("net: dsa: mv88e6xxx: Power on/off SERDES on cmode change")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/mv88e6xxx/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index ebd26b6a93e6..4b02c96f6786 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -408,7 +408,7 @@ int mv88e6390x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			return err;
 	}
 
-	err = mv88e6390_serdes_power(chip, port, false);
+	err = mv88e6390x_serdes_power(chip, port, false);
 	if (err)
 		return err;
 
@@ -424,7 +424,7 @@ int mv88e6390x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 		if (err)
 			return err;
 
-		err = mv88e6390_serdes_power(chip, port, true);
+		err = mv88e6390x_serdes_power(chip, port, true);
 		if (err)
 			return err;
 
-- 
2.19.2

