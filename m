Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EAC2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLRUtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:20 -0500
Received: from mail.windriver.com ([147.11.1.11]:47827 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfLRUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:17 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iY000214;
        Wed, 18 Dec 2019 12:49:10 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ian Molton <spyro@f2s.com>
Subject: [PATCH 06/18] mfd: tc6387xb: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:45 -0500
Message-Id: <1576702137-25905-7-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_TC6387XB
drivers/mfd/Kconfig:    bool "Toshiba TC6387XB"

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
 drivers/mfd/tc6387xb.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index c66a701ab21c..aa2eada4bf30 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -6,7 +6,7 @@
  * This file contains TC6387XB base support.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -199,35 +199,13 @@ static int tc6387xb_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int tc6387xb_remove(struct platform_device *dev)
-{
-	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
-
-	mfd_remove_devices(&dev->dev);
-	iounmap(tc6387xb->scr);
-	release_resource(&tc6387xb->rscr);
-	clk_disable_unprepare(tc6387xb->clk32k);
-	clk_put(tc6387xb->clk32k);
-	kfree(tc6387xb);
-
-	return 0;
-}
-
-
 static struct platform_driver tc6387xb_platform_driver = {
 	.driver = {
-		.name		= "tc6387xb",
+		.name			= "tc6387xb",
+		.suppress_bind_attrs	= true,
 	},
 	.probe		= tc6387xb_probe,
-	.remove		= tc6387xb_remove,
 	.suspend        = tc6387xb_suspend,
 	.resume         = tc6387xb_resume,
 };
-
-module_platform_driver(tc6387xb_platform_driver);
-
-MODULE_DESCRIPTION("Toshiba TC6387XB core driver");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ian Molton");
-MODULE_ALIAS("platform:tc6387xb");
-
+builtin_platform_driver(tc6387xb_platform_driver);
-- 
2.7.4

