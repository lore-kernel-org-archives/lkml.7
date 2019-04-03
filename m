Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C5120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URM2vygS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDCECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44623 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfDCEB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so7597633pgj.11;
        Tue, 02 Apr 2019 21:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5jU7J6gngl6LDGofHSVbyCNiUUURALHXTXqSnIy//Y=;
        b=URM2vygSQZoXSUSf2WTB0DROBZio8y2w2FijAlLbD7GHGEFv3KjT+3gZ1cfFhanTm8
         eaYO2CPcfLp6OceNniO6pCEf29kDKeg6x32GI9z902pAJ4q1Wl6y5RPeAzqBOgbR6EO+
         e3PGCdATK1oQ0nJdKkQ4mBY9Oi8nzXhLupFUWhHJSe4JvekB9mF8US1p7pl7+6diiqnp
         RJXPas8NU7xwjdEMq7xK+Jekzwgr9jW9hSfsMjsEcndzYcxABM1Xq50/171/93ocjV93
         qR2vdoMycfZkM8XNoWnYzEK2Wot1/ysIC9Dpc6T/afVXGFjAjMdz/b/2Gj3yvIVUS4l1
         4A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5jU7J6gngl6LDGofHSVbyCNiUUURALHXTXqSnIy//Y=;
        b=lU+8GMgwmtaQ4L9oaDj43WVtOSubk2Zd3puUaxMYuxAPdIr3DTJvnQDlWGaiVbesqY
         rdrY19nPsmbs9s6yB16/pf56cpBxKiOvjTcGgH0a5d+2pMZOV7G612tNgPaSe2V1TkRB
         4X5Db1a+pPRuUFRKSlQ3dKRozUosVU+/U9m+jMtlhZgjLQiVzrIJbyHQIb6V45p5DSIK
         RurJZvk5aErNh6ioPpNGnk+P3i2C4xSgEh/fi3JuirD7rneye82jR8QcQPum1EYW32Jt
         By/mgg9PlrD995VfqUEED/ZgWBbgB2Snqx19B0pyv+czaaT4SLkdJxyxdZLOkjcKGgUQ
         4tIQ==
X-Gm-Message-State: APjAAAXLO/JcvXyl8gsN5O+AIG3w17IOCw47XnNw30GdJtFb60+wVC/E
        6S9wi+OSRZFpcYsXgerdWZmnGWeq
X-Google-Smtp-Source: APXvYqw3nAlNAn5rxsM50tR3al9WlArBKXES4t/jjWJl6aj+DzekLqgdr6WWwheddHpPZKixZLQ00g==
X-Received: by 2002:a63:c149:: with SMTP id p9mr68403936pgi.362.1554264117984;
        Tue, 02 Apr 2019 21:01:57 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:57 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] spi: gpio: Don't request CS GPIO in DT use-case
Date:   Tue,  2 Apr 2019 21:01:27 -0700
Message-Id: <20190403040133.1459-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT use-case already relies on SPI core to control CS (requested by
of_spi_register_master() and controlled spi_set_cs()), so there's no
need to try to request those GPIO in spi-gpio code. Change the code
such that spi-gpio's CS related code is only used if device is probed
via pdata.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 134 ++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1cff30adc836..8feb036aaf36 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -47,7 +47,6 @@ struct spi_gpio {
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
 	struct gpio_desc		**cs_gpios;
-	bool				has_cs;
 };
 
 /*----------------------------------------------------------------------*/
@@ -217,7 +216,7 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
 
 	/* Drive chip select line, if we have one */
