Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65075C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448E321736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfK2Hp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:45:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52601 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfK2Hp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:45:27 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iaaxx-0003Vl-BI; Fri, 29 Nov 2019 08:45:25 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iaaxw-0003my-Fy; Fri, 29 Nov 2019 08:45:24 +0100
Date:   Fri, 29 Nov 2019 08:45:24 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        kernel@pengutronix.de, Adam.Thomson.Opensource@diasemi.com,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
Message-ID: <20191129074524.dipo37u6lv7vzfhc@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
 <20191127135932.7223-2-m.felsch@pengutronix.de>
 <CAMpxmJXzBphmW7SWD05wtLjSAR7VBzVAgnYJYd3Sd49Bp6AmgQ@mail.gmail.com>
 <20191128124942.4ddyi5eeclvxmqbg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191128124942.4ddyi5eeclvxmqbg@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 01:49:42PM +0100, Marco Felsch wrote:
> On 19-11-28 11:46, Bartosz Golaszewski wrote:
> > śr., 27 lis 2019 o 14:59 Marco Felsch <m.felsch@pengutronix.de> napisał(a):
> > >
> > > Sometimes consumers needs to know the gpio-chip local gpio number of a
> > > 'struct gpio_desc' for further configuration. This is often the case for
> > > mfd devices.
> > >
> > 
> > We already have this support. It's just a matter of exporting it, so
> > maybe adjust the commit message to not be confusing.
> 
> Therefore I mentioned the consumers.
> 
> > That being said: I'm not really a fan of this - the whole idea of gpio
> > descriptors was to make them opaque and their hardware offsets
> > irrelevant. :(
> 
> I know therefore I added a driver local helper but this wasn't the way
> Linus wanted to go..
> 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/gpio/gpiolib.c        |  6 ++++++
> > >  include/linux/gpio/consumer.h | 10 ++++++++++
> > >  2 files changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index 104ed299d5ea..7709648313fc 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -4377,6 +4377,12 @@ int gpiod_count(struct device *dev, const char *con_id)
> > >  }
> > >  EXPORT_SYMBOL_GPL(gpiod_count);
> > >
> > > +int gpiod_to_offset(struct gpio_desc *desc)
> > 
> > Maybe call it: gpiod_desc_to_offset()?
> 
> The function name is proposed by Linus too so Linus what's your
> oppinion?

INAL (I'm not a Linus) but I wonder what the 'd' in gpiod stands for.
Assuming it already meand "desc" I'd prefer gpiod_to_offset.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
