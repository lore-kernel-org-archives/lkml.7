Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E5ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4772067B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJRFjd5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfJ0XDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:03:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfJ0XDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 19:03:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id f19so5340634pgn.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5NCQBLblr+3VzRKWt+r2uKZg0GiljuRiUpnaZ3zSTTc=;
        b=IJRFjd5+3Q2MarXErPyr+smXeeYtKmVnuCMl0pZUsYWXLEiO+DY7flHvEEhKW4ElBg
         homw33IjEzdlp7bDazMU//a271eISLJYTmPrz90ruofkxQ2lscQT4ovmyOvwsyO7zTEO
         QQe8Y9t9/4tXr5ujOvlxrUnE0Fisn+h4+y1bACTAmISo9Fhc2UpBec6GnVJZGOoAu2Z4
         oP1VB10QNgaPM3+dAPVqYoh6eAfu7kfM6vFDKN7qrEBEX/49FeDdBZhTvH1c089dv/95
         2Z9PF6udW46rcL7TAD+ShT8+kqUMOFtb0m7vBsJcXGdCXDoB9c9ZKeHtt3znJUCZYsbG
         pYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NCQBLblr+3VzRKWt+r2uKZg0GiljuRiUpnaZ3zSTTc=;
        b=cKDCxH+yY6cY5l7KAeILuf1H4L6bxeau5Fj5Nx43S5bgvgC+Hz1qHNw++PzVAOfg+F
         RoLQxmYBlI2eaV9F04Nxx2+6TDAMj2F6XPmwsG2wnP6PhmTe3Hq2xOKMWH7WN2xn10ll
         m5fVsL/9OKueyHkV9ogXTgdBB1kWXLaFbilENvAxlTtpbYs6twDmgm1FERKhfxtXV7g6
         h29RGtcBKcvLDo1NpewfvifllDJTfeQ3pdOYX5rCKfpEt9g/nkNDpfEVALNsJ9+UkPxl
         oND6eK4hukAHIf0905GkgDaorGBsq82a4TR0eKUbRF2EE3N/UCxvSdIWjUgldL70cuWA
         ciGw==
X-Gm-Message-State: APjAAAV4czp4uOx6/uLGAGBpRNEvrahYbsV49Mbs3VFQrVoay6acgGEV
        eyoUd3E/1Wy/rYNozSga0m8WBAiI
X-Google-Smtp-Source: APXvYqzWWdejYXFXSoerLcQixmyTyuS9NMY5dq6lOw9KshpsLABjkdCo9VR84Nb0iyUsaZ6LbsBDfQ==
X-Received: by 2002:a63:1f48:: with SMTP id q8mr17884892pgm.215.1572217421403;
        Sun, 27 Oct 2019 16:03:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7sm9131045pfa.150.2019.10.27.16.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:03:40 -0700 (PDT)
Subject: Re: [PATCH] lm75: add lm75b detection
To:     Rain Wang <Rain_Wang@Jabil.com>, Jean Delvare <jdelvare@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191026081049.GA16839@rainw-fedora28-jabil.corp.JABIL.ORG>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7a2ddf42-8bbe-59e0-dae8-85b184ea0da0@roeck-us.net>
Date:   Sun, 27 Oct 2019 16:03:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191026081049.GA16839@rainw-fedora28-jabil.corp.JABIL.ORG>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/19 1:10 AM, Rain Wang wrote:
> The National Semiconductor LM75B is very similar as the
> LM75A, but it has no ID byte register 7, and unused registers
> return 0xff rather than the last read value like LM75A.
> 
> Signed-off-by: Rain Wang <rain_wang@jabil.com>

I am quite hesitant to touch the detect function for this chip.
Each addition increases the risk for false positives. What is the
use case ?

Thanks,
Guenter

> ---
>   drivers/hwmon/lm75.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 5e6392294c03..a718f9eb4d72 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -760,6 +760,7 @@ static int lm75_detect(struct i2c_client *new_client,
>   	int i;
>   	int conf, hyst, os;
>   	bool is_lm75a = 0;
> +	bool is_lm75b = 0;
>   
>   	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>   				     I2C_FUNC_SMBUS_WORD_DATA))
> @@ -780,8 +781,12 @@ static int lm75_detect(struct i2c_client *new_client,
>   	 * register 7, and unused registers return 0xff rather than the
>   	 * last read value.
>   	 *
> +	 * The National Semiconductor LM75B is very similar as the
> +	 * LM75A, but it has no ID byte register 7, and unused registers
> +	 * return 0xff rather than the last read value like LM75A.
> +	 *
>   	 * Note that this function only detects the original National
> -	 * Semiconductor LM75 and the LM75A. Clones from other vendors
> +	 * Semiconductor LM75 and the LM75A/B. Clones from other vendors
>   	 * aren't detected, on purpose, because they are typically never
>   	 * found on PC hardware. They are found on embedded designs where
>   	 * they can be instantiated explicitly so detection is not needed.
> @@ -806,6 +811,13 @@ static int lm75_detect(struct i2c_client *new_client,
>   		is_lm75a = 1;
>   		hyst = i2c_smbus_read_byte_data(new_client, 2);
>   		os = i2c_smbus_read_byte_data(new_client, 3);
> +	} else if (i2c_smbus_read_byte_data(new_client, 4) == 0xff
> +		 && i2c_smbus_read_byte_data(new_client, 5) == 0xff
> +		 && i2c_smbus_read_byte_data(new_client, 6) == 0xff) {
> +		/* LM75B detection */
> +		is_lm75b = 1;
> +		hyst = i2c_smbus_read_byte_data(new_client, 2);
> +		os = i2c_smbus_read_byte_data(new_client, 3);
>   	} else { /* Traditional style LM75 detection */
>   		/* Unused addresses */
>   		hyst = i2c_smbus_read_byte_data(new_client, 2);
> @@ -839,7 +851,8 @@ static int lm75_detect(struct i2c_client *new_client,
>   			return -ENODEV;
>   	}
>   
> -	strlcpy(info->type, is_lm75a ? "lm75a" : "lm75", I2C_NAME_SIZE);
> +	strlcpy(info->type, is_lm75a ?
> +		"lm75a" : (is_lm75b ? "lm75b" : "lm75"), I2C_NAME_SIZE);
>   
>   	return 0;
>   }
> 

