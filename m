Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F183C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFF12176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfLRUuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:50:18 -0500
Received: from mail.windriver.com ([147.11.1.11]:47790 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:17 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iW000214;
        Wed, 18 Dec 2019 12:49:09 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Haojian Zhuang <haojian.zhuang@marvell.com>
Subject: [PATCH 04/18] mfd: 88pm860x-*: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:43 -0500
Message-Id: <1576702137-25905-5-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig/Makefile currently controlling compilation of this code is:

drivers/mfd/Makefile:88pm860x-objs := 88pm860x-core.o 88pm860x-i2c.o
drivers/mfd/Makefile:obj-$(CONFIG_MFD_88PM860X) += 88pm860x.o

drivers/mfd/Kconfig:config MFD_88PM860X
drivers/mfd/Kconfig:    bool "Marvell 88PM8606/88PM8607"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

In the case of 88pm860x-i2c.c, there is nothing modular whatsoever,
so we simply remove module.h itself.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/88pm860x-core.c | 40 ++--------------------------------------
 drivers/mfd/88pm860x-i2c.c  |  1 -
 2 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index c9bae71f643a..741012a7a6e1 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
@@ -643,12 +643,6 @@ static int device_irq_init(struct pm860x_chip *chip,
 	return ret;
 }
 
-static void device_irq_exit(struct pm860x_chip *chip)
-{
-	if (chip->core_irq)
-		free_irq(chip->core_irq, chip);
-}
-
 int pm8606_osc_enable(struct pm860x_chip *chip, unsigned short client)
 {
 	int ret = -EIO;
@@ -1079,12 +1073,6 @@ static int pm860x_device_init(struct pm860x_chip *chip,
 	return 0;
 }
 
-static void pm860x_device_exit(struct pm860x_chip *chip)
-{
-	device_irq_exit(chip);
-	mfd_remove_devices(chip->dev);
-}
-
 static int verify_addr(struct i2c_client *i2c)
 {
 	unsigned short addr_8607[] = {0x30, 0x34};
@@ -1201,18 +1189,6 @@ static int pm860x_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int pm860x_remove(struct i2c_client *client)
-{
-	struct pm860x_chip *chip = i2c_get_clientdata(client);
-
-	pm860x_device_exit(chip);
-	if (chip->companion) {
-		regmap_exit(chip->regmap_companion);
-		i2c_unregister_device(chip->companion);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int pm860x_suspend(struct device *dev)
 {
@@ -1241,22 +1217,20 @@ static const struct i2c_device_id pm860x_id_table[] = {
 	{ "88PM860x", 0 },
 	{}
 };
-MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
 
 static const struct of_device_id pm860x_dt_ids[] = {
 	{ .compatible = "marvell,88pm860x", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, pm860x_dt_ids);
 
 static struct i2c_driver pm860x_driver = {
 	.driver	= {
 		.name	= "88PM860x",
 		.pm     = &pm860x_pm_ops,
 		.of_match_table	= pm860x_dt_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe_new	= pm860x_probe,
-	.remove		= pm860x_remove,
 	.id_table	= pm860x_id_table,
 };
 
@@ -1270,13 +1244,3 @@ static int __init pm860x_i2c_init(void)
 	return ret;
 }
 subsys_initcall(pm860x_i2c_init);
-
-static void __exit pm860x_i2c_exit(void)
-{
-	i2c_del_driver(&pm860x_driver);
-}
-module_exit(pm860x_i2c_exit);
-
-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM860x");
-MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index a000aed35755..986c8c774871 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -7,7 +7,6 @@
  * Author: Haojian Zhuang <haojian.zhuang@marvell.com>
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/mfd/88pm860x.h>
-- 
2.7.4

