Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9F32075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLgK4l8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfECXJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:09:05 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34077 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:09:05 -0400
Received: by mail-it1-f195.google.com with SMTP id p18so9351850itm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/nmHK1VkQE9pFpVfvhGPufZyGjT+bYRqh+BLBRKYLE=;
        b=BLgK4l8SdUGPBQCFA4Jzo4taTvE26RARpOHwQKz1Q3fxznb11WxumD5L4EWil4o8G9
         yHeUTC4Dec3gCWtAwywskb/ifuUi59BXyu/ykNsSYtSOWB+1a7L6RZTEg/qtvntKZHZQ
         zL4dML/2N5VUDADVtl3GJzhxhPj/FM7mKNIOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/nmHK1VkQE9pFpVfvhGPufZyGjT+bYRqh+BLBRKYLE=;
        b=rEDQjnLPAdWIdfjE2reTDV99NQE9JgviRvu9Jfl8bCzaN2Jr6AMjfGC/eJ7fWvki7s
         js+gWlj7Vo/9NTYyUbTD6Dy//FcLDoR5MouRd55hwLBuq2slyiNZ2CQ4bbLZCg/GBrBL
         2PEzT6e488yc/7VspPLuuhZcaEqs/d8tSt5ACoznl7d30PSos0gdjmhRqlPHKiPaRRZZ
         /jCSA6VBRSHu6LdIXyzI8RbWUDu4k/zaX/WStUHW5qeCrYBiohrd2PQe21SOOLntAhVV
         ceLg6P8dn7bmq6DRtjBpypCI5R/VoVqfrTZQgB1SYD3+7N73jadVRipoyk5EMp9ngCBM
         HjHw==
X-Gm-Message-State: APjAAAUYr23qCUuqVLrj8f29oJNtRsA1THRMJV/NHgln84zXDGwcHPQU
        iiXsDRvuN5snR57MjS+c2aVb9Rvi+1w=
X-Google-Smtp-Source: APXvYqzexUvR6AEKqEApODH83Gm5RZzbtjyT5OOTDFigNMJdePDj6wuTSFohkvpfg4kKrwxOmkRIsQ==
X-Received: by 2002:a24:9103:: with SMTP id i3mr9360258ite.7.1556924943769;
        Fri, 03 May 2019 16:09:03 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id 12sm5549243itm.2.2019.05.03.16.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:09:03 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v4 3/3] ASoC: rt5677: fall back to DT prop names on error
Date:   Fri,  3 May 2019 17:07:51 -0600
Message-Id: <20190503230751.168403-4-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503230751.168403-1-fletcherw@chromium.org>
References: <20190503230751.168403-1-fletcherw@chromium.org>
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
index da27cbfaec2b74..e6b75f52d4a433 100644
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
@@ -5283,20 +5285,18 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
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
2.21.0.1020.gf2820cf01a-goog

