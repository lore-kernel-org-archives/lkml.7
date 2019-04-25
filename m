Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEFFC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB0A2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHScPrOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfDYPxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:53:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfDYPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:53:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so56259ljk.13;
        Thu, 25 Apr 2019 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7mKO1sNcxUG5B0HF/jxYbDkD3Eqq+BtfQRzXDYHu7Ck=;
        b=DHScPrOvqXHnvnh7EIM15zo2VP91EjuoZvIM/Ig95zp2Y40+wPhL4V3zlRVIlZuI/c
         0Sh4C1BcJ7mzwle3IdePtUhN1QVmw4fQJzWmvTYmxAERo4RZm8dp1uUhCzDjvKypW7ii
         iADNDi3h1llqJWd/is7108KSGBF96hvZvoKpN0nMSG+WP5Wo5sX+psGrRsTvBn6DNtDO
         RJBGH2uHTTg/2JdwG8WCzwqnpjoQmftDA30q3SQSu8kVZdzFX/3p5OJI5obKRh9fuBYg
         6BoPV6b1OFGwVCPG0kLZdjTNVMCD4k6dk4iMAjRLZb7U2erGkh7039E/RvL4Kxiyi3KX
         A+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mKO1sNcxUG5B0HF/jxYbDkD3Eqq+BtfQRzXDYHu7Ck=;
        b=TDBWBkWBblFw3qHNF464mQ+gKB5j08/iRfh48dFRWF9fuaQGMIAMooPiS06P8XZplA
         RHzrpyNI8iq3t5SYB6HZRfYjJ8yz3r1rA6fatdPPPb/WDUWzmuJe20291UtUUQAQ88t5
         Pfzn9ONvV+OKE3Fv7jhwLrNaRJb10YZi8arfiObn35jsBN+5uFWwGCpB3BG+jaMdwRJp
         cLAHa8uNukeeCJxmv7n2kfqgL1eJAXBDRtZAlC4aly2IH8WHMtPmOrdig3wjZIVj5e3Q
         VwFDYlcLN6YOPTwMvypnWRIYtLrBcAJi005IfsIfJiGiHjYHORw8NuQSovWggbJazcAf
         vD5Q==
X-Gm-Message-State: APjAAAX5qsvzpBmLDv8HO3tb8xMwNTO49jc1IdEJ6/GpPw6unS8QcJHL
        rKD6blhcgQIp9BC+J6+afXC2rZbW
X-Google-Smtp-Source: APXvYqxHgT73XRwYYR5D1dYn7ltiheSbDJzxHqMWAwJTzG74Mt5nIjsiVmixTUeROy36q036f/wSSg==
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr21482292ljj.104.1556207609524;
        Thu, 25 Apr 2019 08:53:29 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id q6sm6127367lfj.36.2019.04.25.08.53.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 08:53:28 -0700 (PDT)
Date:   Thu, 25 Apr 2019 18:53:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the
 idle data field
Message-ID: <20190425155325.voqlrmbdblo7xhtx@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-4-fancer.lancer@gmail.com>
 <7c8d4751-f5f7-ee2a-c411-a985b81d61a3@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8d4751-f5f7-ee2a-c411-a985b81d61a3@axentia.se>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:26:22PM +0000, Peter Rosin wrote:
> On 2019-04-24 14:34, Serge Semin wrote:
> > In case if the idle state has been specified in the data structure,
> > the idle variable is left untouched as before, so to keep a default
> > channel number enabled in the mux idle state. But if a platform doesn't
> > specify which channel is going to be enabled by default, we as before
> > don't setup the deselect callback, but the initial state is saved in the
> > idle variable for further initialization. We can safely do this here
> > since that variable is used for initial state setting only, when no
> > idling lane is specified.
> 
> While this subtlety is *maybe* ok, a comment about it belongs in the
> *code* where it will be seen when the next person makes changes.
> 
> But why not extend the struct with the initial state? How many of
> these muxes do you expect to exist in a system? Multiplied by a
> couple of bytes. Who cares?
> 

I actually thought about this when started working on the patchset.
That time saving the initial value in the idle variable seemed like a
good idea. I even put a small comment in the code about this.

Anyway lets add a new field to "struct gpiomux" structure and use
it as a container for initial value. It is also a good alternative.
I'll do this in a v2 patchset.

-Sergey

> Cheers,
> Peter
> 
> > 
> > The reason of this change is to prepare the code for future GPIOs request
> > path being split up into of- and plat- based methods. The idle variable
> > here is used as a container of the initial state for both of the paths in
> > case of idle-channel isn't specified.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/i2c/muxes/i2c-mux-gpio.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> > index a14fe132b0c3..535c83c43371 100644
> > --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> > +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> > @@ -171,7 +171,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  	struct gpiomux *mux;
> >  	struct i2c_adapter *parent;
> >  	struct i2c_adapter *root;
> > -	unsigned initial_state;
> >  	int i, ret;
> >  
> >  	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
> > @@ -204,12 +203,14 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  
> >  	muxc->mux_locked = true;
> >  
> > -	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
> > -		initial_state = mux->data.idle;
> > +	/*
> > +	 * Set descelect callback if idle state has been setup otherwise just
> > +	 * use the idle variable to store the initial muxer value.
> > +	 */
> > +	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE)
> >  		muxc->deselect = i2c_mux_gpio_deselect;
> > -	} else {
> > -		initial_state = mux->data.values[0];
> > -	}
> > +	else
> > +		mux->data.idle = mux->data.values[0];
> >  
> >  	for (i = 0; i < mux->data.n_gpios; i++) {
> >  		struct device *gpio_dev;
> > @@ -224,7 +225,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  		}
> >  
> >  		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
> > -					    initial_state & (1 << i));
> > +					    mux->data.idle & (1 << i));
> >  		if (ret) {
> >  			dev_err(&pdev->dev,
> >  				"Failed to set direction of GPIO %d to output\n",
> > 
> 
