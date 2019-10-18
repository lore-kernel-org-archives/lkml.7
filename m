Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB60CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD3C222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502097AbfJRPmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:38 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501966AbfJRPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:34 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MNKqC-1ifkHC3J4k-00Orkl; Fri, 18 Oct 2019 17:42:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH 14/46] ARM: pxa: use pdev resource for palmld mmio
Date:   Fri, 18 Oct 2019 17:41:29 +0200
Message-Id: <20191018154201.1276638-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9s9xjur6L83/idKD1YLwArjJyhyl8Cp7qlwCvaEgeO21rFy+Txo
 lkGteYOQn0MBqAMwkJi0uRdkZLsfImWHPdYLE7PLW21Sd3U+j5xmJVqizean3Yo6tGIyt4j
 b1FTAdx0jX4nBBwGdwJ6o8pC+wzWxEhYJyN0mswYrz7qjItCmmaKqVNf3OcjWcOw+Au25rz
 dMaGUYwa0lBQt8U9W94dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGnzZHc3OD0=:1UpnXV4WJndTPk7c3U4mVT
 58XASwopJp2Pwtju3qRPQf7vELH43tB/mnU3w9S1XGNK2fKElPNqbLdX9BoaoFCn2E43lKsGF
 1k7jJBif/36MpjBUMzqOuHQkJSUwfurbA0nLOTsKz+dvxxR+s/E9dJrb2FN3K7J1oRAl0kEQQ
 UMjGv9xBTAxrHHVMoHxIGTqBx6VqHLXKW4ntZPFJl8OMnxHeJp5J7qXk0xS4UhrE1mOeoxUtR
 xmWF+qAp/KSrMZvQOYHiuRjNN7QgR6GVaCBLcVEN2wvHLml4jsRtWWJdcgvrwzioOGFjiwlh6
 s+gEbfWpIHBId2plMIweDQmCWORT+CRxcWsEYEzcrXFDdyA092E6OqKzicnGMuw+gL2I6qrLI
 osG4LuHgVUkphSW7aOg4kBviIGnWDjQjzzU7njddgQ6SgzEJiDSt14MsT0q8bGY/RcMrPm8/+
 HVDQwKwSmGR09sO96wMI5oKvzXwZeW1HFYATOlw9bbgTKpnYiQ2f79SbVO2YHcKjFulZsXCiI
 pFUxCUAJ1J40OGkqr01masMQecvHN+gbyt0L4r5M2KVdZ5Hcw52J9lFNGrKIkvImIaNIQL4ZJ
 lZCQBtZ1r3RcCRgxeJNWEOFkZbEfHV7beKkonkUlPpMbgur3MAu1PSMPDciZw8+4CCZoRU4Ll
 4NZ/jDpVOVwFdDHEsY21mQW07Qhxy942y0cUYlEWYZnmVoYwKF/WtXdeX99tqzk2meV657IHA
 n6/zsOBjfI2E3hIN08dSwgB8KAS8R4OOti2DQcxhPCzraPjhD+zU6E6L4rpqqFZ0xfT+QBuUk
 XeACZjHjrhwQ+lau79HXI35qmO1otzkjAuHOFjjfMIHDYmjuBTkWdV+2NJEf5cR8G1OOTg1JR
 FDDTyCTRoc9JoCXNmHbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The palmld header is almost unused in drivers, the only
remaining thing now is the PATA device address, which should
really be passed as a resource.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/palmld-pcmcia.c             |  3 ++-
 arch/arm/mach-pxa/palmld.c                    | 12 +++++++++---
 arch/arm/mach-pxa/{include/mach => }/palmld.h |  2 +-
 drivers/ata/pata_palmld.c                     |  3 +--
 4 files changed, 13 insertions(+), 7 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/palmld.h (98%)

diff --git a/arch/arm/mach-pxa/palmld-pcmcia.c b/arch/arm/mach-pxa/palmld-pcmcia.c
index 07e0f7438db1..720294a50864 100644
--- a/arch/arm/mach-pxa/palmld-pcmcia.c
+++ b/arch/arm/mach-pxa/palmld-pcmcia.c
@@ -13,9 +13,10 @@
 #include <linux/gpio.h>
 
 #include <asm/mach-types.h>
-#include <mach/palmld.h>
 #include <pcmcia/soc_common.h>
 
+#include "palmld.h"
+
 static struct gpio palmld_pcmcia_gpios[] = {
 	{ GPIO_NR_PALMLD_PCMCIA_POWER,	GPIOF_INIT_LOW,	"PCMCIA Power" },
 	{ GPIO_NR_PALMLD_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index d85146957004..d821606ce0b5 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -29,8 +29,8 @@
 #include <asm/mach/map.h>
 
 #include "pxa27x.h"
+#include "palmld.h"
 #include <linux/platform_data/asoc-pxa.h>
-#include <mach/palmld.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/irda-pxaficp.h>
@@ -279,9 +279,15 @@ static inline void palmld_leds_init(void) {}
  * HDD
  ******************************************************************************/
 #if defined(CONFIG_PATA_PALMLD) || defined(CONFIG_PATA_PALMLD_MODULE)
+static struct resource palmld_ide_resources[] = {
+	DEFINE_RES_MEM(PALMLD_IDE_PHYS, 0x1000),
+};
+
 static struct platform_device palmld_ide_device = {
-	.name	= "pata_palmld",
-	.id	= -1,
+	.name		= "pata_palmld",
+	.id		= -1,
+	.resource	= palmld_ide_resources,
+	.num_resources	= ARRAY_SIZE(palmld_ide_resources),
 };
 
 static struct gpiod_lookup_table palmld_ide_gpio_table = {
diff --git a/arch/arm/mach-pxa/include/mach/palmld.h b/arch/arm/mach-pxa/palmld.h
similarity index 98%
rename from arch/arm/mach-pxa/include/mach/palmld.h
rename to arch/arm/mach-pxa/palmld.h
index 99a6d8b3a1e3..ee3bc15b71a2 100644
--- a/arch/arm/mach-pxa/include/mach/palmld.h
+++ b/arch/arm/mach-pxa/palmld.h
@@ -9,7 +9,7 @@
 #ifndef _INCLUDE_PALMLD_H_
 #define _INCLUDE_PALMLD_H_
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /** HERE ARE GPIOs **/
 
diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
index 2448441571ed..400e65190904 100644
--- a/drivers/ata/pata_palmld.c
+++ b/drivers/ata/pata_palmld.c
@@ -25,7 +25,6 @@
 #include <linux/gpio/consumer.h>
 
 #include <scsi/scsi_host.h>
-#include <mach/palmld.h>
 
 #define DRV_NAME "pata_palmld"
 
@@ -63,7 +62,7 @@ static int palmld_pata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* remap drive's physical memory address */
-	mem = devm_ioremap(dev, PALMLD_IDE_PHYS, 0x1000);
+	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (!mem)
 		return -ENOMEM;
 
-- 
2.20.0

