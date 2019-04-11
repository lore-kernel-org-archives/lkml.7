Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F73C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E2F20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kTqCVK7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfDKJaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:30:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43796 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfDKJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:30:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so1698880wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLM5OGxjE0bCxoX8JlJuO36BhilSPuFc/F1r8G6fLDQ=;
        b=kTqCVK7KW2nICs9vZ+KD+6b+DSOAtYDAxd86WeMhviCAJ5AzDCPp54RhmjT6bIRh19
         HRFMGkRlpJts4gmBdMQY1SY/DZe1leK7jg9x+LBo78FLcJxzYGWvYUJA3o/CeP6B7If7
         1bgQ7hQIXj8lIuZn7A9v69OzDJ3a1KHVEL4QWCpj6AltXKu/zU7FpVJeXEI52IUV0D5P
         pGCCi+IcQr3uIqPX3SVNJrCm6vdRovYoX40RmU0qAqMgvq0y40ON2qmDnF8sm9e2iRFE
         S3GS9JBqjq25/qyVNtIhsYPtitZ1i6Pe2Xz0EKmK3hDB9my1C6desP/0xkBu8xsR1BAr
         RoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLM5OGxjE0bCxoX8JlJuO36BhilSPuFc/F1r8G6fLDQ=;
        b=nQGQVYXGvgQXFBRYU9HrliHxLgRJ0yrNPWKe2m8iTjBiXvYRzDw+BpARcGbM67X8u1
         RO0a8z/I5r0V+Ebgy8S8E51lu+qlslUDPERgPeBZLo20LQ0zoAT+cHRoZQHnttbHTalO
         qZXBcggW0B7+eZ6fwyULqqp9NDyx3KVm35JkjEqoLwzrpFdJdK97dnWHik8oaiRjgsTW
         Z4x2Kjsc7usoOeRs7RSiHOxJrvaj4zMPhRxoG7eCOWaknVNvaQ8slDF6+7ekg9bkdlaW
         L6cfWA/YzNyQmZJUUWjiVvkfgBAGA0Kq6r2Lk4ody1hk+Uq3sffGjPvFiSa7u0x9+AIo
         YeGA==
X-Gm-Message-State: APjAAAUxGLKiOqh9XPAMxo8HpZQpRKah6H/Q5iFdzLYSGYpPhL90w/2P
        g+/9UEZuiNAGi+CvH2y3p32s9g==
X-Google-Smtp-Source: APXvYqyHM8EWTB/2wtehfWQZl0eBdijqY2jIKEOZfGb6/5GYPgQzV9nBvd7auUSU0dkB6PodjxgjQQ==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr29648948wrx.80.1554975033237;
        Thu, 11 Apr 2019 02:30:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a9sm37517228wrt.29.2019.04.11.02.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:30:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 3/6] usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
Date:   Thu, 11 Apr 2019 11:30:21 +0200
Message-Id: <20190411093024.23555-4-brgl@bgdev.pl>
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
index 209a262b5565..6158408b1ea0 100644
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

