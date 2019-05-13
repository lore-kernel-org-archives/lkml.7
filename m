Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ABEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C28208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfEMOYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:24:51 -0400
Received: from mutluit.com ([82.211.8.197]:46738 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfEMOYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:24:45 -0400
Received: from c22-local.mutluit.com (ip4d155212.dynamic.kabel-deutschland.de [77.21.82.18]:58476)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:25) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16FAD6A> for <linux-kernel@vger.kernel.org> from <um@mutluit.com>;
        Mon, 13 May 2019 10:24:41 -0400
From:   Uenal Mutlu <um@mutluit.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Uenal Mutlu <um@mutluit.com>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>
Subject: [PATCH v3] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA TX/RX FIFOs
Date:   Mon, 13 May 2019 16:24:10 +0200
Message-Id: <20190513142410.9299-1-um@mutluit.com>
X-Mailer: git-send-email 2.11.0
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
from lame 36 MiB/s to 45 MiB/s previously.
Read performance is above 200 MiB/s.
[tested on SSD using dd bs=4K/8K/12K/16K/20K/24K/32K: peak-perf at 12K]

Tested on the SBCs Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 which
are based on the Allwinner A20 32bit-SoC (ARMv7-a / arm-linux-gnueabihf).
These devices are RaspberryPi-like small devices.

This problem of slow SATA write-speed with these small devices lasts
for about 7 years now (beginning with the A10 SoC). Many commentators
throughout the years wrongly assumed the slow write speed was a
hardware limitation. This patch finally solves the problem, which
in fact was just a hard-to-find software problem due to lack of
SATA/AHCI documentation by the SoC-maker Allwinner Technology.

Lists of the affected sunxi and other boards and SoCs with SATA using
the ahci_sunxi driver:
  $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
  and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
  See also http://linux-sunxi.org/Category:Devices_with_SATA_port

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Uenal Mutlu <um@mutluit.com>
---

v3:
  * Removed RFC from Subject line, and also the explicit call for RFC
    in the text, thereby submitting the patch for official merging.

v2:
  * Commented the patch in-place in ahci_sunxi.c
  * With bs=12K and no conv=... passed to dd, the write performance
    rises further to 132 MiB/s
  * Changed MB/s to MiB/s
  * Posted the story behind the patch:
    http://lkml.iu.edu/hypermail/linux/kernel/1905.1/03506.html
  * Posted a dd test script to find optimal bs, and some results:
    https://bit.ly/2YoOzEM

v1:
  * States bs=4K for dd and a write performance of 120 MiB/s
---
 drivers/ata/ahci_sunxi.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..018186a39a69 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -157,8 +157,51 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
-	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	/* Setup DMA before DMA start
+	 *
+	 * NOTE: A similar SoC with SATA/AHCI by Texas Instruments documents
+	 *   this Vendor Specific Port (P0DMACR, aka PxDMACR) in its
+	 *   User's Guide document (TMS320C674x/OMAP-L1x Processor
+	 *   Serial ATA (SATA) Controller, Literature Number: SPRUGJ8C,
+	 *   March 2011, Chapter 4.33 Port DMA Control Register (P0DMACR),
+	 *   p.68, https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf)
+	 *   as equivalent to the following struct:
+	 *
+	 *   struct AHCI_P0DMACR_t
+	 *   {
+	 *     unsigned TXTS     : 4;
+	 *     unsigned RXTS     : 4;
+	 *     unsigned TXABL    : 4;
+	 *     unsigned RXABL    : 4;
+	 *     unsigned Reserved : 16;
+	 *   };
+	 *
+	 *   TXTS: Transmit Transaction Size (TX_TRANSACTION_SIZE).
+	 *     This field defines the DMA transaction size in DWORDs for
+	 *     transmit (system bus read, device write) operation. [...]
+	 *
+	 *   RXTS: Receive Transaction Size (RX_TRANSACTION_SIZE).
+	 *     This field defines the Port DMA transaction size in DWORDs
+	 *     for receive (system bus write, device read) operation. [...]
+	 *
+	 *   TXABL: Transmit Burst Limit.
+	 *     This field allows software to limit the VBUSP master read
+	 *     burst size. [...]
+	 *
+	 *   RXABL: Receive Burst Limit.
+	 *     Allows software to limit the VBUSP master write burst
+	 *     size. [...]
+	 *
+	 *   Reserved: Reserved.
+	 *
+	 *
+	 * NOTE: According to the above document, the following alternative
+	 *   to the code below could perhaps be a better option
+	 *   (or preparation) for possible further improvements later:
+	 *     sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff,
+	 *		0x00000033);
+	 */
+	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
 
 	/* Start DMA */
 	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
-- 
2.11.0

