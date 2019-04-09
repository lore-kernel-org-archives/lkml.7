Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E40C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAFD21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554824295;
	bh=n3oVS0RGbjjZsrRYWn3vaYYlmTt0k55e3PTjUh0A4Dg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XtBGtW4yT0mVdHDs1z6ryVtj0b4Eqi1GKhm8Uwe8y6IIrxBM84q7lfpHz0kulaaBP
	 noul0Oc/LomRfIxmtzNZ4qiKgQQmKkHHTrrx4cfUgPBdpTEv6Tc3Vg2f71XetXjSbw
	 AbbuO18Owwv9bSryjQIxgliX2r5Hl5/biVLhm9Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIPiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIPiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:38:13 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCF320883;
        Tue,  9 Apr 2019 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554824292;
        bh=n3oVS0RGbjjZsrRYWn3vaYYlmTt0k55e3PTjUh0A4Dg=;
        h=From:To:Cc:Subject:Date:From;
        b=lfILR6dYprpWXuEMrFtFDySwJdS/HYg1K5by6jxyCu2SKbpXdzElpUCTXq8cccvrX
         1DZ9MU8rYb1xMqZQGDHbz2IJ7X5258nEnzg8sAnxDzM/XvnKrgLaPsoScBomRAILbu
         FAnu6GQUIIqHQvrj1T2C7Yq62NRx55ebtm7I7/Z0=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, vigneshr@ti.com,
        linux-kernel@vger.kernel.org,
        Tien-Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCHv2] mtd: spi-nor: cadence-quadspi: add reset control
Date:   Tue,  9 Apr 2019 10:38:01 -0500
Message-Id: <20190409153801.6941-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the reset control for the QSPI controller and bring it out of reset.

Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: use devm_reset_control_get_optional_exclusive
    print an error message
    return -EPROBE_DEFER
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 792628750eec..c548567adcf0 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -34,6 +34,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/spi/spi.h>
 #include <linux/timer.h>
@@ -1336,6 +1337,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	struct cqspi_st *cqspi;
 	struct resource *res;
 	struct resource *res_ahb;
+	struct reset_control *rstc;
 	const struct cqspi_driver_platdata *ddata;
 	int ret;
 	int irq;
@@ -1362,6 +1364,18 @@ static int cqspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cqspi->clk);
 	}
 
+	/* Obtain QSPI reset control */
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc)) {
+		dev_err(dev, "Cannot get QSPI reset.\n");
+		if (PTR_ERR(rstc) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
+		reset_control_assert(rstc);
+		udelay(1);
+		reset_control_deassert(rstc);
+	}
+
 	/* Obtain and remap controller address. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cqspi->iobase = devm_ioremap_resource(dev, res);
-- 
2.20.0

