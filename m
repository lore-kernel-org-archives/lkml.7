Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5596C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732BB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vkWVTQC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfB1UOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:14:25 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53080 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1UOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:14:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1SKEEcg088377;
        Thu, 28 Feb 2019 14:14:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551384854;
        bh=LnIfJeMRo4/U0RK7N3SjcEwnwcp1i51OKZNAXdkR06U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vkWVTQC/ikLXr2ciN4QzKErPU+Sc4Yk+hT8Gk2Lf/0Vlf0NVJPUtkTcrbunTidW/D
         BqdE+NP/dTcrrS2DK7qI77L0KByC27Kv7YNJMCpAXyamuKl07tIFq75sN758k+mz78
         WlKdqvdg7LTrYmxxMKVoSOaa4sQhqH3RrYEtCoFw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1SKEEV2103822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 14:14:14 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 28
 Feb 2019 14:14:13 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 28 Feb 2019 14:14:13 -0600
Received: from [172.22.64.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1SKEDFY015402;
        Thu, 28 Feb 2019 14:14:13 -0600
Subject: Re: [PATCH v5 5/5] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <20190214182754.30721-6-dmurphy@ti.com>
 <6b5ce732-bce1-7e35-2bf4-a1000bfc9208@grandegger.com>
 <b98b9ccd-1833-50ed-dace-5f8cfd8734f0@ti.com>
 <b8ca8a5a-b6ba-25a0-edcd-65e6a2518d5f@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e0ba9d00-7f7a-0817-fdd0-a20c8b83fb42@ti.com>
Date:   Thu, 28 Feb 2019 14:14:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <b8ca8a5a-b6ba-25a0-edcd-65e6a2518d5f@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 2/28/19 2:07 PM, Wolfgang Grandegger wrote:
> 
> Am 28.02.19 um 19:03 schrieb Dan Murphy:
>>
>> Wolfgang
>>
>> On 2/28/19 11:50 AM, Wolfgang Grandegger wrote:
>>>
>>>
>>> Am 14.02.19 um 19:27 schrieb Dan Murphy:
>>>> Add the TCAN4x5x SPI CAN driver.  This device
>>>> uses the Bosch MCAN IP core along with a SPI
>>>> interface map.  Leverage the MCAN common core
>>>> code to manage the MCAN IP.
>>>>
>>>> This device has a special method to indicate a
>>>> write/read operation on the data payload.
>>>
>>> Please expand the text to approx. 72 lines.>>
>>
>> 72 lines or characters?
> 
> Characters, of course!
> 

OK.  Just clarifying.  I did not think you were asking me to write a book here

>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>> v5 - Changes to accomodate previous patches for functionality - https://lore.kernel.org/patchwork/patch/1033096/
>>>>
>>>>  drivers/net/can/m_can/Kconfig    |   6 +
>>>>  drivers/net/can/m_can/Makefile   |   1 +
>>>>  drivers/net/can/m_can/tcan4x5x.c | 531 +++++++++++++++++++++++++++++++
>>>>  3 files changed, 538 insertions(+)
>>>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>>>
>>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>>> index 66e31022a5fa..6c0ab4703fb7 100644
>>>> --- a/drivers/net/can/m_can/Kconfig
>>>> +++ b/drivers/net/can/m_can/Kconfig
>>>> @@ -9,3 +9,9 @@ config CAN_M_CAN_PLATFORM
>>>>  	depends on CAN_M_CAN
>>>>  	---help---
>>>>  	  Say Y here if you want to support for Bosch M_CAN controller.
>>>> +
>>>> +config CAN_M_CAN_TCAN4X5X
>>>> +	depends on CAN_M_CAN
>>>> +	tristate "TCAN4X5X M_CAN device"
>>>> +	---help---
>>>> +	  Say Y here if you want to support for TI M_CAN controller.
>>>
>>> Could yo please be a bit more verbose here.
>>
>> ACK
>>
>>>
>>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>>> index 057bbcdb3c74..e77f0eccff97 100644
>>>> --- a/drivers/net/can/m_can/Makefile
>>>> +++ b/drivers/net/can/m_can/Makefile
>>>> @@ -4,3 +4,4 @@
>>>>  
>>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>>>  obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>>> +obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
>>>> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
>>>> new file mode 100644
>>>> index 000000000000..606cd1925009
>>>> --- /dev/null
>>>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>>>> @@ -0,0 +1,531 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// SPI to CAN driver for the Texas Instruments TCAN4x5x
>>>> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>>>> +
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/spi/spi.h>
>>>> +
>>>> +#include <linux/regulator/consumer.h>
>>>> +#include <linux/gpio/consumer.h>
>>>> +
>>>> +#include "m_can.h"
>>>> +
>>>> +#define DEVICE_NAME "tcan4x5x"
>>>> +#define TCAN4X5X_EXT_CLK_DEF	40000000
>>>> +
>>>> +#define TCAN4X5X_DEV_ID0	0x00
>>>> +#define TCAN4X5X_DEV_ID1	0x04
>>>> +#define TCAN4X5X_REV		0x08
>>>> +#define TCAN4X5X_STATUS		0x0C
>>>> +#define TCAN4X5X_ERROR_STATUS	0x10
>>>> +#define TCAN4X5X_CONTROL	0x14
>>>> +
>>>> +#define TCAN4X5X_CONFIG		0x800
>>>> +#define TCAN4X5X_TS_PRESCALE	0x804
>>>> +#define TCAN4X5X_TEST_REG	0x808
>>>> +#define TCAN4X5X_INT_FLAGS	0x820
>>>> +#define TCAN4X5X_MCAN_INT_REG	0x824
>>>> +#define TCAN4X5X_INT_EN		0x830
>>>> +
>>>> +
>>>> +/* Interrupt bits */
>>>> +#define TCAN4X5X_CANBUSTERMOPEN_INT_EN	BIT(30)
>>>> +#define TCAN4X5X_CANHCANL_INT_EN	BIT(29)
>>>> +#define TCAN4X5X_CANHBAT_INT_EN		BIT(28)
>>>> +#define TCAN4X5X_CANLGND_INT_EN		BIT(27)
>>>> +#define TCAN4X5X_CANBUSOPEN_INT_EN	BIT(26)
>>>> +#define TCAN4X5X_CANBUSGND_INT_EN	BIT(25)
>>>> +#define TCAN4X5X_CANBUSBAT_INT_EN	BIT(24)
>>>> +#define TCAN4X5X_UVSUP_INT_EN		BIT(22)
>>>> +#define TCAN4X5X_UVIO_INT_EN		BIT(21)
>>>> +#define TCAN4X5X_TSD_INT_EN		BIT(19)
>>>> +#define TCAN4X5X_ECCERR_INT_EN		BIT(16)
>>>> +#define TCAN4X5X_CANINT_INT_EN		BIT(15)
>>>> +#define TCAN4X5X_LWU_INT_EN		BIT(14)
>>>> +#define TCAN4X5X_CANSLNT_INT_EN		BIT(10)
>>>> +#define TCAN4X5X_CANDOM_INT_EN		BIT(8)
>>>> +#define TCAN4X5X_CANBUS_ERR_INT_EN	BIT(5)
>>>> +#define TCAN4X5X_BUS_FAULT		BIT(4)
>>>> +#define TCAN4X5X_MCAN_INT		BIT(1)
>>>> +#define TCAN4X5X_ENABLE_TCAN_INT	(TCAN4X5X_MCAN_INT | \
>>>> +					TCAN4X5X_BUS_FAULT | \
>>>> +					TCAN4X5X_CANBUS_ERR_INT_EN | \
>>>> +					TCAN4X5X_CANINT_INT_EN)
>>>> +
>>>> +/* MCAN Interrupt bits */
>>>> +#define TCAN4X5X_MCAN_IR_ARA		BIT(29)
>>>> +#define TCAN4X5X_MCAN_IR_PED		BIT(28)
>>>> +#define TCAN4X5X_MCAN_IR_PEA		BIT(27)
>>>> +#define TCAN4X5X_MCAN_IR_WD		BIT(26)
>>>> +#define TCAN4X5X_MCAN_IR_BO		BIT(25)
>>>> +#define TCAN4X5X_MCAN_IR_EW		BIT(24)
>>>> +#define TCAN4X5X_MCAN_IR_EP		BIT(23)
>>>> +#define TCAN4X5X_MCAN_IR_ELO		BIT(22)
>>>> +#define TCAN4X5X_MCAN_IR_BEU		BIT(21)
>>>> +#define TCAN4X5X_MCAN_IR_BEC		BIT(20)
>>>> +#define TCAN4X5X_MCAN_IR_DRX		BIT(19)
>>>> +#define TCAN4X5X_MCAN_IR_TOO		BIT(18)
>>>> +#define TCAN4X5X_MCAN_IR_MRAF		BIT(17)
>>>> +#define TCAN4X5X_MCAN_IR_TSW		BIT(16)
>>>> +#define TCAN4X5X_MCAN_IR_TEFL		BIT(15)
>>>> +#define TCAN4X5X_MCAN_IR_TEFF		BIT(14)
>>>> +#define TCAN4X5X_MCAN_IR_TEFW		BIT(13)
>>>> +#define TCAN4X5X_MCAN_IR_TEFN		BIT(12)
>>>> +#define TCAN4X5X_MCAN_IR_TFE		BIT(11)
>>>> +#define TCAN4X5X_MCAN_IR_TCF		BIT(10)
>>>> +#define TCAN4X5X_MCAN_IR_TC		BIT(9)
>>>> +#define TCAN4X5X_MCAN_IR_HPM		BIT(8)
>>>> +#define TCAN4X5X_MCAN_IR_RF1L		BIT(7)
>>>> +#define TCAN4X5X_MCAN_IR_RF1F		BIT(6)
>>>> +#define TCAN4X5X_MCAN_IR_RF1W		BIT(5)
>>>> +#define TCAN4X5X_MCAN_IR_RF1N		BIT(4)
>>>> +#define TCAN4X5X_MCAN_IR_RF0L		BIT(3)
>>>> +#define TCAN4X5X_MCAN_IR_RF0F		BIT(2)
>>>> +#define TCAN4X5X_MCAN_IR_RF0W		BIT(1)
>>>> +#define TCAN4X5X_MCAN_IR_RF0N		BIT(0)
>>>> +#define TCAN4X5X_ENABLE_MCAN_INT	(TCAN4X5X_MCAN_IR_TC | \
>>>> +					TCAN4X5X_MCAN_IR_RF0N | \
>>>> +					TCAN4X5X_MCAN_IR_RF1N | \
>>>> +					TCAN4X5X_MCAN_IR_RF0F | \
>>>> +					TCAN4X5X_MCAN_IR_RF1F)
>>>> +#define TCAN4X5X_MRAM_START	0x8000
>>>> +#define TCAN4X5X_MCAN_OFFSET	0x1000
>>>> +#define TCAN4X5X_MAX_REGISTER	0x8fff
>>>> +
>>>> +#define TCAN4X5X_CLEAR_ALL_INT	0xffffffff
>>>> +#define TCAN4X5X_SET_ALL_INT	0xffffffff
>>>> +
>>>> +#define TCAN4X5X_WRITE_CMD	(0x61 << 24)
>>>> +#define TCAN4X5X_READ_CMD	(0x41 << 24)
>>>> +
>>>> +#define TCAN4X5X_MODE_SEL_MASK		(BIT(7) | BIT(6))
>>>> +#define TCAN4X5X_MODE_SLEEP		0x00
>>>> +#define TCAN4X5X_MODE_STANDBY		BIT(6)
>>>> +#define TCAN4X5X_MODE_NORMAL		BIT(7)
>>>> +
>>>> +#define TCAN4X5X_SW_RESET	BIT(2)
>>>> +
>>>> +#define TCAN4X5X_MCAN_CONFIGURED	BIT(5)
>>>> +#define TCAN4X5X_WATCHDOG_EN		BIT(3)
>>>> +#define TCAN4X5X_WD_60_MS_TIMER		0
>>>> +#define TCAN4X5X_WD_600_MS_TIMER	BIT(28)
>>>> +#define TCAN4X5X_WD_3_S_TIMER		BIT(29)
>>>> +#define TCAN4X5X_WD_6_S_TIMER		(BIT(28) | BIT(29))
>>>> +
>>>> +struct tcan4x5x_priv {
>>>> +	struct regmap *regmap;
>>>> +	struct spi_device *spi;
>>>> +	struct mutex tcan4x5x_lock; /* SPI device lock */
>>>> +
>>>> +	struct m_can_classdev *mcan_dev;
>>>> +
>>>> +	struct gpio_desc *reset_gpio;
>>>> +	struct gpio_desc *interrupt_gpio;
>>>> +	struct gpio_desc *device_wake_gpio;
>>>> +	struct gpio_desc *device_state_gpio;
>>>> +	struct regulator *power;
>>>> +
>>>> +	/* Register based ip */
>>>> +	int mram_start;
>>>> +	int reg_offset;
>>>> +};
>>>> +
>>>> +static struct can_bittiming_const tcan4x5x_bittiming_const = {
>>>> +	.name = DEVICE_NAME,
>>>> +	.tseg1_min = 2,
>>>> +	.tseg1_max = 31,
>>>> +	.tseg2_min = 2,
>>>> +	.tseg2_max = 16,
>>>> +	.sjw_max = 16,
>>>> +	.brp_min = 1,
>>>> +	.brp_max = 32,
>>>> +	.brp_inc = 1,
>>>> +};
>>>> +
>>>> +static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
>>>> +	.name = DEVICE_NAME,
>>>> +	.tseg1_min = 1,
>>>> +	.tseg1_max = 32,
>>>> +	.tseg2_min = 1,
>>>> +	.tseg2_max = 16,
>>>> +	.sjw_max = 16,
>>>> +	.brp_min = 1,
>>>> +	.brp_max = 32,
>>>> +	.brp_inc = 1,
>>>> +};
>>>> +
>>>> +static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
>>>> +{
>>>> +	int wake_state = 0;
>>>> +
>>>> +	if (priv->device_state_gpio)
>>>> +		wake_state = gpiod_get_value(priv->device_state_gpio);
>>>> +
>>>> +	if (priv->device_wake_gpio && wake_state) {
>>>> +		gpiod_set_value(priv->device_wake_gpio, 1);
>>>> +		udelay(100);
>>>
>>> Do you need the setting above?
>>>
>>
>> Do you mean do I need to set the reset line then delay?
> 
> I mean, do you need to set the gpio value to 1 at the beginning? Is 0->1
> not enough?
> 

The data sheet indicates it needs to see a rising edge to wake up.

The hw engineer asked me to put it this way.  But after digging into the data sheet
I am not seeing the HW reason.

I will remove it and see if there is any effect on the operation.
If we need it I will add a comment why.

>>
>>>> +		gpiod_set_value(priv->device_wake_gpio, 0);
>>>> +		udelay(100);
>>>> +		gpiod_set_value(priv->device_wake_gpio, 1);
>>>> +	}
>>>> +}
>>>> +
>>>> +static int regmap_spi_gather_write(void *context, const void *reg,
>>>> +				   size_t reg_len, const void *val,
>>>> +				   size_t val_len)
>>>> +{
>>>> +	struct device *dev = context;
>>>> +	struct spi_device *spi = to_spi_device(dev);
>>>> +	struct spi_message m;
>>>> +	u32 addr;
>>>> +	struct spi_transfer t[2] = {{ .tx_buf = &addr, .len = reg_len, .cs_change = 0,},
>>>> +				   { .tx_buf = val, .len = val_len, },};
>>>
>>> 	struct spi_transfer t[2] = {
>>> 		 {.tx_buf = &addr, .len = reg_len, .cs_change = 0,},
>>> 		 {.tx_buf = val, .len = val_len,},
>>> 	};
>>>
>>>
>>
>> I am assuming LTL issue here.
> 
> LTL means? I just reformatted the declaration.
> 

Line to Long.  But I changed it so it looks better.

>>
>>>> +
>>>> +	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 3;
>>>
>>>
>>
>> There is nothing here 
> 
> It's OK.
> 
>>
>>>
>>>> +
>>>> +	spi_message_init(&m);
>>>> +	spi_message_add_tail(&t[0], &m);
>>>> +	spi_message_add_tail(&t[1], &m);
>>>> +
>>>> +	return spi_sync(spi, &m);
>>>> +}
>>>> +
>>>> +static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
>>>> +{
>>>> +	u16 *reg = (u16 *)(data);
>>>> +	const u32 *val = data + 4;
>>>> +
>>>> +	return regmap_spi_gather_write(context, reg, 4, val, count);
>>>> +}
>>>> +
>>>> +static int regmap_spi_async_write(void *context,
>>>> +				  const void *reg, size_t reg_len,
>>>> +				  const void *val, size_t val_len,
>>>> +				  struct regmap_async *a)
>>>> +{
>>>> +	return -ENOTSUPP;
>>>> +}
>>>> +
>>>> +static struct regmap_async *regmap_spi_async_alloc(void)
>>>> +{
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static int tcan4x5x_regmap_read(void *context,
>>>> +				const void *reg, size_t reg_size,
>>>> +				void *val, size_t val_size)
>>>> +{
>>>> +	struct device *dev = context;
>>>> +	struct spi_device *spi = to_spi_device(dev);
>>>> +
>>>> +	u32 addr = TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2;
>>>> +
>>>> +	return spi_write_then_read(spi, &addr, reg_size, (u32 *)val, val_size);
>>>> +}
>>>> +
>>>> +static struct regmap_bus tcan4x5x_bus = {
>>>> +	.write = tcan4x5x_regmap_write,
>>>> +	.gather_write = regmap_spi_gather_write,
>>>> +	.async_write = regmap_spi_async_write,
>>>> +	.async_alloc = regmap_spi_async_alloc,
>>>> +	.read = tcan4x5x_regmap_read,
>>>> +	.read_flag_mask = 0x00,
>>>> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
>>>> +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>>>> +};
>>>> +
>>>> +static u32 tcan4x5x_read_reg(struct m_can_classdev *m_can_class, int reg)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>>> +	u32 val;
>>>> +
>>>> +	tcan4x5x_check_wake(priv);
>>>> +
>>>> +	regmap_read(priv->regmap, priv->reg_offset + reg, &val);
>>>> +
>>>> +	return val;
>>>> +}
>>>> +
>>>> +static u32 tcan4x5x_read_fifo(struct m_can_classdev *m_can_class,
>>>> +			      int addr_offset)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>>> +	u32 val;
>>>> +
>>>> +	tcan4x5x_check_wake(priv);
>>>> +
>>>> +	regmap_read(priv->regmap, priv->mram_start + addr_offset, &val);
>>>> +
>>>> +	return val;
>>>> +}
>>>> +
>>>> +static int tcan4x5x_write_reg(struct m_can_classdev *m_can_class,
>>>> +			      int reg, int val)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>>> +
>>>> +	tcan4x5x_check_wake(priv);
>>>> +
>>>> +	return regmap_write(priv->regmap, priv->reg_offset + reg, val);
>>>> +}
>>>> +
>>>> +static int tcan4x5x_write_fifo(struct m_can_classdev *m_can_class,
>>>> +			       int addr_offset, int val)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>>> +
>>>> +	tcan4x5x_check_wake(priv);
>>>> +
>>>> +	return regmap_write(priv->regmap, priv->mram_start + addr_offset, val);
>>>> +}
>>>> +
>>>> +static int tcan4x5x_power_enable(struct regulator *reg, int enable)
>>>> +{
>>>> +	if (IS_ERR_OR_NULL(reg))
>>>> +		return 0;
>>>> +
>>>> +	if (enable)
>>>> +		return regulator_enable(reg);
>>>> +	else
>>>> +		return regulator_disable(reg);
>>>> +}
>>>> +
>>>> +static int tcan4x5x_write_tcan_reg(struct m_can_classdev *m_can_class,
>>>> +				   int reg, int val)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>>> +
>>>> +	tcan4x5x_check_wake(priv);
>>>> +
>>>> +	return regmap_write(priv->regmap, reg, val);
>>>> +}
>>>> +
>>>> +static int tcan4x5x_clear_interrupts(struct m_can_classdev *class_dev)
>>>> +{
>>>> +	struct tcan4x5x_priv *tcan4x5x = (struct tcan4x5x_priv *)class_dev->device_data;
>>>> +	int ret;
>>>> +
>>>> +	tcan4x5x_check_wake(tcan4x5x);
>>>> +
>>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_STATUS,
>>>> +				      TCAN4X5X_CLEAR_ALL_INT);
>>>> +	if (ret)
>>>> +		return -EIO;
>>>
>>> Does "ret" not return a proper error code?
>>
>> I can change it to ret.
> 
> Browsing some kernel code, returning "ret" seems the usual approach
> (apart from ignoring the return code).
> 

