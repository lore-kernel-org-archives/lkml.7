Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE18C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208812147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ykIO1E7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfHFFKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:10:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40662 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFFKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:10:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x765AHx1118747;
        Tue, 6 Aug 2019 00:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565068217;
        bh=JJ1RbmDPwbuN+rWHpmRdsTlmQ6XEPByVD/QHcprtOoo=;
        h=From:To:CC:Subject:Date;
        b=ykIO1E7kPAN/NhewSX+KZnUYk1cOPMimB+5bxCNaiwxikaWMkdWUOeSK/si9satP/
         4u4Ajp2c5PzDzWCZjtAOXq7O2lGbFxcTOpYBSeHZxHoLysMGwrkEVNGUNul0mMQSwL
         +Y5A9ocRWvUD+YtMaiPuGFrOXA3U3BQ12OErAHcc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x765AH4f114354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Aug 2019 00:10:17 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 6 Aug
 2019 00:10:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 6 Aug 2019 00:10:16 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x765ADXv009009;
        Tue, 6 Aug 2019 00:10:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 0/3] Merge m25p80 into spi-nor
Date:   Tue, 6 Aug 2019 10:40:38 +0530
Message-ID: <20190806051041.3636-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is repost of patch 6 and 7 split from from Boris Brezillon's X-X-X
mode support series[1]

Background from cover letter for RFC[1]:
m25p80 is just a simple SPI NOR controller driver (a wrapper around the
SPI mem API). Not only it shouldn't be named after a specific SPI NOR
chip, but it also doesn't deserve a specific driver IMO, especially if
the end goal is to get rid of SPI NOR controller drivers found in
drivers/mtd/spi-nor/ and replace them by SPI mem drivers (which would
be placed in drivers/spi/). With this solution, we declare the SPI NOR
driver as a spi_mem_driver, just like the SPI NAND layer is declared as
a spi_mem driver (patch 1/2).
This solution also allows us to check at a fined-grain level (thanks to
the spi_mem_supports_op() function) which operations are supported and
which ones are not, while the original m25p80 logic was basing this
decision on the SPI_{RX,TX}_{DUAL,QUAD,OCTO} flags only (patch 2/2).

[1] https://patchwork.ozlabs.org/cover/982926/

Tested on TI' DRA7xx EVM with TI QSPI controller (a spi-mem driver) with
DMA (s25fl256 and mx66l51235l) flash. I don't see any performance
regression due to bounce buffer copy introduced by this series
Also tested with cadence-quadspi (a spi-nor driver) driver

Boris Brezillon (2):
  mtd: spi-nor: Move m25p80 code in spi-nor.c
  mtd: spi-nor: Rework hwcaps selection for the spi-mem case

Vignesh Raghavendra (1):
  mtd: spi-nor: always use bounce buffer for register read/writes

 drivers/mtd/devices/Kconfig   |  18 -
 drivers/mtd/devices/Makefile  |   1 -
 drivers/mtd/devices/m25p80.c  | 347 ---------------
 drivers/mtd/spi-nor/Kconfig   |   2 +
 drivers/mtd/spi-nor/spi-nor.c | 814 +++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  24 +-
 6 files changed, 777 insertions(+), 429 deletions(-)
 delete mode 100644 drivers/mtd/devices/m25p80.c

-- 
2.22.0

