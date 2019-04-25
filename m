Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835CBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE920717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwj22uaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbfDYUJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:09:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34232 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfDYUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:09:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id h5so746618lfm.1;
        Thu, 25 Apr 2019 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqYNe3Q4on3UBY8kthiYRWhIUXpNxgBemqe9d+/Z800=;
        b=Pwj22uaK2z+VatUB1i82o+bln9TXRmhDS6iM2vgbK1aJ1bviNJDW6Tr8EttllXbJBy
         jQgijOwDK9oXJeUIh+wjSlQsUfu/3tFi1fLWk5cdpHnxG6xm+8ECK7joy+jTqZrDgbzt
         IJbcatJdwswFsBwyQZUptAuK5MvVSKMvLus1qV1aoOzEVkZHFAfUcsWIGiNAUahEbZq8
         f31TxUJpzU7s3ErNgEGUX4fEltOUEbbSQZwftBYbbMNtt9pfdAsTLhfwLfLKroYtNkgN
         60dEGKary8w0B7G18SDyBd6+lMpA9KrdHre01bczojjgpIDScv7pvKvxm/KUh1ls5utA
         LFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqYNe3Q4on3UBY8kthiYRWhIUXpNxgBemqe9d+/Z800=;
        b=HtjfsiTtWAB3fWoeMSmPvoIOmJ+RK3DRWTRAnxsmVFfjGdn81bDOHkrWMqmuwobdqx
         r+axLvy+fDqZ991ixLoYzkSQbfY8ku6oJ7SVVRPwrEV50yvRFUBnZM6d7X52YYdVZm3X
         ykVf886GyvzozeqkbxGejsznQkgQelmomXa6805v+syrR5jfyoovOLhPG3uWYfpBl/q6
         kBXdFnWvfhSilQA2TQ4C2BHc+AQIHfqUcJGWN6xBh53Fb3n06qfNmzo0j0/JBqgjxjmH
         8mCgWGJ2/V+L+24V6QdiloH5peMJYlAdNjj+g41YYvTXHnV8+DEoUXRz0tHV1ycbo8qq
         Ggog==
X-Gm-Message-State: APjAAAVJVgHvtzYjoBUN0TaFusNetAjqMmsq16/SgkKq3qMGmedUmawM
        W2zuWiCHjLykaBxx5iZQjmc=
X-Google-Smtp-Source: APXvYqx/Q/rQDwGxAw90r+FsGi3mefsBH5iJ/Dy4V9fRVockVu+OiSzzd6HjyGyyDfspqX/nbg2K+A==
X-Received: by 2002:a19:a40f:: with SMTP id q15mr19103277lfc.121.1556222992019;
        Thu, 25 Apr 2019 13:09:52 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id 30sm5130963lfr.22.2019.04.25.13.09.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 13:09:51 -0700 (PDT)
Date:   Thu, 25 Apr 2019 23:09:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Message-ID: <20190425200948.bj5h7svga727havo@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-3-fancer.lancer@gmail.com>
 <4e7c9184-03a2-f1d3-2ed0-a761d76b9654@axentia.se>
 <20190425154736.emjumxqimzgvzrla@mobilestation>
 <3366ab5c-ced5-cfe1-c93e-d50ce795c2aa@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3366ab5c-ced5-cfe1-c93e-d50ce795c2aa@axentia.se>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 07:28:52PM +0000, Peter Rosin wrote:
> On 2019-04-25 17:47, Serge Semin wrote:
> > On Wed, Apr 24, 2019 at 09:25:50PM +0000, Peter Rosin wrote:
> >> On 2019-04-24 14:34, Serge Semin wrote:
> >>> It's pointless and might be even errors prone to proceed with further
> >>> initialization if neither of- no platform-based settings were discovered.
> >>> Just return an error in this case.
> >>>
> >>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >>> ---
> >>>  drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++++-----
> >>>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> >>> index 24cf6ec02e75..a14fe132b0c3 100644
> >>> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> >>> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> >>> @@ -132,7 +132,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> >>>  static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> >>>  					struct platform_device *pdev)
> >>>  {
> >>> -	return 0;
> >>> +	return -EINVAL;
> >>>  }
> >>>  #endif
> >>>  
> >>> @@ -142,6 +142,9 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
> >>>  	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
> >>>  	struct gpio_chip *gpio;
> >>>  
> >>> +	if (!data)
> >>> +		return -EINVAL;
> >>> +
> >>>  	/*
> >>>  	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
> >>>  	 * relative to its base GPIO number. Otherwise they are absolute.
> >>> @@ -175,11 +178,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >>>  	if (!mux)
> >>>  		return -ENOMEM;
> >>>  
> >>> -	if (!dev_get_platdata(&pdev->dev))
> >>> +	ret = i2c_mux_gpio_probe_plat(mux, pdev);
> >>> +	if (ret)
> >>>  		ret = i2c_mux_gpio_probe_dt(mux, pdev);
> >>> -	else
> >>> -		ret = i2c_mux_gpio_probe_plat(mux, pdev);
> >>> -	if (ret < 0)
> >>> +	if (ret)
> >>>  		return ret;
> >>
> >> I notice that after this patch, all probe failures from non-dt configs
> >> will return -EINVAL from the dummy i2c_mux_gpio_probe_dt that gets
> >> called on i2c_mux_gpio_probe_plat failure.
> >>
> >> So, any -EPROBE_DEFER is now lost. That probably doesn't fly.
> >>
> > 
> > So what do you suggest then?
> 
> I don't know, I'm just pointing out that you are breaking probe-defer.
> 
> >                              We can return to something like:
> > if (dev_get_platdata(&pdev->dev))
> >     ret = i2c_mux_gpio_probe_plat(mux, pdev);
> > else
> >     ret = i2c_mux_gpio_probe_dt(mux, pdev);
> > 
> > In this case there is no falling back to dt. Just either plat- or of-based
> > initialization. The same can be done for i2c_mux_gpio_request_*() methods.
> 
> Works for me, I fail to see why it is interesting with a fallback
> anyway? If you supply platform data, that is supposed to take
> precedence. No?
> 
> If the platform data fails, I'd rather not have the code run into the
> weeds attempting stuff that's not even supposed to work...
> 

Yeah, you are right. Adding fallback pattern here was a bad idea.
I'll fix it in the next patchset version.

-Sergey

> Cheers,
> Peter
> 
> > -Sergey
> > 
> >> Cheers,
> >> Peter
> >>
> >>>  
> >>>  	parent = i2c_get_adapter(mux->data.parent);
> >>>
> >>
> 
