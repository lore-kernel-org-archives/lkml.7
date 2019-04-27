Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F6C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703D8208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfD0PQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34364 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbfD0PPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3C-00014C-MW; Sat, 27 Apr 2019 16:15:39 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Qh-31; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Nathan Sullivan" <nathan.sullivan@ni.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.649737738@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 039/202] net/phy: micrel: Add workaround for bad autoneg
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

From: Nathan Sullivan <nathan.sullivan@ni.com>

commit d2fd719bcb0e83cb39cfee22ee800f98a56eceb3 upstream.

Very rarely, the KSZ9031 will appear to complete autonegotiation, but
will drop all traffic afterwards.  When this happens, the idle error
count will read 0xFF after autonegotiation completes.  Reset the PHY
when in that state.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16 as dependency of commit 1d16073a3268
 "net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ9031"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/phy/micrel.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -415,6 +415,27 @@ static int ksz8873mll_read_status(struct
 	return 0;
 }
 
+static int ksz9031_read_status(struct phy_device *phydev)
+{
+	int err;
+	int regval;
+
+	err = genphy_read_status(phydev);
+	if (err)
+		return err;
+
+	/* Make sure the PHY is not broken. Read idle error count,
+	 * and reset the PHY if it is maxed out.
+	 */
+	regval = phy_read(phydev, MII_STAT1000);
+	if ((regval & 0xFF) == 0xFF) {
+		phy_init_hw(phydev);
+		phydev->link = 0;
+	}
+
+	return 0;
+}
+
 static int ksz8873mll_config_aneg(struct phy_device *phydev)
 {
 	return 0;
@@ -575,7 +596,7 @@ static struct phy_driver ksphy_driver[]
 	.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
 	.config_init	= ksz9031_config_init,
 	.config_aneg	= genphy_config_aneg,
-	.read_status	= genphy_read_status,
+	.read_status	= ksz9031_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= ksz9021_config_intr,
 	.suspend	= genphy_suspend,

