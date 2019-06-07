Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0DC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9AB20657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="By726Rt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfFGP5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:57:44 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:46904 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729961AbfFGPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:43:36 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0448BC5859;
        Fri,  7 Jun 2019 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559922215; bh=0lEPE/omdBqnj239oGGM+RMVir+ROFSBHtl3mcsX8h4=;
        h=From:To:Cc:Subject:Date:From;
        b=By726Rt7GGoItd7VLH3TBczHPVhVpeILAw1YpJ4M3MQvag4phbfn5xr0LFy6t5X2a
         +QHT35L7b8z+XR/QkNLac6pNfuzVv0z8uWcy23Ymd0TzpFn17a8THB/fh5sC4Pu1qW
         UAKxZGZjB8ZmnSXXvae7Ug6uw/m79q5H9omwDTpzQXGCyKx/9mzOF080RjfNa6ubqM
         yGU5y1NV3MGMokfvHraPa7myWHXntpVK1g31huj07OfGhoFrpwCJWTKxW6Adx6Kgzd
         w+vRWqICzpUcVteMmSrGLt99f2JPmsZ2/GxyiaQfV7mxpSazQa+uAxFc/F0nZkqCJc
         hy8ps+XwlfyoQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.20])
        by mailhost.synopsys.com (Postfix) with ESMTP id A3946A022E;
        Fri,  7 Jun 2019 15:43:29 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-mtd@lists.infradead.org, Marek Vasut <marex@denx.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032 memory
Date:   Fri,  7 Jun 2019 18:43:08 +0300
Message-Id: <20190607154308.20899-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the SST sst26wf016 and sst26wf032
flash memory IC.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 73172d7f512b..224275461a2c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1945,6 +1945,8 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
+	{ "sst26wf016",  INFO(0xbf2651, 0, 64 * 1024, 32, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "sst26wf032",  INFO(0xbf2622, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
 	/* ST Microelectronics -- newer production may have feature updates */
-- 
2.21.0

