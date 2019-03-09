Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D970C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64022081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552156949;
	bh=xpEf7FPGS3RyU7sC1UENZgQ/Yrai+OLFOPDFPDrP5v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0JW2owhEn7iWe4bnZ5bZpXKyICGyUsbJHOqer/SfBqfohB1lG4kk/XyXey5lJsbah
	 tAF6GOw2AOfcN8qfzl3npBhRq4BWsDELNtz/cCV7ukjnHVkvhAnrcJKJ++POtXfrzr
	 cuwe+8HrcgdoIGdsTf2LnZJ1WEuWicgtaYvBnGH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCISm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCISm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:42:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13F820657;
        Sat,  9 Mar 2019 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552156946;
        bh=xpEf7FPGS3RyU7sC1UENZgQ/Yrai+OLFOPDFPDrP5v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/wEH7skGUc74Wbrc1MO/iVYxDBMu6fBawpyDP56/kn3Ws2QA2KN0YS76RKXMEnnU
         +4FgePMwAM7cvyw4UfO0Iqfhr+5N+MOvK/z1Io27VrIJ8dKCDr9QI7vfXAbKus1of4
         9H60FMuZK+vi1Jrf4fV/P0yClntG9hsYGI7zOoEw=
Date:   Sat, 9 Mar 2019 18:42:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     justinpopo6@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ti-ads7950: add GPIO support
Message-ID: <20190309184220.374c2435@archlinux>
In-Reply-To: <1552082608-42603-3-git-send-email-justinpopo6@gmail.com>
References: <1552082608-42603-1-git-send-email-justinpopo6@gmail.com>
        <1552082608-42603-3-git-send-email-justinpopo6@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 14:03:28 -0800
justinpopo6@gmail.com wrote:

> From: Justin Chen <justinpopo6@gmail.com>
> 
> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> pins using the GPIO chip framework.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 200 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 194 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 1e47bef..2e66e4d 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -17,6 +17,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -36,12 +37,15 @@
>   */
>  #define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000
>  
> +#define TI_ADS7950_CR_GPIO	BIT(14)
>  #define TI_ADS7950_CR_MANUAL	BIT(12)
>  #define TI_ADS7950_CR_WRITE	BIT(11)
>  #define TI_ADS7950_CR_CHAN(ch)	((ch) << 7)
>  #define TI_ADS7950_CR_RANGE_5V	BIT(6)
> +#define TI_ADS7950_CR_GPIO_DATA	BIT(4)
>  
>  #define TI_ADS7950_MAX_CHAN	16
> +#define TI_ADS7950_NUM_GPIOS	4
>  
>  #define TI_ADS7950_TIMESTAMP_SIZE (sizeof(int64_t) / sizeof(__be16))
>  
> @@ -49,6 +53,16 @@
>  #define TI_ADS7950_EXTRACT(val, dec, bits) \
>  	(((val) >> (dec)) & ((1 << (bits)) - 1))
>  
> +#define TI_ADS7950_MAN_CMD(cmd)         (TI_ADS7950_CR_MANUAL | (cmd))
> +#define TI_ADS7950_GPIO_CMD(cmd)        (TI_ADS7950_CR_GPIO | (cmd))
> +
> +/* Manual mode configuration */
> +#define TI_ADS7950_MAN_CMD_SETTINGS(st) \
> +	(TI_ADS7950_MAN_CMD(TI_ADS7950_CR_WRITE | st->cmd_settings_bitmask))
> +/* GPIO mode configuration */
> +#define TI_ADS7950_GPIO_CMD_SETTINGS(st) \
> +	(TI_ADS7950_GPIO_CMD(st->gpio_cmd_settings_bitmask))
> +
>  struct ti_ads7950_state {
>  	struct spi_device	*spi;
>  	struct spi_transfer	ring_xfer;
> @@ -58,11 +72,34 @@ struct ti_ads7950_state {
>  
>  	/* Lock to protect the spi xfer buffers */
>  	struct mutex		slock;
> +	struct gpio_chip	chip;
>  
>  	struct regulator	*reg;
>  	unsigned int		vref_mv;
>  
> -	unsigned int		settings;
> +	/*
> +	 * Bitmask of lower 7 bits used for configuration
> +	 * These bits only can be written when TI_ADS7950_CR_WRITE
> +	 * is set, otherwise it retains its original state.
> +	 * [0-3] GPIO signal
> +	 * [4]   Set following frame to return GPIO signal values
> +	 * [5]   Powers down device
> +	 * [6]   Sets Vref range1(2.5v) or range2(5v)
> +	 *
> +	 * Bits present on Manual/Auto1/Auto2 commands
> +	 */
> +	unsigned int		cmd_settings_bitmask;
> +
> +	/*
> +	 * Bitmask of GPIO command
> +	 * [0-3] GPIO direction
> +	 * [4-6] Different GPIO alarm mode configurations
> +	 * [7]   GPIO 2 as device range input
> +	 * [8]   GPIO 3 as device power down input
> +	 * [9]   Reset all registers
> +	 * [10-11] N/A
> +	 */
> +	unsigned int		gpio_cmd_settings_bitmask;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -251,7 +288,7 @@ static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	len = 0;
>  	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
> -		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings;
> +		cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(i));
>  		st->tx_buf[len++] = cmd;
>  	}
>  
> @@ -292,8 +329,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	int ret, cmd;
>  
>  	mutex_lock(&st->slock);
> -
> -	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
> +	cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(ch));
>  	st->single_tx = cmd;
>  
>  	ret = spi_sync(st->spi, &st->scan_single_msg);
> @@ -322,7 +358,7 @@ static int ti_ads7950_get_range(struct ti_ads7950_state *st)
>  		vref /= 1000;
>  	}
>  
> -	if (st->settings & TI_ADS7950_CR_RANGE_5V)
> +	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
>  		vref *= 2;
>  
>  	return vref;
> @@ -367,6 +403,132 @@ static const struct iio_info ti_ads7950_info = {
>  	.update_scan_mode	= ti_ads7950_update_scan_mode,
>  };
>  
> +static void ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
> +			   int value)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +
> +	mutex_lock(&st->slock);
> +
> +	if (value)
> +		st->cmd_settings_bitmask |= BIT(offset);
> +	else
> +		st->cmd_settings_bitmask &= ~BIT(offset);
> +
> +	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> +	spi_sync(st->spi, &st->scan_single_msg);
> +
> +	mutex_unlock(&st->slock);
> +}
> +
> +static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +	int ret;
> +
> +	mutex_lock(&st->slock);
> +
> +	/* If set as output, return the output */
> +	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
> +		ret = st->cmd_settings_bitmask & BIT(offset);
> +		goto out;
> +	}
> +
> +	/* GPIO data bit sets SDO bits 12-15 to GPIO input */
> +	st->cmd_settings_bitmask |= TI_ADS7950_CR_GPIO_DATA;
> +	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		goto out;
> +
> +	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
> +
> +	/* Revert back to original settings */
> +	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
> +	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	mutex_unlock(&st->slock);
> +
> +	return ret;
> +}
> +
> +static int ti_ads7950_get_direction(struct gpio_chip *chip,
> +				    unsigned int offset)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +
> +	/* Bitmask is inverted from GPIO framework 0=input/1=output */
> +	return !(st->gpio_cmd_settings_bitmask & BIT(offset));
> +}
> +
> +static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
> +				     int input)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +	int ret = 0;
> +
> +	mutex_lock(&st->slock);
> +
> +	/* Only change direction if needed */
> +	if (input && (st->gpio_cmd_settings_bitmask & BIT(offset)))
> +		st->gpio_cmd_settings_bitmask &= ~BIT(offset);
> +	else if (!input && !(st->gpio_cmd_settings_bitmask & BIT(offset)))
> +		st->gpio_cmd_settings_bitmask |= BIT(offset);
> +	else
> +		goto out;
> +
> +	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +
> +out:
> +	mutex_unlock(&st->slock);
> +
> +	return ret;
> +}
> +
> +static int ti_ads7950_direction_input(struct gpio_chip *chip,
> +				      unsigned int offset)
> +{
> +	return _ti_ads7950_set_direction(chip, offset, 1);
> +}
> +
> +static int ti_ads7950_direction_output(struct gpio_chip *chip,
> +				       unsigned int offset, int value)
> +{
> +	ti_ads7950_set(chip, offset, value);
> +
> +	return _ti_ads7950_set_direction(chip, offset, 0);
> +}
> +
> +static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&st->slock);
> +
> +	/* Settings for Manual/Auto1/Auto2 commands */
> +	/* Default to 5v ref */
> +	st->cmd_settings_bitmask = TI_ADS7950_CR_RANGE_5V;
> +	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		goto out;
> +
> +	/* Settings for GPIO command */
> +	st->gpio_cmd_settings_bitmask = 0x0;
> +	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +
> +out:
> +	mutex_unlock(&st->slock);
> +
> +	return ret;
> +}
> +
>  static int ti_ads7950_probe(struct spi_device *spi)
>  {
>  	struct ti_ads7950_state *st;
> @@ -391,7 +553,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	st->spi = spi;
> -	st->settings = TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_RANGE_5V;
>  
>  	info = &ti_ads7950_chip_info[spi_get_device_id(spi)->driver_data];
>  
> @@ -459,14 +620,40 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  		goto error_disable_reg;
>  	}
>  
> +	ret = ti_ads7950_init_hw(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to init adc chip\n");
> +		goto error_cleanup_ring;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to register iio device\n");
>  		goto error_cleanup_ring;
>  	}
>  
> +	/* Add GPIO chip */
> +	st->chip.label = dev_name(&st->spi->dev);
> +	st->chip.parent = &st->spi->dev;
> +	st->chip.owner = THIS_MODULE;
> +	st->chip.base = -1;
> +	st->chip.ngpio = TI_ADS7950_NUM_GPIOS;
> +	st->chip.get_direction = ti_ads7950_get_direction;
> +	st->chip.direction_input = ti_ads7950_direction_input;
> +	st->chip.direction_output = ti_ads7950_direction_output;
> +	st->chip.get = ti_ads7950_get;
> +	st->chip.set = ti_ads7950_set;
> +
> +	ret = gpiochip_add_data(&st->chip, st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to init GPIOs\n");
> +		goto error_iio_device;
> +	}
> +
>  	return 0;
>  
> +error_iio_device:
> +	iio_device_unregister(indio_dev);
>  error_cleanup_ring:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_reg:
> @@ -482,6 +669,7 @@ static int ti_ads7950_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct ti_ads7950_state *st = iio_priv(indio_dev);
>  
> +	gpiochip_remove(&st->chip);
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	regulator_disable(st->reg);

