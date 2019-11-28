Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B23208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfK1Mtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:49:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57769 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfK1Mtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:49:50 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iaJEt-0001j4-6d; Thu, 28 Nov 2019 13:49:43 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iaJEs-00048Y-61; Thu, 28 Nov 2019 13:49:42 +0100
Date:   Thu, 28 Nov 2019 13:49:42 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Adam.Thomson.Opensource@diasemi.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
Message-ID: <20191128124942.4ddyi5eeclvxmqbg@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
 <20191127135932.7223-2-m.felsch@pengutronix.de>
 <CAMpxmJXzBphmW7SWD05wtLjSAR7VBzVAgnYJYd3Sd49Bp6AmgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJXzBphmW7SWD05wtLjSAR7VBzVAgnYJYd3Sd49Bp6AmgQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:45:17 up 13 days,  4:03, 23 users,  load average: 0.29, 0.10,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-28 11:46, Bartosz Golaszewski wrote:
> śr., 27 lis 2019 o 14:59 Marco Felsch <m.felsch@pengutronix.de> napisał(a):
> >
> > Sometimes consumers needs to know the gpio-chip local gpio number of a
> > 'struct gpio_desc' for further configuration. This is often the case for
> > mfd devices.
> >
> 
> We already have this support. It's just a matter of exporting it, so
> maybe adjust the commit message to not be confusing.

Therefore I mentioned the consumers.

> That being said: I'm not really a fan of this - the whole idea of gpio
> descriptors was to make them opaque and their hardware offsets
> irrelevant. :(

I know therefore I added a driver local helper but this wasn't the way
Linus wanted to go..

> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/gpio/gpiolib.c        |  6 ++++++
> >  include/linux/gpio/consumer.h | 10 ++++++++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 104ed299d5ea..7709648313fc 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -4377,6 +4377,12 @@ int gpiod_count(struct device *dev, const char *con_id)
> >  }
> >  EXPORT_SYMBOL_GPL(gpiod_count);
> >
> > +int gpiod_to_offset(struct gpio_desc *desc)
> 
> Maybe call it: gpiod_desc_to_offset()?

The function name is proposed by Linus too so Linus what's your
oppinion?

Regards,
  Marco

> > +{
> > +       return gpio_chip_hwgpio(desc);
> > +}
> > +EXPORT_SYMBOL_GPL(gpiod_to_offset);
> > +
> >  /**
> >   * gpiod_get - obtain a GPIO for a given GPIO function
> >   * @dev:       GPIO consumer, can be NULL for system-global GPIOs
> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> > index b70af921c614..e2178c3bf7fd 100644
> > --- a/include/linux/gpio/consumer.h
> > +++ b/include/linux/gpio/consumer.h
> > @@ -60,6 +60,9 @@ enum gpiod_flags {
> >  /* Return the number of GPIOs associated with a device / function */
> >  int gpiod_count(struct device *dev, const char *con_id);
> >
> > +/* Get the local chip offset from a global desc */
> > +int gpiod_to_offset(struct gpio_desc *desc);
> > +
> >  /* Acquire and dispose GPIOs */
> >  struct gpio_desc *__must_check gpiod_get(struct device *dev,
> >                                          const char *con_id,
> > @@ -189,6 +192,13 @@ static inline int gpiod_count(struct device *dev, const char *con_id)
> >         return 0;
> >  }
> >
> > +static inline int gpiod_to_offset(struct gpio_desc *desc)
> > +{
> > +       /* GPIO can never have been requested */
> > +       WARN_ON(desc);
> > +       return 0;
> > +}
> > +
> >  static inline struct gpio_desc *__must_check gpiod_get(struct device *dev,
> >                                                        const char *con_id,
> >                                                        enum gpiod_flags flags)
> > --
> > 2.20.1
> >
