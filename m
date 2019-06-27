Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED0C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E2920843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iPVqE4qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF0HRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:17:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47705 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF0HRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:17:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627071746euoutp02764a5fa9ad0c0cd9d3dd3b9daf242323~r-P6PV5Py2029420294euoutp02c;
        Thu, 27 Jun 2019 07:17:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627071746euoutp02764a5fa9ad0c0cd9d3dd3b9daf242323~r-P6PV5Py2029420294euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561619866;
        bh=016809SWLiNavtpgbPWJW68VdPyatI3WBJsEnZ1/Se0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=iPVqE4qxmuTCvCkJTcCAfNqrZySc3Am9lt3bejUWnKJIR16tmn5bXQbMlJjiGjrUl
         dvkuFvXvD+hBU+uNTfc4luK/BinCGDUMmeQFYxkqFdRGmTCo9g40YWBpT13h/WnXnW
         EoXB62EK2MfE/if2ur8vLf1gQegM3HZiZPaZbPO4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190627071745eucas1p2f7c4bcaf2fe632d92a8304d837279499~r-P512Hj_0726707267eucas1p2t;
        Thu, 27 Jun 2019 07:17:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.96.04377.99D641D5; Thu, 27
        Jun 2019 08:17:45 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627071744eucas1p164b065a96afa23f2f5534fbc73660dae~r-P5GyKvj0969409694eucas1p15;
        Thu, 27 Jun 2019 07:17:44 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-ba-5d146d9932e3
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.9A.04146.89D641D5; Thu, 27
        Jun 2019 08:17:44 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PTQ00HYSXLCML00@eusync4.samsung.com>;
        Thu, 27 Jun 2019 08:17:44 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 1/3] usb: host: xhci-plat: Add support for Exynos5/DWC3
 specific variant
Date:   Thu, 27 Jun 2019 09:17:24 +0200
Message-id: <20190627071726.30467-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190627071726.30467-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7djPc7ozc0ViDTYsFLXYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrdYe+QuUN2mKawO3B47Z91l
        91i85yWTx6ZVnWwe++euYffo27KK0WPDln8sHp83yQWwR3HZpKTmZJalFunbJXBl7Dv8irmg
        xb5izb9TrA2Mx026GDk5JARMJOb2fmDrYuTiEBJYwShxcuFGVgjnM6PEteVrWLoYOcCqNr5L
        hogvY5S4v2IhC4Tzn1HiVHs/E8goNgFDia63XWwgtoiAg8SSpXfAxjIL/GeSmH7jBCtIQlgg
        SqK15TyYzSKgKvHq10OwZl4BW4mjXxYxQtwkL7F6wwFmEJtTwE7i6LTJ7CCDJAS2sElM/Pec
        GeIkF4nH20sh6mUkOjsOMkHUNDNKPDy3Fqqhh1HictMMqKnWEoePXwTbzCzAJzFp23SoQbwS
        HW1CECUeEodebmaEeG0io0TftY1sExglFjAyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/d
        xAiM09P/jn/ZwbjrT9IhRgEORiUeXoY9wrFCrIllxZW5hxglOJiVRHjzw0RihXhTEiurUovy
        44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTBOkvjB/sP70MkLn+0eCWi+
        tds6PeLpp+dnXk2zubHUZk7A8wdry+f6+bYvv8uduNDK6NDZt1UPao+lHtzWGyx3OV3huuqS
        R3s+Mot7Fy9dp7/KkDmrY3Xj5R2qUZd2nNm/PWbu/oy99ZP4E5id/9zyfvBw3z5vSw1HCeue
        oJgmec+tMspxZ3ZlKrEUZyQaajEXFScCAEhNeUrPAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsVy+t/xa7ozckViDTpvqVhsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo7hsUlJzMstSi/TtErgy9h1+xVzQ
        Yl+x5t8p1gbG4yZdjBwcEgImEhvfJXcxcnEICSxhlGg7coYVwmlkkpgxYzGQw8nBJmAo0fW2
        iw3EFhFwkFiy9A4bSBGzQCOzxO8dZ8GKhAWiJFpbzoPZLAKqEq9+PWQCsXkFbCWOflnECGJL
        CMhLrN5wgBnE5hSwkzg6bTI7iC0EVHO1fT37BEaeBYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS
        83M3MQIDb9uxn5t3MF7aGHyIUYCDUYmHd8VO4Vgh1sSy4srcQ4wSHMxKIrz5YSKxQrwpiZVV
        qUX58UWlOanFhxilOViUxHk7BA7GCAmkJ5akZqemFqQWwWSZODilGhglHkR1ZkzQ+77oZVX6
        P/ea6DgGb5EU6YNnyi9y5blJiE1QXP70tXn8tU01/UJztKbnTJ0w+3XRlN9Zi2a9vaWa56I4
        7UXXpg1Ba6WX2RkyG+2beGzu9a/c/+4/EvEpfe4R+UGBIeWx6UaB4sz0UJXT74pKNx7M/6f7
        X/8s9ybu9rqXG46qXTVUYinOSDTUYi4qTgQAwDMo0DgCAAA=
