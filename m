Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27339C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E307320828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qOv2ErHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfF0HRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:17:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47715 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:17:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627071746euoutp023d0db8c3480bbdf75390a32f2578c13d~r-P6a_c1b2044920449euoutp02A;
        Thu, 27 Jun 2019 07:17:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627071746euoutp023d0db8c3480bbdf75390a32f2578c13d~r-P6a_c1b2044920449euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561619866;
        bh=ijdorqqTkcn1o5m8sGtGI6GyhJS7V9aRwUoQkFw7p7U=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=qOv2ErHzIekbzYxR/pZ3xlmMWP5Ld5MDBIOylDL9LAnFPV09aZmXU0OKaOokpx4f1
         Z+NAqu20suNXBfOnOanu1lW5ZTmQNEjkslEUys8hHbNe601tqiCzx+wFkZWU8SlDkQ
         ub3ZBu99Ok2QuHE+uKLTYSxo3rTvLCMaDLiGr/OA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627071745eucas1p1559f45320f6ea101c65ce9487dba63f9~r-P6EfmdH2386123861eucas1p1v;
        Thu, 27 Jun 2019 07:17:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.96.04377.99D641D5; Thu, 27
        Jun 2019 08:17:45 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627071745eucas1p1fa1b9d46e67b131522f49d73ac12d8ed~r-P5dDztj2388423884eucas1p1w;
        Thu, 27 Jun 2019 07:17:45 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-bb-5d146d999ce4
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.9A.04146.99D641D5; Thu, 27
        Jun 2019 08:17:45 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PTQ00HYSXLCML00@eusync4.samsung.com>;
        Thu, 27 Jun 2019 08:17:45 +0100 (BST)
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
Subject: [PATCH 2/3] usb: dwc3: exynos: Use Exynos specific XHCI-plat driver
 variant
Date:   Thu, 27 Jun 2019 09:17:25 +0200
Message-id: <20190627071726.30467-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190627071726.30467-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7djPc7ozc0ViDfacV7PYOGM9q8Wxtifs
        Fs2L17NZLP17j9Hi/PkN7BaXd81hs5hxfh+TxaJlrcwW6zbeYrdYe+QuUN2mKawO3B47Z91l
        91i85yWTx6ZVnWwe++euYffo27KK0WPDln8sHp83yQWwR3HZpKTmZJalFunbJXBlzPqyh7Hg
        rnbFrNbNTA2MO1W6GDk5JARMJPavecrexcjFISSwglHi0aE7bBDOZ0aJD/Na2GGq/l9ZzQJi
        CwksY5S4d7wMoug/o0THxhdMIAk2AUOJrrddbCC2iICDxJKlEJOYBf4zSUy/cYIVJCEsECYx
        82gD2FQWAVWJby+ngk3lFbCV6D2whBVim7zE6g0HmEFsTgE7iaPTJoPdJyGwhk1i2bkzzBBF
        LhJvp/9khLBlJDo7DjJBFDUzSjw8txaqo4dR4nLTDKgqa4nDxy+CrWAW4JOYtG060CQOoDiv
        REebEESJh8SO0zuZIf6cyChxfq3uBEaJBYwMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3
        MQLj9PS/4192MO76k3SIUYCDUYmHl2GPcKwQa2JZcWXuIUYJDmYlEd78MJFYId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYzRvHd2yCYv6jqwmyvg2YaI
        Jq3Glam8s27ZyuftZ8iOe8T67u9z1jndfoECx1aLLXxWFpBiJpDpFFkyYfNE0TDzSWcaPGc7
        XfxjXyzx68DTT7N1N/hsjfMVZNqk0jN/yrnKpvj/Udzlkxa7dRw78tN5SmgXY+Tehd+8rYPa
        r3wLlffe1rTlBJsSS3FGoqEWc1FxIgCy+3ohzwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsVy+t/xa7ozc0ViDVqXs1tsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo7hsUlJzMstSi/TtErgyZn3Zw1hw
        V7tiVutmpgbGnSpdjJwcEgImEv+vrGYBsYUEljBKzN9ZAWE3Mkm8/CMIYrMJGEp0ve1iA7FF
        BBwkliy9A2RzcTALNDJL/N5xlhUkISwQJjHzaAM7iM0ioCrx7eVUsKG8ArYSvQeWsEIsk5dY
        veEAM4jNKWAncXTaZHaIZbYSV9vXs09g5FnAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMj
        MOy2Hfu5eQfjpY3BhxgFOBiVeHhX7BSOFWJNLCuuzD3EKMHBrCTCmx8mEivEm5JYWZValB9f
        VJqTWnyIUZqDRUmct0PgYIyQQHpiSWp2ampBahFMlomDU6qBMWfLblMZ47meaZnhL763mZ7d
        XRl6bv8r5+D9HDM7n76+7X0rJ3rymU+zrH5dW9oTsNniyZQ10XpPxawXvlRd5baoujf/z7Lf
        zUwCP97GOMs+PTnvIHvK8U0/LnBu3fPmfRen1i0x14/SgY6xriEf3oZJm5e8P+wn/3VJo0im
        ZKga455JuUEMEUosxRmJhlrMRcWJAIazBdE3AgAA
