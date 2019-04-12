Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC62082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YG7aeotx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfDLMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:36:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44329 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfDLMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so11710674wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/Q4Spim9Fjjy6MSB+oYYlQqYCUhED1m+pmPurYYc2Y=;
        b=YG7aeotx3icHw05FTScZXtz6eI0WzRmPR9r6FmonoBSpKAOTJdRkCgx5hYrJ4ueMTy
         5jFE2sXMf9uyzDRvuLEzYgDWkJ4kXk6M3eIPBacFPpfE3nrH+0PjH6fRHsxA6p8iUpq2
         NsEBllK/RvsUb0h2tR79J0X3h5918f7qm3OUWmjN1jfK7aWhJD3CX9+u4OJogs44XfU9
         gLQ5pXtlIVpuVend1DdiQ9as/umwvNamToRP/2cAPtLCpat2QWYQqAwSw4ZzvjazMVo9
         XHELA+ILZQuO3XfWbLq1KSP/ag+jz9r+AXXwUKElxgOCphUpxpA3hs4B+GyVwUcAE8z4
         76cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/Q4Spim9Fjjy6MSB+oYYlQqYCUhED1m+pmPurYYc2Y=;
        b=P6PE6LZGg8k33P0zZmh8FahXW869vuTNVH8dH5JMy1aB5FRg5AQb+KNe1lJdww0uhQ
         gu4A1knxlS60eRq2PQ2KyofSYKVWZ7TamCjtHieRz499PPKYl+CF1n14T+Ixv2sFleVk
         jqe1y73VfTW/41SIhnEZrZ3BFDaxrpOIGOaMspjr7UAk9bEVgYPQvQO7cgdUucyGtQRV
         tkh+sm6nnN7GOP8a0qsixnb2sKcNNSLEbhDQeLr+1QH7Snuez3PdxN5vA9m/Xj/b5lbk
         G6DV/Gd42/niA+neK27vhSBHYHc/lnIlUAR7deijYoIojn6vpvnxGlbdYkVHEampcBUZ
         cwjA==
X-Gm-Message-State: APjAAAVUuBqWRa4Ya2OI5k7wiLZC/4oZqz5rMIJcGxUH2ZbUcYqhmal6
        +5siKH6YRqvLGPcE22c83piIuQ==
X-Google-Smtp-Source: APXvYqxUp4JTFAHxNl36SNcbXMkjwbVgonN366UairP79cquPxow05ayhQbaEoIG/Mmfw/Uo1FkIAA==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr35525249wro.152.1555072610418;
        Fri, 12 Apr 2019 05:36:50 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id v190sm12384030wme.18.2019.04.12.05.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:36:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 6/6] usb: ohci-da8xx: drop the vbus GPIO
Date:   Fri, 12 Apr 2019 14:36:40 +0200
Message-Id: <20190412123640.11437-7-brgl@bgdev.pl>
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

All users now setup a fixed regulator for the vbus supply. We can drop
the vbus GPIO code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-da8xx.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index f69b339d45e5..38183ac438c6 100644
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
 
@@ -208,16 +196,11 @@ static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
 	struct device *dev = da8xx_ohci->hcd->self.controller;
 	int ret;
 
-	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
-		if (da8xx_ohci->vbus_gpio) {
-			gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
-		} else if (da8xx_ohci->vbus_reg) {
-			ret = regulator_disable(da8xx_ohci->vbus_reg);
-			if (ret)
-				dev_err(dev,
-					"Failed to disable regulator: %d\n",
-					ret);
-		}
+	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio) &&
+	    da8xx_ohci->vbus_reg) {
+		ret = regulator_disable(da8xx_ohci->vbus_reg);
+		if (ret)
+			dev_err(dev, "Failed to disable regulator: %d\n", ret);
 	}
 
 	return IRQ_HANDLED;
@@ -431,11 +414,6 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
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