X-CMS-MailID: 20190627071744eucas1p164b065a96afa23f2f5534fbc73660dae
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627071744eucas1p164b065a96afa23f2f5534fbc73660dae
References: <20190627071726.30467-1-m.szyprowski@samsung.com>
        <CGME20190627071744eucas1p164b065a96afa23f2f5534fbc73660dae@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB3.0 DRD PHY found in Exynos5 SoCs requires calibration to be done
after every HCD reset. This was initially handled by DWC3 core by commit
d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
exynos5420/5800"), but it turned out that the mentioned patch worked only
by the pure luck and fixed only one use case.

PHY calibration was done in DWC3 driver, just before initializing XHCI
core. This approach was prone to a race. It worked for the fresh boot
case iff XHCI-plat driver was compiled into the kernel or it's module has
been loaded before DWC3 probe. In other cases (XHCI-plat module loaded on
demand after DWC3 probe or during suspend/resume cycle) - the
calibration was not performed at proper time and had no effect.

This patch creates Exynos5/DWC3 specific variant of XHCI-plat driver,
which takes care of proper PHY calibration after XHCI core reset, what
fixes all known use cases (XHCI driver compiled as module and loaded on
demand as well as during system suspend/resume cycle).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/host/Kconfig       |  8 ++++++
 drivers/usb/host/Makefile      |  3 ++
 drivers/usb/host/xhci-exynos.c | 51 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h | 26 +++++++++++++++++
 drivers/usb/host/xhci-plat.c   | 38 ++++++++++++++++++++++++-
 drivers/usb/host/xhci-plat.h   |  2 ++
 6 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 40b5de597112..5a17a9b1fbff 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -53,6 +53,14 @@ config USB_XHCI_PLATFORM
 
 	  If unsure, say N.
 
+config USB_XHCI_EXYNOS
+	tristate "xHCI support for Samsung Exynos SoCs"
+	depends on USB_XHCI_PLATFORM
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	---help---
+	  Say 'Y' to enable the support for the xHCI host controller
+	  found in Samsung Exynos ARM SoCs.
+
 config USB_XHCI_HISTB
 	tristate "xHCI support for HiSilicon STB SoCs"
 	depends on USB_XHCI_PLATFORM && (ARCH_HISI || COMPILE_TEST)
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 84514f71ae44..34afd6680751 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -30,6 +30,9 @@ endif
 ifneq ($(CONFIG_USB_XHCI_RCAR), )
 	xhci-plat-hcd-y		+= xhci-rcar.o
 endif
+ifneq ($(CONFIG_USB_XHCI_EXYNOS), )
+	xhci-plat-hcd-y		+= xhci-exynos.o
+endif
 
 ifneq ($(CONFIG_DEBUG_FS),)
 	xhci-hcd-y		+= xhci-debugfs.o
diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
new file mode 100644
index 000000000000..446d33998382
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xHCI host controller driver for Samsung Exynos5 SoCs
+ *
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+
+#include "xhci.h"
+#include "xhci-plat.h"
+#include "xhci-exynos.h"
+
+int xhci_exynos_init_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct device *dev = hcd->self.controller;
+	struct xhci_plat_priv *xhci_priv = hcd_to_xhci_priv(hcd);
+	struct phy *usb2_generic_phy;
+	int ret;
+
+	usb2_generic_phy = devm_phy_get(dev->parent, "usb2-phy");
+	if (IS_ERR(usb2_generic_phy)) {
+		ret = PTR_ERR(usb2_generic_phy);
+		if (ret == -EPROBE_DEFER) {
+			return ret;
+		} else {
+			dev_err(dev, "no usb2 phy configured\n");
+			return ret;
+		}
+	}
+
+	phy_calibrate(usb2_generic_phy);
+	xhci_priv->priv = usb2_generic_phy;
+
+	xhci->quirks |= XHCI_RESET_ON_RESUME;
+
+	return 0;
+}
+
+int xhci_exynos_post_resume_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *xhci_priv = hcd_to_xhci_priv(hcd);
+	struct phy *usb2_generic_phy = xhci_priv->priv;
+
+	phy_calibrate(usb2_generic_phy);
+
+	return 0;
+}
diff --git a/drivers/usb/host/xhci-exynos.h b/drivers/usb/host/xhci-exynos.h
new file mode 100644
index 000000000000..58ea3e9aea8d
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * drivers/usb/host/xhci-exynos.h
+ *
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _XHCI_EXYNOS_H
+#define _XHCI_EXYNOS_H
+
+
+#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
+int xhci_exynos_init_quirk(struct usb_hcd *hcd);
+int xhci_exynos_post_resume_quirk(struct usb_hcd *hcd);
+#else
+static inline int xhci_exynos_init_quirk(struct usb_hcd *hcd)
+{
+	return 0;
+}
+
+static inline int xhci_exynos_post_resume_quirk(struct usb_hcd *hcd)
+{
+	return 0;
+}
+#endif
+#endif /* _XHCI_EXYNOS_H */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 998241f5fce3..6bc03cdb2f21 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -24,6 +24,7 @@
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
+#include "xhci-exynos.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -64,6 +65,16 @@ static int xhci_priv_resume_quirk(struct usb_hcd *hcd)
 	return priv->resume_quirk(hcd);
 }
 
+static int xhci_priv_post_resume_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->post_resume_quirk)
+		return 0;
+
+	return priv->post_resume_quirk(hcd);
+}
+
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	/*
@@ -102,6 +113,11 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
 	.init_quirk = xhci_mvebu_a3700_init_quirk,
 };
 
+static const struct xhci_plat_priv xhci_plat_samsung_exynos5 = {
+	.init_quirk = xhci_exynos_init_quirk,
+	.post_resume_quirk = xhci_exynos_post_resume_quirk,
+};
+
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
 	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
 	.init_quirk = xhci_rcar_init_quirk,
@@ -260,6 +276,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_reg_clk;
 
 	priv_match = of_device_get_match_data(&pdev->dev);
+	if (!priv_match) {
+		const struct platform_device_id *id =
+						   platform_get_device_id(pdev);
+		if (id)
+			priv_match = (const struct xhci_plat_priv *)
+								id->driver_data;
+	}
 	if (priv_match) {
 		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
 
@@ -413,7 +436,11 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return xhci_resume(xhci, 0);
+	ret = xhci_resume(xhci, 0);
+	if (ret)
+		return ret;
+
+	return xhci_priv_post_resume_quirk(hcd);
 }
 
 static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
@@ -447,9 +474,18 @@ static const struct acpi_device_id usb_xhci_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
 
+static struct platform_device_id xhci_plat_driver_ids[] = {
+	{
+		.name		= "exynos5-dwc3-xhci",
+		.driver_data	= (long) &xhci_plat_samsung_exynos5,
+	}, { },
+};
+MODULE_DEVICE_TABLE(platform, xhci_plat_driver_ids);
+
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
+	.id_table = xhci_plat_driver_ids,
 	.driver	= {
 		.name = "xhci-hcd",
 		.pm = &xhci_plat_pm_ops,
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index ae29f22ff5bd..f8a8e84b4ebe 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -12,9 +12,11 @@
 
 struct xhci_plat_priv {
 	const char *firmware_name;
+	void *priv;
 	void (*plat_start)(struct usb_hcd *);
 	int (*init_quirk)(struct usb_hcd *);
 	int (*resume_quirk)(struct usb_hcd *);
+	int (*post_resume_quirk)(struct usb_hcd *);
 };
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
-- 
2.17.1

