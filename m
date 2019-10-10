Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D34C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189CD208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfJJUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:31:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfJJUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:31:42 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MS1G7-1ig9Fo3Vvv-00TYCf; Thu, 10 Oct 2019 22:31:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 03/36] usb: gadget: s3c: use platform resources
Date:   Thu, 10 Oct 2019 22:29:47 +0200
Message-Id: <20191010203043.1241612-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iwNwd1cVxFxCrms7c8C5XzuQmcy9u/dn0xzTwy3RMzXW1HxHseW
 IktW/Os21uQmVtkwkRfdK8qY77KGxRXzPq9asnOccmpMKGioJurl5rwTvNROCMQ0hv7uHM1
 5n3b0f1Gq1uQp5GkmFlZaHhavVkQl4zYOZ06/7iFrVU7yhx4YAWQB741n54+opUgSOKqapx
 Uqd7p7XE5W4DODvUhpdkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/KCtwZvm948=:MjTG6wQH6Bxkes8aciFuXb
 wupIQgdWQkr5jGLLinWtBtmLJ2v2beVp77GUTiiOxUYG6E8z5XEN47Fg5bXASQZeY78NP+X28
 cuF+YJlcr9ywwhZamJFnQv8guj15mlGyx1EHNB+ZC5Dj2ob/Lmh+lo4+vK61tQsonzDlO0DvC
 qs7fRaIZeBcRWlPX75oaPOBrcGGoQN8+CTB7LemcVNUxkBUFKLtSB+OU+d1hbjT1vRgsXztYw
 GN7CJbrxCk4nLJ9+XwC4en0QBzhQ2Dl/wlyO1vRAVjPE8W/OS4SJSXNW8Nym8gE+PNpJwveDb
 qhbuXxK65AEu9ev0p6t4voIPYRdP2yo8g/comURhSF+9CpGPrxsoPb0TlD2JvRt6IgPxxTV83
 3SlyGem/ISFtWbADtVkvTPwGxi6UPb33hVZF4A0XJfGRDrTOQ/+DOm1AfByNGebaPk++ZU4Ea
 LimmQYfyqNq4cxGUFua7x3Wx6PyPUhyyAJgJsJYu64uyDP3Hl/eLjV5kQ6nu/Wb6A+5oUkzXA
 Jl8FyQRkuwZP6zKUZC6moi3BtS6nOUpVieam8Xjao9HN5Fn7/t/Gs0o6aUoKhUGuGKBR19A9q
 n8kEG8c5zJJ36ptDqdr7XBFzFsvhSipybIw44e+YZZmojMFTusmcexy17QfjG4fTYnpR9ipCG
 taBNgRpoSESiUXenE+9ZFSjQ0sV8YLIR4wOs9Ml/wWbVND+oPHTEEzInk/73Av+ppsgtPa9fw
 2U1M7pDIYSarTkneuXbiBHGIDID1b+Vh+9srUMkHEz3IRWIdD2QoiHZkuwi882ECwm4/w5Ny/
 a2RxIEEXJ+5AVS9XPQh5C3rdadtoJUIwQdrPPcQKEhJB8OoJzkEwYN8XmML3GnFjITtOZzc0Y
 2akHoI5CkL2+FlbMBIpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resources are correctly initialized, so just use them
instead of relying on hardcoded data from platform headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/s3c2410_udc.c          | 31 +++++++------------
 drivers/usb/gadget/udc/s3c2410_udc.h          |  1 +
 .../usb/gadget/udc/s3c2410_udc_regs.h         |  0
 3 files changed, 12 insertions(+), 20 deletions(-)
 rename arch/arm/plat-samsung/include/plat/regs-udc.h => drivers/usb/gadget/udc/s3c2410_udc_regs.h (100%)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index f82208fbc249..e411d27b79fc 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -36,15 +36,11 @@
 #include <asm/byteorder.h>
 #include <asm/irq.h>
 #include <asm/unaligned.h>
-#include <mach/irqs.h>
 
-#include <mach/hardware.h>
-
-#include <plat/regs-udc.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
-
 #include "s3c2410_udc.h"
+#include "s3c2410_udc_regs.h"
 
 #define DRIVER_DESC	"S3C2410 USB Device Controller Gadget"
 #define DRIVER_AUTHOR	"Herbert Pötzl <herbert@13thfloor.at>, " \
