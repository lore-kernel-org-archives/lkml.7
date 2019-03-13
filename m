Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF094C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955DE2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1dEQiQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfCMLP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:15:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39290 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMLP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:15:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so1133630edc.6;
        Wed, 13 Mar 2019 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8s4kfXQlKj0ddPFhnWnOCK4abU0cYxTAMl3tmC67wjM=;
        b=l1dEQiQ3Ijm+9jQt2/AMWLqp2k04Nz2ZuLNyGqeZsDUneUCV0MdERsedOzls8hp5Eg
         lmHIxcKH5YFitdaOKBvvvyxS1iWbHCRe/1bTgytNOaioNCUv6uUwTbFh42XoTpRH41SG
         mZQtyHLyo1f8xAZhYZajCyCbNnMUzxwXDhM8iT1CsC2XiuwqVSBNcW5QvJJxVTwv82yV
         iN/ZIrBjg3CFftpBfFqwBfKPEWmuT/0AwOpMka0QMMKdxkrIqIDOBVx8oQXcwkuiaPQf
         cEx2jAGyvAyXIpiNb1ygWLL/xabQVGV+doERTS49f9JaDT9+ilBbE0HwkNHxOSSbvbE1
         prOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8s4kfXQlKj0ddPFhnWnOCK4abU0cYxTAMl3tmC67wjM=;
        b=bJHsCmM9t1uorbrVzpvkPVS8oW4R/njhI21lCl3LJoUEJAhWY46jBs/vMsgxuoG6Gl
         OSvMpB7vTQ6ol8jCb2Z1fak41b5q0EsIeOKCy94uvkU1xC5ckPPVFoWv3zUEVIlugIlx
         +ejhHkaDOrqKOPDf3mL1tRvkX0Y2NopFM/ZEX3SjKqyzVFI8J9kmpgnoImbPLqEJxcks
         JKzuy1AgMQ9zgukGClqWSqWXucoDRjwxWeW7mPlzoWYHxSwZLKYwYEColatPiNeWqu1I
         NM5bF7naaEddrLLwf/m8RVdG2bRiW/QEwA1ket6utkP+8tK7uFZMWH0X4hjkke4kkgAr
         Xldw==
X-Gm-Message-State: APjAAAU7LX/N3l3q9VgE2pF1VPNE9cx+rcPmfNSDJHObM3JVTHXiolSM
        IAb4Vnd1qiNoBG0OWYxEPEU=
X-Google-Smtp-Source: APXvYqxjwW3cLXVUG9CobiSTnU00mu/2yEeWOphvOtE5mHeVzrOwMgn66rn7SeO3WJgdzVb8Va+YXw==
X-Received: by 2002:a50:9259:: with SMTP id j25mr7042214eda.247.1552475725376;
        Wed, 13 Mar 2019 04:15:25 -0700 (PDT)
Received: from localhost.localdomain (x4db55a4e.dyn.telefonica.de. [77.181.90.78])
        by smtp.gmail.com with ESMTPSA id y17sm378237ejj.10.2019.03.13.04.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 04:15:24 -0700 (PDT)
From:   Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
Cc:     Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: Add driver for TLA202x ADCs
Date:   Wed, 13 Mar 2019 12:14:03 +0100
Message-Id: <1552475646-5181-1-git-send-email-ibtsam.haq.0x01@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542679806-5812-1-git-send-email-ibtsam.haq.0x01@gmail.com>
References: <1542679806-5812-1-git-send-email-ibtsam.haq.0x01@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic driver for Texas Instruments TLA202x series ADCs. Input
channels are configurable from the device tree. Input scaling
is supported. Trigger buffer support is not yet implemented.

Signed-off-by: Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
---
Changes in v2:
- changed commit message
- Added mutex to protect channel selection
- Removed redundant mutex around i2c transfers
- Removed PROCESSED channel output
- Added SCALE info
- Removed Continuous Mode since continuous read not supported
- Removed SAMP_FREQ info since continuous read not supported
---
 drivers/iio/adc/Kconfig      |  11 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-tla2024.c | 463 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 475 insertions(+)
 create mode 100644 drivers/iio/adc/ti-tla2024.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5762565..8c214c8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -816,6 +816,17 @@ config TI_AM335X_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called ti_am335x_adc.
 
+config TI_TLA2024
+	tristate "Texas Instruments TLA2024/TLA2022/TLA2021 ADC driver"
+	depends on OF
+	depends on I2C
+	help
+	  Say yes here to build support for Texas Instruments TLA2024,
+	  TLA2022 or TLA2021 I2C Analog to Digital Converters.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ti-tla2024.
+
 config TI_TLC4541
 	tristate "Texas Instruments TLC4541 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9874e05..819f35b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
