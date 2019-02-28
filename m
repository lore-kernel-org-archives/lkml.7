Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A55C2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfB1NuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:50:17 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34989 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfB1NuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:50:15 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0715FE0008;
        Thu, 28 Feb 2019 13:50:10 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 0/3] net: phy: marvell10g: implement suspend/resume callbacks
Date:   Thu, 28 Feb 2019 14:48:34 +0100
Message-Id: <20190228134837.32740-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series implements the suspend/resume callbacks in the marvell10g
PHY driver:

- When the PHY isn't used, it is set in low power mode.
- At boot time we might now know the PHY status (as it's depending on
  the hardware configuration, or on what the previous stages
  configured), it is forced in low power.

Doing this prevents a PHY which was initialized in a previous stage from
negotiating with the link partner when a local port is down. If the PHY
isn't shutdown when a port is not used, the link partner's PHY may
report the link being up while it's not.

Thanks,
Antoine

Antoine Tenart (3):
  net: phy: marvell10g: implement suspend/resume callbacks
  net: phy: marvell10g: add the suspend/resume callbacks for the 88x2210
  net: phy: marvell10g: set the PHY in low power by default

 drivers/net/phy/marvell10g.c | 39 ++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

-- 
2.20.1

