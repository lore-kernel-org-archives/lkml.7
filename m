Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E189CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2421479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfEJTfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:35:44 -0400
Received: from mutluit.com ([82.211.8.197]:38382 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfEJTfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:35:43 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2019 15:35:42 EDT
Received: from c22-local.mutluit.com (ip4d1674dc.dynamic.kabel-deutschland.de [77.22.116.220]:31668)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:25) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16FAC33> for <linux-kernel@vger.kernel.org> from <um@mutluit.com>;
        Fri, 10 May 2019 15:27:26 -0400
From:   Uenal Mutlu <um@mutluit.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Uenal Mutlu <um@mutluit.com>, linux-sunxi@googlegroups.com,
        u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA TX/RX FIFOs
Date:   Fri, 10 May 2019 21:25:50 +0200
Message-Id: <20190510192550.17458-1-um@mutluit.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
[tested on SSD using dd bs=4K count=512K].

Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
These devices are RaspberryPi-like small devices.

RFC: Since more than about 25 similar SBC/SoC models do use the
ahci_sunxi driver, users are encouraged to test it on all the
affected boards and give feedback.

List of the affected sunxi and other boards and SoCs with SATA using
the ahci_sunxi driver:
  $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
  and http://linux-sunxi.org/Category:Devices_with_SATA_port

Signed-off-by: Uenal Mutlu <um@mutluit.com>
---
 drivers/ata/ahci_sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..257986431c79 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -158,7 +158,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
 
 	/* Start DMA */
 	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
-- 
2.11.0

