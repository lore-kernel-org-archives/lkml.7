Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE520C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779C620857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c125njDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDAUzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:55:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38338 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfDAUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:55:42 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so1532506ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xrpr7Hq7dqaYL2Eo6DwUdVyXfie7eGeQXHVNyEFIVsc=;
        b=c125njDpcb+GViLFb7oVcDNQe5ZLS36m3H9L16x9knOSqaFwlnxDs+rGkawwSxJbev
         wzsTkjX3Y24BpRuyMM2PCZy92/gdYSpJwe6icQto/kqdVd40+EGD10UN9tvr2k3M8eOQ
         CSTTzL1rJRZkv/p3B9Xk++JR9RnhbLzOnsg4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xrpr7Hq7dqaYL2Eo6DwUdVyXfie7eGeQXHVNyEFIVsc=;
        b=hu4sFpg2ItqHBpqvkY1a44TU9aZWAXQkMELY/LXWFdK4tDIghmz944KVK3mr0+Nwk9
         /pHCRaGj4nHePOwp9xzRFwFCSzdl8t0RQ4V996w1p7VMm9aaMMElTwByhI8lDnSc+Ojo
         oSqAvQbboe/zwUmrfUV4XJPBeuM2fL3fpoo15/tbz/1TV6XhP0B3GjV6hjuVw0N7gtpW
         RTZyDGnhfkrHVSVsGu5uQEi67VTh5Bhb3PhOoW0cnEZejJPFwKIZlIqHp/ec5YP+WIra
         h5/OPRBQUk2A/q0s3YtAJBb+fBxBGb4PpLej5O19jjl7FFOAmxuncdb1V1tnTmv887xb
         j8AA==
X-Gm-Message-State: APjAAAVv+JHGJc3wE/MouVyrK+49Ko7xRnCk2K0VGcUeLaTn8mAH7KKW
        JHpSSrZCF6bDDAeLLU9QJWwOsrsBH0VKjQ==
X-Google-Smtp-Source: APXvYqxavNwBue4MkZ+KYHPxCUQFuW4/4QT/57VY6ql1jxwXoUaGRP9EICN0VkNK2m9QSLigHVZSgQ==
X-Received: by 2002:a24:7014:: with SMTP id f20mr1286036itc.44.1554152141676;
        Mon, 01 Apr 2019 13:55:41 -0700 (PDT)
Received: from fletcherw.bld.corp.google.com ([2620:15c:183:200:70a8:812a:cdeb:6e0])
        by smtp.gmail.com with ESMTPSA id v133sm6688570ita.19.2019.04.01.13.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:55:41 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.org>, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Date:   Mon,  1 Apr 2019 14:55:19 -0600
Message-Id: <20190401205519.34023-2-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401205519.34023-1-fletcherw@chromium.org>
References: <20190401205519.34023-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5677 driver is using the wrong property names to read from ACPI.
Update the property names to match those from _DSD, so that the correct
GPIO pin numbers are read and that plug-detection works.

With this patch, plugging and unplugging the headphone jack switches
between headphones and speakers automatically.

Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 33380f82b7008f..1f725086cee39c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4998,25 +4998,6 @@ static const struct acpi_device_id rt5677_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
 
-static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
-		struct device *dev)
-{
-	u32 val;
-
-	if (!device_property_read_u32(dev, "DCLK", &val))
-		rt5677->pdata.dmic2_clk_pin = val;
-
-	rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev, "OUT1");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev, "OUT2");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev, "OUT3");
-
-	device_property_read_u32(dev, "JD1", &rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "JD2", &rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "JD3", &rt5677->pdata.jd3_gpio);
-}
-
 static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
@@ -5273,19 +5254,23 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 		if (match_id)
 			rt5677->type = (enum rt5677_type)match_id->data;
 
-		rt5677_read_device_properties(rt5677, &i2c->dev);
 	} else if (ACPI_HANDLE(&i2c->dev)) {
 		const struct acpi_device_id *acpi_id;
+		u32 val;
 
 		acpi_id = acpi_match_device(rt5677_acpi_match, &i2c->dev);
 		if (acpi_id)
 			rt5677->type = (enum rt5677_type)acpi_id->driver_data;
 
-		rt5677_read_acpi_properties(rt5677, &i2c->dev);
+		if (!device_property_read_u32(&i2c->dev,
+					"realtek,dmic2_clk_pin", &val))
+			rt5677->pdata.dmic2_clk_pin = val;
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

