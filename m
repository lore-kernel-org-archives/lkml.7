Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AF6ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D219621721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4l5WQnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfJGPcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:32:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33932 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfJGPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:32:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so299656wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+UUyJ3n1ncJEha1n4+/C9IqVhKV2cn/9xer57zUNQg=;
        b=M4l5WQnY/5/LYnOXzKCnELHG/dlhUcnZ94WpkSICHsRATKoJHNQZb1WTLQ4HMXk87/
         1ao78TZuxeEd9reB94SSdWD6Llt0ewQX0Lcxb0sczQ+zs1jVRmndlox2A0zXuBjZFV88
         aMGt+pqdnc3IUASMZ/59ziu0+ZF//5EKF4g/k/YOIQupNJg80Wd7ujtm7BOgLg1ZxPgF
         Jih5mb/YWFHIZrkV+6wJCapJl2I8w2QgWrh+iCzDMl+edqvYSa7uz+D3I7sSsrlJ+ip5
         siuFmIAzl+mPgyM78IHo2h/gTJZlDnKCaOKUohtwGNKWUjUt9V3abxFoOSimMI8RI/3U
         cYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+UUyJ3n1ncJEha1n4+/C9IqVhKV2cn/9xer57zUNQg=;
        b=npIWl00pfTT6ViGTL5+tAxIWShKTn9d51EoyGAYvJv/a8H6BOr3QLucAAs4Xdgk3Ue
         bwE6eyKVhyu+vl4uj3a/72j1Z6kXlbieJ54yYifLwefuCUWivBqIg78ZK2WNcpHVc7gU
         sJpdaoEqfnqroOXD39vZ9DOe+b5a+40rumuPiXO9n93voWkJ4ik6oai0Na2tz+Zu+hVk
         PI84IMoi1aOv5vPJQPCqKT0xN/jdS5lFyLSqmmSZAFpnW04ZnCBjKII3+idrq8F3YU87
         45Q/rbpFIA5D3KdmVc0DEOVgxOu/cJ/J96zxMmKVJ/wElLrFToW8Ojnw+p7BZV7l62lw
         +dxg==
X-Gm-Message-State: APjAAAXyP9yp1Ui3FPdyTn99eimFrNTmtZKfYvrc+lZY8UMTrIQDPwtk
        gr+XTyf20aa4k2JIQu0Bl/h7xQ==
X-Google-Smtp-Source: APXvYqx/10sp6D2JJFW3HuaJH4t65Gd2W/SNMkSW3PcA850egBFe5G6/UYiwi8Ay9MMJ3nADgeKQZQ==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr11930483wmc.11.1570462330132;
        Mon, 07 Oct 2019 08:32:10 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t13sm40397699wra.70.2019.10.07.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:32:09 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:32:07 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] backlight: pwm_bl: switch to power-of-2 base for
 fixed-point math
Message-ID: <20191007153207.t5kehxs2znu5z6yx@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-4-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-4-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:06:19PM +0200, Rasmus Villemoes wrote:
> Using a power-of-2 instead of power-of-10 base makes the computations
> much cheaper. 2^16 is safe; retval never becomes more than 2^48 +
> 2^16/2. On a 32 bit platform, the very expensive 64/32 division at the
> end of cie1931() instead becomes essentially free (a shift by 32 is
> just a register rename).
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index aee6839e024a..102bc191310f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -148,7 +148,8 @@ static const struct backlight_ops pwm_backlight_ops = {
>  };
>  
>  #ifdef CONFIG_OF
> -#define PWM_LUMINANCE_SCALE	10000 /* luminance scale */
> +#define PWM_LUMINANCE_SHIFT	16
> +#define PWM_LUMINANCE_SCALE	(1 << PWM_LUMINANCE_SHIFT) /* luminance scale */
>  
>  /*
>   * CIE lightness to PWM conversion.
> @@ -165,23 +166,25 @@ static const struct backlight_ops pwm_backlight_ops = {
>   * The following function does the fixed point maths needed to implement the
>   * above formula.
>   */
> -static u64 cie1931(unsigned int lightness, unsigned int scale)
> +static u64 cie1931(unsigned int lightness)
>  {
>  	u64 retval;
>  
>  	/*
>  	 * @lightness is given as a number between 0 and 1, expressed
> -	 * as a fixed-point number in scale @scale. Convert to a
> -	 * percentage, still expressed as a fixed-point number, so the
> -	 * above formulas can be applied.
> +	 * as a fixed-point number in scale
> +	 * PWM_LUMINANCE_SCALE. Convert to a percentage, still
> +	 * expressed as a fixed-point number, so the above formulas
> +	 * can be applied.
>  	 */
>  	lightness *= 100;
> -	if (lightness <= (8 * scale)) {
> +	if (lightness <= (8 * PWM_LUMINANCE_SCALE)) {
>  		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
>  	} else {
> -		retval = (lightness + (16 * scale)) / 116;
> +		retval = (lightness + (16 * PWM_LUMINANCE_SCALE)) / 116;
>  		retval *= retval * retval;
> -		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
> +		retval += PWM_LUMINANCE_SCALE/2;
> +		retval >>= 2*PWM_LUMINANCE_SHIFT;
>  	}
>  
>  	return retval;
> @@ -215,8 +218,7 @@ int pwm_backlight_brightness_default(struct device *dev,
>  	/* Fill the table using the cie1931 algorithm */
>  	for (i = 0; i < data->max_brightness; i++) {
>  		retval = cie1931((i * PWM_LUMINANCE_SCALE) /
> -				 data->max_brightness, PWM_LUMINANCE_SCALE) *
> -				 period;
> +				 data->max_brightness) * period;
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, PWM_LUMINANCE_SCALE);
>  		if (retval > UINT_MAX)
>  			return -EINVAL;
> -- 
> 2.20.1
