Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE04C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87A2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfLRUuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:50:06 -0500
Received: from mail.windriver.com ([147.11.1.11]:47839 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfLRUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:19 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0id000214;
        Wed, 18 Dec 2019 12:49:14 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ian Molton <spyro@f2s.com>
Subject: [PATCH 11/18] mfd: t7l66xb: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:50 -0500
Message-Id: <1576702137-25905-12-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_T7L66XB
drivers/mfd/Kconfig:    bool "Toshiba T7L66XB"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Ian Molton <spyro@f2s.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/t7l66xb.c | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 70da0c4ae457..636b9c8dc96d 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -20,7 +20,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -403,42 +403,13 @@ static int t7l66xb_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int t7l66xb_remove(struct platform_device *dev)
-{
-	struct t7l66xb_platform_data *pdata = dev_get_platdata(&dev->dev);
-	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
-	int ret;
-
-	ret = pdata->disable(dev);
-	clk_disable_unprepare(t7l66xb->clk48m);
-	clk_put(t7l66xb->clk48m);
-	clk_disable_unprepare(t7l66xb->clk32k);
-	clk_put(t7l66xb->clk32k);
-	t7l66xb_detach_irq(dev);
-	iounmap(t7l66xb->scr);
-	release_resource(&t7l66xb->rscr);
-	mfd_remove_devices(&dev->dev);
-	kfree(t7l66xb);
-
-	return ret;
-
-}
-
 static struct platform_driver t7l66xb_platform_driver = {
 	.driver = {
-		.name	= "t7l66xb",
+		.name			= "t7l66xb",
+		.suppress_bind_attrs	= true,
 	},
 	.suspend	= t7l66xb_suspend,
 	.resume		= t7l66xb_resume,
 	.probe		= t7l66xb_probe,
-	.remove		= t7l66xb_remove,
 };
-
-/*--------------------------------------------------------------------------*/
-
-module_platform_driver(t7l66xb_platform_driver);
-
-MODULE_DESCRIPTION("Toshiba T7L66XB core driver");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ian Molton");
-MODULE_ALIAS("platform:t7l66xb");
+builtin_platform_driver(t7l66xb_platform_driver);
-- 
2.7.4

