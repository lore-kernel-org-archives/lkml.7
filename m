Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5B4C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149BC26D0D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553472;
	bh=I2XIBKBNTs1xoIzNd4LYD+7tpYa0YVk0MttJtKBQ+xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=po316VG5zwlUbVT3MuMF8Mhy6HUaNFq8LtTjXwmeQFEmg1KGA9iohCUUzyyslcMtQ
	 r3aXB/dE7a7W4nsAT90YblLACJ/QbcEvt/Ufbyo+J5pzbmm98MZ7qPeu0imUA+mIty
	 OCqxxurtm5bWR/uINgaLZV0ljJgK6UH2eMJFgQds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfFCJRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfFCJKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:10:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3740827E36;
        Mon,  3 Jun 2019 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553053;
        bh=I2XIBKBNTs1xoIzNd4LYD+7tpYa0YVk0MttJtKBQ+xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPKDF/NRQJgPLl0ftwTyz9peEyRWguszWWbkqfI/+BF+VT2EEno0gZdIBYsufMe01
         l1oSJcIncUqAcJfcq4Q6Q0mkL/REhLv6BSwfcWVZhyqXB8O8utpuAFVVlBwjgbubkq
         sKdC/Os72jJp/pfop99h5D1rJzdH7fgPsZAV4OX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 14/32] net: phy: marvell10g: report if the PHY fails to boot firmware
Date:   Mon,  3 Jun 2019 11:08:08 +0200
Message-Id: <20190603090313.095296232@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090308.472021390@linuxfoundation.org>
References: <20190603090308.472021390@linuxfoundation.org>
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
@@ -27,6 +27,9 @@
 #include <linux/phy.h>
 
 enum {
+	MV_PMA_BOOT		= 0xc050,
+	MV_PMA_BOOT_FATAL	= BIT(0),
+
 	MV_PCS_BASE_T		= 0x0000,
 	MV_PCS_BASE_R		= 0x1000,
 	MV_PCS_1000BASEX	= 0x2000,
@@ -226,6 +229,16 @@ static int mv3310_probe(struct phy_devic
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


