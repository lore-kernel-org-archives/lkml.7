Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED5C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21045218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553968439;
	bh=RNtssCoAcAiAVqwyqs86kzW7zyK+b/Up1AfxbQWaooI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GIdnmj1RG4yzBe/l/qPuRlSMRK5Ur4JSlU0Fj/ijfpgSCF9jKn7YCzBzKqC623RLp
	 UP1qk5V+sJHYG026olqjZ3utB/fLQVABkiixVADybFi2+E4aDcbjuBth62Bf+tIcre
	 Rj5UwnM8jwrWdPkNzgRYih8z3G4T16XoZw+17eqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfC3Rx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbfC3Rx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:53:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68176217F5;
        Sat, 30 Mar 2019 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553968435;
        bh=RNtssCoAcAiAVqwyqs86kzW7zyK+b/Up1AfxbQWaooI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fy/lGeLR993kT5ItdnOLgFu/haa/HejRGlHL6dglzX74jwBkG5SCwAYcKsOsES1tQ
         H7PQa8isvxOyHcrd1AHvfr0bpPb96kLxwHBXv4OOZlHNRyc0sLrakOz3IIEX/vHk4k
         9fqi3w2qz7G7EIzBQcFSKJHhr7TVBVLRLx506/oY=
Date:   Sat, 30 Mar 2019 17:53:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] iio:temperature: Add MAX31856 thermocouple
 support
Message-ID: <20190330175349.1e893f15@archlinux>
In-Reply-To: <20190326111842.12399-3-patrick.havelange@essensium.com>
References: <20190326111842.12399-1-patrick.havelange@essensium.com>
        <20190326111842.12399-3-patrick.havelange@essensium.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:18:42 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> 
