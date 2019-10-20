Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D169CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489B72190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZRl6clE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfJTQgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:36:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42291 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfJTQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:36:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so6142121pgi.9;
        Sun, 20 Oct 2019 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Sqfy5MVvkuoFhxe3Wh+LB0YTiUvNBnBw57IMkZPXeM=;
        b=WZRl6clEBUs66YFryHstqI36Pyxh/dQtcMwbujXC+gN3lZXgifszLMbfRqQKy/Jw9M
         yUmUHs/2pncNDeIPqsUg0XAk5pvd0pYjLaTZH1ytFcr231h0BabR50eOXY1uHqOKCw2B
         nFXVObENRV9QcW8WweeyJ32Kfc49qxn6VqxnwSerEu6U4BBC5Ro9rmgLsoyWOR8CusJP
         a67dliLgFAN3igvtJ/Q6NHW5J9DIfZEc8txVblWJUm46zGGRsd8bI9atPZy0RvdwX4n6
         mpdIz22tEm7XDZGTj2YURCo+KxD8LeNsAe3VYapaXVWLyHVMTN7jhI2XZ6PDnG6pknyC
         Qt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Sqfy5MVvkuoFhxe3Wh+LB0YTiUvNBnBw57IMkZPXeM=;
        b=lFieTQogNq0swR1AE6IIJiAkVLez+93O8fV1QgL0ZmJVw0sH3bzEo2XfpABS7/VDeU
         W4JdNnqWHK5ardZuaZyYkpUi9AjYFiuHQdNzoBKhQO0PGbGF8GUwyN42zyTocdxQArEJ
         vVxa1QiEH+2U6y8acdATpxCRpnUAP2mJJDlEcRgJ1Lf2Fxyy5cJJZoPMLnGXP8tD0Oo0
         PHK/Aw4goENHN19xMzVoWLGME/oEZNhSl2MsnuEQqrH9CsdHnmObRK1DWW2IBMt9Zwyc
         I1lYizUnoHiYwdX73hDahwCBooLgKDohJTi01aH3CAq6b6Ha4v06RY9gVFvISWdtebk8
         ZOuQ==
X-Gm-Message-State: APjAAAVX6gPC0BDxAW7vvNXFsvYvTqnidr1tZg/Ka1WpH7LTQxhoWmQq
        o6SSc5H8kj3JECX63Tyw5c8=
X-Google-Smtp-Source: APXvYqz6KvrkSfaoB3MzBuhesKlTSbSfq+qM2d/+0pVvdBejo7W4aE33vLqdzsgfyxx47CL1FrVfPg==
X-Received: by 2002:a65:64da:: with SMTP id t26mr20675028pgv.180.1571589389398;
        Sun, 20 Oct 2019 09:36:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4sm12935917pff.22.2019.10.20.09.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 09:36:28 -0700 (PDT)
Date:   Sun, 20 Oct 2019 09:36:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add summation feature support
Message-ID: <20191020163628.GA16363@roeck-us.net>
References: <20191016235702.22039-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016235702.22039-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:57:02PM -0700, Nicolin Chen wrote:
> This patch implements the summation feature of INA3221, mainly the
> SCC (enabling) and SF (warning flag) bits of MASK_ENABLE register,
> INA3221_SHUNT_SUM (summation of shunt voltages) register, and the
> INA3221_CRIT_SUM (its critical alert setting) register.
> 
> Although the summation feature allows user to select which channels
> to be added to the result, as an initial support, this patch simply
> selects all channels by default, with one only condition: all shunt
> resistor values need to be the same. This is because the summation
> of current channels can be only accurately calculated, using shunt
> voltage sum register, if all shunt resistors are equivalent.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> 
> Hi Guenter,
> 
> I know my previous questions haven't been answered yet, so nodes
> for enabling bits aren't decided completely. But this patch only
> adds voltage and its current, and we had a conclusion for these
> two already last time. So I think we may add them first. Thanks!
> 

I don't really like the term "summation", as it is the process of
summing things up, not the result. I'll change "summation of" in
the documentation to "sum of" and apply the patch.

Thanks,
Guenter

