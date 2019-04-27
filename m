Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C65C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF6D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfD0PSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:18:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34372 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727710AbfD0PPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3C-00014G-E8; Sat, 27 Apr 2019 16:15:38 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Qm-48; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Zach Brown" <zach.brown@ni.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.782219792@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 040/202] net/phy: micrel: configure intterupts after
 autoneg workaround
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zach Brown <zach.brown@ni.com>

commit b866203d872d5deeafcecd25ea429d6748b5bd56 upstream.

The commit ("net/phy: micrel: Add workaround for bad autoneg") fixes an
autoneg failure case by resetting the hardware. This turns off
intterupts. Things will work themselves out if the phy polls, as it will
figure out it's state during a poll. However if the phy uses only
intterupts, the phy will stall, since interrupts are off. This patch
fixes the issue by calling config_intr after resetting the phy.

Fixes: d2fd719bcb0e ("net/phy: micrel: Add workaround for bad autoneg ")
Signed-off-by: Zach Brown <zach.brown@ni.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/phy/micrel.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -431,6 +431,8 @@ static int ksz9031_read_status(struct ph
 	if ((regval & 0xFF) == 0xFF) {
 		phy_init_hw(phydev);
 		phydev->link = 0;
+		if (phydev->drv->config_intr && phy_interrupt_is_valid(phydev))
+			phydev->drv->config_intr(phydev);
 	}
 
 	return 0;

