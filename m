Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E202176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLRUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:14 -0500
Received: from mail.windriver.com ([147.11.1.11]:47801 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:14 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iX000214;
        Wed, 18 Dec 2019 12:49:10 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 05/18] mfd: tc3589: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:44 -0500
Message-Id: <1576702137-25905-6-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_TC3589X
drivers/mfd/Kconfig:    bool "Toshiba TC35892 and variants"

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
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/tc3589x.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 67c9995bb1aa..ccbdec1a2202 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -6,7 +6,7 @@
  * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -323,8 +323,6 @@ static const struct of_device_id tc3589x_match[] = {
 	{ }
 };
 
-MODULE_DEVICE_TABLE(of, tc3589x_match);
-
 static struct tc3589x_platform_data *
 tc3589x_of_probe(struct device *dev, enum tc3589x_version *version)
 {
@@ -429,15 +427,6 @@ static int tc3589x_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int tc3589x_remove(struct i2c_client *client)
-{
-	struct tc3589x *tc3589x = i2c_get_clientdata(client);
-
-	mfd_remove_devices(tc3589x->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int tc3589x_suspend(struct device *dev)
 {
@@ -480,16 +469,15 @@ static const struct i2c_device_id tc3589x_id[] = {
 	{ "tc3589x", TC3589X_UNKNOWN },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, tc3589x_id);
 
 static struct i2c_driver tc3589x_driver = {
 	.driver = {
 		.name	= "tc3589x",
 		.pm	= &tc3589x_dev_pm_ops,
 		.of_match_table = of_match_ptr(tc3589x_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe		= tc3589x_probe,
-	.remove		= tc3589x_remove,
 	.id_table	= tc3589x_id,
 };
 
@@ -498,13 +486,3 @@ static int __init tc3589x_init(void)
 	return i2c_add_driver(&tc3589x_driver);
 }
 subsys_initcall(tc3589x_init);
-
-static void __exit tc3589x_exit(void)
-{
-	i2c_del_driver(&tc3589x_driver);
-}
-module_exit(tc3589x_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("TC3589x MFD core driver");
-MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
-- 
2.7.4

