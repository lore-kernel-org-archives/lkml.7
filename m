Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2358921852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505495AbfJRPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:44:46 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505164AbfJRPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N33AR-1htWxG247x-013P60; Fri, 18 Oct 2019 17:42:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 11/46] ARM: pxa: cmx270: use platform device for nand
Date:   Fri, 18 Oct 2019 17:41:26 +0200
Message-Id: <20191018154201.1276638-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AbuR27vzvwqTV64dzM3JZRxK8+Uh7OaKfpyn+sIT526ScJjmzmK
 JIJ7LTt+coUJgOsnQwlmCuxVOTtwZTHIFaEmlH7gkm/oxGXEWGKHiHSSjwxG05JZ9zmCL2f
 nyZ9BJcO99q/LJ6sLR9iDukJXjZznJhvvPK3Q+fjryuiX+0vktVBhsBkwCHvAEsxvI5YUOm
 Sz3dS9H0qPVlK5FG3CjoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l2PtyoVwGKc=:+0UEgTT2WSPL5NZ6La/kPz
 DHmB450niREfEPyFYAmQeTXByU0r3y2AE91V1gd21WSqwlhgnuOR1J0ph5In0M1ZrAvR+HN18
 UjDM5XG4d+1SoYl+AMm7duwpjCH9Qh9FigBmRXr2zzSlAWObwWI2GBiWhRf0svOpiLnFJipOm
 wnhQoVDcOnbCYFFNjxR+vlA8/Uqi8LDRXsFU62jSQNDck7MAbwe0UAkjeKzoQZ+uXHFn1fbw3
 ebVXOSacNAHlioTZgCEOOiALKXl2rkyuhf5aOl/R/iyEC1T+yM4YrfdrhR/JCxxUYWcUBJRG4
 PaoQpkISkiKX2VJDMLvXy84shXMYREoDOYZoVAgRnBd2rQv6kMQYhdxrOcwjGKP122/1ZDPSQ
 wxuP3rvoP7eu6MQD4YUOrUTteACUg6X4sbqgseaE2cP3+RYbVKjNScT/C99qd1bLJJS1it8Ea
 NUDBqPBIIgAP+nZurYQEhlLtWQJKDNFbTiZp6TuyBBSbI9MLb2M/ICKcxddt2AbTaJBvT4V8Z
 U5CECnKrQ2LotmlpizOTtf1xNJn7To3sYvMXDJ5GBhbOqjlfxLgg2nsMcRGtFtLl9Y2AZ2Mq8
 EBDiZ+14CfRIAEY/rmMpMJnr5fzDP4wyN/06P6mUUagvOIKsHdSLoRQuWCUPdXYrPlW5t0iBW
 AzXkE9Lee68P3GxF01Dy3/d7cNPHSADY1NRiEf1GyRKb5RI01eREEliDC5tzHHakmKlh+3jb1
 TeWeMUHBxXIsCgqgjqsTTH4hNC/Pm9kGFBdx2YngifU3fYK4xsL1x0luFLt591VEJarvlod1b
 Fm6SpJWE7rXJxCkPIrtdyMeudmH2lWJnKoN+1qkAdWGdzSOhAmJvFdFZPcMVagyGjFMK08tV6
 bwZe2eB6qhQFuQjQ1rTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver traditionally hardcodes the MMIO register address and
the GPIO numbers from data defined in platform header files.

To make it indepdendent of that, use a memory resource for the
registers, and a gpio lookup table to replace the gpio numbers.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/cm-x270.c        | 25 +++++++++
 drivers/mtd/nand/raw/cmx270_nand.c | 88 +++++++++++-------------------
 2 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index 9baad11314f2..6d80400d8887 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -40,6 +40,10 @@
 #define GPIO19_WLAN_STRAP	(19)
 #define GPIO102_WLAN_RST	(102)
 
+/* NAND GPIOS */
+#define GPIO_NAND_CS		(11)
+#define GPIO_NAND_RB		(89)
+
 static unsigned long cmx270_pin_config[] = {
 	/* AC'97 */
 	GPIO28_AC97_BITCLK,
@@ -403,6 +407,26 @@ static void __init cmx270_init_spi(void)
 static inline void cmx270_init_spi(void) {}
 #endif
 
+static struct gpiod_lookup_table cmx270_nand_gpio_table = {
+	.dev_id = "cmx270-nand",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_CS, "cs", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_RB, "rb", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct resource cmx270_nand_resources[] __initdata = {
+	DEFINE_RES_MEM(PXA_CS1_PHYS, 12),
+};
+
+static void __init cmx270_init_nand(void)
+{
+	platform_device_register_simple("cmx270-nand", -1,
+					cmx270_nand_resources, 1);
+	gpiod_add_lookup_table(&cmx270_nand_gpio_table);
+}
+
 void __init cmx270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(cmx270_pin_config));
@@ -416,4 +440,5 @@ void __init cmx270_init(void)
 	cmx270_init_ohci();
 	cmx270_init_2700G();
 	cmx270_init_spi();
+	cmx270_init_nand();
 }
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index 7af3d0bdcdb8..31cb20858c46 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -15,18 +15,17 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/soc/pxa/cpu.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/addr-map.h>
-
-#define GPIO_NAND_CS	(11)
-#define GPIO_NAND_RB	(89)
+static struct gpio_desc *gpiod_nand_cs;
+static struct gpio_desc *gpiod_nand_rb;
 
 /* MTD structure for CM-X270 board */
 static struct mtd_info *cmx270_nand_mtd;
