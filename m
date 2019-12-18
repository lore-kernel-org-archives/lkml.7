Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3EC2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfLRUtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:53 -0500
Received: from mail.windriver.com ([147.11.1.11]:47820 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLRUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:22 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iU000214;
        Wed, 18 Dec 2019 12:49:08 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 02/18] mfd: stmpe-i2c: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:41 -0500
Message-Id: <1576702137-25905-3-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config STMPE_I2C
drivers/mfd/Kconfig:    bool "STMicroelectronics STMPE I2C Interface"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.  In
doing so stmpe_remove itself becomes orphaned, so it gets removed too.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.  As this makes stmpe_remove an orphaned
function, it gets removed too.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/stmpe-i2c.c | 23 ++---------------------
 drivers/mfd/stmpe.c     | 14 --------------
 drivers/mfd/stmpe.h     |  1 -
 3 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 61aa020199f5..9d3e9443225a 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -12,7 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/of_device.h>
 #include "stmpe.h"
@@ -64,7 +64,6 @@ static const struct of_device_id stmpe_of_match[] = {
 	{ .compatible = "st,stmpe2403", .data = (void *)STMPE2403, },
 	{},
 };
-MODULE_DEVICE_TABLE(of, stmpe_of_match);
 
 static int
 stmpe_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
@@ -91,13 +90,6 @@ stmpe_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	return stmpe_probe(&i2c_ci, partnum);
 }
 
-static int stmpe_i2c_remove(struct i2c_client *i2c)
-{
-	struct stmpe *stmpe = dev_get_drvdata(&i2c->dev);
-
-	return stmpe_remove(stmpe);
-}
-
 static const struct i2c_device_id stmpe_i2c_id[] = {
 	{ "stmpe610", STMPE610 },
 	{ "stmpe801", STMPE801 },
@@ -109,7 +101,6 @@ static const struct i2c_device_id stmpe_i2c_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, stmpe_id);
 
 static struct i2c_driver stmpe_i2c_driver = {
 	.driver = {
@@ -118,9 +109,9 @@ static struct i2c_driver stmpe_i2c_driver = {
 		.pm = &stmpe_dev_pm_ops,
 #endif
 		.of_match_table = stmpe_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= stmpe_i2c_probe,
-	.remove		= stmpe_i2c_remove,
 	.id_table	= stmpe_i2c_id,
 };
 
@@ -129,13 +120,3 @@ static int __init stmpe_init(void)
 	return i2c_add_driver(&stmpe_i2c_driver);
 }
 subsys_initcall(stmpe_init);
-
-static void __exit stmpe_exit(void)
-{
-	i2c_del_driver(&stmpe_i2c_driver);
-}
-module_exit(stmpe_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
-MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 1aee3b3253fc..611f1d8243b9 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1492,20 +1492,6 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 	return ret;
 }
 
-int stmpe_remove(struct stmpe *stmpe)
-{
-	if (!IS_ERR(stmpe->vio))
-		regulator_disable(stmpe->vio);
-	if (!IS_ERR(stmpe->vcc))
-		regulator_disable(stmpe->vcc);
-
-	__stmpe_disable(stmpe, STMPE_BLOCK_ADC);
-
-	mfd_remove_devices(stmpe->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int stmpe_suspend(struct device *dev)
 {
diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
index 83491e99ba3c..ba9006b7f8f4 100644
--- a/drivers/mfd/stmpe.h
+++ b/drivers/mfd/stmpe.h
@@ -98,7 +98,6 @@ struct stmpe_client_info {
 };
 
 int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum);
-int stmpe_remove(struct stmpe *stmpe);
 
 #define STMPE_ICR_LSB_HIGH	(1 << 2)
 #define STMPE_ICR_LSB_EDGE	(1 << 1)
-- 
2.7.4

