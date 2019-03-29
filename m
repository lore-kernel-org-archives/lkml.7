Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E388C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27672082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CUQ7KKfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfC2Jdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:33:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37731 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfC2Jdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so1964432wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxVFTCKVfhfrjJriQ7IFcj6eKhxdNdDEXDDI5+KStxc=;
        b=CUQ7KKfdW8+ryhjSUNXaiFX89azn2tYpx2isT2sVjj6MMYlDDZb59OKxxSo4i5+is9
         jcPishfNrPUJLOkdwWo2BPE2E4sr7Cdu+VK+J4/kdk3jUigrmH77ObhZrQVGNpg2ebbG
         7sa6hG2AgJmcIxOE0cST8nIBPDVRCpGo4O/sjbvzF+IUiTzbw7Rlac7HUq5LvkRRzmno
         idvbBMW2bAe3nTKKP27RmtWsivWJdLV68yw8/xHWELdO/BHC1GFd7f2NwYbTcowSkXTg
         VHQ/xjeGtJ6VzOPNkqQtxFDLscOLzh7ewjH2aCcx/sAyRh6ePgeHgsVcFK+Zo8VeoqXa
         kD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxVFTCKVfhfrjJriQ7IFcj6eKhxdNdDEXDDI5+KStxc=;
        b=iH/oxsweYkizBwg2tuIrjhj4/XBhz8aUFzMr3FFEjxzvMHH8+fwA3NGTLU/WavOtqn
         WPZI4y566vvxJ3WHdY1uQHyoD8biQf34o4dmWJ2YiDt03oeLHyWReBnlwwT7thM3HZsx
         lY9T+n5bCP6gIJfPhYBNfI6Mp4SyFX5AeVzAMm6Y+qO3BO4Y9OzCdYWgMNj/BmpJa8kX
         Y3QNbcNPK4qWJ/xjPAKt5IKgCy/YWvsb6g55ocEH+EQ/WInYAF9P5Gx7KoZG2YAoQh3W
         HBmQdedVW05bWlhINBzjNIk7nfKZR4yPbC1XcOBLEhmYEHnHBKzUElWpRwGYgti65DKW
         /QwA==
X-Gm-Message-State: APjAAAXx0LDFbCKSwf9aTfvcCbN4/9j4GXfV6I6YiLzq757rPQQn/KK5
        RyYEk6GPFpsQV/39U1tsIF3/8Q==
X-Google-Smtp-Source: APXvYqy+zZg4B2VxgIKMbzMvBv4CBQGWIh4gIel8gfANT8NUSAkwF5Q59QfXQdw6RoUD5ZGBE3xtyQ==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr1145423wmd.22.1553852025666;
        Fri, 29 Mar 2019 02:33:45 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/6] usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
Date:   Fri, 29 Mar 2019 10:33:31 +0100
Message-Id: <20190329093334.3885-4-brgl@bgdev.pl>
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
 drivers/usb/host/ohci-da8xx.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 9c6d1f03b871..35eb2cb96a8f 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -206,8 +206,25 @@ static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = data;
 
-	if (gpiod_get_value(da8xx_ohci->oc_gpio))
-		gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
+	if (gpiod_get_value(da8xx_ohci->oc_gpio)) {
+		if (da8xx_ohci->vbus_gpio)
+			gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
+		else if (da8xx_ohci->vbus_reg)
+			return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
+{
+	struct da8xx_ohci_hcd *da8xx_ohci = data;
+	struct device *dev = da8xx_ohci->hcd->self.controller;
+	int ret;
+
+	ret = regulator_disable(da8xx_ohci->vbus_reg);
+	if (ret)
+		dev_err(dev, "Failed to disable regulator: %d\n", ret);
 
 	return IRQ_HANDLED;
 }
@@ -434,9 +451,11 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		if (oc_irq < 0)
 			goto err;
 
-		error = devm_request_irq(dev, oc_irq, ohci_da8xx_oc_handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				"OHCI over-current indicator", da8xx_ohci);
+		error = devm_request_threaded_irq(dev, oc_irq,
+				ohci_da8xx_oc_handler, ohci_da8xx_oc_thread,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT, "OHCI over-current indicator",
+				da8xx_ohci);
 		if (error)
 			goto err;
 	}
-- 
2.21.0

