Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72296C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485E02176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfLRUuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:50:11 -0500
Received: from mail.windriver.com ([147.11.1.11]:47837 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfLRUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:19 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0ig000214;
        Wed, 18 Dec 2019 12:49:16 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 14/18] mfd: tps6586x: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:53 -0500
Message-Id: <1576702137-25905-15-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_TPS6586X
drivers/mfd/Kconfig:    bool "TI TPS6586x Power Management chips"

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
Cc: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/tps6586x.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index c8aadd39324e..d7db10d34193 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -16,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -578,17 +578,6 @@ static int tps6586x_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int tps6586x_i2c_remove(struct i2c_client *client)
-{
-	struct tps6586x *tps6586x = i2c_get_clientdata(client);
-
-	tps6586x_remove_subdevs(tps6586x);
-	mfd_remove_devices(tps6586x->dev);
-	if (client->irq)
-		free_irq(client->irq, tps6586x);
-	return 0;
-}
-
 static int __maybe_unused tps6586x_i2c_suspend(struct device *dev)
 {
 	struct tps6586x *tps6586x = dev_get_drvdata(dev);
@@ -616,16 +605,15 @@ static const struct i2c_device_id tps6586x_id_table[] = {
 	{ "tps6586x", 0 },
 	{ },
 };
-MODULE_DEVICE_TABLE(i2c, tps6586x_id_table);
 
 static struct i2c_driver tps6586x_driver = {
 	.driver	= {
 		.name	= "tps6586x",
 		.of_match_table = of_match_ptr(tps6586x_of_match),
 		.pm	= &tps6586x_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= tps6586x_i2c_probe,
-	.remove		= tps6586x_i2c_remove,
 	.id_table	= tps6586x_id_table,
 };
 
@@ -634,13 +622,3 @@ static int __init tps6586x_init(void)
 	return i2c_add_driver(&tps6586x_driver);
 }
 subsys_initcall(tps6586x_init);
-
-static void __exit tps6586x_exit(void)
-{
-	i2c_del_driver(&tps6586x_driver);
-}
-module_exit(tps6586x_exit);
-
-MODULE_DESCRIPTION("TPS6586X core driver");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
-- 
2.7.4