X-CMS-MailID: 20190627071745eucas1p1fa1b9d46e67b131522f49d73ac12d8ed
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627071745eucas1p1fa1b9d46e67b131522f49d73ac12d8ed
References: <20190627071726.30467-1-m.szyprowski@samsung.com>
        <CGME20190627071745eucas1p1fa1b9d46e67b131522f49d73ac12d8ed@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5 SoCs needs to calibrate USB3.0 DRD PHY after every XHCI HCD
reset. This patch adds support for instantiating Exynos5-specific variant
of XHCI-plat driver, which handles the required USB3.0 DRD PHY
calibration.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc3/Kconfig       |  1 +
 drivers/usb/dwc3/core.c        |  1 +
 drivers/usb/dwc3/core.h        |  1 +
 drivers/usb/dwc3/dwc3-exynos.c | 64 +++++++++++++++++++++++-----------
 drivers/usb/dwc3/host.c        |  2 +-
 5 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 89abc6078703..badf86dfb027 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -67,6 +67,7 @@ config USB_DWC3_OMAP
 config USB_DWC3_EXYNOS
 	tristate "Samsung Exynos Platform"
 	depends on (ARCH_EXYNOS || COMPILE_TEST) && OF
+	select USB_XHCI_EXYNOS if USB_XHCI_PLATFORM
 	default USB_DWC3
 	help
 	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c9bb93a2c81e..baa029ceede9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1303,6 +1303,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				    &dwc->hsphy_interface);
 	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
 				 &dwc->fladj);
+	device_property_read_string(dev, "snps,xhci_variant", &dwc->hcd_name);
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3dd783b889cb..1b8f5f5814a4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1176,6 +1176,7 @@ struct dwc3 {
 	u8			tx_max_burst_prd;
 
 	const char		*hsphy_interface;
+	const char		*hcd_name;
 
 	unsigned		connected:1;
 	unsigned		delayed_status:1;
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index c1e9ea621f41..4e847073e85e 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/regulator/consumer.h>
@@ -35,22 +36,20 @@ struct dwc3_exynos {
 
 	struct regulator	*vdd33;
 	struct regulator	*vdd10;
+	struct platform_device	*dwc3;
 };
 
-static int dwc3_exynos_remove_child(struct device *dev, void *unused)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-
-	return 0;
-}
+static const struct property_entry dwc3_exynos_properties[] = {
+	PROPERTY_ENTRY_STRING("snps,xhci_variant", "exynos5-dwc3-xhci"),
+	{}
+};
 
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos;
 	struct device		*dev = &pdev->dev;
-	struct device_node	*node = dev->of_node;
+	struct device_node	*node = dev->of_node, *child;
+	struct platform_device	*dwc3;
 	const struct dwc3_exynos_driverdata *driver_data;
 	int			i, ret;
 
@@ -109,21 +108,43 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto vdd10_err;
 	}
 
-	if (node) {
-		ret = of_platform_populate(node, NULL, NULL, dev);
-		if (ret) {
-			dev_err(dev, "failed to add dwc3 core\n");
-			goto populate_err;
-		}
-	} else {
-		dev_err(dev, "no device node, failed to add dwc3 core\n");
-		ret = -ENODEV;
-		goto populate_err;
+	child = of_get_next_child(node, NULL);
+	if (!child) {
+		dev_err(dev, "Failed to find DWC3 core device node\n");
+		goto dwc3_child_err;
+	}
+
+	dwc3 = of_device_alloc(child, NULL, dev);
+	if (!dwc3) {
+		dev_err(dev, "Failed to allocate DWC3 core device\n");
+		goto dwc3_alloc_err;
+	}
+
+	dwc3->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dwc3->dev.dma_mask = &dwc3->dev.coherent_dma_mask;
+	dwc3->dev.bus = &platform_bus_type;
+
+	ret = platform_device_add_properties(dwc3, dwc3_exynos_properties);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add properties to DWC3 device\n");
+		goto dwc3_props_err;
+	}
+
+	ret = of_device_add(dwc3);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register DWC3 core device\n");
+		goto dwc3_props_err;
 	}
+	exynos->dwc3 = dwc3;
+	of_node_put(child);
 
 	return 0;
 
-populate_err:
+dwc3_props_err:
+	platform_device_put(dwc3);
+dwc3_alloc_err:
+	of_node_put(child);
+dwc3_child_err:
 	regulator_disable(exynos->vdd10);
 vdd10_err:
 	regulator_disable(exynos->vdd33);
@@ -142,7 +163,8 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 	int i;
 
-	device_for_each_child(&pdev->dev, NULL, dwc3_exynos_remove_child);
+	of_device_unregister(exynos->dwc3);
+	platform_device_put(exynos->dwc3);
 
 	for (i = exynos->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(exynos->clks[i]);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f55947294f7c..b526d0c78c3b 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -71,7 +71,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 	dwc->xhci_resources[1].flags = res->flags;
 	dwc->xhci_resources[1].name = res->name;
 
-	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
+	xhci = platform_device_alloc(dwc->hcd_name, PLATFORM_DEVID_AUTO);
 	if (!xhci) {
 		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
 		return -ENOMEM;
-- 
2.17.1

