Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F054CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D921852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505514AbfJRPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:45:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502049AbfJRPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mw9Hm-1i4mQQ3FRM-00s9dJ; Fri, 18 Oct 2019 17:42:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 20/46] ARM: pxa: lubbock: pass udc irqs as resource
Date:   Fri, 18 Oct 2019 17:41:35 +0200
Message-Id: <20191018154201.1276638-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nTJNH1PQzy8cjMMin7LOinomkqs0tSjkKrVT+kBFs4X3KlxxjXo
 dO6+aTpTiKZtK8QpEPweKazqSMi5+LBh8d25s0ioorZsFJb/eln2YpAq4JMhCuYX21uFI5r
 7heIyxwKt5SHkA1O39LkzlW18z0/IxVs2ndKvJ2fTjJRQhiXeLcJWw79XcQu7cAP/hdX5bf
 t3Rc98BI5rEp2PEidC66w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QuvpkRYK1V8=:PClHp9hqTY7U0i9I/VNCU5
 683MANrigxXg9+rxrH9CRmdB8oFbOzHw3w1+HaOXloRGesp7YPDLJ+RG8gXuJA2/mih8e1DFQ
 Bs1Ua6tDAfbCOnqrtevCxFrcTfEP6w/XzyleuQDJ3tep7GYIKfIwRAL6pxo0kG0WlToxCXBMi
 Hpo1MZScQpdGJh9Z6upsJqtDHHuTLOoP6EzgLbvrYvvA+GIGj+sHv5caiTp9wS2IzWPe7OWBs
 dI8FR3g2T02YhTdERnH6OFzYsuFiFggF0M/CojavsILk+IsAbxcqRu/wH2gmUipBbnglGvLJR
 En1I05CplZg9zj8FueyPGhRRfpNOkqGiTwAhQKLglmhigKAuJW5NuIWu6yDA9KlP87NXldTTt
 6DndgPN4J4s62xmmI/Qd7ANmnaPaq+a/BGfZclRpeUYQVPIk7iS2GNiWjUO4uykVQFJ3wOtFZ
 jEjwO1D+ujSMv5MIVYpjVSJ6+uC/Q41X5vY0xeACYYV4grZEF1viS/yMAKcTH4kx2d652HQ9T
 nD11IL/RA6DmIUn90mboBliM4C0M8mev9rctM7dUV3WRDFJ3XW/KojWx6Enb104zoeFtYOqEV
 nZQKK2NN13EP8pLQSuBuEW2QPFnAeiZbWMOfNuxf9KdnGwh/vb3JowwIhfS/WJk7Wrd9H13LS
 Yk/cF9/CbytyuxCaq/eQHS+En7RXOveDRCwjQCvnSvlBKZxUYC01CximEBYgHEqw6NaRtpG7m
 TLxF5zJeKwi1lBvau3glAcBzfNT6a5xqWLLLP+HP851pHHGn96JNR5oGt8Bn1O4++fnKCoJNV
 CQq9oL6tASvoeJZFt7LttVWibzZzHbLgSw4THK3XdpxqMOrbj5JP/qka0AOrtTmfUJVhpKa4W
 dr7PXeyGxe8SExkXZmOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubbock is the only machine that has three IRQs for the UDC.
These are currently hardcoded in the driver based on a
machine header file.

Change this to use platform device resources as we use for
the generic IRQ anyway.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/lubbock.c                   | 12 +++++-
 .../arm/mach-pxa/{include/mach => }/lubbock.h |  2 -
 drivers/usb/gadget/udc/pxa25x_udc.c           | 37 ++++++++++---------
 drivers/usb/gadget/udc/pxa25x_udc.h           |  7 +---
 4 files changed, 32 insertions(+), 26 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/lubbock.h (97%)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 098605c8eeed..187d9d8893d7 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -46,7 +46,7 @@
 
 #include "pxa25x.h"
 #include <linux/platform_data/asoc-pxa.h>
-#include <mach/lubbock.h>
+#include "lubbock.h"
 #include "udc.h"
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/video-pxafb.h>
@@ -131,6 +131,13 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
 	// no D+ pullup; lubbock can't connect/disconnect in software
 };
 
