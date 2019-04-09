Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB44D2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rc+kTt8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDII31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39376 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfDII3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so19678530wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a1ibeF6fSGxrtLocqohp3DOAYCn4qHHgfHueAd+c1xs=;
        b=rc+kTt8MY2foIoO6IjqRvTBpTQiETlG0C7fT9V7xOdJMWZEKp+lAiESGAKm99LXeXu
         T5xQLvJGPkdZatLGwgq7gk5rUuiTTglQKmV/sOshrcW29zByeTA5MPNfno0S8u/6eGuq
         3Bk9cHaoT3DXyZq/jSWydel7+s2mOogSSjxHmB593utiDAnkgd4i+VsS3Ls853Pzg2nm
         rFNO4FFcGBle4U+0Evd1zYEwZK0c+eK+EGNrD21XZSKGYovcqKxt5rF5znqRF8ong5fp
         elykfxGj6rwLp+F4N8t03WwjQMJxuIFYDt+Xx59ZRvexjbyaPin4+fO0MrMGORdLG9mV
         T1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1ibeF6fSGxrtLocqohp3DOAYCn4qHHgfHueAd+c1xs=;
        b=kCbAnIpwJy8kEGWH3G1/upL4i1sbP595qOXlVY5Nnp1jHQWV7vzB3nfgceUAooCwcM
         +5nORN70Z9oFOnoJp89gt5BmhBqziOgvxgbkU9roKebKULlm0n8PE4v4PHMbUG/9JYsk
         hlI8E31VLqwprDKIKw27F71lUrIWilDwapAu9GG96iRtwlOeYWH7j282R7jnhm33Q1db
         J6GeYPWeZBS7oaU7BNIaKRdTrWxoEFSAqr83AaTh5km3Xl4mHawJq5Ob0WKJOM6PVzUX
         XBCNnw+4hxajk0iTAuuzxr6H496c8JmKyUHxp0k4MqeYw1dBWLMPQhPG6/zHFC/lr/DR
         C5tQ==
X-Gm-Message-State: APjAAAWPaN8FrBD/7qRKl8JcW4c9+zu3y/ILgGx0II3ehahqTAOysVRH
        ZzSQqNT3krQEjaCidzFkhCuVYg==
X-Google-Smtp-Source: APXvYqysocVGytB4qAkrXJND7pGufXDa6d177/I7jwR3YsuT6GTfMd1DU/ZnHPgeW3VASAODo3gPGw==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr21891334wrr.1.1554798543888;
        Tue, 09 Apr 2019 01:29:03 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c20sm59968651wre.28.2019.04.09.01.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:29:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 3/6] usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
Date:   Tue,  9 Apr 2019 10:28:52 +0200
Message-Id: <20190409082855.15373-4-brgl@bgdev.pl>
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

Historically the power supply management in this driver has been handled
in two separate places in parallel. Device-tree users simply defined an
appropriate regulator, while two boards with no DT support (da830-evm and
omapl138-hawk) passed functions defined in their respective board files
over platform data. These functions simply used legacy GPIO calls to
watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
fires.

Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
updated these GPIO calls to the modern API and moved them inside the
driver.

This however is not the optimal solution for the vbus GPIO which should
be modeled as a fixed regulator that can be controlled with a GPIO.

In order to keep the overcurrent protection available once we move the
board files to using fixed regulators we need to disable the enable_reg
regulator when the overcurrent indicator interrupt fires. Since we
cannot call regulator_disable() from interrupt context, we need to
switch to using a oneshot threaded interrupt.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 9c6d1f03b871..108fe0a1b962 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -202,12 +202,24 @@ static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 	return 0;
 }
 
-static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
+static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = data;
+	struct device *dev = da8xx_ohci->hcd->self.controller;
+	int ret;
 
-	if (gpiod_get_value(da8xx_ohci->oc_gpio))
-		gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
+	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
+		if (da8xx_ohci->vbus_gpio) {
+			gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
+		} else if (da8xx_ohci->vbus_reg) {
+			ret = regulator_disable(da8xx_ohci->vbus_reg);
+			if (ret)
+				dev_err(dev,
+					"Failed to disable regulator: %d\n",
+					ret);
+		}
+			
+	}
 
 	return IRQ_HANDLED;
 }
@@ -434,8 +446,9 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		if (oc_irq < 0)
 			goto err;
 
-		error = devm_request_irq(dev, oc_irq, ohci_da8xx_oc_handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+		error = devm_request_threaded_irq(dev, oc_irq, NULL,
+				ohci_da8xx_oc_thread, IRQF_TRIGGER_RISING |
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"OHCI over-current indicator", da8xx_ohci);
 		if (error)
 			goto err;
-- 
2.21.0

