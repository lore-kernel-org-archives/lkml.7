Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2CC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1432083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYlMGLg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfFUNKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:10:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51701 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFUNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:10:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so6298061wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zWWuR+34CKSqeHNm3DAPIfBogtgjv1yPdEZeTsKzETc=;
        b=sYlMGLg6ofrBMB6etYJLvDsNE5GKSrdcKhDZuMxtsWNYhzpHM6Uy+v9WkmTMKC9TuH
         1BgOvayYHCsQ3pSt95VOMUAD69bfUn5Hf0vJ44o+ofRUSzCZPeO+QfbDh5fPsROQ3HBo
         y5iBhArohMB4DGOLR+RH8I1mXpsm2L+hfGSQ+k1wx/vLYpq4o3U7snuZuSkGlinhlmDl
         z4cb29V1wDixND0F3ai2WMCO5MGx0E09t400/uCxSYi+U1rmXTdett8MgyCzGRNIwzkc
         mQuXyWXkFWeIpz3epAvNkd/D3gGUreOjHWwFCpIfilLjZ8TykTObi5CN5gmQIiUa8fw0
         YuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zWWuR+34CKSqeHNm3DAPIfBogtgjv1yPdEZeTsKzETc=;
        b=TE2cydrPhnsZcTEtbicynnHaEBfa3wJoND1YGJU33YFKS5WbifYGt49cnNpRq7KyhI
         pEyDE3eP3S5qPYNON9C6Rchx1aaATesNimlIUubzzNwCtjlX4s6Y1R1c/nSKokYy13s6
         K5a79xQZG6vQ/79BEvq2LmiemiCXE8WwL/nGSePi/t+goqGoDu0YWAoIauwuIieEDALW
         Ocj6kG4jbHocKj4tEMQ0uD8PZ2izAieK7ilakDyWG4ledY9hJRqK38Y1kWuvuUJPoFUt
         6HhCp+PpjTNNVm23zCV2NFSRi/jSvBloPaUfavKt5lPy0eI0x8OaxIB1ZWC6aR58YK1O
         u8tw==
X-Gm-Message-State: APjAAAUq9Oml6F5slC/AXzbMcQKUxU+t9YQClaIR3zPc7GyeiEfuAJbz
        xIbSYsH/jmthl6xIAUHNDpPW2A==
X-Google-Smtp-Source: APXvYqxugcFhasT6oqykCSfSXIx0XEa8A82CS0oO38cZlbubwFnhNoEfk4Ul2IhYgZbeXiAhzedHNg==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr3959660wmg.177.1561122621229;
        Fri, 21 Jun 2019 06:10:21 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id 5sm4910909wrc.76.2019.06.21.06.10.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:10:20 -0700 (PDT)
Subject: Re: [PATCH 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
To:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-5-mka@chromium.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <9ea1bb40-95a6-7a67-a8a6-ecc77a70e547@linaro.org>
Date:   Fri, 21 Jun 2019 14:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613194326.180889-5-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   drivers/video/backlight/pwm_bl.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index f067fe7aa35d..912407b6d67f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -404,6 +404,26 @@ int pwm_backlight_brightness_default(struct device *dev,
>   }
>   #endif
>   
> +static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
> +{
> +	unsigned int nlevels = data->max_brightness + 1;
> +	unsigned int min_val = data->levels[0];
> +	unsigned int max_val = data->levels[nlevels - 1];
> +	unsigned int slope = (100 * (max_val - min_val)) / nlevels;

Why 100 (rather than a power of 2)?

It would also be good to have a comment here saying what the maximum 
quantization error is. Doesn't have to be over complex just mentioning 
something like the following (assuming you agree that its true ;-) ):

   Multiplying by XXX means that even in pathalogical cases such as
   (max_val - min_val) == nlevels then the error at max_val is less than
   1%.

With a suitable comment in the fixed point code:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> +	unsigned int margin = (max_val - min_val) / 20; /* 5% */
> +	int i;
> +
> +	for (i = 1; i < nlevels; i++) {
> +		unsigned int linear_value = min_val + ((i * slope) / 100);
> +		unsigned int delta = abs(linear_value - data->levels[i]);
> +
> +		if (delta > margin)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>   {
>   	struct device_node *node = pb->dev->of_node;
> @@ -567,6 +587,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   			pb->levels = data->levels;
>   		}
> +
> +		if (pwm_backlight_is_linear(data))
> +			props.scale = BACKLIGHT_SCALE_LINEAR;
> +		else
> +			props.scale = BACKLIGHT_SCALE_NON_LINEAR;
>   	} else if (!data->max_brightness) {
>   		/*
>   		 * If no brightness levels are provided and max_brightness is
> 