+static struct resource lubbock_udc_resources[] = {
+	DEFINE_RES_MEM(0x40600000, 0x10000),
+	DEFINE_RES_IRQ(IRQ_USB),
+	DEFINE_RES_IRQ(LUBBOCK_USB_IRQ),
+	DEFINE_RES_IRQ(LUBBOCK_USB_DISC_IRQ),
+};
+
 /* GPIOs for SA1111 PCMCIA */
 static struct gpiod_lookup_table sa1111_pcmcia_gpio_table = {
 	.dev_id = "1800",
@@ -495,6 +502,9 @@ static void __init lubbock_init(void)
 	lubbock_init_pcmcia();
 
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
+	/* lubbock has two extra IRQs */
+	pxa25x_device_udc.resource = lubbock_udc_resources;
+	pxa25x_device_udc.num_resources = ARRAY_SIZE(lubbock_udc_resources);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&lubbock_mci_platform_data);
diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h b/arch/arm/mach-pxa/lubbock.h
similarity index 97%
rename from arch/arm/mach-pxa/include/mach/lubbock.h
rename to arch/arm/mach-pxa/lubbock.h
index a3af4a2f9446..8e3ff7d57121 100644
--- a/arch/arm/mach-pxa/include/mach/lubbock.h
+++ b/arch/arm/mach-pxa/lubbock.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/mach-pxa/include/mach/lubbock.h
- *
  *  Author:	Nicolas Pitre
  *  Created:	Jun 15, 2001
  *  Copyright:	MontaVista Software Inc.
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index d4be53559f2e..ed7ae48b7db2 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -44,10 +44,6 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-#endif
-
 #define UDCCR	 0x0000 /* UDC Control Register */
 #define UDC_RES1 0x0004 /* UDC Undocumented - Reserved1 */
 #define UDC_RES2 0x0008 /* UDC Undocumented - Reserved2 */
@@ -1575,18 +1571,15 @@ lubbock_vbus_irq(int irq, void *_dev)
 	int			vbus;
 
 	dev->stats.irqs++;
-	switch (irq) {
-	case LUBBOCK_USB_IRQ:
+	if (irq == dev->usb_irq) {
 		vbus = 1;
-		disable_irq(LUBBOCK_USB_IRQ);
-		enable_irq(LUBBOCK_USB_DISC_IRQ);
-		break;
-	case LUBBOCK_USB_DISC_IRQ:
+		disable_irq(dev->usb_irq);
+		enable_irq(dev->usb_disc_irq);
+	} else if (irq == dev->usb_disc_irq) {
 		vbus = 0;
-		disable_irq(LUBBOCK_USB_DISC_IRQ);
-		enable_irq(LUBBOCK_USB_IRQ);
-		break;
-	default:
+		disable_irq(dev->usb_disc_irq);
+		enable_irq(dev->usb_irq);
+	} else {
 		return IRQ_NONE;
 	}
 
@@ -2421,20 +2414,28 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_LUBBOCK
 	if (machine_is_lubbock()) {
-		retval = devm_request_irq(&pdev->dev, LUBBOCK_USB_DISC_IRQ,
+		dev->usb_irq = platform_get_irq(pdev, 1);
+		if (dev->usb_irq < 0)
+			return dev->usb_irq;
+
+		dev->usb_disc_irq = platform_get_irq(pdev, 2);
+		if (dev->usb_disc_irq < 0)
+			return dev->usb_disc_irq;
+
+		retval = devm_request_irq(&pdev->dev, dev->usb_disc_irq,
 					  lubbock_vbus_irq, 0, driver_name,
 					  dev);
 		if (retval != 0) {
 			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_DISC_IRQ, retval);
+				driver_name, dev->usb_disc_irq, retval);
 			goto err;
 		}
-		retval = devm_request_irq(&pdev->dev, LUBBOCK_USB_IRQ,
+		retval = devm_request_irq(&pdev->dev, dev->usb_irq,
 					  lubbock_vbus_irq, 0, driver_name,
 					  dev);
 		if (retval != 0) {
 			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_IRQ, retval);
+				driver_name, dev->usb_irq, retval);
 			goto err;
 		}
 	} else
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.h b/drivers/usb/gadget/udc/pxa25x_udc.h
index ccc6b921f067..c574fb602741 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.h
+++ b/drivers/usb/gadget/udc/pxa25x_udc.h
@@ -121,16 +121,13 @@ struct pxa25x_udc {
 	struct dentry				*debugfs_udc;
 #endif
 	void __iomem				*regs;
+	int					usb_irq;
+	int					usb_disc_irq;
 };
 #define to_pxa25x(g)	(container_of((g), struct pxa25x_udc, gadget))
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-/* lubbock can also report usb connect/disconnect irqs */
-#endif
-
 static struct pxa25x_udc *the_controller;
 
 /*-------------------------------------------------------------------------*/
-- 
2.20.0

