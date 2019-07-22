Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49FAC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FF021985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+zBb66m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfGVPUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:20:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36979 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfGVPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:20:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so35728899wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rcQE3lqQ7qHdpTliGnphmcGBT5sq5T1i6sYO3p/vgc8=;
        b=V+zBb66mMoZKT+uP6vSPu6gSa0cocMmWscUDuipWZQXinBTzJl0+/SZPTSnx/eG+W7
         M2gj/SB4fPiH3QDjf67mfQ8Nq5e0taThlxRK+Pbv7iY6AjFz4MRd5WmNbZAH+RPBNaXn
         oOJ3sPFg2QfJ4sHMHeXZKOUX6YXHy+63u7p2v9E8LBX9VH9uUxjd8OySrTsVephTd/5R
         zd5znXce9+FzwhGw8znDlGTMr6/pjW832Gw97gSXXtorFOujysfZYyCcISGscjrm85Yj
         kuuLzWhOidE+E7wuLCQSBOYLTMQtQx0W6tctgLTMOj716nlnXLGkUcDWZPCJqLVA93M9
         0vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcQE3lqQ7qHdpTliGnphmcGBT5sq5T1i6sYO3p/vgc8=;
        b=ltldXkyd+99ncCkD0529vYOTllP/uPVdtyw/CWlELiGrp05OYoZ5ljGGYat8CILfrb
         Js+3QafTowUUT96phzP1eYFQchd99/SqFT7jFVmO6VoPExFWOks50k8ju9h3elLXWA+U
         P9Vz15NOAvZqxwnGuBNQPmbKnVW6522VyX+fRAU6D0oiyh/FgCZGbDpXmHZ6y7nx28wK
         30Oe6zqAk34LZ5oerYCws5QkyzNltvPQs9avtYumlhFa1KWvcXfEkp0zaea9yq9Y8R9S
         UCtd6zLw52Zi2SvyPC9aeKrq5/2kicIFuLZINUI+6Di2qt2itSEDS5TOQMGiC66dkkLC
         YlbA==
X-Gm-Message-State: APjAAAU4hDjZVCAqr6ewtlWbw+IB5MMsViV/mEtZ0rIvWYCGB2I3JJn3
        5r1yqr5qzxrXNVwYNKQRoUxPHg==
X-Google-Smtp-Source: APXvYqxCxsboFZaheGk5qi4oj8GmwA1c5IhO90rjs/b8WLMO0LzRMCPUTyNiuTec/jgg8DLQfEd8uA==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr65955957wmh.125.1563808846569;
        Mon, 22 Jul 2019 08:20:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a81sm39805102wmh.3.2019.07.22.08.20.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:20:45 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:20:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 5/7] backlight: gpio: remove dev from struct
 gpio_backlight
Message-ID: <20190722152044.7zwf2xtzbpesjrmv@holly.lan>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150302.29526-6-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:03:00PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is unused. Remove it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/gpio_backlight.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 01262186fa1e..70882556f047 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -19,9 +19,7 @@
>  #include <linux/slab.h>
>  
>  struct gpio_backlight {
> -	struct device *dev;
>  	struct device *fbdev;
> -
>  	struct gpio_desc *gpiod;
>  	int def_value;
>  };
> @@ -69,8 +67,6 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	if (gbl == NULL)
>  		return -ENOMEM;
>  
> -	gbl->dev = &pdev->dev;
> -
>  	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
>  
> -- 
> 2.21.0
> 
