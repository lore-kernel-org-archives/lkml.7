Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD9C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD3206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPDxHFxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfFLUcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:32:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37341 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbfFLUcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:32:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so7106399plb.4;
        Wed, 12 Jun 2019 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKRQymlsjqxLKxljxQwFoKYtghK9wZEByQGTTI+6S1s=;
        b=GPDxHFxlhXxCfjZMVj9+U4SWAV8Yvg2O9v3yoV2BL9Uyb2jrp73jd0p2cCM87aUUDA
         n4Zi4gjnDXlEvUkRAZWMttReAUt5qspmwOM6CSJ00wCodtJtoruryh4gt+H0EyvSgq5b
         gjIUdGpDgbkB3QQQEGXh4IdtkyRdAITKvwzCgSSO+Ct1oyTiK5tyh9+f2qvVPGcYk2fg
         QbneuDfrBCPY1K6i3FMwsKKrLKxpv0bYipvJlSHzV5KLqk0xlsp559B8E1IzJy5di2nM
         W2H21iMfnfgtP4t8C35svfZzBspwlNA4IQ6adkJpxzKAkZiw+hXgjCQ6vFBr+QZiEHmT
         /vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKRQymlsjqxLKxljxQwFoKYtghK9wZEByQGTTI+6S1s=;
        b=aIRqASWv+pyk3ph13yKPJ+viPSRosPvm0ALO1hRk/8tYic6LE+C5tJSdJsD6lT/qCN
         H3emwxCRhroLOydb62BeS0TQqAB3xDwtXKTI9npqpLzXzEy4HrQInS7O52Ay0f0C8Szv
         sIqyp79OdtrlvdUqHhYbwCCA6ojSAkBuY+wZNdh6BJgI2KBTMd1u0CzMIa+/IXXnw3tk
         RSHAmyDi20hWa6LAJJgPW8PaHjpC/7sU3Rr6pVfN1NR3YYSib4b40YDfU4XlfkTQQdF9
         RkRvQQkj8RqRx59TPWSexcYwhRyGNTwUgzST9gp75qnuwKNBgS48BFEY6Vl88OPgevbu
         bGRg==
X-Gm-Message-State: APjAAAUsI83NfkAtSjbd00UDAadnQsVcp6eby7lZH6HIJOBrUmCBrojh
        m9w3+K8tqVGIk9SuLt7ar7o=
X-Google-Smtp-Source: APXvYqwJJkNHN5Yw4AL9f0rcChC5Dgo97CuqrCQrAaPc7lVP7PH0+tS4Z3znk8PjR3R7Q4/6cFGnNQ==
X-Received: by 2002:a17:902:860c:: with SMTP id f12mr83844930plo.127.1560371550634;
        Wed, 12 Jun 2019 13:32:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2sm335140pgc.49.2019.06.12.13.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:32:29 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:32:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v4,1/1] hwmon: (nct7904) Add extra sysfs support for fan,
 voltage and temperature.
