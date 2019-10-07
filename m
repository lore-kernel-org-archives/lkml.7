Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E0C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436FD2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfJGI7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:59:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42885 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJGI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:59:21 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHOrL-0008Mt-OD; Mon, 07 Oct 2019 10:59:15 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHOrK-0005jI-SH; Mon, 07 Oct 2019 10:59:14 +0200
Date:   Mon, 7 Oct 2019 10:59:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] regulator: da9062: add voltage selection gpio support
Message-ID: <20191007085914.jwp6jehllmbiilye@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-4-m.felsch@pengutronix.de>
 <CACRpkdYAjj+EuF+iu4fKjt2Cviu8V+U66HnQThawwU58UGRUzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYAjj+EuF+iu4fKjt2Cviu8V+U66HnQThawwU58UGRUzQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:53:07 up 142 days, 15:11, 94 users,  load average: 0.14, 0.07,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-04 21:41, Linus Walleij wrote:
> On Tue, Sep 17, 2019 at 2:43 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > +       /*
> > +        * We only must ensure that the gpio device is probed before the
> > +        * regulator driver so no need to store the reference global. Luckily
> > +        * devm_* releases the gpio upon a unbound action.
> > +        */
> > +       gpi = devm_gpiod_get_from_of_node(cfg->dev, np, prop, 0, GPIOD_IN |
> > +                                         GPIOD_FLAGS_BIT_NONEXCLUSIVE, label);
> 
> Do you really need the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag here?
> I don't think so, but describe what usecase you have that warrants this
> being claimed twice. Normally that is just needed when you let the
> regulator core handle enablement of a regulator over GPIO, i.e.
> ena_gpiod in struct regulator_config.

This pin can be assigned to all regulators so it is shared across them
also it can be used as voltage-selection gpio by regulator and as
enable signal by an other regulator. I mentioned that within the
dt-bindings and also mentioned that the config has to be the same.

> > +       /* We need the local number */
> > +       nr = da9062_gpio_get_hwgpio(gpi);
> 
> If you really need this we should add a public API to gpiolib and not
> create custom APIs.
> 
> Just make a patch adding
> 
> int gpiod_to_offset(struct gpio_desc *d);
> 
> to the public gpiolib API in include/linux/gpio/consumer.h
> 
> and add the code in gpiolib.c to do this trick.

Okay, I will add it.

Thanks for the review.

Regards,
  Marco

> Yours,
> Linus Walleij
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
