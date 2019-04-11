Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB25C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0474220850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LlyzkDPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfDKJas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:30:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44094 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfDKJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:30:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so6344922wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GEMwZ7dACVPBfzPjV5lUAEHUp2v66lOC+jNy0RoKMOY=;
        b=LlyzkDPYBbaZhaZxDaCJQeEcRJlsiMK88jKOOYPHgM4JHgEAMT4mXUIzyQ4bGj/Sho
         HPL+a898sCKZQFA3IkjD8+Tg0UXsxgqVymMXWuakC1Xa6dk7F8Oni4qVjc5FsCT1UBSL
         UDXgxaYCostRpOyFVQYM5l3mJ5IWlZLLFfHEPD7m0rNDIvw7t8pygFYCx+ExK93cggyE
         ZgMRZteuozoCHXFz0u97rjYaLukxANYOREJNMzFABXsUV12i1tQEgEa3HJ5gzYhVfYk2
         ToSma/VCEARgw+B7FrjK+FNXa6LHzwlXtwuCHrE1kFxwbBSkIbUQYqijq/NykWbxEj5M
         vInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEMwZ7dACVPBfzPjV5lUAEHUp2v66lOC+jNy0RoKMOY=;
        b=E3B+SZaWlFUFucI+xhDIbK1zTkW/xIiM3r+RbCsmRTrM506kywEQcT6jovO6+TtFYX
         tdet+/sXMcGjWdJz72slmEK+VOEdMU+iZR/ZGW9eIkUePluWGDbdVWf2/j1PVYUKHzjy
         MtO4Zr04ZGdLDCXnzhCk3lQ2MwOXBa9AuJquUyaUCpAGQ2hZVeJ+aU1vz/v0EK0SaFet
         yXY2r2+4UhkhUOQNutae5k7+S+4DBo1icIeJVvMeGHTP2tnKB8j0ZN3ub4LW/Cf9AhB7
         JheLyNKq78D9TFj4HQYqcksikNZ3Gi4LaOvqtk81TkQn/i/XlH1TIFo186XgkctI9/uN
         qpHw==
X-Gm-Message-State: APjAAAU+eLutF2pSEUEMQciuxpgX1kgrPAkrZPrfyTC2FoP1/NW6zxVO
        EHQ3MLxUXIJVqQfMxtSgul94bg==
X-Google-Smtp-Source: APXvYqzCqKZqTCUAbmAkyBuRWTsPX7ZNDJpnNQwb4R31fGKGfvuHcm/TQXGa4undHOlTqs9Fw2CNog==
X-Received: by 2002:adf:e449:: with SMTP id t9mr29387776wrm.204.1554975036963;
        Thu, 11 Apr 2019 02:30:36 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a9sm37517228wrt.29.2019.04.11.02.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:30:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 6/6] usb: ohci-da8xx: drop the vbus GPIO
Date:   Thu, 11 Apr 2019 11:30:24 +0200
Message-Id: <20190411093024.23555-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411093024.23555-1-brgl@bgdev.pl>
References: <20190411093024.23555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users now setup a fixed regulator for the vbus supply. We can drop
the vbus GPIO code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-da8xx.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 6158408b1ea0..674641c94c9e 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -40,7 +40,6 @@ struct da8xx_ohci_hcd {
 	struct phy *usb11_phy;
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
-	struct gpio_desc *vbus_gpio;
 	struct gpio_desc *oc_gpio;
 };
 
@@ -91,11 +90,6 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 	struct device *dev = hcd->self.controller;
 	int ret;
 
-	if (da8xx_ohci->vbus_gpio) {
-		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, on);
-		return 0;
-	}
-
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
@@ -120,9 +114,6 @@ static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 
-	if (da8xx_ohci->vbus_gpio)
-		return gpiod_get_value_cansleep(da8xx_ohci->vbus_gpio);
-
 	if (da8xx_ohci->vbus_reg)
 		return regulator_is_enabled(da8xx_ohci->vbus_reg);
 
@@ -155,9 +146,6 @@ static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 
-	if (da8xx_ohci->vbus_gpio)
-		return 1;
-
 	if (da8xx_ohci->vbus_reg)
 		return 1;
 
@@ -209,9 +197,7 @@ static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
 	int ret;
 
 	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
-		if (da8xx_ohci->vbus_gpio) {
-			gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
-		} else if (da8xx_ohci->vbus_reg) {
+		if (da8xx_ohci->vbus_reg) {
 			ret = regulator_disable(da8xx_ohci->vbus_reg);
 			if (ret)
 				dev_err(dev,
@@ -432,11 +418,6 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		}
 	}
 
-	da8xx_ohci->vbus_gpio = devm_gpiod_get_optional(dev, "vbus",
-							GPIOD_OUT_HIGH);
-	if (IS_ERR(da8xx_ohci->vbus_gpio))
-		goto err;
-
 	da8xx_ohci->oc_gpio = devm_gpiod_get_optional(dev, "oc", GPIOD_IN);
 	if (IS_ERR(da8xx_ohci->oc_gpio))
 		goto err;
-- 
2.21.0

