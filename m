Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A9C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C050C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557278266;
	bh=9OMkv/ZBdEnfIAJyqAaLM6xgw/CpTOvjzlJKxqG6Npg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fja1EPJfJe7JPUUKo3ARqcuy8gwpf4oT5YPyYG0R5OAg/pFcoCfLT801IIVg3ggX+
	 cBmoEOoEaJBOz3pVJiCvav4ZLJSJqFS2INJbFUG4i2jvnakkinfy1QrISaya4Gvvhz
	 AzGlA2l/waHcgWwgi3I/u44dGiEgtXiUrFHBRAEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEHBRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHBRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:17:45 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5441A214AE;
        Wed,  8 May 2019 01:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557278264;
        bh=9OMkv/ZBdEnfIAJyqAaLM6xgw/CpTOvjzlJKxqG6Npg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1/k8yxJeLIWkHyCyt8GULnSmNAh4JE7k0/scyOt2AL7LIe2RAWWMcTOwzVRz/YWr
         hTzSRMeSVMDs5KTV2QOnAE3A+4aalKjX7N2rHLwtIW3+UAD+yQOZ4n0q4LckvcbA6S
         Qm2/pixaiE2YFEq1yZvZCB8MBs1amzUuOcuRIXj4=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tien-Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCHv3 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Date:   Tue,  7 May 2019 20:17:34 -0500
Message-Id: <20190508011734.14966-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190508011734.14966-1-dinguyen@kernel.org>
References: <20190508011734.14966-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the reset control properties for the QSPI controller and bring them
out of reset. Most will have just one reset bit, but there is an additional
OCP reset bit that is used ECC. The OCP reset bit will also need to get
de-asserted as well. [1]

[1] https://www.intel.com/content/www/us/en/programmable/hps/arria-10/hps.html#reg_soc_top/sfo1429890575955.html

Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: return full error by using PTR_ERR(rtsc)
    move reset control calls until after the clock enables
    use udelay(2) to be safe
    Add optional OCP(Open Core Protocol) reset signal
v2: use devm_reset_control_get_optional_exclusive
    print an error message
    return -EPROBE_DEFER
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 792628750eec..b9f138767d9e 100644
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
@@ -1336,6 +1337,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	struct cqspi_st *cqspi;
 	struct resource *res;
 	struct resource *res_ahb;
+	struct reset_control *rstc;
+	struct reset_control *rstc_ocp;
 	const struct cqspi_driver_platdata *ddata;
 	int ret;
 	int irq;
@@ -1402,6 +1405,33 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_clk_failed;
 	}
 
+	/* Obtain QSPI reset control */
+	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
+	if (IS_ERR(rstc)) {
+		dev_err(dev, "Cannot get QSPI reset.\n");
+		if (PTR_ERR(rstc) == -EPROBE_DEFER)
+			return PTR_ERR(rstc);
+	}
+
+	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
+	if (IS_ERR(rstc_ocp)) {
+		dev_err(dev, "Cannot get QSPI OCP reset.\n");
+		if (PTR_ERR(rstc_ocp) == -EPROBE_DEFER)
+			return PTR_ERR(rstc_ocp);
+	}
+
+	if (rtsc) {
+		reset_control_assert(rstc);
+		udelay(2);
+		reset_control_deassert(rstc);
+	}
+
+	if (rtsc_ocp) {
+		reset_control_assert(rstc_ocp);
+		udelay(2);
+		reset_control_deassert(rstc_ocp);
+	}
+
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
 	ddata  = of_device_get_match_data(dev);
 	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
-- 
2.20.0

