Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B208C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60650214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742257;
	bh=pHC/AwkjOPNisFX3IuXHq91c+27lrqDTnL/1cap6HOM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OMNvv7qBYZZmvB9eqxOnVjE4aM8PCLbAlHWKw/j8Xui3/07et+7+r3Ts1OIhKKdqC
	 1VfWWflVx9t1LLeTVxMzhuIDjZ6hPN9o3u97eMhqhRgLIbUjlWagHot0t5ksjUow5d
	 zmxz6Dx+B83XlnhUNx/+CgCtpxPKfDcrRUMayZ9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfDHQu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfDHQu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:50:56 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8948920880;
        Mon,  8 Apr 2019 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554742255;
        bh=pHC/AwkjOPNisFX3IuXHq91c+27lrqDTnL/1cap6HOM=;
        h=From:To:Cc:Subject:Date:From;
        b=u6EglcSfxklpNii9D2siCrz7B03R9a17JmwVO8588RS+J5z8n3sD7lfv5YaY8OJI5
         uYlcBNXiSQAs7ctD3DyJ/SxrtqFPiONqOYwGNKyVOILXUi4zNc5AgfG3KdHQyFI2Ab
         rkSsjxxkdNpPj+fDbQig15bUNzMG9zeApmcpQUos=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        Tien-Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: add reset control
Date:   Mon,  8 Apr 2019 11:50:46 -0500
Message-Id: <20190408165046.24310-1-dinguyen@kernel.org>
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
 drivers/mtd/spi-nor/cadence-quadspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 792628750eec..710a853f9d13 100644
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
@@ -1362,6 +1364,14 @@ static int cqspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cqspi->clk);
 	}
 
+	/* Obtain QSPI reset control */
+	rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (!IS_ERR(rstc)) {
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

