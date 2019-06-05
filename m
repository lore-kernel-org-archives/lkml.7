Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A715C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A45D2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oz62Fmi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFEUx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:53:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38849 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:53:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so10157839plb.5;
        Wed, 05 Jun 2019 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8N6Q41OiLcavLt+0q1xule6fZDeSNemkAiEUTe+VLU=;
        b=oz62Fmi7q6fXV+AdZQHLj6MqnTHxsNXPyJJo/z4m1353OWNU1OdFu0qOrot06pmoFj
         uj5jifiFiGcxP9bubch1QgmkdZY8S9/IVawQN9Rolt8ojng0ygKwUee+gGxsvD63H5y0
         dciYIYl4SarFMOJARtRj/rmNdeqvJu5wFnIpXy1l70Nqm7eBLsZKajePA/6ZLZ+uD0cO
         jvbZQCREKFU9uFoZSfadxhNaPYhQdiylX+SM0z8g74YrFB0O09Y9NsrGB3QUbOFHWZQX
         2qliRkWW14kbIaWijQI0y7LFfH4GXOIjj+N0CJ2ojCG1TdK2JRl3epv9E4BCe9RM1+r5
         74Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8N6Q41OiLcavLt+0q1xule6fZDeSNemkAiEUTe+VLU=;
        b=r818SmgcY1C5UKPmq+SN8VYG9FwXgOYNt1z2y42y3ua5vmd1t+et9YHg95p0HhdcTl
         NgqL9wtUvshy9/ZGSf4tizjNpapf/biY6M0Muj5aodxvqpJeUWaQqkmazyOdt3I7f+Dx
         f6vYQEwSAKkOZxuMywEjvebP5AxgQ2ya1JEYohjNQuIzZ8gbyRUCI9IdTul57ArwSG2T
         C7nmqYJbKMpVp7RzD80C+Cd2OsfU5xRi2hSacZv+/6upUR4Fdlwtah0TnWwHu2KYPd7e
         9Ei21zotUDTrSEpGjA4YNSV7LgepkJm2ClTB1fO9rSSghr7DkUV2HH+KZVGhk1pbKMkJ
         SJZw==
X-Gm-Message-State: APjAAAU275XAlszIyiUabxR0594CMcuXzuQqtVEDoR6udY9PwcyQAKe+
        14vs0dgY9DH2OsQEmfhcrSA=
X-Google-Smtp-Source: APXvYqz/No7Hs+aBNYPsXns2P18ky9I5q8MeYanNL5i5oJxPZ/HzmhVn/fp0FkHJ2h0P9QzM/jQuyA==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr45821288plf.246.1559768006885;
        Wed, 05 Jun 2019 13:53:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12sm33692528pgs.22.2019.06.05.13.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:53:26 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:53:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct7904) Fix the incorrect value of tcpu_mask in
 nct7904_data struct.
Message-ID: <20190605205325.GA340@roeck-us.net>
References: <20190531102048.28691-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531102048.28691-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:20:47AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Detect the multi-function of voltage, thermal diode and thermistor
> from register VT_ADC_MD_REG to set value of tcpu_mask in nct7904_data
> struct, set temp[1-5]_input the input values TEMP_CH1~4 and LTD of
> temperature. Set temp[6~13]_input the input values of DTS temperature
> that correspond to sensors TCPU1~8.
> 
Applied.

Thanks,
Guenter

> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---
>  drivers/hwmon/nct7904.c | 72 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 04516789b070..6a74df6841f0 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -4,6 +4,9 @@
>   * Copyright (c) 2015 Kontron
>   * Author: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
>   *
> + * Copyright (c) 2019 Advantech
> + * Author: Amy.Shih <amy.shih@advantech.com.tw>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -59,6 +62,8 @@
>  #define T_CPU1_HV_REG		0xA0	/* Bank 0; 2 regs (HV/LV) per sensor */
>  
>  #define PRTS_REG		0x03	/* Bank 2 */
> +#define PFE_REG			0x00	/* Bank 2; PECI Function Enable */
> +#define TSI_CTRL_REG		0x50	/* Bank 2; TSI Control Register */
>  #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
>  #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
>  
> @@ -74,6 +79,8 @@ struct nct7904_data {
>  	u32 vsen_mask;
>  	u32 tcpu_mask;
>  	u8 fan_mode[FANCTL_MAX];
> +	u8 enable_dts;
> +	u8 has_dts;
>  };
>  
>  /* Access functions */
> @@ -238,11 +245,15 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> -		if (channel == 0)
> +		if (channel == 4)
>  			ret = nct7904_read_reg16(data, BANK_0, LTD_HV_REG);
> +		else if (channel < 5)
> +			ret = nct7904_read_reg16(data, BANK_0,
> +						 TEMP_CH1_HV_REG + channel * 4);
>  		else
>  			ret = nct7904_read_reg16(data, BANK_0,
> -					T_CPU1_HV_REG + (channel - 1) * 2);
> +						 T_CPU1_HV_REG + (channel - 5)
> +						 * 2);
>  		if (ret < 0)
>  			return ret;
>  		temp = ((ret & 0xff00) >> 5) | (ret & 0x7);
> @@ -258,11 +269,11 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
>  	const struct nct7904_data *data = _data;
>  
>  	if (attr == hwmon_temp_input) {
> -		if (channel == 0) {
> -			if (data->vsen_mask & BIT(17))
> +		if (channel < 5) {
> +			if (data->tcpu_mask & BIT(channel))
>  				return 0444;
>  		} else {
> -			if (data->tcpu_mask & BIT(channel - 1))
> +			if (data->has_dts & BIT(channel - 5))
>  				return 0444;
>  		}
>  	}
> @@ -469,6 +480,7 @@ static int nct7904_probe(struct i2c_client *client,
>  	struct device *dev = &client->dev;
>  	int ret, i;
>  	u32 mask;
> +	u8 val, bit;
>  
>  	data = devm_kzalloc(dev, sizeof(struct nct7904_data), GFP_KERNEL);
>  	if (!data)
> @@ -502,10 +514,52 @@ static int nct7904_probe(struct i2c_client *client,
>  	data->vsen_mask = mask;
>  
>  	/* CPU_TEMP attributes */
> -	ret = nct7904_read_reg16(data, BANK_0, DTS_T_CTRL0_REG);
> -	if (ret < 0)
> -		return ret;
> -	data->tcpu_mask = ((ret >> 8) & 0xf) | ((ret & 0xf) << 4);
> +	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
> +
> +	if ((ret & 0x6) == 0x6)
> +		data->tcpu_mask |= 1; /* TR1 */
> +	if ((ret & 0x18) == 0x18)
> +		data->tcpu_mask |= 2; /* TR2 */
> +	if ((ret & 0x20) == 0x20)
> +		data->tcpu_mask |= 4; /* TR3 */
> +	if ((ret & 0x80) == 0x80)
> +		data->tcpu_mask |= 8; /* TR4 */
> +
> +	/* LTD */
> +	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
> +	if ((ret & 0x02) == 0x02)
> +		data->tcpu_mask |= 0x10;
> +
> +	/* Multi-Function detecting for Volt and TR/TD */
> +	ret = nct7904_read_reg(data, BANK_0, VT_ADC_MD_REG);
> +
> +	for (i = 0; i < 4; i++) {
> +		val = (ret & (0x03 << i)) >> (i * 2);
> +		bit = (1 << i);
> +		if (val == 0)
> +			data->tcpu_mask &= ~bit;
> +	}
> +
> +	/* PECI */
> +	ret = nct7904_read_reg(data, BANK_2, PFE_REG);
> +	if (ret & 0x80) {
> +		data->enable_dts = 1; //Enable DTS & PECI
> +	} else {
> +		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
> +		if (ret & 0x80)
> +			data->enable_dts = 0x3; //Enable DTS & TSI
> +	}
> +
> +	/* Check DTS enable status */
> +	if (data->enable_dts) {
> +		data->has_dts =
> +			nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
> +		if (data->enable_dts & 0x2) {
> +			data->has_dts |=
> +			(nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG) & 0xF)
> +								<< 4;
> +		}
> +	}
>  
>  	for (i = 0; i < FANCTL_MAX; i++) {
>  		ret = nct7904_read_reg(data, BANK_3, FANCTL1_FMR_REG + i);
