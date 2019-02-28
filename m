Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B11C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0E4205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfB1N2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:28:34 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:4267 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731830AbfB1N2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:28:34 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544454000"; 
   d="scan'208";a="9122354"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2019 22:28:31 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9295343DA3C6;
        Thu, 28 Feb 2019 22:28:30 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 2/2] spi: dw: Add support for an optional interface clock
Date:   Thu, 28 Feb 2019 13:25:42 +0000
Message-Id: <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Synopsys SSI Controller has an interface clock, but most SoCs hide 
this away. However, on some SoCs you need to explicity enable the 
interface clock in order to access the registers. Therefore, add 
support for an optional interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 drivers/spi/spi-dw-mmio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 4bd59a9..7cbc173 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -30,6 +30,7 @@
 struct dw_spi_mmio {
 	struct dw_spi  dws;
 	struct clk     *clk;
+	struct clk     *pclk;
 	void           *priv;
 };
 
@@ -172,6 +173,14 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Optional interface clock */
+	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(dwsmmio->pclk))
+		return PTR_ERR(dwsmmio->pclk);
+	ret = clk_prepare_enable(dwsmmio->pclk);
+	if (ret)
+		goto out_clk;
+
 	dws->bus_num = pdev->id;
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
@@ -199,6 +208,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	clk_disable_unprepare(dwsmmio->pclk);
+out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
 	return ret;
 }
@@ -208,6 +219,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
-- 
2.7.4