@@ -70,14 +69,14 @@ static void cmx270_read_buf(struct nand_chip *this, u_char *buf, int len)
 
 static inline void nand_cs_on(void)
 {
-	gpio_set_value(GPIO_NAND_CS, 0);
+	gpiod_set_value(gpiod_nand_cs, 0);
 }
 
 static void nand_cs_off(void)
 {
 	dsb();
 
-	gpio_set_value(GPIO_NAND_CS, 1);
+	gpiod_set_value(gpiod_nand_cs, 1);
 }
 
 /*
@@ -120,48 +119,41 @@ static int cmx270_device_ready(struct nand_chip *this)
 {
 	dsb();
 
-	return (gpio_get_value(GPIO_NAND_RB));
+	return (gpiod_get_value(gpiod_nand_rb));
 }
 
 /*
  * Main initialization routine
  */
-static int __init cmx270_init(void)
+static int cmx270_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (!(machine_is_armcore() && cpu_is_pxa27x()))
-		return -ENODEV;
-
-	ret = gpio_request(GPIO_NAND_CS, "NAND CS");
+	gpiod_nand_cs = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(gpiod_nand_cs);
 	if (ret) {
 		pr_warn("CM-X270: failed to request NAND CS gpio\n");
 		return ret;
 	}
 
-	gpio_direction_output(GPIO_NAND_CS, 1);
-
-	ret = gpio_request(GPIO_NAND_RB, "NAND R/B");
+	gpiod_nand_rb = devm_gpiod_get(dev, "rb", GPIOD_IN);
+	ret = PTR_ERR_OR_ZERO(gpiod_nand_rb);
 	if (ret) {
 		pr_warn("CM-X270: failed to request NAND R/B gpio\n");
-		goto err_gpio_request;
+		return ret;
 	}
 
-	gpio_direction_input(GPIO_NAND_RB);
-
 	/* Allocate memory for MTD device structure and private data */
-	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
-	if (!this) {
-		ret = -ENOMEM;
-		goto err_kzalloc;
-	}
+	this = devm_kzalloc(dev, sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this)
+		return -ENOMEM;
 
-	cmx270_nand_io = ioremap(PXA_CS1_PHYS, 12);
+	cmx270_nand_io = devm_platform_ioremap_resource(pdev, 0);
 	if (!cmx270_nand_io) {
 		pr_debug("Unable to ioremap NAND device\n");
-		ret = -EINVAL;
-		goto err_ioremap;
+		return -EINVAL;
 	}
 
 	cmx270_nand_mtd = nand_to_mtd(this);
@@ -189,48 +181,30 @@ static int __init cmx270_init(void)
 	ret = nand_scan(this, 1);
 	if (ret) {
 		pr_notice("No NAND device\n");
-		goto err_scan;
+		return ret;
 	}
 
 	/* Register the partitions */
-	ret = mtd_device_register(cmx270_nand_mtd, partition_info,
-				  NUM_PARTITIONS);
-	if (ret)
-		goto err_scan;
-
-	/* Return happy */
-	return 0;
-
-err_scan:
-	iounmap(cmx270_nand_io);
-err_ioremap:
-	kfree(this);
-err_kzalloc:
-	gpio_free(GPIO_NAND_RB);
-err_gpio_request:
-	gpio_free(GPIO_NAND_CS);
-
-	return ret;
-
+	return mtd_device_register(cmx270_nand_mtd, partition_info,
+				   NUM_PARTITIONS);
 }
-module_init(cmx270_init);
 
 /*
  * Clean up routine
  */
-static void __exit cmx270_cleanup(void)
+static int cmx270_remove(struct platform_device *pdev)
 {
-	/* Release resources, unregister device */
 	nand_release(mtd_to_nand(cmx270_nand_mtd));
 
-	gpio_free(GPIO_NAND_RB);
-	gpio_free(GPIO_NAND_CS);
-
-	iounmap(cmx270_nand_io);
-
-	kfree(mtd_to_nand(cmx270_nand_mtd));
+	return 0;
 }
-module_exit(cmx270_cleanup);
+
+static struct platform_driver cmx270_nand_driver = {
+	.driver.name = "cmx270-nand",
+	.probe = cmx270_probe,
+	.remove = cmx270_remove,
+};
+module_platform_driver(cmx270_nand_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-- 
2.20.0

