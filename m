Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CDC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1336227F2D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553368;
	bh=yRfgj8NhuyV4x/BmUDE5zHkWOv8iWvsFj5+xR83Zyiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wALKiGKoQO+Z5G31jvuEesyZ2MkSmbcE/TjwfJyB9iNV8auio+ftVFZa9XaGlwPi6
	 2rdiPg6djNux+0VZBF+UA9r1EVtDrd355FNJVpQ9OGHrNULghqTone2hLOIpI+j+Fs
	 gK0L+9NefVRrtPnz7jNR7P2sdCeFGHUwwPLnc3E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFCJQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbfFCJNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E7521952;
        Mon,  3 Jun 2019 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553185;
        bh=yRfgj8NhuyV4x/BmUDE5zHkWOv8iWvsFj5+xR83Zyiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkcRfz8tDTHVKMdNEFa1aHTKaZg5NT2qXz+tPFLnw1K/fhFg2vpLmg12/94pP2bLx
         IeFgk+MEPr5MFMwhN1nhSiNr00uSBlsdErDpM7EPvKgOlTNFz5jACAGrejkcS7ChJy
         Zpl1G8GAqtWqepo/N8xb3S9gHarAnFuK7l3BHcj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 16/40] net: phy: marvell10g: report if the PHY fails to boot firmware
Date:   Mon,  3 Jun 2019 11:09:09 +0200
Message-Id: <20190603090523.620302467@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 3d3ced2ec5d71b99d72ae6910fbdf890bc2eccf0 ]

Some boards do not have the PHY firmware programmed in the 3310's flash,
which leads to the PHY not working as expected.  Warn the user when the
PHY fails to boot the firmware and refuse to initialise.

Fixes: 20b2af32ff3f ("net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell10g.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -31,6 +31,9 @@
 #define MV_PHY_ALASKA_NBT_QUIRK_REV	(MARVELL_PHY_ID_88X3310 | 0xa)
 
 enum {
+	MV_PMA_BOOT		= 0xc050,
+	MV_PMA_BOOT_FATAL	= BIT(0),
+
 	MV_PCS_BASE_T		= 0x0000,
 	MV_PCS_BASE_R		= 0x1000,
 	MV_PCS_1000BASEX	= 0x2000,
@@ -211,6 +214,16 @@ static int mv3310_probe(struct phy_devic
 	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
 		return -ENODEV;
 
+	ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MV_PMA_BOOT);
+	if (ret < 0)
+		return ret;
+
+	if (ret & MV_PMA_BOOT_FATAL) {
+		dev_warn(&phydev->mdio.dev,
+			 "PHY failed to boot firmware, status=%04x\n", ret);
+		return -ENODEV;
+	}
+
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;