>  Documentation/hwmon/ina3221.rst |  12 +++
>  drivers/hwmon/ina3221.c         | 163 +++++++++++++++++++++++++++-----
>  2 files changed, 153 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina3221.rst
> index f6007ae8f4e2..bf9051339dec 100644
> --- a/Documentation/hwmon/ina3221.rst
> +++ b/Documentation/hwmon/ina3221.rst
> @@ -41,6 +41,18 @@ curr[123]_max           Warning alert current(mA) setting, activates the
>  			average is above this value.
>  curr[123]_max_alarm     Warning alert current limit exceeded
>  in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
> +in7_input               Summation of shunt voltage(uV) channels
> +in7_label               Channel label for summation of shunt voltage
> +curr4_input             Summation of current(mA) measurement channels,
> +                        (only available when all channels use the same resistor
> +                        value for their shunt resistors)
> +curr4_crit              Critical alert current(mA) setting for summation of
> +                        current measurement, activates the corresponding alarm
> +                        when the respective current is above this value
> +                        (only effective when all channels use the same resistor
> +                        value for their shunt resistors)
> +curr4_crit_alarm        Critical alert current limit exceeded for summation of
> +                        current measurements.
>  samples                 Number of samples using in the averaging mode.
>  
>                          Supports the list of number of samples:
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 0037e2bdacd6..0a60d7513037 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -31,6 +31,8 @@
>  #define INA3221_WARN2			0x0a
>  #define INA3221_CRIT3			0x0b
>  #define INA3221_WARN3			0x0c
> +#define INA3221_SHUNT_SUM		0x0d
> +#define INA3221_CRIT_SUM		0x0e
>  #define INA3221_MASK_ENABLE		0x0f
>  
>  #define INA3221_CONFIG_MODE_MASK	GENMASK(2, 0)
> @@ -50,6 +52,8 @@
>  #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
>  #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
>  
> +#define INA3221_MASK_ENABLE_SCC_MASK	GENMASK(14, 12)
> +
>  #define INA3221_CONFIG_DEFAULT		0x7127
>  #define INA3221_RSHUNT_DEFAULT		10000
>  
> @@ -60,9 +64,11 @@ enum ina3221_fields {
>  	/* Status Flags */
>  	F_CVRF,
>  
> -	/* Alert Flags */
> +	/* Warning Flags */
>  	F_WF3, F_WF2, F_WF1,
> -	F_CF3, F_CF2, F_CF1,
> +
> +	/* Alert Flags: SF is the summation-alert flag */
> +	F_SF, F_CF3, F_CF2, F_CF1,
>  
>  	/* sentinel */
>  	F_MAX_FIELDS
> @@ -75,6 +81,7 @@ static const struct reg_field ina3221_reg_fields[] = {
>  	[F_WF3] = REG_FIELD(INA3221_MASK_ENABLE, 3, 3),
>  	[F_WF2] = REG_FIELD(INA3221_MASK_ENABLE, 4, 4),
>  	[F_WF1] = REG_FIELD(INA3221_MASK_ENABLE, 5, 5),
> +	[F_SF] = REG_FIELD(INA3221_MASK_ENABLE, 6, 6),
>  	[F_CF3] = REG_FIELD(INA3221_MASK_ENABLE, 7, 7),
>  	[F_CF2] = REG_FIELD(INA3221_MASK_ENABLE, 8, 8),
>  	[F_CF1] = REG_FIELD(INA3221_MASK_ENABLE, 9, 9),
> @@ -107,6 +114,7 @@ struct ina3221_input {
>   * @inputs: Array of channel input source specific structures
>   * @lock: mutex lock to serialize sysfs attribute accesses
>   * @reg_config: Register value of INA3221_CONFIG
> + * @summation_shunt_resistor: equivalent shunt resistor value for summation
>   * @single_shot: running in single-shot operating mode
>   */
>  struct ina3221_data {
> @@ -116,16 +124,51 @@ struct ina3221_data {
>  	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
>  	struct mutex lock;
>  	u32 reg_config;
> +	int summation_shunt_resistor;
>  
>  	bool single_shot;
>  };
>  
>  static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
>  {
> +	/* Summation channel checks shunt resistor values */
> +	if (channel > INA3221_CHANNEL3)
> +		return ina->summation_shunt_resistor != 0;
> +
>  	return pm_runtime_active(ina->pm_dev) &&
>  	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
>  }
>  
> +/**
> + * Helper function to return the resistor value for current summation.
> + *
> + * There is a condition to calculate current summation -- all the shunt
> + * resistor values should be the same, so as to simply fit the formula:
> + *     current summation = shunt voltage summation / shunt resistor
> + *
> + * Returns the equivalent shunt resistor value on success or 0 on failure
> + */
> +static inline int ina3221_summation_shunt_resistor(struct ina3221_data *ina)
> +{
> +	struct ina3221_input *input = ina->inputs;
> +	int i, shunt_resistor = 0;
> +
> +	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
> +		if (input[i].disconnected || !input[i].shunt_resistor)
> +			continue;
> +		if (!shunt_resistor) {
> +			/* Found the reference shunt resistor value */
> +			shunt_resistor = input[i].shunt_resistor;
> +		} else {
> +			/* No summation if resistor values are different */
> +			if (shunt_resistor != input[i].shunt_resistor)
> +				return 0;
> +		}
> +	}
> +
> +	return shunt_resistor;
> +}
> +
>  /* Lookup table for Bus and Shunt conversion times in usec */
>  static const u16 ina3221_conv_time[] = {
>  	140, 204, 332, 588, 1100, 2116, 4156, 8244,
> @@ -183,7 +226,14 @@ static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
>  	if (ret)
>  		return ret;
>  
> -	*val = sign_extend32(regval >> 3, 12);
> +	/*
> +	 * Shunt Voltage Sum register has 14-bit value with 1-bit shift
> +	 * Other Shunt Voltage registers have 12 bits with 3-bit shift
> +	 */
> +	if (reg == INA3221_SHUNT_SUM)
> +		*val = sign_extend32(regval >> 1, 14);
> +	else
> +		*val = sign_extend32(regval >> 3, 12);
>  
>  	return 0;
>  }
> @@ -195,6 +245,7 @@ static const u8 ina3221_in_reg[] = {
>  	INA3221_SHUNT1,
>  	INA3221_SHUNT2,
>  	INA3221_SHUNT3,
> +	INA3221_SHUNT_SUM,
>  };
>  
>  static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
> @@ -224,8 +275,12 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>  	u8 reg = ina3221_in_reg[channel];
>  	int regval, ret;
>  
> -	/* Translate shunt channel index to sensor channel index */
> -	channel %= INA3221_NUM_CHANNELS;
> +	/*
> +	 * Translate shunt channel index to sensor channel index except
> +	 * the 7th channel (6 since being 0-aligned) is for summation.
> +	 */
> +	if (channel != 6)
> +		channel %= INA3221_NUM_CHANNELS;
>  
>  	switch (attr) {
>  	case hwmon_in_input:
> @@ -259,22 +314,29 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>  	}
>  }
>  
> -static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS] = {
> -	[hwmon_curr_input] = { INA3221_SHUNT1, INA3221_SHUNT2, INA3221_SHUNT3 },
> -	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3 },
> -	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2, INA3221_CRIT3 },
> -	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3 },
> -	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3 },
> +static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS + 1] = {
> +	[hwmon_curr_input] = { INA3221_SHUNT1, INA3221_SHUNT2,
> +			       INA3221_SHUNT3, INA3221_SHUNT_SUM },
> +	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3, 0 },
> +	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2,
> +			      INA3221_CRIT3, INA3221_CRIT_SUM },
> +	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3, 0 },
> +	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3, F_SF },
>  };
>  
>  static int ina3221_read_curr(struct device *dev, u32 attr,
>  			     int channel, long *val)
>  {
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	struct ina3221_input *input = &ina->inputs[channel];
> -	int resistance_uo = input->shunt_resistor;
> +	struct ina3221_input *input = ina->inputs;
>  	u8 reg = ina3221_curr_reg[attr][channel];
> -	int regval, voltage_nv, ret;
> +	int resistance_uo, voltage_nv;
> +	int regval, ret;
> +
> +	if (channel > INA3221_CHANNEL3)
> +		resistance_uo = ina->summation_shunt_resistor;
> +	else
> +		resistance_uo = input[channel].shunt_resistor;
>  
>  	switch (attr) {
>  	case hwmon_curr_input:
> @@ -293,6 +355,9 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  		/* fall through */
>  	case hwmon_curr_crit:
>  	case hwmon_curr_max:
> +		if (!resistance_uo)
> +			return -ENODATA;
> +
>  		ret = ina3221_read_value(ina, reg, &regval);
>  		if (ret)
>  			return ret;
> @@ -366,10 +431,18 @@ static int ina3221_write_curr(struct device *dev, u32 attr,
>  			      int channel, long val)
>  {
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
> -	struct ina3221_input *input = &ina->inputs[channel];
> -	int resistance_uo = input->shunt_resistor;
> +	struct ina3221_input *input = ina->inputs;
>  	u8 reg = ina3221_curr_reg[attr][channel];
> -	int regval, current_ma, voltage_uv;
> +	int resistance_uo, current_ma, voltage_uv;
> +	int regval;
> +
> +	if (channel > INA3221_CHANNEL3)
> +		resistance_uo = ina->summation_shunt_resistor;
> +	else
> +		resistance_uo = input[channel].shunt_resistor;
> +
> +	if (!resistance_uo)
> +		return -EOPNOTSUPP;
>  
>  	/* clamp current */
>  	current_ma = clamp_val(val,
> @@ -381,8 +454,21 @@ static int ina3221_write_curr(struct device *dev, u32 attr,
>  	/* clamp voltage */
>  	voltage_uv = clamp_val(voltage_uv, -163800, 163800);
>  
> -	/* 1 / 40uV(scale) << 3(register shift) = 5 */
> -	regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
> +	/*
> +	 * Formula to convert voltage_uv to register value:
> +	 *     regval = (voltage_uv / scale) << shift
> +	 * Note:
> +	 *     The scale is 40uV for all shunt voltage registers
> +	 *     Shunt Voltage Sum register left-shifts 1 bit
> +	 *     All other Shunt Voltage registers shift 3 bits
> +	 * Results:
> +	 *     SHUNT_SUM: (1 / 40uV) << 1 = 1 / 20uV
> +	 *     SHUNT[1-3]: (1 / 40uV) << 3 = 1 / 5uV
> +	 */
> +	if (reg == INA3221_SHUNT_SUM)
> +		regval = DIV_ROUND_CLOSEST(voltage_uv, 20) & 0xfffe;
> +	else
> +		regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
>  
>  	return regmap_write(ina->regmap, reg, regval);
>  }
> @@ -499,7 +585,10 @@ static int ina3221_read_string(struct device *dev, enum hwmon_sensor_types type,
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	int index = channel - 1;
>  
> -	*str = ina->inputs[index].label;
> +	if (channel == 7)
> +		*str = "summation of shunt voltages";
> +	else
> +		*str = ina->inputs[index].label;
>  
>  	return 0;
>  }
> @@ -529,6 +618,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
>  		case hwmon_in_label:
>  			if (channel - 1 <= INA3221_CHANNEL3)
>  				input = &ina->inputs[channel - 1];
> +			else if (channel == 7)
> +				return 0444;
>  			/* Hide label node if label is not provided */
>  			return (input && input->label) ? 0444 : 0;
>  		case hwmon_in_input:
> @@ -573,11 +664,16 @@ static const struct hwmon_channel_info *ina3221_info[] = {
>  			   /* 4-6: shunt voltage Channels */
>  			   HWMON_I_INPUT,
>  			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT),
> +			   HWMON_I_INPUT,
> +			   /* 7: summation of shunt voltage channels */
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
>  	HWMON_CHANNEL_INFO(curr,
> +			   /* 1-3: current channels*/
> +			   INA3221_HWMON_CURR_CONFIG,
>  			   INA3221_HWMON_CURR_CONFIG,
>  			   INA3221_HWMON_CURR_CONFIG,
> -			   INA3221_HWMON_CURR_CONFIG),
> +			   /* 4: summation of current channels */
> +			   HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM),
>  	NULL
>  };
>  
> @@ -624,6 +720,9 @@ static ssize_t ina3221_shunt_store(struct device *dev,
>  
>  	input->shunt_resistor = val;
>  
> +	/* Update summation_shunt_resistor for summation channel */
> +	ina->summation_shunt_resistor = ina3221_summation_shunt_resistor(ina);
> +
>  	return count;
>  }
>  
> @@ -642,6 +741,7 @@ ATTRIBUTE_GROUPS(ina3221);
>  
>  static const struct regmap_range ina3221_yes_ranges[] = {
>  	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
> +	regmap_reg_range(INA3221_SHUNT_SUM, INA3221_SHUNT_SUM),
>  	regmap_reg_range(INA3221_MASK_ENABLE, INA3221_MASK_ENABLE),
>  };
>  
> @@ -772,6 +872,9 @@ static int ina3221_probe(struct i2c_client *client,
>  			ina->reg_config &= ~INA3221_CONFIG_CHx_EN(i);
>  	}
>  
> +	/* Initialize summation_shunt_resistor for summation channel control */
> +	ina->summation_shunt_resistor = ina3221_summation_shunt_resistor(ina);
> +
>  	ina->pm_dev = dev;
>  	mutex_init(&ina->lock);
>  	dev_set_drvdata(dev, ina);
> @@ -875,6 +978,22 @@ static int __maybe_unused ina3221_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* Initialize summation channel control */
> +	if (ina->summation_shunt_resistor) {
> +		/*
> +		 * Take all three channels into summation by default
> +		 * Shunt measurements of disconnected channels should
> +		 * be 0, so it does not matter for summation.
> +		 */
> +		ret = regmap_update_bits(ina->regmap, INA3221_MASK_ENABLE,
> +					 INA3221_MASK_ENABLE_SCC_MASK,
> +					 INA3221_MASK_ENABLE_SCC_MASK);
> +		if (ret) {
> +			dev_err(dev, "Unable to control summation channel\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
