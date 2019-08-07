Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA1C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58421743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz73yeuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfHGEwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 00:52:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43223 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHGEwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 00:52:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so31781277pld.10;
        Tue, 06 Aug 2019 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5hiSqGX7w637MnPROSqcsxYTrzSfRBDlHqDSSozO8E=;
        b=Dz73yeuj/p4j8KDE7fvSAnQRmntAfHXmNnHRfvoXCbYpbuNRlnJqNwQZWZBUbff+Zj
         xWKHkvFvfCv+iAIRmCGyzNYGvr9p6+IOu2atXcq6QKWwpNYyeQV6zAfFqli3cGTbz4Ek
         DKyXRJf6xo5SbghE8iMOtg3QnLACJYWPVVdPxFZrn5tgSsyjO76ksLKuLkFff972vQyj
         GbgCrLcmJNqSeYtTQXFwnD90Jf/PLjtTQ96znnI168bd6I+D+zTA4UBMAqh63tqEHbOp
         0utUg8YrDPpjQpgnzxcs4pxih4OrhjvBewQ8ADUBNGxxJQ04eHzNcPea8w578WWWpru8
         f3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5hiSqGX7w637MnPROSqcsxYTrzSfRBDlHqDSSozO8E=;
        b=dIX/eEOhSKQmbBGKmfrlpGknR3Sozf+dAGMCSP/bkVuRyd3rAV4cNAw8GUeOAK51VF
         vgBkC+tYDkX8CNcdWPeAlAkz5VxqnYZ74AFwK0n+veibwqmecinNg/klj78MKTcn+VaF
         UGbLoAZjd77pMhWLQqel4pNgaTJUJuMcuKouxrHIQvZSEAkkPnqN9/VFWcYDC3/cwZKI
         GqNUlRYt0gT+5muUpbkSzyp+lnIfjkquV7STXhDzRoYRBH6N2s6Goevt7u1ssDmfv7w5
         9jYj9DgxVpkDvyqKvXZl9SdUTUpYTgXpXhJUuive/3Cjz0NK8BjWlgpJtQvdlpyd5Tii
         Ibyg==
X-Gm-Message-State: APjAAAW1B55xDoApQw0Mq+cKP5Bglz6euNfSvkAvpCbFgeBumKgaCj3f
        axuiIKS5i4vTGFK7/MBb6Hh6ogpo
X-Google-Smtp-Source: APXvYqzupl8dQwaX7+cwVjbaZsQ4AWKyQ9LWSRzkLhI6xeMlpRTJ+wfnbGe4a4akZ2a9trJ67Gsstg==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr6563013plb.145.1565153540364;
        Tue, 06 Aug 2019 21:52:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23sm92429478pfn.140.2019.08.06.21.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 21:52:19 -0700 (PDT)
Subject: Re: [v5,1/1] hwmon: (nct7904) Add extra sysfs support for fan,
 voltage and temperature.
