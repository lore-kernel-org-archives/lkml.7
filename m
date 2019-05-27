Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1511C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F720673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dI7oZX8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfE0M1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:27:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51625 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfE0M1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:27:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so8550363wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e8kvGLomISBrOHS2epUFWGzVK/nHlgPtiicRmKEX4zk=;
        b=dI7oZX8bxri0JjfXRlxa/24LwUtiAhLzaomz+NfhAqGCFhwGWbnCLOu/TkG+bPJ6o7
         jDgEwkXVQwm+7VzuT90veusMypSgrAxMQzc8H2cQzVW/U1U9tOkGHiR5uyl05fB8ai35
         YT3EKGQpzfcC6N8EQyuNzy8iXlgae+KdZa4jHDXoJ7OfEpWiCTW+bvsZZIE1o8hyFgd9
         Rq94Rl2SfT76vUUs8ZMzW1NuCz27szKZuXtkfhlSEviNeTWPB1NWlPo4iUNBKhYGrpa/
         VIapsQMejyQCtynJbFWzeLFPU7owmQTHP3tWL8CIJEbF9MqDx02JNaODHQfrPmy7F4hO
         gV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e8kvGLomISBrOHS2epUFWGzVK/nHlgPtiicRmKEX4zk=;
        b=UnMCpxRuoRf1J2MImLiPG+jTTYZl2a0KT7vYiJxVYzTCqAHg1YK6cGifJekNyaEpeL
         HSxCFXG3kyrwqNuXu387XSfwzUTYL+8BHUboMFHPEySiQgVv7+vyTN+5bKw+Yh/9+Vbo
         VJoEIeF2TXyTZ2lzOZ29PkW3zF84ZDFUaR5WqndY4cTT/Jkp3MknJ/iiuSPX9DCpDjSa
         CTck4l9PuhKelL+qFyphFQ+4g6yOZqrdM+CDg75nhNsRtNOMYuxtGL5BjFH/uciMzw0s
         O9lwrmIM0/cSghfs+ESSKZzWk38U3ygUxuUNvoHw6UD87bbaQ+qp/vH8lfKn1TMWKJZI
         4DVA==
X-Gm-Message-State: APjAAAWsj/hKf/QE4MeWNvG0CWr9FlRJE+CoQYQkrrdCZ4nYEOIzQqsX
        CJPEdBNLF5IEPvEmUkY0BeLxPQ==
X-Google-Smtp-Source: APXvYqysOlAecsXBUAJJtbWePsKMksj6XBZ7EaWzsQNKrfq/v1VRK+f8LLilBpGoB1pGJ2m2yYLY/w==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr9206755wmi.18.1558960023688;
        Mon, 27 May 2019 05:27:03 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h6sm9405270wrm.47.2019.05.27.05.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:27:03 -0700 (PDT)
Subject: Re: [PATCH 06/14] pwm: meson: pass struct pwm_device to
 meson_pwm_calc()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-7-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <9d0d7be1-af52-a7db-79ec-3b17b3190897@baylibre.com>
Date:   Mon, 27 May 2019 14:27:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525181133.4875-7-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> meson_pwm_calc() is the last function that accepts a struct
> meson_pwm_channel. meson_pwm_enable(), meson_pwm_disable() and
> meson_pwm_apply() for example are all taking a struct pwm_device as
> parameter. When they need the struct meson_pwm_channel these functions
> simply call pwm_get_chip_data() internally.
> 
> Make meson_pwm_calc() consistent with the other functions in the
> meson-pwm driver by passing struct pwm_device to it as well. The value
> of the "id" parameter is actually pwm->hwpwm, but the driver never read
> the "id" parameter, which is why there's no replacement for it in the
> new code.
> 
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 39ea119add7b..d6eb4d04d5c9 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -114,10 +114,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  		clk_disable_unprepare(channel->clk);
>  }
>  
> -static int meson_pwm_calc(struct meson_pwm *meson,
> -			  struct meson_pwm_channel *channel,
> +static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  			  struct pwm_state *state)
>  {
> +	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq = -1;
>  	u64 fin_ps;
> @@ -280,7 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->period != channel->state.period ||
>  	    state->duty_cycle != channel->state.duty_cycle ||
>  	    state->polarity != channel->state.polarity) {
> -		err = meson_pwm_calc(meson, channel, state);
> +		err = meson_pwm_calc(meson, pwm, state);
>  		if (err < 0)
>  			return err;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
