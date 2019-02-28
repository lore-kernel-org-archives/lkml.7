Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EB72184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KJbFzU0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfB1WRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:17:50 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:54790 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728807AbfB1WRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:17:48 -0500
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7BFF530C062;
        Thu, 28 Feb 2019 14:17:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7BFF530C062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1551392265;
        bh=O1WZ6ypgpJmoh3xhtqfNQG7XD8MtxaS3nKm0DN0vOf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJbFzU0Zw3UVfu+RcZOVuDZwntSDJoV8fh+dOtdy1OuQXxfQLaOEds56OJ+7KabtS
         O0JWWBHw5r2oqR1O1x8hBQkOM3UMdBn93rUMysWUeh/P9NDIN8nLxuhiI3+vXZ31/1
         VjjAXNYLV4Ka1FpkARNQXuRvi2Z8SsXo2uHoVCdE=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id CBC39AC0798;
        Thu, 28 Feb 2019 14:17:45 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id C402227ECE7; Thu, 28 Feb 2019 14:17:45 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v4 2/2] iio: adc: ti-ads7950: add GPIO support
Date:   Thu, 28 Feb 2019 14:16:49 -0800
Message-Id: <1551392209-20004-3-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551392209-20004-1-git-send-email-justinpopo6@gmail.com>
References: <1551392209-20004-1-git-send-email-justinpopo6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

The ADS79XX has GPIO pins that can be used. Add support for the GPIO
pins using the GPIO chip framework.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 200 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 194 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 1e47bef..0964053 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -36,12 +37,15 @@
  */
 #define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000
 
+#define TI_ADS7950_CR_GPIO	BIT(14)
 #define TI_ADS7950_CR_MANUAL	BIT(12)
 #define TI_ADS7950_CR_WRITE	BIT(11)
 #define TI_ADS7950_CR_CHAN(ch)	((ch) << 7)
 #define TI_ADS7950_CR_RANGE_5V	BIT(6)
+#define TI_ADS7950_CR_GPIO_DATA	BIT(4)
 
 #define TI_ADS7950_MAX_CHAN	16
+#define TI_ADS7950_NUM_GPIOS	4
 
 #define TI_ADS7950_TIMESTAMP_SIZE (sizeof(int64_t) / sizeof(__be16))
 
@@ -49,6 +53,16 @@
 #define TI_ADS7950_EXTRACT(val, dec, bits) \
 	(((val) >> (dec)) & ((1 << (bits)) - 1))
 
+#define TI_ADS7950_MAN_CMD(cmd)         (TI_ADS7950_CR_MANUAL | (cmd))
+#define TI_ADS7950_GPIO_CMD(cmd)        (TI_ADS7950_CR_GPIO | (cmd))
+
+/* Manual mode configuration */
+#define TI_ADS7950_MAN_CMD_SETTINGS(st) \
+	(TI_ADS7950_MAN_CMD(TI_ADS7950_CR_WRITE | st->cmd_settings_bitmask))
+/* GPIO mode configuration */
+#define TI_ADS7950_GPIO_CMD_SETTINGS(st) \
+	(TI_ADS7950_GPIO_CMD(st->gpio_cmd_settings_bitmask))
+
 struct ti_ads7950_state {
 	struct spi_device	*spi;
 	struct spi_transfer	ring_xfer;
@@ -58,11 +72,34 @@ struct ti_ads7950_state {
 
 	/* Lock to protect the spi xfer buffers */
 	struct mutex		slock;
+	struct gpio_chip	chip;
 
 	struct regulator	*reg;
 	unsigned int		vref_mv;
 
-	unsigned int		settings;
+	/*
+	 * Bitmask of lower 7 bits used for configuration
+	 * These bits only can be written when TI_ADS7950_CR_WRITE
+	 * is set, otherwise it retains its original state.
+	 * [0-3] GPIO signal
+	 * [4]   Set following frame to return GPIO signal values
+	 * [5]   Powers down device
+	 * [6]   Sets Vref range1(2.5v) or range2(5v)
+	 *
+	 * Bits present on Manual/Auto1/Auto2 commands
+	 */
+	unsigned int		cmd_settings_bitmask;
+
+	/*
+	 * Bitmask of GPIO command
+	 * [0-3] GPIO direction
+	 * [4-6] Different GPIO alarm mode configurations
+	 * [7]   GPIO 2 as device range input
+	 * [8]   GPIO 3 as device power down input
+	 * [9]   Reset all registers
+	 * [10-11] N/A
+	 */
+	unsigned int		gpio_cmd_settings_bitmask;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -251,7 +288,7 @@ static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
 
 	len = 0;
 	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
-		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings;
+		cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(i));
 		st->tx_buf[len++] = cmd;
 	}
 
@@ -292,8 +329,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	int ret, cmd;
 
 	mutex_lock(&st->slock);
