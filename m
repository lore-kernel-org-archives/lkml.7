Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9890EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO4HdsJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfCTS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:59:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40763 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfCTS7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:59:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so3227311ljq.7;
        Wed, 20 Mar 2019 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBSnsOclFLVD9dJlHbZ04vapHQdEz160kvqEFm3t0LU=;
        b=mO4HdsJOa/qYtxi4Q5Mg3sMfxeBf7WSbTnrBahB2tElnWVslk232/j2YwCGh9FJtVP
         krHNE0SJDmeiOSt6ZjcayW6LNcIJhrxQG7o/zOQlMV9JCWa3RidOAJunBjU/UWrZEEHX
         VSsitouiKnNlIcQ9LZIAkrsQQ6auZme3Gn2/Cq4XGHpn6r+r+IFEevKmSsJ/xi+KaDFN
         PvYQpm6gFO5NcivJm8PJvMDP3wTrnqZPyGiCIPMe0QqlQBg/GeIVrEx5IsQXEEIs6/Ji
         biCPaaHZ8sc/jsbb+rbdQzoE9fhsUj2eA37KTVlY2RmaXrVggj4vDAUQ+8EwMBQ3MTtL
         Sx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBSnsOclFLVD9dJlHbZ04vapHQdEz160kvqEFm3t0LU=;
        b=erX2yUX/TgEIZozdFrUCDwwbDbs6xGfxiWNgwZyVT/AFoCDsZBu8GW2VhvUVhC9Kj+
         rGbopDiAmEXl7vBB5NJsMg5c/fBi73B/uzIm2GliBy3XRiH8PZcrkb0IFc6g1e1O1jfY
         uz+5d6c0DJw3C371p3e2nmN+L5XAfOTuroeRy4OUoxH+n9dUCrpcgZQzJHHB5Av036Tj
         wXn24VPlxO1JDNiGzBpK2CsD/+yxrBiWlktdzLFsiZFqI8fW7Xp25IvtQWwNmSse8ibp
         +vn6mGCzroLrAOuUXSiaZ0IbdR5ixBl1J25cPJmunO/QXMtL7IxscIcPD/zlY4rjrcqW
         TrVQ==
X-Gm-Message-State: APjAAAW+FI0qUxZ3jlo/e5ensmbcLam3KglDfXWKhq9NK3JcKkn7SDdo
        UJ2JoEevBxcmKOD/EryrSNspA843
X-Google-Smtp-Source: APXvYqyLWWElvDh3njaR20/ruFAaDVYkgJrL/TkAJ4FuIkFnMN6En2yNyZH+gMfuV6n3SpBaigfMow==
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr35424ljj.119.1553108357462;
        Wed, 20 Mar 2019 11:59:17 -0700 (PDT)
Received: from [192.168.1.18] (chp186.neoplus.adsl.tpnet.pl. [83.31.13.186])
        by smtp.gmail.com with ESMTPSA id n2sm516380lfe.71.2019.03.20.11.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 11:59:16 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190313123249.17258-1-dmurphy@ti.com>
 <20190313123249.17258-4-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a7ee025e-361e-90b8-e38d-53546a542102@gmail.com>
Date:   Wed, 20 Mar 2019 19:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313123249.17258-4-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I have one minor issue below.

