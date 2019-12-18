Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F45C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6952176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfLRUt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:26 -0500
Received: from mail.windriver.com ([147.11.1.11]:47819 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:22 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iT000214;
        Wed, 18 Dec 2019 12:49:07 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 01/18] mfd: stmpe-spi: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:40 -0500
Message-Id: <1576702137-25905-2-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/mfd/Kconfig:config STMPE_SPI
drivers/mfd/Kconfig:    bool "STMicroelectronics STMPE SPI Interface"

The Kconfig currently controlling compilation of this code is:

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/stmpe-spi.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 7351734f7593..3f6471e7301a 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -10,7 +10,7 @@
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/types.h>
 #include "stmpe.h"
@@ -102,13 +102,6 @@ stmpe_spi_probe(struct spi_device *spi)
 	return stmpe_probe(&spi_ci, id->driver_data);
 }
 
-static int stmpe_spi_remove(struct spi_device *spi)
-{
-	struct stmpe *stmpe = spi_get_drvdata(spi);
-
-	return stmpe_remove(stmpe);
-}
-
 static const struct of_device_id stmpe_spi_of_match[] = {
 	{ .compatible = "st,stmpe610", },
 	{ .compatible = "st,stmpe801", },
@@ -118,7 +111,6 @@ static const struct of_device_id stmpe_spi_of_match[] = {
 	{ .compatible = "st,stmpe2403", },
 	{ /* sentinel */ },
 };
-MODULE_DEVICE_TABLE(of, stmpe_spi_of_match);
 
 static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe610", STMPE610 },
@@ -129,18 +121,17 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
 		.name	= "stmpe-spi",
 		.of_match_table = of_match_ptr(stmpe_spi_of_match),
+		.suppress_bind_attrs = true,
 #ifdef CONFIG_PM
 		.pm	= &stmpe_dev_pm_ops,
 #endif
 	},
 	.probe		= stmpe_spi_probe,
-	.remove		= stmpe_spi_remove,
 	.id_table	= stmpe_spi_id,
 };
 
@@ -149,13 +140,3 @@ static int __init stmpe_init(void)
 	return spi_register_driver(&stmpe_spi_driver);
 }
 subsys_initcall(stmpe_init);
-
-static void __exit stmpe_exit(void)
-{
-	spi_unregister_driver(&stmpe_spi_driver);
-}
-module_exit(stmpe_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("STMPE MFD SPI Interface Driver");
-MODULE_AUTHOR("Viresh Kumar <vireshk@kernel.org>");
-- 
2.7.4

