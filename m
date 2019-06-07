Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BEC20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFxvdk65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfFGWTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:19:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35110 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfFGWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:19:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so1938036pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8iuPUmxzg7rQ1mcChA8EFOd7sUTB/HD7Cy4zNZiOnqU=;
        b=CFxvdk65xd7tcdZzJVz4UpmWkpj2H0DyBEP+rSqqcdcBPMPUXaHAK2yMfBeGuEzfcK
         stk+FYrZRrEUIFuksmoi9O52OT8AevaATD57kkw1chD3TO3mDhDjM1uOuEasaWq/K+ci
         sfAVNw3mZCK0NZ8i3/luNQ/qVucJTF0GbUfTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8iuPUmxzg7rQ1mcChA8EFOd7sUTB/HD7Cy4zNZiOnqU=;
        b=BGcl73cZHKH/2zkjKbsA77nWjqUZpXfgRad/fvGIACqGdZ9So9C/cMlpXTHpfS3Cwx
         HLmkSgsx6mKaLAenuRwDQsfrEcmTosXJjjSdJP8qTaVmpmVM/aFeMU+lT6eydyUWAfmd
         skNQFGGZxCqZ0z/c5pr+16b1RqqhHocW0v+vGw+rNH8SEd4WEj8LEssILDU3KdHQMmOF
         6E+qIwz2bjj1u7bDOuQ26oRuSsZ0CkXNWzFrSaahfhkKoLfVrRCu+url4FqqC8VD9ylO
         14/Vmp1yxm2IHAdgG6AVz7mvaeJEfBr0IT6TYy+xH9k/Q59Fl8ntiGW4HYJqsxinnFOD
         LfJA==
X-Gm-Message-State: APjAAAX4cGD2PDqxW+25ICZZVstoHAcnQqJwgs8AUXOr+KifD280d5e3
        t0r2/LB01K1zZqgUAzQZaf7LHg==
X-Google-Smtp-Source: APXvYqz2x5Lf3XLwNWkRmjImZUEqpXEjYipatdtaIyzpqULgmQhr7hnhIYl70ZYH3co6M3PTWxBmjw==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr7940880pji.126.1559945989250;
        Fri, 07 Jun 2019 15:19:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g17sm3474771pfb.56.2019.06.07.15.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:19:48 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:19:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED
 linearly to human eye.
Message-ID: <20190607220947.GR40515@google.com>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208113032.27810-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

some comments inline, a bit late, but I just tested this on veyron
minnie.

On Thu, Feb 08, 2018 at 12:30:31PM +0100, Enric Balletbo i Serra wrote:
> When you want to change the brightness using a PWM signal, one thing you
> need to consider is how human perceive the brightness. Human perceive
> the brightness change non-linearly, we have better sensitivity at low
> luminance than high luminance, so to achieve perceived linear dimming,
> the brightness must be matches to the way our eyes behave. The CIE 1931
> lightness formula is what actually describes how we perceive light.
> 
> This patch computes a default table with the brightness levels filled
> with the numbers provided by the CIE 1931 algorithm, the number of the
> brightness levels is calculated based on the PWM resolution.
> 
> The calculation of the table using the CIE 1931 algorithm is enabled by
> default when you do not define the 'brightness-levels' propriety in your
> device tree.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> ...
>
> +static
> +int pwm_backlight_brightness_default(struct device *dev,
> +				     struct platform_pwm_backlight_data *data,
> +				     unsigned int period)
> +{
> +	unsigned int counter = 0;
> +	unsigned int i, n;
> +	u64 retval;
> +
> +	/*
> +	 * Count the number of bits needed to represent the period number. The
> +	 * number of bits is used to calculate the number of levels used for the
> +	 * brightness-levels table, the purpose of this calculation is have a
> +	 * pre-computed table with enough levels to get linear brightness
> +	 * perception. The period is divided by the number of bits so for a
> +	 * 8-bit PWM we have 255 / 8 = 32 brightness levels or for a 16-bit PWM
> +	 * we have 65535 / 16 = 4096 brightness levels.
> +	 *
> +	 * Note that this method is based on empirical testing on different
> +	 * devices with PWM of 8 and 16 bits of resolution.
> +	 */
> +	n = period;
> +	while (n) {
> +		counter += n % 2;
> +		n >>= 1;
> +	}

I don't quite follow the heuristics above. Are you sure the number of
PWM bits can be infered from the period? What if the period value (in
ns) doesn't directly correspond to a register value? And even if it
did, counting the number of set bits (the above loops is a
re-implementation of ffs()) doesn't really result in the dividers
mentioned in the comment. E.g. a period of 32768 ns (0x8000) results
in a divider of 1, i.e. 32768 brighness levels.

On veyron minnie the period is 1000000 ns, which results in 142858
levels (1000000 / 7)!

Not sure if there is a clean solution using heuristics, a DT property
specifying the number of levels could be an alternative. This could
also be useful to limit the number of (mostly) redundant levels, even
the intended max of 4096 seems pretty high.

Another (not directly related) observation is that on minnie the
actual brightness at a nominal 50% is close to 0 (duty cycle ~3%). I
haven't tested with other devices, but I wonder if it would make
sense to have an option to drop the bottom N% of levels, since the
near 0 brightness in the lower 50% probably isn't very useful in most
use cases, but maybe it looks different on other devices.

Cheers

Matthias
