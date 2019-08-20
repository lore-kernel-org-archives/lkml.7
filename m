Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02030C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94BE22DCC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="f3bIV3Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfHTOML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:12:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbfHTOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:11:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so12571599wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FGBKHCq8FJWMnIUa/LWFL4TzsPl3MOXhcThUateMRtc=;
        b=f3bIV3SrHFrMQrtixm3U82rRcligpygZElE9yXd5V8V9ltf6yCrcMipHXrommhcqfw
         TFOHb/OanU4gCVrKHQ4rz/c+Lfhl0tvYf7X1dwxm6Wgsb0V3lZi6+l3NjxduRxirIBhg
         hWW408Mo9CNtLPe2K1XsYTiZwLTBeRtkzcdT6kM94Gw7kC4ZCx5uxEncz8qyBoj/iayH
         QSjw5kDf4YeSbhEFMhXZb9Y5o+cnR5cHW72PjEkakxrM2G28a8rEre+NOZ/qpC3DNmKh
         lUQzqHDbg+0ReV5HhEvmxRDpMVa7i8/eh+1DlHByywQhWXJivmNVoag839ISQcYEypA3
         OXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=FGBKHCq8FJWMnIUa/LWFL4TzsPl3MOXhcThUateMRtc=;
        b=O6GaBRP8xf88MwzHA8JPh0o085bpP67X/Ik+7ZH/GkHB87yE8CuzBRwStlLQtS8RMV
         KJld3KdQTQBNOa0x1ZweKDL7/WHL1CyGwStXUjGpWNv2QbHZKY23KVJy7v3Sur+e+sv4
         wYU3EWFZmjHMKLXNj+on2waYglr9OyQQWXKUxDV52zAM96O0rYUOgr68O++fOplJ5nWp
         6gEt8AXjyn12uXJ1magbJ8hBULMqR67i5WhG9AYWc1I+vg+ETLpeS+bJ937M5PwdHiYy
         tbS/N4SKut+sJk9x/EtqbhNnMx9PTg9xHY1hhPhYTw0qPWMEwgNmcUkijZ7vKmWoZ307
         m4lw==
X-Gm-Message-State: APjAAAVTtibCZYEMIijh2TzsZA8cldKub5cSKpjt0Bmqu1EIlsZni/Ia
        FmHYCcQDu4BRXsxQrzMqCcNZorYYY5tIUA==
X-Google-Smtp-Source: APXvYqxobUNDMTRwNWh7KrFllFIt6Sw6gQaq/G0HklprIHThax3CILx4Cq6GYMtvbluPatyRvV4Qqw==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr34863140wro.158.1566310310222;
        Tue, 20 Aug 2019 07:11:50 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u186sm229705wmu.26.2019.08.20.07.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:11:49 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, linux@roeck-us.net
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 2/4] iio: adc: ina2xx: Setup better name then simple ina2xx
Date:   Tue, 20 Aug 2019 16:11:39 +0200
Message-Id: <e1a9d7c5f94a4942a97a242e530a3bfdda8bbc74.1566310292.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with multiple ina2xx chips it is impossible to find out which
iio device is which one based on probe order. That's why it is necessary to
setup better name based on possition.
The patch is reusing dev_name which is setup by core with client->name.

name char array was setup to 128 byte length to correspond the same name
length by HID device.

Before this patch:
iio:device9: ina226 (buffer capable)
After:
iio:device9: ina226-3-004a (buffer capable)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Also id->name can be used as prefix. On ina226 output is the same.

Also I am happy to change that space for name will be dynamicky allocated
to save a space if needed.
---
 drivers/iio/adc/ina2xx-adc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 37058d9c2054..7c7c63677bf4 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -146,6 +146,7 @@ struct ina2xx_chip_info {
 	int range_vbus; /* Bus voltage maximum in V */
 	int pga_gain_vshunt; /* Shunt voltage PGA gain */
 	bool allow_async_readout;
+	char name[128];
 };
 
 static const struct ina2xx_config ina2xx_config[] = {
@@ -1027,7 +1028,12 @@ static int ina2xx_probe(struct i2c_client *client,
 		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
 		indio_dev->info = &ina219_info;
 	}
-	indio_dev->name = id->name;
+
+	/* Compose chip name to unified i2c format */
+	snprintf(chip->name, sizeof(chip->name), "%s-%s",
+		 client->name, dev_name(&client->dev));
+
+	indio_dev->name = chip->name;
 	indio_dev->setup_ops = &ina2xx_setup_ops;
 
 	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-- 
2.17.1

