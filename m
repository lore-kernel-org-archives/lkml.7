Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3ABC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4562084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDCKKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:10:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41362 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:10:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so5913285lja.8;
        Wed, 03 Apr 2019 03:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrJy4uS4rsQbOKx4CXwOuMg+c4TQQHqn3vkGKoL5K70=;
        b=GKcjzTxNgw0oSC4cVXhxTSMzE/WBkcflIlVSWDKjKuhOBF2JH5nLU9oVTQolL4EpvO
         rNLAZrtmcnObv0sfnth4Zv6S17npILZzkVcMZLD8iaRxLbRDC2TVImKII3KFwWNfShOA
         RWcjjtscAGYG9Co4IfY3oAHjfBbvXf3NfofUWynSgKmW+Mpj2ojMU430+M8B8raIsxdZ
         KNU3ZaYCSNYn+0WGz/QWvgE9bkCnxAAtx8B0tKQPHEkoYIVrJ/Yu7ubsRCrGVfPAF7nI
         dfHha/pITo4a+NRbaKf2uSikp1kvDYi+wdr2hFBazSiaWhqrNM5C/d6PspM8KoHEUsA8
         2C8g==
X-Gm-Message-State: APjAAAWCNDgY+yOeIUKqoQWoPpSWDUXUEnbJnxEDnN+iewq8q36dYRZ8
        kJ3jZi+wC/bwJtKfb0OzV9A=
X-Google-Smtp-Source: APXvYqyb2MfClw3ejovmKMsLqNcM2g2l2BjjD/gWRtVOBbBpJAT/PjErbLXaXF69PoIHroRE8c9K6g==
X-Received: by 2002:a2e:5056:: with SMTP id v22mr42095140ljd.153.1554286207171;
        Wed, 03 Apr 2019 03:10:07 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t14sm3185471lji.33.2019.04.03.03.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 03:10:06 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:10:03 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190403101003.GC3493@localhost.localdomain>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403093015.GJ11301@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:30:15AM +0100, Lee Jones wrote:
> On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> 
> > Hello Lee,
> > 
> > Thanks for taking a look on this again =) I agree with most of the
> > comments and correct them at next version.
> > 
> > On Wed, Apr 03, 2019 at 08:31:52AM +0100, Lee Jones wrote:
> > > On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> > > 
> > > > ROHM BD70528MWV is an ultra-low quiescent current general
> > > > purpose single-chip power management IC for battery-powered
> > > > portable devices.
> > > > 
> > > > Add MFD core which enables chip access for following subdevices:
> > > > 	- regulators/LED drivers
> > > > 	- battery-charger
> > > > 	- gpios
> > > > 	- 32.768kHz clk
> > > > 	- RTC
> > > > 	- watchdog
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > + * Mapping of main IRQ register bits to sub irq register offsets so
> > > 
> > > "sub-IRQ"
> > > 
> > > > + * that we can access corect sub IRQ registers based on bits that
> > > 
> > > "sub IRQ" is also fine, but please standardise.
> > > 
> > > I do prefer "sub-IRQ" though.
> > 
> > I'll go with "sub-IRQ" then
> > 
> > > > +
> > > > +#define WD_CTRL_MAGIC1 0x55
> > > > +#define WD_CTRL_MAGIC2 0xAA
> > > > +/**
> > > > + * bd70528_wdt_set - arm or disarm watchdog timer
> > > > + *
> > > > + * @data:	device data for the PMIC instance we want to operate on
> > > > + * @enable:	new state of WDT. zero to disable, non zero to enable
> > > > + * @old_state:	previous state of WDT will be filled here
> > > > + *
> > > > + * Arm or disarm WDT on BD70528 PMIC. Expected to be called only by
> > > > + * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock must be taken
> > > > + * by calling bd70528_wdt_lock before calling bd70528_wdt_set.
> > > > + */
> > > > +int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state)
> > > 
> > > Why doesn't this reside in the watchdog driver?
> > 
> > If my memory serves me right we shortly discussed this already during v8
> > review ;) Cant blame you though as I have seen some of the mail traffic
> > going through your inbox :D
> > 
> > The motivation to have the functions exported from MFD is to not create
> > sirect dependency between RTC and WDT. There may be cases where we want
> > to leave either RTC or WDT out of compilation. MFD is always needed so
> > the dependency from MFD to RTC/WDT does not harm.
> > 
> > (Here's some discussion necromancy if you are interested in re-reading
> > how we did end up with this implementation:
> > https://lore.kernel.org/lkml/20190212091723.GZ20638@dell/)
> > 
> > I hope you are still Ok with having the WDT control functions in MFD.
> 
> OOI, why does the RTC need to control the WDT?

I thought I had a comment about this somewhere in code... O_o Must have
been in some development branch I had :/

Anyways, setting the RTC counter may cause watchdog to trigger. It is not
further explained why but I would guess watchdog uses RTC counter to check
if it should've been pinged already. So RTC needs to disable watch dog for
the duration of hwclock setting and enable it again after the new time is
set. I can add a comment about this to MFD driver if it helps :)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