Message-ID: <20190612203228.GA21113@roeck-us.net>
References: <20190612083049.25180-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612083049.25180-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:30:48AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> NCT-7904D also supports reading of channel limitation registers
> and SMI status registers for fan, voltage and temperature monitoring,
> and also supports reading of temperature sensor type which is thermal diode,
> thermistor, AMD SB-TSI or Intel PECI, thus add below sysfs nodes:
> 
> -fan[1-*]_min
> -fan[1-*]_alarm
> -in[1-*]_min
> -in[1-*]_max
> -in[1-*]_alarm
> -temp[1-*]_max
> -temp[1-*]_max_hyst
> -temp[1-*]_crit
> -temp[1-*]_crit_hyst
> -temp[1-*]_alarm
> -temp[1-*]_type
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---
>  drivers/hwmon/nct7904.c | 496 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 444 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 5708171197e7..1e6b81f12ecb 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -46,10 +46,33 @@
>  #define DTS_T_CTRL1_REG		0x27
>  #define VT_ADC_MD_REG		0x2E
>  
> +#define VSEN1_HV_LL_REG		0x02	/* Bank 1; 2 regs (HV/LV) per sensor */
> +#define VSEN1_LV_LL_REG		0x03	/* Bank 1; 2 regs (HV/LV) per sensor */
> +#define VSEN1_HV_HL_REG		0x00	/* Bank 1; 2 regs (HV/LV) per sensor */
> +#define VSEN1_LV_HL_REG		0x01	/* Bank 1; 2 regs (HV/LV) per sensor */
> +#define SMI_STS1_REG		0xC1	/* Bank 0; SMI Status Register */
> +#define SMI_STS5_REG		0xC5	/* Bank 0; SMI Status Register */
> +#define SMI_STS7_REG		0xC7	/* Bank 0; SMI Status Register */
> +#define SMI_STS8_REG		0xC8	/* Bank 0; SMI Status Register */
> +
>  #define VSEN1_HV_REG		0x40	/* Bank 0; 2 regs (HV/LV) per sensor */
>  #define TEMP_CH1_HV_REG		0x42	/* Bank 0; same as VSEN2_HV */
>  #define LTD_HV_REG		0x62	/* Bank 0; 2 regs in VSEN range */
> +#define LTD_HV_HL_REG		0x44	/* Bank 1; 1 reg for LTD */
> +#define LTD_LV_HL_REG		0x45	/* Bank 1; 1 reg for LTD */
> +#define LTD_HV_LL_REG		0x46	/* Bank 1; 1 reg for LTD */
> +#define LTD_LV_LL_REG		0x47	/* Bank 1; 1 reg for LTD */
> +#define TEMP_CH1_CH_REG		0x05	/* Bank 1; 1 reg for LTD */
> +#define TEMP_CH1_W_REG		0x06	/* Bank 1; 1 reg for LTD */
> +#define TEMP_CH1_WH_REG		0x07	/* Bank 1; 1 reg for LTD */
> +#define TEMP_CH1_C_REG		0x04	/* Bank 1; 1 reg per sensor */
> +#define DTS_T_CPU1_C_REG	0x90	/* Bank 1; 1 reg per sensor */
> +#define DTS_T_CPU1_CH_REG	0x91	/* Bank 1; 1 reg per sensor */
> +#define DTS_T_CPU1_W_REG	0x92	/* Bank 1; 1 reg per sensor */
> +#define DTS_T_CPU1_WH_REG	0x93	/* Bank 1; 1 reg per sensor */
>  #define FANIN1_HV_REG		0x80	/* Bank 0; 2 regs (HV/LV) per sensor */
> +#define FANIN1_HV_HL_REG	0x60	/* Bank 1; 2 regs (HV/LV) per sensor */
> +#define FANIN1_LV_HL_REG	0x61	/* Bank 1; 2 regs (HV/LV) per sensor */
>  #define T_CPU1_HV_REG		0xA0	/* Bank 0; 2 regs (HV/LV) per sensor */
>  
>  #define PRTS_REG		0x03	/* Bank 2 */
> @@ -58,6 +81,8 @@
>  #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
>  #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
>  
> +#define ENABLE_TSI	BIT(1)
> +
>  static const unsigned short normal_i2c[] = {
>  	0x2d, 0x2e, I2C_CLIENT_END
>  };
> @@ -72,6 +97,7 @@ struct nct7904_data {
>  	u8 fan_mode[FANCTL_MAX];
>  	u8 enable_dts;
>  	u8 has_dts;
> +	u8 temp_mode; /* 0: TR mode, 1: TD mode */
>  };
>  
>  /* Access functions */
> @@ -170,6 +196,25 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
>  			rpm = 1350000 / cnt;
>  		*val = rpm;
>  		return 0;
> +	case hwmon_fan_min:
> +		ret = nct7904_read_reg16(data, BANK_1,
> +					 FANIN1_HV_HL_REG + channel * 2);
> +		if (ret < 0)
> +			return ret;
> +		cnt = ((ret & 0xff00) >> 3) | (ret & 0x1f);
> +		if (cnt == 0x1fff)
> +			rpm = 0;
> +		else
> +			rpm = 1350000 / cnt;
> +		*val = rpm;
> +		return 0;
> +	case hwmon_fan_alarm:
> +		ret = nct7904_read_reg(data, BANK_0,
> +				       SMI_STS7_REG + (channel >> 3));
> +		if (ret < 0)
> +			return ret;
> +		*val = (ret >> (channel & 0x07)) & 1;
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -179,8 +224,20 @@ static umode_t nct7904_fan_is_visible(const void *_data, u32 attr, int channel)
>  {
>  	const struct nct7904_data *data = _data;
>  
> -	if (attr == hwmon_fan_input && data->fanin_mask & (1 << channel))
> -		return 0444;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_alarm:
> +		if (data->fanin_mask & (1 << channel))
> +			return 0444;
> +		break;
> +	case hwmon_fan_min:
> +		if (data->fanin_mask & (1 << channel))
> +			return 0644;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -211,6 +268,37 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
>  			volt *= 6; /* 0.006V scale */
>  		*val = volt;
>  		return 0;
> +	case hwmon_in_min:
> +		ret = nct7904_read_reg16(data, BANK_1,
> +					 VSEN1_HV_LL_REG + index * 4);
> +		if (ret < 0)
> +			return ret;
> +		volt = ((ret & 0xff00) >> 5) | (ret & 0x7);
> +		if (index < 14)
> +			volt *= 2; /* 0.002V scale */
> +		else
> +			volt *= 6; /* 0.006V scale */
> +		*val = volt;
> +		return 0;
> +	case hwmon_in_max:
> +		ret = nct7904_read_reg16(data, BANK_1,
> +					 VSEN1_HV_HL_REG + index * 4);
> +		if (ret < 0)
> +			return ret;
> +		volt = ((ret & 0xff00) >> 5) | (ret & 0x7);
> +		if (index < 14)
> +			volt *= 2; /* 0.002V scale */
> +		else
> +			volt *= 6; /* 0.006V scale */
> +		*val = volt;
> +		return 0;
> +	case hwmon_in_alarm:
> +		ret = nct7904_read_reg(data, BANK_0,
> +				       SMI_STS1_REG + (index >> 3));
> +		if (ret < 0)
> +			return ret;
> +		*val = (ret >> (index & 0x07)) & 1;
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -221,9 +309,20 @@ static umode_t nct7904_in_is_visible(const void *_data, u32 attr, int channel)
>  	const struct nct7904_data *data = _data;
>  	int index = nct7904_chan_to_index[channel];
>  
> -	if (channel > 0 && attr == hwmon_in_input &&
> -	    (data->vsen_mask & BIT(index)))
> -		return 0444;
> +	switch (attr) {
> +	case hwmon_in_input:
> +	case hwmon_in_alarm:
> +		if (channel > 0 && (data->vsen_mask & BIT(index)))
> +			return 0444;
> +		break;
> +	case hwmon_in_min:
> +	case hwmon_in_max:
> +		if (channel > 0 && (data->vsen_mask & BIT(index)))
> +			return 0644;
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	return 0;
>  }
> @@ -233,6 +332,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  {
>  	struct nct7904_data *data = dev_get_drvdata(dev);
>  	int ret, temp;
> +	unsigned int reg1, reg2, reg3;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> @@ -250,16 +350,100 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  		temp = ((ret & 0xff00) >> 5) | (ret & 0x7);
>  		*val = sign_extend32(temp, 10) * 125;
>  		return 0;
> +	case hwmon_temp_alarm:
> +		if (channel < 5) {
> +			ret = nct7904_read_reg(data, BANK_0,
> +					       SMI_STS1_REG);
> +			if (ret < 0)
> +				return ret;
> +			*val = (ret >> (((channel * 2) + 1) & 0x07)) & 1;
> +		} else {
> +			if ((channel - 5) < 4) {
> +				ret = nct7904_read_reg(data, BANK_0,
> +						       SMI_STS7_REG +
> +						       ((channel - 5) >> 3));
> +				if (ret < 0)
> +					return ret;
> +				*val = (ret >> ((channel - 5) & 0x07)) & 1;
> +			} else {
> +				ret = nct7904_read_reg(data, BANK_0,
> +						       SMI_STS8_REG +
> +						       ((channel - 5) >> 3));
> +				if (ret < 0)
> +					return ret;
> +				*val = (ret >> (((channel - 5) & 0x07) - 4))
> +							& 1;
> +			}
> +		}
> +		return 0;
> +	case hwmon_temp_type:
> +		if (channel < 5) {
> +			if ((data->tcpu_mask >> channel) & 0x01) {
> +				if ((data->temp_mode >> channel) & 0x01)
> +					*val = 3; /* TD */
> +				else
> +					*val = 4; /* TR */
> +			} else {
> +				*val = 0;
> +			}
> +		} else {
> +			if ((data->has_dts >> (channel - 5)) & 0x01) {
> +				if (data->enable_dts & ENABLE_TSI)
> +					*val = 5; /* TSI */
> +				else
> +					*val = 6; /* PECI */
> +			} else {
> +				*val = 0;
> +			}
> +		}
> +		return 0;
> +	case hwmon_temp_max:
> +		reg1 = LTD_HV_HL_REG;
> +		reg2 = TEMP_CH1_C_REG;
> +		reg3 = DTS_T_CPU1_C_REG;
> +		break;
> +	case hwmon_temp_max_hyst:
> +		reg1 = LTD_LV_HL_REG;
> +		reg2 = TEMP_CH1_CH_REG;
> +		reg3 = DTS_T_CPU1_CH_REG;
> +		break;
> +	case hwmon_temp_crit:
> +		reg1 = LTD_HV_LL_REG;
> +		reg2 = TEMP_CH1_W_REG;
> +		reg3 = DTS_T_CPU1_W_REG;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg1 = LTD_LV_LL_REG;
> +		reg2 = TEMP_CH1_WH_REG;
> +		reg3 = DTS_T_CPU1_WH_REG;
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> +
> +	if (channel == 4)
> +		ret = nct7904_read_reg(data, BANK_1, reg1);
> +	else if (channel < 5)
> +		ret = nct7904_read_reg(data, BANK_1,
> +				       reg2 + channel * 8);
> +	else
> +		ret = nct7904_read_reg(data, BANK_1,
> +				       reg3 + (channel - 5) * 4);
> +
> +	if (ret < 0)
> +		return ret;
> +	*val = ret * 1000;
> +	return 0;
>  }
>  
>  static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>  {
>  	const struct nct7904_data *data = _data;
>  
> -	if (attr == hwmon_temp_input) {
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_alarm:
> +	case hwmon_temp_type:
>  		if (channel < 5) {
>  			if (data->tcpu_mask & BIT(channel))
>  				return 0444;
> @@ -267,6 +451,21 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>  			if (data->has_dts & BIT(channel - 5))
>  				return 0444;
>  		}
> +		break;
> +	case hwmon_temp_max:
> +	case hwmon_temp_max_hyst:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_crit_hyst:
> +		if (channel < 5) {
> +			if (data->tcpu_mask & BIT(channel))
> +				return 0644;
> +		} else {
> +			if (data->has_dts & BIT(channel - 5))
> +				return 0644;
> +		}
> +		break;
> +	default:
> +		break;
>  	}
>  
>  	return 0;
> @@ -297,6 +496,137 @@ static int nct7904_read_pwm(struct device *dev, u32 attr, int channel,
>  	}
>  }
>  
> +static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
> +			      long val)
> +{
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	unsigned int reg1, reg2, reg3;
> +
> +	val = clamp_val(val / 1000, -128, 127);
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		reg1 = LTD_HV_HL_REG;
> +		reg2 = TEMP_CH1_C_REG;
> +		reg3 = DTS_T_CPU1_C_REG;
> +		break;
> +	case hwmon_temp_max_hyst:
> +		reg1 = LTD_LV_HL_REG;
> +		reg2 = TEMP_CH1_CH_REG;
> +		reg3 = DTS_T_CPU1_CH_REG;
> +		break;
> +	case hwmon_temp_crit:
> +		reg1 = LTD_HV_LL_REG;
> +		reg2 = TEMP_CH1_W_REG;
> +		reg3 = DTS_T_CPU1_W_REG;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg1 = LTD_LV_LL_REG;
> +		reg2 = TEMP_CH1_WH_REG;
> +		reg3 = DTS_T_CPU1_WH_REG;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	if (channel == 4)
> +		ret = nct7904_write_reg(data, BANK_1, reg1, val);
> +	else if (channel < 5)
> +		ret = nct7904_write_reg(data, BANK_1,
> +					reg2 + channel * 8, val);
> +	else
> +		ret = nct7904_write_reg(data, BANK_1,
> +					reg3 + (channel - 5) * 4, val);
> +
> +	return ret;
> +}
> +
> +static int nct7904_write_fan(struct device *dev, u32 attr, int channel,
> +			     long val)
> +{
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	u8 tmp;
> +
> +	switch (attr) {
> +	case hwmon_fan_min:
> +		if (val <= 0)
> +			return 0x1fff;
> +
What exactly is this return value supposed to reflect ? Expected return
value is either 0 or an error code. 0x1fff is not a valid return code.

> +		val = clamp_val((1350000 + (val >> 1)) / val, 1, 0x1fff);
> +		tmp = (val >> 5) & 0xff;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					FANIN1_HV_HL_REG + channel * 2, tmp);
> +		if (ret < 0)
> +			return ret;
> +		tmp = val & 0x1f;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					FANIN1_LV_HL_REG + channel * 2, tmp);
> +		return ret;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int nct7904_write_in(struct device *dev, u32 attr, int channel,
> +			    long val)
> +{
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret, index, tmp;
> +
> +	index = nct7904_chan_to_index[channel];
> +
> +	if (index < 14)
> +		val = val / 2; /* 0.002V scale */
> +	else
> +		val = val / 6; /* 0.006V scale */
> +
> +	val = clamp_val(val, 0, 0x7ff); /* Bit 15 is sign bit */

What is "Bit 15 is sign bit" supposed to mean ?
I don't find an indication that the chips reports or accepts
negative voltages, the clamp does not accept negative values,
and nct7904_read_in() does not report negative values either.
I find the comment just confusing.

> +
> +	switch (attr) {
> +	case hwmon_in_min:
> +		tmp = nct7904_read_reg(data, BANK_1,
> +				       VSEN1_LV_LL_REG + index * 4);
> +		if (tmp < 0)
> +			return tmp;
> +		tmp &= ~0x7;
> +		tmp |= val & 0x7;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					VSEN1_LV_LL_REG + index * 4, tmp);
> +		if (ret < 0)
> +			return ret;
> +		tmp = nct7904_read_reg(data, BANK_1,
> +				       VSEN1_HV_LL_REG + index * 4);
> +		if (tmp < 0)
> +			return tmp;
> +		tmp = (val >> 3) & 0xff;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					VSEN1_HV_LL_REG + index * 4, tmp);
> +		return ret;
> +	case hwmon_in_max:
> +		tmp = nct7904_read_reg(data, BANK_1,
> +				       VSEN1_LV_HL_REG + index * 4);
> +		if (tmp < 0)
> +			return tmp;
> +		tmp &= ~0x7;
> +		tmp |= val & 0x7;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					VSEN1_LV_HL_REG + index * 4, tmp);
> +		if (ret < 0)
> +			return ret;
> +		tmp = nct7904_read_reg(data, BANK_1,
> +				       VSEN1_HV_HL_REG + index * 4);
> +		if (tmp < 0)
> +			return tmp;
> +		tmp = (val >> 3) & 0xff;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					VSEN1_HV_HL_REG + index * 4, tmp);
> +		return ret;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static int nct7904_write_pwm(struct device *dev, u32 attr, int channel,
>  			     long val)
>  {
> @@ -354,8 +684,14 @@ static int nct7904_write(struct device *dev, enum hwmon_sensor_types type,
>  			 u32 attr, int channel, long val)
>  {
>  	switch (type) {
> +	case hwmon_in:
> +		return nct7904_write_in(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return nct7904_write_fan(dev, attr, channel, val);
>  	case hwmon_pwm:
>  		return nct7904_write_pwm(dev, attr, channel, val);
> +	case hwmon_temp:
> +		return nct7904_write_temp(dev, attr, channel, val);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -404,51 +740,91 @@ static int nct7904_detect(struct i2c_client *client,
>  
>  static const struct hwmon_channel_info *nct7904_info[] = {
>  	HWMON_CHANNEL_INFO(in,
> -			   HWMON_I_INPUT, /* dummy, skipped in is_visible */
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT,
> -			   HWMON_I_INPUT),
> +			   /* dummy, skipped in is_visible */
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			   HWMON_I_ALARM),
>  	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT,
> -			   HWMON_F_INPUT),
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM),
>  	HWMON_CHANNEL_INFO(pwm,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT),
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST),
>  	NULL
>  };
>  
> @@ -506,6 +882,8 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	/* CPU_TEMP attributes */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
> +	if (ret < 0)
> +		return ret;
>  
>  	if ((ret & 0x6) == 0x6)
>  		data->tcpu_mask |= 1; /* TR1 */
> @@ -518,37 +896,51 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	/* LTD */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
> +	if (ret < 0)
> +		return ret;
>  	if ((ret & 0x02) == 0x02)
>  		data->tcpu_mask |= 0x10;
>  
>  	/* Multi-Function detecting for Volt and TR/TD */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_MD_REG);
> +	if (ret < 0)
> +		return ret;
>  
> +	data->temp_mode = 0;
>  	for (i = 0; i < 4; i++) {
>  		val = (ret & (0x03 << i)) >> (i * 2);
>  		bit = (1 << i);
>  		if (val == 0)
>  			data->tcpu_mask &= ~bit;
> +		else if (val == 0x1 || val == 0x2)
> +			data->temp_mode |= bit;
>  	}
>  
>  	/* PECI */
>  	ret = nct7904_read_reg(data, BANK_2, PFE_REG);
> +	if (ret < 0)
> +		return ret;
>  	if (ret & 0x80) {
> -		data->enable_dts = 1; //Enable DTS & PECI
> +		data->enable_dts = 1; /* Enable DTS & PECI */
>  	} else {
>  		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
> +		if (ret < 0)
> +			return ret;
>  		if (ret & 0x80)
> -			data->enable_dts = 0x3; //Enable DTS & TSI
> +			data->enable_dts = 0x3; /* Enable DTS & TSI */
>  	}
>  
>  	/* Check DTS enable status */
>  	if (data->enable_dts) {
> -		data->has_dts =
> -			nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
> -		if (data->enable_dts & 0x2) {
> -			data->has_dts |=
> -			(nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG) & 0xF)
> -								<< 4;
> +		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG);
> +		if (ret < 0)
> +			return ret;
> +		data->has_dts = ret & 0xF;
> +		if (data->enable_dts & ENABLE_TSI) {
> +			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
> +			if (ret < 0)
> +				return ret;
> +			data->has_dts |= (ret & 0xF) << 4;
>  		}
>  	}
>  
> -- 
> 2.17.1
> 
