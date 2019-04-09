Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A492C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE55C2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hgnS7Qni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDIQ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:29:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51412 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDIQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:29:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x39GSZxw005270;
        Tue, 9 Apr 2019 11:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554827315;
        bh=DJvc0ge537nCBJBODwdpAZCOezSwUbOSr8t29iAXJhs=;
        h=From:To:CC:Subject:Date;
        b=hgnS7QniUkwvqIfalT5ca6HJwiXm1HGKuI8Viu1jnWxVB2Kpi60LRzOxTSX5lgFt4
         HLie9eQT07DOgtCS0FgB5iu87g1FhhAdfZhWNfIeQAR+d3vKKF9+U1z8S6Ds5uz4Pd
         1hR3DjtjmvfN7t/A5rmWIsAdUsDudGMxnwk204Ck=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x39GSZB0097637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 11:28:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 11:28:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 11:28:35 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x39GSVQC128531;
        Tue, 9 Apr 2019 11:28:32 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH 0/2] Merge m25p80 into spi-nor
Date:   Tue, 9 Apr 2019 21:56:49 +0530
Message-ID: <20190409162651.24593-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
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
DMA (s25fl256) flash. I don't see any performance regression due to
bounce buffer copy introduced by this series

Boris Brezillon (2):
  mtd: spi-nor: Move m25p80 code in spi-nor.c
  mtd: spi-nor: Rework hwcaps selection for the spi-mem case

 drivers/mtd/devices/Kconfig   |  18 -
 drivers/mtd/devices/Makefile  |   1 -
 drivers/mtd/devices/m25p80.c  | 351 ----------------
 drivers/mtd/spi-nor/Kconfig   |   2 +
 drivers/mtd/spi-nor/spi-nor.c | 771 ++++++++++++++++++++++++++++++++--
 include/linux/mtd/spi-nor.h   |  22 +
 6 files changed, 759 insertions(+), 406 deletions(-)
 delete mode 100644 drivers/mtd/devices/m25p80.c

-- 
2.21.0

