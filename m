Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A127C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16F32465E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLgV18T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfLIMUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:20:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44667 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfLIMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:20:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so7149681pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaDYqsyc1Amfj+rSgV5LdqRPEszOSqeoO5bxQF6wI/8=;
        b=HLgV18T+ucI2mKJgCw3vbomZ0tuzLu/7/QH2PtjQy299n5JyYS+Q6PHKNLr7OTXImX
         QY6tia+bJb7iRkFFxN7yJrcvlfR9Li81a98kc7ViNQ0V8S4AXznyoEG0HYaXQGQt4aT5
         PZHiH6nFw3wYdCuYq6T8rCEZBXIUJf9UGdjZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaDYqsyc1Amfj+rSgV5LdqRPEszOSqeoO5bxQF6wI/8=;
        b=QluRpihH//7bNIhbG2Alr+Cgqv28DmW1P8gnSouug7dea64WNrWKo6W0Pu5avbH8tU
         QdViJLiRIB0HDDYgeRIBztOGRw2D3TfoOlL9Qrp52Pu07dMHOa+o8Qc5myFfwsTlxoMW
         dJvU+27vE7DvN0oEHM0b21iejosFg0idYBvl7rpud0RFskgeWWSl9SseQyNm9jeDDKh3
         tUtSFRKDfFYP25bDQ2d2RkaXk7Q2/tEqIJZxKGMcFOHgTVKXQCWn1JlKc8/Jri1KonPl
         6PZxbKLQA0s9pTpamqHhEFTlzyVzgMsjUHR5GCQlb6JVunNcqpfMivucCLw8vPsvgzjB
         0iBw==
X-Gm-Message-State: APjAAAUP4PAu0NU6bT9oJ6194an7c9OegcGV0mF4gAsBZuMFqqhO7emN
        8xaifdsr9Xtdde6Qn4NYORSlfw==
X-Google-Smtp-Source: APXvYqy/lHJIWrfIzvI2UJaglWQA7earIp8Y3bMqEUk8egTypwDN5U4K852L6vRuGCM11q/C3vqrtQ==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr19049999pgg.239.1575894047511;
        Mon, 09 Dec 2019 04:20:47 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p21sm26733813pfn.103.2019.12.09.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 04:20:47 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Matthias Brugger <mbrugger@suse.com>, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm: bridge: anx7688: Support bypass GPIO feature
Date:   Mon,  9 Dec 2019 20:20:13 +0800
Message-Id: <20191209122013.178564-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191209122013.178564-1-hsinyi@chromium.org>
References: <20191209122013.178564-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support optional feature: bypass GPIO.

Get GPIO status in irq handler. If GPIO is active, mode_fixup would be
bypassed.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix-anx7688.c | 57 +++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix-anx7688.c b/drivers/gpu/drm/bridge/analogix-anx7688.c
index 5a3a2251c1c5..1d09db2cf8e9 100644
--- a/drivers/gpu/drm/bridge/analogix-anx7688.c
+++ b/drivers/gpu/drm/bridge/analogix-anx7688.c
@@ -5,11 +5,16 @@
  * Copyright 2016 Google LLC
  */
 
+#include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 /* Register addresses */
 #define VENDOR_ID_REG 0x00
@@ -31,6 +36,9 @@ struct anx7688 {
 	struct i2c_client *client;
 	struct regmap *regmap;
 
+	struct gpio_desc *gpiod_bypass;
+	int bypass;
+
 	bool filter;
 };
 
@@ -49,6 +57,10 @@ static bool anx7688_bridge_mode_fixup(struct drm_bridge *bridge,
 	int totalbw, requiredbw;
 	int ret;
 
+	/* bypass anx mode fixup */
+	if (anx7688->bypass)
+		return true;
+
 	if (!anx7688->filter)
 		return true;
 
@@ -93,6 +105,19 @@ static const struct drm_bridge_funcs anx7688_bridge_funcs = {
 	.mode_fixup	= anx7688_bridge_mode_fixup,
 };
 
+static irqreturn_t gpio_display_mux_det_threaded_handler(int unused, void *data)
+{
+	struct anx7688 *anx7688 = data;
+
+	anx7688->bypass = gpiod_get_value(anx7688->gpiod_bypass);
+	dev_dbg(&anx7688->client->dev, "Interrupt %d!\n", anx7688->bypass);
+
+	if (anx7688->bridge.dev)
+		drm_kms_helper_hotplug_event(anx7688->bridge.dev);
+
+	return IRQ_HANDLED;
+}
+
 static const struct regmap_config anx7688_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -156,6 +181,38 @@ static int anx7688_i2c_probe(struct i2c_client *client,
 			 buffer[0], buffer[1]);
 	}
 
+	/* Optional bypass-gpios */
+	anx7688->gpiod_bypass = devm_gpiod_get_optional(dev, "bypass",
+							GPIOD_IN);
+	if (IS_ERR(anx7688->gpiod_bypass)) {
+		ret = PTR_ERR(anx7688->gpiod_bypass);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "bypass-gpios assigned failed\n");
+		return ret;
+	}
+	if (anx7688->gpiod_bypass) {
+		int irq;
+
+		irq = gpiod_to_irq(anx7688->gpiod_bypass);
+		if (irq < 0) {
+			dev_err(dev, "Failed to get output irq %d\n", irq);
+			return -ENODEV;
+		}
+
+		anx7688->bypass = gpiod_get_value(anx7688->gpiod_bypass);
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				gpio_display_mux_det_threaded_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
+				"gpio-display-mux-det", anx7688);
+		if (ret) {
+			dev_err(dev,
+				"Failed to request MUX_DET threaded irq\n");
+			return ret;
+		}
+	}
+
 	anx7688->bridge.funcs = &anx7688_bridge_funcs;
 	drm_bridge_add(&anx7688->bridge);
 
-- 
2.24.0.393.g34dc348eaf-goog