On 3/13/19 1:32 PM, Dan Murphy wrote:
> Introduce the Texas Instruments LM3532 White LED driver.
> The driver supports ALS configurability or manual brightness
> control.
> 
> The driver also supports associating LED strings with specific
> control banks in a group or as individually controlled strings.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v4 - Updated code to DT doc changes appending "ti," to TI specific properties -
> https://lore.kernel.org/patchwork/patch/1050124/
> 
> v3 - Removed switch case for register setting in favor of an algorithim (v1 comment),
> https://lore.kernel.org/patchwork/patch/1049024/
> v2 - Added look up tables for als_avg, als_imp and ramp times, fixed brightness
> control when ALS is in control, added property value checks to ensure the values
> are not out of bounds - https://lore.kernel.org/patchwork/patch/1048807/
> 
>   drivers/leds/Kconfig       |  10 +
>   drivers/leds/Makefile      |   1 +
>   drivers/leds/leds-lm3532.c | 681 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 692 insertions(+)
>   create mode 100644 drivers/leds/leds-lm3532.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..da00b9ed5a5c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -138,6 +138,16 @@ config LEDS_LM3530
>   	  controlled manually or using PWM input or using ambient
>   	  light automatically.
>   
> +config LEDS_LM3532
> +	tristate "LCD Backlight driver for LM3532"
> +	depends on LEDS_CLASS
> +	depends on I2C
> +	help
> +	  This option enables support for the LCD backlight using
> +	  LM3532 ambient light sensor chip. This ALS chip can be
> +	  controlled manually or using PWM input or using ambient
> +	  light automatically.
> +
>   config LEDS_LM3533
>   	tristate "LED support for LM3533"
>   	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4c1b0054f379..7a8b1f55d459 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
>   obj-$(CONFIG_LEDS_CPCAP)		+= leds-cpcap.o
>   obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
>   obj-$(CONFIG_LEDS_LM3530)		+= leds-lm3530.o
> +obj-$(CONFIG_LEDS_LM3532)		+= leds-lm3532.o
>   obj-$(CONFIG_LEDS_LM3533)		+= leds-lm3533.o
>   obj-$(CONFIG_LEDS_LM3642)		+= leds-lm3642.o
>   obj-$(CONFIG_LEDS_MIKROTIK_RB532)	+= leds-rb532.o
> diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
> new file mode 100644
> index 000000000000..e8a614d71469
> --- /dev/null
> +++ b/drivers/leds/leds-lm3532.c
> @@ -0,0 +1,681 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// TI LM3532 LED driver
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/module.h>
> +#include <uapi/linux/uleds.h>
> +#include <linux/gpio/consumer.h>
> +
> +#define LM3532_NAME "lm3532-led"
> +#define LM3532_BL_MODE_MANUAL	0x00
> +#define LM3532_BL_MODE_ALS	0x01
> +
> +#define LM3532_REG_OUTPUT_CFG	0x10
> +#define LM3532_REG_STARTSHUT_RAMP	0x11
> +#define LM3532_REG_RT_RAMP	0x12
> +#define LM3532_REG_PWM_A_CFG	0x13
> +#define LM3532_REG_PWM_B_CFG	0x14
> +#define LM3532_REG_PWM_C_CFG	0x15
> +#define LM3532_REG_ZONE_CFG_A	0x16
> +#define LM3532_REG_CTRL_A_BRT	0x17
> +#define LM3532_REG_ZONE_CFG_B	0x18
> +#define LM3532_REG_CTRL_B_BRT	0x19
> +#define LM3532_REG_ZONE_CFG_C	0x1a
> +#define LM3532_REG_CTRL_C_BRT	0x1b
> +#define LM3532_REG_ENABLE	0x1d
> +#define LM3532_ALS_CONFIG	0x23
> +#define LM3532_REG_ZN_0_HI	0x60
> +#define LM3532_REG_ZN_0_LO	0x61
> +#define LM3532_REG_ZN_1_HI	0x62
> +#define LM3532_REG_ZN_1_LO	0x63
> +#define LM3532_REG_ZN_2_HI	0x64
> +#define LM3532_REG_ZN_2_LO	0x65
> +#define LM3532_REG_ZN_3_HI	0x66
> +#define LM3532_REG_ZN_3_LO	0x67
> +#define LM3532_REG_MAX		0x7e
> +
> +/* Contorl Enable */
> +#define LM3532_CTRL_A_ENABLE	BIT(0)
> +#define LM3532_CTRL_B_ENABLE	BIT(1)
> +#define LM3532_CTRL_C_ENABLE	BIT(2)
> +
> +/* PWM Zone Control */
> +#define LM3532_PWM_ZONE_MASK	0x7c
> +#define LM3532_PWM_ZONE_0_EN	BIT(2)
> +#define LM3532_PWM_ZONE_1_EN	BIT(3)
> +#define LM3532_PWM_ZONE_2_EN	BIT(4)
> +#define LM3532_PWM_ZONE_3_EN	BIT(5)
> +#define LM3532_PWM_ZONE_4_EN	BIT(6)
> +
> +/* Brightness Configuration */
> +#define LM3532_I2C_CTRL		BIT(0)
> +#define LM3532_ALS_CTRL		0
> +#define LM3532_LINEAR_MAP	BIT(1)
> +#define LM3532_ZONE_MASK	(BIT(2) | BIT(3) | BIT(4))
> +#define LM3532_ZONE_0		0
> +#define LM3532_ZONE_1		BIT(2)
> +#define LM3532_ZONE_2		BIT(3)
> +#define LM3532_ZONE_3		(BIT(2) | BIT(3))
> +#define LM3532_ZONE_4		BIT(4)
> +
> +#define LM3532_ENABLE_ALS	BIT(3)
> +#define LM3532_ALS_SEL_SHIFT	6
> +
> +/* Zone Boundary Register */
> +#define LM3532_ALS_WINDOW_mV	2000
> +#define LM3532_ALS_ZB_MAX	4
> +#define LM3532_ALS_OFFSET_mV	2
> +
> +#define LM3532_CONTROL_A	0
> +#define LM3532_CONTROL_B	1
> +#define LM3532_CONTROL_C	2
> +#define LM3532_MAX_CONTROL_BANKS 3
> +#define LM3532_MAX_LED_STRINGS	3
> +
> +#define LM3532_OUTPUT_CFG_MASK	0x3
> +#define LM3532_BRT_VAL_ADJUST	8
> +#define LM3532_RAMP_DOWN_SHIFT	3
> +
> +#define LM3532_NUM_RAMP_VALS	8
> +#define LM3532_NUM_AVG_VALS	8
> +#define LM3532_NUM_IMP_VALS	32
> +
> +/*
> + * struct lm3532_als_data
> + * @config - value of ALS configuration register
> + * @als1_imp_sel - value of ALS1 resistor select register
> + * @als2_imp_sel - value of ALS2 resistor select register
> + * @als_avrg_time - ALS averaging time
> + * @als_input_mode - ALS input mode for brightness control
> + * @als_vmin - Minimum ALS voltage
> + * @als_vmax - Maximum ALS voltage
> + * @zone_lo - values of ALS lo ZB(Zone Boundary) registers
> + * @zone_hi - values of ALS hi ZB(Zone Boundary) registers
> + */
> +struct lm3532_als_data {
> +	u8 config;
> +	u8 als1_imp_sel;
> +	u8 als2_imp_sel;
> +	u8 als_avrg_time;
> +	u8 als_input_mode;
> +	u32 als_vmin;
> +	u32 als_vmax;
> +	u8 zones_lo[LM3532_ALS_ZB_MAX];
> +	u8 zones_hi[LM3532_ALS_ZB_MAX];
> +};
> +
> +/**
> + * struct lm3532_led
> + * @led_dev: led class device
> + * @priv - Pointer the device data structure
> + * @control_bank - Control bank the LED is associated to
> + * @mode - Mode of the LED string
> + * @num_leds - Number of LED strings are supported in this array
> + * @led_strings - The LED strings supported in this array
> + * @label - LED label
> + */
> +struct lm3532_led {
> +	struct led_classdev led_dev;
> +	struct lm3532_data *priv;
> +
> +	int control_bank;
> +	int mode;
> +	int num_leds;
> +	u32 led_strings[LM3532_MAX_CONTROL_BANKS];
> +	char label[LED_MAX_NAME_SIZE];
> +};
> +
> +/**
> + * struct lm3532_data
> + * @enable_gpio - Hardware enable gpio
> + * @regulator: regulator
> + * @client: i2c client
> + * @regmap - Devices register map
> + * @dev - Pointer to the devices device struct
> + * @lock - Lock for reading/writing the device
> + * @als_data - Pointer to the als data struct
> + * @runtime_ramp_up - Runtime ramp up setting
> + * @runtime_ramp_down - Runtime ramp down setting
> + * @leds - Array of LED strings
> + */
> +struct lm3532_data {
> +	struct gpio_desc *enable_gpio;
> +	struct regulator *regulator;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +
> +	struct lm3532_als_data *als_data;
> +
> +	u32 runtime_ramp_up;
> +	u32 runtime_ramp_down;
> +
> +	struct lm3532_led leds[];
> +};
> +
> +static const struct reg_default lm3532_reg_defs[] = {
> +	{LM3532_REG_OUTPUT_CFG, 0xe4},
> +	{LM3532_REG_STARTSHUT_RAMP, 0xc0},
> +	{LM3532_REG_RT_RAMP, 0xc0},
> +	{LM3532_REG_PWM_A_CFG, 0x82},
> +	{LM3532_REG_PWM_B_CFG, 0x82},
> +	{LM3532_REG_PWM_C_CFG, 0x82},
> +	{LM3532_REG_ZONE_CFG_A, 0xf1},
> +	{LM3532_REG_CTRL_A_BRT, 0xf3},
> +	{LM3532_REG_ZONE_CFG_B, 0xf1},
> +	{LM3532_REG_CTRL_B_BRT, 0xf3},
> +	{LM3532_REG_ZONE_CFG_C, 0xf1},
> +	{LM3532_REG_CTRL_C_BRT, 0xf3},
> +	{LM3532_REG_ENABLE, 0xf8},
> +	{LM3532_ALS_CONFIG, 0x44},
> +	{LM3532_REG_ZN_0_HI, 0x35},
> +	{LM3532_REG_ZN_0_LO, 0x33},
> +	{LM3532_REG_ZN_1_HI, 0x6a},
> +	{LM3532_REG_ZN_1_LO, 0x66},
> +	{LM3532_REG_ZN_2_HI, 0xa1},
> +	{LM3532_REG_ZN_2_LO, 0x99},
> +	{LM3532_REG_ZN_3_HI, 0xdc},
> +	{LM3532_REG_ZN_3_LO, 0xcc},
> +};
> +
> +static const struct regmap_config lm3532_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = LM3532_REG_MAX,
> +	.reg_defaults = lm3532_reg_defs,
> +	.num_reg_defaults = ARRAY_SIZE(lm3532_reg_defs),
> +	.cache_type = REGCACHE_FLAT,
> +};
> +
> +const static int als_imp_table[LM3532_NUM_IMP_VALS] = {37000, 18500, 12330,
> +						       92500, 7400, 6170, 5290,
> +						       4630, 4110, 3700, 3360,
> +						       3080, 2850, 2640, 2440,
> +						       2310, 2180, 2060, 1950,
> +						       1850, 1760, 1680, 1610,
> +						       1540, 1480, 1420, 1370,
> +						       1320, 1280, 1230, 1190};
> +static int lm3532_get_als_imp_index(int als_imped)
> +{
> +	int i;
> +
> +	if (als_imped > als_imp_table[1])
> +		return 0;
> +
> +	if (als_imped < als_imp_table[LM3532_NUM_IMP_VALS - 1])
> +		return LM3532_NUM_IMP_VALS - 1;
> +
> +	for (i = 1; i < LM3532_NUM_IMP_VALS; i++) {
> +		if (als_imped == als_imp_table[i])
> +			return i;
> +
> +		/* Find an approximate index by looking up the table */
> +		if (als_imped < als_imp_table[i - 1] &&
> +		    als_imped > als_imp_table[i]) {
> +			if (als_imped - als_imp_table[i - 1] <
> +			    als_imp_table[i] - als_imped)
> +				return i + 1;
> +			else
> +				return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int lm3532_get_index(const int table[], int size, int value)
> +{
> +	int i;
> +
> +	for (i = 1; i < size; i++) {
> +		if (value == table[i])
> +			return i;
> +
> +		/* Find an approximate index by looking up the table */
> +		if (value > table[i - 1] &&
> +		    value < table[i]) {
> +			if (value - table[i - 1] < table[i] - value)
> +				return i - 1;
> +			else
> +				return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +const static int als_avrg_table[LM3532_NUM_AVG_VALS] = {17920, 35840, 71680,
> +							1433360, 286720, 573440,
> +							1146880, 2293760};
> +static int lm3532_get_als_avg_index(int avg_time)
> +{
> +	if (avg_time <= als_avrg_table[0])
> +		return 0;
> +
> +	if (avg_time > als_avrg_table[LM3532_NUM_AVG_VALS - 1])
> +		return LM3532_NUM_AVG_VALS - 1;
> +
> +	return lm3532_get_index(&als_avrg_table[0], LM3532_NUM_AVG_VALS,
> +				avg_time);
> +}
> +
> +const static int ramp_table[LM3532_NUM_RAMP_VALS] = { 8, 1024, 2048, 4096, 8192,
> +						     16384, 32768, 65536};
> +static int lm3532_get_ramp_index(int ramp_time)
> +{
> +	if (ramp_time <= ramp_table[0])
> +		return 0;
> +
> +	if (ramp_time > ramp_table[LM3532_NUM_RAMP_VALS - 1])
> +		return LM3532_NUM_RAMP_VALS - 1;
> +
> +	return lm3532_get_index(&ramp_table[0], LM3532_NUM_RAMP_VALS,
> +				ramp_time);
> +}
> +
> +static int lm3532_led_enable(struct lm3532_led *led_data)
> +{
> +	int ctrl_en_val = BIT(led_data->control_bank);
> +	int ret;
> +
> +	ret = regmap_update_bits(led_data->priv->regmap, LM3532_REG_ENABLE,
> +					 ctrl_en_val, ctrl_en_val);
> +	if (ret) {
> +		dev_err(led_data->priv->dev, "Failed to set ctrl:%d\n", ret);
> +		return ret;
> +	}
> +
> +	return regulator_enable(led_data->priv->regulator);
> +}
> +
> +static int lm3532_led_disable(struct lm3532_led *led_data)
> +{
> +	int ctrl_en_val = BIT(led_data->control_bank);
> +	int ret;
> +
> +	ret = regmap_update_bits(led_data->priv->regmap, LM3532_REG_ENABLE,
> +					 ctrl_en_val, ~ctrl_en_val);
> +	if (ret) {
> +		dev_err(led_data->priv->dev, "Failed to set ctrl:%d\n", ret);
> +		return ret;
> +	}
> +
> +	return regulator_disable(led_data->priv->regulator);
> +}
> +
> +static int lm3532_brightness_set(struct led_classdev *led_cdev,
> +				 enum led_brightness brt_val)
> +{
> +	struct lm3532_led *led =
> +			container_of(led_cdev, struct lm3532_led, led_dev);
> +	u8 brightness_reg;
> +	int ret;
> +
> +	mutex_lock(&led->priv->lock);
> +
> +	if (led->mode == LM3532_BL_MODE_ALS) {
> +		if (brt_val > LED_OFF)
> +			ret = lm3532_led_enable(led);
> +		else
> +			ret = lm3532_led_disable(led);
> +
> +		goto unlock;
> +	}
> +
> +	if (brt_val == LED_OFF) {
> +		ret = lm3532_led_disable(led);
> +		goto unlock;
> +	}
> +
> +	ret = lm3532_led_enable(led);
> +	if (ret)
> +		goto unlock;
> +
> +	brightness_reg = LM3532_REG_CTRL_A_BRT + led->control_bank * 2;
> +	brt_val = brt_val / LM3532_BRT_VAL_ADJUST;
> +
> +	ret = regmap_write(led->priv->regmap, brightness_reg, brt_val);
> +
> +unlock:
> +	mutex_unlock(&led->priv->lock);
> +	return ret;
> +}
> +
> +static int lm3532_init_registers(struct lm3532_led *led)
> +{
> +	struct lm3532_data *drvdata = led->priv;
> +	unsigned int runtime_ramp_val;
> +	unsigned int output_cfg_val = 0;
> +	unsigned int output_cfg_shift = 0;
> +	unsigned int output_cfg_mask = 0;
> +	int ret, i;
> +
> +	for (i = 0; i < led->num_leds; i++) {
> +		output_cfg_shift = led->led_strings[i] * 2;
> +		output_cfg_val |= (led->control_bank << output_cfg_shift);
> +		output_cfg_mask |= LM3532_OUTPUT_CFG_MASK << output_cfg_shift;
> +	}
> +
> +	ret = regmap_update_bits(drvdata->regmap, LM3532_REG_OUTPUT_CFG,
> +				 output_cfg_mask, output_cfg_val);
> +	if (ret)
> +		return ret;
> +
> +	runtime_ramp_val = drvdata->runtime_ramp_up |
> +			 (drvdata->runtime_ramp_down << LM3532_RAMP_DOWN_SHIFT);
> +
> +	return regmap_write(drvdata->regmap, LM3532_REG_RT_RAMP,
> +			    runtime_ramp_val);
> +}
> +
> +static int lm3532_als_configure(struct lm3532_data *priv,
> +				struct lm3532_led *led)
> +{
> +	struct lm3532_als_data *als = priv->als_data;
> +	u32 als_vmin, als_vmax, als_vstep;
> +	int zone_reg = LM3532_REG_ZN_0_HI;
> +	int brightnes_config_reg;
> +	int ret;
> +	int i;
> +
> +	als_vmin = als->als_vmin;
> +	als_vmax = als->als_vmax;
> +
> +	als_vstep = (als_vmax - als_vmin) / ((LM3532_ALS_ZB_MAX + 1) * 2);
> +
> +	for (i = 0; i < LM3532_ALS_ZB_MAX; i++) {
> +		als->zones_lo[i] = ((als_vmin + als_vstep + (i * als_vstep)) *
> +				LED_FULL) / 1000;
> +		als->zones_hi[i] = ((als_vmin + LM3532_ALS_OFFSET_mV +
> +				als_vstep + (i * als_vstep)) * LED_FULL) / 1000;
> +
> +		zone_reg = LM3532_REG_ZN_0_HI + i * 2;
> +		ret = regmap_write(priv->regmap, zone_reg, als->zones_lo[i]);
> +		if (ret)
> +			return ret;
> +
> +		zone_reg += 1;
> +		ret = regmap_write(priv->regmap, zone_reg, als->zones_hi[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	als->config = (als->als_avrg_time | (LM3532_ENABLE_ALS) |
> +		(als->als_input_mode << LM3532_ALS_SEL_SHIFT));
> +
> +	ret = regmap_write(priv->regmap, LM3532_ALS_CONFIG, als->config);
> +	if (ret)
> +		return ret;
> +
> +	brightnes_config_reg = LM3532_REG_ZONE_CFG_A + led->control_bank * 2;
> +
> +	return regmap_update_bits(priv->regmap, brightnes_config_reg,
> +				  LM3532_I2C_CTRL, LM3532_ALS_CTRL);
> +}
> +
> +static int lm3532_parse_als(struct lm3532_data *priv)
> +{
> +	struct lm3532_als_data *als;
> +	int als_avg_time;
> +	int als_impedance;
> +	int ret;
> +
> +	als = devm_kzalloc(priv->dev, sizeof(*als), GFP_KERNEL);
> +	if (als == NULL)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ti,als-vmin",
> +				       &als->als_vmin);
> +	if (ret)
> +		als->als_vmin = 0;
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ti,als-vmax",
> +				       &als->als_vmax);
> +	if (ret)
> +		als->als_vmax = LM3532_ALS_WINDOW_mV;
> +
> +	if (als->als_vmax > LM3532_ALS_WINDOW_mV) {
> +		ret = -EINVAL;
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ti,als1-imp-sel",
> +				      &als_impedance);
> +	if (ret)
> +		als->als1_imp_sel = 0;
> +	else
> +		als->als1_imp_sel = lm3532_get_als_imp_index(als_impedance);
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ti,als2-imp-sel",
> +				      &als_impedance);
> +	if (ret)
> +		als->als2_imp_sel = 0;
> +	else
> +		als->als2_imp_sel = lm3532_get_als_imp_index(als_impedance);
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ti,als-avrg-time-us",
> +				      &als_avg_time);
> +	if (ret)
> +		als->als_avrg_time = 0;
> +	else
> +		als->als_avrg_time = lm3532_get_als_avg_index(als_avg_time);
> +
> +	ret = device_property_read_u8(&priv->client->dev, "ti,als-input-mode",
> +				      &als->als_input_mode);
> +	if (ret)
> +		als->als_input_mode = 0;
> +
> +	if (als->als_input_mode > LM3532_BL_MODE_ALS) {
> +		ret = -EINVAL;
> +		return ret;
> +	}
> +
> +	priv->als_data = als;
> +
> +	return ret;
> +}
> +
> +static int lm3532_parse_node(struct lm3532_data *priv)
> +{
> +	struct fwnode_handle *child = NULL;
> +	struct lm3532_led *led;
> +	const char *name;
> +	int control_bank;
> +	u32 ramp_time;
> +	size_t i = 0;
> +	int ret;
> +
> +	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
> +						   "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->enable_gpio))
> +		priv->enable_gpio = NULL;
> +
> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vin");
> +	if (IS_ERR(priv->regulator))
> +		priv->regulator = NULL;
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ramp-up-us",
> +				       &ramp_time);
> +	if (ret)
> +		dev_info(&priv->client->dev, "ramp-up-ms property missing\n");
> +	else
> +		priv->runtime_ramp_up = lm3532_get_ramp_index(ramp_time);
> +
> +	ret = device_property_read_u32(&priv->client->dev, "ramp-down-us",
> +				       &ramp_time);
> +	if (ret)
> +		dev_info(&priv->client->dev, "ramp-down-ms property missing\n");
> +	else
> +		priv->runtime_ramp_down = lm3532_get_ramp_index(ramp_time);
> +
> +	device_for_each_child_node(priv->dev, child) {
> +		led = &priv->leds[i];
> +
> +		ret = fwnode_property_read_u32(child, "reg", &control_bank);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "reg property missing\n");
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		if (control_bank > LM3532_CONTROL_C) {
> +			dev_err(&priv->client->dev, "Control bank invalid\n");
> +			continue;
> +		}
> +
> +		led->control_bank = control_bank;
> +
> +		ret = fwnode_property_read_u32(child, "ti,led-mode",
> +					       &led->mode);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "ti,led-mode property missing\n");
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		if (led->mode == LM3532_BL_MODE_ALS) {
> +			ret = lm3532_parse_als(priv);
> +			if (ret)
> +				dev_err(&priv->client->dev, "Failed to parse als\n");
> +			else
> +				lm3532_als_configure(priv, led);
> +		}
> +
> +		led->num_leds = fwnode_property_read_u32_array(child,
> +							       "led-sources",
> +							       NULL, 0);
> +
> +		if (led->num_leds > LM3532_MAX_LED_STRINGS) {
> +			dev_err(&priv->client->dev, "To many LED string defined\n");
> +			continue;
> +		}
> +
> +		ret = fwnode_property_read_u32_array(child, "led-sources",
> +						    led->led_strings,
> +						    led->num_leds);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "led-sources property missing\n");
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		fwnode_property_read_string(child, "linux,default-trigger",
> +					    &led->led_dev.default_trigger);
> +
> +		ret = fwnode_property_read_string(child, "label", &name);
> +		if (ret)
> +			snprintf(led->label, sizeof(led->label),
> +				"%s::", priv->client->name);
> +		else
> +			snprintf(led->label, sizeof(led->label),
> +				 "%s:%s", priv->client->name, name);
> +
> +		led->priv = priv;
> +		led->led_dev.name = led->label;
> +		led->led_dev.brightness_set_blocking = lm3532_brightness_set;
> +
> +		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "led register err: %d\n",
> +				ret);
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		lm3532_init_registers(led);
> +
> +		i++;
> +	}
> +
> +child_out:
> +	return ret;
> +}
> +
> +static int lm3532_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct lm3532_data *drvdata;
> +	int ret = 0;
> +	int count;
> +
> +	count = device_get_child_node_count(&client->dev);
> +	if (!count) {
> +		dev_err(&client->dev, "LEDs are not defined in device tree!");
> +		return -ENODEV;
> +	}
> +
> +	drvdata = devm_kzalloc(&client->dev, struct_size(drvdata, leds, count),
> +			   GFP_KERNEL);
> +	if (drvdata == NULL)
> +		return -ENOMEM;
> +
> +	drvdata->client = client;
> +	drvdata->dev = &client->dev;
> +
> +	drvdata->regmap = devm_regmap_init_i2c(client, &lm3532_regmap_config);
> +	if (IS_ERR(drvdata->regmap)) {
> +		ret = PTR_ERR(drvdata->regmap);
> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&drvdata->lock);
> +	i2c_set_clientdata(client, drvdata);
> +
> +	ret = lm3532_parse_node(drvdata);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to parse node\n");
> +		return ret;
> +	}
> +
> +	if (drvdata->enable_gpio)
> +		gpiod_direction_output(drvdata->enable_gpio, 1);
> +
> +	return ret;
> +}
> +
> +static int lm3532_remove(struct i2c_client *client)
> +{
> +	struct lm3532_data *drvdata = i2c_get_clientdata(client);
mutex_destroy(&drvdata->lock);

> +	if (drvdata->enable_gpio)
> +		gpiod_direction_output(drvdata->enable_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_lm3532_leds_match[] = {
> +	{ .compatible = "ti,lm3532", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_lm3532_leds_match);
> +
> +static const struct i2c_device_id lm3532_id[] = {
> +	{LM3532_NAME, 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, lm3532_id);
> +
> +static struct i2c_driver lm3532_i2c_driver = {
> +	.probe = lm3532_probe,
> +	.remove = lm3532_remove,
> +	.id_table = lm3532_id,
> +	.driver = {
> +		.name = LM3532_NAME,
> +		.of_match_table = of_lm3532_leds_match,
> +	},
> +};
> +module_i2c_driver(lm3532_i2c_driver);
> +
> +MODULE_DESCRIPTION("Back Light driver for LM3532");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> 

-- 
Best regards,
Jacek Anaszewski