Changed

>>
>>>
>>>> +
>>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_MCAN_INT_REG,
>>>> +				      TCAN4X5X_ENABLE_MCAN_INT);
>>>> +	if (ret)
>>>> +		return -EIO;
>>>> +
>>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_INT_FLAGS,
>>>> +				      TCAN4X5X_CLEAR_ALL_INT);
>>>> +	if (ret)
>>>> +		return -EIO;
>>>> +
>>>> +
>>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_ERROR_STATUS,
>>>> +				      TCAN4X5X_CLEAR_ALL_INT);
>>>> +	if (ret)
>>>> +		return -EIO;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int tcan4x5x_init(struct m_can_classdev *class_dev)
>>>> +{
>>>> +	struct tcan4x5x_priv *tcan4x5x = (struct tcan4x5x_priv *)class_dev->device_data;
>>>> +	int ret;
>>>> +
>>>> +	tcan4x5x_check_wake(tcan4x5x);
>>>> +
>>>> +	ret = tcan4x5x_clear_interrupts(class_dev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_INT_EN,
>>>> +				      TCAN4X5X_ENABLE_TCAN_INT);
>>>> +	if (ret)
>>>> +		return -EIO;
>>>> +
>>>> +	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
>>>> +				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_NORMAL);
>>>> +	if (ret)
>>>> +		return -EIO;
>>
>> Same comment as above
>>
>>>> +
>>>> +	/* Zero out the MCAN buffers */
>>>> +	m_can_init_ram(class_dev);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int tcan4x5x_parse_config(struct m_can_classdev *class_dev)
>>>> +{
>>>> +	struct tcan4x5x_priv *tcan4x5x = (struct tcan4x5x_priv *)class_dev->device_data;
>>>> +
>>>> +	tcan4x5x->reset_gpio = devm_gpiod_get_optional(class_dev->dev,
>>>> +						       "reset", GPIOD_OUT_LOW);
>>>> +	if (IS_ERR(tcan4x5x->reset_gpio))
>>>> +		tcan4x5x->reset_gpio = NULL;
>>>> +
>>>> +	tcan4x5x->device_wake_gpio = devm_gpiod_get_optional(class_dev->dev,
>>>> +							     "device-wake",
>>>> +							     GPIOD_OUT_HIGH);
>>>> +	if (IS_ERR(tcan4x5x->device_wake_gpio))
>>>> +		tcan4x5x->device_wake_gpio = NULL;
>>>> +
>>>> +	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(class_dev->dev,
>>>> +							      "device-state",
>>>> +							      GPIOD_IN);
>>>> +	if (IS_ERR(tcan4x5x->device_state_gpio))
>>>> +		tcan4x5x->device_state_gpio = NULL;
>>>> +
>>>> +	tcan4x5x->interrupt_gpio = devm_gpiod_get(class_dev->dev,
>>>> +						  "data-ready", GPIOD_IN);
>>>> +	if (IS_ERR(tcan4x5x->interrupt_gpio)) {
>>>> +		dev_err(class_dev->dev, "data-ready gpio not defined\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	class_dev->net->irq = gpiod_to_irq(tcan4x5x->interrupt_gpio);
>>>> +
>>>> +	tcan4x5x->power = devm_regulator_get_optional(class_dev->dev,
>>>> +						      "vsup");
>>>> +	if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
>>>> +		return -EPROBE_DEFER;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct regmap_config tcan4x5x_regmap = {
>>>> +	.reg_bits = 32,
>>>> +	.val_bits = 32,
>>>> +	.cache_type = REGCACHE_NONE,
>>>> +	.max_register = TCAN4X5X_MAX_REGISTER,
>>>> +};
>>>> +
>>>> +static struct m_can_ops tcan4x5x_ops = {
>>>> +	.device_init = tcan4x5x_init,
>>>> +	.read_reg = tcan4x5x_read_reg,
>>>> +	.write_reg = tcan4x5x_write_reg,
>>>> +	.write_fifo = tcan4x5x_write_fifo,
>>>> +	.read_fifo = tcan4x5x_read_fifo,
>>>> +	.clr_dev_interrupts = tcan4x5x_clear_interrupts,
>>>> +};
>>>> +
>>>> +static int tcan4x5x_can_probe(struct spi_device *spi)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv;
>>>> +	struct m_can_classdev *mcan_class;
>>>> +	int freq, ret;
>>>> +
>>>> +	mcan_class = m_can_class_allocate_dev(&spi->dev);
>>>> +	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	mcan_class->device_data = priv;
>>>> +
>>>> +	m_can_class_get_clocks(mcan_class);
>>>> +	if (IS_ERR(mcan_class->cclk)) {
>>>> +		dev_err(&spi->dev, "no CAN clock source defined\n");
>>>> +		freq = TCAN4X5X_EXT_CLK_DEF;
>>>> +	} else {
>>>> +		freq = clk_get_rate(mcan_class->cclk);
>>>> +	}
>>>> +
>>>> +	/* Sanity check */
>>>> +	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF)
>>>> +		return -ERANGE;
>>>> +
>>>> +	priv->reg_offset = TCAN4X5X_MCAN_OFFSET;
>>>> +	priv->mram_start = TCAN4X5X_MRAM_START;
>>>> +	priv->spi = spi;
>>>> +	priv->mcan_dev = mcan_class;
>>>> +
>>>> +	mcan_class->pm_clock_support = 0;
>>>> +	mcan_class->can.clock.freq = freq;
>>>> +	mcan_class->dev = &spi->dev;
>>>> +	mcan_class->ops = &tcan4x5x_ops;
>>>> +	mcan_class->is_peripherial = true;
>>>> +	mcan_class->bit_timing = &tcan4x5x_bittiming_const;
>>>> +	mcan_class->data_timing = &tcan4x5x_data_bittiming_const;
>>>> +
>>>> +	spi_set_drvdata(spi, priv);
>>>> +
>>>> +	ret = tcan4x5x_parse_config(mcan_class);
>>>> +	if (ret)
>>>> +		goto out_clk;
>>>> +
>>>> +	/* Configure the SPI bus */
>>>> +	spi->bits_per_word = 32;
>>>> +	ret = spi_setup(spi);
>>>> +	if (ret)
>>>> +		goto out_clk;
>>>> +
>>>> +	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
>>>> +					&spi->dev, &tcan4x5x_regmap);
>>>> +
>>>> +	mutex_init(&priv->tcan4x5x_lock);
>>>> +
>>>> +	tcan4x5x_power_enable(priv->power, 1);
>>>> +
>>>> +	ret = m_can_class_register(mcan_class);
>>>> +	if (ret)
>>>> +		goto reg_err;
>>>
>>> out_power?
>>>
>>
>> Not sure what you are asking?
> 
> "reg_err" stands for what? Above you use "out_clk" to disable clock
> settings. Therefore "out_power" does make sense to me (or something
> similar). Next time I will be a bit more verbose, sorry!
> 

Yeah that makes more sense.  reg_err was registration error.

>>
>>>> +
>>>> +	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
>>>> +	return 0;
>>>> +
>>>> +reg_err:
>>>> +	tcan4x5x_power_enable(priv->power, 0);
>>>> +out_clk:
>>>> +	if (!IS_ERR(mcan_class->cclk)) {
>>>> +		clk_disable_unprepare(mcan_class->cclk);
>>>> +		clk_disable_unprepare(mcan_class->hclk);
>>>> +	}
>>>> +
>>>> +	dev_err(&spi->dev, "Probe failed, err=%d\n", -ret);
>>>
>>> Just "ret" is fine!
>>>
>>
>> Ack
>>
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int tcan4x5x_can_remove(struct spi_device *spi)
>>>> +{
>>>> +	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
>>>> +
>>>> +	tcan4x5x_power_enable(priv->power, 0);
>>>> +
>>>> +	m_can_class_unregister(priv->mcan_dev);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id tcan4x5x_of_match[] = {
>>>> +	{ .compatible = "ti,tcan4x5x", },
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, tcan4x5x_of_match);
>>>> +
>>>> +static const struct spi_device_id tcan4x5x_id_table[] = {
>>>> +	{
>>>> +		.name		= "tcan4x5x",
>>>> +		.driver_data	= 0,
>>>> +	},
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
>>>> +
>>>> +static struct spi_driver tcan4x5x_can_driver = {
>>>> +	.driver = {
>>>> +		.name = DEVICE_NAME,
>>>> +		.of_match_table = tcan4x5x_of_match,
>>>> +		.pm = NULL,
>>>> +	},
>>>> +	.id_table = tcan4x5x_id_table,
>>>> +	.probe = tcan4x5x_can_probe,
>>>> +	.remove = tcan4x5x_can_remove,
>>>> +};
>>>> +module_spi_driver(tcan4x5x_can_driver);
>>>> +
>>>> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
>>>> +MODULE_DESCRIPTION("Texas Instruments TCAN4x5x CAN driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>>
>>>
>>> The changes to the io-mapped driver look good and non-critical... time
>>> to ask for beta-testers for the next version of the patch series.
>>>
>>
>> OK.  I also tested this here on one of our boards that use the iomapped code.
> 
> I know, you are testing on a dra76x from?
> 
>   https://www.spinics.net/lists/linux-can/msg00886.html
> 
> More testing would be nice.
> 

OK.  I know we will be testing both the io mapped and we have a couple customers
using the TCAN code with this change.

Dan

> Wolfgang.
> 


-- 
------------------
Dan Murphy
