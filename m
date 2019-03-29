Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66873C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345D621773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dPoePFfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfC2Jdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:33:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37096 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfC2Jdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so1715542wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GP71nrEz2X3rw8lQrVpt+CoiTCN65NyK/tNcu9jk+HM=;
        b=dPoePFfuN4kBvyabdGTpC3H2E0TFZ2RIh1sUkDEajwe6gyeyIDKQCtj6SBh8WBjg6q
         9g8yAQ7YtC5Zphy68e/UDohmEh50c8yrmgICTE+52kGMLdSKtvCvDqO3Yv5tK/vpMNK8
         XNDR9sXOVasozdiRyAiu6+lo++5VdekKialK3tsX17V1Bi/PruMptVBl3UkO9KZbAdGW
         o3Rm3HEJP43/vPD9T1ODdryZduS7xTX7lZ2V3+LBExU6/Ny6JUE6hbju0+UFq4rVsoEb
         NS6qHudSnnvDnZjsJBSrZksEUhbmH/X6JVDfb8gafgMAVKxiRTdpvt1z0JsyGiZ9dmq0
         a3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GP71nrEz2X3rw8lQrVpt+CoiTCN65NyK/tNcu9jk+HM=;
        b=i6O+6KxCNDUMusMeeGmylASo6+Tr0mVMHnHCqNrX4AB+joyYjNeMfs1GsVc5l0ZzkI
         b39VlVqEW2Ky+MESpYTlblmofMT7noY7/FwTbBMR80bmkbbmXw1DwWuQn3m+PRkvoynJ
         VeXkde78RYPVrOQjGP9FHh6Izc6O8YG2uD/MuSRu72F03f84gbHK5wxBHpDIEKWO0qxn
         l4k4iqWhqIZlVa9vsIagWiuEX7ym7q3etaWIAmdAQ7M3pt/kw41yMtuCSP9H8PYospew
         xqs8l/vJtndLU20r1budubjOxltSojrPIiecWzVec0uBiCClufxnhPQ3FRYdvKGUUCOh
         vvlw==
X-Gm-Message-State: APjAAAWpnq42Af/IkZgPrnunE2A7OyTR+eUnf50bTp2n2rbaYl7LJKTZ
        9wKoWmweb9qGR7CSgJAjs6BOjugcdbM=
X-Google-Smtp-Source: APXvYqx2tOQhgDugwDc3oTfArC3GBendxfodPg6UHJto8zVnrsKrIOmsARKO7o8B0TARyoTapdtG5A==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr31002027wrr.145.1553852029302;
        Fri, 29 Mar 2019 02:33:49 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 6/6] usb: ohci-da8xx: drop the vbus GPIO
Date:   Fri, 29 Mar 2019 10:33:34 +0100
Message-Id: <20190329093334.3885-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329093334.3885-1-brgl@bgdev.pl>
References: <20190329093334.3885-1-brgl@bgdev.pl>
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
---
 drivers/usb/host/ohci-da8xx.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 35eb2cb96a8f..ef27f9126cca 100644
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
 
@@ -207,9 +195,7 @@ static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
 	struct da8xx_ohci_hcd *da8xx_ohci = data;
 
 	if (gpiod_get_value(da8xx_ohci->oc_gpio)) {
-		if (da8xx_ohci->vbus_gpio)
-			gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
-		else if (da8xx_ohci->vbus_reg)
+		if (da8xx_ohci->vbus_reg)
 			return IRQ_WAKE_THREAD;
 	}
 
@@ -437,11 +423,6 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
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

