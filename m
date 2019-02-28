Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952702171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHwaeLAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfB1O0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47094 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732946AbfB1O0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id i5so12137499qkd.13;
        Thu, 28 Feb 2019 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LhLBOUVEFdkrOLZyvw0gu9evm3wKITUpm71PjNrrlnI=;
        b=gHwaeLAG+eCrRH7+FXF3SXn7JybsidgytdVVfbtXfbDj8yP+HFCamy+4RqtVKDkY3F
         LRO1IY6B8fxq7Exti9/SHGKmHBx+xy7ffdHxnkgNA8w7Th9TEDMPMWa9ObqwL0aAjUMQ
         GEFvdVQwjRl1YN1oVe6XjQc41sYPS0t8Ft3j7mBVHk+4GHoEu0ZUW4y561aJN1upAD2M
         paVAJy4eaaDwbVVs7veyurSQUl3ZHsEi6s9jy2JyBfp73ma/Zk2KO3D0zEGRezmjMHIv
         XN2AdaipZHwLibpJNmLu+qn1rIMImq/pv7UTwgBH3ynrxOYEzcHpei15/XK6RLRoZ6Oh
         GQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhLBOUVEFdkrOLZyvw0gu9evm3wKITUpm71PjNrrlnI=;
        b=liFqd+quh89WeRipZ/dgxT53XAN25GleMisp62TokD4BPjy8HWeVaOjiHONWjYu8Sr
         jw6rZZJ2g9PkgkooIUJ1FbYlj3Bj3smEHPxnm6l3hHDAcVGWi8PQd8DgdeKGqR2x64lX
         Mi7CijGQDT04xXjXhCqC40JgrPPZOQ09SjzElIpRaQkLeWdOhPP1qG5RxuVgJDzs9lT/
         fkmWCbztobPH7ks6VVPTh8cxp3HYKC2LqOgqDfy9IpzhTvCE61LgWS4g+GUscBGINbdN
         zS6QKPbehGvdbw6YNYbOdKfKhaM6e06AkFYdup+SGlOXnRgwM47wYv6FJFYStu3mD2Yl
         6gTg==
X-Gm-Message-State: AHQUAuYnDTryqPINIlOHGtlsFGGKDNnfLlzEPSJIl7kcXRo3viLLvPIk
        R9QX5G3xOwR5ML1E8FkElEQ=
X-Google-Smtp-Source: APXvYqxxr4H4nNGiTsjAG1s9TNWSpDMrW1LiqE/X5fY3fKJCDrW5yWaSMi+bR5oH/zqMClv36v3PZg==
X-Received: by 2002:a37:4887:: with SMTP id v129mr6923351qka.100.1551363973946;
        Thu, 28 Feb 2019 06:26:13 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id r44sm12107321qtb.53.2019.02.28.06.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:26:13 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:26:08 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 8/9] staging: iio: ad7780: moving ad7780 out of staging
Message-ID: <f4fc17090c7c48e5ae3ea7242ef23766047c0cd8.1551358569.git.renatogeh@gmail.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ad7780 ADC driver out of staging and into the mainline.

The ad7780 is a sigma-delta analog to digital converter. This driver provides
reading voltage values and status bits from both the ad778x and ad717x series.
Its interface also allows writing on the FILTER and GAIN GPIO pins on the
ad778x.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v3:
 - Changes unrelated to moving the driver to main tree were resent as
   individual patches
Changes in v4:
 - Removed line warning it was safe to build the ad7780 driver by
   default

About the above change in v4, I was unsure whether it was ok to add this
in this patch, as 'move out of staging' patches should be just that. But
this change is so minimal I'm willing to risk a v5. Bottom line: should
I add this change as another patch?

 drivers/iio/adc/Kconfig          |  12 +
 drivers/iio/adc/Makefile         |   1 +
 drivers/iio/adc/ad7780.c         | 365 +++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig  |  13 --
 drivers/staging/iio/adc/Makefile |   1 -
 drivers/staging/iio/adc/ad7780.c | 365 -------------------------------
 6 files changed, 378 insertions(+), 379 deletions(-)
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f3cc7a31bce5..6b36a45bd09f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -108,6 +108,18 @@ config AD7766
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7766.
 
