Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D91C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E679F2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfLRUtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:40 -0500
Received: from mail.windriver.com ([147.11.1.11]:47841 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfLRUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:33 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0ia000214;
        Wed, 18 Dec 2019 12:49:11 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 08/18] mfd: twl4030-audio: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:47 -0500
Message-Id: <1576702137-25905-9-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_TWL4030_AUDIO
drivers/mfd/Kconfig:    bool "TI TWL4030 Audio"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/twl4030-audio.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 4536d829b43e..7612997e3b86 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -8,7 +8,7 @@
  * Copyright:   (C) 2009 Nokia Corporation
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -258,32 +258,17 @@ static int twl4030_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int twl4030_audio_remove(struct platform_device *pdev)
-{
-	mfd_remove_devices(&pdev->dev);
-	twl4030_audio_dev = NULL;
-
-	return 0;
-}
-
 static const struct of_device_id twl4030_audio_of_match[] = {
 	{.compatible = "ti,twl4030-audio", },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, twl4030_audio_of_match);
 
 static struct platform_driver twl4030_audio_driver = {
 	.driver		= {
 		.name	= "twl4030-audio",
 		.of_match_table = twl4030_audio_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= twl4030_audio_probe,
-	.remove		= twl4030_audio_remove,
 };
-
-module_platform_driver(twl4030_audio_driver);
-
-MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
-MODULE_DESCRIPTION("TWL4030 audio block MFD driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:twl4030-audio");
+builtin_platform_driver(twl4030_audio_driver);
-- 
2.7.4

