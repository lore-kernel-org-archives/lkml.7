Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55084C47409
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181312176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDOQqhZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfLQOZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:25:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38494 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfLQOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:25:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so3389511wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6kERw8dQIBACWsW0c+lQf/JA1vmIIx6c9Yg7JLLE81M=;
        b=nDOQqhZNRhoqSIT9ygYhf6sYksvjQo/V0MI0iG8xAI89/NE0iO63AgxOdrYKa917lh
         cV57WmnloRdU8ZjuMMbUdWOmp2MgBXI2WEQ5WqGnLOoJOFyKMPsabxDfUcaNKPAPeiM2
         zv4czVKjcJqiWovFGXwRRlP2dVy0h+1BS1p9/h4xdRTva3rVoO1B1OcPZ/XgmnA+sJ40
         vWKeXt+JEwXo0VccppBW2PHy+gJw6MXFYRlbIzyrMoKTbuZ7A7Y74SobzBvgiX6bUQpV
         WikCepIxqMQ9K/Ngfgj9jIUxHUgZNtMRIlArBYGinPF/qsIGu7SOJYhQd1ZXTxJwZQUR
         5tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6kERw8dQIBACWsW0c+lQf/JA1vmIIx6c9Yg7JLLE81M=;
        b=OB8FQpVNER9MhR27nOxkkS5FmfBlTc3ZUoilNJS6K+a+GJRvz8hvUzXiYPm4AhKNH3
         X7Cus6o/V3T8ebT7WRahsSysIagKSBsBEgabhV6H98aKEin0dUGrYMzwJ8h3C+CIlv2o
         eqdMU595RiceYc2/JNQjlWRjKgLolZ4Et271HoiFAX3EuIwR3KEUPCDGkyMHTpBC4G0C
         Gd7Ej2w0tiGtQrrJvZ3ERaokyPWnGj9iVQaszp2u2qU29QUL5EfUjiIVkP0OdxhzOJP0
         B1Tr5xww978Hg0iFCkXNC/cIt+rex3aG/aSsMvExHGquB2A7N1jFK9xF7NPOVty5qjxx
         fLyw==
X-Gm-Message-State: APjAAAX8TACompEWlX4NdlAFnS9o547PeVZSnCDju9eD9mkNhYNLhWRD
        +GWhTWzM1qqvE0JWxHpfZl/Qvg==
X-Google-Smtp-Source: APXvYqxwCwi38Wr5D9A/L2wvMeZPSaKLDoI2uWPVSQnU9lhUcxlxXv46EcbtmUS5uruundfigIgz8w==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr5654182wml.138.1576592738272;
        Tue, 17 Dec 2019 06:25:38 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id s65sm3189680wmf.48.2019.12.17.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:25:37 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:25:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v6 05/15] mfd: bd71828: Support ROHM BD71828 PMIC - core
Message-ID: <20191217142537.GN18955@dell>
References: <cover.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
 <252de5646fedfec7c575269843a47091fe199c79.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
 <20191216164641.GC18955@dell>
 <5593db6b3328c0a1a7069d839f5c777b4b3822b6.camel@fi.rohmeurope.com>
 <20191217135430.GM18955@dell>
 <20191217140810.GD3489463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217140810.GD3489463@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019, gregkh@linuxfoundation.org wrote:
> On Tue, Dec 17, 2019 at 01:54:30PM +0000, Lee Jones wrote:
> > On Tue, 17 Dec 2019, Vaittinen, Matti wrote:
> > > On Mon, 2019-12-16 at 16:46 +0000, Lee Jones wrote:
> > > > On Wed, 11 Dec 2019, Matti Vaittinen wrote:
> > > > 
> > > > > BD71828GW is a single-chip power management IC for battery-powered
> > > > > portable
> > > > > devices. The IC integrates 7 buck converters, 7 LDOs, and a 1500 mA
> > > > > single-cell linear charger. Also included is a Coulomb counter, a
> > > > > real-time
> > > > > clock (RTC), 3 GPO/regulator control pins, HALL input and a 32.768
> > > > > kHz
> > > > > clock gate.
> > > > > 
> > > > > Add MFD core driver providing interrupt controller facilities and
> > > > > i2c
> > > > > access to sub device drivers.
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > > ---
> > > > > 
> > > > > Changes since v5:
> > > > > - No changes
> > > > > 
> > > > >  drivers/mfd/Kconfig              |  15 ++
> > > > >  drivers/mfd/Makefile             |   2 +-
> > > > >  drivers/mfd/rohm-bd71828.c       | 319 +++++++++++++++++++++++
> > > > >  include/linux/mfd/rohm-bd71828.h | 425
> > > > > +++++++++++++++++++++++++++++++
> > > > >  include/linux/mfd/rohm-generic.h |   1 +
> > > > >  5 files changed, 761 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/mfd/rohm-bd71828.c
> > > > >  create mode 100644 include/linux/mfd/rohm-bd71828.h

[...]
> > 
> > If you have this in your header:
> > 
> >   GPL-2.0-only
> > 
> > Your MODULE tags should read:
> > 
> > MODULE_LICENSE("GPL v2");
> 
> Nope, as per module.h, which is quoted here, either:
> 	MODULE_LICENSE("GPL");
> or:
> 	MODULE_LICENSE("GPL v2");
> mean the exact same thing.

Interesting.  I always took a non-specified version to mean:

  "... and any other future version of the licence"

Educated, thanks!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
