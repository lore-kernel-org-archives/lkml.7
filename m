Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92ADC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957812176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfLRUtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:50 -0500
Received: from mail.windriver.com ([147.11.1.11]:47877 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfLRUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:25 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0ik000214;
        Wed, 18 Dec 2019 12:49:19 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Yang@mail.windriver.com, Bin <bin.yang@intel.com>,
        Zhu@mail.windriver.com, Lejun <lejun.zhu@linux.intel.com>
Subject: [PATCH 18/18] mfd: intel_soc_pmic_core: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:57 -0500
Message-Id: <1576702137-25905-19-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile/Kconfig currently controlling compilation of this code is:

drivers/mfd/Makefile:intel-soc-pmic-objs := intel_soc_pmic_core.o intel_soc_pmic_crc.o
drivers/mfd/Makefile:obj-$(CONFIG_INTEL_SOC_PMIC)       += intel-soc-pmic.o
drivers/mfd/Kconfig:config INTEL_SOC_PMIC
drivers/mfd/Kconfig:    bool "Support for Intel Atom SoC PMIC"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_i2c_driver() uses the same init level priority as
builtin_i2c_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Yang, Bin <bin.yang@intel.com>
Cc: Zhu, Lejun <lejun.zhu@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/intel_soc_pmic_core.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index c9f35378d391..33d1a658e25f 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -13,7 +13,7 @@
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/pwm.h>
@@ -115,23 +115,6 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
-{
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
-
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-
-	/* Remove lookup table for Panel Control from the GPIO Chip */
-	gpiod_remove_lookup_table(&panel_gpio_table);
-
-	/* remove crc-pwm lookup table */
-	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
-
-	mfd_remove_devices(&i2c->dev);
-
-	return 0;
-}
-
 static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
@@ -167,14 +150,12 @@ static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
 static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
 
 #if defined(CONFIG_ACPI)
 static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
 	{ "INT33FD" },
 	{ },
 };
-MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
 #endif
 
 static struct i2c_driver intel_soc_pmic_i2c_driver = {
@@ -182,16 +163,10 @@ static struct i2c_driver intel_soc_pmic_i2c_driver = {
 		.name = "intel_soc_pmic_i2c",
 		.pm = &intel_soc_pmic_pm_ops,
 		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = intel_soc_pmic_i2c_probe,
-	.remove = intel_soc_pmic_i2c_remove,
 	.id_table = intel_soc_pmic_i2c_id,
 	.shutdown = intel_soc_pmic_shutdown,
 };
-
-module_i2c_driver(intel_soc_pmic_i2c_driver);
-
-MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
-MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
+builtin_i2c_driver(intel_soc_pmic_i2c_driver);
-- 
2.7.4

