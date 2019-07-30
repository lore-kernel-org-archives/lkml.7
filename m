Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649F1C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C1B20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUBllZ0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfG3SSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:13 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42748 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbfG3SQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:37 -0400
Received: by mail-pf1-f180.google.com with SMTP id q10so30248484pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFBugelIB7I8z4cy5abhXFxwmRdCQ/NaAVq/fljfFQg=;
        b=DUBllZ0mAggJZuUUb7vFEYrOKYBQMcqLmkGKBUHKGhnRthEmpb4V4B176dkyokIrbm
         U1Tyv/H1EiTYe23PTlUDcH5kiuwOxXclK+OM56Wb6pgqou7J1Ko55TFANP26kYVLns0s
         4DxFRz+aGt7uJUNG+Ff+7IpiHXTvJc8m+j40A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFBugelIB7I8z4cy5abhXFxwmRdCQ/NaAVq/fljfFQg=;
        b=DNrlb01UV7VHbljfjENghl5AG1GO+k2/6TXB+cjeR8C8a1EReqjkiUowDLWNW7ixH7
         uvDRb1PVDJXLy7JK4/+C1l32M5O6j8lD2lAvs7mHd51cauc3VRvpoKorHZ1qnUW7LNul
         JUsJhlZ7Wj5jRefSnarCCTHj38O5rXS/VWgiuI1E5NC4fPxyhgW4R1kK/2+e3bbrEQ3+
         /H7J1HUofag6FS25H86VTcr9z0GTz9k+Xi5rZDQHtlBuZVJHgIBK/uOTjXPNiHXd3VmH
         Y2Vhq4YH6fVtb9VAgfN2zvZiaGB23dDEl+E3kLpg2J903P8ibLmAChdZevncMjzPxgDM
         Ixeg==
X-Gm-Message-State: APjAAAVtylIVKP8biB/dXkKQb8tDyKrojZj8iyoDveVQWNFRriD/U+x5
        Yj/8AX2WJojg39HUtif1RZ0Lg6BXSuGFsQ==
X-Google-Smtp-Source: APXvYqw++e//LBUtxeiPk00rIVavVGA5jBcaXyIS6FCEyUEhDADg16eyDnpjK4oGv7OuBMwHYRSEFg==
X-Received: by 2002:aa7:8383:: with SMTP id u3mr43267517pfm.175.1564510596341;
        Tue, 30 Jul 2019 11:16:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v6 46/57] usb: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:46 -0700
Message-Id: <20190730181557.90391-47-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/usb/chipidea/core.c               |  1 -
 drivers/usb/dwc2/platform.c               |  4 +---
 drivers/usb/dwc3/dwc3-keystone.c          |  1 -
 drivers/usb/dwc3/dwc3-omap.c              |  4 +---
 drivers/usb/gadget/udc/aspeed-vhub/core.c |  1 -
 drivers/usb/gadget/udc/bcm63xx_udc.c      |  8 ++------
 drivers/usb/gadget/udc/bdc/bdc_core.c     |  4 +---
 drivers/usb/gadget/udc/gr_udc.c           |  8 ++------
 drivers/usb/gadget/udc/lpc32xx_udc.c      |  5 +----
 drivers/usb/gadget/udc/renesas_usb3.c     |  4 +---
 drivers/usb/gadget/udc/s3c-hsudc.c        |  4 +---
 drivers/usb/gadget/udc/udc-xilinx.c       |  4 +---
 drivers/usb/host/ehci-atmel.c             |  3 ---
 drivers/usb/host/ehci-omap.c              |  4 +---
 drivers/usb/host/ehci-orion.c             |  3 ---
 drivers/usb/host/ehci-platform.c          |  4 +---
 drivers/usb/host/ehci-sh.c                |  3 ---
 drivers/usb/host/ehci-st.c                |  4 +---
 drivers/usb/host/imx21-hcd.c              |  4 +---
 drivers/usb/host/ohci-platform.c          |  4 +---
 drivers/usb/host/ohci-st.c                |  4 +---
 drivers/usb/mtu3/mtu3_core.c              |  4 +---
 drivers/usb/phy/phy-ab8500-usb.c          | 12 +++---------
 drivers/usb/typec/tcpm/wcove.c            |  4 +---
 24 files changed, 22 insertions(+), 79 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 26062d610c20..36c964cd40a3 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1008,7 +1008,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	ci->irq = platform_get_irq(pdev, 0);
 	if (ci->irq < 0) {
-		dev_err(dev, "missing IRQ\n");
 		ret = ci->irq;
 		goto deinit_phy;
 	}
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 80fd3c6dcd1c..3c6ce09a6db5 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -407,10 +407,8 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	spin_lock_init(&hsotg->lock);
 
 	hsotg->irq = platform_get_irq(dev, 0);
