Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35BAC3276F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF2820863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005135;
	bh=Qb3m8o3v/CT1jaIGRbSVS20mboLUBUtnyX6r/TOUIO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mkxGgwIB5hJZlGDuIVmBJWa0CpWGfuKsZlXsEwNLletN/2xu2yZBgHNJL6NLt+9NV
	 3tJ9wdThlKUcpJDesDaXKvq8MwkYnQa09m/NN/YcuWLg7z+W/NRQTO+utqMhFM1WC1
	 ZtftyHd9MhU0oPd3pzY77reJg1bQI/Ou/oag4eSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgABWby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgABWbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:31:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5761621835;
        Thu,  2 Jan 2020 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004308;
        bh=Qb3m8o3v/CT1jaIGRbSVS20mboLUBUtnyX6r/TOUIO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3LBaVzmFbZMcrc3RXIE/j4p4qSZgn5INr9vMnjrKVneWGq8nVS2yiiEr4N3cMJvb
         yZWUf59JItnN5czGoioKRB8mxH5TjVMSYTvI0EAwX7D02yQtfgjx1u8Fw1hfMfenaE
         ZmYPNhVsdZ7a/rgUopsM19eglOTb+urtN4/axDBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 099/171] net: usb: lan78xx: Fix suspend/resume PHY register access error
Date:   Thu,  2 Jan 2020 23:07:10 +0100
Message-Id: <20200102220600.957092549@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
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
@@ -1763,6 +1763,7 @@ static int lan78xx_mdio_init(struct lan7
 	dev->mdiobus->read = lan78xx_mdiobus_read;
 	dev->mdiobus->write = lan78xx_mdiobus_write;
 	dev->mdiobus->name = "lan78xx-mdiobus";
+	dev->mdiobus->parent = &dev->udev->dev;
 
 	snprintf(dev->mdiobus->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);


