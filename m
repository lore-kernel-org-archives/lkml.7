Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94509C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2E20409
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640575;
	bh=prkrhnJRoSbtS7JX9q8fq7A4FByQwa0ZP1hOz0/cf8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+C3jd1Gm02oX6IzwKc4qu2w0ip9jC/um6dAVDDbsFBH/G5kCP8WFWYfSMCYYfVue
	 CFMC9a40cvHoRtI1hP1u2BCqwMRf7X1mtYIkTUCWB3rNwQbEeg9VIbF4viBmKis4MF
	 jDexfxCmR1ayVSsPqRxPFe9DXHzGsPaGaNH9plmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfL2R3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbfL2R33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:29:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D097207FD;
        Sun, 29 Dec 2019 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640568;
        bh=prkrhnJRoSbtS7JX9q8fq7A4FByQwa0ZP1hOz0/cf8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIgeyKdhmN2kWorL2MaZiaSAH9T7SE/kUZtToIu479RK1XwLA4y/oCB3RKdTBbu3J
         vYNmMdKFuFDAhFAWmZvCX/xhwLcKpm9go3Apz2J0JQksgM4567gfL5IbpiTfPC36d9
         Qra/bjuJ5z6QzFAL6V//gmO/msnkBKaGFYRrhLcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 009/219] net: usb: lan78xx: Fix suspend/resume PHY register access error
Date:   Sun, 29 Dec 2019 18:16:51 +0100
Message-Id: <20191229162510.345406284@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

[ Upstream commit 20032b63586ac6c28c936dff696981159913a13f ]

Lan78xx driver accesses the PHY registers through MDIO bus over USB
connection. When performing a suspend/resume, the PHY registers can be
accessed before the USB connection is resumed. This will generate an
error and will prevent the device to resume correctly.
This patch adds the dependency between the MDIO bus and USB device to
allow correct handling of suspend/resume.

Fixes: ce85e13ad6ef ("lan78xx: Update to use phylib instead of mii_if_info.")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1823,6 +1823,7 @@ static int lan78xx_mdio_init(struct lan7
 	dev->mdiobus->read = lan78xx_mdiobus_read;
 	dev->mdiobus->write = lan78xx_mdiobus_write;
 	dev->mdiobus->name = "lan78xx-mdiobus";
+	dev->mdiobus->parent = &dev->udev->dev;
 
 	snprintf(dev->mdiobus->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);