-	if (hsotg->irq < 0) {
-		dev_err(&dev->dev, "missing IRQ resource\n");
+	if (hsotg->irq < 0)
 		return hsotg->irq;
-	}
 
 	dev_dbg(hsotg->dev, "registering common handler for irq%d\n",
 		hsotg->irq);
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index cbee5fb9b9fb..a69eb4a7b832 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -112,7 +112,6 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing irq\n");
 		error = irq;
 		goto err_irq;
 	}
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index ed8b86517675..6f711d58d82f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -469,10 +469,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index db3628be38c0..c08d385e2723 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -348,7 +348,6 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	/* Find interrupt and install handler */
 	vhub->irq = platform_get_irq(pdev, 0);
 	if (vhub->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get interrupt\n");
 		rc = vhub->irq;
 		goto err;
 	}
diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index c1fcc77403ea..97b16463f3ef 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2328,10 +2328,8 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 
 	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource #0\n");
+	if (irq < 0)
 		goto out_uninit;
-	}
 	if (devm_request_irq(dev, irq, &bcm63xx_udc_ctrl_isr, 0,
 			     dev_name(dev), udc) < 0)
 		goto report_request_failure;
@@ -2339,10 +2337,8 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	/* IRQ resources #1-6: data interrupts for IUDMA channels 0-5 */
 	for (i = 0; i < BCM63XX_NUM_IUDMA; i++) {
 		irq = platform_get_irq(pdev, i + 1);
-		if (irq < 0) {
-			dev_err(dev, "missing IRQ resource #%d\n", i + 1);
+		if (irq < 0)
 			goto out_uninit;
-		}
 		if (devm_request_irq(dev, irq, &bcm63xx_udc_data_isr, 0,
 				     dev_name(dev), &udc->iudma[i]) < 0)
 			goto report_request_failure;
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index ccbd1d34eb2a..cc4a16e253ac 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -515,10 +515,8 @@ static int bdc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "platform_get_irq failed:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	spin_lock_init(&bdc->lock);
 	platform_set_drvdata(pdev, bdc);
 	bdc->irq = irq;
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 729e60e49564..7a0e9a58c2d8 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2134,19 +2134,15 @@ static int gr_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	dev->irq = platform_get_irq(pdev, 0);
-	if (dev->irq <= 0) {
-		dev_err(dev->dev, "No irq found\n");
+	if (dev->irq <= 0)
 		return -ENODEV;
-	}
 
 	/* Some core configurations has separate irqs for IN and OUT events */
 	dev->irqi = platform_get_irq(pdev, 1);
 	if (dev->irqi > 0) {
 		dev->irqo = platform_get_irq(pdev, 2);
-		if (dev->irqo <= 0) {
-			dev_err(dev->dev, "Found irqi but not irqo\n");
+		if (dev->irqo <= 0)
 			return -ENODEV;
-		}
 	} else {
 		dev->irqi = 0;
 	}
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5f1b14f3e5a0..e9cf20979bf6 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3061,11 +3061,8 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	/* Get IRQs */
 	for (i = 0; i < 4; i++) {
 		udc->udp_irq[i] = platform_get_irq(pdev, i);
-		if (udc->udp_irq[i] < 0) {
-			dev_err(udc->dev,
-				"irq resource %d not available!\n", i);
+		if (udc->udp_irq[i] < 0)
 			return udc->udp_irq[i];
-		}
 	}
 
 	udc->udp_baseaddr = devm_ioremap_resource(dev, res);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 87062d22134d..027a25694a68 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2743,10 +2743,8 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 		priv = of_device_get_match_data(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	usb3 = devm_kzalloc(&pdev->dev, sizeof(*usb3), GFP_KERNEL);
 	if (!usb3)
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 31c7c5587cf9..858993c73442 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1311,10 +1311,8 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 	s3c_hsudc_setup_ep(hsudc);
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "unable to obtain IRQ number\n");
+	if (ret < 0)
 		goto err_res;
-	}
 	hsudc->irq = ret;
 
 	ret = devm_request_irq(&pdev->dev, hsudc->irq, s3c_hsudc_irq, 0,
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index b1f4104d1283..29d8e5f8bb58 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -2074,10 +2074,8 @@ static int xudc_probe(struct platform_device *pdev)
 		return PTR_ERR(udc->addr);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, xudc_irq, 0,
 			       dev_name(&pdev->dev), udc);
 	if (ret < 0) {
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 3ba140ceaf52..e893467d659c 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -100,9 +100,6 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
 		retval = -ENODEV;
 		goto fail_create_hcd;
 	}
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7d20296cbe9f..fc125b3d06e7 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -115,10 +115,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "EHCI irq failed: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 790acf3633e8..a319b1df3011 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -223,9 +223,6 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
 		err = -ENODEV;
 		goto err;
 	}
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 4c306fb6b069..769749ca5961 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -145,10 +145,8 @@ static int ehci_platform_probe(struct platform_device *dev)
 	}
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
 			     dev_name(&dev->dev));
diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index a9ee767952c1..ef75b9d70eb4 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -85,9 +85,6 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
 		ret = -ENODEV;
 		goto fail_create_hcd;
 	}
diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index ccb4e611001d..f74433aac948 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -158,10 +158,8 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 		return -ENODEV;
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res_mem) {
 		dev_err(&dev->dev, "no memory resource provided");
diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c
index 6e3dad19d369..e406c5459a97 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -1836,10 +1836,8 @@ static int imx21_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(&imx21_hc_driver,
 		&pdev->dev, dev_name(&pdev->dev));
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 65a1c3fdc88c..7addfc2cbadc 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -111,10 +111,8 @@ static int ohci_platform_probe(struct platform_device *dev)
 		return err;
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
 			dev_name(&dev->dev));
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index 638a92bd2cdc..ac796ccd93ef 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -138,10 +138,8 @@ static int st_ohci_platform_probe(struct platform_device *dev)
 		return -ENODEV;
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 
 	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res_mem) {
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f8bd1d57e795..c3d5c1206eec 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -835,10 +835,8 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 		return -ENOMEM;
 
 	mtu->irq = platform_get_irq(pdev, 0);
-	if (mtu->irq < 0) {
-		dev_err(dev, "fail to get irq number\n");
+	if (mtu->irq < 0)
 		return mtu->irq;
-	}
 	dev_info(dev, "irq %d\n", mtu->irq);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mac");
diff --git a/drivers/usb/phy/phy-ab8500-usb.c b/drivers/usb/phy/phy-ab8500-usb.c
index aaf363f19714..bda3ac2a321e 100644
--- a/drivers/usb/phy/phy-ab8500-usb.c
+++ b/drivers/usb/phy/phy-ab8500-usb.c
@@ -712,10 +712,8 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 
 	if (ab->flags & AB8500_USB_FLAG_USE_LINK_STATUS_IRQ) {
 		irq = platform_get_irq_byname(pdev, "USB_LINK_STATUS");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "Link status irq not found\n");
+		if (irq < 0)
 			return irq;
-		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_link_status_irq,
 				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
@@ -728,10 +726,8 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 
 	if (ab->flags & AB8500_USB_FLAG_USE_ID_WAKEUP_IRQ) {
 		irq = platform_get_irq_byname(pdev, "ID_WAKEUP_F");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "ID fall irq not found\n");
+		if (irq < 0)
 			return irq;
-		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_disconnect_irq,
 				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
@@ -744,10 +740,8 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 
 	if (ab->flags & AB8500_USB_FLAG_USE_VBUS_DET_IRQ) {
 		irq = platform_get_irq_byname(pdev, "VBUS_DET_F");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "VBUS fall irq not found\n");
+		if (irq < 0)
 			return irq;
-		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_disconnect_irq,
 				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 6b317c150bdd..edc271da14f4 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -617,10 +617,8 @@ static int wcove_typec_probe(struct platform_device *pdev)
 	wcove->regmap = pmic->regmap;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
 	if (irq < 0)
-- 
Sent by a computer through tubes

