Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E593C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A91206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d8uOznQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfDYPb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:31:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54156 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:31:25 -0400
Received: by mail-it1-f196.google.com with SMTP id z4so781543itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iO6QxAEf/Q0+FM6nHynVXjUVuWpOJFjFaye+j3F/zM8=;
        b=d8uOznQPSd0CCLEp84FaTcIlK5izr5ZfRS0QI402v0uhb7E2dTLc5Oe8IUBq7hZ95T
         o5jMqfyznGBXS86CLE1+Uk+4FPksLTt7CE3Ic3zGo0D7mHzyDjw9HA/hx6WJfSCC/5Nt
         14np9Evr/bytIAzDVfMze7aKYzfQH4SyDXaRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iO6QxAEf/Q0+FM6nHynVXjUVuWpOJFjFaye+j3F/zM8=;
        b=onGV2fFDhXMcyt86/h8000dKf7i2cFeSfx46fIVM5sPeBnQiTfiuXhfS1MzcIS/WEW
         HaxeV8mLpntHNmt3MYlwODrUTthPfrnGAr8h45LZ3vLPLf3wbhIuilORiP6NVWSMjthj
         j+CfD5LKKnqIGrs3TkAUpF63OKqoE+00RjhZH0tR/40rHT3XyGCYzUs+iw/5xBwph43U
         OA4knauSu+C+OJgp16CtkZOe94bKkQub0QcxROLtcfSk4ljSOxc4hwlMtq7/UGoXcGYQ
         mhLJ+J+W0j5m59dqdslDd1JMEWUS+0IvmfYRPh3ZfZlRhwwDSmHQbYxO9Lo9fBwg7I5m
         WLHg==
X-Gm-Message-State: APjAAAXfXHXNndpzYZDSBqNVRCMRx2af06w1Ku+W0fDNzJI3CjAS1Mm4
        U5ayXTHdJ4hSidrR6+A5ObB6roBa3dw=
X-Google-Smtp-Source: APXvYqw/EW1Krq1sjEyHIbmd4Sm71SS6irON9RrDFyYabomCLVCvFyqG+eR59vTLGsW0Fi68+4Nugw==
X-Received: by 2002:a24:1a47:: with SMTP id 68mr3427155iti.132.1556206284085;
        Thu, 25 Apr 2019 08:31:24 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id g4sm3829646ioc.9.2019.04.25.08.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:31:23 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3 3/3] ASoC: rt5677: fall back to DT prop names on error
Date:   Thu, 25 Apr 2019 09:31:05 -0600
Message-Id: <20190425153105.118799-2-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190425153105.118799-1-fletcherw@chromium.org>
References: <20190415194557.9182-2-fletcherw@chromium.org>
 <20190425153105.118799-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5677 driver uses ACPI-style property names to read from the
device API. However, these do not match the property names in _DSD
used on the Chromebook Pixel 2015, which are closer to the Device Tree
style.  Unify the two functions for reading from the device API so that
they try ACPI-style names first and fall back to the DT names on error.

With this patch, plugging and unplugging the headphone jack switches
between headphones and speakers automatically.

Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 6bff0df53c6c6b..38e99580f09acd 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4998,48 +4998,50 @@ static const struct acpi_device_id rt5677_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
 
-static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
+static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
 	u32 val;
 
-	if (!device_property_read_u32(dev, "DCLK", &val))
-		rt5677->pdata.dmic2_clk_pin = val;
+	rt5677->pdata.in1_diff =
+		device_property_read_bool(dev, "IN1") ||
+		device_property_read_bool(dev, "realtek,in1-differential");
 
-	rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev, "OUT1");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev, "OUT2");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev, "OUT3");
+	rt5677->pdata.in2_diff =
+		device_property_read_bool(dev, "IN2") ||
+		device_property_read_bool(dev, "realtek,in2-differential");
 
-	device_property_read_u32(dev, "JD1", &rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "JD2", &rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "JD3", &rt5677->pdata.jd3_gpio);
-}
+	rt5677->pdata.lout1_diff =
+		device_property_read_bool(dev, "OUT1") ||
+		device_property_read_bool(dev, "realtek,lout1-differential");
 
-static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
-		struct device *dev)
-{
-	rt5677->pdata.in1_diff = device_property_read_bool(dev,
-			"realtek,in1-differential");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev,
-			"realtek,in2-differential");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev,
-			"realtek,lout1-differential");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev,
-			"realtek,lout2-differential");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev,
-			"realtek,lout3-differential");
+	rt5677->pdata.lout2_diff =
+		device_property_read_bool(dev, "OUT2") ||
+		device_property_read_bool(dev, "realtek,lout2-differential");
+
+	rt5677->pdata.lout3_diff =
+		device_property_read_bool(dev, "OUT3") ||
+		device_property_read_bool(dev, "realtek,lout3-differential");
 
 	device_property_read_u8_array(dev, "realtek,gpio-config",
-			rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
-
-	device_property_read_u32(dev, "realtek,jd1-gpio",
-			&rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "realtek,jd2-gpio",
-			&rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "realtek,jd3-gpio",
-			&rt5677->pdata.jd3_gpio);
+				      rt5677->pdata.gpio_config,
+				      RT5677_GPIO_NUM);
+
+	if (!device_property_read_u32(dev, "DCLK", &val) ||
+	    !device_property_read_u32(dev, "realtek,dmic2_clk_pin", &val))
+		rt5677->pdata.dmic2_clk_pin = val;
+
+	if (!device_property_read_u32(dev, "JD1", &val) ||
+	    !device_property_read_u32(dev, "realtek,jd1-gpio", &val))
+		rt5677->pdata.jd1_gpio = val;
+
+	if (!device_property_read_u32(dev, "JD2", &val) ||
+	    !device_property_read_u32(dev, "realtek,jd2-gpio", &val))
+		rt5677->pdata.jd2_gpio = val;
+
+	if (!device_property_read_u32(dev, "JD3", &val) ||
+	    !device_property_read_u32(dev, "realtek,jd3-gpio", &val))
+		rt5677->pdata.jd3_gpio = val;
 }
 
 struct rt5677_irq_desc {
@@ -5284,20 +5286,18 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 		match_id = of_match_device(rt5677_of_match, &i2c->dev);
 		if (match_id)
 			rt5677->type = (enum rt5677_type)match_id->data;
-
-		rt5677_read_device_properties(rt5677, &i2c->dev);
 	} else if (ACPI_HANDLE(&i2c->dev)) {
 		const struct acpi_device_id *acpi_id;
 
 		acpi_id = acpi_match_device(rt5677_acpi_match, &i2c->dev);
 		if (acpi_id)
 			rt5677->type = (enum rt5677_type)acpi_id->driver_data;
-
-		rt5677_read_acpi_properties(rt5677, &i2c->dev);
 	} else {
 		return -EINVAL;
 	}
 
+	rt5677_read_device_properties(rt5677, &i2c->dev);
+
 	/* pow-ldo2 and reset are optional. The codec pins may be statically
 	 * connected on the board without gpios. If the gpio device property
 	 * isn't specified, devm_gpiod_get_optional returns NULL.
-- 
2.21.0.392.gf8f6787159e-goog

