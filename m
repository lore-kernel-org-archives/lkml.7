Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73529C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D72067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/tyJLft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFEUxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:53:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36924 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:53:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so49246pff.4;
        Wed, 05 Jun 2019 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uTQaK72Ucpyy9f0pgMv8AGV40mI5ohsiXRE9XtKqUc=;
        b=t/tyJLftXYoCRugTW3KDzXOX2ZQhjiE6IXeF0t5unvQdfPzvFen878nclX7wKBmtz7
         PFdXOcui/A36psokoh+f3Lwqw00/gXE6JMT6R03V8uCKFe/GWUzJCWHKoVlTAayHKr4s
         9ax8io5/XpFMo0KMLu15VGUk+110B60XA/GjuZy2vwWQq6emEmnSFn8A+Yd2tifZbjUe
         MyVROtM4Fx5DGOB+GXuLdeZ0MCStxkeXt8dqod8xRkviVx3D0A27uPJz3wdN0OIUoR7q
         D4pbXOEp/wNW5qf0oDmxekolt0XQZZx1+DiKpKkw/llE7UErCujP2wZywcXX/0Q/S8Hr
         E+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uTQaK72Ucpyy9f0pgMv8AGV40mI5ohsiXRE9XtKqUc=;
        b=Ns8z7BhZMJNoCzmL3frRMHZTDNPtZDzF0twIH2FfPzH5tqyyUsnycnbaj3sFot6F1O
         bW7lPA1b8tYIWIhoaJNX5pqV0ou6ZuTYAC2sYjDiSfWXcCOAg/n2E6qz6zJ/liwEULAw
         IufmjXu8ba7Ze06SkzkKvnq9joVBdBMO1Gz1gQ3X/cHIS2D0aYygybvMX7XtRJs3/h/e
         +SFxS0wyGz6zy+qNvrCnCabCSOl+yslm0Y23MdIWJdP9LuLuG7hYaqTI0k+4AoMpyi0x
         RZyzhn1JL6JTJMveLFyKctxEXM2+3+nJ2HTdc02NAUEnkUmqCuyp6dZg9GCWmByqBHSS
         aTvg==
X-Gm-Message-State: APjAAAW7lsVm/87JJZykohM9NQLEMSDx8GTXPrKeA+jNLaH/ycLo5WMd
        LC1EqpHtRnoFKZ81qo6RyiY=
X-Google-Smtp-Source: APXvYqwKGih6a3m971uHNFmU9pFnYvUtv3yyGqWh3SY8WJKJdQ2xspu+QBkBsh+W1wmv5054Kx9K1Q==
X-Received: by 2002:a63:a056:: with SMTP id u22mr929758pgn.318.1559768023900;
        Wed, 05 Jun 2019 13:53:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h62sm20762071pgc.77.2019.06.05.13.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:53:43 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:53:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct7904) Add extra sysfs support for fan,
 voltage and temperature.
Message-ID: <20190605205342.GA366@roeck-us.net>
References: <20190531102255.28740-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531102255.28740-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:22:54AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> This patch do 2 jobs as described in below:
> 
> 1. NCT-7904D also supports reading of channel limitation registers
> and SMI status registers for fan, voltage and temperature monitoring,
> add below sysfs nodes:
> 
> -fan[1-*]_min
> -fan[1-*]_alarm
> -in[0-*]_min
> -in[0-*]_max
> -in[0-*]_alarm
> -temp[1-*]_max
> -temp[1-*]_max_hyst
> -temp[1-*]_emergency
> -temp[1-*]_emergency_hyst
> -temp[1-*]_alarm
> 
> 2. Add the temp[1-*]_type sysfs to show type of temperature sensor is
> thermal diode, thermistor, AMD SB-TSI or Intel PECI.
> 

Applied.

Thanks,
Guenter

> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---
>  drivers/hwmon/nct7904.c | 492 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 440 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 6a74df6841f0..91d1eb822707 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -55,10 +55,33 @@
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
> @@ -67,6 +90,8 @@
>  #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
>  #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
>  
> +#define ENABLE_TSI	BIT(1)
> +
>  static const unsigned short normal_i2c[] = {
>  	0x2d, 0x2e, I2C_CLIENT_END
>  };
> @@ -81,6 +106,7 @@ struct nct7904_data {
>  	u8 fan_mode[FANCTL_MAX];
>  	u8 enable_dts;
>  	u8 has_dts;
> +	u8 temp_mode; /* 0: TR mode, 1: TD mode */
>  };
>  
>  /* Access functions */
> @@ -179,6 +205,25 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
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
> @@ -188,8 +233,18 @@ static umode_t nct7904_fan_is_visible(const void *_data, u32 attr, int channel)
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
> +	case hwmon_fan_min:
> +		if (data->fanin_mask & (1 << channel))
> +			return 0644;
> +	default:
> +		break;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -220,6 +275,37 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
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
> @@ -230,9 +316,18 @@ static umode_t nct7904_in_is_visible(const void *_data, u32 attr, int channel)
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
> +	case hwmon_in_min:
> +	case hwmon_in_max:
> +		if (channel > 0 && (data->vsen_mask & BIT(index)))
> +			return 0644;
> +	default:
> +		break;
> +	}
>  
>  	return 0;
>  }
> @@ -242,6 +337,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  {
>  	struct nct7904_data *data = dev_get_drvdata(dev);
>  	int ret, temp;
> +	unsigned int reg1, reg2, reg3;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> @@ -259,16 +355,100 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  		temp = ((ret & 0xff00) >> 5) | (ret & 0x7);
>  		*val = sign_extend32(temp, 10) * 125;
>  		return 0;
> +	case hwmon_temp_alarm:
> +		if (channel < 5) {
> +			ret = nct7904_read_reg(data, BANK_0,
> +					       SMI_STS1_REG);
> +			if (ret < 0)
> +				return ret;
> +			*val = (ret >> (channel & 0x07)) & 1;
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
> +	case hwmon_temp_emergency:
> +		reg1 = LTD_HV_LL_REG;
> +		reg2 = TEMP_CH1_W_REG;
> +		reg3 = DTS_T_CPU1_W_REG;
> +		break;
> +	case hwmon_temp_emergency_hyst:
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
> @@ -276,6 +456,19 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>  			if (data->has_dts & BIT(channel - 5))
>  				return 0444;
>  		}
> +	case hwmon_temp_max:
> +	case hwmon_temp_max_hyst:
> +	case hwmon_temp_emergency:
> +	case hwmon_temp_emergency_hyst:
> +		if (channel < 5) {
> +			if (data->tcpu_mask & BIT(channel))
> +				return 0644;
> +		} else {
> +			if (data->has_dts & BIT(channel - 5))
> +				return 0644;
> +		}
> +	default:
> +		break;
>  	}
>  
>  	return 0;
> @@ -306,6 +499,139 @@ static int nct7904_read_pwm(struct device *dev, u32 attr, int channel,
>  	}
>  }
>  
> +static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
> +			      long val)
> +{
> +	struct nct7904_data *data = dev_get_drvdata(dev);
> +	int ret, index;
> +	unsigned int reg1, reg2, reg3;
> +
> +	index = nct7904_chan_to_index[channel];
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
> +	case hwmon_temp_emergency:
> +		reg1 = LTD_HV_LL_REG;
> +		reg2 = TEMP_CH1_W_REG;
> +		reg3 = DTS_T_CPU1_W_REG;
> +		break;
> +	case hwmon_temp_emergency_hyst:
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
> +	int ret, index;
> +	u8 tmp;
> +
> +	index = nct7904_chan_to_index[channel];
> +
> +	if (index < 14)
> +		val = val / 2; /* 0.002V scale */
> +	else
> +		val = val / 6; /* 0.006V scale */
> +
> +	val = clamp_val(val, 0, 0x7ff); /* Bit 15 is sign bit */
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
> +				       VSEN1_HV_LL_REG + index * 4);
> +		if (tmp < 0)
> +			return tmp;
> +		tmp = (val >> 3) & 0xff;
> +		ret = nct7904_write_reg(data, BANK_1,
> +					VSEN1_HV_LL_REG + index * 4, tmp);
> +		return ret;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static int nct7904_write_pwm(struct device *dev, u32 attr, int channel,
>  			     long val)
>  {
> @@ -363,8 +689,14 @@ static int nct7904_write(struct device *dev, enum hwmon_sensor_types type,
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
> @@ -413,51 +745,91 @@ static int nct7904_detect(struct i2c_client *client,
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
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_HYST),
>  	NULL
>  };
>  
> @@ -515,6 +887,8 @@ static int nct7904_probe(struct i2c_client *client,
>  
>  	/* CPU_TEMP attributes */
>  	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
> +	if (ret < 0)
> +		return ret;
>  
>  	if ((ret & 0x6) == 0x6)
>  		data->tcpu_mask |= 1; /* TR1 */
> @@ -527,37 +901,51 @@ static int nct7904_probe(struct i2c_client *client,
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
> +		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
> +		if (ret < 0)
> +			return ret;
> +		data->has_dts = ret;
> +		if (data->enable_dts & ENABLE_TSI) {
> +			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
> +			if (ret < 0)
> +				return ret;
> +			data->has_dts |= (ret & 0xF) << 4;
>  		}
>  	}
>  