-	if (spi_gpio->has_cs) {
+	if (spi_gpio->cs_gpios) {
 		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
 		/* SPI chip selects are normally active-low */
@@ -235,10 +234,12 @@ static int spi_gpio_setup(struct spi_device *spi)
 	 * The CS GPIOs have already been
 	 * initialized from the descriptor lookup.
 	 */
-	cs = spi_gpio->cs_gpios[spi->chip_select];
-	if (!spi->controller_state && cs)
-		status = gpiod_direction_output(cs,
-						!(spi->mode & SPI_CS_HIGH));
+	if (spi_gpio->cs_gpios) {
+		cs = spi_gpio->cs_gpios[spi->chip_select];
+		if (!spi->controller_state && cs)
+			status = gpiod_direction_output(cs,
+						  !(spi->mode & SPI_CS_HIGH));
+	}
 
 	if (!status)
 		status = spi_bitbang_setup(spi);
@@ -291,11 +292,8 @@ static void spi_gpio_cleanup(struct spi_device *spi)
  */
 static int spi_gpio_request(struct device *dev,
 			    struct spi_gpio *spi_gpio,
-			    unsigned int num_chipselects,
 			    u16 *mflags)
 {
-	int i;
-
 	spi_gpio->mosi = devm_gpiod_get_optional(dev, "mosi", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->mosi))
 		return PTR_ERR(spi_gpio->mosi);
@@ -316,13 +314,6 @@ static int spi_gpio_request(struct device *dev,
 	if (IS_ERR(spi_gpio->sck))
 		return PTR_ERR(spi_gpio->sck);
 
-	for (i = 0; i < num_chipselects; i++) {
-		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs",
-							     i, GPIOD_OUT_HIGH);
-		if (IS_ERR(spi_gpio->cs_gpios[i]))
-			return PTR_ERR(spi_gpio->cs_gpios[i]);
-	}
-
 	return 0;
 }
 
@@ -333,90 +324,87 @@ static const struct of_device_id spi_gpio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
 
-static int spi_gpio_probe_dt(struct platform_device *pdev)
+static int spi_gpio_probe_dt(struct platform_device *pdev,
+			     struct spi_master *master)
 {
-	int ret;
-	u32 tmp;
-	struct spi_gpio_platform_data	*pdata;
-	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-			of_match_device(spi_gpio_dt_ids, &pdev->dev);
-
-	if (!of_id)
-		return 0;
+	master->dev.of_node = pdev->dev.of_node;
+	master->use_gpio_descriptors = true;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
+	return 0;
+}
+#else
+static inline int spi_gpio_probe_dt(struct platform_device *pdev,
+				    struct spi_master *master)
+{
+	return 0;
+}
+#endif
 
+static int spi_gpio_probe_pdata(struct platform_device *pdev,
+				struct spi_master *master)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_gpio_platform_data *pdata = dev_get_platdata(dev);
+	struct spi_gpio *spi_gpio = spi_master_get_devdata(master);
+	int i;
 
-	ret = of_property_read_u32(np, "num-chipselects", &tmp);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "num-chipselects property not found\n");
-		goto error_free;
-	}
+#ifdef GENERIC_BITBANG
+	if (!pdata || !pdata->num_chipselect)
+		return -ENODEV;
+#endif
+	/*
+	 * The master needs to think there is a chipselect even if not
+	 * connected
+	 */
+	master->num_chipselect = pdata->num_chipselect ?: 1;
 
-	pdata->num_chipselect = tmp;
-	pdev->dev.platform_data = pdata;
+	spi_gpio->cs_gpios = devm_kcalloc(dev, master->num_chipselect,
+					  sizeof(*spi_gpio->cs_gpios),
+					  GFP_KERNEL);
+	if (!spi_gpio->cs_gpios)
+		return -ENOMEM;
 
-	return 1;
+	for (i = 0; i < master->num_chipselect; i++) {
+		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs", i,
+							     GPIOD_OUT_HIGH);
+		if (IS_ERR(spi_gpio->cs_gpios[i]))
+			return PTR_ERR(spi_gpio->cs_gpios[i]);
+	}
 
-error_free:
-	devm_kfree(&pdev->dev, pdata);
-	return ret;
-}
-#else
-static inline int spi_gpio_probe_dt(struct platform_device *pdev)
-{
 	return 0;
 }
-#endif
 
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
-	struct spi_gpio_platform_data	*pdata;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
+	const struct of_device_id	*of_id;
 	u16 master_flags = 0;
-	bool use_of = 0;
-
-	status = spi_gpio_probe_dt(pdev);
-	if (status < 0)
-		return status;
-	if (status > 0)
-		use_of = 1;
 
-	pdata = dev_get_platdata(dev);
-#ifdef GENERIC_BITBANG
-	if (!pdata || (!use_of && !pdata->num_chipselect))
-		return -ENODEV;
-#endif
+	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
 		return -ENOMEM;
 
-	spi_gpio = spi_master_get_devdata(master);
+	if (of_id)
+		status = spi_gpio_probe_dt(pdev, master);
+	else
+		status = spi_gpio_probe_pdata(pdev, master);
 
-	spi_gpio->cs_gpios = devm_kcalloc(dev,
-				pdata->num_chipselect,
-				sizeof(*spi_gpio->cs_gpios),
-				GFP_KERNEL);
-	if (!spi_gpio->cs_gpios)
-		return -ENOMEM;
+	if (status)
+		return status;
 
-	platform_set_drvdata(pdev, spi_gpio);
+	spi_gpio = spi_master_get_devdata(master);
 
-	/* Determine if we have chip selects connected */
-	spi_gpio->has_cs = !!pdata->num_chipselect;
+	platform_set_drvdata(pdev, spi_gpio);
 
 	spi_gpio->pdev = pdev;
 
-	status = spi_gpio_request(dev, spi_gpio,
-				  pdata->num_chipselect, &master_flags);
+	status = spi_gpio_request(dev, spi_gpio, &master_flags);
 	if (status)
 		return status;
 
@@ -425,13 +413,9 @@ static int spi_gpio_probe(struct platform_device *pdev)
 			    SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
-	/* The master needs to think there is a chipselect even if not connected */
-	master->num_chipselect = spi_gpio->has_cs ? pdata->num_chipselect : 1;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
-#ifdef CONFIG_OF
-	master->dev.of_node = dev->of_node;
-#endif
+
 	bb = &spi_gpio->bitbang;
 	bb->master = master;
 	bb->chipselect = spi_gpio_chipselect;
-- 
2.20.1

