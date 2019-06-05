Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0CC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7A520717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2+O+rSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfFEWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:24:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34297 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFEWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:24:46 -0400
Received: by mail-it1-f194.google.com with SMTP id u124so641548itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGv1peBnBY+mU2N9Az2Lmrfzzn5EZSvqASNR7aYsSN4=;
        b=W2+O+rSmjCnTc7n0OLEtYGkSuegR/EfCtycOrEebTz1uEJ+oLNlMuoSDhM3izgbbsw
         HDnIMwOKchDMkhobtSEheBXXaAyAIW2wv/6TAfGVjmULtTxXan0H7kNb9nf+9vQ8ME0F
         EoVxTzVQxVCqCouyCXKV6+OvXUCTFD2iw/pR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGv1peBnBY+mU2N9Az2Lmrfzzn5EZSvqASNR7aYsSN4=;
        b=aciTISsvkwvDKfzmBdJd1Mc1S9KI7GT69QNNdFK8US11ZQNfIboA1ZeZR7Gzum1eZD
         BpswXRXmxiaNChy66yS2VLq91QhuUn6AHXkk+XZT0EyJTnvauI4DYZhqJ0q+6ryBc4Rh
         5S08UoKwzqqs/DRNq4Hku6petAyh7qTx5Ys7xuEjmQOQrDBzl3VbeD9MZ2OPJamV4o1j
         B5XeKhhcu5k7P/NhrsPUUJEhxhLSlpi8XjYNEMsfBTAZc9N9uOzh6dQvMid6ljvgWnv3
         ZQgPfleYBsTms8HQmv2SFH3KZGqDReyx7yGenG9ezPY4cRRe8McVT4JO0bWZwxNl639u
         egNQ==
X-Gm-Message-State: APjAAAX1HpKvriti8oOMSBYlTxJ2ZhXdDBNZSIFYevxgzoOiw6W6dW1l
        MRMO4GByyLCvG23LCpQOfCOQQUi0uufhLA==
X-Google-Smtp-Source: APXvYqzbaWNOFsIui75N1Vncy33qz2nBAIGbYBfV9xneeFN+JtXmGBaBXLDL1odxiyHMOqpF6rRPCA==
X-Received: by 2002:a24:7ca:: with SMTP id f193mr17297953itf.175.1559773484772;
        Wed, 05 Jun 2019 15:24:44 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id f4sm68593itl.36.2019.06.05.15.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:24:44 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v6 1/4] ASoC: rt5677: fall back to DT prop names on error
Date:   Wed,  5 Jun 2019 16:24:16 -0600
Message-Id: <20190605222419.54479-2-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190605222419.54479-1-fletcherw@chromium.org>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190605222419.54479-1-fletcherw@chromium.org>
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

Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9b7a1833d3316c..62489a8c3fed6e 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5019,48 +5019,50 @@ static const struct acpi_device_id rt5677_acpi_match[] = {
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
 
 static struct regmap_irq rt5677_irqs[] = {
@@ -5143,20 +5145,18 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
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
2.22.0.rc1.311.g5d7573a151-goog

