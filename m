Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB62C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAC2217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R5tJGNMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfDEAPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:15:38 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6458 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfDEAOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69deb0000>; Thu, 04 Apr 2019 17:14:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 17:14:30 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:30 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de50004>; Thu, 04 Apr 2019 17:14:29 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST mode
Date:   Thu, 4 Apr 2019 17:14:10 -0700
Message-ID: <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423275; bh=oJLl+U5RWwH3JRK77Un8w0l5USj1X2RqbAbKS6vxFl8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=R5tJGNMBpBaS5rWko+1kKVM+MXpPX0x7wQbgXXV1OJeWC707EV/UY1NMkboM93dl5
         e/OyghwruN4pRbGn5iSNpuZeiogebwg5+IOZFsO/YNE6c+sIn9YHc2P4obEJdhtWYl
         YDp7Of+5rZ6bDl3iEOeoAWk7c/1o53BCM1PyyGn+42hcYH6F2QFSnFBHCQcGGEYXpO
         K9Azy49K7qb8cHZmyN32AQOUQp1uGoJlkxhmfTSPZLJNKdlGjI0ma4lsKiWrgz5ZcB
         cbff6zzA7dkYDw3LvZtfwnlLcfDeBybZPBUzP4YIMPmb3GoFzUVJQ2jtXDrtOKEllQ
         +ppEBGBinskXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI Master controllers support configuring Least significant byte
first or Most significant byte first order for transfers. Also some SPI
slave devices expect bytes to be in Least significant first order and
some devices expect Most significant first order.

SPI driver declares mode and mode_bits as u16 and all bits are used.

This patch changes mode and mode_bits to be u32 to allow for more mode
configurations.

This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to
choose LSByte order or MSByte order through the device tree property
spi-lsbyte-first.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 5 ++++-
 include/linux/spi/spi.h | 7 ++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bd2a424672df..97ce047a776b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1638,6 +1638,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_3WIRE;
 	if (of_property_read_bool(nc, "spi-lsb-first"))
 		spi->mode |= SPI_LSB_FIRST;
+	if (of_property_read_bool(nc, "spi-lsbyte-first"))
+		spi->mode |= SPI_LSBYTE_FIRST;
 
 	/*
 	 * For descriptors associated with the device, polarity inversion is
@@ -2979,10 +2981,11 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
-	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
+	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
 			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
+			(spi->mode & SPI_LSBYTE_FIRST) ? "lsbyte, " : "",
 			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
 			(spi->mode & SPI_LOOP) ? "loopback, " : "",
 			spi->bits_per_word, spi->max_speed_hz,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a0975cf76cf6..d5c86b763f43 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -143,7 +143,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
-	u16			mode;
+	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -164,6 +164,7 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_LSBYTE_FIRST	0x10000		/* per-word bytes-on-wire */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
@@ -439,7 +440,7 @@ struct spi_controller {
 	u16			dma_alignment;
 
 	/* spi_device.mode flags understood by this controller driver */
-	u16			mode_bits;
+	u32			mode_bits;
 
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
@@ -1276,7 +1277,7 @@ struct spi_board_info {
 	/* mode becomes spi_device.mode, and is essential for chips
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
-	u16		mode;
+	u32		mode;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
-- 
2.7.4

