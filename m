Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC50C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AC92070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HSB3T242"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfDOVax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:30:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16525 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfDOVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f80e0000>; Mon, 15 Apr 2019 14:30:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:30:49 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f8060002>; Mon, 15 Apr 2019 14:30:48 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Date:   Mon, 15 Apr 2019 14:30:28 -0700
Message-ID: <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363854; bh=PA+MUP4wtIjTbicCMD+SI9ZPZygFzrJAP89JsXk9240=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=HSB3T242lt8CnIDGANDbLJYJPFMnZKRD3ZkK8ato4ckUZM442od6lR27mtg2z/mm3
         Ag36IM9YeHQYEaemfTCaZKbTM3bkN0IAFZdo4ETb2HsedDVUMGYNdiSBFZTYoSPVh2
         o0gWvIt1qovIvvsNnTilculcqq1UdpqBFFuttNKSrQabL+8yV98QZC3+K3L2e0uWHD
         PkcINDuWxQnvvXI9hwX9mGQjeNwRjqDipYC7qlpFENkPn+wWOp71GsGdBwW44Jjot8
         MQf7MA48Diu3YBfOcXt4GQRMcHgqfdEr9HGn6kr8BzMMEnvsSggNpHF1Ltuj7bOWzE
         7k63bkffSHNCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI slaves expect bytes to be in least significant first order
and some expects most significant first oder.

This patch adds support for requesting SPI master controllers for
least significant first order using SPI_LSBYTE_FIRST mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 18 ++++++++++--------
 include/linux/spi/spi.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bf4027b54a19..59b1e57cae74 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2982,14 +2982,16 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
-	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
-			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
-			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
-			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
-			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
-			(spi->mode & SPI_LOOP) ? "loopback, " : "",
-			spi->bits_per_word, spi->max_speed_hz,
-			status);
+	dev_dbg(&spi->dev,
+		"setup mode %d, %s%s%s%s%s%u bits/w, %u Hz max --> %d\n",
+		(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
+		(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
+		(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
+		(spi->mode & SPI_LSBYTE_FIRST) ? "lsbyte, " : "",
+		(spi->mode & SPI_3WIRE) ? "3wire, " : "",
+		(spi->mode & SPI_LOOP) ? "loopback, " : "",
+		spi->bits_per_word, spi->max_speed_hz,
+		status);
 
 	return status;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..fc4d21b4c2e4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -164,6 +164,7 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_LSBYTE_FIRST	0x10000		/* per-word bytes-on-wire */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.7.4

