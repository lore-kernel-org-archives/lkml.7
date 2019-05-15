Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D1C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8622053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920112;
	bh=5un5W7faLGTbnVrsHgs32zUEtDbsdaDzzdUCFtETPGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0eT8xqB9LyTlBRilPkmxfmj1tY7QNpVULI1FwxElZvPkELvO2ZfXjoFeF3Xwy5XV
	 vdIo1pieA6FgTELDvBeu8lj7wutr9TrfWW7J8LzbGjHTtUHF1aZuIphXNUNCg06mAe
	 IrOV1c1bopU17qsWDAHvqhZ0WlJs+EL0F75xyqMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfEOLdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732631AbfEOLdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E637A206BF;
        Wed, 15 May 2019 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920018;
        bh=5un5W7faLGTbnVrsHgs32zUEtDbsdaDzzdUCFtETPGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvO3fCgibXFhI7sBia0ZwrsB51qQi/g+x1WD1fmaztap3VRDUD02hJJsqERqoEqOw
         K8EYzapJPWfd42dr2kpnptir+ml/jQlARVRG9ufsRhRSDGS5HG7GCA6Kx76L+t2E/e
         Y4Ufm/+SevyL2KcHGzc8YM5wCKZKa8L1kmSJyZN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 34/46] net: phy: fix phy_validate_pause
Date:   Wed, 15 May 2019 12:56:58 +0200
Message-Id: <20190515090627.120276402@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit b4010af981ac8cdf1f7f58eb6b131c482e5dee02 ]

We have valid scenarios where ETHTOOL_LINK_MODE_Pause_BIT doesn't
need to be supported. Therefore extend the first check to check
for rx_pause being set.

See also phy_set_asym_pause:
rx=0 and tx=1: advertise asym pause only
rx=0 and tx=0: stop advertising both pause modes

The fixed commit isn't wrong, it's just the one that introduced the
linkmode bitmaps.

Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2044,11 +2044,14 @@ bool phy_validate_pause(struct phy_devic
 			struct ethtool_pauseparam *pp)
 {
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-			       phydev->supported) ||
-	    (!linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-				phydev->supported) &&
-	     pp->rx_pause != pp->tx_pause))
+			       phydev->supported) && pp->rx_pause)
 		return false;
+
+	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+			       phydev->supported) &&
+	    pp->rx_pause != pp->tx_pause)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(phy_validate_pause);


