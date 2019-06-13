Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C942082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6BwezNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFMPeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:34:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42944 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfFMKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:33:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so4886115wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AvF+rESNmUsYSxuwMN4dGVfZ/GYoOlQetjDsp5wH4wc=;
        b=T6BwezNryJPzXa4V2XzFft4bfVNOdwMNWcC3+p2ctBY6GvYfs+0VnNo4cwpGZH96eR
         PX/MSykeONYonOLw7OEzZMrNYmo41Xo8k88/Rm284Z5Ec5WV4aI5Wf/pe8LiwSB6sxLG
         Owb7+orUWD44+WHU0eQtEJ2ofIAN3UDv7ExYa6k7FEj7Dmi+YbqHNPfExuc1sGurYlOl
         euUYOJxakEJtyVHGusSny9JFKMJum1V+xhaGb3O9MHBXHaIasApjGdMfHaZSjfFBIgX9
         c3bsNA2rG06pf6X4Rh68/dcqJeXW9RmF1FKtXOv8pNazKlUBfCl9c0CA/4OLAQIsICUq
         FRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AvF+rESNmUsYSxuwMN4dGVfZ/GYoOlQetjDsp5wH4wc=;
        b=loVIZdaid20BTfpQWgQ0E4Nvw22O7FejdZbuRFvpuJbMREKDI94p6jHsNM5JCiI1kM
         5LyyjuNsFO0TZg1YWjaF8ChAMdtls65mUyyuR5v4OReoiNbig+fnUyY71OT+OK3q6Vxq
         x/ffj91shJ85p/ibGHfDitCNcGhP2wXa/aSD51mI/arGeBxw8Pw//f/PVfJ4FU1dmCZT
         iWdbEnVjcWivQooOOOjtNJeguaHs1t5ML/uI98zMYu1LY78iKKtkdrtQG5kCql/VMsFC
         sknQiwx47HT1gNhVWTJPIbB4IAJtmi+6WlUq4qrx+y3CRtRUeukSBP7cXqSS7a76uBCv
         rgzg==
X-Gm-Message-State: APjAAAUC9lp1a29NDAOWHxzpwvWa0zf4BaFbI+lT1q+Vwg3aseXMzPts
        RJ0wD060PB5QZCq8KAToadedGQ==
X-Google-Smtp-Source: APXvYqw5jcoZ/iCX06jWg/9hyoQ9jajMt2+MO1Qiyu54NoQ9yZHhfdIagflNMIxOHArES62DmpVD/g==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr59660630wrq.28.1560422002290;
        Thu, 13 Jun 2019 03:33:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z5sm2944149wrv.60.2019.06.13.03.33.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 03:33:21 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:33:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: Replace old GPIO APIs with GPIO
 Consumer APIs for sky81542-backlight driver
Message-ID: <20190613103319.xhnb3vkjanycfqth@holly.lan>
References: <20190612043229.GA18179@t-1000>
 <20190612102615.f4zbprojjxfuahqc@holly.lan>
 <20190612152433.GA24293@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612152433.GA24293@t-1000>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:24:34AM -0700, Shobhit Kukreti wrote:
> On Wed, Jun 12, 2019 at 11:26:15AM +0100, Daniel Thompson wrote:
> > Hi Shobhit
> > 
> > Thanks for the patch. Feedback below...
> 
>   Hi Daneil, 	
> 
>   You provided some valuable feedback. Thank you for your time and
>   effort.	
> > 
> > 
> > On Tue, Jun 11, 2019 at 09:32:32PM -0700, Shobhit Kukreti wrote:
> > > Port the sky81452-backlight driver to adhere to new gpio descriptor based
> > > APIs. Modified the file sky81452-backlight.c and sky81452-backlight.h.
> > > The gpio descriptor property in device tree should be "sky81452-en-gpios"
> > 
> > That is contradicted by the device tree bindings. The property should
> > remain "gpios" as it was before this conversion.
> 
>  You are correct. 	
> > 
> > 
> > > Removed unnecessary header files "linux/gpio.h" and "linux/of_gpio.h".
> > > 
> > > Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> > 
> > What level of testing have you done? Is this a fix for hardware you own
> > or a cleanup after searching the sources?
> > 
>   I did not the test on actual hardware. I was trying to do a clean up and boot on 
>   QEMU/rock960 board. I will drop the patch until I can find  the  sk81452 
>   hardware to test it.

Blind bug fixes are not prohibited by any means. However a clean up
without no (intentional) functional changes will certainly attract much
closer review and might also need more care when constructing a Cc: list
for the patch (e.g. to include the original author for their review or
testing, etc).


Daniel.