-
-	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
+	cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(ch));
 	st->single_tx = cmd;
 
 	ret = spi_sync(st->spi, &st->scan_single_msg);
@@ -322,7 +358,7 @@ static int ti_ads7950_get_range(struct ti_ads7950_state *st)
 		vref /= 1000;
 	}
 
-	if (st->settings & TI_ADS7950_CR_RANGE_5V)
+	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
 		vref *= 2;
 
 	return vref;
@@ -367,6 +403,135 @@ static const struct iio_info ti_ads7950_info = {
 	.update_scan_mode	= ti_ads7950_update_scan_mode,
 };
 
+static void ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
+			   int value)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+
+	mutex_lock(&st->slock);
+
+	if (value)
+		st->cmd_settings_bitmask |= BIT(offset);
+	else
+		st->cmd_settings_bitmask &= ~BIT(offset);
+
+	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
+	spi_sync(st->spi, &st->scan_single_msg);
+
+	mutex_unlock(&st->slock);
+}
+
+static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+	int ret;
+
+	mutex_lock(&st->slock);
+
+	/* If set as output, return the output */
+	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
+		ret = st->cmd_settings_bitmask & BIT(offset);
+		goto out;
+	}
+
+	/* GPIO data bit sets SDO bits 12-15 to GPIO input */
+	st->cmd_settings_bitmask |= TI_ADS7950_CR_GPIO_DATA;
+	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	if (ret)
+		goto out;
+
+	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
+
+	/* Revert back to original settings */
+	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
+	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	if (ret)
+		goto out;
+
+out:
+	mutex_unlock(&st->slock);
+
+	return ret;
+}
+
+static int ti_ads7950_get_direction(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+
+	/* Bitmask is inverted from GPIO framework 0=input/1=output */
+	return !(st->gpio_cmd_settings_bitmask & BIT(offset));
+}
+
+static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
+				     int input)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+	int ret = 0;
+
+	mutex_lock(&st->slock);
+
+	/* Only change direction if needed */
+	if (input && (st->gpio_cmd_settings_bitmask & BIT(offset)))
+		st->gpio_cmd_settings_bitmask &= ~BIT(offset);
+	else if (!input && !(st->gpio_cmd_settings_bitmask & BIT(offset)))
+		st->gpio_cmd_settings_bitmask |= BIT(offset);
+	else
+		goto out;
+
+	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+
+out:
+	mutex_unlock(&st->slock);
+
+	return ret;
+}
+
+static int ti_ads7950_direction_input(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	return _ti_ads7950_set_direction(chip, offset, 1);
+}
+
+static int ti_ads7950_direction_output(struct gpio_chip *chip,
+				       unsigned int offset, int value)
+{
+	ti_ads7950_set(chip, offset, value);
+
+	return _ti_ads7950_set_direction(chip, offset, 0);
+}
+
+static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
+{
+	int ret = 0;
+
+	mutex_lock(&st->slock);
+
+	/* Settings for Manual/Auto1/Auto2 commands */
+	/* Default to 5v ref */
+	st->cmd_settings_bitmask = TI_ADS7950_CR_RANGE_5V;
+	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	if (ret)
+		goto out;
+
+	/* Settings for GPIO command */
+	st->gpio_cmd_settings_bitmask = 0x0;
+	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	mutex_unlock(&st->slock);
+	if (ret)
+		goto out;
+
+out:
+	mutex_unlock(&st->slock);
+
+	return ret;
+}
+
 static int ti_ads7950_probe(struct spi_device *spi)
 {
 	struct ti_ads7950_state *st;
@@ -391,7 +556,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	st->spi = spi;
-	st->settings = TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_RANGE_5V;
 
 	info = &ti_ads7950_chip_info[spi_get_device_id(spi)->driver_data];
 
@@ -465,6 +629,30 @@ static int ti_ads7950_probe(struct spi_device *spi)
 		goto error_cleanup_ring;
 	}
 
+	ret = ti_ads7950_init_hw(st);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to init adc chip\n");
+		goto error_cleanup_ring;
+	}
+
+	/* Add GPIO chip */
+	st->chip.label = dev_name(&st->spi->dev);
+	st->chip.parent = &st->spi->dev;
+	st->chip.owner = THIS_MODULE;
+	st->chip.base = -1;
+	st->chip.ngpio = TI_ADS7950_NUM_GPIOS;
+	st->chip.get_direction = ti_ads7950_get_direction;
+	st->chip.direction_input = ti_ads7950_direction_input;
+	st->chip.direction_output = ti_ads7950_direction_output;
+	st->chip.get = ti_ads7950_get;
+	st->chip.set = ti_ads7950_set;
+
+	ret = gpiochip_add_data(&st->chip, st);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to init GPIOs\n");
+		goto error_cleanup_ring;
+	}
+
 	return 0;
 
 error_cleanup_ring:
-- 
2.7.4