To:     Amy.Shih@advantech.com.tw, she90122@gmail.com
Cc:     oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190807013842.24451-1-Amy.Shih@advantech.com.tw>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <268ba418-e7ab-9f50-d8ce-0a5c258edc1c@roeck-us.net>
Date:   Tue, 6 Aug 2019 21:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807013842.24451-1-Amy.Shih@advantech.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 6:38 PM, Amy.Shih@advantech.com.tw wrote:
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
> -temp[1-*]_emergency
> -temp[1-*]_emergency_hyst
> -temp[1-*]_alarm
> -temp[1-*]_type
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Changes in v5:
> - Squashed subsequent fixes of three patches into one patch.
> Changes in v4:
> - Fix the incorrect return value of case hwmon_fan_min in function "nct7904_write_fan".
> - Fix the confused calculation of case hwmon_fan_min in function
> Changes in v3:
> - Squashed subsequent fixes of patches into one patch.
> 
> -- Fix bad fallthrough in various switch statements.
> -- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
> -- Fix incorrect register setting of voltage.
> -- Fix incorrect register bit mapping of temperature alarm.
> -- Fix wrong return code 0x1fff in function nct7904_write_fan.
> -- Delete wrong comment in function nct7904_write_in.
> -- Fix wrong attribute names for temperature.
> -- Fix wrong registers setting for temperature.
> 
> Changes in v2:
> - Fix bad fallthrough in various switch statements.
> - Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
> ---
>   drivers/hwmon/nct7904.c | 469 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 424 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 710c30562fc1..76372f20d71a 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -46,10 +46,33 @@
>   #define DTS_T_CTRL1_REG		0x27
>   #define VT_ADC_MD_REG		0x2E
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
>   #define VSEN1_HV_REG		0x40	/* Bank 0; 2 regs (HV/LV) per sensor */
>   #define TEMP_CH1_HV_REG		0x42	/* Bank 0; same as VSEN2_HV */
>   #define LTD_HV_REG		0x62	/* Bank 0; 2 regs in VSEN range */
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
>   #define FANIN1_HV_REG		0x80	/* Bank 0; 2 regs (HV/LV) per sensor */
> +#define FANIN1_HV_HL_REG	0x60	/* Bank 1; 2 regs (HV/LV) per sensor */
> +#define FANIN1_LV_HL_REG	0x61	/* Bank 1; 2 regs (HV/LV) per sensor */
>   #define T_CPU1_HV_REG		0xA0	/* Bank 0; 2 regs (HV/LV) per sensor */
>   
>   #define PRTS_REG		0x03	/* Bank 2 */
> @@ -58,6 +81,8 @@
>   #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
>   #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
>   
> +#define ENABLE_TSI	BIT(1)
> +
>   static const unsigned short normal_i2c[] = {
>   	0x2d, 0x2e, I2C_CLIENT_END
>   };
> @@ -72,6 +97,7 @@ struct nct7904_data {
>   	u8 fan_mode[FANCTL_MAX];
>   	u8 enable_dts;
>   	u8 has_dts;
> +	u8 temp_mode; /* 0: TR mode, 1: TD mode */
>   };
>   
>   /* Access functions */
> @@ -170,6 +196,25 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
>   			rpm = 1350000 / cnt;
>   		*val = rpm;
>   		return 0;
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
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -179,8 +224,20 @@ static umode_t nct7904_fan_is_visible(const void *_data, u32 attr, int channel)
>   {
>   	const struct nct7904_data *data = _data;
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
>   	return 0;
>   }
>   
> @@ -211,6 +268,37 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
>   			volt *= 6; /* 0.006V scale */
>   		*val = volt;
>   		return 0;
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
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -221,9 +309,20 @@ static umode_t nct7904_in_is_visible(const void *_data, u32 attr, int channel)
>   	const struct nct7904_data *data = _data;
>   	int index = nct7904_chan_to_index[channel];
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
>   	return 0;
>   }
> @@ -233,6 +332,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>   {
>   	struct nct7904_data *data = dev_get_drvdata(dev);
>   	int ret, temp;
> +	unsigned int reg1, reg2, reg3;
>   
>   	switch (attr) {
>   	case hwmon_temp_input:
> @@ -250,16 +350,100 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>   		temp = ((ret & 0xff00) >> 5) | (ret & 0x7);
>   		*val = sign_extend32(temp, 10) * 125;
>   		return 0;
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
> +		reg2 = TEMP_CH1_W_REG;
> +		reg3 = DTS_T_CPU1_W_REG;
> +		break;
> +	case hwmon_temp_max_hyst:
> +		reg1 = LTD_LV_HL_REG;
> +		reg2 = TEMP_CH1_WH_REG;
> +		reg3 = DTS_T_CPU1_WH_REG;
> +		break;
> +	case hwmon_temp_crit:
> +		reg1 = LTD_HV_LL_REG;
> +		reg2 = TEMP_CH1_C_REG;
> +		reg3 = DTS_T_CPU1_C_REG;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg1 = LTD_LV_LL_REG;
> +		reg2 = TEMP_CH1_CH_REG;
> +		reg3 = DTS_T_CPU1_CH_REG;
> +		break;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
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
>   }
>   
>   static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>   {
>   	const struct nct7904_data *data = _data;
>   
> -	if (attr == hwmon_temp_input) {
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_alarm:
> +	case hwmon_temp_type:
>   		if (channel < 5) {
>   			if (data->tcpu_mask & BIT(channel))
>   				return 0444;
> @@ -267,6 +451,21 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>   			if (data->has_dts & BIT(channel - 5))
>   				return 0444;
>   		}
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
>   	}
>   
>   	return 0;
> @@ -297,6 +496,137 @@ static int nct7904_read_pwm(struct device *dev, u32 attr, int channel,
>   	}
>   }
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
> +		reg2 = TEMP_CH1_W_REG;
> +		reg3 = DTS_T_CPU1_W_REG;
> +		break;
> +	case hwmon_temp_max_hyst:
> +		reg1 = LTD_LV_HL_REG;
> +		reg2 = TEMP_CH1_WH_REG;
> +		reg3 = DTS_T_CPU1_WH_REG;
> +		break;
> +	case hwmon_temp_crit:
> +		reg1 = LTD_HV_LL_REG;
> +		reg2 = TEMP_CH1_C_REG;
> +		reg3 = DTS_T_CPU1_C_REG;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg1 = LTD_LV_LL_REG;
> +		reg2 = TEMP_CH1_CH_REG;
> +		reg3 = DTS_T_CPU1_CH_REG;
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
> +			return -EINVAL;
> +
> +		val = clamp_val(DIV_ROUND_CLOSEST(1350000, val), 1, 0x1fff);
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
> +	val = clamp_val(val, 0, 0x7ff);
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
>   static int nct7904_write_pwm(struct device *dev, u32 attr, int channel,
>   			     long val)
>   {
> @@ -354,8 +684,14 @@ static int nct7904_write(struct device *dev, enum hwmon_sensor_types type,
>   			 u32 attr, int channel, long val)
>   {
>   	switch (type) {
> +	case hwmon_in:
> +		return nct7904_write_in(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return nct7904_write_fan(dev, attr, channel, val);
>   	case hwmon_pwm:
>   		return nct7904_write_pwm(dev, attr, channel, val);
> +	case hwmon_temp:
> +		return nct7904_write_temp(dev, attr, channel, val);
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -404,51 +740,91 @@ static int nct7904_detect(struct i2c_client *client,
>   
>   static const struct hwmon_channel_info *nct7904_info[] = {
>   	HWMON_CHANNEL_INFO(in,
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
>   	HWMON_CHANNEL_INFO(fan,
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
>   	HWMON_CHANNEL_INFO(pwm,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>   	HWMON_CHANNEL_INFO(temp,
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
>   	NULL
>   };
>   
> @@ -530,11 +906,14 @@ static int nct7904_probe(struct i2c_client *client,
>   	if (ret < 0)
>   		return ret;
>   
> +	data->temp_mode = 0;
>   	for (i = 0; i < 4; i++) {
>   		val = (ret & (0x03 << i)) >> (i * 2);
>   		bit = (1 << i);
>   		if (val == 0)
>   			data->tcpu_mask &= ~bit;
> +		else if (val == 0x1 || val == 0x2)
> +			data->temp_mode |= bit;
>   	}
>   
>   	/* PECI */
> @@ -557,7 +936,7 @@ static int nct7904_probe(struct i2c_client *client,
>   		if (ret < 0)
>   			return ret;
>   		data->has_dts = ret & 0xF;
> -		if (data->enable_dts & 0x2) {
> +		if (data->enable_dts & ENABLE_TSI) {
>   			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
>   			if (ret < 0)
>   				return ret;
> 

