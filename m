Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B027C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FD020833
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfK2LgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:36:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48341 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2LgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:36:07 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iaeZ7-0002le-Gy; Fri, 29 Nov 2019 12:36:01 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iaeZ6-00020W-Fx; Fri, 29 Nov 2019 12:36:00 +0100
Date:   Fri, 29 Nov 2019 12:36:00 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
Message-ID: <20191129113600.phbhqudrgtm2egpf@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
 <20191127135932.7223-2-m.felsch@pengutronix.de>
 <CACRpkdbG=XiQHNZa+zBqdyTDRhyXD5rLxbLjp3qqGbcQeTX26Q@mail.gmail.com>
 <20191129101542.drtcn44twcyzxqmm@pengutronix.de>
 <CACRpkda-mYbzxL9u-U9AHrFihtAQBaZajrQ-SN=WQH6=bg4swg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda-mYbzxL9u-U9AHrFihtAQBaZajrQ-SN=WQH6=bg4swg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:32:22 up 14 days,  2:50, 29 users,  load average: 0.01, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-29 11:19, Linus Walleij wrote:
> On Fri, Nov 29, 2019 at 11:15 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > > What about renaming gpio_chip_hwgpio() everywhere
> > > to gpiod_to_offet(), remove it from drivers/gpio/gpiolib.h
> > > and export it in <linux/gpio/consumer.h> instead?
> >
> > That's also possible but then we have to include the consumer.h header
> > within the gpiolib.c and this seems to be wrong. But since I'm not the
> > maintainer it is up to you and Bart. Both ways are possible,
> 
> What about following the pattern by the clk subsystem and
> create <linux/gpio/private.h> and put it there?
> 
> It should be an indication to people to not use these features
> lightly. We can decorate the header file with some warnings.

That's a good idea. So the following points should be done:
  - rename gpio_chip_hwgpio() to gpiod_to_offset() or gpiod_to_local_offset()
  - move the new helper to <linux/gpio/private.h>
  - add kerneldoc
  - add warnings into the header

Regards,
  Marco

> Yours,
> Linus Walleij
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
