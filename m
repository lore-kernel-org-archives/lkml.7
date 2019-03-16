Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7661AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5721903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752199;
	bh=agemnFM0i8J1OzgNaTUMd4SQnPPkh2oL7jKnWGAAa2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DmGNEYEfJHTf/La81Leos0nsRQB84a6B/5Lqh1l71kEuV01k3OBwEcIpkR68VG3im
	 Y0+u6kkixzV9+prBbSY5NvHfmyKzquntni+a61B6s4aUqnEYTPjKLtTDYZUdTktaJj
	 fkL0Rwq7V+coPNqQEQPtlkWY7Rs/8QZDnVZzQ8tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCPQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfCPQDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:03:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E801521900;
        Sat, 16 Mar 2019 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752194;
        bh=agemnFM0i8J1OzgNaTUMd4SQnPPkh2oL7jKnWGAAa2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E7GWfdxeK6IluPfpaow5yzwuoangLDbyPDT2RLRT76pljwZYDwck+rltAGAjqCE/+
         3Kxh4b8HRkKY7le2UQ6ZaPX3mocKCQX/vkAXkQDuwQJS4e7dWaCIr6+f4MhtAGZiK7
         DT8jhjSCIivv5uD4/7LaCRefKR036Sg16WR0ec2c=
Date:   Sat, 16 Mar 2019 16:03:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: imu: adis16480: Add support for external
 clock
