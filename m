Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945EEC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C722AED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNZKGEKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGXLNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:13:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52533 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGXLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:13:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so41442389wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoTHpFzQYPjvAZfIE3OYqA2wlNclaoN9MrmSNOMVyog=;
        b=sNZKGEKeF2gx87AyJo4R5CYbJaKpY/ihuXG0R7rQkW4wRe4s2JJbI+yIG04881Spln
         gd+DDll/gXoZRxNp19YBgqDXmF/J+0pP21GtLnClf7RwOJrvY354Fdm3TfcMG27l63qb
         rMGjgtPNIv3Z8NCYxq/ew31B7rBrTn31oGGfsRMlZ+K4t1aL/uS2X3qN10x+rDHfzoVN
         9oxoUbHx79nwVpzbwRtVzJyRxByvgMGXYTLE7oEnIHYsTnXfJGUTSexU3YlM7mA6j/wd
         P1oV6X9iodNVjStiYAXUe2ytdYHKY/wSwZf8T4sH5oDYRLPUOay3M6DU2+z9flz1/QzN
         54FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoTHpFzQYPjvAZfIE3OYqA2wlNclaoN9MrmSNOMVyog=;
        b=DBkgQlbkCCKLqfZFlvdQfpCKIGImEsTg8UpVI7geIRgeXIdEc6zXDOSbVMhibGuE1D
         Nnv7g01xgSWdgeetl5pK1hiBEwslHy1DsBSJH8v4gaCELpDtWV+XEM015edraj8NSHyO
         Ru6xsWwGZ4ZfSqACw3BYk6Zwmt/hlyOquasGRm+cVuH7M+i69DHvQEE5txiHJNX78OLb
         2NOUJ7j/NZgIWauSeX6hgbSF2INvDpKlANh5+SuG/nRZxOA2tJnKaAu+c/iuLDfZ+MG1
         z4qG3Pfyymamhlh6h+0tNbFGdjVasElydP+3v5MoCgfRZxSyroYd6wXkeFjNfH0ueuFC
         9yrw==
X-Gm-Message-State: APjAAAWwPkfBuQnLeLhWiaVr6rqQaHMFv7Z6yLBtF7jOqCT9CYrnAsqP
        c4XUCDN0jz4W9afbds6dLinSSA==
X-Google-Smtp-Source: APXvYqwL4FGhbU5IvgYchPKITgSwCC6hxbCyT7AAsCPQGSECzuD1QkWBPt0+GgsrgAixoJZK+W4tng==
X-Received: by 2002:a1c:a985:: with SMTP id s127mr72652355wme.163.1563966783080;
        Wed, 24 Jul 2019 04:13:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p18sm45929436wrm.16.2019.07.24.04.13.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:13:02 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:13:00 +0100
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
Subject: Re: [PATCH v3 4/7] backlight: gpio: remove unused fields from
 platform data
Message-ID: <20190724111300.pt624m3olrpzp4nj@holly.lan>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <20190724082508.27617-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724082508.27617-5-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:25:05AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove the platform data fields that nobody uses.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  include/linux/platform_data/gpio_backlight.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
> index 34179d600360..1a8b5b1946fe 100644
> --- a/include/linux/platform_data/gpio_backlight.h
> +++ b/include/linux/platform_data/gpio_backlight.h
> @@ -9,9 +9,6 @@ struct device;
>  
>  struct gpio_backlight_platform_data {
>  	struct device *fbdev;
> -	int gpio;
> -	int def_value;
> -	const char *name;
>  };
>  
>  #endif
> -- 
> 2.21.0
> 
