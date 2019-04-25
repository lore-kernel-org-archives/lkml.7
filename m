Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F84C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5522B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="map3fdjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfDYPrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:47:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46101 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfDYPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:47:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so17856543lfj.13;
        Thu, 25 Apr 2019 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ySUvljXpuUtuUJ4XpdV5GmroC1xZAQ973WvNd8KEmuw=;
        b=map3fdjpfYfcoJcEMWBRwTO5rufArfd1zQHSIpynjeP068JgTNSTyymG7/cdz8euTx
         ZQBT0u2M8naqqZt0k0+LKNdArbzkXq+67Uc4UOQ5A5hr2hzKWZdT1uClTu02CU6Sc7H2
         9EKB3jd57wZ1MicLdUUS2PhEZeo+S9ZFBo1UDtOjSuXKZUWZtszUUBrTVjWxl73prNHy
         dwlu5uMddU+UChPkzN3cqoULnCADxKFNq+A1Nv7ke/+dJm2JQWiSgdyFZizjO9TOCnLN
         ZZG+M5ziJST00vuKerj0rl6ubhBLbP1zuKXbdppmzsuKa8pGyLQHMuTTjfy2fQsT7CRy
         v2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ySUvljXpuUtuUJ4XpdV5GmroC1xZAQ973WvNd8KEmuw=;
        b=AehUxLCfAt7w0BIcTozKeUK5PRLJXg+lO169f2oBMjDCjBNqVpkR+aJrMblPxTQ37V
         u/0Y4mCmp9i5abDrEgGrKWpBRj5auMlLEDNfUSrpHOAe5k8EsJyvq/MkphUwlLPKhm7Q
         R3VzKkAHTOOQm3SifFviQQkOVNKLUtHCXJfAwihVMu8do3mC+ObdZOId0b0bBFWCbz86
         TMLwStG+McBGLrD+Kes26adNIHLv59Y0W8Vb0SrJaPW3k4F3A7dsvNnK5ddTJjrzW5vm
         06QOR54u6hYcidLoiOTPT0CYlLtzwcS3cgtqu1TTjf0nLaAf/VzxN7Zp98LOuIOIA1g2
         PmUg==
X-Gm-Message-State: APjAAAUgKPFNaKkcVfc/8C2x/al3TBLnKIbZkGoL27Q40RpIX4KZ4O+t
        6a+c3PMxTq45yX927rQ7Dp8=
X-Google-Smtp-Source: APXvYqwXY8nIWx56YSxb1b1U90MT0FZJ5moaTalfI4dxSnFQ9UIB9k/rXac/NTO5ShSnOkUZ21aH6Q==
X-Received: by 2002:ac2:51ba:: with SMTP id f26mr22486757lfk.126.1556207271440;
        Thu, 25 Apr 2019 08:47:51 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id m19sm4771624lji.70.2019.04.25.08.47.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 08:47:50 -0700 (PDT)
Date:   Thu, 25 Apr 2019 18:47:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Message-ID: <20190425154736.emjumxqimzgvzrla@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-3-fancer.lancer@gmail.com>
 <4e7c9184-03a2-f1d3-2ed0-a761d76b9654@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7c9184-03a2-f1d3-2ed0-a761d76b9654@axentia.se>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:25:50PM +0000, Peter Rosin wrote:
> On 2019-04-24 14:34, Serge Semin wrote:
> > It's pointless and might be even errors prone to proceed with further
> > initialization if neither of- no platform-based settings were discovered.
> > Just return an error in this case.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> > index 24cf6ec02e75..a14fe132b0c3 100644
> > --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> > +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> > @@ -132,7 +132,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> >  static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> >  					struct platform_device *pdev)
> >  {
> > -	return 0;
> > +	return -EINVAL;
> >  }
> >  #endif
> >  
> > @@ -142,6 +142,9 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
> >  	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
> >  	struct gpio_chip *gpio;
> >  
> > +	if (!data)
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
> >  	 * relative to its base GPIO number. Otherwise they are absolute.
> > @@ -175,11 +178,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  	if (!mux)
> >  		return -ENOMEM;
> >  
> > -	if (!dev_get_platdata(&pdev->dev))
> > +	ret = i2c_mux_gpio_probe_plat(mux, pdev);
> > +	if (ret)
> >  		ret = i2c_mux_gpio_probe_dt(mux, pdev);
> > -	else
> > -		ret = i2c_mux_gpio_probe_plat(mux, pdev);
> > -	if (ret < 0)
> > +	if (ret)
> >  		return ret;
> 
> I notice that after this patch, all probe failures from non-dt configs
> will return -EINVAL from the dummy i2c_mux_gpio_probe_dt that gets
> called on i2c_mux_gpio_probe_plat failure.
> 
> So, any -EPROBE_DEFER is now lost. That probably doesn't fly.
> 

So what do you suggest then? We can return to something like:
if (dev_get_platdata(&pdev->dev))
    ret = i2c_mux_gpio_probe_plat(mux, pdev);
else
    ret = i2c_mux_gpio_probe_dt(mux, pdev);

In this case there is no falling back to dt. Just either plat- or of-based
initialization. The same can be done for i2c_mux_gpio_request_*() methods.

-Sergey

> Cheers,
> Peter
> 
> >  
> >  	parent = i2c_get_adapter(mux->data.parent);
> > 
> 
