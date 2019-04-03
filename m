Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB4CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E76A2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arC2Bdv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDCL0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:26:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41185 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:26:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so6198197plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0B5846Qj48irt1Bqb+wtKlBUuvrN2uhhkGpMhKv1ajc=;
        b=arC2Bdv3ecOwLXWncAWAMI+rAbMY/c9t2P2HMeyzFpWKWMglGp5i8PVCn7cgdNWubw
         r2pjO6PJny0CXo3p/v/Xhx3wsQ6IotgWtdTLT08ey05MQZgTdYyFNBWaOezT2P5rBkx8
         iAUCB4YgJuL+qGAT2KeuyNp/uZpMoXOjSYv/dEICAaAYqx+V94pIU9VwaIUz5HfUwRRR
         nMwTcQAsLvHeLnBkDj84zcephzy0l0MAC3LjTZ0agbN89exavaC2vXMAF7EtPdPhGXa2
         aNMSBrljC+adAJ9ABsCsG1hx/QEQZx36m3Ho0IBSDi823DJkbgFdZfpkJNY9sdm5GpUS
         WhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0B5846Qj48irt1Bqb+wtKlBUuvrN2uhhkGpMhKv1ajc=;
        b=sgn3afNXxgKoqOWpPLThG3BQqb1APTSB588YosKS/Ji/OXuK1+3gYu/0vv3/Il/jHu
         8Q85fbDiVwowe5b1o3Buaa8ftYZw8Kkj160dDauYUy3GuDiVNdbaILfZy5EZMLwOIrOS
         SLeE7mxko9dpO4WsIE5aKI+e4m966x47vMI70qZVG/Rctyo+ohiCo2yjZCPOXyNYbdu4
         nLXf1Eq5WmsSVnYlOt3jV9xxYGAtafl+5eID5T9MggOYs41nt8i/mj0QUlqp+b7nT3ua
         CtjGRvko+ujyW9XIOpllyogQhvG7gDbr2iIx9tZ7+Q1nO0cojek0ElFm6NSXd45WNS0G
         5g5A==
X-Gm-Message-State: APjAAAXAw2byfC+K1wMxhnFQ9lkKob/NI/cEF4XPEeIc1nWrhYSOiIhr
        DaygXB0ulcx5nOBevlaTWphNHQ==
X-Google-Smtp-Source: APXvYqwbGKDsbAGKaKk33ooPdr+A6/ssJ3ZShnRgfwyosb8w1MssA6oLeadkL3bzTfQwyEUIIr9h5g==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr77449907pld.25.1554290769884;
        Wed, 03 Apr 2019 04:26:09 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id n26sm47326286pfi.165.2019.04.03.04.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 04:26:08 -0700 (PDT)
Date:   Wed, 3 Apr 2019 12:25:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
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
Message-ID: <20190403112559.GP11301@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403101003.GC3493@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Matti Vaittinen wrote:

> On Wed, Apr 03, 2019 at 10:30:15AM +0100, Lee Jones wrote:
> > On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> > 
> > > Hello Lee,
> > > 
> > > Thanks for taking a look on this again =) I agree with most of the
> > > comments and correct them at next version.
> > > 
> > > On Wed, Apr 03, 2019 at 08:31:52AM +0100, Lee Jones wrote:
> > > > On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> > > > 
> > > > > ROHM BD70528MWV is an ultra-low quiescent current general
> > > > > purpose single-chip power management IC for battery-powered
> > > > > portable devices.
> > > > > 
> > > > > Add MFD core which enables chip access for following subdevices:
> > > > > 	- regulators/LED drivers
> > > > > 	- battery-charger
> > > > > 	- gpios
> > > > > 	- 32.768kHz clk
> > > > > 	- RTC
> > > > > 	- watchdog
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > > + * Mapping of main IRQ register bits to sub irq register offsets so
> > > > 
> > > > "sub-IRQ"
> > > > 
> > > > > + * that we can access corect sub IRQ registers based on bits that
> > > > 
> > > > "sub IRQ" is also fine, but please standardise.
> > > > 
> > > > I do prefer "sub-IRQ" though.
> > > 
> > > I'll go with "sub-IRQ" then
> > > 
> > > > > +
> > > > > +#define WD_CTRL_MAGIC1 0x55
> > > > > +#define WD_CTRL_MAGIC2 0xAA
> > > > > +/**
> > > > > + * bd70528_wdt_set - arm or disarm watchdog timer
> > > > > + *
> > > > > + * @data:	device data for the PMIC instance we want to operate on
> > > > > + * @enable:	new state of WDT. zero to disable, non zero to enable
> > > > > + * @old_state:	previous state of WDT will be filled here
> > > > > + *
> > > > > + * Arm or disarm WDT on BD70528 PMIC. Expected to be called only by
> > > > > + * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock must be taken
> > > > > + * by calling bd70528_wdt_lock before calling bd70528_wdt_set.
> > > > > + */
> > > > > +int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state)
> > > > 
> > > > Why doesn't this reside in the watchdog driver?
> > > 
> > > If my memory serves me right we shortly discussed this already during v8
> > > review ;) Cant blame you though as I have seen some of the mail traffic
> > > going through your inbox :D
> > > 
> > > The motivation to have the functions exported from MFD is to not create
> > > sirect dependency between RTC and WDT. There may be cases where we want
> > > to leave either RTC or WDT out of compilation. MFD is always needed so
> > > the dependency from MFD to RTC/WDT does not harm.
> > > 
> > > (Here's some discussion necromancy if you are interested in re-reading
> > > how we did end up with this implementation:
> > > https://lore.kernel.org/lkml/20190212091723.GZ20638@dell/)
> > > 
> > > I hope you are still Ok with having the WDT control functions in MFD.
> > 
> > OOI, why does the RTC need to control the WDT?
> 
> I thought I had a comment about this somewhere in code... O_o Must have
> been in some development branch I had :/
> 
> Anyways, setting the RTC counter may cause watchdog to trigger. It is not
> further explained why but I would guess watchdog uses RTC counter to check
> if it should've been pinged already. So RTC needs to disable watch dog for
> the duration of hwclock setting and enable it again after the new time is
> set. I can add a comment about this to MFD driver if it helps :)

How does the user select between using the RTC and the WDT?

Or are the generally both enabled at the same time?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
