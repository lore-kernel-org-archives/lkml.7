Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D1DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145F720850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="UywwujrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfENSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:13:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42987 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfENSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:12:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id d4so10884795qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HrkjcsngWKiOpJS10js6bvf1zdshTsN54KJhQwcMKVg=;
        b=UywwujrY/ytEzSfp8rG9FXW/ApAoK75ult5EIRsYGH1clhBX7Ek9y6Tj6lWt9Xo6pK
         P8kF8427XKk1mgLR646yNWutCI9Y4T3sU62CshHLqV9b0UYbtVRph4V9DhrPDpK147Zx
         bDPZrVlvWhkkSq5ZLj8Xa8I6WWnhSNA5PiYSumt4rpj34C9M6t2h2wW+9ZLG7JMPpTL3
         48SXBH1rghW8V51fCr0a+0MEYGnRSGDasXc2GYaXoxPGkQLcMlxBlHQJlU7voH/u3aIO
         PUHIxzdBMivxsr5/Zpqw8TcH09MZDT6mzWt6LZcFAxotbq5el/9nRruGl72Nolpv4GFx
         3sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HrkjcsngWKiOpJS10js6bvf1zdshTsN54KJhQwcMKVg=;
        b=fSIEj4K9O5IUdkn+V7T8Bt7YPUBMx5q5Dav/WYfXZo9EF/DWhPfDpzX+GA45C7y35V
         FYfh//HuEBihgqA4P1fgaoIYXaCJW645lgBmY8+iltGWFD5Rz+XGjcFYr8UfL7pQb6YS
         mzy/pNXGTFzN0QuFyefI7im99x/07yEjwr5uP0Z1R8GMQ0zBWTRH1FEgIqJw1A6ByX7R
         S/+0JxJOZhfZtD0+zkJW/eVQzfLLfjNxcUHOlHj3/KORcE944jrpVEz/GJnyBdF9mbLO
         L1TkmAa4DIqggKF52n+D6psl4Vaw/Juv2jGrRE5qRkRz1JWuMHoHmulQS8tGGKz7P9iz
         jzYg==
X-Gm-Message-State: APjAAAVyt//EqXxATrGpkLnP7NwesLTbMQFCpK7oOtlzYznsGIKufUq+
        2xQqBHOIi6PzGoWVsLmEEu4dEQ==
X-Google-Smtp-Source: APXvYqyKze9u0JIuismmXNkd+chXAfH2zyghRGa1LErYSasX1sE5+g2ouyvkDufBwjI7Z5AohXUjtQ==
X-Received: by 2002:a37:358:: with SMTP id 85mr28270475qkd.174.1557857578793;
        Tue, 14 May 2019 11:12:58 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id g55sm14028045qtk.76.2019.05.14.11.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:12:58 -0700 (PDT)
Date:   Tue, 14 May 2019 14:12:57 -0400
From:   Sean Paul <sean@poorly.run>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/bridge: adv7511: Fix low refresh rate selection
Message-ID: <20190514181257.GS17077@art_vandelay>
References: <20190424132210.26338-1-matt.redfearn@thinci.com>
 <20190511193226.GO13043@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511193226.GO13043@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 10:32:26PM +0300, Laurent Pinchart wrote:
> Hi Matt,
> 
> Thank you for the patch.
> 
> On Wed, Apr 24, 2019 at 01:22:27PM +0000, Matt Redfearn wrote:
> > The driver currently sets register 0xfb (Low Refresh Rate) based on the
> > value of mode->vrefresh. Firstly, this field is specified to be in Hz,
> > but the magic numbers used by the code are Hz * 1000. This essentially
> > leads to the low refresh rate always being set to 0x01, since the
> > vrefresh value will always be less than 24000. Fix the magic numbers to
> > be in Hz.
> > Secondly, according to the comment in drm_modes.h, the field is not
> > supposed to be used in a functional way anyway. Instead, use the helper
> > function drm_mode_vrefresh().
> > 
> > Fixes: 9c8af882bf12 ("drm: Add adv7511 encoder driver")
> > Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
> 
> Wow, a 4.5 year old bug fix, nice :-)
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 

Applied to drm-misc-next-fixes.

Thanks!

Sean

> > ---
> > 
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > index 85c2d407a52..e7ddd3e3db9 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -747,11 +747,11 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
> >  			vsync_polarity = 1;
> >  	}
> >  
> > -	if (mode->vrefresh <= 24000)
> > +	if (drm_mode_vrefresh(mode) <= 24)
> >  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_24HZ;
> > -	else if (mode->vrefresh <= 25000)
> > +	else if (drm_mode_vrefresh(mode) <= 25)
> >  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_25HZ;
> > -	else if (mode->vrefresh <= 30000)
> > +	else if (drm_mode_vrefresh(mode) <= 30)
> >  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_30HZ;
> >  	else
> >  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