+obj-$(CONFIG_TI_TLA2024) += ti-tla2024.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
 obj-$(CONFIG_VF610_ADC) += vf610_adc.o
diff --git a/drivers/iio/adc/ti-tla2024.c b/drivers/iio/adc/ti-tla2024.c
new file mode 100644
index 0000000..e902eb8
--- /dev/null
+++ b/drivers/iio/adc/ti-tla2024.c
@@ -0,0 +1,463 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Texas Instruments TLA2021/TLA2022/TLA2024 12-bit ADC driver
+ *
+ * Copyright (C) 2019 Koninklijke Philips N.V.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#define TLA2024_DATA 0x00
+#define TLA2024_DATA_RES_MASK GENMASK(15, 4)
+#define TLA2024_DATA_RES_SHIFT 4
+
+#define TLA2024_CONF 0x01
+#define TLA2024_CONF_OS_MASK BIT(15)
+#define TLA2024_CONF_OS_SHIFT 15
+#define TLA2024_CONF_MUX_MASK GENMASK(14, 12)
+#define TLA2024_CONF_MUX_SHIFT 12
+#define TLA2024_CONF_PGA_MASK GENMASK(11, 9)
+#define TLA2024_CONF_PGA_SHIFT 9
+#define TLA2024_CONF_MODE_MASK BIT(8)
+#define TLA2024_CONF_MODE_SHIFT 8
+#define TLA2024_CONF_DR_MASK GENMASK(7, 5)
+#define TLA2024_CONF_DR_SHIFT 5
+
+#define TLA2024_CONV_RETRY 10
+
+struct tla202x_model {
+	unsigned int mux_available;
+	unsigned int pga_available;
+};
+
+struct tla2024 {
+	struct i2c_client *i2c;
+	struct tla202x_model *model;
+	struct mutex lock; /* protect channel selection */
+	u8 used_mux_channels;
+};
+
+struct tla2024_channel {
+	int ainp;
+	int ainn;
+	const char *datasheet_name;
+	bool differential;
+};
+
+static const struct tla2024_channel tla2024_all_channels[] = {
+	{0, 1, "AIN0-AIN1", 1},
+	{0, 3, "AIN0-AIN3", 1},
+	{1, 3, "AIN1-AIN3", 1},
+	{2, 3, "AIN2-AIN3", 1},
+	{0, -1, "AIN0-GND", 0},
+	{1, -1, "AIN1-GND", 0},
+	{2, -1, "AIN2-GND", 0},
+	{3, -1, "AIN3-GND", 0},
+};
+
+static int tla2024_find_chan_idx(int ainp_in, int ainn_in, u16 *idx)
+{
+	u16 i;
+
+	for (i = 0; i < ARRAY_SIZE(tla2024_all_channels); i++) {
+		if ((tla2024_all_channels[i].ainp == ainp_in) &&
+		    (tla2024_all_channels[i].ainn == ainn_in)) {
+			*idx = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+#define TLA202x_MODEL(_mux, _pga)		\
+	{					\
+		.mux_available = (_mux),	\
+		.pga_available = (_pga),	\
+	}
+
+enum tla2024_model_id {
+	TLA2024 = 0,
+	TLA2022 = 1,
+	TLA2021 = 2,
+};
+
+static struct tla202x_model tla202x_models[] = {
+	TLA202x_MODEL(1, 1), // TLA2024
+	TLA202x_MODEL(0, 1), // TLA2022
+	TLA202x_MODEL(0, 0), // TLA2021
+};
+
+static const int tla2024_scale[] = { /* scale, int plus micro */
+	3, 0, 2, 0, 1, 0, 0, 500000, 0, 250000, 0, 125000 };
+
+static int tla2024_get(struct tla2024 *priv, u8 addr, u16 mask,
+		       u16 shift, u16 *val)
+{
+	int ret;
+	u16 data;
+
+	ret = i2c_smbus_read_word_swapped(priv->i2c, addr);
+	if (ret < 0)
+		return ret;
+
+	data = ret;
+	*val = (mask & data) >> shift;
+
+	return 0;
+}
+
+static int tla2024_set(struct tla2024 *priv, u8 addr, u16 mask,
+		       u16 shift, u16 val)
+{
+	int ret;
+	u16 data;
+
+	ret = i2c_smbus_read_word_swapped(priv->i2c, addr);
+	if (ret < 0)
+		return ret;
+
+	data = ret;
+	data &= ~mask;
+	data |= mask & (val << shift);
+
+	ret = i2c_smbus_write_word_swapped(priv->i2c, addr, data);
+
+	return ret;
+}
+
+static int tla2024_read_avail(struct iio_dev *idev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+
+		*length = ARRAY_SIZE(tla2024_scale);
+		*vals = tla2024_scale;
+
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static int tla2024_of_find_chan(struct tla2024 *priv, struct device_node *ch)
+{
+	u16 chan_idx = 0;
+	u32 tmp_p, tmp_n;
+	int ainp, ainn;
+	int ret;
+
+	ret = of_property_read_u32_index(ch, "single-channel", 0, &tmp_p);
+	if (ret) {
+		ret = of_property_read_u32_index(ch,
+						 "diff-channels", 0, &tmp_p);
+		if (ret)
+			return ret;
+
+		ret = of_property_read_u32_index(ch,
+						 "diff-channels", 1, &tmp_n);
+		if (ret)
+			return ret;
+
+		ainp = (int)tmp_p;
+		ainn = (int)tmp_n;
+	} else {
+		ainp = (int)tmp_p;
+		ainn = -1;
+	}
+
+	ret = tla2024_find_chan_idx(ainp, ainn, &chan_idx);
+	if (ret < 0)
+		return ret;
+
+	/* if model doesn"t have mux then only channel 0 is allowed */
+	if (!priv->model->mux_available && chan_idx)
+		return -EINVAL;
+
+	/* if already used */
+	if ((priv->used_mux_channels) & (1 << chan_idx))
+		return -EINVAL;
+
+	return chan_idx;
+}
+
+static int tla2024_init_chan(struct iio_dev *idev, struct device_node *node,
+			     struct iio_chan_spec *chan)
+{
+	struct tla2024 *priv = iio_priv(idev);
+	u16 chan_idx;
+	int ret;
+
+	ret = tla2024_of_find_chan(priv, node);
+	if (ret < 0)
+		return ret;
+
+	chan_idx = ret;
+	priv->used_mux_channels |= BIT(chan_idx);
+	chan->type = IIO_VOLTAGE;
+	chan->channel = tla2024_all_channels[chan_idx].ainp;
+	chan->channel2 = tla2024_all_channels[chan_idx].ainn;
+	chan->differential = tla2024_all_channels[chan_idx].differential;
+	chan->extend_name = node->name;
+	chan->datasheet_name = tla2024_all_channels[chan_idx].datasheet_name;
+	chan->indexed = 1;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE);
+	chan->info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SCALE);
+
+	return 0;
+}
+
+static int tla2024_wait(struct tla2024 *priv)
+{
+	int ret;
+	unsigned int retry = TLA2024_CONV_RETRY;
+	u16 status;
+
+	do {
+		if (!--retry)
+			return -EIO;
+		ret = tla2024_get(priv, TLA2024_CONF, TLA2024_CONF_OS_MASK,
+				  TLA2024_CONF_OS_SHIFT, &status);
+		if (ret < 0)
+			return ret;
+		if (!status)
+			usleep_range(25, 1000);
+	} while (!status);
+
+	return ret;
+}
+
+static int tla2024_select_channel(struct tla2024 *priv,
+				  struct iio_chan_spec const *chan)
+{
+	int ret;
+	int ainp = chan->channel;
+	int ainn = chan->channel2;
+	u16 chan_id = 0;
+
+	ret = tla2024_find_chan_idx(ainp, ainn, &chan_id);
+	if (ret < 0)
+		return ret;
+
+	return tla2024_set(priv, TLA2024_CONF, TLA2024_CONF_MUX_MASK,
+					   TLA2024_CONF_MUX_SHIFT, chan_id);
+}
+
+static int tla2024_convert(struct tla2024 *priv)
+{
+	int ret = 0;
+
+	ret = tla2024_set(priv, TLA2024_CONF, TLA2024_CONF_OS_MASK,
+			  TLA2024_CONF_OS_SHIFT, 1);
+	if (ret < 0)
+		return ret;
+
+	return tla2024_wait(priv);
+}
+
+static int tla2024_read_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct tla2024 *priv = iio_priv(idev);
+	int ret;
+	u16 data;
+	s16 tmp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&priv->lock);
+		ret = tla2024_select_channel(priv, channel);
+		if (ret < 0)
+			goto return_unlock;
+
+		ret = tla2024_convert(priv);
+		if (ret < 0)
+			goto return_unlock;
+
+		ret = tla2024_get(priv, TLA2024_DATA, TLA2024_DATA_RES_MASK,
+				  TLA2024_DATA_RES_SHIFT, &data);
+		if (ret < 0)
+			goto return_unlock;
+
+		tmp = (s16)(data << TLA2024_DATA_RES_SHIFT);
+		*val = tmp >> TLA2024_DATA_RES_SHIFT;
+		ret = IIO_VAL_INT;
+
+return_unlock:
+		mutex_unlock(&priv->lock);
+		return ret;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (!(priv->model->pga_available)) {
+			*val = 1; /* Scale always 1 mV when no PGA */
+			return IIO_VAL_INT;
+		}
+		ret = tla2024_get(priv, TLA2024_CONF, TLA2024_CONF_PGA_MASK,
+				  TLA2024_CONF_PGA_SHIFT, &data);
+		if (ret < 0)
+			return ret;
+
+		/* gain for the 3bit pga values 6 and 7 is same as at 5 */
+		if (data >= (ARRAY_SIZE(tla2024_scale) >> 1))
+			data = (ARRAY_SIZE(tla2024_scale) >> 1) - 1;
+
+		*val = tla2024_scale[data << 1];
+		*val2 = tla2024_scale[(data << 1) + 1];
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tla2024_write_raw(struct iio_dev *idev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct tla2024 *priv = iio_priv(idev);
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!(priv->model->pga_available))
+			return -EINVAL; /* scale can't be changed if no pga */
+
+		for (i = 0; i < ARRAY_SIZE(tla2024_scale); i = i + 2) {
+			if ((tla2024_scale[i] == val) &&
+			    (tla2024_scale[i + 1] == val2))
+				break;
+		}
+
+		if (i == ARRAY_SIZE(tla2024_scale))
+			return -EINVAL;
+
+		return tla2024_set(priv, TLA2024_CONF, TLA2024_CONF_PGA_MASK,
++					TLA2024_CONF_PGA_SHIFT, i >> 1);
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int tla2024_of_chan_init(struct iio_dev *idev)
+{
+	struct device_node *node = idev->dev.of_node;
+	struct device_node *child;
+	struct iio_chan_spec *channels;
+	int ret, i, num_channels;
+
+	num_channels = of_get_available_child_count(node);
+	if (!num_channels) {
+		dev_err(&idev->dev, "no channels configured\n");
+		return -ENODEV;
+	}
+
+	channels = devm_kcalloc(&idev->dev, num_channels,
+				sizeof(struct iio_chan_spec), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_available_child_of_node(node, child) {
+		ret = tla2024_init_chan(idev, child, &channels[i]);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+		i++;
+	}
+
+	idev->channels = channels;
+	idev->num_channels = num_channels;
+
+	return 0;
+}
+
+static const struct iio_info tla2024_info = {
+	.read_raw = tla2024_read_raw,
+	.write_raw = tla2024_write_raw,
+	.read_avail = tla2024_read_avail,
+};
+
+static int tla2024_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *iio;
+	struct tla2024 *priv;
+	struct tla202x_model *model;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	model = &tla202x_models[id->driver_data];
+
+	iio = devm_iio_device_alloc(&client->dev, sizeof(*priv));
+	if (!iio)
+		return -ENOMEM;
+
+	priv = iio_priv(iio);
+	priv->i2c = client;
+	priv->model = model;
+	mutex_init(&priv->lock);
+
+	iio->dev.parent = &client->dev;
+	iio->dev.of_node = client->dev.of_node;
+	iio->name = client->name;
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &tla2024_info;
+
+	ret = tla2024_of_chan_init(iio);
+	if (ret < 0)
+		return ret;
+
+	ret = tla2024_set(priv, TLA2024_CONF, TLA2024_CONF_MODE_MASK,
+			  TLA2024_CONF_MODE_SHIFT, 1);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, iio);
+}
+
+static const struct i2c_device_id tla2024_id[] = {
+	{ "tla2024", TLA2024 },
+	{ "tla2022", TLA2022 },
+	{ "tla2021", TLA2021 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tla2024_id);
+
+static const struct of_device_id tla2024_of_match[] = {
+	{ .compatible = "ti,tla2024" },
+	{ .compatible = "ti,tla2022" },
+	{ .compatible = "ti,tla2021" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tla2024_of_match);
+
+static struct i2c_driver tla2024_driver = {
+	.driver = {
+		.name = "tla2024",
+		.of_match_table = of_match_ptr(tla2024_of_match),
+	},
+	.probe = tla2024_probe,
+	.id_table = tla2024_id,
+};
+module_i2c_driver(tla2024_driver);
+
+MODULE_AUTHOR("Ibtsam Haq <ibtsam.haq@philips.com>");
+MODULE_DESCRIPTION("Texas Instruments TLA2021/TLA2022/TLA2024 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