+config AD7780
+	tristate "Analog Devices AD7780 and similar ADCs driver"
+	depends on SPI
+	depends on GPIOLIB || COMPILE_TEST
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7170, AD7171,
+	  AD7780 and AD7781 SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7780.
+
 config AD7791
 	tristate "Analog Devices AD7791 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ea5031348052..b48852157115 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7766) += ad7766.o
+obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
new file mode 100644
index 000000000000..aa1ddd0c45ee
--- /dev/null
+++ b/drivers/iio/adc/ad7780.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ * Copyright 2019 Renato Lui Geh
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/bits.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+
+#define AD7780_RDY		BIT(7)
+#define AD7780_FILTER		BIT(6)
+#define AD7780_ERR		BIT(5)
+#define AD7780_GAIN		BIT(2)
+
+#define AD7170_ID		0
+#define AD7171_ID		1
+#define AD7780_ID		1
+#define AD7781_ID		0
+
+#define AD7780_ID_MASK		(BIT(3) | BIT(4))
+
+#define AD7780_PATTERN_GOOD	1
+#define AD7780_PATTERN_MASK	GENMASK(1, 0)
+
+#define AD7170_PATTERN_GOOD	5
+#define AD7170_PATTERN_MASK	GENMASK(2, 0)
+
+#define AD7780_GAIN_MIDPOINT	64
+#define AD7780_FILTER_MIDPOINT	13350
+
+static const unsigned int ad778x_gain[2]      = { 1, 128 };
+static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
+
+struct ad7780_chip_info {
+	struct iio_chan_spec	channel;
+	unsigned int		pattern_mask;
+	unsigned int		pattern;
+	bool			is_ad778x;
+};
+
+struct ad7780_state {
+	const struct ad7780_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct gpio_desc		*powerdown_gpio;
+	struct gpio_desc		*gain_gpio;
+	struct gpio_desc		*filter_gpio;
+	unsigned int			gain;
+	unsigned int			odr;
+	unsigned int			int_vref_mv;
+
+	struct ad_sigma_delta sd;
+};
+
+enum ad7780_supported_device_ids {
+	ID_AD7170,
+	ID_AD7171,
+	ID_AD7780,
+	ID_AD7781,
+};
+
+static struct ad7780_state *ad_sigma_delta_to_ad7780(struct ad_sigma_delta *sd)
+{
+	return container_of(sd, struct ad7780_state, sd);
+}
+
+static int ad7780_set_mode(struct ad_sigma_delta *sigma_delta,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
+	unsigned int val;
+
+	switch (mode) {
+	case AD_SD_MODE_SINGLE:
+	case AD_SD_MODE_CONTINUOUS:
+		val = 1;
+		break;
+	default:
+		val = 0;
+		break;
+	}
+
+	gpiod_set_value(st->powerdown_gpio, val);
+
+	return 0;
+}
+
+static int ad7780_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (voltage_uv < 0)
+			return voltage_uv;
+		voltage_uv /= 1000;
+		*val = voltage_uv * st->gain;
+		*val2 = chan->scan_type.realbits - 1;
+		st->int_vref_mv = voltage_uv;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -(1 << (chan->scan_type.realbits - 1));
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->odr;
+		return IIO_VAL_INT;
+	default:
+	break;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7780_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+	const struct ad7780_chip_info *chip_info = st->chip_info;
+	unsigned long long vref;
+	unsigned int full_scale, gain;
+
+	if (!chip_info->is_ad778x)
+		return 0;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val != 0)
+			return -EINVAL;
+
+		vref = st->int_vref_mv * 1000000LL;
+		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
+		gain = DIV_ROUND_CLOSEST(vref, full_scale);
+		gain = DIV_ROUND_CLOSEST(gain, val2);
+		st->gain = gain;
+		if (gain < AD7780_GAIN_MIDPOINT)
+			gain = 0;
+		else
+			gain = 1;
+		gpiod_set_value(st->gain_gpio, gain);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
+			val = 0;
+		else
+			val = 1;
+		st->odr = ad778x_odr_avail[val];
+		gpiod_set_value(st->filter_gpio, val);
+		break;
+	default:
+	break;
+	}
+
+	return 0;
+}
+
+static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
+				     unsigned int raw_sample)
+{
+	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
+	const struct ad7780_chip_info *chip_info = st->chip_info;
+
+	if ((raw_sample & AD7780_ERR) ||
+	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
+		return -EIO;
+
+	if (chip_info->is_ad778x) {
+		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
+		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
+	}
+
+	return 0;
+}
+
+static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
+	.set_mode = ad7780_set_mode,
+	.postprocess_sample = ad7780_postprocess_sample,
+	.has_registers = false,
+};
+
+#define AD7780_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
+#define AD7170_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
+
+static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
+	[ID_AD7170] = {
+		.channel = AD7170_CHANNEL(12, 24),
+		.pattern = AD7170_PATTERN_GOOD,
+		.pattern_mask = AD7170_PATTERN_MASK,
+		.is_ad778x = false,
+	},
+	[ID_AD7171] = {
+		.channel = AD7170_CHANNEL(16, 24),
+		.pattern = AD7170_PATTERN_GOOD,
+		.pattern_mask = AD7170_PATTERN_MASK,
+		.is_ad778x = false,
+	},
+	[ID_AD7780] = {
+		.channel = AD7780_CHANNEL(24, 32),
+		.pattern = AD7780_PATTERN_GOOD,
+		.pattern_mask = AD7780_PATTERN_MASK,
+		.is_ad778x = true,
+	},
+	[ID_AD7781] = {
+		.channel = AD7780_CHANNEL(20, 32),
+		.pattern = AD7780_PATTERN_GOOD,
+		.pattern_mask = AD7780_PATTERN_MASK,
+		.is_ad778x = true,
+	},
+};
+
+static const struct iio_info ad7780_info = {
+	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
+};
+
+static int ad7780_probe(struct spi_device *spi)
+{
+	struct ad7780_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->gain = 1;
+
+	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
+
+	st->chip_info =
+		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &st->chip_info->channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ad7780_info;
+
+	st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
+						     "powerdown",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(st->powerdown_gpio)) {
+		ret = PTR_ERR(st->powerdown_gpio);
+		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (st->chip_info->is_ad778x) {
+		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
+							"adi,gain",
+							GPIOD_OUT_HIGH);
+		if (IS_ERR(st->gain_gpio)) {
+			ret = PTR_ERR(st->gain_gpio);
+			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
+				ret);
+			return ret;
+		}
+
+		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
+							  "adi,filter",
+							  GPIOD_OUT_HIGH);
+		if (IS_ERR(st->filter_gpio)) {
+			ret = PTR_ERR(st->filter_gpio);
+			dev_err(&spi->dev,
+				"Failed to request filter GPIO: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
+	}
+
+	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_cleanup_buffer_and_trigger;
+
+	return 0;
+
+error_cleanup_buffer_and_trigger:
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+error_disable_reg:
+	regulator_disable(st->reg);
+
+	return ret;
+}
+
+static int ad7780_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7780_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+
+	regulator_disable(st->reg);
+
+	return 0;
+}
+
+static const struct spi_device_id ad7780_id[] = {
+	{"ad7170", ID_AD7170},
+	{"ad7171", ID_AD7171},
+	{"ad7780", ID_AD7780},
+	{"ad7781", ID_AD7781},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7780_id);
+
+static struct spi_driver ad7780_driver = {
+	.driver = {
+		.name	= "ad7780",
+	},
+	.probe		= ad7780_probe,
+	.remove		= ad7780_remove,
+	.id_table	= ad7780_id,
+};
+module_spi_driver(ad7780_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 7a93d3a5c113..404a53c743a6 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,19 +3,6 @@
 #
 menu "Analog to digital converters"
 
-config AD7780
-	tristate "Analog Devices AD7780 and similar ADCs driver"
-	depends on SPI
-	depends on GPIOLIB || COMPILE_TEST
-	select AD_SIGMA_DELTA
-	help
-	  Say yes here to build support for Analog Devices AD7170, AD7171,
-	  AD7780 and AD7781 SPI analog to digital converters (ADC).
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7780.
-
 config AD7816
 	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 7a421088ff82..4b76769b32bc 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -3,7 +3,6 @@
 # Makefile for industrial I/O ADC drivers
 #
 
-obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7280) += ad7280a.o
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
deleted file mode 100644
index aa1ddd0c45ee..000000000000
--- a/drivers/staging/iio/adc/ad7780.c
+++ /dev/null
@@ -1,365 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- * Copyright 2019 Renato Lui Geh
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
-#include <linux/bits.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/adc/ad_sigma_delta.h>
-
-#define AD7780_RDY		BIT(7)
-#define AD7780_FILTER		BIT(6)
-#define AD7780_ERR		BIT(5)
-#define AD7780_GAIN		BIT(2)
-
-#define AD7170_ID		0
-#define AD7171_ID		1
-#define AD7780_ID		1
-#define AD7781_ID		0
-
-#define AD7780_ID_MASK		(BIT(3) | BIT(4))
-
-#define AD7780_PATTERN_GOOD	1
-#define AD7780_PATTERN_MASK	GENMASK(1, 0)
-
-#define AD7170_PATTERN_GOOD	5
-#define AD7170_PATTERN_MASK	GENMASK(2, 0)
-
-#define AD7780_GAIN_MIDPOINT	64
-#define AD7780_FILTER_MIDPOINT	13350
-
-static const unsigned int ad778x_gain[2]      = { 1, 128 };
-static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
-
-struct ad7780_chip_info {
-	struct iio_chan_spec	channel;
-	unsigned int		pattern_mask;
-	unsigned int		pattern;
-	bool			is_ad778x;
-};
-
-struct ad7780_state {
-	const struct ad7780_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct gpio_desc		*powerdown_gpio;
-	struct gpio_desc		*gain_gpio;
-	struct gpio_desc		*filter_gpio;
-	unsigned int			gain;
-	unsigned int			odr;
-	unsigned int			int_vref_mv;
-
-	struct ad_sigma_delta sd;
-};
-
-enum ad7780_supported_device_ids {
-	ID_AD7170,
-	ID_AD7171,
-	ID_AD7780,
-	ID_AD7781,
-};
-
-static struct ad7780_state *ad_sigma_delta_to_ad7780(struct ad_sigma_delta *sd)
-{
-	return container_of(sd, struct ad7780_state, sd);
-}
-
-static int ad7780_set_mode(struct ad_sigma_delta *sigma_delta,
-			   enum ad_sigma_delta_mode mode)
-{
-	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
-	unsigned int val;
-
-	switch (mode) {
-	case AD_SD_MODE_SINGLE:
-	case AD_SD_MODE_CONTINUOUS:
-		val = 1;
-		break;
-	default:
-		val = 0;
-		break;
-	}
-
-	gpiod_set_value(st->powerdown_gpio, val);
-
-	return 0;
-}
-
-static int ad7780_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val,
-			   int *val2,
-			   long m)
-{
-	struct ad7780_state *st = iio_priv(indio_dev);
-	int voltage_uv;
-
-	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
-	case IIO_CHAN_INFO_SCALE:
-		voltage_uv = regulator_get_voltage(st->reg);
-		if (voltage_uv < 0)
-			return voltage_uv;
-		voltage_uv /= 1000;
-		*val = voltage_uv * st->gain;
-		*val2 = chan->scan_type.realbits - 1;
-		st->int_vref_mv = voltage_uv;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	case IIO_CHAN_INFO_OFFSET:
-		*val = -(1 << (chan->scan_type.realbits - 1));
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->odr;
-		return IIO_VAL_INT;
-	default:
-	break;
-	}
-
-	return -EINVAL;
-}
-
-static int ad7780_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long m)
-{
-	struct ad7780_state *st = iio_priv(indio_dev);
-	const struct ad7780_chip_info *chip_info = st->chip_info;
-	unsigned long long vref;
-	unsigned int full_scale, gain;
-
-	if (!chip_info->is_ad778x)
-		return 0;
-
-	switch (m) {
-	case IIO_CHAN_INFO_SCALE:
-		if (val != 0)
-			return -EINVAL;
-
-		vref = st->int_vref_mv * 1000000LL;
-		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
-		gain = DIV_ROUND_CLOSEST(vref, full_scale);
-		gain = DIV_ROUND_CLOSEST(gain, val2);
-		st->gain = gain;
-		if (gain < AD7780_GAIN_MIDPOINT)
-			gain = 0;
-		else
-			gain = 1;
-		gpiod_set_value(st->gain_gpio, gain);
-		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)
-			val = 0;
-		else
-			val = 1;
-		st->odr = ad778x_odr_avail[val];
-		gpiod_set_value(st->filter_gpio, val);
-		break;
-	default:
-	break;
-	}
-
-	return 0;
-}
-
-static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
-				     unsigned int raw_sample)
-{
-	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
-	const struct ad7780_chip_info *chip_info = st->chip_info;
-
-	if ((raw_sample & AD7780_ERR) ||
-	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
-		return -EIO;
-
-	if (chip_info->is_ad778x) {
-		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
-		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
-	}
-
-	return 0;
-}
-
-static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
-	.set_mode = ad7780_set_mode,
-	.postprocess_sample = ad7780_postprocess_sample,
-	.has_registers = false,
-};
-
-#define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
-#define AD7170_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
-
-static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
-	[ID_AD7170] = {
-		.channel = AD7170_CHANNEL(12, 24),
-		.pattern = AD7170_PATTERN_GOOD,
-		.pattern_mask = AD7170_PATTERN_MASK,
-		.is_ad778x = false,
-	},
-	[ID_AD7171] = {
-		.channel = AD7170_CHANNEL(16, 24),
-		.pattern = AD7170_PATTERN_GOOD,
-		.pattern_mask = AD7170_PATTERN_MASK,
-		.is_ad778x = false,
-	},
-	[ID_AD7780] = {
-		.channel = AD7780_CHANNEL(24, 32),
-		.pattern = AD7780_PATTERN_GOOD,
-		.pattern_mask = AD7780_PATTERN_MASK,
-		.is_ad778x = true,
-	},
-	[ID_AD7781] = {
-		.channel = AD7780_CHANNEL(20, 32),
-		.pattern = AD7780_PATTERN_GOOD,
-		.pattern_mask = AD7780_PATTERN_MASK,
-		.is_ad778x = true,
-	},
-};
-
-static const struct iio_info ad7780_info = {
-	.read_raw = ad7780_read_raw,
-	.write_raw = ad7780_write_raw,
-};
-
-static int ad7780_probe(struct spi_device *spi)
-{
-	struct ad7780_state *st;
-	struct iio_dev *indio_dev;
-	int ret;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	st = iio_priv(indio_dev);
-	st->gain = 1;
-
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
-
-	st->chip_info =
-		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
-
-	spi_set_drvdata(spi, indio_dev);
-
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = &st->chip_info->channel;
-	indio_dev->num_channels = 1;
-	indio_dev->info = &ad7780_info;
-
-	st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
-						     "powerdown",
-						     GPIOD_OUT_LOW);
-	if (IS_ERR(st->powerdown_gpio)) {
-		ret = PTR_ERR(st->powerdown_gpio);
-		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
-			ret);
-		return ret;
-	}
-
-	if (st->chip_info->is_ad778x) {
-		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
-							"adi,gain",
-							GPIOD_OUT_HIGH);
-		if (IS_ERR(st->gain_gpio)) {
-			ret = PTR_ERR(st->gain_gpio);
-			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
-				ret);
-			return ret;
-		}
-
-		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
-							  "adi,filter",
-							  GPIOD_OUT_HIGH);
-		if (IS_ERR(st->filter_gpio)) {
-			ret = PTR_ERR(st->filter_gpio);
-			dev_err(&spi->dev,
-				"Failed to request filter GPIO: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
-
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer_and_trigger;
-
-	return 0;
-
-error_cleanup_buffer_and_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7780_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7780_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
-
-	return 0;
-}
-
-static const struct spi_device_id ad7780_id[] = {
-	{"ad7170", ID_AD7170},
-	{"ad7171", ID_AD7171},
-	{"ad7780", ID_AD7780},
-	{"ad7781", ID_AD7781},
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad7780_id);
-
-static struct spi_driver ad7780_driver = {
-	.driver = {
-		.name	= "ad7780",
-	},
-	.probe		= ad7780_probe,
-	.remove		= ad7780_remove,
-	.id_table	= ad7780_id,
-};
-module_spi_driver(ad7780_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
-MODULE_LICENSE("GPL v2");
-- 
2.21.0

