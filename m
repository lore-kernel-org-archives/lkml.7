Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36512176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLRUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:18 -0500
Received: from mail.windriver.com ([147.11.1.11]:47825 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfLRUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:17 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iZ000214;
        Wed, 18 Dec 2019 12:49:11 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ian Molton <spyro@f2s.com>
Subject: [PATCH 07/18] mfd: tc6393xb: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:46 -0500
Message-Id: <1576702137-25905-8-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_TC6393XB
drivers/mfd/Kconfig:    bool "Toshiba TC6393XB"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Ian Molton <spyro@f2s.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/tc6393xb.c | 43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 05d5059ca203..55f6ffb35e7f 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -12,7 +12,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
@@ -730,32 +730,6 @@ static int tc6393xb_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int tc6393xb_remove(struct platform_device *dev)
-{
-	struct tc6393xb_platform_data *tcpd = dev_get_platdata(&dev->dev);
-	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
-	int ret;
-
-	mfd_remove_devices(&dev->dev);
-
-	if (tcpd->teardown)
-		tcpd->teardown(dev);
-
-	tc6393xb_detach_irq(dev);
-
-	if (tc6393xb->gpio.base != -1)
-		gpiochip_remove(&tc6393xb->gpio);
-
-	ret = tcpd->disable(dev);
-	clk_disable_unprepare(tc6393xb->clk);
-	iounmap(tc6393xb->scr);
-	release_resource(&tc6393xb->rscr);
-	clk_put(tc6393xb->clk);
-	kfree(tc6393xb);
-
-	return ret;
-}
-
 #ifdef CONFIG_PM
 static int tc6393xb_suspend(struct platform_device *dev, pm_message_t state)
 {
@@ -826,12 +800,12 @@ static int tc6393xb_resume(struct platform_device *dev)
 
 static struct platform_driver tc6393xb_driver = {
 	.probe = tc6393xb_probe,
-	.remove = tc6393xb_remove,
 	.suspend = tc6393xb_suspend,
 	.resume = tc6393xb_resume,
 
 	.driver = {
 		.name = "tc6393xb",
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -839,17 +813,4 @@ static int __init tc6393xb_init(void)
 {
 	return platform_driver_register(&tc6393xb_driver);
 }
-
-static void __exit tc6393xb_exit(void)
-{
-	platform_driver_unregister(&tc6393xb_driver);
-}
-
 subsys_initcall(tc6393xb_init);
-module_exit(tc6393xb_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ian Molton, Dmitry Baryshkov and Dirk Opfer");
-MODULE_DESCRIPTION("tc6393xb Toshiba Mobile IO Controller");
-MODULE_ALIAS("platform:tc6393xb");
-
-- 
2.7.4

