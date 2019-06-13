Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B01C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ACA206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560439697;
	bh=6q1tqBslR+sX7EAq/FGHs6zAAfTzWJiVITsie12E7aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmtUdK/I87iadwlwtVeZARButSmQ9P0HixNbUAfbQsEb4r/TZY7rsq/uJOav8Vp1H
	 md07YU3tguGZz1QAI4tmfyK49dBKfITcqrYUSs5VkWoUKAHDSK2KdXHMSjG8w0/3Py
	 wAbf+aFySq634AFIVl0m8i+Nw64kTxInF12aAblU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfFMP2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfFMLbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:31:52 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA0021744;
        Thu, 13 Jun 2019 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560425511;
        bh=6q1tqBslR+sX7EAq/FGHs6zAAfTzWJiVITsie12E7aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVqEZP7zVN8vi0rnG4J3KdIgslLIgqRFaEkEMPZj+RTGUdpX20bOvF7+zQ0p3ucrM
         VizKk/IhCCXBoIbP3uDIY94pJ7Xb6bwjOXpMopeympnhgu5yGY4TXo7IUBiAuzFU7N
         LxXPFwtu9ywkXzxGBjy6MvL5FzOvm+KePoqoUE28=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        Tien-Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCHv6 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Date:   Thu, 13 Jun 2019 06:31:38 -0500
Message-Id: <20190613113138.8280-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190613113138.8280-1-dinguyen@kernel.org>
References: <20190613113138.8280-1-dinguyen@kernel.org>
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

The reason this patch is needed is in the case where a bootloader leaves
the QSPI controller in a reset state, or a state where init cannot occur
successfully, the patch will put the QSPI controller into a clean state.

[1] https://www.intel.com/content/www/us/en/programmable/hps/arria-10/hps.html#reg_soc_top/sfo1429890575955.html

Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v6: no need to check for reset pointer in assert/deassert as the call to
    assert/deassert is already doing the checking
v5: remove udelay(not needed) on tested hardware
    group reset assert/deassert together
    update commit message with reasoning for patch
v4: fix compile error
v3: return full error by using PTR_ERR(rtsc)
    move reset control calls until after the clock enables
    use udelay(2) to be safe
    Add optional OCP(Open Core Protocol) reset signal
v2: use devm_reset_control_get_optional_exclusive
    print an error message
    return -EPROBE_DEFER
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 792628750eec..732323c2adb1 100644
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
@@ -1402,6 +1405,25 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_clk_failed;
 	}
 
+	/* Obtain QSPI reset control */
+	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
+	if (IS_ERR(rstc)) {
+		dev_err(dev, "Cannot get QSPI reset.\n");
+		return PTR_ERR(rstc);
+	}
+
+	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
+	if (IS_ERR(rstc_ocp)) {
+		dev_err(dev, "Cannot get QSPI OCP reset.\n");
+		return PTR_ERR(rstc_ocp);
+	}
+
+	reset_control_assert(rstc);
+	reset_control_deassert(rstc);
+
+	reset_control_assert(rstc_ocp);
+	reset_control_deassert(rstc_ocp);
+
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
 	ddata  = of_device_get_match_data(dev);
 	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
-- 
2.20.0

