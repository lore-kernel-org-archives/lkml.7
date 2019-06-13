Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D14C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5F621473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bmGw/SSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfFMV4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:56:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41886 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFMV4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:56:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so260273pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqSKUfplOln9iJ64al9vHogCwxzrRaa83C6tRk2QQv4=;
        b=bmGw/SSMPtz8TE4EKqoCf4eLamt3dGCnE78OhZFLR1j3AZMAPdFK6N1D2wU0jpgmTc
         TQMHeLtGxZalAqLGnm4EwKQ86Br67IcUCO4J2VujjS2raHFk08WiqngAoT1IhPARrEaQ
         02N2tSwU3jtn+gGyNBs3XOqsFEvuYN/QORCeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqSKUfplOln9iJ64al9vHogCwxzrRaa83C6tRk2QQv4=;
        b=XP8MoXFn1Nc7LO3GZCOTlkV6czQIdp0gL97w8f7809RJx4NdSOOScUemIykIvnTi/u
         35H5tngB4G8FSWnxXpJm98UjMHtMPr0N1k0d4Cs/2LGP8P0cvfza6r006k3KICGOYdA1
         QsI1v40rCzmhTMluV3piLDmQ0c6e8dheM5iA7qXh06U9vGlz09H+7jpllvFkcQtBuNP+
         xi0K8hsJ5qSTLq5zFMszAj+164V2oD5Tq5vpD0KnQKnqPVEoB/fy6ESJZrl9UIZGz3rb
         ujJeX2lJR1/f1vy2ZagAqkqqqO9EnjLTFk7wzSjyzbAADc5Qi3G9gPUsed6a438Na/0J
         dSJQ==
X-Gm-Message-State: APjAAAWqVIzTL4XnUlE6mfhxjOCW49R79u9eG8XXOVpnveTT6ff402xG
        btUSJVmMV/nCreO/DSu6F3Yh8A==
X-Google-Smtp-Source: APXvYqxa8NPQpW/ncEZ+9wWZVsY/YQvADDPz4jjl5yyTTQ0yaFx82hxstv7CK/gJQmit6jtF7CSy+w==
X-Received: by 2002:a17:90a:b294:: with SMTP id c20mr7807965pjr.16.1560463009452;
        Thu, 13 Jun 2019 14:56:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v28sm687528pga.65.2019.06.13.14.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 14:56:48 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:56:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 2/4] backlight: Expose brightness curve type through sysfs
Message-ID: <20190613215646.GO137143@google.com>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613194326.180889-3-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a few minor things when glancing over the patch on patchwork

On Thu, Jun 13, 2019 at 12:43:24PM -0700, Matthias Kaehlcke wrote:
> Backlight brightness curves can have different shapes. The two main
> types are linear and non-linear curves. The human eye doesn't
> perceive linearly increasing/decreasing brightness as linear (see
> also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> linearly to human eye"), hence many backlights use non-linear (often
> logarithmic) brightness curves. The type of curve currently is opaque
> to userspace, so userspace often relies on more or less reliable

nit: avoid relies ... reliable :)

> heuristics (like the number of brightness levels) to decide whether
> to treat a backlight device as linear or non-linear.
> 
> Export the type of the brightness curve via the new sysfs attribute
> 'scale'. The value of the attribute may be a simple string like
> 'linear' or 'non-linear', or a composite string similar to
> 'compatible' strings of the device tree. A composite string consists
> of different elements separated by commas, starting with the
> most-detailed description and ending with the least-detailed one. An
> example for a composite string is "cie-1931,perceptual,non-linear"
> This brightness curve was generated with the CIE 1931 algorithm, it
> is perceptually linear, but not actually linear in terms of the
> emitted light. If userspace doesn't know about 'cie-1931' or
> 'perceptual' it should at least be able to interpret the 'non-linear'
> part.
> 
> For devices that don't provide information about the scale of their
> brightness curve the value of the 'scale' attribute is 'unknown'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  drivers/video/backlight/backlight.c           | 22 +++++++++++++
>  include/linux/backlight.h                     | 10 ++++++
>  4 files changed, 65 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentation/ABI/testing/sysfs-class-backlight
> new file mode 100644
> index 000000000000..924fb68940e6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight
> @@ -0,0 +1,32 @@
> +What:		/sys/class/backlight/<backlight>/scale
> +Date:		June 2019
> +KernelVersion:	5.4
> +Contact:	Daniel Thompson <daniel.thompson@linaro.org>
> +Description:
> +		Description of the scale of the brightness curve. The
> +		description consists of one or more elements separated by
> +		commas, from the most detailed to the least detailed
> +		description.
> +
> +		Possible values are:
> +
> +		unknown
> +		  The scale of the brightness curve is unknown.
> +
> +		linear
> +		  The brightness changes linearly in terms of the emitted
> +		  light, changes are perceived as non-linear by the human eye.
> +
> +		non-linear
> +		  The brightness changes non-linearly in terms of the emitted
> +		  light, changes might be perceived as linear by the human eye.
> +
> +		perceptual,non-linear
> +		  The brightness changes non-linearly in terms of the emitted
> +		  light, changes should be perceived as linear by the human eye.
> +
> +		cie-1931,perceptual,non-linear
> +		  The brightness curves was calculated with the CIE 1931

s/curves/curve/

> +static const char *const backlight_scale_types[] = {
> +	[BACKLIGHT_SCALE_UNKNOWN]	= "unknown",
> +	[BACKLIGHT_SCALE_CIE1931]	= "cie-1931,perceptual,non-linear",
> +	[BACKLIGHT_SCALE_PERCEPTUAL]	= "perceptual,non-linear",
> +	[BACKLIGHT_SCALE_LINEAR]	= "linear",
> +	[BACKLIGHT_SCALE_NON_LINEAR]	= "non-linear",
> +};
> +
> +

Delete one blank line

> +enum backlight_scale {
> +	BACKLIGHT_SCALE_UNKNOWN,
> +	BACKLIGHT_SCALE_CIE1931 = 1,
> +	BACKLIGHT_SCALE_PERCEPTUAL,
> +	BACKLIGHT_SCALE_LINEAR,
> +	BACKLIGHT_SCALE_NON_LINEAR,	/* needed for backwards compatibility */

maybe better list the more generic options first, same for the string
table.