@@ -57,6 +53,7 @@ static struct s3c2410_udc	*the_controller;
 static struct clk		*udc_clock;
 static struct clk		*usb_bus_clock;
 static void __iomem		*base_addr;
+static int			irq_usbd;
 static u64			rsrc_start;
 static u64			rsrc_len;
 static struct dentry		*s3c2410_udc_debugfs_root;
@@ -839,8 +836,6 @@ static void s3c2410_udc_handle_ep(struct s3c2410_ep *ep)
 	}
 }
 
-#include <mach/regs-irq.h>
-
 /*
  *	s3c2410_udc_irq - interrupt handler
  */
@@ -981,7 +976,7 @@ static irqreturn_t s3c2410_udc_irq(int dummy, void *_dev)
 		}
 	}
 
-	dprintk(DEBUG_VERBOSE, "irq: %d s3c2410_udc_done.\n", IRQ_USBD);
+	dprintk(DEBUG_VERBOSE, "irq: %d s3c2410_udc_done.\n", irq_usbd);
 
 	/* Restore old index */
 	udc_write(idx, S3C2410_UDC_INDEX_REG);
@@ -1784,13 +1779,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	spin_lock_init(&udc->lock);
 	udc_info = dev_get_platdata(&pdev->dev);
 
-	rsrc_start = S3C2410_PA_USBDEV;
-	rsrc_len   = S3C24XX_SZ_USBDEV;
-
-	if (!request_mem_region(rsrc_start, rsrc_len, gadget_name))
-		return -EBUSY;
-
-	base_addr = ioremap(rsrc_start, rsrc_len);
+	base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (!base_addr) {
 		retval = -ENOMEM;
 		goto err_mem;
@@ -1802,17 +1791,19 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	s3c2410_udc_disable(udc);
 	s3c2410_udc_reinit(udc);
 
+	irq_usbd = platform_get_irq(pdev, 0);
+
 	/* irq setup after old hardware state is cleaned up */
-	retval = request_irq(IRQ_USBD, s3c2410_udc_irq,
+	retval = request_irq(irq_usbd, s3c2410_udc_irq,
 			     0, gadget_name, udc);
 
 	if (retval != 0) {
-		dev_err(dev, "cannot get irq %i, err %d\n", IRQ_USBD, retval);
+		dev_err(dev, "cannot get irq %i, err %d\n", irq_usbd, retval);
 		retval = -EBUSY;
 		goto err_map;
 	}
 
-	dev_dbg(dev, "got irq %i\n", IRQ_USBD);
+	dev_dbg(dev, "got irq %i\n", irq_usbd);
 
 	if (udc_info && udc_info->vbus_pin > 0) {
 		retval = gpio_request(udc_info->vbus_pin, "udc vbus");
@@ -1879,7 +1870,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	if (udc_info && udc_info->vbus_pin > 0)
 		gpio_free(udc_info->vbus_pin);
 err_int:
-	free_irq(IRQ_USBD, udc);
+	free_irq(irq_usbd, udc);
 err_map:
 	iounmap(base_addr);
 err_mem:
@@ -1913,7 +1904,7 @@ static int s3c2410_udc_remove(struct platform_device *pdev)
 		free_irq(irq, udc);
 	}
 
-	free_irq(IRQ_USBD, udc);
+	free_irq(irq_usbd, udc);
 
 	iounmap(base_addr);
 	release_mem_region(rsrc_start, rsrc_len);
diff --git a/drivers/usb/gadget/udc/s3c2410_udc.h b/drivers/usb/gadget/udc/s3c2410_udc.h
index bdcaa8dd300f..68bdf3e5aac2 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.h
+++ b/drivers/usb/gadget/udc/s3c2410_udc.h
@@ -90,6 +90,7 @@ struct s3c2410_udc {
 	unsigned			req_pending : 1;
 	u8				vbus;
 	struct dentry			*regs_info;
+	int				irq;
 };
 #define to_s3c2410(g)	(container_of((g), struct s3c2410_udc, gadget))
 
diff --git a/arch/arm/plat-samsung/include/plat/regs-udc.h b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/regs-udc.h
rename to drivers/usb/gadget/udc/s3c2410_udc_regs.h
-- 
2.20.0

