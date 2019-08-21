Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB24C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56431233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMLmpdVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfHUOE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:04:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46986 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:04:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so2147322wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ep3pc90vpoVG0Lq8JYK4R2Sa69WJp1f9mSFS+lsduu0=;
        b=CMLmpdVrYckFsCp7XcD4I5fsNQE83lkhqKBvYVnwzZc1V2q5+GmgP396fcmaJ7NSKu
         /IKfoU5FDuJidTSGvV5vAROimcrCuS/GNN0EM9JI0yymk9228JEMAkFV6poxxjj+/OuP
         PpxUF1n6buUWwfMT808oS62Hnx8TfhNIV79aaiXiGIyenVzccqpdngz57BNzI9NRwoDB
         R5R+vU9xdiYso82A7HHmwJ2WCDiAM6o5f4fDWsBdHMKzIMyBJQsiYozECbPPO+xlCmBP
         KtInRJXJqhrlAYeAYLnwkj09ig3XVXSWb+zTHeD23nULW3fUApzAwTQt7VSrYPy3IF75
         eDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ep3pc90vpoVG0Lq8JYK4R2Sa69WJp1f9mSFS+lsduu0=;
        b=b8ZQtpiIhIAwyCvCXXCMGTrBVEfWW1IAzlAyPs8L8mlob4xAWiceinFSRLccyKDbzi
         oOdMCeuIMWIJTR03XGtL6BMspUznwRstcmQUWhfnwpkJ3MZJt2TGDa94wnfJQJc5LkfF
         h+ZQaB5kJ+rMDOSiArzb6Ww7cSJeJWzGrScP/IkW+vRXq16L6/3qrt1jPLnwWVjcLSQv
         NusO3EJ7lldehb6a4vQ3ukZBGrBcVRI0f9D0mQTc0Lx6nC1zbZ3O/teUxSVByVLv1B2p
         iWpjRlgD6L2S/+EqgW12+7eQU1AScUKs6WlFauF9XPj1dDbFjuUfs8Y6RMT1iEYJkz/K
         YRhA==
X-Gm-Message-State: APjAAAWzJv6qiMJe88vx9o+goisRiCWO+4ioEGLG1fLySqnPDW+VojdL
        /Z9FHkIf7P6EZY6Jg+rAhul+qA==
X-Google-Smtp-Source: APXvYqxrz8Ujd13xWs6w1FryN9ooB1DKKEmYD6a2FiUUfYXMxGKxC+LyrbLFp+qi9lq4FrP/caQyrA==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr43516861wro.190.1566396296807;
        Wed, 21 Aug 2019 07:04:56 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m6sm16729440wrq.95.2019.08.21.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:04:55 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:04:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v3] backlight: gpio-backlight: Correct initial power
 state handling
Message-ID: <20190821140454.6uuquwx7bkyx656e@holly.lan>
References: <20190731084018.5318-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731084018.5318-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:40:18AM +0300, Peter Ujfalusi wrote:
> The default-on property - or the def_value via legacy pdata) should be
> handled as:
> if it is 1, the backlight must be enabled (kept enabled)
> if it is 0, the backlight must be disabled (kept disabled)
> 
> This only works for the case when default-on is set. If it is not set then
> the brightness of the backlight is set to 0. Now if the backlight is
> enabled by external driver (graphics) the backlight will stay disabled since
> the brightness is configured as 0. The backlight will not turn on.
> 
> In order to minimize screen flickering during device boot:
> 
> The initial brightness should be set to 1.
> 
> If booted in non DT mode or no phandle link to the backlight node:
> follow the def_value/default-on to select UNBLANK or POWERDOWN
> 
> If in DT boot we have phandle link then leave the GPIO in a state which the
> bootloader left it and let the user of the backlight to configure it
> further.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Hi,
> 
> sorry for the delay, but got distracted a bit with the resend of this...
> Let's try again ;)
> 
> Changes since v2 (https://lore.kernel.org/patchwork/patch/1002359/):
> - Rebased on drm-next
> 
> Changes since v1:
> - Implement similiar initial power state handling as pwm backlight have
> 
> Regards,
> Peter
> 
>  drivers/video/backlight/gpio_backlight.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index e84f3087e29f..18e053e4716c 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -59,13 +59,11 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
>  				   struct gpio_backlight *gbl)
>  {
>  	struct device *dev = &pdev->dev;
> -	enum gpiod_flags flags;
>  	int ret;
>  
>  	gbl->def_value = device_property_read_bool(dev, "default-on");
> -	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>  
> -	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> +	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
>  	if (IS_ERR(gbl->gpiod)) {
>  		ret = PTR_ERR(gbl->gpiod);
>  
> @@ -79,6 +77,22 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
> +{
> +	struct device_node *node = gbl->dev->of_node;
> +
> +	/* Not booted with device tree or no phandle link to the node */
> +	if (!node || !node->phandle)
> +		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> +
> +	/* if the enable GPIO is disabled, do not enable the backlight */
> +	if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
> +		return FB_BLANK_POWERDOWN;
> +
> +	return FB_BLANK_UNBLANK;
> +}
> +
> +
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct gpio_backlight_platform_data *pdata =
> @@ -136,7 +150,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		return PTR_ERR(bl);
>  	}
>  
> -	bl->props.brightness = gbl->def_value;
> +	bl->props.power = gpio_backlight_initial_power_state(gbl);
> +	bl->props.brightness = 1;
> +
>  	backlight_update_status(bl);
>  
>  	platform_set_drvdata(pdev, bl);
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
