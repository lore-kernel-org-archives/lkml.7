Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90950C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5439020866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617172;
	bh=I0kx65nCYAK+HmbpXDS4vfsmvtWKxLnAmlY+ieIsn4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VrF27mRRvjFVOuGnqZFof1uHVUdddY9AQQLHB3/5UFzJubuyM8u4CHwQawHGO+IA1
	 Qpm68KvnLPT5cYgplh+iB/FPGXrsCW1BS22KJP+QNLWDa2RKJ0n/b4BDDuRbkhF7Q7
	 PZuzWwqt7mcN9cXWRDqLaJ3cZMuksHHJBMof/w/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCCMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfCCMqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:46:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5D920857;
        Sun,  3 Mar 2019 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617168;
        bh=I0kx65nCYAK+HmbpXDS4vfsmvtWKxLnAmlY+ieIsn4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3dwE6pcVs6QE/ZQJQG/cRZKP0Zt6RHBjrHArSxyj/bVldZ07xXNXs7VeYy7RSWrd
         jOvW9ywpSxJCHIarF2lSU17y4FnrTPn8uM150RnGMk6RthHLP00HKrX00VnDfqbwEn
         2oLe2c7qJN6qtqjm4nVWE71Kjr1b5paRTbO3lYFU=
Date:   Sun, 3 Mar 2019 12:46:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] iio: imu: adis16480: Add support for
 configurable drdy indicator
Message-ID: <20190303124603.4fcd506f@archlinux>
In-Reply-To: <1551284068-4882-2-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-2-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:22 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The FNCTIO_CTRL register provides configuration control for each I/O pin
> (DIO1, DIO2, DIO3 and DIO4).
> 
> This patch adds the option to configure each DIOx pin as data ready
> indicator with positive or negative polarity by reading the 'interrupts'
> and 'interrupt-names' properties from the devicetree. The
> 'interrupt-names' property is optional, if it is not specified, then the
> DIO1 pin is used as default data ready signal.
> 
> Although the factory default assigns DIO2 as data ready signal, in the
> versions previous this patch, DIO1 pin was used. We should leave this
> configuration as is, since some devices might be expecting the interrupt
> on the wrong physical pin.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Nice detailed description.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index a27fe20..98a23ac 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -9,6 +9,8 @@
>   *
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/of_irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> @@ -107,6 +109,14 @@
>  #define ADIS16480_FIR_COEF_C(x)			ADIS16480_FIR_COEF(0x09, (x))
>  #define ADIS16480_FIR_COEF_D(x)			ADIS16480_FIR_COEF(0x0B, (x))
>  
> +/* ADIS16480_REG_FNCTIO_CTRL */
> +#define ADIS16480_DRDY_SEL_MSK		GENMASK(1, 0)
> +#define ADIS16480_DRDY_SEL(x)		FIELD_PREP(ADIS16480_DRDY_SEL_MSK, x)
> +#define ADIS16480_DRDY_POL_MSK		BIT(2)
> +#define ADIS16480_DRDY_POL(x)		FIELD_PREP(ADIS16480_DRDY_POL_MSK, x)
> +#define ADIS16480_DRDY_EN_MSK		BIT(3)
> +#define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
> +
>  struct adis16480_chip_info {
>  	unsigned int num_channels;
>  	const struct iio_chan_spec *channels;
> @@ -116,12 +126,26 @@ struct adis16480_chip_info {
>  	unsigned int accel_max_scale;
>  };
>  
> +enum adis16480_int_pin {
> +	ADIS16480_PIN_DIO1,
> +	ADIS16480_PIN_DIO2,
> +	ADIS16480_PIN_DIO3,
> +	ADIS16480_PIN_DIO4
> +};
> +
>  struct adis16480 {
>  	const struct adis16480_chip_info *chip_info;
>  
>  	struct adis adis;
>  };
>  
> +static const char * const adis16480_int_pin_names[4] = {
> +	[ADIS16480_PIN_DIO1] = "DIO1",
> +	[ADIS16480_PIN_DIO2] = "DIO2",
> +	[ADIS16480_PIN_DIO3] = "DIO3",
> +	[ADIS16480_PIN_DIO4] = "DIO4",
> +};
> +
>  #ifdef CONFIG_DEBUG_FS
>  
>  static ssize_t adis16480_show_firmware_revision(struct file *file,
> @@ -741,8 +765,17 @@ static int adis16480_stop_device(struct iio_dev *indio_dev)
>  
>  static int adis16480_enable_irq(struct adis *adis, bool enable)
>  {
> -	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL,
> -		enable ? BIT(3) : 0);
> +	uint16_t val;
> +	int ret;
> +
> +	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &= ~ADIS16480_DRDY_EN_MSK;
> +	val |= ADIS16480_DRDY_EN(enable);
> +
> +	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
>  }
>  
>  static int adis16480_initial_setup(struct iio_dev *indio_dev)
> @@ -826,6 +859,62 @@ static const struct adis_data adis16480_data = {
>  	.enable_irq = adis16480_enable_irq,
>  };
>  
> +static int adis16480_config_irq_pin(struct device_node *of_node,
> +				    struct adis16480 *st)
> +{
> +	struct irq_data *desc;
> +	enum adis16480_int_pin pin;
> +	unsigned int irq_type;
> +	uint16_t val;
> +	int i, irq = 0;
> +
> +	desc = irq_get_irq_data(st->adis.spi->irq);
> +	if (!desc) {
> +		dev_err(&st->adis.spi->dev, "Could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}
> +
> +	/* Disable data ready since the default after reset is on */
> +	val = ADIS16480_DRDY_EN(0);
> +
> +	/*
> +	 * Get the interrupt from the devicetre by reading the interrupt-names
> +	 * property. If it is not specified, use DIO1 pin as default.
> +	 * According to the datasheet, the factory default assigns DIO2 as data
> +	 * ready signal. However, in the previous versions of the driver, DIO1
> +	 * pin was used. So, we should leave it as is since some devices might
> +	 * be expecting the interrupt on the wrong physical pin.
> +	 */
> +	pin = ADIS16480_PIN_DIO1;
> +	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
> +		irq = of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
> +		if (irq > 0) {
> +			pin = i;
> +			break;
> +		}
> +	}
> +
> +	val |= ADIS16480_DRDY_SEL(pin);
> +
> +	/*
> +	 * Get the interrupt line behaviour. The data ready polarity can be
> +	 * configured as positive or negative, corresponding to
> +	 * IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING respectively.
> +	 */
> +	irq_type = irqd_get_trigger_type(desc);
> +	if (irq_type == IRQF_TRIGGER_RISING) { /* Default */
> +		val |= ADIS16480_DRDY_POL(1);
> +	} else if (irq_type == IRQF_TRIGGER_FALLING) {
> +		val |= ADIS16480_DRDY_POL(0);
> +	} else {
> +		dev_err(&st->adis.spi->dev,
> +			"Invalid interrupt type 0x%x specified\n", irq_type);
> +		return -EINVAL;
> +	}
> +	/* Write the data ready configuration to the FNCTIO_CTRL register */
> +	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
> +}
> +
>  static int adis16480_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -853,6 +942,10 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
> +	if (ret)
> +		return ret;
> +
>  	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;