> This patch adds support for Maxim MAX31856 thermocouple
> temperature sensor support.
> 
> More information can be found in:
> https://www.maximintegrated.com/en/ds/MAX31856.pdf
> 
> NOTE: Driver support only Comparator Mode.
> 
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes
> v1 -> v2
> [Peter
> 	1. Fixed all space & 'return' related comments
> 	2. Removed 'sysfs_create_group' api  because
> 	   iio_device_register function is handling sysfs entry
> 	3. Return -EIO if there is any fault
> 	4. Added check for 'read_size' before spi read call
> 	5. Removed license text from the source file
> 	6. Added .o file in alphabetic order
> 	7. Used #defines instead of magic bits
> 
> v2 -> v3
> [Jonathan
> 	1. Used bool for fault_oc and fault_ovuv
> 	2. Changed 'max31856_read' function and use byte array to
> 	   store registers value.
> 	3. Used 'GENMASK' where required
>         4. Changed logic 'max31856_thermocouple_read' function. Used
> 	   array to read registers value.
> 	5. Used 'devm_iio_device_register' and removed 'max31856_remove'.
> 	6. Fixed other cosmetic changes.
> 	7. Added 'sysfs-bus-iio-temperature-max31856' file and updated
> 	   'MAINTAINERS' file.
> 
> v3 -> v4
> [Jonathan
> 	1. Removed unwanted logic
> 	2. Updated code to handle return value of max31856_read call
> 	3. Added devicetree id table
> 	4. Removed one-shot support from driver as this support was not
> 	   implemented with correct design.
> 
> v4 -> v5
> [Patrick
> 	1. Rename thermocouple type to maxim,thermocouple-type for DT entry
> 	2. Don't cache values from the Fault Status Register
> 	3. Simplify a bit max31856_init()
> 	4. Use IIO_NO_MOD in switch case + default error case
> 	5. Use dev_*() instead of pr_*()
> 	6. Fix missing space in comments
> 	7. Removed iio_info.driver_module assignment as no longer present
> 	8. Don't keep read/write buffer into the internal driver struct
> 	9. Updated kernel version, add missing space in documentation
>        10. Updated (c) year
>        11. Removed linux/init.h #include
>        12. More use of BIT() macro
>        13. Removed iio_chan_spec.address assignment as not used
>        14. In max31856_thermocouple_read(), same switch case order as
> 	   channels definition
>        15. Refactor show_fault_*() functions
>        16. Use u8 as register type in max31856_{read,write}()
> 
> v5 -> v6
> [Patrick
> 	1. Use generic thermocouple-type property
> 	2. Fix doc for fault_ovuv entry
> 	3. Add check for supported thermocouple-types in probe()
> 
> v6 -> v7
> [Patrick
> 	1. None
> ---
>  .../sysfs-bus-iio-temperature-max31856        |  24 ++
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/max31856.c            | 353 ++++++++++++++++++
>  4 files changed, 388 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
>  create mode 100644 drivers/iio/temperature/max31856.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> new file mode 100644
> index 000000000000..3b3509a3ef2f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Open-circuit fault. The detection of open-circuit faults,
> +		such as those caused by broken thermocouple wires.
> +		Reading returns either '1' or '0'.
> +		'1' = An open circuit such as broken thermocouple wires
> +		      has been detected.
> +		'0' = No open circuit or broken thermocouple wires are detected
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Overvoltage or Undervoltage Input Fault. The internal circuitry
> +		is protected from excessive voltages applied to the thermocouple
> +		cables by integrated MOSFETs at the T+ and T- inputs, and the
> +		BIAS output. These MOSFETs turn off when the input voltage is
> +		negative or greater than VDD.
> +		Reading returns either '1' or '0'.
> +		'1' = The input voltage is negative or greater than VDD.
> +		'0' = The input voltage is positive and less than VDD (normal
> +		state).
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 82e4a62745e2..c66eeb23615b 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -97,4 +97,14 @@ config TSYS02D
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys02d.
>  
> +config MAX31856
> +	tristate "MAX31856 thermocouple sensor"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for MAX31856
> +	  thermocouple sensor chip connected via SPI.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max31856.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 34a31db0bb63..baca4776ca0d 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> +obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> new file mode 100644
> index 000000000000..6b67d6b95cf9
> --- /dev/null
> +++ b/drivers/iio/temperature/max31856.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* max31856.c
> + *
> + * Maxim MAX31856 thermocouple sensor driver
> + *
> + * Copyright (C) 2018-2019 Rockwell Collins
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <dt-bindings/iio/temperature/thermocouple.h>
> +/*
> + * The MSB of the register value determines whether the following byte will
> + * be written or read. If it is 0, one or more byte reads will follow.
> + */
> +#define MAX31856_RD_WR_BIT         BIT(7)
> +
> +#define MAX31856_CR0_AUTOCONVERT   BIT(7)
> +#define MAX31856_CR0_1SHOT         BIT(6)
> +#define MAX31856_CR0_OCFAULT       BIT(4)
> +#define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> +#define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
> +#define MAX31856_FAULT_OVUV        BIT(1)
> +#define MAX31856_FAULT_OPEN        BIT(0)
> +
> +/* The MAX31856 registers */
> +#define MAX31856_CR0_REG           0x00
> +#define MAX31856_CR1_REG           0x01
> +#define MAX31856_MASK_REG          0x02
> +#define MAX31856_CJHF_REG          0x03
> +#define MAX31856_CJLF_REG          0x04
> +#define MAX31856_LTHFTH_REG        0x05
> +#define MAX31856_LTHFTL_REG        0x06
> +#define MAX31856_LTLFTH_REG        0x07
> +#define MAX31856_LTLFTL_REG        0x08
> +#define MAX31856_CJTO_REG          0x09
> +#define MAX31856_CJTH_REG          0x0A
> +#define MAX31856_CJTL_REG          0x0B
> +#define MAX31856_LTCBH_REG         0x0C
> +#define MAX31856_LTCBM_REG         0x0D
> +#define MAX31856_LTCBL_REG         0x0E
> +#define MAX31856_SR_REG            0x0F
> +
> +static const struct iio_chan_spec max31856_channels[] = {
> +	{	/* Thermocouple Temperature */
> +		.type = IIO_TEMP,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{	/* Cold Junction Temperature */
> +		.type = IIO_TEMP,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +struct max31856_data {
> +	struct spi_device *spi;
> +	u32 thermocouple_type;
> +};
> +
> +static int max31856_read(struct max31856_data *data, u8 reg,
> +			 u8 val[], unsigned int read_size)
> +{
> +	return spi_write_then_read(data->spi, &reg, 1, val, read_size);
> +}
> +
> +static int max31856_write(struct max31856_data *data, u8 reg,
> +			  unsigned int val)
> +{
> +	u8 buf[2];
> +
> +	buf[0] = reg | (MAX31856_RD_WR_BIT);
> +	buf[1] = val;
> +
> +	return spi_write(data->spi, buf, 2);
> +}
> +
> +static int max31856_init(struct max31856_data *data)
> +{
> +	int ret;
> +	u8 reg_cr0_val, reg_cr1_val;
> +
> +	/* Start by changing to Off mode before making changes as
> +	 * some settings are recommended to be set only when the device
> +	 * is off
> +	 */
> +	ret = max31856_read(data, MAX31856_CR0_REG, &reg_cr0_val, 1);
> +	if (ret)
> +		return ret;
> +
> +	reg_cr0_val &= ~MAX31856_CR0_AUTOCONVERT;
> +	ret = max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Set thermocouple type based on dts property */
> +	ret = max31856_read(data, MAX31856_CR1_REG, &reg_cr1_val, 1);
> +	if (ret)
> +		return ret;
> +
> +	reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
> +	reg_cr1_val |= data->thermocouple_type;
> +	ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Enable Open circuit fault detection
> +	 * Read datasheet for more information: Table 4.
> +	 * Value 01 means : Enabled (Once every 16 conversions)
> +	 */
> +	reg_cr0_val &= ~MAX31856_CR0_OCFAULT_MASK;
> +	reg_cr0_val |= MAX31856_CR0_OCFAULT;
> +
> +	/* Set Auto Conversion Mode */
> +	reg_cr0_val &= ~MAX31856_CR0_1SHOT;
> +	reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
> +
> +	return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
> +}
> +
> +static int max31856_thermocouple_read(struct max31856_data *data,
> +				      struct iio_chan_spec const *chan,
> +				      int *val)
> +{
> +	int ret, offset_cjto;
> +	u8 reg_val[3];
> +
> +	switch (chan->channel2) {
> +	case IIO_NO_MOD:
> +		/*
> +		 * Multibyte Read
> +		 * MAX31856_LTCBH_REG, MAX31856_LTCBM_REG, MAX31856_LTCBL_REG
> +		 */
> +		ret = max31856_read(data, MAX31856_LTCBH_REG, reg_val, 3);
> +		if (ret)
> +			return ret;
> +		/* Skip last 5 dead bits of LTCBL */
> +		*val = (reg_val[0] << 16 | reg_val[1] << 8 | reg_val[2]) >> 5;
> +		/* Check 7th bit of LTCBH reg. value for sign*/
> +		if (reg_val[0] & 0x80)
> +			*val -= 0x80000;
> +		break;
> +
> +	case IIO_MOD_TEMP_AMBIENT:
> +		/*
> +		 * Multibyte Read
> +		 * MAX31856_CJTO_REG, MAX31856_CJTH_REG, MAX31856_CJTL_REG
> +		 */
> +		ret = max31856_read(data, MAX31856_CJTO_REG, reg_val, 3);
> +		if (ret)
> +			return ret;
> +		/* Get Cold Junction Temp. offset register value */
> +		offset_cjto = reg_val[0];
> +		/* Get CJTH and CJTL value and skip last 2 dead bits of CJTL */
> +		*val = (reg_val[1] << 8 | reg_val[2]) >> 2;
> +		/* As per datasheet add offset into CJTH and CJTL */
> +		*val += offset_cjto;
> +		/* Check 7th bit of CJTH reg. value for sign */
> +		if (reg_val[1] & 0x80)
> +			*val -= 0x4000;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = max31856_read(data, MAX31856_SR_REG, reg_val, 1);
> +	if (ret)
> +		return ret;
> +	/* Check for over/under voltage or open circuit fault */
> +	if (reg_val[0] & (MAX31856_FAULT_OVUV | MAX31856_FAULT_OPEN))
> +		return -EIO;
> +
> +	return ret;
> +}
> +
> +static int max31856_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max31856_thermocouple_read(data, chan, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_TEMP_AMBIENT:
> +			/* Cold junction Temp. Data resolution is 0.015625 */
> +			*val = 15;
> +			*val2 = 625000; /* 1000 * 0.015625 */
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		default:
> +			/* Thermocouple Temp. Data resolution is 0.0078125 */
> +			*val = 7;
> +			*val2 = 812500; /* 1000 * 0.0078125) */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	u8 reg_val;
> +	int ret;
> +	bool fault;
> +
> +	ret = max31856_read(data, MAX31856_SR_REG, &reg_val, 1);
> +	if (ret)
> +		return ret;
> +
> +	fault = reg_val & faultbit;
> +
> +	return sprintf(buf, "%d\n", fault);
> +}
> +
> +static ssize_t show_fault_ovuv(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	return show_fault(dev, MAX31856_FAULT_OVUV, buf);
> +}
> +
> +static ssize_t show_fault_oc(struct device *dev,
> +			     struct device_attribute *attr,
> +			     char *buf)
> +{
> +	return show_fault(dev, MAX31856_FAULT_OPEN, buf);
> +}
> +
> +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> +static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> +
> +static struct attribute *max31856_attributes[] = {
> +	&iio_dev_attr_fault_ovuv.dev_attr.attr,
> +	&iio_dev_attr_fault_oc.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max31856_group = {
> +	.attrs = max31856_attributes,
> +};
> +
> +static const struct iio_info max31856_info = {
> +	.read_raw = max31856_read_raw,
> +	.attrs = &max31856_group,
> +};
> +
> +static int max31856_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct iio_dev *indio_dev;
> +	struct max31856_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->spi = spi;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->info = &max31856_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max31856_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
> +
> +	ret = of_property_read_u32(spi->dev.of_node, "thermocouple-type",
> +				   &data->thermocouple_type);
> +
> +	if (ret) {
> +		dev_info(&spi->dev,
> +			 "Could not read thermocouple type DT property, configuring as a K-Type\n");
> +		data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	}
> +
> +	/*
> +	 * no need to translate values as the supported types
> +	 * have the same value as the #defines
> +	 */
> +	switch (data->thermocouple_type) {
> +	case THERMOCOUPLE_TYPE_B:
> +	case THERMOCOUPLE_TYPE_E:
> +	case THERMOCOUPLE_TYPE_J:
> +	case THERMOCOUPLE_TYPE_K:
> +	case THERMOCOUPLE_TYPE_N:
> +	case THERMOCOUPLE_TYPE_R:
> +	case THERMOCOUPLE_TYPE_S:
> +	case THERMOCOUPLE_TYPE_T:
> +		break;
> +	default:
> +		dev_err(&spi->dev,
> +			"error: thermocouple-type %u not supported by max31856\n"
> +			, data->thermocouple_type);
> +		return -EINVAL;
> +	}
> +
> +	ret = max31856_init(data);
> +	if (ret) {
> +		dev_err(&spi->dev, "error: Failed to configure max31856\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max31856_id[] = {
> +	{ "max31856", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max31856_id);
> +
> +static const struct of_device_id max31856_of_match[] = {
> +	{ .compatible = "maxim,max31856" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max31856_of_match);
> +
> +static struct spi_driver max31856_driver = {
> +	.driver = {
> +		.name = "max31856",
> +		.of_match_table = max31856_of_match,
> +	},
> +	.probe = max31856_probe,
> +	.id_table = max31856_id,
> +};
> +module_spi_driver(max31856_driver);
> +
> +MODULE_AUTHOR("Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>");
> +MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
> +MODULE_DESCRIPTION("Maxim MAX31856 thermocouple sensor driver");
> +MODULE_LICENSE("GPL");