>   
> > 
> > > ---
> > >  drivers/video/backlight/sky81452-backlight.c     | 24 ++++++++++++------------
> > >  include/linux/platform_data/sky81452-backlight.h |  4 +++-
> > >  2 files changed, 15 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> > > index d414c7a..12ef628 100644
> > > --- a/drivers/video/backlight/sky81452-backlight.c
> > > +++ b/drivers/video/backlight/sky81452-backlight.c
> > > @@ -19,12 +19,10 @@
> > >  
> > >  #include <linux/backlight.h>
> > >  #include <linux/err.h>
> > > -#include <linux/gpio.h>
> > >  #include <linux/init.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > -#include <linux/of_gpio.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/platform_data/sky81452-backlight.h>
> > > @@ -193,7 +191,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> > >  	pdata->ignore_pwm = of_property_read_bool(np, "skyworks,ignore-pwm");
> > >  	pdata->dpwm_mode = of_property_read_bool(np, "skyworks,dpwm-mode");
> > >  	pdata->phase_shift = of_property_read_bool(np, "skyworks,phase-shift");
> > > -	pdata->gpio_enable = of_get_gpio(np, 0);
> > >  
> > >  	ret = of_property_count_u32_elems(np, "led-sources");
> > >  	if (ret < 0) {
> > > @@ -274,13 +271,17 @@ static int sky81452_bl_probe(struct platform_device *pdev)
> > >  		if (IS_ERR(pdata))
> > >  			return PTR_ERR(pdata);
> > >  	}
> > > -
> > > -	if (gpio_is_valid(pdata->gpio_enable)) {
> > > -		ret = devm_gpio_request_one(dev, pdata->gpio_enable,
> > > -					GPIOF_OUT_INIT_HIGH, "sky81452-en");
> > > -		if (ret < 0) {
> > > -			dev_err(dev, "failed to request GPIO. err=%d\n", ret);
> > > -			return ret;
> > > +	pdata->gpiod_enable = devm_gpiod_get(dev, "sk81452-en", GPIOD_OUT_HIGH);
> > 
> > As above... I think the second argument here needs to be NULL in order
> > to preserve the current DT bindings.
>   
>   You are correct. I was testing this driver with a custom dtb in rock960 board and named
>   the property as above in the dts. It should be NULL.
> 
> > 
> > > +	if (IS_ERR(pdata->gpiod_enable)) {
> > > +		long ret = PTR_ERR(pdata->gpiod_enable);
> > > +
> > > +		/**
> > 
> > Nitpicking... but no second star here. That's a trigger symbold for
> > documentation processors.
> 
>   That is a great feedback. I will keep that in mind.
> > 
> > > +		 * gpiod_enable is optional in device tree.
> > > +		 * Return error only if gpio was assigned in device tree
> > 
> > Also nitpicking but I had to read this a few times because
> > gpiod_enable is not in device tree, gpios is.
> 
>   You are correct. I will make necessary changes.
> > 
> > This is a common pattern so the comment can be very short. Something
> > like:
> > 
> >     This DT property is optional so no need to propagate ENOENT
> 
> 	Noted.
> > 
> > 
> > > +		 */
> > > +		if (ret != -ENOENT) {
> > > +			dev_err(dev, "failed to request GPIO. err=%ld\n", ret);
> > > +			return PTR_ERR(pdata->gpiod_enable);
> > >  		}
> > >  	}
> > >  
> > > @@ -323,8 +324,7 @@ static int sky81452_bl_remove(struct platform_device *pdev)
> > >  	bd->props.brightness = 0;
> > >  	backlight_update_status(bd);
> > >  
> > > -	if (gpio_is_valid(pdata->gpio_enable))
> > > -		gpio_set_value_cansleep(pdata->gpio_enable, 0);
> > > +	gpiod_set_value_cansleep(pdata->gpiod_enable, 0);
> > >  
> > >  	return 0;
> > >  }
> > > diff --git a/include/linux/platform_data/sky81452-backlight.h b/include/linux/platform_data/sky81452-backlight.h
> > > index 1231e9b..dc4cb85 100644
> > > --- a/include/linux/platform_data/sky81452-backlight.h
> > > +++ b/include/linux/platform_data/sky81452-backlight.h
> > > @@ -20,6 +20,8 @@
> > >  #ifndef _SKY81452_BACKLIGHT_H
> > >  #define _SKY81452_BACKLIGHT_H
> > >  
> > > +#include <linux/gpio/consumer.h>
> > > +
> > 
> > This heaer file should be included from the C file... it is not required
> > to parse the header.
>  
>   I appreciate the feedback. I will keep that in mind to avoid future
>   errors. 
> > 
> > 
> > Daniel.
> > 
> > 
> > >  /**
> > >   * struct sky81452_platform_data
> > >   * @name:	backlight driver name.
> > > @@ -34,7 +36,7 @@
> > >   */
> > >  struct sky81452_bl_platform_data {
> > >  	const char *name;
> > > -	int gpio_enable;
> > > +	struct gpio_desc *gpiod_enable;
> > >  	unsigned int enable;
> > >  	bool ignore_pwm;
> > >  	bool dpwm_mode;
> > > -- 
> > > 2.7.4
> > > 
