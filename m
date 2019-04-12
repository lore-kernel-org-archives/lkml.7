Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F11C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7E02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hgQLpCvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDLMhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:37:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54594 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfDLMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so11028462wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmZNDj/ROqmmydwLVfrSm5YpHHAqTHz5p0ofV4c+h88=;
        b=hgQLpCvyQWkGA2+C2SVC+yttOyqCs79IPSMazHMDa5D/84A9fokZ/J6nVKCozEc+d/
         1wn1YKFAmx3OMtjLtetWgWH3h9ZRDkowGbxcMxoWdgx9zZlyfS7PvfBY3KKXcM5yHmEU
         7Nn65q9oRScO4qvbKi+HN2z5+PmH5mIzDZXfjcIqlul6bL9tdn+zrpu1lTVSgyaebUsI
         eJV2MjdxrBWTyLiMkQEJEj6FZV2t2One7G5SE/y0sjcstKtjupUgdhryil3RSNKAfRAG
         xIKrlA0oe450dJNe1BD79oWMG7wzq8gs0XrB130U127+8Gej98UNSFNEeEsGwBjsf652
         J6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmZNDj/ROqmmydwLVfrSm5YpHHAqTHz5p0ofV4c+h88=;
        b=DwsGPgUWFkgTwpymyaOYoKsQP31kj8+S241CZAO5D/jfmpPE3NYSRKkDAHM9pbA2cz
         BkmMrfIzHdDOsh0poR3rga+ToHyUVMnRq8sCP9zjYIWTKtld1iwLa3rv/JB10Eg1s+q/
         AnwgXFF/YeKQvRNyG6ahQeqCzEm3tsni7hD5RNwQuLog2e+GEsR+8Q5cqQX2bNEhDXp2
         m23UYg3di38TCxqNkL6EABkIc2ZZQ22OBhtvpEI8U2qzbcqpULn+8nAmh+AuJl7tA0dv
         Klqsv/Opvz3GpcknaTBuVk3/fKrg1SgeLmjv2EEu96HuTGba8+AVuSb67tmita8YSTvW
         yfaw==
X-Gm-Message-State: APjAAAVwQj3RmnyJVkeFCoiueeP/TrG3Ai0pGnOp9cofcqL7hi2nhc6n
        4okdDYS+nbN0/UWbu0e3JPQ7Ng==
X-Google-Smtp-Source: APXvYqwolTlOkBeqh0vywQsBopUex17ovDjGm26J7GwepQL2sUOHtRZs/QRwZB/kPFkyAVSqQrrnCw==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr11430786wmc.92.1555072606977;
        Fri, 12 Apr 2019 05:36:46 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id v190sm12384030wme.18.2019.04.12.05.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:36:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 3/6] usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
Date:   Fri, 12 Apr 2019 14:36:37 +0200
Message-Id: <20190412123640.11437-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412123640.11437-1-brgl@bgdev.pl>
References: <20190412123640.11437-1-brgl@bgdev.pl>
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
 drivers/usb/host/ohci-da8xx.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 209a262b5565..f69b339d45e5 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -202,12 +202,23 @@ static int ohci_da8xx_regulator_event(struct notifier_block *nb,
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
+	}
 
 	return IRQ_HANDLED;
 }
@@ -434,8 +445,9 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
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

