Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8FDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17406218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCPNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 09:45:24 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48633 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfCPNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 09:45:24 -0400
X-Originating-IP: 86.206.237.96
Received: from windsurf (lfbn-tou-1-411-96.w86-206.abo.wanadoo.fr [86.206.237.96])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 205B040006;
        Sat, 16 Mar 2019 13:45:19 +0000 (UTC)
Date:   Sat, 16 Mar 2019 14:45:19 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v2 3/5] gpio: use new gpio_set_config() helper in more
 places
Message-ID: <20190316144519.07805478@windsurf>
In-Reply-To: <20190316014352.GA6124@roeck-us.net>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
        <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
        <20190316014352.GA6124@roeck-us.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 15 Mar 2019 18:43:52 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index cf8a4402fef1..9762a836fec9 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2762,7 +2762,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
> >  	}
> >  
> >  	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
> > -	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
> > +	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);  
> 
> Are you sure this is correct ? This patch results in a number of tracebacks
> in mainline. Reverting it fixes the problem.
> 
> gpio_set_config() seems to pack config, but it is already packed above.
> That seems a bit suspicious.

I'll have a look. In the mean time, I'm fine with the patch being
reverted.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
