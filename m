Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D55C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDCMlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:41:15 -0400
Received: from sauhun.de ([88.99.104.3]:48388 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfDCMkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:40:41 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id D6AAD3E43CF;
        Wed,  3 Apr 2019 14:40:38 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 08/12] i2c: ocores: refactor setup for polling
Date:   Wed,  3 Apr 2019 14:40:15 +0200
Message-Id: <20190403124019.8947-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By properly setting up the algorithm at probe time, we can skip the
check at every transfer. This allows us to get rid of the flags
completely.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 4e1a077fb688..1b99f467aae0 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -26,8 +26,6 @@
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
 
-#define OCORES_FLAG_POLL BIT(0)
-
 /*
  * 'process_lock' exists because ocores_process() and ocores_process_timeout()
  * can't run in parallel.
@@ -37,7 +35,6 @@ struct ocores_i2c {
 	int iobase;
 	u32 reg_shift;
 	u32 reg_io_width;
-	unsigned long flags;
 	wait_queue_head_t wait;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
@@ -403,11 +400,7 @@ static int ocores_xfer_polling(struct i2c_adapter *adap,
 static int ocores_xfer(struct i2c_adapter *adap,
 		       struct i2c_msg *msgs, int num)
 {
-	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
-
-	if (i2c->flags & OCORES_FLAG_POLL)
-		return ocores_xfer_polling(adap, msgs, num);
-	return ocores_xfer_core(i2c, msgs, num, false);
+	return ocores_xfer_core(i2c_get_adapdata(adap), msgs, num, false);
 }
 
 static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
@@ -447,7 +440,7 @@ static u32 ocores_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static const struct i2c_algorithm ocores_algorithm = {
+static struct i2c_algorithm ocores_algorithm = {
 	.master_xfer = ocores_xfer,
 	.functionality = ocores_func,
 };
@@ -673,13 +666,13 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq == -ENXIO) {
-		i2c->flags |= OCORES_FLAG_POLL;
+		ocores_algorithm.master_xfer = ocores_xfer_polling;
 	} else {
 		if (irq < 0)
 			return irq;
 	}
 
-	if (!(i2c->flags & OCORES_FLAG_POLL)) {
+	if (ocores_algorithm.master_xfer != ocores_xfer_polling) {
 		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
 				       pdev->name, i2c);
 		if (ret) {
-- 
2.11.0

