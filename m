Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D517C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E61D2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aOyyfHUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfCZP5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:57:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34068 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731599AbfCZP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:57:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so15032135wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFSbPR6gZ80NJT0kvphV1uF3Ic6xnPJohJygHS7zRgQ=;
        b=aOyyfHUdTD+0/C9sDYB9DC3OSZ8vRYaurmgBJITGhusdwLsJ+dzzvg8NJz9IDzsEKa
         DPDRv1KfS3coVpzetOLZg95go1aCY7GmwKWqc31K3ocNQGJepodvoncJjGWy06H4kcYp
         9Gb71Rqh5Jzcn6fNi7A9BMsmFFNtDoUO2m6b2YMHBLlGa66B3BQCm5EtYI7BtytV5tD/
         3SyhpzCfA0ggyUSgzWpQO6TxliKpXsB0t+jOoFREzmuzEpLMHsWAp5i4fDxYVyutvgCB
         xpWXqq/4SvYmGf02ysXCWU12RYuHrRr+qaZiSDwOXAWrdm/3XrIn00HOcdMfIjXCk34q
         IoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFSbPR6gZ80NJT0kvphV1uF3Ic6xnPJohJygHS7zRgQ=;
        b=qtkTVY+YJ0U02/P10m4oqV7SrHjmZuqNc+sLaBHl+ttcxhlt+jo5ybj6KODZ1NgW+0
         +BYqLB3TmecRmTr6eutaFFK4ImBLDUQR6eXvC2ibvdNS//yPrR2wpL64fObWQY8xs4fx
         4p6PnQnraD2bNnl972nKilKTrmFh2CFUtNSz9dFYlBZE/5nXRhNVWu81mGlCancMqhv4
         lZQCShnZg2NE7u1YUYtTaqDFP3A1K2LPo7GDdU7yJFZFjjyF6oJ2FT4VtxtTrc3/0E50
         IUSmfEwA1E7D07UyzbjrKerNjKfDW1+MMvVlMxfmR1f+n0HL4iNmiCN9FqJ3NOBVBiWd
         1jVg==
X-Gm-Message-State: APjAAAWXdpJ1BOTNmKwPklHVZWR6f49ID/sF/hcj7XsxIkgpf1LrWzEa
        +VLIVElAd6FFGIOBNVy+ZPkdPqKCT18=
X-Google-Smtp-Source: APXvYqyOFnJbEHiLStnWxm6A9moQpJBYz65AYo7mBV9PirflEkXMHvaAZxVw5xKdY8jUrFUkgHxdVA==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr21129403wrq.151.1553615859235;
        Tue, 26 Mar 2019 08:57:39 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 204sm28522999wmc.1.2019.03.26.08.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:57:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/3] usb: ohci-da8xx: drop the vbus GPIO
Date:   Tue, 26 Mar 2019 16:57:28 +0100
Message-Id: <20190326155728.5432-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326155728.5432-1-brgl@bgdev.pl>
References: <20190326155728.5432-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users now setup a fixed regulator for the vbus supply. We can drop
the vbus GPIO code. We need to modify the over-current interrupt
handler to use a threaded irq as we cannot disable a regulator from
interrupt context.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 39 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index ca8a94f15ac0..f3892034de58 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -41,7 +41,6 @@ struct da8xx_ohci_hcd {
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
 	unsigned int reg_enabled;
-	struct gpio_desc *vbus_gpio;
 	struct gpio_desc *oc_gpio;
 };
 
@@ -92,11 +91,6 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 	struct device *dev = hcd->self.controller;
 	int ret;
 
-	if (da8xx_ohci->vbus_gpio) {
-		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, on);
-		return 0;
-	}
-
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
@@ -124,9 +118,6 @@ static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 
-	if (da8xx_ohci->vbus_gpio)
-		return gpiod_get_value_cansleep(da8xx_ohci->vbus_gpio);
-
 	if (da8xx_ohci->vbus_reg)
 		return regulator_is_enabled(da8xx_ohci->vbus_reg);
 
@@ -159,9 +150,6 @@ static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 
-	if (da8xx_ohci->vbus_gpio)
-		return 1;
-
 	if (da8xx_ohci->vbus_reg)
 		return 1;
 
@@ -211,7 +199,16 @@ static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
 	struct da8xx_ohci_hcd *da8xx_ohci = data;
 
 	if (gpiod_get_value(da8xx_ohci->oc_gpio))
-		gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
+		return IRQ_WAKE_THREAD;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
+{
+	struct da8xx_ohci_hcd *da8xx_ohci = data;
+
+	regulator_disable(da8xx_ohci->vbus_reg);
 
 	return IRQ_HANDLED;
 }
@@ -424,11 +421,6 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
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
@@ -438,9 +430,14 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		if (oc_irq < 0)
 			goto err;
 
-		error = devm_request_irq(dev, oc_irq, ohci_da8xx_oc_handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				"OHCI over-current indicator", da8xx_ohci);
+		error = devm_request_threaded_irq(dev, oc_irq,
+						  ohci_da8xx_oc_handler,
+						  ohci_da8xx_oc_thread,
+						  IRQF_TRIGGER_RISING |
+						  IRQF_TRIGGER_FALLING |
+						  IRQF_ONESHOT,
+						  "OHCI over-current indicator",
+						  da8xx_ohci);
 		if (error)
 			goto err;
 	}
-- 
2.20.1

