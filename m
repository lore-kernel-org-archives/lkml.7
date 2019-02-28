Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F12C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD9E20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfB1OBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:01:21 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:54989 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730687AbfB1OBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:01:21 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544454000"; 
   d="scan'208";a="8917342"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2019 23:01:19 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 11F11446E12D;
        Thu, 28 Feb 2019 23:01:16 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v5 2/2] i2c: designware: Add support for an interface clock
Date:   Thu, 28 Feb 2019 13:52:10 +0000
Message-Id: <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Synopsys I2C Controller has an interface clock, but most SoCs hide
this away. However, on some SoCs you need to explicitly enable the
interface clock in order to access the registers. Therefore, add 
support for an optional interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5:
 - Updated comments to reference "interface clock" instead of
   "peripheral clock".
 - Corrected spelling in commit message, changing "explicity" to
   "explicitly".
v4:
 - Updated comments to reference "peripheral clock"
   instead of "bus clock".
 - Added Wolfram's Acked-by
v3:
 - busclk renamed to pclk.
 - Added comment with dw_i2c_dev struct definition describing pclk.
 - Added enable rollback of first clock if second fails to enable.
v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.
---
 drivers/i2c/busses/i2c-designware-common.c  | 18 ++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h    |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c |  5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a473011..2de7452 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -251,13 +251,27 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 
 int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 {
+	int ret;
+
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
-	if (prepare)
-		return clk_prepare_enable(dev->clk);
+	if (prepare) {
+		/* Optional interface clock */
+		ret = clk_prepare_enable(dev->pclk);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(dev->clk);
+		if (ret)
+			clk_disable_unprepare(dev->pclk);
+
+		return ret;
+	}
 
 	clk_disable_unprepare(dev->clk);
+	clk_disable_unprepare(dev->pclk);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b4a0b2b..e88c711 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -177,6 +177,7 @@
  * @base: IO registers pointer
  * @cmd_complete: tx completion indicator
  * @clk: input reference clock
+ * @pclk: clock required to access the registers
  * @slave: represent an I2C slave device
  * @cmd_err: run time hadware error code
  * @msgs: points to an array of messages currently being transferred
@@ -226,6 +227,7 @@ struct dw_i2c_dev {
 	void __iomem		*ext;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct clk		*pclk;
 	struct reset_control	*rst;
 	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9eaac3b..97129f5 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -346,6 +346,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		i2c_dw_configure_master(dev);
 
+	/* Optional interface clock */
+	dev->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(dev->pclk))
+		return PTR_ERR(dev->pclk);
+
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_prepare_clk(dev, true)) {
 		u64 clk_khz;
-- 
2.7.4

