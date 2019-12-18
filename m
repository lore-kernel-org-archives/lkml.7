Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984232176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfLRUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:44 -0500
Received: from mail.windriver.com ([147.11.1.11]:47832 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfLRUtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:32 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0ie000214;
        Wed, 18 Dec 2019 12:49:14 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Milo Kim <milo.kim@ti.com>
Subject: [PATCH 12/18] mfd: lp8788: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:51 -0500
Message-Id: <1576702137-25905-13-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_LP8788
drivers/mfd/Kconfig:    bool "TI LP8788 Power Management Unit Driver"

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

Cc: Milo Kim <milo.kim@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/lp8788.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index 768d556b3fe9..b218855e4162 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -11,7 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/lp8788.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 
 #define MAX_LP8788_REGISTERS		0xA2
@@ -199,27 +199,17 @@ static int lp8788_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 			       ARRAY_SIZE(lp8788_devs), NULL, 0, NULL);
 }
 
-static int lp8788_remove(struct i2c_client *cl)
-{
-	struct lp8788 *lp = i2c_get_clientdata(cl);
-
-	mfd_remove_devices(lp->dev);
-	lp8788_irq_exit(lp);
-	return 0;
-}
-
 static const struct i2c_device_id lp8788_ids[] = {
 	{"lp8788", 0},
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, lp8788_ids);
 
 static struct i2c_driver lp8788_driver = {
 	.driver = {
 		.name = "lp8788",
+		.suppress_bind_attrs = true,
 	},
 	.probe = lp8788_probe,
-	.remove = lp8788_remove,
 	.id_table = lp8788_ids,
 };
 
@@ -228,13 +218,3 @@ static int __init lp8788_init(void)
 	return i2c_add_driver(&lp8788_driver);
 }
 subsys_initcall(lp8788_init);
-
-static void __exit lp8788_exit(void)
-{
-	i2c_del_driver(&lp8788_driver);
-}
-module_exit(lp8788_exit);
-
-MODULE_DESCRIPTION("TI LP8788 MFD Driver");
-MODULE_AUTHOR("Milo Kim");
-MODULE_LICENSE("GPL");
-- 
2.7.4

