Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4965C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B22084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDCMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:41:09 -0400
Received: from sauhun.de ([88.99.104.3]:48410 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfDCMkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:40:42 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id 81A513E43D1;
        Wed,  3 Apr 2019 14:40:40 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 11/12] i2c: algo: bit: add flag to whitelist atomic transfers
Date:   Wed,  3 Apr 2019 14:40:18 +0200
Message-Id: <20190403124019.8947-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new xfer_atomic callback to check a newly introduced flag to
whitelist atomic transfers. This will report configurations which
worked accidently.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/algos/i2c-algo-bit.c | 22 ++++++++++++++++++++--
 include/linux/i2c-algo-bit.h     |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 5e5990a83da5..913db013fe90 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -603,6 +603,23 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 	return ret;
 }
 
+/*
+ * We print a warning when we are not flagged to support atomic transfers but
+ * will try anyhow. That's what the I2C core would do as well. Sadly, we can't
+ * modify the algorithm struct at probe time because this struct is exported
+ * 'const'.
+ */
+static int bit_xfer_atomic(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
+			   int num)
+{
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+
+	if (!adap->can_do_atomic)
+		dev_warn(&i2c_adap->dev, "not flagged for atomic transfers\n");
+
+	return bit_xfer(i2c_adap, msgs, num);
+}
+
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
@@ -615,8 +632,9 @@ static u32 bit_func(struct i2c_adapter *adap)
 /* -----exported algorithm data: -------------------------------------	*/
 
 const struct i2c_algorithm i2c_bit_algo = {
-	.master_xfer	= bit_xfer,
-	.functionality	= bit_func,
+	.master_xfer = bit_xfer,
+	.master_xfer_atomic = bit_xfer_atomic,
+	.functionality = bit_func,
 };
 EXPORT_SYMBOL(i2c_bit_algo);
 
diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index 69045df78e2d..7fd5575a368f 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -33,6 +33,7 @@ struct i2c_algo_bit_data {
 				   minimum 5 us for standard-mode I2C and SMBus,
 				   maximum 50 us for SMBus */
 	int timeout;		/* in jiffies */
+	bool can_do_atomic;	/* callbacks don't sleep, we can be atomic */
 };
 
 int i2c_bit_add_bus(struct i2c_adapter *);
-- 
2.11.0