Message-ID: <20190316160309.73a58843@archlinux>
In-Reply-To: <1552297529-26422-1-git-send-email-stefan.popa@analog.com>
References: <1552297529-26422-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 11:45:29 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Inertial sensor data collection and processing can be controlled by
> configuring one of the DIOx lines as an external clock input. This
> option is available for all devices supported by this driver. However,
> only adis1649x devices support different modes for the external clock.
> 
> Sync mode is supported by all devices. In this mode, the output data
> rate is equal with the clock frequency divided by DEC_RATE + 1. This
> mode of calculation is similar with the case when the internal clock is
> used.
> 
> Pulse Per Second (PPS) Mode, is only supported by adis1649x devices. In
> this mode, the output data rate is equal to the product of the external
> clock frequency and the scale factor in the SYNC_SCALE register.
> 
> This patch uses the "clock-names" property to enable the external clock
> in one of the two supported modes: "sync" or "pps". This property is
> optional. If it is not specified, the internal clock is used.
> 
> This patch also offers the option to select the DIOx line to be used as
> an external clock input via the custom "adi,ext-clk-pin" property. If this
> field is left empty, DIO2 is assigned as default external clock input pin.
> Each DIOx pin supports only one function at a time (data ready line
> selection or external clock input).
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- used ADIS16480_DRDY_SEL() macro when checking for external clock
> 	  input pin.
> 
>  drivers/iio/imu/adis16480.c | 186 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 179 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 28cece3..ab137c1 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -9,6 +9,7 @@
>   *
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/bitfield.h>
>  #include <linux/of_irq.h>
>  #include <linux/interrupt.h>
> @@ -99,6 +100,12 @@
>  #define ADIS16480_REG_FIRM_DM			ADIS16480_REG(0x03, 0x7A)
>  #define ADIS16480_REG_FIRM_Y			ADIS16480_REG(0x03, 0x7C)
>  
> +/*
> + * External clock scaling in PPS mode.
> + * Available only for ADIS1649x devices
> + */
> +#define ADIS16495_REG_SYNC_SCALE		ADIS16480_REG(0x03, 0x10)
> +
>  #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
>  
>  /* Each filter coefficent bank spans two pages */
> @@ -116,6 +123,12 @@
>  #define ADIS16480_DRDY_POL(x)		FIELD_PREP(ADIS16480_DRDY_POL_MSK, x)
>  #define ADIS16480_DRDY_EN_MSK		BIT(3)
>  #define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
> +#define ADIS16480_SYNC_SEL_MSK		GENMASK(5, 4)
> +#define ADIS16480_SYNC_SEL(x)		FIELD_PREP(ADIS16480_SYNC_SEL_MSK, x)
> +#define ADIS16480_SYNC_EN_MSK		BIT(7)
> +#define ADIS16480_SYNC_EN(x)		FIELD_PREP(ADIS16480_SYNC_EN_MSK, x)
> +#define ADIS16480_SYNC_MODE_MSK		BIT(8)
> +#define ADIS16480_SYNC_MODE(x)		FIELD_PREP(ADIS16480_SYNC_MODE_MSK, x)
>  
>  struct adis16480_chip_info {
>  	unsigned int num_channels;
> @@ -128,6 +141,7 @@ struct adis16480_chip_info {
>  	unsigned int int_clk;
>  	unsigned int max_dec_rate;
>  	const unsigned int *filter_freqs;
> +	bool has_pps_clk_mode;
>  };
>  
>  enum adis16480_int_pin {
> @@ -137,10 +151,19 @@ enum adis16480_int_pin {
>  	ADIS16480_PIN_DIO4
>  };
>  
> +enum adis16480_clock_mode {
> +	ADIS16480_CLK_SYNC,
> +	ADIS16480_CLK_PPS,
> +	ADIS16480_CLK_INT
> +};
> +
>  struct adis16480 {
>  	const struct adis16480_chip_info *chip_info;
>  
>  	struct adis adis;
> +	struct clk *ext_clk;
> +	enum adis16480_clock_mode clk_mode;
> +	unsigned int clk_freq;
>  };
>  
>  static const char * const adis16480_int_pin_names[4] = {
> @@ -296,20 +319,34 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
>  static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> -	unsigned int t;
> +	unsigned int t, reg;
>  
>  	t =  val * 1000 + val2 / 1000;
>  	if (t <= 0)
>  		return -EINVAL;
>  
> -	t = st->chip_info->int_clk / t;
> +	/*
> +	 * When using PPS mode, the rate of data collection is equal to the
> +	 * product of the external clock frequency and the scale factor in the
> +	 * SYNC_SCALE register.
> +	 * When using sync mode, or internal clock, the output data rate is
> +	 * equal with  the clock frequency divided by DEC_RATE + 1.
> +	 */
> +	if (st->clk_mode == ADIS16480_CLK_PPS) {
> +		t = t / st->clk_freq;
> +		reg = ADIS16495_REG_SYNC_SCALE;
> +	} else {
> +		t = st->clk_freq / t;
> +		reg = ADIS16480_REG_DEC_RATE;
> +	}
> +
>  	if (t > st->chip_info->max_dec_rate)
>  		t = st->chip_info->max_dec_rate;
>  
> -	if (t != 0)
> +	if ((t != 0) && (st->clk_mode != ADIS16480_CLK_PPS))
>  		t--;
>  
> -	return adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
> +	return adis_write_reg_16(&st->adis, reg, t);
>  }
>  
>  static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
> @@ -318,12 +355,29 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  	uint16_t t;
>  	int ret;
>  	unsigned freq;
> +	unsigned int reg;
> +
> +	if (st->clk_mode == ADIS16480_CLK_PPS)
> +		reg = ADIS16495_REG_SYNC_SCALE;
> +	else
> +		reg = ADIS16480_REG_DEC_RATE;
>  
> -	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, &t);
> +	ret = adis_read_reg_16(&st->adis, reg, &t);
>  	if (ret < 0)
>  		return ret;
>  
> -	freq = st->chip_info->int_clk / (t + 1);
> +	/*
> +	 * When using PPS mode, the rate of data collection is equal to the
> +	 * product of the external clock frequency and the scale factor in the
> +	 * SYNC_SCALE register.
> +	 * When using sync mode, or internal clock, the output data rate is
> +	 * equal with  the clock frequency divided by DEC_RATE + 1.
> +	 */
> +	if (st->clk_mode == ADIS16480_CLK_PPS)
> +		freq = st->clk_freq * t;
> +	else
> +		freq = st->clk_freq / (t + 1);
> +
>  	*val = freq / 1000;
>  	*val2 = (freq % 1000) * 1000;
>  
> @@ -793,6 +847,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 4250000,
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
>  	},
>  	[ADIS16495_2] = {
>  		.channels = adis16485_channels,
> @@ -805,6 +860,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 4250000,
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
>  	},
>  	[ADIS16495_3] = {
>  		.channels = adis16485_channels,
> @@ -817,6 +873,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 4250000,
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
>  	},
>  	[ADIS16497_1] = {
>  		.channels = adis16485_channels,
> @@ -829,6 +886,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 4250000,
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
>  	},
>  	[ADIS16497_2] = {
>  		.channels = adis16485_channels,
> @@ -841,6 +899,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 4250000,
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
>  	},
>  	[ADIS16497_3] = {
>  		.channels = adis16485_channels,
> @@ -853,6 +912,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 4250000,
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
> +		.has_pps_clk_mode = true,
>  	},
>  };
>  
> @@ -1027,6 +1087,100 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
>  	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
>  }
>  
> +static int adis16480_of_get_ext_clk_pin(struct adis16480 *st,
> +					struct device_node *of_node)
> +{
> +	const char *ext_clk_pin;
> +	enum adis16480_int_pin pin;
> +	int i;
> +
> +	pin = ADIS16480_PIN_DIO2;
> +	if (of_property_read_string(of_node, "adi,ext-clk-pin", &ext_clk_pin))
> +		goto clk_input_not_found;
> +
> +	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
> +		if (strcasecmp(ext_clk_pin, adis16480_int_pin_names[i]) == 0)
> +			return i;
> +	}
> +
> +clk_input_not_found:
> +	dev_info(&st->adis.spi->dev,
> +		"clk input line not specified, using DIO2\n");
> +	return pin;
> +}
> +
> +static int adis16480_ext_clk_config(struct adis16480 *st,
> +				    struct device_node *of_node,
> +				    bool enable)
> +{
> +	unsigned int mode, mask;
> +	enum adis16480_int_pin pin;
> +	uint16_t val;
> +	int ret;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	pin = adis16480_of_get_ext_clk_pin(st, of_node);
> +	/*
> +	 * Each DIOx pin supports only one function at a time. When a single pin
> +	 * has two assignments, the enable bit for a lower priority function
> +	 * automatically resets to zero (disabling the lower priority function).
> +	 */
> +	if (pin == ADIS16480_DRDY_SEL(val))
> +		dev_warn(&st->adis.spi->dev,
> +			"DIO%x pin supports only one function at a time\n",
> +			pin + 1);
> +
> +	mode = ADIS16480_SYNC_EN(enable) | ADIS16480_SYNC_SEL(pin);
> +	mask = ADIS16480_SYNC_EN_MSK | ADIS16480_SYNC_SEL_MSK;
> +	/* Only ADIS1649x devices support pps ext clock mode */
> +	if (st->chip_info->has_pps_clk_mode) {
> +		mode |= ADIS16480_SYNC_MODE(st->clk_mode);
> +		mask |= ADIS16480_SYNC_MODE_MSK;
> +	}
> +
> +	val &= ~mask;
> +	val |= mode;
> +
> +	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return clk_prepare_enable(st->ext_clk);
> +}
> +
> +static int adis16480_get_ext_clocks(struct adis16480 *st)
> +{
> +	st->clk_mode = ADIS16480_CLK_INT;
> +	st->ext_clk = devm_clk_get(&st->adis.spi->dev, "sync");
> +	if (!IS_ERR_OR_NULL(st->ext_clk)) {
> +		st->clk_mode = ADIS16480_CLK_SYNC;
> +		return 0;
> +	}
> +
> +	if (PTR_ERR(st->ext_clk) != -ENOENT) {
> +		dev_err(&st->adis.spi->dev, "failed to get ext clk\n");
> +		return PTR_ERR(st->ext_clk);
> +	}
> +
> +	if (st->chip_info->has_pps_clk_mode) {
> +		st->ext_clk = devm_clk_get(&st->adis.spi->dev, "pps");
> +		if (!IS_ERR_OR_NULL(st->ext_clk)) {
> +			st->clk_mode = ADIS16480_CLK_PPS;
> +			return 0;
> +		}
> +
> +		if (PTR_ERR(st->ext_clk) != -ENOENT) {
> +			dev_err(&st->adis.spi->dev, "failed to get ext clk\n");
> +			return PTR_ERR(st->ext_clk);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int adis16480_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -1058,10 +1212,25 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
> +	ret = adis16480_get_ext_clocks(st);
>  	if (ret)
>  		return ret;
>  
> +	if (!IS_ERR_OR_NULL(st->ext_clk)) {
> +		ret = adis16480_ext_clk_config(st, spi->dev.of_node, true);
> +		if (ret)
> +			return ret;
> +
> +		st->clk_freq = clk_get_rate(st->ext_clk);
> +		st->clk_freq *= 1000; /* micro */
> +	} else {
> +		st->clk_freq = st->chip_info->int_clk;
> +	}
> +
> +	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
> +	if (ret)
> +		goto error_clk_disable_unprepare;
> +
>  	ret = adis16480_initial_setup(indio_dev);
>  	if (ret)
>  		goto error_cleanup_buffer;
> @@ -1078,6 +1247,8 @@ static int adis16480_probe(struct spi_device *spi)
>  	adis16480_stop_device(indio_dev);
>  error_cleanup_buffer:
>  	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
> +error_clk_disable_unprepare:
> +	clk_disable_unprepare(st->ext_clk);
>  	return ret;
>  }
>  
> @@ -1090,6 +1261,7 @@ static int adis16480_remove(struct spi_device *spi)
>  	adis16480_stop_device(indio_dev);
>  
>  	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
> +	clk_disable_unprepare(st->ext_clk);
>  
>  	return 0;
>  }

