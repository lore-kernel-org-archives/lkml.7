Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C6CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E164C208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfD0P0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34840 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728433AbfD0P0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:03 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zB-Nc; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Qw-6I; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Sekhar Nori" <nsekhar@ti.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Heiner Kallweit" <hkallweit1@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.524165376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 042/202] net: phy: micrel: set soft_reset callback to
 genphy_soft_reset for KSZ9031
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

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 1d16073a326891c2a964e4cb95bc18fbcafb5f74 upstream.

So far genphy_soft_reset was used automatically if the PHY driver
didn't implement the soft_reset callback. This changed with the
mentioned commit and broke KSZ9031. To fix this configure the
KSZ9031 PHY driver to use genphy_soft_reset.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -596,6 +596,7 @@ static struct phy_driver ksphy_driver[]
 	.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
 	.config_init	= ksz9031_config_init,
 	.config_aneg	= genphy_config_aneg,
+	.soft_reset	= genphy_soft_reset,
 	.read_status	= ksz9031_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= ksz9021_config_intr,

