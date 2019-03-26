Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85745C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485382075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INI2SKS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfCZUDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:03:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41380 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZUDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:03:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so3125107pfd.8;
        Tue, 26 Mar 2019 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UCNORsKkR6DTRgKLd7wxUec1B8EozazJHrB8dBBozXk=;
        b=INI2SKS5Ug5LVJQ8KFm07rzF9dlcNMr5LUWk4Ux0jjXAajQSoDDEfkFNyCTE3lgdZ/
         qWap56xLTVRncJFoFoURKuOg8CpD3zhvqPmLpKPCmNPxW6onfh+f+MyAxvK8cZE6Xc96
         Rvg0HExV5zN2LfpnOBQyMYYIWW1yLwYNW6qFLCogju+Ze3tJi3+XIC+cuRDEo9vshtcJ
         sPiwIeJDLvmU3j0cq66CXLrnM/dbWDuHGIfEiXdj2D9OoxkEWeum07kgEIW8vo6kgKxP
         iwEElHmB6KymUFI2gMEtceQVLCI4OTvqBTICfh7deAYR3OayEujj9xltPLxDfuadPmnD
         RdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UCNORsKkR6DTRgKLd7wxUec1B8EozazJHrB8dBBozXk=;
        b=TyZtIZMgi99DPfrttfXKu461c2HHyh8wesOP4JhbhmNFE99QBxD7gyvqU0UjeIrX/C
         xIRa5hYki7C5WkdLuMzkgxY61eRNy3FYhzmFQLlLi0+5/1/v9vQYIUYKptg1riYDS7oI
         ZSr7uY/s384nA7VbEBXMDT2U3F8F9m/zNg7CY3s67TT4Gynmr2jVZDjZ5HQlZb1/K8ZZ
         8pPH9lWYzKpS68Vr4ys6CHFQg6dX7vqpMBFSlCoHG75OIgt8LvSUSqG979pyejTNee9s
         pmeDGxXVXP7g6v7SU2TC9uTqdq4eBDEMiC2gMmoYz2+iug0bdPU/re1MjFlBwlv8QQIt
         Qdxg==
X-Gm-Message-State: APjAAAXPIkYEw7GI/BpMId1TpMAYTH/ZXn818rbJn2aywGn/y6mIATiD
        dbTOeCA7CSvPVhQ1O6Em5Zc=
X-Google-Smtp-Source: APXvYqw5PmxWbujer5FdunUKtwmfWmclJtMLM4JfJSAEMXxG9rziLjb3gTP9XtpnWP8oGtDyEA2MJA==
X-Received: by 2002:a63:2c55:: with SMTP id s82mr24420765pgs.356.1553630584528;
        Tue, 26 Mar 2019 13:03:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k124sm20080402pgc.65.2019.03.26.13.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 13:03:03 -0700 (PDT)
Date:   Tue, 26 Mar 2019 13:03:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v2 3/5] gpio: use new gpio_set_config() helper in more
 places
Message-ID: <20190326200302.GA15712@roeck-us.net>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
 <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
 <20190316014352.GA6124@roeck-us.net>
 <20190316144519.07805478@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316144519.07805478@windsurf>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 02:45:19PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 15 Mar 2019 18:43:52 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index cf8a4402fef1..9762a836fec9 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -2762,7 +2762,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
> > >  	}
> > >  
> > >  	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
> > > -	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
> > > +	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);  
> > 
> > Are you sure this is correct ? This patch results in a number of tracebacks
> > in mainline. Reverting it fixes the problem.
> > 
> > gpio_set_config() seems to pack config, but it is already packed above.
> > That seems a bit suspicious.
> 
> I'll have a look. In the mean time, I'm fine with the patch being
> reverted.
> 

The problem is still seen in the latest kernel as of last night, and
I did not see any further activities. Should I send a revert request ?

Guenter
