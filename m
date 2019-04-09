Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390C020643
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MBfSNNsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDII3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41222 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfDII3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so19653254wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p38pAuvIEjPOoMJmacPqD0dwSx+AzVUQhdkwsmJTYSE=;
        b=MBfSNNswpjRwqServDNjI2/BOiIcx9EC0oB1tqAD7fGW2Oowkm0RWHTlbKrCzhvsix
         0qy6xl8hhcUflELsLM2TQ9euS4q4Vr74Z6VlpX7DMAsRWqpl57h3aQb8CODjQLwmIqt7
         mwUIr3o4CyVQNSLQEG1To6NiOhVCR27Bz/jrjfAY7Psvg5ilDPHaXnKoUjaOt0zzT0RY
         9btINSJ2H3Cf3/0FzIlZLr0yrYn3Lmj3TvvY5gCaExsktVo5MHRwlIzQPUAPq17lmzES
         lScDYTVOZ43XjZMugEZTS4swgXx/G2dqXLWTX2gHboK4RdWYYpxTA1u/oodqSkk2AKlx
         3D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p38pAuvIEjPOoMJmacPqD0dwSx+AzVUQhdkwsmJTYSE=;
        b=WnsYnz/XepGPnNqCmO0LKUov9juDzwlK1RRrpF2gG4nI6Dy4JQc0Z+lsOzqB52sTn3
         cWyB4/0DEEjIG/giyaK0GJNtCoKlJVQHCezYy3/GUoynLuK9xyEu0lWxHdhN4ULKA7ZI
         m836r7MLq6/DVZtbu8bz3k2GR4MJKwqULC+v00oidJgmFCefXwzBxv0yreYIAcMWxqrq
         5zdeXXf++HMvYxLj5ABEVLsA2E/f3I5kLZnbWKyyUFwqQFF4o2+HJ+aIjnbrPgy+2wmg
         F5Dxuw2Ghk7H3i0mFNO+8w3CQYugj1pspR3Jfxb7vt2ozqjxxjvickFnxGvmhbTFNuE2
         gD+A==
X-Gm-Message-State: APjAAAWKGRPDwkXZnPtGpXfDZW8SAZKP8gszSoebi17X/dfa9ARnv2aJ
        Fccvvg11lTx0qbd9XjnL/by1TA==
X-Google-Smtp-Source: APXvYqwuqt0Q4a6XDmiEQ2O+wNjRnHQZTa83jRtPmEs026IXU9oxqaWK/TDBjMKzdwmzTeqqwOu5EQ==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr22158011wrs.173.1554798547426;
        Tue, 09 Apr 2019 01:29:07 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c20sm59968651wre.28.2019.04.09.01.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:29:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 6/6] usb: ohci-da8xx: drop the vbus GPIO
Date:   Tue,  9 Apr 2019 10:28:55 +0200
Message-Id: <20190409082855.15373-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409082855.15373-1-brgl@bgdev.pl>
References: <20190409082855.15373-1-brgl@bgdev.pl>
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
index 108fe0a1b962..9d1157beb508 100644
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

