Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3011C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14A42089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfIMMNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:13:05 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:46470 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729760AbfIMMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:13:04 -0400
X-IronPort-AV: E=Sophos;i="5.64,501,1559487600"; 
   d="scan'208";a="26313271"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2019 21:13:03 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 04D1D4001DDD;
        Fri, 13 Sep 2019 21:13:01 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 3/3] spi: dw: Add compatible string for Renesas RZ/N1 SPI  Controller
Date:   Fri, 13 Sep 2019 13:12:00 +0100
Message-Id: <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
additional registers for software CS control and DMA. This patch does not
address the changes required for DMA support, it simply adds the compatible
string. The CS registers are not needed as Linux can use gpios for the CS
signals.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index edb3cf6..3640b01 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -225,6 +225,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
+	{ .compatible = "renesas,rzn1-spi", },
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.7.4

