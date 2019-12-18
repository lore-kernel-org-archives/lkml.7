Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58139C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3049C21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLRUtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:49:33 -0500
Received: from mail.windriver.com ([147.11.1.11]:47887 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLRUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:49:31 -0500
Received: from yow-cube1.wrs.com (yow-cube1.wrs.com [128.224.56.98])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTP id xBIKn0iV000214;
        Wed, 18 Dec 2019 12:49:08 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Ribeiro <drwyrm@gmail.com>,
        Harald Welte <laforge@openezx.org>
Subject: [PATCH 03/18] mfd: ezx-pcap: Make it explicitly non-modular
Date:   Wed, 18 Dec 2019 15:48:42 -0500
Message-Id: <1576702137-25905-4-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config EZX_PCAP
drivers/mfd/Kconfig:    bool "Motorola EZXPCAP Support"

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
Cc: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Harald Welte <laforge@openezx.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/ezx-pcap.c | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 70fa18b04ad2..954a27985b2f 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2009 Daniel Ribeiro <drwyrm@gmail.com>
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -392,30 +392,6 @@ static int pcap_add_subdev(struct pcap_chip *pcap,
 	return ret;
 }
 
-static int ezx_pcap_remove(struct spi_device *spi)
-{
-	struct pcap_chip *pcap = spi_get_drvdata(spi);
-	unsigned long flags;
-	int i;
-
-	/* remove all registered subdevs */
-	device_for_each_child(&spi->dev, NULL, pcap_remove_subdev);
-
-	/* cleanup ADC */
-	spin_lock_irqsave(&pcap->adc_lock, flags);
-	for (i = 0; i < PCAP_ADC_MAXQ; i++)
-		kfree(pcap->adc_queue[i]);
-	spin_unlock_irqrestore(&pcap->adc_lock, flags);
-
-	/* cleanup irqchip */
-	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++)
-		irq_set_chip_and_handler(i, NULL, NULL);
-
-	destroy_workqueue(pcap->workqueue);
-
-	return 0;
-}
-
 static int ezx_pcap_probe(struct spi_device *spi)
 {
 	struct pcap_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -513,9 +489,9 @@ static int ezx_pcap_probe(struct spi_device *spi)
 
 static struct spi_driver ezxpcap_driver = {
 	.probe	= ezx_pcap_probe,
-	.remove = ezx_pcap_remove,
 	.driver = {
-		.name	= "ezx-pcap",
+		.name			= "ezx-pcap",
+		.suppress_bind_attrs	= true,
 	},
 };
 
@@ -523,16 +499,4 @@ static int __init ezx_pcap_init(void)
 {
 	return spi_register_driver(&ezxpcap_driver);
 }
-
-static void __exit ezx_pcap_exit(void)
-{
-	spi_unregister_driver(&ezxpcap_driver);
-}
-
 subsys_initcall(ezx_pcap_init);
-module_exit(ezx_pcap_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Daniel Ribeiro / Harald Welte");
-MODULE_DESCRIPTION("Motorola PCAP2 ASIC Driver");
-MODULE_ALIAS("spi:ezx-pcap");
-- 
2.7.4

